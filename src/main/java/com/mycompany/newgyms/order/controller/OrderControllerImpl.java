package com.mycompany.newgyms.order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.order.service.OrderService;
import com.mycompany.newgyms.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl implements OrderController {
	
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;

	@Autowired
	private MemberVO memberVO;
	
	@Override
	@RequestMapping(value="/nonMemberOrder.do", method=RequestMethod.GET)
	public ModelAndView nonMemberOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("/order/nonMemberOrder");
        return mav;
	}
	
	@RequestMapping(value="/orderEachProduct.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachProduct(@ModelAttribute("orderVO") OrderVO orderVO, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		request.setCharacterEncoding("utf-8");
		
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		memberVO=(MemberVO)session.getAttribute("memberInfo");

		
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			String member_id = memberVO.getMember_id();
			
			orderVO.setMember_id(member_id);
			
			//보유한 적립금(주문/결제 페이지)
			String orderPoint = orderService.orderPoint(member_id);
			mav.addObject("orderPoint", orderPoint);
			
		
		} else if (isLogOn == null || isLogOn == false || memberVO == null) {
			
			String member_id = session.getId(); 
			orderVO.setMember_id(member_id);

		}
		
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO);
		
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}
	
	
	@RequestMapping(value="/orderCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView orderCartProduct(HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		
		String[] cart_id_list = request.getParameterValues("check_one");
		Map<String, Object> orderMap = new HashMap<String, Object>();
		orderMap.put("cart_id_list", cart_id_list);
		
		List<OrderVO> myOrderList = orderService.selectOrderProductList(orderMap);

		//로그인 정보 가져오기
		HttpSession session = request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		
		//로그인한 경우
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			String member_id = memberVO.getMember_id(); //로그인한 member_id
			orderVO.setMember_id(member_id);
			
			//보유한 적립금(주문/결제 페이지)
			String orderPoint = orderService.orderPoint(member_id);
			mav.addObject("orderPoint", orderPoint);

			
			//로그인 하지 않은 경우
		} else if (isLogOn == null || isLogOn == false || memberVO == null) {
			
			String member_id = session.getId(); //session Id를 member_id에 저장
			orderVO.setMember_id(member_id);
			
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		/*
		 * mav.addObject("myOrderList", myOrderList); mav.addObject("orderer",
		 * memberVO);
		 */		return mav;

	}	
	
	@RequestMapping(value="/payToOrderProduct.do", method = RequestMethod.POST)
	public ModelAndView payToOrderProduct(@RequestParam Map<String, String> orderMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		String message = null;
		
		orderMap.put("order_state", "결제완료");
		List<OrderVO> myOrderList = (List<OrderVO>)session.getAttribute("myOrderList");
		
		for (int i=0; i<myOrderList.size(); i++) {
			OrderVO orderVO = (OrderVO)myOrderList.get(i);
			orderVO.setMember_id(orderMap.get("member_id"));
			orderVO.setCenter_name(orderMap.get("center_name"));
			orderVO.setProduct_id(Integer.parseInt(orderMap.get("product_id")));
			orderVO.setProduct_main_image(orderMap.get("product_main_image"));
			orderVO.setProduct_name(orderMap.get("product_name"));
			orderVO.setProduct_option_name(orderMap.get("product_option_name"));
			orderVO.setProduct_option_price(orderMap.get("product_option_price"));
			orderVO.setProduct_price(Integer.parseInt(orderMap.get("product_price")));
			orderVO.setProduct_sales_price(Integer.parseInt(orderMap.get("product_sales_price")));
			orderVO.setOrderer_name(orderMap.get("orderer_name"));
			orderVO.setOrderer_hp1(orderMap.get("orderer_hp1"));
			orderVO.setOrderer_hp2(orderMap.get("orderer_hp2"));
			orderVO.setOrderer_hp3(orderMap.get("orderer_hp3"));
			orderVO.setReceiver_name(orderMap.get("receiver_name"));
			orderVO.setReceiver_hp1(orderMap.get("receiver_hp1"));
			orderVO.setReceiver_hp2(orderMap.get("receiver_hp2"));
			orderVO.setReceiver_hp3(orderMap.get("receiver_hp3"));
			orderVO.setPay_method(orderMap.get("pay_method"));
			orderVO.setCard_com_name(orderMap.get("card_com_name"));
			orderVO.setCard_pay_month(orderMap.get("card_pay_month"));
			orderVO.setOrder_state(orderMap.get("order_state"));
			myOrderList.set(i, orderVO);
		}
		int order_id = orderService.addNewOrder(myOrderList);
		session.setAttribute("order_id", order_id);
		
		mav.setViewName("redirect:/mypage/myOrderDetail.do?order_id="+order_id);
		
		return mav;
	}
}