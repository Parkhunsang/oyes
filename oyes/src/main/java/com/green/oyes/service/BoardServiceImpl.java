package com.green.oyes.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.green.oyes.dto.Board;
import com.green.oyes.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService{
	@Autowired
	private BoardMapper bm;
	@Override
	public int getTotal(String board_kind, String search, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("board_kind", board_kind);
		map.put("search", search);
		map.put("keyword", keyword);
		return bm.getTotal(map);
	}
	@Override
	public List<Board> list(String board_kind, int startRow, int rowPerPage, String search, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("board_kind", board_kind);
		map.put("startRow", startRow);
		map.put("rowPerPage", rowPerPage);
		map.put("search", search);
		map.put("keyword", keyword);
		return bm.list(map);
	}
	@Override
	public Board select(int num) {
		return bm.select(num);
	}
	@Override
	public int insert(Board board) {
		return bm.insert(board);
	}
	@Override
	public void updateReadcount(int num) {
		bm.updateReadcount(num);
	}
	@Override
	public int update(Board board) {
		return bm.update(board);
	}
	@Override
	public int delete(Board board) {
		return bm.delete(board);
	}
}
