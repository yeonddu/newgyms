package com.mycompany.newgyms.owner.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface OwnerProductController {
	public ModelAndView ownerProductList(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response) throws Exception;

}