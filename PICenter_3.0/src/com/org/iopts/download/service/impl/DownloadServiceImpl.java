package com.org.iopts.download.service.impl;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.download.dao.DownloadDAO;
import com.org.iopts.download.service.DownloadService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class DownloadServiceImpl implements DownloadService{

	private static Logger logger = LoggerFactory.getLogger(DownloadServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private DownloadDAO dao;


	@Override
	public int selectDownloadIndex(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectDownloadIndex");
		
		return dao.selectDownloadIndex();
	}
	
	@Override
	public int insertDownload(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("insertDownload");
		String userNo = SessionUtil.getSession("memberSession", "USER_NO");
		map.put("user_no", userNo);
		
		dao.insertDownload(map);
		int result = -1;
		try {
			result = Integer.parseInt(map.get("NOTICE_FILE_ID").toString());
		} catch (Exception e) {
			logger.error(e.toString());
		}
		
		return result;
	}
	
	@Override
	public int selectFileDownloadIndex(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectFileDownloadIndex");
		
		return dao.selectFileDownloadIndex();
	}
	
	@Override
	public int insertFileDownload(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("insertFileDownload");
		String userNo = SessionUtil.getSession("memberSession", "USER_NO");
		map.put("user_no", userNo);
		
		dao.insertFileDownload(map);
		int result = -1;
		try {
			result = Integer.parseInt(map.get("DOWNLOAD_FILE_ID").toString());
		} catch (Exception e) {
			logger.error(e.toString());
		}
		
		return result;
	}
	
	

	
}
