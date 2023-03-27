package com.mycompany.newgyms.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<OrderVO> selectMyOrderList(String member_id) throws DataAccessException {
		List<OrderVO> orderList = (List)sqlSession.selectList("mapper.mypage.selectMyOrderList", member_id);
		return orderList;
	}
	
	public List<OrderVO> selectMyOrderDetail(int order_id) throws DataAccessException {
		List<OrderVO> orderList = (List)sqlSession.selectList("mapper.mypage.selectMyOrderDetail", order_id);
		return orderList;
	}

	public List<OrderVO> selectMyOrderCancel(Map orderMap) throws DataAccessException {
		List<OrderVO> orderList = (List)sqlSession.selectList("mapper.mypage.selectMyOrderCancel", orderMap);
		return orderList;
	}
	
	public void refundMyOrder(MyPageVO mypageVO) throws DataAccessException {
		sqlSession.insert("mapper.mypage.refundMyOrder", mypageVO);
	}

}
