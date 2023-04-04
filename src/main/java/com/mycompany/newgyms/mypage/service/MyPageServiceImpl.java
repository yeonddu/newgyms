package com.mycompany.newgyms.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.board.vo.ArticleVO;
import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.mypage.dao.MyPageDAO;
import com.mycompany.newgyms.mypage.vo.PointVO;
import com.mycompany.newgyms.order.vo.OrderVO;
import com.mycompany.newgyms.review.vo.ReviewVO;

@Service("myPageService")
@Transactional(propagation=Propagation.REQUIRED)
public class MyPageServiceImpl implements MyPageService {
	@Autowired
	private MyPageDAO myPageDAO;
	
	// 결제내역 조회
	@Override
	public List<OrderVO> listMyOrders(Map condMap) throws Exception {
		return myPageDAO.selectMyOrderList(condMap);
	}
	
	@Override
	public List<OrderVO> orderMemberList(Map condMap) throws Exception {
		return myPageDAO.orderMemberListSelect(condMap);
	}
	
	@Override
	public List<OrderVO> orderMember(Map condMap) throws Exception {
		return myPageDAO.selectOrderMember(condMap);
	}
	
	@Override
	public List<OrderVO> myOrderDetail(int order_id) throws Exception {
		return myPageDAO.selectMyOrderDetail(order_id);
	}
	
	@Override
	public List<OrderVO> myOrderCancel(Map orderMap) throws Exception {
		return myPageDAO.selectMyOrderCancel(orderMap);
	}

	@Override
	public void myOrderRefund(Map refundMap) throws Exception {
		myPageDAO.refundMyOrder(refundMap);
	}
	
	@Override
	public String maxNumSelect(Map condMap) throws Exception {
		return myPageDAO.maxNumSelect(condMap);
	}
	
	// 적립금 조회
	@Override
    public String nowPoint(String member_id) throws Exception {
       return myPageDAO.nowPointSelect(member_id);
    }
   
	@Override
    public List<PointVO> myStackList(Map<String, Object> condMap) throws Exception {
       return myPageDAO.selectMyStackList(condMap);
    }
    
	@Override
    public String maxStack(Map condMap) throws Exception {
        return myPageDAO.maxStackSelect(condMap);
     }
	
	// 게시글 관리
	@Override
	public List<ArticleVO> myArticleList(String member_id) throws Exception {
		List<ArticleVO> myArticleList = myPageDAO.selectMyArticleList(member_id);
		return myArticleList;
	}
	
	// 이용후기 관리
		@Override
		public String reviewMaxNum(Map condMap) throws Exception {
			return myPageDAO.reviewMaxNum(condMap);
		}
		@Override
		public List<ReviewVO> listMyReviews(Map condMap) throws Exception {
			return myPageDAO.listMyReviews(condMap);
		}
		@Override
		public void deleteReview(Map condMap) throws Exception {
			myPageDAO.deleteReview(condMap);
		}

	
	// 회원정보 수정/탈퇴
	@Override
	public MemberVO myPageDetail(Map mypageMap) throws Exception{
		return myPageDAO.myPageDetail(mypageMap);
	}
	
	@Override
	public MemberVO modifyMyInfo(Map modifyMap) throws Exception {
		myPageDAO.updateMyInfo(modifyMap);
		// 수정된 회원 정보를 다시 받아옴
		MemberVO memberVO = myPageDAO.myPageDetail(modifyMap);
		return memberVO;
	}
	
	@Override
	public void deleteMember(Map deleteMap) throws Exception {
		myPageDAO.deleteMember(deleteMap);
	}

}
