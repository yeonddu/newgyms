package com.mycompany.newgyms.product.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;

public interface ProductDAO {
	/*상품검색 추가*/
	public List<ProductVO> selectProductList(String productSort) throws DataAccessException;
	public List<ProductVO> selectproductByAddress(String address) throws DataAccessException;
	public ProductVO selectProductDetail(String product_id) throws DataAccessException;
	
	public List<ProductOptVO> selectProductOption(String product_id) throws DataAccessException;
	public Map<String,Object> selectProductImage(String product_id) throws DataAccessException;
	
	public MemberVO selectOwnerDetail(String member_id) throws DataAccessException;
	
	public List<ProductVO> selectSortedProduct(String productSort, String sortBy) throws DataAccessException;
	
	public List<ProductVO> selectProductBySearchWord(String searchWord) throws DataAccessException;
	
	public List<ProductVO> searchProductByCondition(Map searchMap) throws DataAccessException;
	/*
	public List<ProductVO> searchProductByCondition(String searchOption, String searchWord, String minPrice, String maxPrice) throws DataAccessException;
	
	public List<ProductVO> selectProductList(String productStatus ) throws DataAccessException;
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException;
	*/
}
