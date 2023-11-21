package com.org.iopts.report.vo;

public class ReportChunk {
	private int offset;
	private int length;
	
	private String matchCon;
	 
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getLength() {
		return length;
	}
	public void setLength(int length) {
		this.length = length;
	}
	public String getMatchCon() {
		return matchCon;
	}
	public void setMatchCon(String matchCon) {
		this.matchCon = matchCon;
	}
	@Override
	public String toString() {
		return "ReportChunk [offset=" + offset + ", length=" + length + ", matchCon=" + matchCon + "]";
	}
	
}
