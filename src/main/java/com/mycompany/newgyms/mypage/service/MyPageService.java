package com.mycompany.newgyms.mypage.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

public interface MyPageService {
	public List<OrderVO> listMyOrders(String member_id) throws Exception;
	public List<OrderVO> myOrderDetail(int order_id) throws Exception;
	public List<OrderVO> myOrderCancel(Map orderMap) throws Exception;
	public void myOrderRefund(MyPageVO mypageVO) throws Exception;

}