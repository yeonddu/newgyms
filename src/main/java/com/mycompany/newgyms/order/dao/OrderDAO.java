package com.mycompany.newgyms.order.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.order.vo.OrderVO;

public interface OrderDAO {
	public List<OrderVO> selectOrderProductList(Map orderMap) throws DataAccessException;
}
