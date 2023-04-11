package com.mycompany.newgyms.admin.member.controller;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
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

import com.mycompany.newgyms.admin.member.service.AdminMemberService;
import com.mycompany.newgyms.common.base.BaseController;
import com.mycompany.newgyms.member.vo.MemberVO;

@Controller("adminMemberController")
@RequestMapping(value = "/admin/member")
public class AdminMemberControllerImpl extends BaseController implements AdminMemberController {
	@Autowired
	private AdminMemberService adminMemberService;
	@Autowired
	private MemberVO memberVO;
	
	@RequestMapping(value="/adminMemberList.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminMemberList(@RequestParam Map<String, String> dateMap, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String chapter = dateMap.get("chapter");
		String pageNum = dateMap.get("pageNum");
		String beginDate=null,endDate=null;
		
		String [] tempDate = calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		
		
		HashMap<String,Object> condMap=new HashMap<String,Object>();
		if(chapter== null) {
			chapter = "1";
		}
		condMap.put("chapter",chapter);
		if(pageNum== null) {
			pageNum = "1";
		}
		condMap.put("pageNum",pageNum);
		condMap.put("beginDate",beginDate);
		condMap.put("endDate", endDate);
		
		ArrayList<MemberVO> adminMemberList = adminMemberService.memberList(condMap);
		mav.addObject("adminMemberList", adminMemberList);
		
		String beginDate1[]=beginDate.split("-");
		String endDate2[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate2[0]);
		mav.addObject("endMonth",endDate2[1]);
		mav.addObject("endDay",endDate2[2]);
		
		mav.addObject("chapter", chapter);
		mav.addObject("pageNum", pageNum);
		return mav;
		
	}
	
	@Override
	@RequestMapping(value="/memberDetail.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView adminMemberDetail(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName = (String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		String member_id = request.getParameter("member_id");
		MemberVO adminMemberDetail = adminMemberService.memberDetail(member_id);
		mav.addObject("adminMemberDetail", adminMemberDetail);
		return mav;
	}
	
	@Override
	@RequestMapping(value="/modifyMemberInfo.do" ,method={RequestMethod.POST,RequestMethod.GET})
	public ModelAndView modifyMemberInfo(@RequestParam Map<String, String> modifyMap, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();

		adminMemberService.modifyMemberInfo(modifyMap);

		/*
		PrintWriter out = response.getWriter();
		out.println("<script>alert('회원정보 수정이 완료되었습니다. :)');</script>");
		out.flush();
		*/
		mav.setViewName("redirect:/admin/member/adminMemberList.do");
		return mav;
	}
	
	// 회원 탈퇴 시키기
	@Override
	@RequestMapping(value="/deleteMember.do" ,method={RequestMethod.POST})
	public ModelAndView deleteMember(@RequestParam ("member_id") String member_id, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> modifyMap = new HashMap<String, Object>();
		modifyMap.put("member_id", member_id);
		modifyMap.put("del_yn", "Y");
		adminMemberService.memberState(modifyMap);
		
		mav.setViewName("redirect:/admin/member/adminMemberList.do");
		return mav;
	}
	
	// 회원 복구 시키기
	@Override
	@RequestMapping(value="/rollbackMember.do" ,method={RequestMethod.POST})
	public ModelAndView rollbackMember(@RequestParam ("member_id") String member_id, HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> modifyMap = new HashMap<String, Object>();
		modifyMap.put("member_id", member_id);
		modifyMap.put("del_yn", "N");
		adminMemberService.memberState(modifyMap);
		
		mav.setViewName("redirect:/admin/member/adminMemberList.do");
		return mav;
	}
}
