package com.org.iopts.report.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.report.dao.piReportExceptDAO;
import com.org.iopts.report.service.piReportExceptService;
import com.org.iopts.util.SessionUtil;

@Service("piReportExceptService")
@Transactional
public class piReportExceptServiceImple implements piReportExceptService {
	
	private static Logger log = LoggerFactory.getLogger(piReportExceptServiceImple.class);

	@Inject
	private piReportExceptDAO exceptionDao;

	@Override
	public List<HashMap<String, Object>> searchExceptionList(HashMap<String, Object> params) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);			// 사용자

		return exceptionDao.searchExceptionList(params);
	}
}