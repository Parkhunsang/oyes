package com.green.oyes.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Member;
@Mapper
public interface AdminMemberMapper {

	List<Member> select_all();

}