package com.green.oyes.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.green.oyes.dto.Board;

@Mapper
public interface BoardMapper {
	int getTotal(Map<String, Object> map);
	List<Board> list(Map<String, Object> map);
	Board select(int num);
	int insert(Board board);
	void updateReadcount(int num);
	int update(Board board);
	int delete(Board board);
}
