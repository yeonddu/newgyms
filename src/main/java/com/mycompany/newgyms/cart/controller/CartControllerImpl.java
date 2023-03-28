package com.mycompany.newgyms.cart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import com.mycompany.newgyms.product.vo.ProductOptVO;

import net.sf.json.JSONArray;

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

	/*장바구니 목록*/
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT"); 
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0"); 
		response.setHeader("Pragma", "no-cache");
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
System.out.println("isLogOn :"+isLogOn);
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		//로그인한 경우
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			
			//로그인한 member_id
			session.setAttribute("memberInfo", memberVO);
			String member_id=memberVO.getMember_id();
			cartVO.setMember_id(member_id);
			/* mav.addObject("member_id", member_id); */
			
		//로그인 하지 않은 경우
		} else if (isLogOn == null || isLogOn == false || memberVO!= null) {
			
			String member_id = session.getId(); //session Id를 member_id에 저장
System.out.println("session Id"+member_id);
			cartVO.setMember_id(member_id);
			
		}
		
		Map<String ,List> cartMap=cartService.myCartList(cartVO);
		session.setAttribute("cartMap", cartMap);//장바구니 목록 화면에서 상품 주문 시 사용하기 위해서 장바구니 목록을 세션에 저장한다.
		mav.addObject("cartMap", cartMap);
		return mav;
	}

	/* 장바구니 추가 */
	@RequestMapping(value="/addProductInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id, @RequestParam("option_id") int option_id, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		//로그인 정보 가져오기
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
System.out.println("isLogOn :"+isLogOn);
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		if (isLogOn == true && memberVO!= null && memberVO.getMember_id() != null) {
			
			String member_id=memberVO.getMember_id(); //로그인한 member_id
			cartVO.setMember_id(member_id);
			
		} else if (isLogOn == null || isLogOn == false || memberVO!= null) {
			
			String member_id = session.getId(); //session Id를 member_id에 저장
System.out.println("session Id"+member_id);
			cartVO.setMember_id(member_id);
			session.setMaxInactiveInterval(1*60);
			session.setAttribute("isLogOn", false);
			
		}
		
		cartVO.setProduct_id(product_id);
		cartVO.setOption_id(option_id);
		
		//장바구니에 이미 등록된 제품인지 확인
		boolean isAreadyExisted=cartService.findCartProduct(cartVO);
		System.out.println("isAreadyExisted:"+isAreadyExisted);

		if(isAreadyExisted==true){
			return "already_existed";
		}else{
			cartService.addProductInCart(cartVO);
			return "add_success";
		}
	}
	
	/*장바구니 옵션 변경*/
	@RequestMapping(value="/selectProductOption.do" ,method = RequestMethod.GET)
	
	public @ResponseBody List<ProductOptVO> selectProductOption(@RequestParam("product_id") String product_id, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		List<ProductOptVO> productOptList = productService.productOptionList(product_id);
		return productOptList;
	}
	
	/*변경한 옵션 저장*/
	@RequestMapping(value="/modifyCartOption.do" ,method = RequestMethod.POST)
	public @ResponseBody String  modifyCartOption(@RequestParam("product_id") int product_id, @RequestParam("option_id") int option_id, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		HttpSession session=request.getSession();
		
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();
		
		cartVO.setProduct_id(product_id);
		cartVO.setMember_id(member_id);
		cartVO.setOption_id(option_id);
		
		boolean result=cartService.modifyCartOption(cartVO);

		
		if(result==true){
		   return "modify_success";
		}else{
			  return "modify_failed";	
		}
		
	}
	
	/* 장바구니 개별 삭제 */
	@RequestMapping(value="/removeEachCartProduct.do" ,method = RequestMethod.GET)
	public ResponseEntity removeEachCartProduct(@RequestParam("cart_id") int cart_id, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		try {
			cartService.removeEachCartProduct(cart_id);
			message = "<script>";
			message += " alert('삭제가 완료되었습니다. :)');";
			message += " location.href='" + request.getContextPath() + "/cart/myCartList.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요 :( ');";
			message += " location.href='" + request.getContextPath() + "/cart/myCartList.do';";
			message += " </script>";
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	/* 장바구니 선택 삭제 */
	@RequestMapping(value="/removeCartProduct.do" ,method = RequestMethod.POST)
	public @ResponseBody ResponseEntity removeCartProduct(@RequestParam(value="cart_id[]") String[] cart_id_list, HttpServletRequest request, HttpServletResponse response)  throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		Map<String, Object> cartMap = new HashMap<String, Object>();
		cartMap.put("cart_id_list", cart_id_list);
		System.out.println(cartMap);
		try {
			cartService.removeCartProduct(cartMap);
			message = "<script>";
			message += " alert('삭제가 완료되었습니다. :)');";
			message += " location.href='" + request.getContextPath() + "/cart/myCartList.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요 :( ');";
			message += " location.href='" + request.getContextPath() + "/cart/myCartList.do';";
			message += " </script>";
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

}
