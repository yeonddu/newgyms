package com.mycompany.newgyms.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.vo.MyPageVO;

public interface MyPageController {
	public ModelAndView myOrderList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView myOrderDetail(@RequestParam("order_id") int order_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView myOrderCancel(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity myOrderRefund(@ModelAttribute("mypageVO") MyPageVO mypageVO, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView myPageInfo(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView myDetailInfo(@RequestParam Map<String, String> mypageMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modifyMyInfo(@RequestParam Map<String, String> modifyMap, HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteMemberForm(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView deleteMember(@RequestParam Map<String, String> deleteMap, HttpServletRequest request, HttpServletResponse response)  throws Exception;
}