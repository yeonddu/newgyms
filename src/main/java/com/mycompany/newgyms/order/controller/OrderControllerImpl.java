package com.mycompany.newgyms.order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.order.service.OrderService;
import com.mycompany.newgyms.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl implements OrderController {
	
	@Override
	@RequestMapping(value="/nonMemberOrder.do", method=RequestMethod.GET)
	public ModelAndView nonMemberOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("/order/nonMemberOrder");
        
        return mav;
	}

}