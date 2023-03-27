package com.mycompany.newgyms.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;

public interface OrderController {
	public ModelAndView nonMemberOrder(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
