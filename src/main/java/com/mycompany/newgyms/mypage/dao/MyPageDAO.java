package com.mycompany.newgyms.mypage.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.vo.PointVO;
import com.mycompany.newgyms.order.vo.OrderVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

public interface MyPageDAO {
	// 결제내역 조회
	public List<OrderVO> selectMyOrderList(Map condMap) throws DataAccessException;
	public List<OrderVO> orderMemberListSelect(Map condMap) throws DataAccessException;
	public List<OrderVO> selectMyOrderDetail(int order_id) throws DataAccessException;
	public List<OrderVO> selectMyOrderCancel(Map orderMap) throws DataAccessException;
	public void refundMyOrder(Map refundMap) throws DataAccessException;
	public int selectNewRefundId() throws DataAccessException;
	public String maxNumSelect(Map condMap) throws DataAccessException;
	
	// 적립금 조회
	public List<PointVO> selectMyStackList(Map condMap) throws DataAccessException;
	public String nowPointSelect(String member_id) throws DataAccessException;
	public String maxStackSelect(Map condMap) throws DataAccessException;
	public void addPoint(Map pointMap) throws DataAccessException;
	public void usePoint(Map pointMap) throws DataAccessException;
	
	// 게시글 관리
	public List selectMyArticleList(String member_id) throws DataAccessException;
	
	// 이용후기 관리
	public String reviewMaxNum(Map condMap) throws DataAccessException;
	public List<ReviewVO> listMyReviews(Map condMap) throws DataAccessException;
	public void deleteReview(Map condMap) throws DataAccessException;

	
	// 회원정보 수정/탈퇴
	public MemberVO myPageDetail(Map mypageMap) throws DataAccessException;
	public void updateMyInfo(Map modifyMap) throws DataAccessException;
	public void deleteMember(Map deleteMap) throws DataAccessException;
	public List<OrderVO> selectOrderMember(Map condMap);
}