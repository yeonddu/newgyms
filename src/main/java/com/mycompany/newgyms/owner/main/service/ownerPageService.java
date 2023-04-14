package com.mycompany.newgyms.owner.main.service;

import java.util.Map;

import com.mycompany.newgyms.member.vo.MemberVO;
import com.mycompany.newgyms.owner.main.vo.OwnerPageVO;

public interface ownerPageService {
	
	/* 사업장 소개/관리 페이지 */
	public OwnerPageVO ownerPageIntroView(String member_id) throws Exception;
	public MemberVO ownerPageIntroInfo(String member_id) throws Exception;
	
	/* 사업장 관리 수정 */
	public String ownerPageIntroModify(Map modifyMap) throws Exception;
	
	/* 사업자 회원정보 수정/탈퇴 */
	public MemberVO ownerPageDetail(Map ownerpageMap) throws Exception;
	public MemberVO modifyMyInfo(Map modifyMap) throws Exception;
	public void deleteMember(Map deleteMap) throws Exception;

	
}
