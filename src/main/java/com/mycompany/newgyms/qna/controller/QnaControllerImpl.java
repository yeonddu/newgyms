package com.mycompany.newgyms.qna.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.qna.service.QnaService;
import com.mycompany.newgyms.qna.vo.QnaVO;

@Controller("qnaController")
@RequestMapping(value = "/qna")
public class QnaControllerImpl {
	
	@Autowired
	private QnaService qnaService;

	@RequestMapping(value = "/addQuestion.do", method = RequestMethod.POST)
	public ResponseEntity addQuestion(@ModelAttribute("qnaVO") QnaVO qnaVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		
		qnaVO.setQna_parent_no(0);
		qnaVO.setQna_answer_state("�亯���");
		qnaVO.setMember_id(member_id);
		
		String secret = request.getParameter("secret");
		
		if(secret != null) {
		    qnaVO.setQna_secret("1"); //��б��� ������ ���
		  } else {
			  qnaVO.setQna_secret("0");
		  }
		
		int product_id = qnaVO.getProduct_id();
		
		try {
			qnaService.addQuestion(qnaVO);
			message = "<script>";
			message += " alert('���Ǳ��� ��ϵǾ����ϴ�.. :)');";
			message += " location.href='" + request.getContextPath() + "/product/productDetail.do?product_id= " + product_id +"';";
//			message += " location.href='" + request.getContextPath() + "/product/productDetail.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('�۾� �� ������ �߻��߽��ϴ�. �ٽ� �õ��� �ּ���');";
			message += " location.href='" + request.getContextPath() + "/product/productDetail.do?product_id= " + product_id +"';";
//			message += " location.href='" + request.getContextPath() + "/product/productDetail.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
}
