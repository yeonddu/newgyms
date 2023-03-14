package com.mycompany.newgyms.review.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("reviewDAO")
public class ReviewDAOImpl implements ReviewDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public ArrayList selectproductReview(String product_id) throws DataAccessException{
		ArrayList list = new ArrayList();
		list=(ArrayList)sqlSession.selectList("mapper.review.selectProductReview",product_id);
		return list;
	}
	 
}
