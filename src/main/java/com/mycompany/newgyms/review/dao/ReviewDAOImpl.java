package com.mycompany.newgyms.review.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.product.vo.ProductImageVO;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList selectproductReviewList(int product_id) throws DataAccessException{
		ArrayList list = new ArrayList();
		list=(ArrayList)sqlSession.selectList("mapper.review.selectProductReviewList",product_id);
		return list;
	}
	
	@Override
	public ArrayList selectReviewList() throws DataAccessException {
		ArrayList list = (ArrayList) sqlSession.selectList("mapper.review.selectReviewList");
		return list;
	}
	
	public Map<String, Object> selectReviewImage() throws DataAccessException {
		List<ProductImageVO> detailImageList = (ArrayList) sqlSession.selectList("mapper.product.selectProductDetailImage", product_id);
		Map imageMap = new HashMap();
		imageMap.put("detailImageList", detailImageList);

		return imageMap;
	}
}
