package com.mycompany.newgyms.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.order.vo.OrderVO;

public interface OrderController {
	public ModelAndView nonMemberOrder(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView orderEachProduct(@ModelAttribute("orderVO") OrderVO orderVO, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView orderCartProduct( @RequestParam(value="cart_id[]") String[] cart_id_list,
            HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
