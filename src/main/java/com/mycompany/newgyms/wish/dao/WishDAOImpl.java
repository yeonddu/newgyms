package com.mycompany.newgyms.wish.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("wishDAO")
public class WishDAOImpl implements WishDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertWishList(String product_id, String member_id) throws Exception {
		Map wishMap = new HashMap();
		wishMap.put("product_id", product_id);
		wishMap.put("member_id", member_id);
		sqlSession.insert("mapper.wish.insertWishList",wishMap);
	}
}
