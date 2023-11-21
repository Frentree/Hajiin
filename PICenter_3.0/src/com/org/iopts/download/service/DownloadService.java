package com.org.iopts.download.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface DownloadService {
	// 최상위 결과
	int selectDownloadIndex(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	int insertDownload(Map<String, Object> map, HttpServletRequest request) throws Exception ;

	int selectFileDownloadIndex(Map<String, Object> map, HttpServletRequest request) throws Exception;

	int insertFileDownload(Map<String, Object> map, HttpServletRequest request) throws Exception;
}
