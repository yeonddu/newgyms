package com.mycompany.newgyms.owner.event.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface OwnerEventController {
	// 이벤트 목록
	public ModelAndView ownerEventList(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 이벤트 삭제
	public ResponseEntity removeEvent(@RequestParam("event_no") int event_no, HttpServletRequest request, HttpServletResponse response) throws Exception;

}