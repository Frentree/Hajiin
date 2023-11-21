package com.org.iopts.exception.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.detection.controller.piDetectionController;
import com.org.iopts.detection.dao.piDetectionDAO;
import com.org.iopts.exception.dao.piDetectionListDAO;
import com.org.iopts.exception.service.piDetectionListService;
import com.org.iopts.util.SessionUtil;

@Service
@Transactional
public class piDetectionListServiceImple implements piDetectionListService {

	private static Logger log = LoggerFactory.getLogger(piDetectionListServiceImple.class);

	@Inject
	private piDetectionListDAO dao;
	
	@Override
	public List<HashMap<String, Object>> selectFindSubpath(HashMap<String, Object> params) throws SQLException {
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no"  , user_no);
		String location = params.get("location").toString();
		location = location.replaceAll("\\\\", "\\\\\\\\");
		
		log.info("params >>>>>>>> " + params);
		
		
		String onedriveChk = params.get("onedriveChk").toString();
		String name = params.get("name").toString();
		String text = params.get("text").toString();
		
		params.put("onedriveChk", onedriveChk);
		params.put("location", location);
		params.put("name", name);
		params.put("text", text);
		
		
		try {
			// PICenter 에서 받아오는 개인정보 유형 갯수
			List<Integer> patternList = dao.queryCustomDataTypesCnt(); 
			params.put("patternList", patternList); 
			
		} catch(Exception e) {
			log.error(e.toString());
		}
		
		List<HashMap<String, Object>>findMap = dao.selectFindSubpath2(params);

		return findMap;
	}
	
	@Override
	public List<HashMap<String, Object>> selectDetectionApprovalList(HashMap<String, Object> params) throws SQLException {
		
		/*
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no"  , user_no);
		String location = params.get("location").toString();
		location = location.replaceAll("\\\\", "\\\\\\\\");
		params.put("location", location);
		*/	
		List<HashMap<String, Object>>findMap = dao.selectDetectionApprovalList(params);

		return findMap;
	}
	
	@Override
	public List<Map<String, Object>> getDetectionApprovalList(HttpServletRequest request) throws Exception {
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("user_no", user_no);
			map.put("user_grade", user_grade);
			map.put("idx", request.getParameter("idx"));
			map.put("selectList", request.getParameter("selectList"));
			map.put("schPath", request.getParameter("schPath"));
			
			resultList = dao.getDetectionApprovalList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
	}
	
	@Override
	public List<HashMap<String, Object>> subpathSelect(HashMap<String, Object> params) throws SQLException {
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no"  , user_no);

		List<HashMap<String, Object>>findMap = dao.subpathSelect(params);

		return findMap;
	}
	

	@Override
	public List<Map<String, Object>> selectUserTargetList(HttpServletRequest request) throws Exception {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		String host = request.getParameter("host");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		
		searchMap.put("user_no", user_no);
		searchMap.put("user_grade", user_grade);
		searchMap.put("host", host);
		map = dao.selectUserTargetList(searchMap);	
		return map;
	}

	@Override
	public HashMap<String, Object> selectProcessDocuNum(HashMap<String, Object> params) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);

		HashMap<String, Object> memberMap = dao.selectProcessDocuNum(params);

		return memberMap;
	}

	@Override
	public HashMap<String, Object> registProcessGroup(HashMap<String, Object> params) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");

		params.put("user_no", user_no);
		params.put("hash_id", deletionList.get(0));

		dao.registProcessGroup(params);

		return params;
	}

	@Override
	public void registProcess(HashMap<String, Object> params, HashMap<String, Object> groupMap) {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		List<String> deletionList = (List<String>)params.get("deletionList");

		for (int i = 0; i < deletionList.size(); i++) {
			params.put("user_no", user_no);
			params.put("hash_id", deletionList.get(i));
			params.put("data_processing_group_idx", groupMap.get("idx"));

			dao.registProcess(params);
		}
	}

	@Override
	public void cancelApproval(HashMap<String, Object> params) {
		List<String> deletionList = (List<String>)params.get("deletionList");
		for(int i=0; i<deletionList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("target_id", params.get("target_id"));
			map.put("hash_id", deletionList.get(i));
			String key = dao.selectIdx(map);
			map.put("key", key);
			
			log.info(map.toString());
			
			if(!"".equals(key) && key != null) {
				dao.deleteDataProcessing(map);
				int group_idx_cnt = dao.getCountProcessingGroup(map);
				if(group_idx_cnt < 1) {
					dao.deleteDataProcessingGroup(map);
				}
			}
			
			
		}
	}
	

	@Override
	public List<HashMap<String, Object>> personalApprovalData(HashMap<String, Object> params) throws SQLException {
		String idx = params.get("idx").toString();
		params.put("idx", idx);

		List<HashMap<String, Object>>findMap = dao.personalApprovalData(params);

		return findMap;
	}
	
	@Override
	public List<Map<String, Object>> queryCustomDataTypes() throws SQLException {

		List<Map<String, Object>> map = dao.queryCustomDataTypes();

		return map;
	}
	
	@Override
	public List<Map<String, Object>> queryMatchDetail() throws SQLException {
		
		List<Map<String, Object>> map = dao.queryMatchDetail();
		
		return map;
	}
	
}
