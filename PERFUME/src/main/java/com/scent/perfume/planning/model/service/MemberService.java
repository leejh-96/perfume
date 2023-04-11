package com.scent.perfume.planning.model.service;

import com.scent.perfume.planning.model.vo.Member;

public interface MemberService {
	Member findMemberById(String id);

	Member login(String id, String password);

	int save(Member member);

	Boolean isDuplicateId(String id);

	int delete(int no);
}