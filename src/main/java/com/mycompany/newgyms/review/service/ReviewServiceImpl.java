package com.mycompany.newgyms.review.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.product.vo.ProductVO;
import com.mycompany.newgyms.review.dao.ReviewDAO;
import com.mycompany.newgyms.review.vo.ReviewVO;

@Service("reviewService")
@Transactional(propagation=Propagation.REQUIRED)
public class ReviewServiceImpl implements ReviewService{
	private static final String String = null;
	@Autowired
	private ReviewDAO reviewDAO;
	
	
	public List<ReviewVO> productReviewList(int product_id) throws Exception{
		List reviewList= reviewDAO.selectproductReviewList(product_id);
		return reviewList;
	}
	
	public List<ReviewVO> reviewList() throws Exception {
		List reviewList = reviewDAO.selectReviewList();
		return reviewList;
	}
	
	public Map reviewImage() throws Exception {
		Map imageMap = reviewDAO.reviewImage();
		return imageMap;
	}
	
}
