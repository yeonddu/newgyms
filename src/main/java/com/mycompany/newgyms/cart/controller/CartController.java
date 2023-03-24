package com.mycompany.newgyms.cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.product.vo.ProductOptVO;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,@RequestParam("cart_option_name") String cart_option_name, @RequestParam("cart_option_price") int cart_option_price, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public @ResponseBody List<ProductOptVO> selectProductOption(@RequestParam("product_id") String product_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public @ResponseBody String  modifyCartOption(@RequestParam("product_id") int product_id, @RequestParam("cart_option_name") String cart_option_name, @RequestParam("cart_option_price") int cart_option_price, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	/* 
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goods_id,@RequestParam("order_goods_qty") int order_goods_qty, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public  @ResponseBody String modifyCartQty(@RequestParam("product_id") int product_id,@RequestParam("order_option") int cart_option,
			                  HttpServletRequest request, HttpServletResponse response)  throws Exception;
	 */
	public ModelAndView removeCartProduct(@RequestParam("cart_id") int cart_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;

}
