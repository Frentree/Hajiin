package com.org.iopts.setting.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.dto.MemberVO;

public interface Pi_SetService {
	
	public List<Map<Object, Object>> selectSetting() throws Exception;

	public List<Map<String, Object>> patternList(HttpServletRequest request) throws Exception;
}
