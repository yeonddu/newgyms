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
	public List<ProductVO> selectProductList(Map listMap) throws DataAccessException;

	public ProductVO selectProductDetail(String product_id) throws DataAccessException;
	
	public List<ProductOptVO> selectProductOptionList(String product_id) throws DataAccessException;
	
	public Map<String,Object> selectProductImage(String product_id) throws DataAccessException;
	
	public MemberVO selectOwnerDetail(String member_id) throws DataAccessException;
	
	public List<ProductVO> selectSortedProduct(Map sortMap) throws DataAccessException;
	
	public List<ProductVO> selectProductBySearchWord(String searchWord) throws DataAccessException;
	
	public List<ProductVO> searchProductByCondition(Map searchMap) throws DataAccessException;
	
	public ProductOptVO selectProductOption(String product_id) throws DataAccessException;

}
