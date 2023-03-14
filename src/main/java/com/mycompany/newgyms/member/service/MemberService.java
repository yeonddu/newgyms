package com.mycompany.newgyms.member.service;

import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;

public interface MemberService {
	public MemberVO login(Map  loginMap) throws Exception;
	public MemberVO joinCheck(Map joinCheckMap) throws Exception;
	public void joinMember(MemberVO memberVO) throws Exception;
	public void joinOwner(MemberVO memberVO) throws Exception;
	public String overlappedId(String id) throws Exception;
	public String overlappedEid(String eid) throws Exception;
	public void kakaoJoin(MemberVO memberVO) throws Exception;
	public void kakaoLogin(Map loginMap) throws Exception;
	public MemberVO searchid(Map  searchidMap) throws Exception;
	public MemberVO searchid1(Map  searchidMap) throws Exception;
	public MemberVO searchpw(Map  searchidMap) throws Exception;
	public void newpw(Map searchpwMap) throws Exception;
}
