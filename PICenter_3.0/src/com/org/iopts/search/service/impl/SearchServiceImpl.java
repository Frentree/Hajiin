package com.org.iopts.search.service.impl;

import java.io.Reader;
import java.net.ProtocolException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.mapping.ResultMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.org.iopts.dao.Pi_UserDAO;
import com.org.iopts.exception.dao.piDetectionListDAO;
import com.org.iopts.search.dao.SearchDAO;
import com.org.iopts.search.service.SearchService;
import com.org.iopts.search.vo.DataTypeVo;
import com.org.iopts.service.Pi_ScanServiceImpl;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import scala.collection.generic.BitOperations.Int;

@Service
@Transactional
public class SearchServiceImpl implements SearchService{

	private static Logger logger = LoggerFactory.getLogger(SearchServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private SearchDAO searchDao;
	
	@Inject
	private Pi_UserDAO userDao;
	
	@Inject
	private piDetectionListDAO detectiondao;
	
	@Override
	public Map<String, Object> insertProfile(HttpServletRequest request) throws Exception {
		logger.info("insertProfile Service!");
		// 로그 기록
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String password = request.getParameter("password");
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		
		Map<String, Object> map = new HashMap<String,Object>();
		SimpleDateFormat format = new SimpleDateFormat ("yyMMdd");
		Date time = new Date();
		String timer = format.format(time);
		
		String datatype_name = request.getParameter("datatype_name");
		String std_id = "";
		
		String profileArr = request.getParameter("profileArr");
		String cntArr = request.getParameter("cntArr");
		String dupArr = request.getParameter("dupArr");
		logger.info("dupArr :: " + dupArr);
		
		String ocr = request.getParameter("ocr");
		String recent = request.getParameter("recent");
		String capture = request.getParameter("capture");
		
		String profile[] = profileArr.split(",");
		String profileCnt[] = cntArr.split(",");
		String profileDup[] = dupArr.split(",");
		
		int cnt = 0;
		int dup = 0;
		String expression = "";
		String expression_con = "";
		
		logger.info("profile >>> " + profileArr);
		
		JSONObject jObject = new JSONObject();
		JSONArray builtinsArr = new JSONArray();
		jObject.put("label", timer+"_"+user_no);
		jObject.put("builtins", builtinsArr);
		JSONArray datatypeArr = new JSONArray();
		
		List<Map<String, Object>> patternMap = detectiondao.queryCustomDataRules();
		
		JSONArray patternArr = new JSONArray();
		JSONObject patternObj = new JSONObject();
		
		for(int i = 0; i < profile.length; i++) {
			
			patternObj = new JSONObject();
			patternObj.put(profile[i], "1");
			
			JSONObject datatypeObject = new JSONObject();
			cnt = Integer.parseInt(profileCnt[i]);
			
			if(cnt < 1) {
				patternObj.put(profile[i]+"_CNT", 1);
				expression_con = "";
				
			}else {
				patternObj.put(profile[i]+"_CNT", cnt);
				expression_con = " POSTPROCESS \"MINIMUM " + cnt + "\"";
			}
			dup = Integer.parseInt(profileDup[i]);
			
			patternObj.put(profile[i]+"_DUP", dup);
			datatypeObject.put("disabled", false);

			logger.info("profile[i] >>> " + profile[i]);
			
			if(dup > 0) {
				expression_con += " POSTPROCESS \"UNIQUE\"";
			}else {
				expression_con += "";
			}
			
			for (Map<String, Object> pMap : patternMap) {
				if(profile[i].equals(pMap.get("ID"))) {
					
					patternObj.put("KR_NAMR", pMap.get("PATTERN_NAME"));
					patternArr.add(patternObj);
					datatypeObject.put("label", pMap.get("PATTERN_CODE"));
					expression = pMap.get("PATTERN_RULE").toString().replaceAll("\\\\n", "\n").replaceAll("%s", expression_con);
					
				}
			}
			
			datatypeObject.put("expression", expression);
			datatypeArr.add(datatypeObject);
			
		}
		
		jObject.put("custom_expressions", datatypeArr);
		
		jObject.put("ocr", ocr.equals("1") ? true : false);
		jObject.put("voice", false);
		jObject.put("ebcdic", false);
		jObject.put("suppress", true);
		jObject.put("capture", true);
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			int ap_count = Integer.parseInt((properties.getProperty("recon.count") == null) ? "0" : properties.getProperty("recon.count"));
			int success_count = 0;
			
			for(int i=0; i<ap_count; i++) {
				// 서버 Data Type Profiles 생성 시 증분검사 시기 정하기
				if(i == 0) {
					if("1".equals(recent)) {
						JSONArray arr = new JSONArray();
						JSONObject obj = new JSONObject();
						
						// 오늘날짜에서 6개월 전부터 1개월 후까지
						Calendar cal = new GregorianCalendar(Locale.KOREA);
					    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");

					    cal.setTime(new Date());
					    cal.add(Calendar.MONTH, -6);	     
					    String fromDate = fm.format(cal.getTime());
					    
					    cal.setTime(new Date());
					    cal.add(Calendar.MONTH, +1);
					    String toDate = fm.format(cal.getTime());
					    
						obj.put("type", "include_date_range");
						obj.put("from_date", fromDate);
						obj.put("to_date", toDate);
						arr.add(obj);
						jObject.put("filters", arr);
					}
				}else {
					if("1".equals(recent)) {
						JSONArray arr = new JSONArray();
						JSONObject obj = new JSONObject();
						
						obj.put("type", "include_recent");
						obj.put("days", 7);
						arr.add(obj);
						jObject.put("filters", arr);
					}
				}
				String data = jObject.toString();
				
				this.recon_url = (i == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (i+1)) ;
				this.recon_id = (i == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (i+1)) ;
				this.recon_password = (i == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (i+1)) ;
				this.api_ver = properties.getProperty("recon.api.version");
				httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/"+ this.api_ver + "/datatypes/profiles", "POST", data);
				
				String HttpsResponseDataMessage = "";
				try {
					HttpsResponseDataMessage = httpsResponse.get("HttpsResponseDataMessage").toString();
				}catch (NullPointerException e) {
					logger.error(e.toString());
				}
						
				logger.info("HttpsResponseDataMessage : " + HttpsResponseDataMessage);
				
				int resultCode = Integer.parseInt(httpsResponse.get("HttpsResponseCode").toString());
				logger.info("resultCode : " + resultCode);
				
				if(resultCode == 201) {
					JSONObject resultObject = JSONObject.fromObject(HttpsResponseDataMessage);
					logger.info("getMatchObjects jsonObject : " + resultObject);
					
					if(i == 0) {
						std_id = resultObject.get("id").toString();
					}
					map.put("datatype_id", resultObject.get("id"));
					map.put("datatype_label", datatype_name);
					map.put("create_user", user_no);
					map.put("ocr", ocr);
					map.put("recent", recent);
					map.put("capture", capture);
					map.put("std_id", std_id);
					map.put("ap_no", i);
					map.put("datatype", patternArr.toString());
					
					logger.info(map.toString());
					
					searchDao.insertProfile(map);
					
					userLog.put("user_no", user_no);
					userLog.put("menu_name", "DATATYPE REGIST");		
					userLog.put("user_ip", clientIP);
					userLog.put("job_info", "개인정보 유형 생성(성공) - " + datatype_name);
					userLog.put("logFlag", "2");
					
					userDao.insertLog(userLog);
				} else {
					userLog.put("user_no", user_no);
					userLog.put("menu_name", "DATATYPE REGIST");		
					userLog.put("user_ip", clientIP);
					userLog.put("job_info", "개인정보 유형 생성(실패) ap-"+(i+1));
					userLog.put("logFlag", "2");
					
					userDao.insertLog(userLog);
				}
				resultMap.put("resultCode", resultCode);
				resultMap.put("resultMessage", "Failed");
				
				
			}
			
		} catch (ProtocolException e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> getProfile(HttpServletRequest request) throws Exception {
		logger.info("getProfile Service!");
		String datatype_id = request.getParameter("datatype_id");
		String name = request.getParameter("name");
		
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("datatype_id", datatype_id);
		
		if(!"".equals(name) && name != null) {
			map.put("name", name);
		}
		List<Map<String, Object>> profileList = searchDao.getProfile(map);
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		List<String> keyList = new ArrayList<>();
		
		HashMap<String, Object> resultMap = new HashMap<>();
		Map<String, Object> dataTypeMap =  new HashMap<String, Object>();

		for (Map<String, Object> pMap : profileList) {
			resultMap = new HashMap<>();
			
			resultMap.put("OCR", pMap.get("OCR"));
			resultMap.put("STD_ID", pMap.get("STD_ID"));
			resultMap.put("RECENT", pMap.get("RECENT"));
			resultMap.put("CAPTURE", pMap.get("CAPTURE"));
			resultMap.put("CREATE_USER", pMap.get("CREATE_USER"));
			resultMap.put("DATATYPE_ID", pMap.get("DATATYPE_ID"));
			resultMap.put("DATATYPE_LABEL", pMap.get("DATATYPE_LABEL"));
			
			JSONArray dataType = JSONArray.fromObject(pMap.get("DATATYPE").toString());
			
			for(int j = 0 ; j < dataType.size() ; j++) {
				dataTypeMap =  new HashMap<String, Object>();
				keyList = new ArrayList<>();
				
				JSONObject dataTypeObject = dataType.getJSONObject(j);
				Iterator i = dataTypeObject.keys();
				
				while(i.hasNext())
			    {
			        String b = i.next().toString();
			        keyList.add(b); // 키 값 저장
			    }
				
				for(int k=0 ; k < keyList.size() ; k++) {
					resultMap.put(keyList.get(k), dataTypeObject.get(keyList.get(k)));
				}
			}
			resultList.add(resultMap);
			
		}
		
		return resultList;
	}

	@Override
	public Map<String, Object> updateProfile(HttpServletRequest request) throws Exception {
		logger.info("updateProfile Service!");
		
		// 로그 기록
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
		
		String datatype_id = (String) request.getParameter("datatype_id");
		String std_id = (String) request.getParameter("std_id");;
		
		Map<String, Object> map = new HashMap<String,Object>();
		SimpleDateFormat format = new SimpleDateFormat ("yyMMdd");
		Date time = new Date();
		String timer = format.format(time);
		
		String datatype_name = request.getParameter("datatype_name");
		
		String profileArr = request.getParameter("profileArr");
		String cntArr = request.getParameter("cntArr");
		String dupArr = request.getParameter("dupArr");
		int dbSize = searchDao.getDatatypesUserSize(std_id);
		logger.info("dbSize :: " + dbSize);
		
		String ocr = request.getParameter("ocr");
		String recent = request.getParameter("recent");
		String capture = request.getParameter("capture");
		
		String profile[] = profileArr.split(",");
		String profileCnt[] = cntArr.split(",");
		String profileDup[] = dupArr.split(",");
		
		int cnt = 0;
		int dup = 0;
		String expression = "";
		String expression_con = "";
		
		JSONObject jObject = new JSONObject();
		JSONArray builtinsArr = new JSONArray();
		jObject.put("label", timer+"_"+user_no);
		jObject.put("builtins", builtinsArr);
		JSONArray datatypeArr = new JSONArray();
		
		List<Map<String, Object>> patternMap = detectiondao.queryCustomDataRules();
		
		JSONArray patternArr = new JSONArray();
		JSONObject patternObj = new JSONObject();
		
		for(int i = 0; i < profile.length; i++) {
			
			patternObj = new JSONObject();
			patternObj.put(profile[i], "1");
			
			JSONObject datatypeObject = new JSONObject();
			cnt = Integer.parseInt(profileCnt[i]);
			
			if(cnt < 1) {
				patternObj.put(profile[i]+"_CNT", 1);
				expression_con = "";
				
			}else {
				patternObj.put(profile[i]+"_CNT", cnt);
				expression_con = " POSTPROCESS \"MINIMUM " + cnt + "\"";
			}
			dup = Integer.parseInt(profileDup[i]);
			
			patternObj.put(profile[i]+"_DUP", dup);
			datatypeObject.put("disabled", false);

			patternArr.add(patternObj);
			
			logger.info("profile[i] >>> " + profile[i]);
			
			if(dup > 0) {
				expression_con += " POSTPROCESS \"UNIQUE\"";
			}else {
				expression_con = "";
			}
			
			for (Map<String, Object> pMap : patternMap) {
				if(profile[i].equals(pMap.get("ID"))) {
					
					datatypeObject.put("label", pMap.get("PATTERN_CODE"));
					expression = pMap.get("PATTERN_RULE").toString().replaceAll("\\\\n", "\n").replaceAll("%s", expression_con);
					
				}
			}
			
			datatypeObject.put("expression", expression);
			datatypeArr.add(datatypeObject);
			
		}
		
		jObject.put("custom_expressions", datatypeArr);
		
		jObject.put("ocr", ocr.equals("1") ? true : false);
		jObject.put("voice", false);
		jObject.put("ebcdic", false);
		jObject.put("suppress", true);
		jObject.put("capture", true);
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		List<DataTypeVo> datatypeList = new ArrayList<>();
		int resultCode = 0;
		
		try {
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			int ap_count = Integer.parseInt((properties.getProperty("recon.count") == null) ? "0" : properties.getProperty("recon.count"));
			
			for(int i=0; i< ap_count; i++) {
				logger.info("ap count ===== " + i);
				
				// 서버 Data Type Profiles 생성 시 증분검사 시기 정하기
				if(i == 0) {
					if("1".equals(recent)) {
						JSONArray arr = new JSONArray();
						JSONObject obj = new JSONObject();
						
						// 오늘날짜에서 6개월 전부터 1개월 후까지
						Calendar cal = new GregorianCalendar(Locale.KOREA);
					    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");

					    cal.setTime(new Date());
					    cal.add(Calendar.MONTH, -6);	     
					    String fromDate = fm.format(cal.getTime());
					    
					    cal.setTime(new Date());
					    cal.add(Calendar.MONTH, +1);
					    String toDate = fm.format(cal.getTime());
					    
						obj.put("type", "include_date_range");
						obj.put("from_date", fromDate);
						obj.put("to_date", toDate);
						arr.add(obj);
						jObject.put("filters", arr);
					}
				}else {
					if("1".equals(recent)) {
						JSONArray arr = new JSONArray();
						JSONObject obj = new JSONObject();
						
						obj.put("type", "include_recent");
						obj.put("days", 7);
						arr.add(obj);
						jObject.put("filters", arr);
					}
				}
				String data = jObject.toString();
				
				this.recon_url = (i == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (i+1)) ;
				this.recon_id = (i == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (i+1)) ;
				this.recon_password = (i == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (i+1)) ;
				this.api_ver = properties.getProperty("recon.api.version");
				httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/"+ this.api_ver + "/datatypes/profiles", "POST", data);
				
				String HttpsResponseDataMessage = httpsResponse.get("HttpsResponseDataMessage").toString();
				logger.info("HttpsResponseDataMessage : " + HttpsResponseDataMessage);
				
				resultCode = Integer.parseInt(httpsResponse.get("HttpsResponseCode").toString());
				logger.info("resultCode : " + resultCode);
				
				if(resultCode == 201) {
					JSONObject resultObject = JSONObject.fromObject(HttpsResponseDataMessage);
					logger.info("getMatchObjects jsonObject : " + resultObject);
					
					datatype_id = resultObject.get("id").toString();
					
					datatypeList.add(new DataTypeVo(datatype_id, std_id, i, datatype_name, user_no, ocr, recent, capture));
					
				} 
			}
			
			if(datatypeList.size() == ap_count) {	// 개인정보 유형이 전체 추가 된경우
				logger.info("DataType Profile Complete DB Update Start!");
				
				for(int i=0; i< datatypeList.size(); i++) {
					map.put("datatype_id", datatypeList.get(i).getDatatype_id());
					map.put("std_id", datatypeList.get(i).getStd_id());
					map.put("ap_no", datatypeList.get(i).getAp_no());
					map.put("datatype_label", datatypeList.get(i).getDatatype_label());
					map.put("create_user", datatypeList.get(i).getCreate_user());
					map.put("ocr", datatypeList.get(i).getOcr());
					map.put("recent", datatypeList.get(i).getRecent());
					map.put("capture", datatypeList.get(i).getCapture());
					map.put("datatype", patternArr.toString());
					
					// 서버 Data Type Profiles 생성 시 증분검사 시기 정하기
					if(i == 0) {
						if("1".equals(recent)) {
							JSONArray arr = new JSONArray();
							JSONObject obj = new JSONObject();
							
							// 오늘날짜에서 6개월 전부터 1개월 후까지
							Calendar cal = new GregorianCalendar(Locale.KOREA);
						    SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");

						    cal.setTime(new Date());
						    cal.add(Calendar.MONTH, -6);	     
						    String fromDate = fm.format(cal.getTime());
						    
						    cal.setTime(new Date());
						    cal.add(Calendar.MONTH, +1);
						    String toDate = fm.format(cal.getTime());
						    
							obj.put("type", "include_date_range");
							obj.put("from_date", fromDate);
							obj.put("to_date", toDate);
							arr.add(obj);
							jObject.put("filters", arr);
						}
					}else {
						if("1".equals(recent)) {
							JSONArray arr = new JSONArray();
							JSONObject obj = new JSONObject();
							
							obj.put("type", "include_recent");
							obj.put("days", 7);
							arr.add(obj);
							jObject.put("filters", arr);
						}
					}
					String data = jObject.toString();
					
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/beta/datatypes/profiles", "POST", data);
					
					if(i < dbSize) { 	// 기존에 있던 ap 서버에 update
						searchDao.updateProfile(map);
					} else {		// 새로운 ap 서버에 insert
						searchDao.insertProfile(map);
					}
				}
				
				userLog.put("user_no", user_no);
				userLog.put("menu_name", "DATATYPE UPDATE");		
				userLog.put("user_ip", clientIP);
				userLog.put("job_info", "개인정보 유형 수정(성공) - " + datatype_name);
				userLog.put("logFlag", "2");
				
				userDao.insertLog(userLog);
				
				resultMap.put("resultCode", 201);
				resultMap.put("resultMessage", "SUCCESS");
					
			} else {
				userLog.put("user_no", user_no);
				userLog.put("menu_name", "DATATYPE UPDATE");		
				userLog.put("user_ip", clientIP);
				userLog.put("job_info", "개인정보 유형 수정(실패) - " + datatype_name);
				userLog.put("logFlag", "2");
				
				userDao.insertLog(userLog);
				
				resultMap.put("resultCode", resultCode);
				resultMap.put("resultMessage", "Failed");
			}
			/*
			// 기준이 되는 datatype_id 업데이트
			searchDao.updateStandardId(map);
			
			// 정책에 속해있는 datatype_id 업데이트
			searchDao.updateDatatypeInPolicy(map);*/
			
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			//return resultMap;
		} catch (Exception e) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
		}
		
		return resultMap;
		
	}

	@Override
	public Map<String, Object> deleteProfile(HttpServletRequest request) throws Exception {
		logger.info("resetDefaultPolicy request : " + request);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// 로그 기록
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String password = request.getParameter("password");
		
		// User Log 남기기
		Map<String, Object> userLog = new HashMap<String, Object>();
				
		String datatype_id = request.getParameter("datatype_id");
		String datatype_label = request.getParameter("datatype_label");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("DATATYPE_ID", datatype_id);
		
		Map<String, Object> dataTypeMap = searchDao.selectDataTypeById(map);
		List<Map<String, Object>> resultList = searchDao.getPolicy(map);
		
		if(dataTypeMap != null) {
			for (int i = 0; i < resultList.size() ; i++) {
				Map<String, Object> result = resultList.get(i);
				if(result.get("DATATYPE_ID").equals(dataTypeMap.get("datatype_id"))) {
					resultMap.put("resultCode", -9);
					resultMap.put("resultMessage", "Failed");
					return resultMap;
				}
			}
		}		
		searchDao.deleteProfile(map);
		
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "DATATYPE DELETE");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "개인정보 유형 삭제 - " + datatype_label);
		userLog.put("logFlag", "2");
		
