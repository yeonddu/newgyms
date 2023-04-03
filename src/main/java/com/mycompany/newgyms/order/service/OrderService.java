package com.mycompany.newgyms.order.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.order.vo.OrderVO;

public interface OrderService {
	public List<OrderVO> selectOrderProductList(Map orderMap) throws Exception;
}
