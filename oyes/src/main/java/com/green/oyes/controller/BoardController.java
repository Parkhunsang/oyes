package com.green.oyes.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import com.green.oyes.dto.Board;
import com.green.oyes.service.BoardService;
import com.green.oyes.service.PageBean;

import jakarta.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BoardController {
	@Autowired
	private BoardService bs;
	@GetMapping("/about/boardView")
	public void view(@RequestParam(value = "board_kind", defaultValue = "NOTICE") String board_kind,
			@RequestParam(value = "num",defaultValue = "0") int num,
			@RequestParam(value="pageNum",defaultValue="") String pageNum, Model model) {
		bs.updateReadcount(num); // 조회수 1증가
		Board board = bs.select(num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("board", board);
		model.addAttribute("board_kind", board_kind);
	}
	@GetMapping("/about/boardList") 
	public void boardList(@RequestParam(value = "board_kind", defaultValue = "NOTICE") String board_kind, // kind = press | notice
			@RequestParam(value="pageNum", defaultValue = "") String pageNum,
			@RequestParam(value = "search", defaultValue = "") String search,
			@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
		int rowPerPage = 10;
		if (pageNum == null || pageNum.equals("")) pageNum = "1";
		int currentPage = Integer.parseInt(pageNum);
		int total = bs.getTotal(board_kind, search, keyword);
		int startRow = (currentPage - 1) * rowPerPage;
		int num = total - startRow;
		List<Board> list = bs.list(board_kind, startRow, rowPerPage, search, keyword);
		PageBean pb = new PageBean(currentPage, rowPerPage, total);
		
		String[] title = {"제목","내용", "제목+내용"};
		String[] sh = {"board_title","board_content","subcon"};
		model.addAttribute("title", title);
		model.addAttribute("sh", sh);
		model.addAttribute("search", search);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pb", pb);		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("num", num);
		model.addAttribute("board_kind", board_kind);
		model.addAttribute("list", list);
		}
	@GetMapping("/about/boardInsertForm")
	public void boardInsertForm(@RequestParam(value = "board_kind", defaultValue = "NOTICE") String board_kind,
			@RequestParam(value = "num",defaultValue = "0") int num,
			@RequestParam(value="pageNum", defaultValue = "") String pageNum,
			HttpSession session, Model model) {
		model.addAttribute("num", num);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("board_kind", board_kind);
	}
	@PostMapping("/about/boardInsert")
	public void boardInsert(Board board, Model model,
			@RequestParam(value="pageNum",defaultValue="") String pageNum) {
		board.setPatient_no(10000000);
		int result = bs.insert(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}
	@GetMapping("/about/boardUpdateForm")
	public void updateForm(@RequestParam(value = "board_kind", defaultValue = "NOTICE") String board_kind,
			@RequestParam(value = "num",defaultValue = "0") int num,
			@RequestParam(value="pageNum",defaultValue="") String pageNum, Model model) {
		Board board = bs.select(num);
		model.addAttribute("board", board);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("board_kind", board_kind);
	}
	@PostMapping("/about/boardUpdate")
	public void boardUpdate(Board board, Model model,
			@RequestParam(value="pageNum",defaultValue="") String pageNum) {
		board.setPatient_no(10000000);
		int result = bs.update(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}
	@GetMapping("/about/boardDelete")
	public void delete(Board board,
			@RequestParam(value="pageNum",defaultValue="") String pageNum,Model model) {
		board.setPatient_no(10000000);
		int result = bs.delete(board);
		model.addAttribute("result", result);
		model.addAttribute("pageNum", pageNum);
	}
}