		userDao.insertLog(userLog);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "삭제 됨");
		
		return resultMap;
		
	}

	@Override
	public List<Map<String, Object>> getPolicy(HttpServletRequest request) throws Exception {
		logger.info("getPolicy Service");

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		
		logger.info("name :: " + request.getParameter("name"));
		
		Map<String, Object> map = new HashMap<>();
		if(!"".equals(request.getParameter("name"))) {
			map.put("name", request.getParameter("name"));
		}
		
		String policyid =  request.getParameter("policyid");
		String scheduleUse =  request.getParameter("scheduleUse");
		map.put("policyid", policyid);
		map.put("schedule_use", scheduleUse);
		map.put("grade", grade);
		map.put("user_no", user_no);
		
		logger.info(scheduleUse);
		
		List<Map<String, Object>> patternMap = detectiondao.queryCustomDataTypes();
		map.put("patternMap", patternMap);
		
		resultList = searchDao.getPolicy(map);
		
		logger.info("resultList >>> " + resultList);
		for(int i=0; i<resultList.size(); i++) {
			Map<String, Object> result = resultList.get(i);
			
			if(result.get("PAUSE_DAYS") != null && !result.get("PAUSE_DAYS").equals("")) {
				int days = Integer.parseInt(result.get("PAUSE_DAYS").toString());
				
				String str_days = String.format("%07d", Integer.parseInt(Integer.toBinaryString(days)));
				String[] arr_days = str_days.split("");
				result.put("PAUSE_DAYS", arr_days);
				resultList.set(i, result);
			}
		}
		
		return resultList;
	}

	@Override
	public Map<String, Object> deletePolicy(HttpServletRequest request) throws Exception {
		logger.info("getPolicy Service");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		logger.info("idx :: " + request.getParameter("idx"));
		
		String datatype_id = request.getParameter("datatype_id");
		int idx = Integer.parseInt(request.getParameter("idx").toString());
		
		Map<String, Object> map = new HashMap<>();
		map.put("DATATYPE_ID", datatype_id);
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		resultList = searchDao.selectPCPolicy(map);
		for (int i = 0; i < resultList.size(); i++) {
			Map<String, Object> result = resultList.get(i);
			if(result.get("POLICY_ID").equals(idx)) {
				resultMap.put("resultCode", -9);
				resultMap.put("resultMessage", "Failed");
				return resultMap;
			}
		}
		
		if(!"".equals(request.getParameter("idx"))) {
			map.put("idx", request.getParameter("idx"));
			searchDao.deletePolicy(map);
		}
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "삭제 됨");
		
		return resultMap;
	}

	@Override
	public Map<String, Object> modifyPolicy(HttpServletRequest request) throws Exception {
		logger.info("getPolicy Service");
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("resultCode", -1);
		resultMap.put("resultMessage", "FAILED");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("idx", request.getParameter("idx"));
			map.put("policy_name", request.getParameter("policy_name"));
			map.put("comment", request.getParameter("comment"));
			map.put("start_dtm", request.getParameter("start_dtm"));
			map.put("cycle", request.getParameter("cycle"));
			map.put("action", request.getParameter("action"));
			map.put("datatype_id", request.getParameter("datatype_id"));
			map.put("std_id", request.getParameter("std_id"));
			map.put("enabled", request.getParameter("enabled"));
			map.put("from_time_hour", request.getParameter("from_time_hour"));
			map.put("from_time_minutes", request.getParameter("from_time_minutes"));
			map.put("to_time_hour", request.getParameter("to_time_hour"));
			map.put("to_time_minutes", request.getParameter("to_time_minutes"));
			map.put("pause_days", request.getParameter("pause_days"));
			map.put("user_no", request.getParameter("user"));
			map.put("policy_type", request.getParameter("policy_type"));
			
			searchDao.modifyPolicy(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, Object> insertPolicy(HttpServletRequest request) throws Exception {
		logger.info("insertPolicy Service");
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("resultCode", -1);
		resultMap.put("resultMessage", "FAILED");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("policy_name", request.getParameter("policy_name"));
			map.put("comment", request.getParameter("comment"));
			map.put("start_dtm", request.getParameter("start_dtm"));
			map.put("cycle", request.getParameter("cycle"));
			map.put("action", request.getParameter("action"));
			map.put("datatype_id", request.getParameter("datatype_id"));
			map.put("std_id", request.getParameter("std_id"));
			map.put("enabled", request.getParameter("enabled"));
			map.put("from_time_hour", request.getParameter("from_time_hour"));
			map.put("from_time_minutes", request.getParameter("from_time_minutes"));
			map.put("to_time_hour", request.getParameter("to_time_hour"));
			map.put("to_time_minutes", request.getParameter("to_time_minutes"));
			map.put("pause_days", request.getParameter("pause_days"));
			map.put("user_no", request.getParameter("user"));
			map.put("policy_type", request.getParameter("policy_type"));
			
			searchDao.insertPolicy(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public List<Map<String, Object>> getStatusList(HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		logger.info("insertPolicy Service");
		
		logger.info("sch_group :: " + request.getParameter("sch_group"));
		logger.info("sch_host :: " + request.getParameter("sch_host"));
		logger.info("sch_svcName :: " + request.getParameter("sch_svcName"));
		logger.info("sch_svcManager :: " + request.getParameter("sch_svcManager"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("sch_group", request.getParameter("sch_group"));
			map.put("sch_host", request.getParameter("sch_host"));
			map.put("sch_svcName", request.getParameter("sch_svcName"));
			map.put("sch_svcManager", request.getParameter("sch_svcManager"));
			map.put("user_no", user_no);
			map.put("user_grade", user_grade);
			
			resultList = searchDao.getStatusList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultList;
	}
	
	@Override
	public List<Map<String, Object>> getUserList(HttpServletRequest request) throws Exception {
		logger.info("insertPolicy Service");
		
		logger.info("sch_aut :: " + request.getParameter("sch_aut"));
		logger.info("sch_id :: " + request.getParameter("sch_id"));
		logger.info("sch_userName :: " + request.getParameter("sch_userName"));
		logger.info("sch_teamName :: " + request.getParameter("sch_teamName"));
		logger.info("sch_userLeave :: " + request.getParameter("sch_userLeave"));
		logger.info("sch_lockStatus :: " + request.getParameter("sch_lockStatus"));
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		try {
			
			Map<String, Object> map = new HashMap<>();
			map.put("sch_aut", request.getParameter("sch_aut"));
			map.put("sch_id", request.getParameter("sch_id"));
			map.put("sch_userName", request.getParameter("sch_userName"));
			map.put("sch_teamName", request.getParameter("sch_teamName"));
			map.put("sch_userLeave", request.getParameter("sch_userLeave"));
			map.put("sch_lockStatus", request.getParameter("sch_lockStatus"));
			
			resultList = searchDao.getUserList(map);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		/*resultMap.put("resultCode", -1);
		resultMap.put("resultMessage", "FAILED");
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("policy_name", request.getParameter("policy_name"));
			map.put("comment", request.getParameter("comment"));
			map.put("start_dtm", request.getParameter("start_dtm"));
			map.put("cycle", request.getParameter("cycle"));
			map.put("datatype_id", request.getParameter("datatype_id"));
			map.put("enabled", request.getParameter("enabled"));
			
			//searchDao.insertPolicy(map);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
			
		} catch (Exception e) {
			e.printStackTrace();
		}*/
		return resultList;
	}

	@Override
	public Map<String, Object> registSchedule(HttpServletRequest request, String api_ver) throws Exception {
		logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules");
//		String scheduleData = request.getParameter("scheduleData");

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String type = request.getParameter("type");
		String scheduleName = request.getParameter("schedule_name");
		String policyID = request.getParameter("policy_id");
		String datatypeID = request.getParameter("datatype_id");
		String std_id = request.getParameter("std_id");
		String action = request.getParameter("action");
		
		int group_key = -1;
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		JsonParser parser = new JsonParser();
		JsonArray dataArr = (JsonArray) parser.parse(request.getParameter("scheduleArr"));
		logger.info("size :: " + dataArr.size());
		
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("user_no", user_no);
		map.put("scheduleName", scheduleName);
		map.put("policy_id", policyID);
		map.put("datatype_id", datatypeID);
		map.put("std_id", std_id);
		

		searchDao.insertScheduleGroup(map);
		group_key = (int) map.get("SCHEDULE_GROUP_ID");
		map.put("groupID", group_key);
		
		int count = 0;
		
		for(int i=0; i<dataArr.size(); i++) {
			/*logger.info(dataArr.get(i).toString());*/
			
			logger.info(dataArr.toString());
			
			JsonObject obj = (JsonObject) dataArr.get(i);
			int ap_no = Integer.parseInt(obj.get("ap_no").toString());
			String scheduleData = obj.get("scheduleData").toString();
			
			String target_id = obj.get("target_id").getAsString();
			String location_id = obj.get("location_id").getAsString();
			String drm = "";
			
			map.put("target_id", target_id);
			map.put("location_id", location_id);
			map.put("ap_no", ap_no);
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			Map<String, Object> httpsResponse = null;
			
			if(ap_no != 0) {	// PC일 경우, 기존 스캔 기동중인 항목 취소 처리
				logger.info("Previous Schedule Delete !");
				
				String schedule_id = "";
				
				List<Map<String, Object>> scheduleList = searchDao.selectSchedulePCStatus(map);
				
				for(int j = 0; j < scheduleList.size(); j++ ) {	// schedule, paused, scanning 상태 인 항목 정지
					schedule_id = scheduleList.get(j).get("SCHEDULE_ID").toString();
							
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/schedules/" + schedule_id + "/cancel", "POST", null);
			     	updateScanschedule(reconUtil, recon_url, recon_id, recon_password, 0, schedule_id, drm);
				}
			}
			
			
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url+"/"+api_ver+"/schedules", "POST", scheduleData);
			
			int resultCode = (int) httpsResponse.get("HttpsResponseCode");
			String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
			
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			
			Map<String, Object> userLog = new HashMap<String, Object>();
			
			logger.info("requestMsg >> " + resultMessage);
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "SCHEDULE REGIST");
			userLog.put("user_ip", clientIP);
			//userLog.put("job_info", "스캔 등록");
			userLog.put("logFlag", "1");
			
			if(resultCode == 201) {
				count ++;
				userLog.put("job_info", "스캔 등록 성공");
				map.put("type", type);
				map.put("user_no", user_no);
				map.put("scheduleName", scheduleName);
				map.put("policy_id", policyID);
				map.put("datatype_id", datatypeID);
				map.put("std_id", std_id);
				map.put("action", action);
				JsonElement element = parser.parse(httpsResponse.get("HttpsResponseDataMessage").toString());
				JsonObject object = element.getAsJsonObject();
				
				String schedule_id = object.get("id").getAsString();
				map.put("reconScheduleID", schedule_id);
				// 스케줄 그룹 등록
				logger.info("mpa :: " + map);
				
				// 스케줄 타겟 등록
				searchDao.insertScheduleTargets(map);
				
				// 스캔 등록 성공 시 스케줄 리스트 업데이트
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, schedule_id, drm);
			} else if (resultCode == 409) {
				userLog.put("job_info", "스캔 등록 실패 - 스케줄명 중복");
			} else if (resultCode == 422) {
				userLog.put("job_info", "스캔 등록 실패 - 시작시간 오류");
			} else {
				userLog.put("job_info", "스캔 등록 실패 - " + resultCode);
			}
			
			userDao.insertLog(userLog);
		}
		
		if(count == 0) {
			searchDao.failedSchedule(map);
		}
		
		return resultMap;
	}
	

	@Override
	public Map<String, Object> registPCSchedule(HttpServletRequest request, String api_ver) throws Exception {
		logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules");
//		String scheduleData = request.getParameter("scheduleData");

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String type = request.getParameter("type");
		String scheduleName = request.getParameter("schedule_name");
		String net_type = request.getParameter("net_type");
		String policyID = "";
		String datatypeID = "";
		String std_id = "";
		String action = "";
		String drm = null;
		String trace = "";
/*		String policyID = request.getParameter("policy_id");
		String datatypeID = request.getParameter("datatype_id");
		String std_id = request.getParameter("std_id");
		String action = request.getParameter("action");
*/		
		int group_key = -1;
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		JsonParser parser = new JsonParser();
		JsonArray scheduleArr = (JsonArray) parser.parse(request.getParameter("scheduleArr"));
		logger.info("size :: " + scheduleArr.size());
		JsonArray dataArr = (JsonArray) parser.parse(request.getParameter("dataArr"));
		
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("user_no", user_no);
		map.put("scheduleName", scheduleName);
		map.put("policy_id", -1);
		map.put("datatype_id", -1);
		map.put("std_id", -1);
		
		logger.info("drequest.getParameter(\"dataArr\")>>>" + request.getParameter("dataArr"));
		if(net_type.equals("3")) { // OneDrive 검색 실행일 경우
			searchDao.insertScheduleGroupOneDrive(map);
		}else {
			searchDao.insertScheduleGroup(map);
		}
		group_key = (int) map.get("SCHEDULE_GROUP_ID");
		map.put("groupID", group_key);
		
		int count = 0;
		
		for(int i=0; i<scheduleArr.size(); i++) {
			/*logger.info(dataArr.get(i).toString());*/
			
			logger.info(scheduleArr.toString());
			JsonObject obj = (JsonObject) scheduleArr.get(i);
			
			JsonObject dataObj = (JsonObject) dataArr.get(i);
			logger.info("dataObj.toString() >>>" + dataObj.toString());
			
			policyID = dataObj.get("policy_id").toString();
			datatypeID = dataObj.get("datatype_id").getAsString();
			std_id = dataObj.get("std_id").getAsString();
			action = dataObj.get("action").toString();
			
			if(dataObj.get("drm_status").getAsString().equals("NONE")) {
				drm = null;
			}else {
				drm = dataObj.get("drm_status").getAsString(); 
			}
			
			int ap_no = Integer.parseInt(obj.get("ap_no").toString());
			String scheduleData = obj.get("scheduleData").toString();
			
			String target_id = obj.get("target_id").getAsString();
			String location_id = obj.get("location_id").getAsString();

			map.put("target_id", target_id);
			map.put("location_id", location_id);
			map.put("ap_no", ap_no);
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			Map<String, Object> httpsResponse = null;
			
			/*if(ap_no != 0) {	// PC일 경우, 기존 스캔 기동중인 항목 취소 처리
				logger.info("Previous Schedule Delete !");
				
				String schedule_id = "";
				
				List<Map<String, Object>> scheduleList = searchDao.selectSchedulePCStatus(map);
				
				for(int j = 0; j < scheduleList.size(); j++ ) {	// schedule, paused, scanning 상태 인 항목 정지
					schedule_id = scheduleList.get(j).get("SCHEDULE_ID").toString();
							
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/schedules/" + schedule_id + "/cancel", "POST", null);
			     	updateScanschedule(reconUtil, recon_url, recon_id, recon_password, 0, schedule_id);
				}
			}*/
			
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url+"/"+api_ver+"/schedules", "POST", scheduleData);
			
			int resultCode = (int) httpsResponse.get("HttpsResponseCode");
			String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
			
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			
			Map<String, Object> userLog = new HashMap<String, Object>();
			
			logger.info("requestMsg >> " + resultMessage);
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "SCHEDULE REGIST");
			userLog.put("user_ip", clientIP);
			//userLog.put("job_info", "스캔 등록");
			userLog.put("logFlag", "1");
			
			if(resultCode == 201) {
				count ++;
				userLog.put("job_info", "스캔 등록 성공");
				map.put("type", type);
				map.put("user_no", user_no);
				map.put("scheduleName", scheduleName);
				map.put("policy_id", policyID);
				map.put("std_id", std_id);
				map.put("action", action);
				map.put("drm", drm);
				
				JsonElement element = parser.parse(httpsResponse.get("HttpsResponseDataMessage").toString());
				JsonObject object = element.getAsJsonObject();
				
				String schedule_id = object.get("id").getAsString();
				map.put("datatype_id", datatypeID);
				map.put("reconScheduleID", schedule_id);
				// 스케줄 그룹 등록
				logger.info("mpa :: " + map);
				
				// 스케줄 타겟 등록
				searchDao.insertScheduleTargets(map);
				
				// 스캔 등록 성공 시 스케줄 리스트 업데이트
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, schedule_id, drm);
			} else if (resultCode == 409) {
				userLog.put("job_info", "스캔 등록 실패 - 스케줄명 중복");
			} else if (resultCode == 422) {
				userLog.put("job_info", "스캔 등록 실패 - 시작시간 오류");
			} else {
				userLog.put("job_info", "스캔 등록 실패 - " + resultCode);
			}
			
			userDao.insertLog(userLog);
		}
		
		if(count == 0) {
			searchDao.failedSchedule(map);
		}
		
		return resultMap;
	}
	
	private void updateScanschedule(ReconUtil reconUtil, String recon_url, String recon_id, String recon_password, int ap_no,String schedule_id, String drm) throws Exception {
		logger.info("updateScanSchedule");
		String start_date = "";
		String end_date = "";

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -1);
		start_date = sdf.format(cal.getTime());
		cal.add(Calendar.YEAR, 1);
		end_date = sdf.format(cal.getTime());	
		
		try {
			String url =  String.format("%s/%s/schedules/%s?details=true&completed=true&cancelled=true&stopped=true&failed=true&deactivated=true&pending=true&start_date=%s&limit=5000000&end_date=%s'",
					recon_url, api_ver,schedule_id, start_date, end_date);
			logger.info("url :: " + url);
			
			Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id, recon_password, url, "GET", "");
			
			JsonParser parser = new JsonParser();
			
			//JsonArray arr = (JsonArray) parser.parse(httpsResponse.get("HttpsResponseData").toString());
			
			JsonObject obj = (JsonObject) parser.parse(httpsResponse.get("HttpsResponseData").toString());
			
			Map<String, Object> map = new HashMap<>();
			map.put("id", obj.get("id").toString().replaceAll("\"", ""));
			map.put("label", obj.get("label").toString().replaceAll("\"", ""));
			map.put("status", obj.get("status").toString().replaceAll("\"", ""));
			map.put("repeat_days", obj.get("repeat_days").toString().replaceAll("\"", ""));
			map.put("repeat_months", obj.get("repeat_months").toString().replaceAll("\"", ""));
			map.put("next_scan", obj.get("next_scan").toString().replaceAll("\"", ""));
			map.put("cpu", obj.get("cpu").toString().replaceAll("\"", ""));
			map.put("capture", obj.get("capture").toString().replaceAll("\"", ""));
			map.put("trace", obj.get("trace").toString().replaceAll("\"", ""));
			map.put("ap_no", ap_no);
			
			logger.info("obj >>> " + obj);
			
			JsonArray pro_arr = (JsonArray) obj.get("profiles");
			String profiles = "";
			for(int pi=0; pi<pro_arr.size(); pi++) {
				profiles += pro_arr.get(pi).toString().replaceAll("\"", "");
				
				if(pi < (pro_arr.size()-1)) {
					profiles += ",";
				}
			}
			map.put("profiles", profiles);
			
			logger.info(obj.toString());
			logger.info("obj test :: " + obj.has("pause"));
			if(obj.has("pause")) {
				JsonArray pause_arr = (JsonArray) obj.get("pause");
				for(int pausei=0; pausei<pause_arr.size(); pausei++) {
					JsonObject pause_obj = (JsonObject) pause_arr.get(pausei);
					//{"days":62,"from":28800,"to":72000}
					
					map.put("pause_days", pause_obj.get("days").toString().replaceAll("\"", ""));
					map.put("pause_from", pause_obj.get("from").toString().replaceAll("\"", ""));
					map.put("pause_to", pause_obj.get("to").toString().replaceAll("\"", ""));
				}
			}
			
			JsonArray t_arr = (JsonArray) obj.get("targets");
			String target_id = "";
			String target_name = "";
			for(int ti=0; ti<t_arr.size(); ti++) {
				JsonObject t_obj = (JsonObject) t_arr.get(ti);
				target_id += t_obj.get("id").toString().replaceAll("\"", "");
				target_name += t_obj.get("name").toString().replaceAll("\"", "");
				if(ti < (t_arr.size()-1)) {
					target_id += ",";
					target_name += ",";
				}
			}
			map.put("target_id", target_id);
			map.put("target_name", target_name);
			
			if(drm !="" && drm != null) {
				map.put("drm", drm);
			}else {
				map.put("drm", null);
			}

			logger.info("map :: " + map.toString());
			searchDao.updateScanSchedule(map);
			
			/*for(int i=0; i<arr.size(); i++) {
				JsonObject obj = (JsonObject) arr.get(i);
				
				Map<String, Object> map = new HashMap<>();
				map.put("id", obj.get("id").toString().replaceAll("\"", ""));
				map.put("label", obj.get("label").toString().replaceAll("\"", ""));
				map.put("status", obj.get("status").toString().replaceAll("\"", ""));
				map.put("repeat_days", obj.get("repeat_days").toString().replaceAll("\"", ""));
				map.put("repeat_months", obj.get("repeat_months").toString().replaceAll("\"", ""));
				map.put("next_scan", obj.get("next_scan").toString().replaceAll("\"", ""));
				map.put("cpu", obj.get("cpu").toString().replaceAll("\"", ""));
				map.put("capture", obj.get("capture").toString().replaceAll("\"", ""));
				map.put("trace", obj.get("trace").toString().replaceAll("\"", ""));
				map.put("ap_no", ap_no);
				
				JsonArray pro_arr = (JsonArray) obj.get("profiles");
				String profiles = "";
				for(int pi=0; pi<pro_arr.size(); pi++) {
					profiles += pro_arr.get(pi).toString().replaceAll("\"", "");
					
					if(pi < (pro_arr.size()-1)) {
						profiles += ",";
					}
				}
				map.put("profiles", profiles);
				
				logger.info(obj.toString());
				logger.info("obj test :: " + obj.has("pause"));
				if(obj.has("pause")) {
					JsonArray pause_arr = (JsonArray) obj.get("pause");
					for(int pausei=0; pausei<pause_arr.size(); pausei++) {
						JsonObject pause_obj = (JsonObject) pause_arr.get(pausei);
						//{"days":62,"from":28800,"to":72000}
						
						map.put("pause_days", pause_obj.get("days").toString().replaceAll("\"", ""));
						map.put("pause_from", pause_obj.get("from").toString().replaceAll("\"", ""));
						map.put("pause_to", pause_obj.get("to").toString().replaceAll("\"", ""));
					}
				}
				
				JsonArray t_arr = (JsonArray) obj.get("targets");
				String target_id = "";
				String target_name = "";
				for(int ti=0; ti<t_arr.size(); ti++) {
					JsonObject t_obj = (JsonObject) t_arr.get(ti);
					target_id += t_obj.get("id").toString().replaceAll("\"", "");
					target_name += t_obj.get("name").toString().replaceAll("\"", "");
					if(ti < (t_arr.size()-1)) {
						target_id += ",";
						target_name += ",";
					}
				}
				map.put("target_id", target_id);
				map.put("target_name", target_name);

				logger.info("map :: " + map.toString());
				searchDao.updateScanSchedule(map);
			}*/
			
			logger.info(httpsResponse.toString());
		} catch (ProtocolException e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public List<Map<String, Object>> registScheduleGroup(HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		
		Map<String, Object> map = new HashMap<>();
		String title = request.getParameter("title");
		String writer = request.getParameter("writer");
		String sch_type = request.getParameter("sch_type");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		map.put("title", title);
		map.put("writer", writer);
		map.put("sch_type", sch_type);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		
		return searchDao.selectScheduleGroup(map);
	}
	
	@Override
	public List<Map<String, Object>> registScheduleTargets(HttpServletRequest request) throws Exception {
		String group_id = request.getParameter("group_id");
		Map<String, Object> map = new HashMap<>();
		int ap_no = 0;
		String id = "";
		String drm = "";
		ReconUtil reconUtil = new ReconUtil();

		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		Map<String, Object> httpsResponse = null;
		
		map.put("group_id", group_id);
		List<Map<String,Object>> scheduleList = searchDao.selectScheduleTargets(map);

		for (Map<String, Object> item : scheduleList) {
			String status = (String) item.get("SCHEDULE_STATUS");
			
			if(status.equals("cancelled") || status.equals("completed") || status.equals("failed")) {
				continue;
			}
			
			ap_no = Integer.parseInt(item.get("AP_NO").toString());
			id = (String) item.get("RECON_SCHEDULE_ID");
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			try {
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, id, drm);
			}catch (Exception e) {
				
			}
		}
		
		return searchDao.selectScheduleTargets(map);
	}
	

	@Override
	public Map<String, Object> changeSchedule(HttpServletRequest request, String api_ver) throws Exception {

		//https://172.30.1.58:8339/beta/schedules/98/Action
		String id = request.getParameter("id");
		String task = request.getParameter("task");
		int ap_no = Integer.parseInt(request.getParameter("ap_no"));
		String target_id = request.getParameter("target_id");
		
		logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules/" + id + "/" + task +", Ap_no : " + ap_no);
		
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
		String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
		String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/schedules/" + id + "/" + task, "POST", null);
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", e.getMessage());
			return resultMap;
		}

		int resultCode = (int) httpsResponse.get("HttpsResponseCode");
		String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
		String drm = "";
		
		if ((resultCode != 200) && (resultCode != 204)) {
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			return resultMap;
		}
		// 작업변경이 성공하면 DB도 변경 해 준다.
     	String changedTask = "scheduled";
     	switch (task) {
     	case "deactivate" :
     		changedTask = "deactivated";
     		break;
     	case "skip" :
     		changedTask = "scheduled";
     		break;
     	case "pause" :
     		changedTask = "pause";
     		break;
     	case "restart" :
     		changedTask = "scheduled";
     		break;
     	case "stop" :
     		changedTask = "stopped";
     		break;
     	case "cancel" :
     		changedTask = "cancelled";
     		break;
     	case "reactivate" :
     		changedTask = "scheduled";
     		break;
 		default :
     		changedTask = "scheduled";
 		break;
     	}
     	
     	updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, id, drm);
  	
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		// DB 업데이트
		Map<String, Object> scheduleMap = new HashMap<String, Object>();
		scheduleMap.put("changedTask", changedTask);
		scheduleMap.put("id", id);
		scheduleMap.put("ap_no", ap_no);
		
		searchDao.updateScheduleStatus(scheduleMap);
		
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "SCHEDULE CHANGE");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "스캔 상태 변경 > " + changedTask + "[" + changedTask + "]");
		userLog.put("logFlag", "1");

		userDao.insertLog(userLog);
		
		return resultMap;
	}


	@Override
	public Map<String, Object> changeScheduleAll(List<String> taskList, HttpServletRequest request, String api_ver) throws Exception {

		//https://172.30.1.58:8339/beta/schedules/98/Action
		String groupid = request.getParameter("groupid");
		String task = request.getParameter("task");
		String id = "";
		String drm = "";
		int ap_no = 0;
		ReconUtil reconUtil = new ReconUtil();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		/* 스케줄 상태 재확인 (scanning, scheduled 항목에 대해 스케줄 항목을 recon 데이터로 업데이트) */
		Map<String, Object> mapa = new HashMap<>();
		List<String> tasksList = new ArrayList<>();
		tasksList.add("scheduled");
		tasksList.add("scanning");
		mapa.put("group_id", groupid);
		mapa.put("taskList", tasksList);
		
		if(task.equals("stop") || task.equals("cancel")) {
			mapa.put("status", 0);
			searchDao.updateScheduleGroupStatus(mapa);
		}
		
		List<Map<String,Object>> scheduleList = searchDao.selectScheduleTargets(mapa);
		
		for (Map<String, Object> item : scheduleList) {
			ap_no = Integer.parseInt(item.get("AP_NO").toString());
			id = (String) item.get("RECON_SCHEDULE_ID");
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			try {
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, id, drm);
			}catch (Exception e) {
				resultMap.put("resultCode", -1);
				resultMap.put("resultMessage", e.getMessage());
				return resultMap;
			}
		}
		
		/* 변경된 상태로 스케줄 변경 */
		Map<String, Object> map = new HashMap<>();
		map.put("group_id", groupid);
		map.put("taskList", taskList);
		
		List<Map<String,Object>> scheduleStatusList = searchDao.selectScheduleTargets(map);
		
		Map<String, Object> httpsResponse = null;
		
		for (Map<String, Object> item : scheduleStatusList) {
			ap_no = Integer.parseInt(item.get("AP_NO").toString());
			id = (String) item.get("RECON_SCHEDULE_ID");
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			logger.info("getGroup Status Update doc : " + "/" + api_ver + "/schedules/" + id + "/" + task);
			
			try {
				httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/schedules/" + id + "/" + task, "POST", null);
				
				int resultCode = (int) httpsResponse.get("HttpsResponseCode");
				String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
				
				if ((resultCode != 200) && (resultCode != 204)) {
					resultMap.put("resultCode", resultCode);
					resultMap.put("resultMessage", resultMessage);
					return resultMap;
				}
				
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, id, drm);
			}catch (Exception e) {
				resultMap.put("resultCode", -1);
				resultMap.put("resultMessage", e.getMessage());
				return resultMap;
			}
		}
  	
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		/*
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		Map<String, Object> userLog = new HashMap<String, Object>();
		
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "SCHEDULE CHANGE");		
		userLog.put("user_ip", clientIP);
		userLog.put("job_info", "스캔 상태 변경 > " + changedTask + "[" + changedTask + "]");
		userLog.put("logFlag", "1");

		userDao.insertLog(userLog);*/
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> completedSchedule(HttpServletRequest request) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String groupid = request.getParameter("groupid");
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("group_id", groupid);
		map.put("status", 2);
		searchDao.updateScheduleGroupStatus(map);
		
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
	}
	
	// 데이터 타입 갖고오기
	@Override
	public List<Map<String, Object>> selectScanDataTypes(HttpServletRequest request) throws Exception {
		String std_id = request.getParameter("std_id");
		Map<String, Object> map = new HashMap<>();
		ReconUtil reconUtil = new ReconUtil();

		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		Map<String, Object> httpsResponse = null;
		
		map.put("std_id", std_id);
		
		return searchDao.selectScanDataTypes(map);
	}
	
	@Override
	public Map<String, Object> selectSKTScanDataTypes(HttpServletRequest request) throws Exception {
		String ap_no = request.getParameter("ap_no");
		String target_id = request.getParameter("target_id");
		String location_id = request.getParameter("location_id");
		String net_type = request.getParameter("net_type");
		Map<String, Object> map = new HashMap<>();
		
		map.put("ap_no", ap_no);
		map.put("target_id", target_id);
		map.put("location_id", location_id);
		map.put("net_type", net_type);
		
		return searchDao.selectSKTScanDataTypes(map);
	}

	@Override
	public Map<String, Object> confirmApply(HttpServletRequest request, String api_ver) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		String target_id = request.getParameter("target_id");
		String confirm = request.getParameter("confirm");
		String schedule_id = request.getParameter("schedule_id");
		String ap_no = request.getParameter("ap_no");
		
		resultMap.put("target_id", target_id);
		resultMap.put("confirm", confirm);
		resultMap.put("schedule_id", schedule_id);
		resultMap.put("ap_no", ap_no);
		
		logger.info("target_id >> " + target_id + " , confirm >>" + confirm + " , schedule_id >> " + schedule_id + ", ap_no >> " + ap_no);
		
		if(!ap_no.equals("0")) {
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "대상 서버에 적용이 불가능합니다.");
			
			return resultMap;
		}
		
		searchDao.updateConfirmApply(resultMap);
		
		if(confirm.equals("0")) {
			
			logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules/" + schedule_id + "/cancel");
			
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			String recon_url = properties.getProperty("recon.url");
			String recon_id = properties.getProperty("recon.id");
			String recon_password = properties.getProperty("recon.password") ;
			String drm = "";
			
			ReconUtil reconUtil = new ReconUtil();
			Map<String, Object> httpsResponse = null;
			
			try {
				httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/schedules/" + schedule_id + "/cancel", "POST", null);
			} catch (ProtocolException e) {
				// TODO Auto-generated catch block
				resultMap.put("resultCode", -1);
				resultMap.put("resultMessage", e.getMessage());
				return resultMap;
			}

			int resultCode = (int) httpsResponse.get("HttpsResponseCode");
			String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
			
			if ((resultCode != 200) && (resultCode != 204)) {
				resultMap.put("resultCode", resultCode);
				resultMap.put("resultMessage", resultMessage);
				return resultMap;
			}
			// 작업변경이 성공하면 DB도 변경 해 준다.
	     	String changedTask = "cancelled";
	     	
	     	updateScanschedule(reconUtil, recon_url, recon_id, recon_password, 0, schedule_id, drm);
	  	
			resultMap.put("resultCode", 1);
			resultMap.put("resultMessage", "검색 진행을 취소하였습니다.");
			
			// User Log 남기기
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			Map<String, Object> userLog = new HashMap<String, Object>();
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "SCHEDULE CHANGE");		
			userLog.put("user_ip", clientIP);
			userLog.put("job_info", "스캔 상태 변경 > " + changedTask + "[" + changedTask + "]");
			userLog.put("logFlag", "1");

			userDao.insertLog(userLog);
			
		} else if (confirm.equals("1")) {
			resultMap.put("resultCode", 1);
			resultMap.put("resultMessage", "대상 스케줄을 확정하였습니다.");
			
		}
		
		return resultMap;
	}
	

	@Override
	public Map<String, Object> updateSchedule(HttpServletRequest request) throws Exception {

		logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules");
//		String scheduleData = request.getParameter("scheduleData");

		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int group_key = Integer.parseInt(request.getParameter("scheduleid"));
		
		
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		JsonParser parser = new JsonParser();
		JsonArray dataArr = (JsonArray) parser.parse(request.getParameter("scheduleArr"));
		logger.info("size :: " + dataArr.size());
		
		Map<String, Object> map = new HashMap<>();
		
		for(int i=0; i<dataArr.size(); i++) {
			/*logger.info(dataArr.get(i).toString());*/
			
			JsonObject obj = (JsonObject) dataArr.get(i);
			int ap_no = Integer.parseInt(request.getParameter("ap_no"));;
			String scheduleData = obj.get("scheduleData").toString();
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			Map<String, Object> httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url+"/"+api_ver+"/schedules/"+group_key, "PUT", scheduleData);
			
			int resultCode = (int) httpsResponse.get("HttpsResponseCode");
			String resultMessage = (String) httpsResponse.get("HttpsResponseMessage");
			
			resultMap.put("resultCode", resultCode);
			resultMap.put("resultMessage", resultMessage);
			
			Map<String, Object> userLog = new HashMap<String, Object>();
			
			logger.info("requestMsg >> " + resultMessage);
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "SCHEDULE UPDATE");
			userLog.put("user_ip", clientIP);
			//userLog.put("job_info", "스캔 등록");
			userLog.put("logFlag", "1");
			
			if(resultCode == 204) {
				userLog.put("job_info", "스캔쥴 변경 성공");
				map.put("target_id", obj.get("target_id").getAsString());
				
				logger.info("map :: " + map);
				
				// 스캔쥴 변경 - 없데이트
				//updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, group_key+"");
			} else if (resultCode == 409) {
				userLog.put("job_info", "스캔쥴 변경 실패 - 스케줄명 중복");
			} else if (resultCode == 422) {
				userLog.put("job_info", "스캔쥴 변경 실패 - 시작시간 오류");
			} else {
				userLog.put("job_info", "스캔쥴 변경 실패 - " + resultCode);
			}
			
			userDao.insertLog(userLog);
		}
		
		return resultMap;
	}
	
	@Override
	public void updateReconSchedule(HttpServletRequest request) throws Exception {
		logger.info("getMatchObjects doc : " + "/" + api_ver + "/schedules");

		ReconUtil reconUtil = new ReconUtil();

		int group_key = Integer.parseInt(request.getParameter("scheduleid"));
		String drm = "";

		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		properties.load(reader);

		int ap_no = Integer.parseInt(request.getParameter("ap_no"));

		String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
		String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
		String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;

		updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, group_key+"", drm);

	}
	
	@Override
	public List<Map<String, Object>> selectNetHost(HttpServletRequest request) throws Exception {
		String type = request.getParameter("type");
		
		Map<String, Object> map = new HashMap<>();
		StringBuffer ip = new StringBuffer();
		
		switch (type) {
		case "type1":	//OA(SOC)
			ip.append("150.20.18.|150.20.20.|150.20.21.|150.20.22.|150.20.23.|150.20.47.|");
			ip.append("150.20.44.|150.20.45.|150.20.19.");
			break;
		case "type2":	//OA(N-SOC)
			ip.append("150.24.95.|150.28.65.|150.28.66.|150.28.67.|150.28.68.|150.28.69.|150.28.70.|150.28.78.|150.28.79.");
			break;
		case "type3":	//유통망(서비스 ACE/TOP지점)
			
			break;
		case "type4":	//유통망(대리점)
			
			break;
		case "type5":	//유통망(F&U/미납센터, PS&M본사)
			//PS&M
			for(int i = 44; i < 49; i++) {
				ip.append("10.40."+ i + ".|");
			}
			ip.append("90.31.252.|90.31.253.|");
			ip.append("10.40.74.|10.40.75.|");
			for(int i = 55; i < 59; i++) {
				ip.append("10.40."+ i + ".|");
			}
			ip.append("10.40.7.|10.40.11.");
			break;
		case "type6":	//VDI
			// mydesk
			for(int i = 64; i < 104; i++) {
				ip.append("172.26."+ i + ".|");
			}
			ip.append("10.179.30.|10.179.31.|10.179.96.|10.179.98.|10.179.11.|10.179.13.|10.179.14.|10.179.18.|10.179.28.|10.179.97.|10.179.99.|10.179.109.|10.179.111.|10.179.113.|10.178.131.|");
			// DTVDI
			ip.append("172.26.59.|172.26.60.|172.26.61.|172.26.62.|");
			// 망분리(VDI)
			ip.append("172.26.240.|172.26.242.|172.26.244.|");
			// 고객센터
			for(int i = 1; i < 9; i++) {
				ip.append("172.26."+ i + ".|");
			}
			ip.append("172.26.9.");
			break;
		case "type7":	//VDI(SOC)
			ip.append("150.20.33.|150.20.34.|150.20.35.|150.20.37.|150.20.38.");
			break;
		default:
			break;
		}
		
		map.put("net_ip", ip.toString());
		
		
		
		return searchDao.selectNetHost(map);
	}
	
	
	// 검색 스케줄 Scanning 항목 보기
	@Override
	public Map<String, Object> getScanDetails(HttpServletRequest request, String api_ver) throws Exception {
		//https://masterIP:8339/beta/schedules/98?details=true
		String id = request.getParameter("id");
		int ap_no = Integer.parseInt(request.getParameter("ap_no").toString());
		
		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		
		logger.info("getMatchObjects doc : " + "/beta/schedules/" + id + "?details=true");

		Map<String, Object> resultMap = new HashMap<String, Object>();
		ReconUtil reconUtil = new ReconUtil();
		Map<String, Object> httpsResponse = null;
		
		String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
		String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
		String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
		
		try {
			httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/"+api_ver+"/schedules/" + id + "?details=true", "GET", null);
		} catch (ProtocolException e) {
			// TODO Auto-generated catch block
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

		ArrayList<Map<String, String>> detailList = new ArrayList<>();
		
		JSONArray jsonArr = jsonObject.getJSONArray("targets");
		
		for(int i=0; i<jsonArr.size(); i++) {
			JSONObject obj = jsonArr.getJSONObject(i);
			
			String name = obj.getString("name");
			String status = "";
			String percentage = "";
			String currentlyFile = "";
			JSONArray locArr = new JSONArray();
			if(obj.containsKey("locations")) {
				locArr = obj.getJSONArray("locations");
			}
			
			for(int j=0; j<locArr.size(); j++) {
				JSONObject locObj = locArr.getJSONObject(j);
				status = locObj.getString("status");

				String message = "";
				try {
					message = locObj.getString("message");
					percentage = message.substring(0, (message.indexOf("%")+1));
					currentlyFile = message.substring((message.indexOf("'File path ")+11), (message.length()-1));
				} catch (Exception e) {
					logger.error(e.toString());
				}
			}
			
			Map<String, String> data = new HashMap<>();
			data.put("name", name);
			data.put("status", status);
			data.put("percentage", percentage);
			data.put("currentlyFile", currentlyFile);
			
			detailList.add(data);
		}
		
		
		resultMap.put("resultData", detailList);
		resultMap.put("resultCode", 0);
		resultMap.put("resultMessage", "SUCCESS");
		
		return resultMap;
			
	}
	
	// pc 정책 생성(네트워크, 그룹, pc)
	@Override
	public Map<String, Object> insertNetPolicy(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int type = Integer.parseInt(request.getParameter("type")); 	// 네트워크, 그룹, pc 구분
		String rangeId = request.getParameter("rangeId"); 			// 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
		String rangeNm = request.getParameter("rangeNm"); 			// 이름
		String rangeType = request.getParameter("rangeType"); 		// pc일 경우 호스트 ap_no 구분 용
		String trace = request.getParameter("trace"); 				// 스캔 트레이스 로그
		String drm = request.getParameter("drm"); 					// drm status
		String policyId = request.getParameter("policyId"); 		// 검색 정책
		String[] timeArr = request.getParameterValues("timeArr"); 	// 검색 시간
		String scanday = request.getParameter("scanday"); 		// 검색 정책
		
		map.put("timeArr", timeArr);
		map.put("type", type);
		map.put("rangeId", rangeId);
		map.put("rangeNm", rangeNm);
		map.put("ap_no", rangeType);
		map.put("trace", trace);
		map.put("drm", drm);
		map.put("policyId", policyId);
		map.put("scanday", scanday);
		
		int net_id = searchDao.selectScheduleId(); // net_id 
		map.put("net_id", net_id);
		
		try {
			
			if(type == 0) { // 망 등록
				map.put("rangeId", rangeId.replace("TYPE", ""));
				searchDao.insertNetPolicy(map);
				searchDao.insertNetSchedule(map);
				searchDao.updateNetTarget(map);
			} else if(type == 1) { // 그룹 등록
				searchDao.insertNetPolicy(map);
				searchDao.insertNetSchedule(map);
				searchDao.updateNetDeptTarget(map);
			} else if(type == 2) { // PC 등록
				searchDao.insertNetPolicy(map);
				searchDao.insertNetSchedule(map);
				searchDao.updateNetTarget(map);
			} 
			
		} catch (Exception e) {
			searchDao.deleteNetPolicy(map);
			searchDao.deleteNetSchedule(map);
			
			map.put("resultCode", 400);
			map.put("resultMsg", "PC 정책 등록에 실패하였습니다.");
			
		}
		
		return map;
	}
	
	// OneDrive 정책 생성
	@Override
	public Map<String, Object> insertOneDrivePolicy(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int type = Integer.parseInt(request.getParameter("type")); 					// 네트워크, 그룹, pc 구분
		String rangeId = request.getParameter("rangeId"); 							// 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
		String rangeNm = request.getParameter("rangeNm"); 							// 이름
		String rangeOneDriveNm = request.getParameter("rangeOneDriveNm"); 			// 검색 시간
		String rangeType = request.getParameter("rangeType"); 						// pc일 경우 호스트 ap_no 구분 용
		String trace = request.getParameter("trace"); 								// 스캔 트레이스 로그
		String policyId = request.getParameter("policyId"); 						// 검색 정책
		String targetId = request.getParameter("targetId"); 						// 검색 정책
		
		String[] rangeIdArr = request.getParameterValues("rangeId");
		
		map.put("type", type);
		/*map.put("rangeId", rangeId);*/
		map.put("targetId", targetId);
		map.put("rangeNm", rangeNm);
		/*map.put("rangeOneDriveNm", rangeOneDriveNm);*/
		map.put("ap_no", rangeType);
		map.put("trace", trace);
		map.put("policyId", policyId);
		
		int net_id = searchDao.selectScheduleId(); // net_id 
		map.put("net_id", net_id);
		try {
		
			JSONArray reangeNameArray = JSONArray.fromObject(rangeOneDriveNm);
			JSONArray reangeIdArray = JSONArray.fromObject(rangeId);
			map.put("rangeIdArr", reangeIdArray);
			
			searchDao.updateNetOneDrive(map); // pi_location.net_id 업데이트
			for (int i = 0 ; i < reangeIdArray.size() ; i++) {
				map.put("rangeId", reangeIdArray.get(i).toString());
				map.put("rangeOneDriveNm", reangeNameArray.get(i).toString());
				
				searchDao.insertOneDrivePolicy(map);
			}
			
		} catch (Exception e) {
			searchDao.deleteNetPolicy(map);
			searchDao.deleteNetSchedule(map);
			
			map.put("resultCode", 400);
			map.put("resultMsg", "PC 정책 등록에 실패하였습니다.");
			
		}
		
		return map;
	}
	
	// OneDrive 정책 업데이트
	@Override
	public Map<String, Object> updateOneDrivePolicy(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
	
		String net_id = request.getParameter("net_id");
		int type = Integer.parseInt(request.getParameter("type")); 					// type == 3 (OneDrive)
		int beforeType = Integer.parseInt(request.getParameter("beforeType"));		// 기존 타입 (네트워크, 그룹, pc 구분)
		String beforeRangeId = request.getParameter("beforeRangeId");				// 기존 대상의 아이디 (네트워크=net_id, 그룹= insa_code, pc=target_id)
		String rangeId = request.getParameter("rangeId"); 							// location_id
		String rangeNm = request.getParameter("rangeNm"); 							// 이름
		String rangeOneDriveNm = request.getParameter("rangeOneDriveNm"); 			// 검색 시간
		String rangeType = request.getParameter("rangeType"); 						// pc일 경우 호스트 ap_no 구분 용
		String trace = request.getParameter("trace"); 								// 스캔 트레이스 로그
		String policyId = request.getParameter("policyId"); 		
		String targetId = request.getParameter("targetId"); 		
		
		int update_net_id = searchDao.selectScheduleId(); // net_id 
		map.put("net_id", update_net_id);
		
		map.put("type", type);
		map.put("targetId", targetId);
		map.put("beforeRangeId", beforeRangeId);
		map.put("beforeType", beforeType);
		map.put("rangeId", rangeId);
		map.put("rangeNm", rangeNm);
		map.put("ap_no", rangeType);
		map.put("policyId", policyId);
		map.put("before_net_id", net_id);
		map.put("trace", trace);
		try {

			if(type == 0) {
				map.put("rangeId", rangeId.replace("TYPE", ""));
			}
			
			// 기존에 생성된 데이터 net_id 삭제 (전과 다른 대상일 경우)
			updatePoliy(beforeRangeId, beforeType, rangeId, map);
			
			if(type == 3) {
				JSONArray reangeNameArray = JSONArray.fromObject(rangeOneDriveNm);
				JSONArray reangeIdArray = JSONArray.fromObject(rangeId);
				map.put("rangeIdArr", reangeIdArray);
				
				searchDao.updateNetOneDrive(map); // pi_location.net_id 업데이트
				searchDao.updateNetStatus(map);
				
				for (int i = 0 ; i < reangeIdArray.size() ; i++) {
					
					map.put("rangeId", reangeIdArray.get(i).toString());
					map.put("rangeOneDriveNm", reangeNameArray.get(i).toString());
					
					searchDao.insertOneDrivePolicy(map);
				}
			}
				
		} catch (Exception e) {
			searchDao.deleteNetPolicy(map);
			searchDao.deleteNetSchedule(map);
			
			map.put("resultCode", 400);
			map.put("resultMsg", "PC 정책 등록에 실패하였습니다.");
		}
		
		return map;
	}
	
	@Override
	public Map<String, Object> updateNetPolicy(HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int type = Integer.parseInt(request.getParameter("type"));
		int beforeType = Integer.parseInt(request.getParameter("beforeType"));
		String beforeRangeId = request.getParameter("beforeRangeId");
		String rangeId = request.getParameter("rangeId");
		String rangeNm = request.getParameter("rangeNm");
		String rangeType = request.getParameter("rangeType");
		String ap_no = request.getParameter("ap_no");
		String net_id = request.getParameter("net_id");
		String policyId = request.getParameter("policyId");
		String trace = request.getParameter("trace");
		String drm = request.getParameter("drm");
		String scanday = request.getParameter("scanday");
		String[] timeArr = request.getParameterValues("timeArr");
		
		
		map.put("timeArr", timeArr);
		map.put("type", type);
		map.put("beforeRangeId", beforeRangeId);
		map.put("beforeType", beforeType);
		map.put("rangeId", rangeId);
		map.put("rangeNm", rangeNm);
		map.put("rangeType", rangeType);
		map.put("policyId", policyId);
		map.put("net_id", net_id);
		map.put("NET_ID", net_id);
		map.put("ap_no", ap_no);
		map.put("trace", trace);
		map.put("scanday", scanday);
		map.put("drm", drm);
		
		try {
			
			if(type == 0) {
				map.put("rangeId", rangeId.replace("TYPE", ""));
			}
			
			// 기존에 생성된 데이터 net_id 삭제 (전과 다른 대상일 경우)
			updatePoliy(beforeRangeId, beforeType, rangeId, map);
			
			if(type != 3) {
				searchDao.updateNetPolicy(map); 
				searchDao.updateNetSchedule(map);
				
				if(type == 0 || type == 2) { // 네트워크, PC 업데이트
					searchDao.updateNetTarget(map); 
				} else if(type == 1) { // 그룹 업데이트
					searchDao.updateNetDeptTarget(map);
				} 
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}

	@Override
	public List<Map<String, Object>> selectPCPolicy(HttpServletRequest request) throws Exception {
		String net_nm = request.getParameter("net_nm");
		
		Map<String, Object> map = new HashMap<>();
		map.put("net_nm", net_nm);
		
		
		return searchDao.selectPCPolicy(map);
	}
	
	@Override
	public List<Map<String, Object>> selectPCPolicyTime(HttpServletRequest request) throws Exception {
		String net_id = request.getParameter("net_id");
		
		Map<String, Object> map = new HashMap<>();
		map.put("net_id", net_id);
		
		return searchDao.selectPCPolicyTime(map);
	}
	
	@SuppressWarnings("null")
	@Override
	public void deletePCPolicy(HttpServletRequest request) throws Exception {
		String net_id = request.getParameter("net_id");
		int type = Integer.parseInt(request.getParameter("type"));
		String group_id = request.getParameter("group_id");
		String ap_no = request.getParameter("ap_no");
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("NET_ID", net_id);
		map.put("group_id", group_id);
		map.put("ap_no", ap_no);
		
		try {
			// 망 삭제 일경우 (해당 망에 결러 있는 Target List 제거)
			if(type == 0) {
				map.put("UPDATE_NET", null);
				
				searchDao.deletePCPolicy(map);
				searchDao.updatePCPolicy(map);
			// 그룹 삭제 일경우 (해당 상위 그룹에 정책이 걸려 있는 항목을 찾고 상위 정책으로 변경, 상위 그룹이 없을 경우 망 정책으로 적용)
			} else if(type == 1) {
				Map<String, Object> result = searchDao.selectUpGroupPolicy(map);
				
				//상위 그룹에 망정책이 걸려있음
				if(result != null) {
					map.put("UPDATE_NET", result.get("NET_ID"));	// 기존에 걸려있던 상위 정책 으로 변경
					searchDao.updatePCPolicy(map);
					searchDao.deletePCPolicy(map);
				} else {	// 상위 그룹에 pc정책이 안걸려있으면, 망정책으로 변경
					searchDao.updateUpNetwork(map);
					searchDao.deletePCPolicy(map);
				}
				
			// PC, OneDrive 삭제 일 경우 (상위 그룹 정책 찾고 , 없으면 상위 망 검색)	
			} else if(type == 2 || type == 3) {
				Map<String, Object> result = searchDao.selectUpPCPolicy(map);
				if(result != null) {
					map.put("UPDATE_NET", result.get("NET_ID"));	// 기존에 걸려있던 상위 정책 으로 변경
					searchDao.updatePCPolicy(map);
					searchDao.deletePCPolicy(map);
				} else {	// 상위 그룹에 pc정책이 안걸려있으면, 망정책으로 변경
					searchDao.updateUpNetwork(map);
					searchDao.deletePCPolicy(map);
				}
			}
		}catch (Exception e) {
			// TODO: handle exception
			logger.error(e.toString());
		}
		
		
	}
	
	@Override
	public List<Map<String, Object>> selectPCSearchStatus(HttpServletRequest request) throws Exception {
		String net_id = request.getParameter("net_id");
		String location_id = request.getParameter("location_id");
		String type = request.getParameter("type");
		Map<String, Object> map = new HashMap<>();
		int ap_no = 0;
		String id = "";
		String drm = "";
		ReconUtil reconUtil = new ReconUtil();

		Properties properties = new Properties();
		String resource = "/property/config.properties";
		Reader reader = Resources.getResourceAsReader(resource);
		
		properties.load(reader);
		Map<String, Object> httpsResponse = null;
		
		map.put("net_id", net_id);
		map.put("location_id", location_id);
		map.put("type", type);
		List<Map<String,Object>> scheduleList = searchDao.selectScheduleTargets(map);

		for (Map<String, Object> item : scheduleList) {
			String status = (String) item.get("SCHEDULE_STATUS");
			
			if(status.equals("cancelled") || status.equals("completed") || status.equals("failed")) {
				continue;
			}
			
			ap_no = Integer.parseInt(item.get("AP_NO").toString());
			id = (String) item.get("RECON_SCHEDULE_ID");
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
			
			try {
				updateScanschedule(reconUtil, recon_url, recon_id, recon_password, ap_no, id, drm);
			}catch (Exception e) {
				
			}
		}
		
		return searchDao.selectPCSearchStatus(map);
	}

	@Override
	public Map<String, Object> selectUserSearchCount(HttpServletRequest request) throws Exception {
		
		String user_no = request.getParameter("user_no");
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("user_no", user_no);
		
		return searchDao.selectUserSearchCount(map);
	}
	
	@Override
	public List<Map<String, Object>> netList(HttpServletRequest request) {
		
		String net_type = request.getParameter("net_type");
		String net_ip = request.getParameter("net_ip");
		String net_type_class = request.getParameter("net_type_class");
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("net_type", net_type);
		map.put("net_type_class", net_type_class);
		map.put("net_ip", net_ip);
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		
		logger.info("map >>>>>>>>> " + map);
		
		return searchDao.netList(map);
	}
	
	
	@Override
	public Map<String, Object> insertNetIp(HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> userLog = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			// User Log 남기기
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			
			String type = request.getParameter("type");
			String type_name = request.getParameter("type_name");
			String type_class = request.getParameter("type_class");
			String ip = request.getParameter("ip");
			String mask = request.getParameter("mask");
			String mask_ip = request.getParameter("mask_ip");
			
			map.put("type", type);
			map.put("type_name", type_name);
			map.put("type_class", type_class);
			map.put("ip", ip);
			map.put("mask", mask);
			map.put("mask_ip", mask_ip);
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "NET CREATED");
			userLog.put("user_ip", clientIP);
			userLog.put("logFlag", "9");
			userLog.put("job_info", "net_ip 생성("+ip+"/"+mask+")");
			
			int resultInt = searchDao.selectNetIpCheck(map);
		
			if(resultInt > 0) {
				resultMap.put("resultCode", -9);
				resultMap.put("resultMessage", "이미 생성된 네트워크 입니다.");
			}else {
				searchDao.insertNetIp(map);
				userDao.insertLog(userLog);
				
				resultMap.put("resultCode", 0);
				resultMap.put("resultMessage", "네트워크가 생성 되었습니다.");
			}
			
			
		}catch (Exception e) {
			// TODO: handle exception
			logger.error(e.toString());
		}
		return resultMap;
	}
	
	@Override
	public Map<String, Object> updateNetIp(HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> userLog = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<>();
		
		try {
			// User Log 남기기
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			
			String type = request.getParameter("type");
			String type_name = request.getParameter("type_name");
			String type_class = request.getParameter("type_class");
			String ip = request.getParameter("ip");
			String mask = request.getParameter("mask");
			String mask_ip = request.getParameter("mask_ip");
			
			String reachNet_Ip = request.getParameter("reachNet_Ip");
			String reachNetMask = request.getParameter("reachNetMask");
			
			
			map.put("type", type);
			map.put("type_name", type_name);
			map.put("type_class", type_class);
			map.put("ip", ip);
			map.put("mask", mask);
			map.put("mask_ip", mask_ip);
			
			map.put("reachNet_Ip", reachNet_Ip);
			map.put("reachNetMask", reachNetMask);
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "NET CREATED");
			userLog.put("user_ip", clientIP);
			userLog.put("logFlag", "9");
			userLog.put("job_info", "net_ip 수정("+ip+"/"+mask+")");
			
			searchDao.updateNetIp(map);
			userDao.insertLog(userLog);
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "네트워크가 수정 되었습니다.");
			
		}catch (Exception e) {
			// TODO: handle exception
			logger.error(e.toString());
		}
		return resultMap;
	}

	@Override
	public void deleteNetIp(HttpServletRequest request) throws Exception {
		// User Log 남기기
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		ServletUtil servletUtil = new ServletUtil(request);
		String clientIP = servletUtil.getIp();
		
		String ip = request.getParameter("ip");
		String mask = request.getParameter("mask");
		
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> userLog = new HashMap<String, Object>();
		
		map.put("mask", mask);
		map.put("ip", ip);
		
		userLog.put("user_no", user_no);
		userLog.put("menu_name", "NET DELETE");
		userLog.put("user_ip", clientIP);
		userLog.put("logFlag", "9");
		userLog.put("job_info", "net_ip 삭제("+ip+"/"+mask+")");
		
		try {
			searchDao.deleteNetIp(map);
			userDao.insertLog(userLog);
			
		}catch (Exception e) {
			// TODO: handle exception
			logger.error(e.toString());
		}
	}
	

	
	private void updatePoliy(String beforeRangeId, int beforeType, String rangeId, Map<String, Object> map) throws Exception {

		try {
			if(!beforeRangeId.equals(rangeId)) {
				if(beforeType == 0) { // 네트워크 였을 경우
					searchDao.deleteNetId(map);
				}else if (beforeType == 1) { // 그룹이 였을 경우
					searchDao.deleteNetGroup(map);
				}else if (beforeType == 2) { // pc 였을 경우
					searchDao.deleteNetId(map);
				}else if (beforeType == 3) { // OneDrive 였을 경우
					searchDao.deleteOneDriveNetId(map);
					/*searchDao.deleteOneDriveNetId2(map);*/
				}
			}
			
			if(beforeType != 3) {
				searchDao.deleteNetSchedule(map); // 생성된 시간 제거
			}
			
		} catch (Exception e) {
			logger.error("policy update error >>> " + e);
		}
	}
	
	@Override
	public int insertNetListIp(HashMap<String, Object> params, HttpServletRequest request) throws Exception {
		String resulList = request.getParameter("resulList");
		Map<String, Object> resultMap2 = new HashMap<String, Object>();
		
		List<Map<String, Object>> NetList = new ArrayList<>();
		
		int resultInt  = 0;
		JSONArray jsonarry = JSONArray.fromObject(resulList);
		
		try {
			
			for(int i = 0; i < jsonarry.size(); i++) {
				Map<String, Object> resultMap = new HashMap<String, Object>();
				JSONObject jsonObject = (JSONObject) jsonarry.get(i);
				
				String ip = jsonObject.getString("ip");
				String type = jsonObject.getString("type");
				String detail = jsonObject.getString("detail");
				String mask = jsonObject.getString("mask");
				String mask_ip = jsonObject.getString("mask_ip");
				
				if(resultMap2.containsKey(mask)) {
	                List<String> existingIPs = (List<String>) resultMap2.get(mask);
	                existingIPs.add(ip);
	            } else {
	                List<String> newIPs = new ArrayList<String>();
	                newIPs.add(ip);
	                resultMap.put("mask", mask);
	                resultMap.put("IPList", newIPs);
	                
	                resultMap2.put(mask, newIPs);
	            }
				if(resultMap.size() > 0) {
					NetList.add(resultMap);
				}
			}
			
			logger.info("insert Mask List >>> " + resultMap2.keySet());
			
			for(int i = 0; i < NetList.size(); i++) {
				
				int resultNetInt = searchDao.selectNetMask(NetList.get(i));
				
				if(resultNetInt > 0) {
					resultInt = resultInt + resultNetInt;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultInt;
	}

	@Override
	public Map<String, Object> insertNetList(HashMap<String, Object> params, HttpServletRequest request) throws Exception {
		String resulList = request.getParameter("resulList");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> NetList = new ArrayList<>();
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> mapList = new HashMap<String, Object>();
		
		JSONArray jsonarry = JSONArray.fromObject(resulList);
		
		try {
			for(int i = 0; i < jsonarry.size(); i++) {
				
				map = new HashMap<String, Object>();
				
				JSONObject jsonObject = (JSONObject) jsonarry.get(i);
				
				String ip = jsonObject.getString("ip");
				String type = jsonObject.getString("type");
				String type_name = jsonObject.getString("type_name");
				String type_class = jsonObject.getString("detail");
				String mask = jsonObject.getString("mask");
				String mask_ip = jsonObject.getString("mask_ip");
				
				map.put("ip", ip);
				map.put("type", type);
				map.put("type_name", type_name);
				map.put("type_class", type_class);
				map.put("mask", mask);
				map.put("mask_ip", mask_ip);
				
				searchDao.insertNetList(map);
			}
			
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", jsonarry.size() + "건 insert 완료");
			
			// User Log 남기기
			String user_no = SessionUtil.getSession("memberSession", "USER_NO");
			Map<String, Object> userLog = new HashMap<String, Object>();
			ServletUtil servletUtil = new ServletUtil(request);
			String clientIP = servletUtil.getIp();
			
			userLog.put("user_no", user_no);
			userLog.put("menu_name", "NETLIST INSERT");
			userLog.put("user_ip", clientIP);
			userLog.put("logFlag", "9");
			userLog.put("job_info", "네트워크 일괄 등록");
			
			userDao.insertLog(userLog);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			resultMap.put("resultCode", -1);
			resultMap.put("resultMessage", "insert 실패");
		}
		
		return resultMap;
	}
	
	@Override
	public int insertFilterList(HashMap<String, Object> params, HttpServletRequest request) throws Exception {
		String resulList = request.getParameter("resulList");
		Map<String, Object> resultMap2 = new HashMap<String, Object>();
		
		List<Map<String, Object>> filterList = new ArrayList<>();
		
		int resultInt  = 0;
		int notServer = 0;
		JSONArray jsonarry = JSONArray.fromObject(resulList);
		
		try {
			
			for(int i = 0; i < jsonarry.size(); i++) {
				
				JSONArray exArray = new JSONArray();
				JSONObject exInfo = new JSONObject();
				
				ReconUtil reconUtil = new ReconUtil();
				Map<String, Object> httpsResponse = null;
				
				Map<String, Object> resultMap = new HashMap<String, Object>();
				JSONObject jsonObject = (JSONObject) jsonarry.get(i);
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				String ap_nm = jsonObject.getString("ap_nm");
				String target_nm = jsonObject.getString("target_id");
				String path = jsonObject.getString("path");
				
				Map<String, Object> targetMap = new HashMap<String, Object>();
				
				resultMap.put("path", path);
				
				exInfo.put("expression", path);
				exInfo.put("type", "exclude_expression");
				
				map.put("ap_nm", ap_nm);
				if(target_nm.equals("전체")){
					targetMap = searchDao.selectTargetIdAll(map);
				}else {
					map.put("target_name", target_nm);
					targetMap = searchDao.selectTargetId(map);
					resultMap.put("ip", targetMap.get("TARGET_ID"));
					exInfo.put("apply_to", targetMap.get("TARGET_ID"));
				}
				
				exArray.add(exInfo);
				if(targetMap != null) {
					resultMap.put("ip", targetMap.get("IP"));
					resultMap.put("ap_no", targetMap.get("AP_NO"));
				}else {
					++notServer;
					break;
				}
				
				try {
					
					int ap_no = Integer.parseInt(resultMap.get("ap_no").toString());
					
					Properties properties = new Properties();
					String resource = "/property/config.properties";
					Reader reader = Resources.getResourceAsReader(resource);
					
					properties.load(reader);
					
					String api_ver = properties.getProperty("recon.api.version");
					
					String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
					String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
					String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
					
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/filters", "POST", exArray.toString());		
					
					int resultCode = Integer.parseInt(httpsResponse.get("HttpsResponseCode").toString());
					
					if(resultCode == 201) {
						resultMap.put("resultCode", 0);
						resultMap.put("resultMessage", "예외 처리 성공");
					}else {
						resultMap.put("resultCode", -2);
						resultMap.put("resultMessage", "예외 처리 실패");
					}
				}catch (Exception e) {
					// TODO: handle exception
					resultMap.put("resultCode", -1);
					resultMap.put("resultMessage", e.getMessage());
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultInt;
	}
}
