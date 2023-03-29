package com.mycompany.newgyms.review.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.review.service.ReviewService;
import com.mycompany.newgyms.review.vo.ReviewVO;


@Controller("reviewController")
@RequestMapping(value="/review")
public class ReviewControllerImpl implements ReviewController {
		
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ReviewVO reviewVO;
	
	@RequestMapping(value = "/reviewList.do", method = RequestMethod.GET)
	public ModelAndView reviewList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List<ReviewVO> reviewList = reviewService.reviewList();
		mav.addObject("reviewList", reviewList);
		
		/* ¿ÃπÃ¡ˆ */
		Map imageMap = reviewService.reviewImage();
		mav.addObject("imageMap", imageMap);

		
		return mav;
	}

}
