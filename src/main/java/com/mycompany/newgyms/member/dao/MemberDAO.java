package com.mycompany.newgyms.member.dao;

import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.mycompany.newgyms.member.vo.MemberVO;

public interface MemberDAO {
	public MemberVO login(Map loginMap) throws DataAccessException;
	public MemberVO joinCheck(Map joinCheckMap) throws DataAccessException;
	public void insertNewMember(MemberVO memberVO) throws DataAccessException;
	public void insertNewOwner(MemberVO memberVO) throws DataAccessException;
	public String selectOverlappedID(String id) throws DataAccessException;
	public String selectOverlappedEID(String eid) throws DataAccessException;
	public void insertKakaoMember(MemberVO memberVO) throws DataAccessException;
	public MemberVO kakaoLogin(Map loginMap) throws DataAccessException;
	public MemberVO searchid(Map searchidMap) throws DataAccessException;
	public MemberVO searchpw(Map searchidMap) throws DataAccessException;
	public MemberVO searchid1(Map searchidMap) throws DataAccessException;
	public void newpw(Map searchpwMap) throws DataAccessException;
}