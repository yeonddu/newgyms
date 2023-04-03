package com.mycompany.newgyms.order.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.newgyms.order.dao.OrderDAO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Service("orderService")
public class OrderServiceImpl {
	@Autowired
	private OrderDAO orderDAO;

	public List<OrderVO> selectOrderProductList(Map orderMap) throws Exception{
		List<OrderVO> myOrderList = orderDAO.selectOrderProductList(orderMap);
		return myOrderList;
	}
}
