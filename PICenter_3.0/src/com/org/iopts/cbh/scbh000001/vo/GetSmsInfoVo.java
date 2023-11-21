package com.org.iopts.cbh.scbh000001.vo;

public class GetSmsInfoVo {
	
	// output parameter
	private String RETURN;	// 결과전송
	private String UUID;	// SMS 전송 키

	
	public String getRETURN() {
		return RETURN;
	}
	public void setRETURN(String rETURN) {
		RETURN = rETURN;
	}
	public String getUUID() {
		return UUID;
	}
	public void setUUID(String uUID) {
		UUID = uUID;
	}
	
	@Override
	public String toString() {
		return "GetCbhInfoVo [RETURN=" + RETURN + ", UUID=" + UUID + "]";
	}
}
