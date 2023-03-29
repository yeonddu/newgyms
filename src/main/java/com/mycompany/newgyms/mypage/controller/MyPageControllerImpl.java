package com.mycompany.newgyms.mypage.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.service.MyPageService;
import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Controller("myPageController")
@RequestMapping(value="/mypage")
public class MyPageControllerImpl implements MyPageController {
	@Autowired
	private MyPageService myPageService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private MyPageVO mypageVO;
	
	@Override
	@RequestMapping(value="/myOrderList.do", method = RequestMethod.GET)
	public ModelAndView myOrderList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// 조건 검색 결과를 위한 변수(조건) 받음
		String member_id = request.getParameter("member_id");
		String chapter = request.getParameter("chapter");
		String order_state = request.getParameter("order_state");
		String firstDate = request.getParameter("firstDate"); if (firstDate == "") firstDate = "1900-01-01";
		String secondDate = request.getParameter("secondDate"); if (secondDate == "") secondDate = "2100-01-01";
		String text_box = request.getParameter("text_box");
		Map<String, Object> condMap = new HashMap<String, Object>();
		condMap.put("member_id", member_id);
		condMap.put("chapter", chapter);
		condMap.put("order_state", order_state);
		condMap.put("firstDate", firstDate);
		condMap.put("secondDate", secondDate);
		condMap.put("text_box", text_box);
		String maxnum = myPageService.maxNumSelect(condMap);
		condMap.put("maxnum", maxnum);
		
		List<OrderVO> myOrderList = myPageService.listMyOrders(condMap);
		// 조건 검색에 따른 결과 입력 
		mav.addObject("member_id", member_id);
		mav.addObject("chapter", chapter);
		mav.addObject("maxnum", maxnum);
		mav.addObject("order_state", order_state);
		mav.addObject("firstDate", firstDate);
		mav.addObject("secondDate", secondDate);
		mav.addObject("text_box", text_box);
		mav.addObject("myOrderList", myOrderList);
		
		mav.setViewName("/mypage/myOrderList");
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myOrderDetail.do", method = RequestMethod.GET)
	public ModelAndView myOrderDetail(@RequestParam("order_id") int order_id, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println(order_id);

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		
		List<OrderVO> myOrderDetail = myPageService.myOrderDetail(order_id);
		
		mav.addObject("member", member);
		mav.addObject("myOrderDetail", myOrderDetail);

		return mav;
	}
	
	@Override
	@RequestMapping(value="/myOrderCancel.do", method = RequestMethod.POST)
	public ModelAndView myOrderCancel(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		
		// 페이지에서 받아온 취소할 주문번호 목록을 배열에 담음
		String[] list = request.getParameterValues("cancel");
		
		// 취소한 주문번호 list를 담을 맵 구조 생성
		Map<String, Object> orderMap = new HashMap<String, Object>();
		orderMap.put("list", list);

		System.out.println(orderMap);
		
		List<OrderVO> myOrderDetail = myPageService.myOrderCancel(orderMap);
		System.out.println(myOrderDetail.size());
		
		mav.addObject("member", member);
		mav.addObject("myOrderDetail", myOrderDetail);
		mav.setViewName("/mypage/myOrderCancel");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/mypage/myOrderRefund.do", method = RequestMethod.POST)
	public ResponseEntity myOrderRefund(@ModelAttribute("mypageVO") MyPageVO mypageVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		// 임시값
		mypageVO.setOrder_state("결제취소");
		mypageVO.setOrder_seq_num(1);
		mypageVO.setRefund_price(100000);
		
		try {
			myPageService.myOrderRefund(mypageVO);
			message = "<script>";
			message += " alert('환불 신청이 완료되었습니다. :)');";
			message += " location.href='" + request.getContextPath() + "/mypage/myOrderList.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath() + "/member/myOrderCancel.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);

		return resEntity;
	}
	
	@Override
	@RequestMapping(value="/myPageModify.do", method = RequestMethod.GET)
	public ModelAndView myPageInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/myPageModify");
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/myDetailInfo.do", method = RequestMethod.POST)
	public ModelAndView myDetailInfo(@RequestParam Map<String, String> mypageMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		memberVO = myPageService.myPageDetail(mypageMap);
		
		if (memberVO != null && memberVO.getMember_id() != null) {
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("memberInfo", memberVO);
			mav.setViewName("/mypage/myDetailInfo");

		} else {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호가 올바르지 않습니다.');</script>");
			out.flush();
			mav.setViewName("/mypage/myPageModify");
		}
				
		return mav;
	}
	
	@Override
	@RequestMapping(value="modifyMyInfo.do", method = RequestMethod.POST)
	public ModelAndView modifyMyInfo(@RequestParam Map<String, String> modifyMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();

		memberVO = myPageService.modifyMyInfo(modifyMap);
		System.out.println(memberVO);
		
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		session.setAttribute("memberInfo", memberVO);
		out.println("<script>alert('회원정보 수정이 완료되었습니다. :)');</script>");
		out.flush();
		
		mav.setViewName("/mypage/myPageModify");
		
		return mav;
	}
	
	@Override
	@RequestMapping(value="/deleteMemberForm.do", method = RequestMethod.POST)
	public ModelAndView deleteMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("회원탈퇴 페이지로 이동합니다.");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/deleteMemberForm");
		return mav;
	}
	
	@Override
	@RequestMapping(value="/deleteMember.do" ,method = RequestMethod.POST)
	public ModelAndView deleteMember(@RequestParam Map<String, String> deleteMap, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		System.out.println("회원 탈퇴를 진행합니다.");
		ModelAndView mav = new ModelAndView();
		myPageService.deleteMember(deleteMap);
		
		mav.setViewName("redirect:/member/logout.do");
		return mav;
	}

}
