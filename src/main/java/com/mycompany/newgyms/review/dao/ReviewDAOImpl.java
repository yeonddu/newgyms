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
import com.mycompany.newgyms.review.vo.ReviewImageVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

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
	
	@Override
	public ReviewVO selectReviewDetail(int review_no) throws DataAccessException {
		ReviewVO reviewVO = sqlSession.selectOne("mapper.review.selectReviewDetail", review_no);
		return reviewVO;
	}
	
	@Override
	public List<ReviewImageVO> selectReviewImageList(int review_no) throws DataAccessException {
		List<ReviewImageVO> reviewImageList = (ArrayList) sqlSession.selectList("mapper.review.selectReviewImageList", review_no);
		return reviewImageList;
	}
}
