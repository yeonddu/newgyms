package com.mycompany.newgyms.mypage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.vo.MyPageVO;
import com.mycompany.newgyms.order.vo.OrderVO;

public interface MyPageDAO {
	public List<OrderVO> selectMyOrderList(Map condMap) throws DataAccessException;
	public List<OrderVO> selectMyOrderDetail(int order_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderCancel(Map orderMap) throws DataAccessException;
	public void refundMyOrder(MyPageVO mypageVO) throws DataAccessException;
	public String maxNumSelect(Map condMap) throws DataAccessException;
	
	public MemberVO myPageDetail(Map mypageMap) throws DataAccessException;
	public void updateMyInfo(Map modifyMap) throws DataAccessException;
	public void deleteMember(Map deleteMap) throws DataAccessException;
}