package com.mycompany.newgyms.review.service;

import java.util.List;

import com.mycompany.newgyms.review.vo.ReviewVO;


public interface ReviewService {
	public List<ReviewVO> productReview(String product_id) throws Exception;
}
