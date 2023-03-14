package com.mycompany.newgyms.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.mycompany.newgyms.member.dao.MemberDAO;
import com.mycompany.newgyms.member.vo.MemberVO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public MemberVO login(Map  loginMap) throws Exception{
		return memberDAO.login(loginMap);
	}
	
	@Override
	public MemberVO joinCheck(Map joinCheckMap) throws Exception{
		return memberDAO.joinCheck(joinCheckMap);
	}
	
	@Override
	public void joinMember(MemberVO memberVO) throws Exception{
		memberDAO.insertNewMember(memberVO);
	}
	
	@Override
	public void joinOwner(MemberVO memberVO) throws Exception{
		memberDAO.insertNewOwner(memberVO);
	}
	
	@Override
	public String overlappedId(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}
	
	@Override
	public String overlappedEid(String eid) throws Exception{
		return memberDAO.selectOverlappedEID(eid);
	}
	
	@Override
	public void kakaoJoin(MemberVO memberVO) throws Exception{
		memberDAO.insertKakaoMember(memberVO);
	}
	
	@Override
	public void kakaoLogin(Map loginMap) throws Exception{
		memberDAO.kakaoLogin(loginMap);
	}
	
	@Override
	public MemberVO searchid(Map searchidMap) throws Exception{
		return memberDAO.searchid(searchidMap);
	}
	@Override
	public MemberVO searchpw(Map searchidMap) throws Exception{
		return memberDAO.searchpw(searchidMap);
	}
	@Override
	public MemberVO searchid1(Map searchidMap) throws Exception{
		return memberDAO.searchid1(searchidMap);
	}
	
	@Override
	public void newpw(Map searchpwMap) throws Exception{
		memberDAO.newpw(searchpwMap);
	}
}
