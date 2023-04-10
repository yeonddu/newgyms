package com.mycompany.newgyms.owner.qna.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.owner.qna.service.OwnerQnaService;
import com.mycompany.newgyms.qna.vo.QnaVO;

@Controller("ownerQnaController")
@RequestMapping(value = "/owner/qna")
public class OwnerQnaControllerImpl implements OwnerQnaController{


	@Autowired
	private OwnerQnaService ownerQnaService;
	@Autowired
	private QnaVO qnaVO;

	@RequestMapping(value = "/ownerQnaList.do", method = RequestMethod.GET)
	public ModelAndView ownerQnaList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		//로그인 정보 가져오기
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id(); //로그인한 member_id
		
		/* 질문 목록 */
		List<QnaVO> questionList = ownerQnaService.ownerQuestionList(member_id);
		mav.addObject("questionList", questionList);
		
		/* 답변 목록 */
		List<QnaVO> answerList = ownerQnaService.ownerAnswerList(member_id);
		mav.addObject("answerList", answerList);
		
		return mav;
	}
	
	@RequestMapping(value = "/addAnswer.do", method = RequestMethod.POST)
	public ResponseEntity addAnswer(@ModelAttribute("qnaVO") QnaVO qnaVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();
		qnaVO.setMember_id(member_id);
		
		qnaVO.setQna_answer_state("답변완료");
		
		try {
			ownerQnaService.addAnswer(qnaVO);
			message = "<script>";
			message += " alert('답글이 등록되었습니다 :)');";
			message += " location.href='" + request.getContextPath()  + "/owner/qna/ownerQnaList.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath()  + "/owner/qna/ownerQnaList.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
	
	@Override
	@RequestMapping(value = "modifyAnswer.do", method = RequestMethod.POST)
	public ModelAndView modifyAnswer(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		ModelAndView mav = new ModelAndView();
		
		//로그인 정보 가져오기
		HttpSession session=request.getSession();
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		
		String member_id = memberVO.getMember_id(); //로그인한 member_id
		qnaVO.setMember_id(member_id);
		
		int qna_no = Integer.parseInt(request.getParameter("qna_no"));
		String qna_title = request.getParameter("qna_title");
		String qna_contents = request.getParameter("qna_contents");
		
		qnaVO.setQna_no(qna_no);
		qnaVO.setQna_title(qna_title);
		qnaVO.setQna_contents(qna_contents);
		
		ownerQnaService.modifyAnswer(qnaVO);
		
		/*
		PrintWriter out = response.getWriter();
		session.setAttribute("memberInfo", memberVO);
		out.println("<script>alert('문의글이 수정되었습니다. :)');</script>");
		out.flush();
		 * */

		mav.setViewName("redirect:/owner/qna/ownerQnaList.do");
		
		return mav;
	}
	
	
	
	@RequestMapping(value = "/removeAnswer.do", method = RequestMethod.GET)
	public ResponseEntity removeAnswer(@RequestParam("qna_no") int qna_no, @RequestParam("qna_parent_no") int qna_parent_no, HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		
		HttpSession session=request.getSession();

		qnaVO.setQna_no(qna_no);
		qnaVO.setQna_parent_no(qna_parent_no);
		try {
			ownerQnaService.removeAnswer(qnaVO);
			message = "<script>";
			message += " alert('답글이 삭제되었습니다 :)');";
			
			message += " location.href='" + request.getContextPath()  + "/owner/qna/ownerQnaList.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath()  + "/owner/qna/ownerQnaList.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}
}
