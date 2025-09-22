package com.green.oyes.service;

import java.util.List;

import com.green.oyes.dto.Board;

public interface BoardService {
	int getTotal(String board_kind, String search, String keyword);
	List<Board> list(String board_kind, int startRow, int rowPerPage, String search, String keyword);
	Board select(int num);
	int insert(Board board);
	void updateReadcount(int num);
	int update(Board board);
	int delete(Board board);
}
