package com.mycompany.newgyms.cart.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.product.vo.ProductOptVO;

public interface CartController {
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public @ResponseBody String addProductInCart(@RequestParam("product_id") int product_id,@RequestParam("cart_option_name") String cart_option_name, @RequestParam("cart_option_price") int cart_option_price, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public @ResponseBody List<ProductOptVO> selectProductOption(@RequestParam("product_id") String product_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	
	public @ResponseBody String  modifyCartOption(@RequestParam("product_id") int product_id, @RequestParam("cart_option_name") String cart_option_name, @RequestParam("cart_option_price") int cart_option_price, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity removeEachCartProduct(@RequestParam("cart_id") int cart_id, HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity removeCartProduct(@RequestParam(value="cart_id_list[]") String[] cart_id_list, HttpServletRequest request, HttpServletResponse response)  throws Exception;
}
