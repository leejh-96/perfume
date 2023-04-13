package com.scent.perfume.planning.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scent.perfume.planning.model.mapper.MemberMapper;
import com.scent.perfume.planning.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public Member findMemberById(String id) {
		
		return mapper.selectMemberById(id);
	}
	
	@Override
	public Member login(String id, String pwd) {
		Member member = null;
		
		member = this.findMemberById(id);
		
		if (member != null) {			
			return member;
		} else {
			return null;
		}
	}
}