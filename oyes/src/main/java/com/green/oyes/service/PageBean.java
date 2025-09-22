package com.green.oyes.service;
import lombok.Data;
@Data
public class PageBean {
	private int pagePerBlock = 3;
	private int currentPage;
	private int rowPerPage;
	private int total;
	private int totalPage;
	private int startPage;
	private int endPage;
	
	public PageBean(int currentPage, int rowPerPage, int total) {
		this.currentPage=currentPage; 
		this.rowPerPage=rowPerPage; this.total=total;
		// Math.ceil : 현재 실수보다 큰 정수중에서 가장 작은 정수 3.5 => 4,5,6,...중에서 4
		totalPage = (int)(Math.ceil((double)total/rowPerPage));
		startPage = currentPage-(currentPage-1)%pagePerBlock;
		endPage = startPage+pagePerBlock-1;
		// endPage 는 total 페이지보다 클수없다.
		if (endPage > totalPage) endPage = totalPage;
		if (currentPage > totalPage) {
		    currentPage = totalPage == 0 ? 1 : totalPage;
		}
	}

}
