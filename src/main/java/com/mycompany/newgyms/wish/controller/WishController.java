package com.mycompany.newgyms.wish.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface WishController {
	public void addWishList(@RequestParam("product_id") String product_id, HttpServletRequest request, HttpServletResponse response) throws Exception;
}
