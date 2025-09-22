package com.green.oyes.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.green.oyes.dto.DoctorSearch;
@Mapper
public interface DoctorSearchMapper {
	List<DoctorSearch> findByNameContaining(
	        @Param("keyword") String keyword,
	        @Param("limit") int limit
	    );
}
