package com.mycompany.newgyms.product.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

public interface ProductController {
	/*상품검색 추가*/
	public ModelAndView productList(@RequestParam("productSort") String productSort, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public ModelAndView productDetail(@RequestParam("product_id") String product_id,HttpServletRequest request, HttpServletResponse response) throws Exception;	
	public ModelAndView productSorting(@RequestParam("productSort") String productSort,@RequestParam("sortBy") String sortBy, HttpServletRequest request, HttpServletResponse response) throws Exception;
	/*
	public @ResponseBody String keywordSearch(@RequestParam("keyword") String keyword,HttpServletRequest request, HttpServletResponse response) throws Exception;
	public ModelAndView searchProduct(@RequestParam("searchWord") String searchWord,HttpServletRequest request, HttpServletResponse response) throws Exception;
	 */
}

