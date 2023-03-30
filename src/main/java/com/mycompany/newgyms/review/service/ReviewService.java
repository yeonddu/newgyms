package com.mycompany.newgyms.review.service;

import java.util.List;
import java.util.Map;

import com.mycompany.newgyms.review.vo.ReviewImageVO;
import com.mycompany.newgyms.review.vo.ReviewVO;


public interface ReviewService {
	public List<ReviewVO> productReviewList(int product_id) throws Exception;
	public List<ReviewVO> reviewList() throws Exception;
	public ReviewVO viewReview(int review_no) throws Exception;
	public List<ReviewImageVO> reviewImageList(int review_no) throws Exception;
}
