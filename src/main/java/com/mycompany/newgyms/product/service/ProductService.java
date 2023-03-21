package com.mycompany.newgyms.product.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;

public interface ProductService {
	public List<ProductVO> productList(Map listMap) throws Exception;

	public Map productDetail(String _product_id) throws Exception;
	public MemberVO ownerDetail(String member_id) throws Exception;
	
	public ProductOptVO selectModifyCart(String _product_id) throws Exception;
	
	public List<ProductOptVO> productOption(String _product_id) throws Exception;
	public Map productImage(String _product_id) throws Exception;

	public List<ProductVO> productSorting(Map sortMap) throws Exception;
	public List<ProductVO> searchProduct(String searchWord) throws Exception;
	public List<ProductVO> searchProductByCondition(Map searchMap) throws Exception;
/*	public List<ProductVO> searchProductByCondition(String searchOption, String searchWord, String minPrice, String maxPrice) throws Exception;
	
	/*
	public Map<String,List<ProductVO>> listProduct() throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;
*/
}
