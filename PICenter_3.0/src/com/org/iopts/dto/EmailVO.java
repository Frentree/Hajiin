package com.org.iopts.dto;

public class EmailVO {

	/*
	 * Mail ID
	 *  1: 결제 요청
	 *  2: 렬제반려
	 *  3: 걾제완료
	 *  4: 담당자 변경용청
	 *  5: 담당자 변경반려
	 *  6: 담당자 변경완료
	 *  7: 검색결과
	 *  8: 장기미조치
	 *  9: 미접속 에이전트 알림
	 */ 
	
	private String sendder;
	private String reciver;
	private String title_arg;
	private String contents="";
	
	public EmailVO(int mail_id) {
		if(mail_id==1) {
			title_arg="검색 결과 조치 예정 결재 요청 알림/문서번호 :";
		}else if(mail_id==2) {
			title_arg="검색 결과 조치 예정 결재 반려 알림/문서번호 :";
		}else if(mail_id==3) {
			title_arg="검색 결과 조치 예정 결재 완료 알림/문서번호 :";
		}else if(mail_id==4) {
			title_arg="담당자 변경 요청 알림/문서번호 :";
		}else if(mail_id==5) {
			title_arg="담당자 변경 반려 알림/문서번호 :";
		}else if(mail_id==6) {
			title_arg="담당자 변경 완료 알림/문서번호 :";			
		}else if(mail_id==7) {
			title_arg="담당 계정 개인정보 검출 알림";			
		}else if(mail_id==8) {
			title_arg="검색 결과 장기 미조치 알림";
		}else if(mail_id==9) {
			title_arg="미접속 에이전트 알림";
		}
	}
	

	public String getSendder() {
		return sendder;
	}
	public void setSendder(String sendder) {
		this.sendder = sendder;
	}
	public String getReciver() {
		return reciver;
	}
	public void setReciver(String reciver) {
		this.reciver = reciver;
	}
	public String getTitle_arg() {
		return title_arg;
	}
	public void setTitle_arg(String title_arg) {
		this.title_arg = title_arg;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	
}
