package com.mycompany.newgyms.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.order.vo.OrderVO;

public interface OrderDAO {
	public String orderPoint(String member_id) throws DataAccessException;
	public List<OrderVO> selectOrderProductList(Map orderMap) throws DataAccessException;
	public int insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;
}
