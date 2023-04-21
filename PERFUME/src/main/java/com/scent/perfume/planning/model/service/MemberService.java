package com.scent.perfume.planning.model.service;

import com.scent.perfume.planning.model.vo.Member;

public interface MemberService {
	Member findMemberById(String id);

	Member login(String id, String pwd);

	String findMemberByEmail(String userEmail);

	String getMailStatus(String id);
	
	String getPassword(String userName, String userId, String userEmail);

	String generateTempPassword();

	void updatePassword(String userId, String tempPassword);
}