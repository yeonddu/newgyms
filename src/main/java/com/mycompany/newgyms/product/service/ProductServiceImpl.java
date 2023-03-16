package com.mycompany.newgyms.product.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.dao.ProductDAO;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

@Service("productService")
@Transactional(propagation=Propagation.REQUIRED)
public class ProductServiceImpl implements ProductService {

	private static final String String = null;
	@Autowired
	private ProductDAO productDAO;
	
	/*상품검색 추가*/
	public List<ProductVO> productList(String product_sort) throws Exception{
		List productList=productDAO.selectProductList(product_sort);
		return productList;
	}
	
	public List<ProductVO> productByAddress(String address) throws Exception {
		List productList=productDAO.selectproductByAddress(address);
		return productList;
	}
	
	public Map productDetail(String _product_id) throws Exception {
		Map productMap=new HashMap();
		ProductVO productVO = productDAO.selectProductDetail(_product_id);
		productMap.put("productVO", productVO);
		
		/* 옵션 */
		List<ProductOptVO> productOptList = productDAO.selectProductOption(_product_id);
		productMap.put("productOptList", productOptList);

		
		return productMap;
	}
	public Map productImage(String _product_id) throws Exception {
		/* 이미지 */
		Map imageMap =productDAO.selectProductImage(_product_id);
		return imageMap;
	}

	/*사업자 정보 가져오기*/
	public MemberVO ownerDetail(String member_id) throws Exception {
	MemberVO memberVO = productDAO.selectOwnerDetail(member_id);
	return memberVO;
	}

	public List<ProductVO> productSorting(String product_sort, String sortBy) throws Exception{
		List productList= productDAO.selectSortedProduct(product_sort, sortBy);
		return productList;
	}
	public List<ProductVO> searchProduct(String searchWord) throws Exception{
		List productList=productDAO.selectProductBySearchWord(searchWord);
		return productList;
	}
	
	public List<ProductVO> searchProductByCondition(Map searchMap) throws Exception{
		List productList=productDAO.searchProductByCondition(searchMap);
		return productList;
	}
	/*
	public List<ProductVO> searchProductByCondition(String searchOption, String searchWord, String minPrice, String maxPrice) throws Exception{
		List productList=productDAO.searchProductByCondition(searchOption, searchWord, minPrice, maxPrice);
		return productList;
	}
	*/
	/*

	public List<String> keywordSearch(String keyword) throws Exception {
		List<String> list=productDAO.selectKeywordSearch(keyword);
		return list;
	}
	
	*/
}