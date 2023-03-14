package com.mycompany.newgyms.member.controller;

import java.util.HashMap;
import java.util.Map;

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

import com.mycompany.newgyms.common.base.BaseController;
import com.mycompany.newgyms.member.service.KakaoService;
import com.mycompany.newgyms.member.service.MemberService;
import com.mycompany.newgyms.member.vo.MemberVO;

@Controller("memberController")
@RequestMapping(value = "/member")
public class MemberControllerImpl extends BaseController implements MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberVO memberVO;
	@Autowired
	private KakaoService kakaoService;

	@Override
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, String> loginMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.login(loginMap);
		if (memberVO != null && memberVO.getMember_id() != null) {
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberVO);

			String action = (String) session.getAttribute("action");
			if (action != null && action.equals("/order/orderEachGoods.do")) {
				mav.setViewName("forward:" + action);
			} else {
				mav.setViewName("redirect:/main/main.do");
			}

		} else {
			String message = "아이디나 비밀번호가 틀립니다. 다시 로그인해주세요";
			mav.addObject("message", message);
			mav.setViewName("/member/loginForm");
		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		mav.setViewName("redirect:/main/main.do");
		return mav;
	}

	@Override
	@RequestMapping(value = "/joinCheck.do", method = RequestMethod.POST)
	public ModelAndView joinCheck(@RequestParam Map<String, String> joinCheckMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		memberVO = memberService.joinCheck(joinCheckMap);
		String member_name = request.getParameter("member_name");
		String member_rrn1 = request.getParameter("member_rrn1");
		String member_rrn2 = request.getParameter("member_rrn2");
		String join_type = request.getParameter("join_type");
		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("member_name", member_name);
		session.setAttribute("member_rrn1", member_rrn1);
		session.setAttribute("member_rrn2", member_rrn2);
		session.setAttribute("join_type", join_type);

		if (memberVO != null && memberVO.getMember_id() != null) {
			// 이미 만들어진 계정(아이디)가 있으면 알림 페이지로
			String member_id = memberVO.getMember_id();
			System.out.println(member_id);
			session.setAttribute("member_id", member_id);
			mav.setViewName("forward:/member/joinAlready.do");

		} else {
			// 중복 조회된 계정(아이디)가 없으면 회원가입 페이지로
			if (join_type.equals("101")) { // join_type 101 == 일반회원
				mav.setViewName("redirect:/member/joinMember.do");
			} else { // join_type 102 == 사업자 회원
				mav.setViewName("redirect:/member/joinOwner.do");
			}

		}
		return mav;
	}

	@Override
	@RequestMapping(value = "/joinMember.do", method = RequestMethod.POST)
	public ResponseEntity joinMember(@ModelAttribute("memberVO") MemberVO _memberVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			memberService.joinMember(_memberVO);
			message = "<script>";
			message += " alert('뉴짐스의 회원이 되신것을 환영합니다. :)');";
			message += " location.href='" + request.getContextPath() + "/member/loginForm.do';";
			message += " </script>";
		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath() + "/member/joinMember.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	@Override
	@RequestMapping(value = "/joinOwner.do", method = RequestMethod.POST)
	public ResponseEntity joinOwner(@ModelAttribute("memberVO") MemberVO _memberVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			memberService.joinOwner(_memberVO);
			message = "<script>";
			message += " alert('회원 가입을 마쳤습니다. 로그인창으로 이동합니다.');";
			message += " location.href='" + request.getContextPath() + "/member/loginForm.do';";
			message += " </script>";

		} catch (Exception e) {
			message = "<script>";
			message += " alert('작업 중 오류가 발생했습니다. 다시 시도해 주세요');";
			message += " location.href='" + request.getContextPath() + "/member/joinAdmin.do';";
			message += " </script>";
			e.printStackTrace();
		}
		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}

	@Override
	@RequestMapping(value = "/overlappedId.do", method = RequestMethod.POST)
	public ResponseEntity overlappedId(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ResponseEntity resEntity = null;
		String result = memberService.overlappedId(id);
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}

	@Override
	@RequestMapping(value = "/overlappedEid.do", method = RequestMethod.POST)
	public ResponseEntity overlappedEid(@RequestParam("eid") String eid, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ResponseEntity resEntity = null;
		String result = memberService.overlappedEid(eid);
		resEntity = new ResponseEntity(result, HttpStatus.OK);
		return resEntity;
	}

	@RequestMapping(value = "/kakaoLogin.do")
    public String kakaoLogin() {
        StringBuffer loginUrl = new StringBuffer();
        loginUrl.append("https://kauth.kakao.com/oauth/authorize?client_id=");
        loginUrl.append("46b3bd1331c738d34ac33651f62775f7"); 
        loginUrl.append("&redirect_uri=");
        loginUrl.append("http://localhost:8080/newgyms/member/kakaoJoin.do"); 
        loginUrl.append("&response_type=code");
        
        return "redirect:"+loginUrl.toString();
    }

	@RequestMapping(value = "/kakaoJoin.do", method = RequestMethod.GET)
    public String redirectKakao(@RequestParam String code, HttpSession session) throws Exception {
            System.out.println(code);
            
            //접속토큰 get
            String kakaoToken = kakaoService.getReturnAccessToken(code);
            System.out.println("kakaoToken : " + kakaoToken);
            
            //접속자 정보 get
            Map<String, Object> result = kakaoService.getUserInfo(kakaoToken);
            System.out.println("result: " + result);
            String member_id = (String) result.get("id");
            String member_name = (String) result.get("nickname");
            String email = (String) result.get("email");
            String member_pw = member_id;
            
            System.out.printf("member_id : " + member_id);
            System.out.printf("member_name : " + member_name);
            System.out.printf("email : " + email);
            System.out.printf("member_pw" + member_pw);
            
            // 분기
            MemberVO memberVO = new MemberVO();
            
            // 아이디 중복 확인, 없을 시 회원가입 진행
            if (memberService.overlappedId(member_id).equals("false")) {
                System.out.println("카카오 계정으로 회원가입");
                String email1 = email.substring(0, email.indexOf("@"));
                String email2 = email.substring(email.indexOf("@")+1);
                memberVO.setEmail1(email1);
                memberVO.setEmail2(email2);
                memberVO.setMember_id(member_id);
                memberVO.setMember_pw(member_pw);
                memberVO.setMember_name(member_name);
                memberVO.setJoin_type("101");
                memberService.kakaoJoin(memberVO);
                return "redirect:/member/kakaoLogin.do";
                
            } else {
                session.setAttribute("isLogOn", true);
    			session.setAttribute("memberInfo", memberVO);
            }
            
            session.setAttribute("kakaoToken", kakaoToken);
   
        return "redirect:/main/main.do";
    }
	
	@Override
	@RequestMapping(value="/searchid.do" ,method = RequestMethod.POST)
	public ModelAndView searchid(@RequestParam Map<String, String> searchidMap,
			                  HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO=memberService.searchid(searchidMap);
		if (memberVO != null) {
			String member_id = memberVO.getMember_id();
			String member_pw = memberVO.getMember_pw();
			session.setAttribute("member_id",member_id);
			session.setAttribute("member_pw",member_pw);
			mav.setViewName("forward:/member/foundidForm.do");
		} else {
			mav.setViewName("forward:/member/searchid1.do");			
		}
		return mav;
	}
	@Override
	@RequestMapping(value="/searchid1.do" ,method = RequestMethod.POST)
	public ModelAndView searchid1(@RequestParam Map<String, String> searchidMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(1);
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO=memberService.searchid1(searchidMap);
		if (memberVO != null) {
			String member_id = memberVO.getMember_id();
			session.setAttribute("member_id",member_id);
			mav.setViewName("forward:/member/foundidForm.do");		
		} else {
			String message="개같이 틀림";
			mav.addObject("member_id", message);
			mav.setViewName("forward:/member/foundidForm.do");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/searchpw.do" ,method = RequestMethod.POST)
	public ModelAndView searchpw(@RequestParam Map<String, String> searchpwMap,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		HttpSession session=request.getSession();
		memberVO=memberService.searchpw(searchpwMap);
		if (memberVO != null) {
			String member_id = memberVO.getMember_id();
			session.setAttribute("member_id",member_id);
			mav.setViewName("forward:/member/foundpwForm.do");
		} else {
			String message="어~~~안해주면 그만이야~~~";
			mav.addObject("message", message);
			mav.setViewName("forward:/member/searchpw.do");
		}
		return mav;
	}
	
	@Override
	@RequestMapping(value="/newpw.do" ,method = RequestMethod.POST)
	public ModelAndView newpw(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		/*
		String member_pw = searchpwMap.get("member_pw");
		String new_pw = searchpwMap.get("new_pw");
		*/
		String member_id = request.getParameter("member_id");
		String member_pw = request.getParameter("member_pw");
		String new_pw = request.getParameter("new_pw");
		
		Map searchpwMap = new HashMap();
		searchpwMap.put("member_id", member_id);
		searchpwMap.put("member_pw", member_pw);
		searchpwMap.put("new_pw", new_pw);
		if (member_pw == new_pw) {
			memberService.newpw(searchpwMap);
			/* mav.setViewName("forward:/member/login.do"); */
		} else {
			mav.setViewName("forward:/member/login.do");
		}
		return mav;
	}
	
	
}
