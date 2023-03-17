package com.mycompany.newgyms.cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	/* 
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,@RequestParam("cart_option") String cart_option,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public  @ResponseBody String modifyCartQty(@RequestParam("product_id") int product_id,@RequestParam("order_option") int cart_option,
			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	 */

}
