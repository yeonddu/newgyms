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
		
		
		MemberVO memberVo=(MemberVO)session.getAttribute("memberInfo");
		if (memberVo != null && memberVo.getMember_id() != null) {
		
			String loginMember_id=memberVo.getMember_id();
			mav.addObject("loginMember_id", loginMember_id);
			cartVO.setMember_id(loginMember_id);
		}

		
		
		 
		
		
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);//��ٱ��� ��� ȭ�鿡�� ��ǰ �ֹ� �� ����ϱ� ���ؼ� ��ٱ��� ����� ���ǿ� �����Ѵ�.
		//mav.addObject("cartMap", cartMap);
		
		String product_id = "cartVO.getProduct_id";

		/* ��ǰ ���� �������� */
		Map productMap = productService.productDetail(product_id);
		mav.addObject("productMap", productMap);
		
		/*�̹��� ��������*/
		Map imageMap = productService.productImage(product_id);
		mav.addObject("imageMap",imageMap);
		
		return mav;
	}
	
	/*
	 

	
	@RequestMapping(value="/addProductInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	   public  @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,@RequestParam("order_option") int order_option,
	                             HttpServletRequest request, HttpServletResponse response)  throws Exception{
	      HttpSession session=request.getSession();
	      memberVO=(MemberVO)session.getAttribute("memberInfo");
	      String member_id=memberVO.getMember_id();
	      
	      cartVO.setMember_id(member_id);
	      //īƮ ������� �̹� ��ϵ� ��ǰ���� �Ǻ��Ѵ�.
	      cartVO.setProduct_id(product_id);
	      cartVO.setCart_option(order_option);
	      boolean isAreadyExisted=cartService.findCartProduct(cartVO);
	      System.out.println("isAreadyExisted:"+isAreadyExisted);
	      if(isAreadyExisted==true){
	         return "already_existed";
	      }else{
	         cartService.addProductInCart(cartVO);
	         return "add_success";
	      }
	   }
	
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
			
	@RequestMapping(value="/removeCartProduct.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,
			                          HttpServletRequest request, HttpServletResponse response)  throws Exception{
		ModelAndView mav=new ModelAndView();
		cartService.removeCartProduct(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do");
		return mav;
	}
		 */
}
