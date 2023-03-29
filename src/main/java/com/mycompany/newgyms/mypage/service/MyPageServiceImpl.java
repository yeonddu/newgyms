package com.mycompany.newgyms.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.dao.MyPageDAO;
import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageDAO myPageDAO;
	
	public List<OrderVO> listMyOrders(Map condMap) throws Exception {
		return myPageDAO.selectMyOrderList(condMap);
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
	
	public String maxNumSelect(Map condMap) throws Exception {
		return myPageDAO.maxNumSelect(condMap);
	}
	
	public MemberVO myPageDetail(Map mypageMap) throws Exception{
		return myPageDAO.myPageDetail(mypageMap);
	}
	
	public MemberVO modifyMyInfo(Map modifyMap) throws Exception {
		myPageDAO.updateMyInfo(modifyMap);
		
		// 수정된 회원정보를 다시 가져옴
		MemberVO memberVO = myPageDAO.myPageDetail(modifyMap);
		return memberVO;
	}
	
	public void deleteMember(Map deleteMap) throws Exception {
		myPageDAO.deleteMember(deleteMap);
	}

}
