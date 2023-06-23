package model2.mvcboard;

import dto.Criteria;

public class PageDto {

	int startNo; // 페이지블럭 시작번호
	int endNo; // 페이지블럭 끝번호
	int realEnd; // 진짜 페이지블럭 끝번호
	boolean prev, next; // 다음페이지 , 이전페이지
	
	int total; // 총게시물수
	Criteria cri = new Criteria(); // 페이지번호, 페이지 게시물수
	
	public PageDto() {
		// TODO Auto-generated constructor stub
	}

	// 페이지 
	public PageDto(int total, Criteria cri) {
		super();
		this.total = total;
		this.cri = cri;
		
		endNo = (int)Math.ceil(cri.getPageNo()/10.0)*10;
		startNo = endNo-(10-1);

		realEnd = (int)Math.ceil((total/1.0)/cri.getAmount());
		
		// 페이지 블럭의 끝번호를 설정
		// 게시물의 끝페이지보다 큰경우, 게시물의 끝페이지로 설정
		endNo = endNo>realEnd?realEnd:endNo;
		
		// 앞으로 이동/ 뒤로 이동 설정
		prev = startNo>1?true:false;
		next = endNo!=realEnd?true:false;
	}

	public int getStartNo() {
		return startNo;
	}

	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}

	public int getEndNo() {
		return endNo;
	}

	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public int getRealEnd() {
		return realEnd;
	}

	public void setRealEnd(int realEnd) {
		this.realEnd = realEnd;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Criteria getCri() {
		return cri;
	}

	public void setCri(Criteria cri) {
		this.cri = cri;
	}

}
