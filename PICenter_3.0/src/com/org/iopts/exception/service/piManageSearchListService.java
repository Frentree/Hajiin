package com.org.iopts.exception.service;

import java.util.HashMap;
import java.util.List;

public interface piManageSearchListService {
	
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws Exception;
	
	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params)  throws Exception;
	
}
