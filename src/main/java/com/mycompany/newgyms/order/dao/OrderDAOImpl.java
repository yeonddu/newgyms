package com.mycompany.newgyms.order.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.order.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl {
	@Autowired
	private SqlSession sqlSession;
	
	public List<OrderVO> selectOrderProductList(Map orderMap) throws DataAccessException {
		List<OrderVO> myOrderList = sqlSession.selectList("mapper.order.selectOrderProductList",orderMap);
		return myOrderList;
	}

}
