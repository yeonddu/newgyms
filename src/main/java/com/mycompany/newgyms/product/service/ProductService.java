package com.mycompany.newgyms.product.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.vo.ProductVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

public interface ProductService {
	/*상품검색 추가*/
	public List<ProductVO> productList(String productSort) throws Exception;
	public Map productDetail(String _product_id) throws Exception;
	public MemberVO ownerDetail(String member_id) throws Exception;
	public Map productImage(String _product_id) throws Exception;

	public List<ProductVO> productSorting(String productSort, String sortBy) throws Exception;
	public List<ProductVO> searchProduct(String searchWord) throws Exception;
	public List<ProductVO> searchProductByCondition(Map searchMap) throws Exception;
/*	public List<ProductVO> searchProductByCondition(String searchOption, String searchWord, String minPrice, String maxPrice) throws Exception;
	
	/*
	public Map<String,List<ProductVO>> listProduct() throws Exception;
	
	public List<String> keywordSearch(String keyword) throws Exception;
*/
}
