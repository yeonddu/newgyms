package com.mycompany.newgyms.mypage.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.service.MyPageService;
import com.mycompany.newgyms.mypage.vo.PointVO;
import com.mycompany.newgyms.mypage.vo.RefundVO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Controller("myPageController")
@RequestMapping(value = "/mypage")
public class MyPageControllerImpl implements MyPageController {
	@Autowired
	private MyPageService myPageService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private OrderVO orderVO;
	@Autowired
	private RefundVO refundVO;

	// 결제내역 조회
	@Override
	@RequestMapping(value = "/myOrderList.do", method = RequestMethod.GET)
	public ModelAndView myOrderList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();

		String member_id = request.getParameter("member_id");
		String chapter = request.getParameter("chapter");
		/*
		 * String order_state = request.getParameter("order_state"); String firstDate =
		 * request.getParameter("firstDate"); if (firstDate == "") firstDate =
		 * "1900-01-01"; String secondDate = request.getParameter("secondDate"); if
		 * (secondDate == "") secondDate = "2100-01-01"; String text_box =
		 * request.getParameter("text_box");
		 */
		Map<String, Object> condMap = new HashMap<String, Object>();
		condMap.put("member_id", member_id);
		condMap.put("chapter", chapter);
		/*
		 * condMap.put("order_state", order_state); condMap.put("firstDate", firstDate);
		 * condMap.put("secondDate", secondDate); condMap.put("text_box", text_box);
		 */
		String maxnum = myPageService.maxNumSelect(condMap);
		List<OrderVO> orderMemberList = myPageService.orderMemberList(condMap);
		condMap.put("maxnum", maxnum);

		List<OrderVO> myOrderList = myPageService.listMyOrders(condMap);
		List<OrderVO> orderMember = myPageService.orderMember(condMap);
		int count = orderMember.size();

		mav.addObject("count", count);
		mav.addObject("member_id", member_id);
		mav.addObject("chapter", chapter);
		mav.addObject("maxnum", maxnum);
		mav.addObject("orderMemberList", orderMemberList);

		/*
		 * mav.addObject("order_state", order_state); mav.addObject("firstDate",
		 * firstDate); mav.addObject("secondDate", secondDate);
		 * mav.addObject("text_box", text_box);
		 */

		mav.addObject("myOrderList", myOrderList);
		mav.addObject("orderMember", orderMember);
		mav.setViewName("/mypage/myOrderList");

		return mav;
	}

	// 결제내역 상세 조회
	@Override
	@RequestMapping(value = "/myOrderDetail.do", method = RequestMethod.GET)
	public ModelAndView myOrderDetail(@RequestParam("order_id") int order_id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println(order_id);

		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberInfo");

		List<OrderVO> myOrderDetail = myPageService.myOrderDetail(order_id);

		mav.addObject("member", member);
		mav.addObject("myOrderDetail", myOrderDetail);

		return mav;
	}

	// 환불하기 페이지로 이동
	@Override
	@RequestMapping(value = "/myOrderCancel.do", method = RequestMethod.POST)
	public ModelAndView myOrderCancel(@RequestParam("total_price") int total_price, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO member = (MemberVO) session.getAttribute("memberInfo");

		// 취소할 상품들의 개별 주문번호를 받아와 리스트에 담음
		String[] list = request.getParameterValues("cancel");

		Map<String, Object> orderMap = new HashMap<String, Object>();
		orderMap.put("list", list);

		System.out.println(orderMap);

		List<OrderVO> myOrderDetail = myPageService.myOrderCancel(orderMap);
		System.out.println(myOrderDetail.size());

		request.setAttribute("total_price", total_price);
		mav.addObject("member", member);
		mav.addObject("myOrderDetail", myOrderDetail);
		mav.setViewName("/mypage/myOrderCancel");
		return mav;
	}

	// 환불 신청
	@Override
	@RequestMapping(value = "/myOrderRefund.do", method = RequestMethod.POST)
	public ModelAndView myOrderRefund(@RequestParam Map<String, Object> refundMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();

		// 취소할 상품들의 개별 주문번호를 받아와 리스트에 담음
		String[] list = request.getParameterValues("cancel");
		String order_id = request.getParameter("order_id");

		// 환불 신청한 상품의 개수만큼 반복
		for (int i = 0; i < list.length; i++) {
			refundMap.put("order_state", "결제취소");
			refundMap.put("order_seq_num", list[i]);
			myPageService.myOrderRefund(refundMap);
		}

		mav.setViewName("redirect:/mypage/myOrderDetail.do?order_id=" + order_id);

		return mav;
	}

	// 회원정보 조회 본인확인
	@Override
	@RequestMapping(value = "/myPageModify.do", method = RequestMethod.GET)
	public ModelAndView myPageInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/myPageModify");

		return mav;
	}

	// 회원정보 수정페이지 이동
	@Override
	@RequestMapping(value = "/myDetailInfo.do", method = RequestMethod.POST)
	public ModelAndView myDetailInfo(@RequestParam Map<String, String> mypageMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
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

	// 회원정보 수정
	@Override
	@RequestMapping(value = "modifyMyInfo.do", method = RequestMethod.POST)
	public ModelAndView modifyMyInfo(@RequestParam Map<String, String> modifyMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
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

	// 회원탈퇴 페이지 이동
	@Override
	@RequestMapping(value = "/deleteMemberForm.do", method = RequestMethod.POST)
	public ModelAndView deleteMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("회원탈퇴 페이지로 이동합니다.");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/mypage/deleteMemberForm");
		return mav;
	}

	// 회원탈퇴 진행
	@Override
	@RequestMapping(value = "/deleteMember.do", method = RequestMethod.POST)
	public ModelAndView deleteMember(@RequestParam Map<String, String> deleteMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("회원탈퇴를 진행합니다.");
		ModelAndView mav = new ModelAndView();
		myPageService.deleteMember(deleteMap);

		mav.setViewName("redirect:/member/logout.do");
		return mav;
	}

	// 적립금 조회
	@Override
	@RequestMapping(value = "/myStackList.do", method = RequestMethod.GET)
	public ModelAndView myStackList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String member_id = request.getParameter("member_id");
		String chapter = request.getParameter("chapter");
		Map<String, Object> condMap = new HashMap<String, Object>();
		condMap.put("member_id", member_id);
		condMap.put("chapter", chapter);
		String maxnum = myPageService.maxStack(condMap);
		condMap.put("maxnum", maxnum);
		List<PointVO> myStackList = myPageService.myStackList(condMap);
		String nowPoint = myPageService.nowPoint(member_id);

		mav.addObject("member_id", member_id);
		mav.addObject("chapter", chapter);
		mav.addObject("maxnum", maxnum);
		mav.addObject("nowPoint", nowPoint);
		mav.addObject("myStackList", myStackList);
		mav.setViewName("/mypage/myStackList");
		return mav;
	}

}
