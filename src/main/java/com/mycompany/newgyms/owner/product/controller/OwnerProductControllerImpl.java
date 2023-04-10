package com.mycompany.newgyms.owner.product.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.owner.product.service.OwnerProductService;
import com.mycompany.newgyms.product.vo.ProductVO;

@Controller("ownerProductController")
@RequestMapping(value = "/owner/product")
public class OwnerProductControllerImpl implements OwnerProductController {
	@Autowired
	private OwnerProductService ownerProductService;

	// 사업자 상품 목록
	@RequestMapping(value = "/ownerProductList.do", method = RequestMethod.GET)
	public ModelAndView ownerProductList(@RequestParam("member_id") String member_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		List<ProductVO> ownerProductList = ownerProductService.ownerProductList(member_id);

		mav.addObject("ownerProductList", ownerProductList);
		return mav;
	}
}