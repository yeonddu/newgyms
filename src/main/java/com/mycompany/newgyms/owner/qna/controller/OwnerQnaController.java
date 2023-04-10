package com.mycompany.newgyms.owner.qna.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface OwnerQnaController {
	public ModelAndView ownerQnaList(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView modifyAnswer(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ResponseEntity removeAnswer(@RequestParam("qna_no") int qna_no, @RequestParam("qna_parent_no") int qna_parent_no, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
