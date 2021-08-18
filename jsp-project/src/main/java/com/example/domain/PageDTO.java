package com.example.domain;

import lombok.Data;

@Data
public class PageDTO {

	private final int PAGE_BLOCK = 5;

	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;

	private int totalCount;
	private Criteria cri;

	public PageDTO(Criteria cri, int totalCount) {
		this.cri = cri;
		this.totalCount = totalCount;

		endPage = (int) Math.ceil((double) cri.getPageNum() / PAGE_BLOCK) * PAGE_BLOCK;
		startPage = endPage - (PAGE_BLOCK - 1);
		
		// 실제 끝페이지가 PAGE_BLOCK 만큼 딱 안떨어질 때
		int realEnd = (int)Math.ceil((double)totalCount/cri.getAmount());
		
		if(realEnd < endPage) {
			endPage = realEnd;
		}
		
		prev = startPage > 1;
		next = endPage < realEnd;

	}

}
