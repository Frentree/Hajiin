package com.org.iopts.detection.service;

import java.util.HashMap;
import java.util.List;

public interface piChangeService {

	// 정탐/오탐 리스트 조회
	public List<HashMap<String, Object>> selectChangeList(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectPathChangeList(HashMap<String, Object> params) throws Exception;

	public void updateChangeApproval(HashMap<String, Object> params) throws Exception;
	
	public void updatePathChangeApproval(HashMap<String, Object> params) throws Exception;
}
