package com.mycompany.newgyms.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.mypage.dao.MyPageDAO;
import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageDAO myPageDAO;
	
	public List<OrderVO> listMyOrders(String member_id) throws Exception {
		return myPageDAO.selectMyOrderList(member_id);
	}
	
	public List<OrderVO> myOrderDetail(int order_id) throws Exception {
		return myPageDAO.selectMyOrderDetail(order_id);
	}

	public List<OrderVO> myOrderCancel(Map orderMap) throws Exception {
		return myPageDAO.selectMyOrderCancel(orderMap);
	}

	public void myOrderRefund(MyPageVO mypageVO) throws Exception {
		myPageDAO.refundMyOrder(mypageVO);
	}

}
