package com.mycompany.newgyms.wish.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.wish.service.WishService;


@Controller("wishController")
@RequestMapping(value = "/wish")
public class WishControllerImpl implements WishController{
	@Autowired
	private WishService wishService;
	
	@RequestMapping(value = "/addWishList.do", method = RequestMethod.GET)
	public void addWishList(@RequestParam("product_id") String product_id,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMember_id();

		wishService.addWishList(product_id, member_id);


	}

}
