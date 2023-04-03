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
	private MemberVO memberVO;

	@Autowired
	private OrderVO orderVO;
	
	@Override
	@RequestMapping(value="/nonMemberOrder.do", method=RequestMethod.GET)
	public ModelAndView nonMemberOrder(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
        mav.setViewName("/order/nonMemberOrder");
        return mav;
	}
	
	@RequestMapping(value="/orderEachProduct.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachProduct(@ModelAttribute("orderVO") OrderVO orderVO, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		//String action=(String)session.getAttribute("action");
		
		
		//로그인한 경우
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			String member_id=memberVO.getMember_id();
			//String member_name=memberVO.getMember_name();
			//String member_hp1 = memberVO.getHp1();
			//String member_hp2 = memberVO.getHp2();
			//String member_hp3 = memberVO.getHp3();
			
			orderVO.setMember_id(member_id);
			
//			session.setAttribute("orderInfo", orderVO);
//			session.setAttribute("action", "/order/orderEachGoods.do");
//			return new ModelAndView("redirect:/member/loginForm.do");
			
		//로그인 하지 않은 경우
		} else if (isLogOn == null || isLogOn == false || memberVO == null) {
			
			String member_id = session.getId(); //session Id를 member_id에 저장
			orderVO.setMember_id(member_id);

		}
		
//		orderVO=(OrderVO)session.getAttribute("orderInfo");
//		session.removeAttribute("action");
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO);

		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}
	
	
	@RequestMapping(value="/orderCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView orderCartProduct( @RequestParam(value="cart_id[]") String[] cart_id_list,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println("dd"+cart_id_list);
		
		Map<String, Object> orderMap = new HashMap<String, Object>();
		orderMap.put("cart_id_list", cart_id_list);

		
		//주문상품 정보 가져오기
		List<OrderVO> myOrderList = orderService.selectOrderProductList(orderMap);
	        
		//로그인 정보 가져오기
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		
		//로그인한 경우
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			String member_id=memberVO.getMember_id(); //로그인한 member_id
			orderVO.setMember_id(member_id);
			
		//로그인 하지 않은 경우
		} else if (isLogOn == null || isLogOn == false || memberVO == null) {
			
			String member_id = session.getId(); //session Id를 member_id에 저장
			orderVO.setMember_id(member_id);
			
		}

		
//		Map cartMap=(Map)session.getAttribute("cartMap");
//		List<ProductVO> myProductList=(List<ProductVO>)cartMap.get("myProductList");
		
	/*
		for(int i=0; i<cart_id_list.length;i++){
			String cart_id = cart_id_list[0];
			
			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoods_id();
				if(goods_id==Integer.parseInt(cart_goods[0])) {
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoods_title();
					int goods_sales_price=goodsVO.getGoods_sales_price();
					String goods_fileName=goodsVO.getGoods_fileName();
					_orderVO.setGoods_id(goods_id);
					_orderVO.setGoods_title(goods_title);
					_orderVO.setGoods_sales_price(goods_sales_price);
					_orderVO.setGoods_fileName(goods_fileName);
					_orderVO.setOrder_goods_qty(Integer.parseInt(cart_goods[1]));
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
	 * */	
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}	
}