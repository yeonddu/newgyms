package com.mycompany.newgyms.review.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.review.service.ReviewService;
import com.mycompany.newgyms.review.vo.ReviewImageVO;
import com.mycompany.newgyms.review.vo.ReviewVO;


@Controller("reviewController")
@RequestMapping(value="/review")
public class ReviewControllerImpl implements ReviewController {
		
	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping(value = "/reviewList.do", method = RequestMethod.GET)
	public ModelAndView reviewList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List<ReviewVO> reviewList = reviewService.reviewList();
		mav.addObject("reviewList", reviewList);
		
		return mav;
	}
	

	/* 리뷰 상세페이지 */
	@RequestMapping(value = "/viewReview.do", method = RequestMethod.GET)
	public ModelAndView viewReview(@RequestParam("review_no") int review_no, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		ReviewVO reviewVO = reviewService.viewReview(review_no);
		
		mav.addObject("reviewVO", reviewVO);
		/* 이미지 */
		List<ReviewImageVO> reviewImageList = reviewService.reviewImageList(review_no);
		mav.addObject("reviewImageList ",reviewImageList);
		return mav;
	}

}
