package com.mycompany.newgyms.cart.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.cart.service.CartService;
import com.mycompany.newgyms.cart.vo.CartVO;
import com.mycompany.newgyms.common.base.BaseController;
import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.service.ProductService;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{

	@Autowired
	private ProductService productService;
	@Autowired
	private CartService cartService;
	
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;

	
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		response.setHeader("Pragma", "no-cache");
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		//로그인한 경우
		if (memberVO != null && memberVO.getMember_id() != null) {
			//로그인한 member_id
			session.setAttribute("memberInfo", memberVO);
			String member_id=memberVO.getMember_id();
			/* mav.addObject("member_id", member_id); */
			cartVO.setMember_id(member_id);
		} else {
			
		}
		
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);//장바구니 목록 화면에서 상품 주문 시 사용하기 위해서 장바구니 목록을 세션에 저장한다.
		//mav.addObject("cartMap", cartMap);

		String product_id = "cartVO.getProduct_id";
		Map productOptMap = productService.productOption(product_id);
		mav.addObject("productOptMap", productOptMap);
/*
 

		/* 제품 정보 가져오기
		Map productMap = productService.productDetail(product_id);
		mav.addObject("productMap", productMap);
		*/		
		
		return mav;
	}

	@RequestMapping(value="/addProductInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,@RequestParam("cart_option_name") String cart_option_name,
			@RequestParam("cart_option_price") String cart_option_price, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		if (memberVO != null && memberVO.getMember_id() != null) {
			//로그인한 member_id
			String member_id=memberVO.getMember_id();
			cartVO.setMember_id(member_id);
		}
		
		//카트 등록전에 이미 등록된 제품인지 판별한다.
		cartVO.setProduct_id(product_id);
		cartVO.setCart_option_name(cart_option_name);
		cartVO.setCart_option_price(cart_option_price);
		
		boolean isAreadyExisted=cartService.findCartProduct(cartVO);
		System.out.println("isAreadyExisted:"+isAreadyExisted);
		if(cart_option_price == null) {
			return "option_isnull";
		}else if(isAreadyExisted==true){
			return "already_existed";
		}else{
			
			cartService.addProductInCart(cartVO);
			return "add_success";
		}
	}
	/*

	
	@RequestMapping(value="/modifyCartQty.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartQty(@RequestParam("product_id") int product_id,
			                                   @RequestParam("cart_option") String cart_option,
			                                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		cartVO.setProduct_id(product_id);
		cartVO.setMember_id(member_id);
		cartVO.setCart_option(cart_option);
		boolean result=cartService.modifyCartQty(cartVO);

		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
			
		 */
	@RequestMapping(value="/removeCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,
			HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartProduct(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}
}
