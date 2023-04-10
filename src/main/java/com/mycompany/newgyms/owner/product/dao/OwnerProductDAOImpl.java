package com.mycompany.newgyms.owner.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

@Repository("ownerProductDAO")
public class OwnerProductDAOImpl implements OwnerProductDAO {
	@Autowired
	private SqlSession sqlSession;
	
	// 상품 목록
	@Override
	public List selectOwnerProductList(String member_id) throws DataAccessException {
		List ownerProductList = (List) sqlSession.selectList("mapper.owner_product.selectOwnerProductList", member_id);
		return ownerProductList;
	}
}
