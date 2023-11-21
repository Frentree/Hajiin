package com.org.iopts.exception.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.dao.Pi_DetectionDAO;
import com.org.iopts.detection.dao.piApprovalDAO;
import com.org.iopts.detection.service.impl.piApprovalServiceImple;
import com.org.iopts.exception.dao.piManageSearchListDAO;
import com.org.iopts.exception.service.piManageSearchListService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class piManageSearchListServiceImple implements piManageSearchListService {

	private static Logger log = LoggerFactory.getLogger(piApprovalServiceImple.class);
	
	@Inject
	private piManageSearchListDAO dao;

	@Override
	public List<HashMap<String, Object>> searchProcessList(HashMap<String, Object> params) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);			// 사용자

		return dao.searchProcessList(params);
	}
	
	@Override
	public List<HashMap<String, Object>> selectProcessPath(HashMap<String, Object> params) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		return dao.selectProcessPath(params);
	}
	
}
