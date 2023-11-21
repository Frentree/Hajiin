package com.org.iopts.service;

import java.io.Reader;
import java.net.ProtocolException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.controller.ExceptionController;
import com.org.iopts.dao.Pi_ExceptionDAO;

import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_ExceptionServiceImpl implements Pi_ExceptionService {
	
	private static Logger logger = LoggerFactory.getLogger(Pi_ExceptionServiceImpl.class);

	@Inject
	private Pi_ExceptionDAO dao;
	
	@Override
	public List<Map<String, Object>> selectFindSubpath(HttpServletRequest request) throws Exception {
		
		String target_id = request.getParameter("target_id");
		String location = request.getParameter("location");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("target_id", target_id);
		map.put("location", location);
		
		logger.info("selectFindSubpath IMPL");

		List<Map<String, Object>>findMap = dao.selectFindSubpath(map);
		
		return findMap;
	}

	@Override
	@Transactional
	public void registException(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String reason = request.getParameter("reason");
		String ok_user_no = request.getParameter("ok_user_no");		
		String[] exceptionList = request.getParameterValues("exceptionList[]");

		for (int i = 0; i < exceptionList.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hash_id", exceptionList[i]);
			map.put("user_no", user_no);
			map.put("ok_user_no", ok_user_no);
			map.put("reason", reason);
			
			dao.registException(map);	
		}
	}

	@Override
	@Transactional
	public void deleteException(HttpServletRequest request) {

		String[] exceptionList = request.getParameterValues("exceptionList[]");

		for (int i = 0; i < exceptionList.length; i++) {
			dao.deleteException(exceptionList[i]);
		}
	}
	
	@Override
	@Transactional
	public void registDeletion(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String[] deletionList = request.getParameterValues("deletionList[]");

		for (int i = 0; i < deletionList.length; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hash_id", deletionList[i]);
			map.put("user_no", user_no);
			
			dao.registDeletion(map);	
		}
	}

	@Override
	public Map<String, Object> getMatchObjects(HttpServletRequest request, String api_ver) {

		String id = request.getParameter("id");
		String tid = request.getParameter("tid");
		logger.info("ap_no :: " + request.getParameter("ap_no"));
		int ap_no = Integer.parseInt(request.getParameter("ap_no"));
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> targetObject = new HashMap<String, Object>();
		Map<String, Object> daoMap = new HashMap<String, Object>();
		try {
			daoMap.put("id", id);
			daoMap.put("tid", tid);
			daoMap.put("ap_no", ap_no);
			targetObject = dao.getTargetByNode(daoMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		
		if (targetObject.isEmpty()) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "존재하지 않는 노드 ID");
			return resultMap;
			
		}
		String NodeID = (String) targetObject.get("INFO_ID");
		logger.info("NodeID : " + NodeID);
		String TargetID = (String) targetObject.get("TARGET_ID");
		logger.info("TargetID : " + TargetID);
		
		// 여기서 부터는 Recon server에서 데이터 받는
		//https://172.30.1.58:8339/beta/targets/15456464750237578083/matchobjects/1?details=true
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		
		try {
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			logger.info("getMatchObjects doc : " + "/" + api_ver + "/targets/" + TargetID + "/matchobjects/" + NodeID + "?details=true");
			
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/targets/" + TargetID + "/matchobjects/" + NodeID + "?details=true", "GET", null);
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		} catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}
		int resultCode = (int) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		if (resultCode != 200) {
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			return resultMap;
		}
		JSONObject jsonObject = JSONObject.fromObject(httpsResponse.get("HttpsResponseData"));
		logger.info("getMatchObjects jsonObject : " + jsonObject);
		resultMap.put("resultData", jsonObject);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> selectExceptionList(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("status", request.getParameter("status"));
		searchMap.put("target_id", request.getParameter("target_id"));
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		
		return dao.selectExceptionList(searchMap);
	}
	
	@Override
	public List<Map<String, Object>> selectDeletionList(HttpServletRequest request) throws Exception {

		Map<String, Object> searchMap = new HashMap<String, Object>();
		
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		searchMap.put("target_id", request.getParameter("target_id"));
		
		return dao.selectDeletionList(searchMap);
	}

	@Override
	@Transactional
	public void deleteDeletion(HttpServletRequest request) {

		String[] deletionList = request.getParameterValues("deletionList[]");

		for (int i = 0; i < deletionList.length; i++) {
			dao.deleteDeletion(deletionList[i]);
		}
	}

	@Override
	public List<Map<String, Object>> selectExceptionApprList(HttpServletRequest request) throws Exception {

		String ok_user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		Map<String, Object> searchMap = new HashMap<String, Object>();		
		searchMap.put("user_no", request.getParameter("user_no"));
		searchMap.put("target_id", request.getParameter("target_id"));
		searchMap.put("fromDate", request.getParameter("fromDate"));
		searchMap.put("toDate", request.getParameter("toDate"));
		searchMap.put("ok_user_no", ok_user_no);
		
		return dao.selectExceptionApprList(searchMap);
	}

	@Override
	@Transactional
	public void registExceptionAppr(HttpServletRequest request) {

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String apprType = request.getParameter("apprType");
		String[] exceptionApprList = request.getParameterValues("exceptionApprList[]");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_no", user_no);
		map.put("apprType", apprType);
		
		for (int i = 0; i < exceptionApprList.length; i++) {
			map.put("idx", exceptionApprList[i]);
			dao.registExceptionAppr(map);
		}  
	}

	@Override
	public List<Map<String, Object>> selectDownloadList(HashMap<String, Object> params, HashMap<String, Object> targetInfo) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		params.put("user_no", user_no);
		
		//logger.info(params.toString());
		//logger.info(targetInfo.toString());
		
		List<Map<String, Object>>findMap = dao.selectFindSubpath(params);
		if("Remote Access Only".equals(targetInfo.get("PLATFORM"))) {			// DB 데이터일 경우
			List<Map<String, Object>> resultMap = new ArrayList<>();
			
			for(int i=0; i<findMap.size(); i++) {
				String shortname = findMap.get(i).get("SHORTNAME").toString();
				String[] split_shortname = shortname.split("/");
//				log.info("["+i+"] :: " + findMap.get(i).get("SHORTNAME"));
//				log.info("["+i+"] split_shortname :: " + split_shortname.length);
				if(split_shortname.length <= 3 && "1".equals(findMap.get(i).get("LEVEL").toString())) {
					resultMap.add(findMap.get(i));
				}
			}
			
//			for(int i=0; i<resultMap.size(); i++) {
//				logger.info("resultMap["+i+"] :: " + resultMap.get(i).toString());
//			}
			
			if(resultMap.size() < findMap.size()) {
				for(int i=0; i<findMap.size(); i++) {
					String shortname = findMap.get(i).get("SHORTNAME").toString();
					String[] split_shortname = shortname.split("/");
					if(split_shortname.length > 3 && "1".equals(findMap.get(i).get("LEVEL").toString())) {		// LOB 컬럼이 있을경우
						//resultMap.add(findMap.get(i));
						String lob_shortname = split_shortname[0]+"/"+split_shortname[1]+"/"+split_shortname[2];
//						logger.info("find_shortname :: " + lob_shortname);
//						logger.info("shortname :: " + shortname);
						
						int lob_type1 = Integer.parseInt(findMap.get(i).get("TYPE1").toString());
						int lob_type2 = Integer.parseInt(findMap.get(i).get("TYPE2").toString());
						int lob_type3 = Integer.parseInt(findMap.get(i).get("TYPE3").toString());
						int lob_type4 = Integer.parseInt(findMap.get(i).get("TYPE4").toString());
						int lob_type5 = Integer.parseInt(findMap.get(i).get("TYPE5").toString());
						int lob_type6 = Integer.parseInt(findMap.get(i).get("TYPE6").toString());
						int lob_type = Integer.parseInt(findMap.get(i).get("TYPE").toString());
						
						for(int j=0; j<resultMap.size(); j++) {
							String result_shortname = resultMap.get(j).get("SHORTNAME").toString();
							if(result_shortname.equals(lob_shortname)) {
								int find_type1 = Integer.parseInt(resultMap.get(j).get("TYPE1").toString());
								int find_type2 = Integer.parseInt(resultMap.get(j).get("TYPE2").toString());
								int find_type3 = Integer.parseInt(resultMap.get(j).get("TYPE3").toString());
								int find_type4 = Integer.parseInt(resultMap.get(j).get("TYPE4").toString());
								int find_type5 = Integer.parseInt(resultMap.get(j).get("TYPE5").toString());
								int find_type6 = Integer.parseInt(resultMap.get(j).get("TYPE6").toString());
								int find_type = Integer.parseInt(resultMap.get(j).get("TYPE").toString());
								
								resultMap.get(j).put("TYPE1", find_type1+lob_type1);
								resultMap.get(j).put("TYPE2", find_type2+lob_type2);
								resultMap.get(j).put("TYPE3", find_type3+lob_type3);
								resultMap.get(j).put("TYPE4", find_type4+lob_type4);
								resultMap.get(j).put("TYPE5", find_type5+lob_type5);
								resultMap.get(j).put("TYPE6", find_type6+lob_type6);
								resultMap.get(j).put("TYPE"	, find_type+lob_type);
								
								break;
							}
						}
					}
				}
			}
			return resultMap;
		} else {
			
			return findMap;
		}
	}
}
