package com.mycompany.newgyms.product.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.product.vo.ProductImageVO;
import com.mycompany.newgyms.product.vo.ProductOptVO;
import com.mycompany.newgyms.product.vo.ProductVO;

@Repository("productDAO")
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSession sqlSession;

	/*��ǰ �˻� �߰�*/
	public ArrayList selectProductList(String product_sort) throws DataAccessException{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.product.selectProductList",product_sort);
		 return list;
	}

	@Override
	public ProductVO selectProductDetail(String product_id) throws DataAccessException{
		ProductVO productVO=(ProductVO)sqlSession.selectOne("mapper.product.selectProductDetail",product_id);
		return productVO;
	}
	
	/* �ɼ� */
	@Override
	public List<ProductOptVO> selectProductOption(String product_id) throws DataAccessException{
		List<ProductOptVO> productOptList=(ArrayList)sqlSession.selectList("mapper.product.selectProductOption",product_id);
		return productOptList;
	}

	/* ���α׷� ������ �̹��� */
	@Override
	public List<ProductImageVO> selectProductDetailImage(String product_id) throws DataAccessException{
		List<ProductImageVO> imageList=(ArrayList)sqlSession.selectList("mapper.product.selectProductDetailImage",product_id);
		return imageList;
	}
	/* ���� ���� �̹��� */
	@Override
	public List<ProductImageVO> selectProductPriceImage(String product_id) throws DataAccessException{
		List<ProductImageVO> priceImage=(ArrayList)sqlSession.selectList("mapper.product.selectProductPriceImage",product_id);
		return priceImage;
	}
	/* �ü� ���� �̹��� */
	@Override
	public List<ProductImageVO> selectProductFacilityImage(String product_id) throws DataAccessException{
		List<ProductImageVO> facilityImage=(ArrayList)sqlSession.selectList("mapper.product.selectProductFacilityImage",product_id);
		return facilityImage;
	}
	
	/*�Ǹ��� ����*/
	@Override
	public MemberVO selectOwnerDetail(String center_name) throws DataAccessException{
		MemberVO memberVO=(MemberVO)sqlSession.selectOne("mapper.product.selectOwnerDetail",center_name);
		return memberVO;
	}
	
	

	/*
	 * public ArrayList selectproductReview(String product_id) throws
	 * DataAccessException{ ArrayList list = new ArrayList();
	 * list=(ArrayList)sqlSession.selectList("mapper.review.selectProductReview",
	 * product_id); return list; }
	 */
	 
	public ArrayList selectSortedProduct(String product_sort, String sortBy) throws DataAccessException{
		ArrayList list = new ArrayList();
		if(sortBy.equals("popular")) {
			list=(ArrayList)sqlSession.selectList("mapper.product.selectproductSortByPopular",product_sort);
		} else if (sortBy.equals("lowPrice")) {
			list=(ArrayList)sqlSession.selectList("mapper.product.selectproductSortByLowPrice",product_sort);
		} else if (sortBy.equals("highPrice")) {
			list=(ArrayList)sqlSession.selectList("mapper.product.selectproductSortByHighPrice",product_sort);
	} 
		return list;
	}
	
	@Override
	public ArrayList selectProductBySearchWord(String searchWord) throws DataAccessException{
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.product.selectProductBySearchWord",searchWord);
		return list;
	}
	
	@Override
	public ArrayList searchProductByCondition(String searchOption, String searchWord, String minPrice, String maxPrice) throws DataAccessException{
		Map searchMap = new HashMap();
		searchMap.put("searchOption", searchOption);
		searchMap.put("searchWord", searchWord);
		searchMap.put("minPrice", minPrice);
		searchMap.put("maxPrice", maxPrice);
		
		ArrayList list = new ArrayList();		
		list=(ArrayList)sqlSession.selectList("mapper.product.selectProductByCondition",searchMap);				
		/*		
		if (searchOption.equals("product_name")) {
				list=(ArrayList)sqlSession.selectList("mapper.product.selectProductByProductName",searchMap);				
				
		} else if (searchOption.equals("center_name")) {
				list=(ArrayList)sqlSession.selectList("mapper.product.selectProductByCenterName",searchMap);
		}
		*/
		return list;
	}
	
		
	/*
	@Override
	public List<ProductVO> selectProductList(String productStatus ) throws DataAccessException {
		List<ProductVO> productList=(ArrayList)sqlSession.selectList("mapper.product.selectProductList",productStatus);
		return productList;	
		
	}
	@Override
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
	   List<String> list=(ArrayList)sqlSession.selectList("mapper.product.selectKeywordSearch",keyword);
	   return list;
	}
	
	
	*/
}