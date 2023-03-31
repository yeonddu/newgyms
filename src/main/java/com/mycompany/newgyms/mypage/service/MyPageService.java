package com.mycompany.newgyms.mypage.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.vo.PointVO;
import com.mycompany.newgyms.order.vo.OrderVO;

public interface MyPageService {
	// 결제내역 조회
	public List<OrderVO> listMyOrders(Map condMap) throws Exception;
	public List<OrderVO> orderMemberList(Map condMap) throws Exception;
	public List<OrderVO> myOrderDetail(int order_id) throws Exception;
	public List<OrderVO> myOrderCancel(Map orderMap) throws Exception;
	public void myOrderRefund(Map refundMap) throws Exception;
	public String maxNumSelect(Map condMap) throws Exception;
	
	// 적립금 조회
	public String nowPoint(String member_id) throws Exception;
	public List<PointVO> myStackList(Map<String, Object> condMap) throws Exception;
	public String maxStack(Map condMap) throws Exception;
	
	// 회원정보 수정/탈퇴
	public MemberVO myPageDetail(Map mypageMap) throws Exception;
	public MemberVO modifyMyInfo(Map modifyMap) throws Exception;
	public void deleteMember(Map deleteMap) throws Exception;
	public List<OrderVO> orderMember(Map<String, Object> condMap) throws Exception;
}