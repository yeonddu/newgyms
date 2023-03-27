package com.mycompany.newgyms.mypage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

public interface MyPageDAO {
	public List<OrderVO> selectMyOrderList(String member_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderDetail(int order_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderCancel(Map orderMap) throws DataAccessException;
	public void refundMyOrder(MyPageVO mypageVO) throws DataAccessException;

}