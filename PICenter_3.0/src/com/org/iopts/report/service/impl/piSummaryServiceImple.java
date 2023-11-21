package com.org.iopts.report.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.Reader;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.io.Resources;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonParser;
import com.org.iopts.report.dao.piSummaryDAO;
import com.org.iopts.report.service.piSummaryService;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service("piSummaryService")
@Transactional
public class piSummaryServiceImple implements piSummaryService {
	
	private static Logger log = LoggerFactory.getLogger(piSummaryServiceImple.class);

	@Inject
	private piSummaryDAO summaryDao;
	
	 @Value("${recon.api.version}")
    private String api_ver;
    
    @Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${excel.file.path}")
	private String excel_path;

	@Override
	public List<HashMap<String, Object>> searchSummaryList(HashMap<String, Object> params) throws Exception {
		//log.info("searchSummaryList : " + params.get("SCH_DMZ_SELECT").toString());
		//log.info("object :: " + params.get("SCH_OBJECT").toString());
		//String target = params.get("SCH_OBJECT").toString();
		
		/*String path = params.get("SCH_PATH").toString();
		path = path.replaceAll("\\\\", "\\\\\\\\");
		params.put("SCH_PATH", path);*/
		int date = (Integer.parseInt(params.get("SCH_DATE").toString()));
		String ap = params.get("AP_NO").toString();
		log.info("ap : " + ap);
		if(ap.equals("0")) {
			if(date == 0) {
				return summaryDao.searchSummaryList(params);
			}else {
				return summaryDao.searchSummaryRegDateList(params);
			}
		}else {
			if(date == 0) {
				return summaryDao.searchPCSummaryList(params);
			}else {
				return summaryDao.searchPCSummaryRegDateList(params);
			}
		}
		//변경
		/*String path = params.get("SCH_PATH").toString();
		path = path.replaceAll("\\\\", "\\\\\\\\");
		params.put("SCH_PATH", path);
		return summaryDao.searchSummaryList(params);*/
	}
	
	//	@Override
	public List<HashMap<String, Object>> searchDataProcessingFlag() throws Exception {
		return summaryDao.searchDataProcessingFlag();
	}

	@Override
	public List<HashMap<String, Object>> getMonthlyReport(HashMap<String, Object> params) throws Exception {
		
		log.info(params.get("year")+"");
		log.info(params.get("month")+"");
		
		String yyyymm = String.valueOf(params.get("year")) + String.valueOf(params.get("month"));
		return summaryDao.getMonthlyReport(yyyymm);
	}

	@Override
	public List<Map<String, Object>> selectPersonNotCom() throws Exception {
		return summaryDao.selectPersonNotCom();
	}
	
	@Override
	public List<Map<String, Object>> selectTeamNotCom() throws Exception {
		return summaryDao.selectTeamNotCom();
	}

	@Override
	public List<Map<String, Object>> selectOwnerList(Map<String, Object> map) throws Exception {
		return summaryDao.selectOwnerList(map);
	}
	
	@Override
	public Map<String, Object> getExcelDownCNT(HashMap<String, Object> params) throws Exception {
		
		int ap_no = 0;

		Map<String, Object> result = new HashMap<>();
		
		List<Map<String, Object>> resultList = new ArrayList<>();
		List<Map<String, Object>> chunksResultList = new ArrayList<>();
		List<Map<String, Object>> matchResultList = new ArrayList<>();
		List<Map<String, Object>> metasResultList = new ArrayList<>();
		
		Map<String, Object> resultMap =  new HashMap<String, Object>();
		Map<String, Object> chunksResultMap =  new HashMap<String, Object>();
		Map<String, Object> matchResultMap =  new HashMap<String, Object>();
		Map<String, Object> metasResultMap =  new HashMap<String, Object>();
		
		String tid = (String) params.get("tid");
		String gid = (String) params.get("gid");
		String reg_date = (String) params.get("sch_SDATE");
		String end_date = (String) params.get("sch_EDAT");
		
		String[] groupArr = gid.split(",");
		String[] targetArr = tid.split(",");
		HashMap<String, Object> groupMap =  new HashMap<String, Object>();
		HashMap<String, Object> targetMap =  new HashMap<String, Object>();
		
		List<String> targetList = new ArrayList<>();
		List<String> groupList = new ArrayList<>();
		List<Map<String, Object>> groupList2 = new ArrayList<>();
		
		targetMap.put("sch_SDATE", reg_date);
		targetMap.put("sch_EDAT", end_date);
		
		if(gid != null && ! gid.equals("")) {
			JSONArray groupJArr = JSONArray.fromObject(groupArr);
			for(int i = 0; i < groupJArr.size(); i++) {
				String groupID = (String) groupJArr.get(i);
				groupList.add(groupID);
			}
			groupMap.put("groupList", groupList);
		}
		if(tid != null && !tid.equals("")) {
			JSONArray targetJArr = JSONArray.fromObject(targetArr);
			for(int i = 0; i < targetJArr.size(); i++) {
				String targetID = (String) targetJArr.get(i);
				targetList.add(targetID);
			}
			groupMap.put("targetList", targetList);
		}
		
		if(groupMap.size() > 0) {
			groupList2 = summaryDao.getGroupID(groupMap);
			targetList = new ArrayList<>();
			if(groupList2.size() > 0) {
				for(int i=0; i<groupList2.size() ; i++) {
					if(groupList2.get(i) != null) {
						String targetId = (String)groupList2.get(i).get("TARGET_ID");
						targetList.add(targetId);
					}
				}
				targetMap.put("targetList", targetList);
			}else {
				result.put("fileName", "NoFile");
				result.put("rowLength", 0);
				return result;
			}
		}
	

		JSONObject jsonObject = null;
		List<Map<String, Object>> targetObject = null;
		List<Map<String, Object>> agent_mngr = null;
		Map<String, Object> targetList3 = null;
		Map<String, Object> daoMap = new HashMap<String, Object>();
		
		daoMap.put("reg_date", reg_date);
		daoMap.put("end_date", end_date);
		
		try {
			if(groupMap.size() > 0) {
				daoMap.put("targetList", targetList);
				targetObject = summaryDao.getTargetByNode(daoMap);
			}else {
				targetObject = summaryDao.getTargetByNode(daoMap);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		for(int i=0 ; i < targetObject.size() ; i++) {
			
			Map<String, Object> userMap = new HashMap<String, Object>();
			
			String target_id = (String) targetObject.get(i).get("TARGET_ID");
			String hash_id = (String) targetObject.get(i).get("HASH_ID");
			String fid = (String) targetObject.get(i).get("INFO_ID");
			String host_name = (String) targetObject.get(i).get("NAME");
			/*String group_name = (String) targetObject.get(i).get("GROUP_NAME");*/
			String agent_ip = (String) targetObject.get(i).get("AGENT_CONNECTED_IP");
			String agent_connected = (String) targetObject.get(i).get("AGENT_CONNECTED");
			String modified_date = (String) targetObject.get(i).get("MODIFIED_DATE");
			String owner = (String) targetObject.get(i).get("ACCOUNT");
			String chk = (String) targetObject.get(i).get("CHK");
			String path = (String) targetObject.get(i).get("PATH");
			String apNo = targetObject.get(i).get("AP_NO").toString();
			
			userMap.put("target_id", target_id);
			userMap.put("ap_no", apNo);
			
			String service_mngr = "";
			String service_mngr2 = "";
			
			agent_mngr = summaryDao.getMngrUser(userMap);
			
			if(agent_mngr.size() > 0) {
				log.info("agent_mngr >>> " + agent_mngr.toString());
				service_mngr = (String) agent_mngr.get(0).get("SERVICE_MNGR");
				service_mngr2 = (String) agent_mngr.get(0).get("SERVICE_MNGR2");
			}
			
			ReconUtil reconUtil = new ReconUtil();
			Map<String, Object> httpsResponse = null;
			JsonParser parser = new JsonParser();
			
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			boolean infoIDNull = false;
			
			if(chk.equals(">"))  infoIDNull = true; // 하위경로 존재 O
			else infoIDNull = false; // 하위경로 존재 X

			resultMap =  new HashMap<String, Object>();
			resultMap.put("fid", fid);
			resultMap.put("hash_id", hash_id);
			resultMap.put("target_id", target_id);
			resultMap.put("host_name", host_name);
			resultMap.put("agent_ip", agent_ip);
			resultMap.put("agent_connected", agent_connected);
			resultMap.put("CHK", chk);
			resultMap.put("owner", owner);
			resultMap.put("path", path);
			resultMap.put("service_mngr", service_mngr);
			resultMap.put("service_mngr2", service_mngr2);
			
			if(infoIDNull) { // 하위 경로 존재 O
				log.info("IT CONTAINS SUB PATH.(FID ID IS NULL)");
				
				resultMap.put("modified_dt", modified_date);
				
				Map<String, Object> infoID = summaryDao.getInfoId(resultMap);
				
				if(infoID.get("FID") != null) {
					resultMap.put("fid", infoID.get("FID"));
					fid = infoID.get("FID").toString();
					
					resultMap.put("subpath_hash_id", infoID.get("HASH_ID"));
					
					targetList3= summaryDao.getsubpathTotal(resultMap);
					
					int type1 = Integer.parseInt(targetList3.get("TYPE1").toString());
					int type2 = Integer.parseInt(targetList3.get("TYPE2").toString());
					int type3 = Integer.parseInt(targetList3.get("TYPE3").toString());
					int type4 = Integer.parseInt(targetList3.get("TYPE4").toString());
					int type5 = Integer.parseInt(targetList3.get("TYPE5").toString());
					int type6 = Integer.parseInt(targetList3.get("TYPE6").toString());
					int type7 = Integer.parseInt(targetList3.get("TYPE7").toString());
					int type8 = Integer.parseInt(targetList3.get("TYPE8").toString());
					int total = type1 + type2 + type3 + type4 + type5 + type6 + type7 + type8;
					
					resultMap.put("TYPE1", type1);
					resultMap.put("TYPE2", type2);
					resultMap.put("TYPE3", type3);
					resultMap.put("TYPE4", type4);
					resultMap.put("TYPE5", type5);
					resultMap.put("TYPE6", type6);
					resultMap.put("TYPE7", type7);
					resultMap.put("TYPE8", type8);
					resultMap.put("TYPE",total);
				}
			}
			
			properties.load(reader);
			
			String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
			String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
			String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
		
			try {
				httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/targets/" + target_id + "/matchobjects/" + fid + "?details=true", "GET", null);
				
				if((Integer) httpsResponse.get("HttpsResponseCode") == 200) {
					
					jsonObject = JSONObject.fromObject(httpsResponse.get("HttpsResponseData"));
					
					JSONArray matches = jsonObject.getJSONArray("matches");
					JSONArray chunks = jsonObject.getJSONArray("chunks");
					JSONArray metas = jsonObject.getJSONArray("metas");
					
					if(!infoIDNull) {
						log.info("IT DOES NOT INCLUDE SUB PATH.(FID ID IS NOT NULL)");
						resultMap.put("path", jsonObject.get("path"));
					}
					matchResultList = new ArrayList<>();
					chunksResultList = new ArrayList<>();
					metasResultList = new ArrayList<>();	
					
					for(int j = 0 ; j < matches.size() ; j++) {
						matchResultMap =  new HashMap<String, Object>();

						JSONObject M_resultObject = matches.getJSONObject(j);
	    				
						matchResultMap.put("match_CON", M_resultObject.getString("content"));
						matchResultMap.put("match_offset", M_resultObject.getString("offset"));
						matchResultMap.put("match_length", M_resultObject.getString("length"));
						matchResultMap.put("match_Type", M_resultObject.getString("data_type"));
						
						matchResultList.add(matchResultMap);
					}
					
					for(int j = 0 ; j < chunks.size() ; j++) {
						chunksResultMap =  new HashMap<String, Object>();

						JSONObject C_resultObject = chunks.getJSONObject(j);
	    				
						chunksResultMap.put("chunks_CON", C_resultObject.getString("content"));
						chunksResultMap.put("chunks_length", C_resultObject.getString("length"));
						chunksResultMap.put("chunks_offset", C_resultObject.getString("offset"));
						
						chunksResultList.add(chunksResultMap);
					}
					
					for(int j = 0 ; j < metas.size() ; j++) {
						metasResultMap =  new HashMap<String, Object>();
						
						JSONObject M_resultObject = metas.getJSONObject(j);
						
						if(M_resultObject.getString("label").equals("File Owner")) {
							resultMap.put("owner", M_resultObject.getString("value"));
						}else if(M_resultObject.getString("label").equals("File Modified")) {
							resultMap.put("Modified_Date", M_resultObject.getString("value"));
						}else if(M_resultObject.getString("label").equals("File Created")) {
							resultMap.put("Created_Date", M_resultObject.getString("value"));
						}else {
							metasResultMap.put("metas_type", M_resultObject.getString("label"));
							metasResultMap.put("metas_val", M_resultObject.getString("value"));
							metasResultList.add(metasResultMap);
						}
					}
					
					resultMap.put("chunksResultList", chunksResultList);
					resultMap.put("matchResultList", matchResultList);
					resultMap.put("metasResultList", metasResultList);
					resultList.add(resultMap);
					
				}else if((Integer) httpsResponse.get("HttpsResponseCode") == 404) {
					log.info("Recon path Delete :: Response Code 404");
				}
				
			} catch (Exception e) {
				log.error("Detail api Export Error :::  " + e);
				e.printStackTrace();
			}
		}
		
		JSONArray jsonArray = JSONArray.fromObject(resultList);

		OutputStream out = null;
		String fileName = "";
		
		// 현재날짜
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyMMddHHmm");

		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		
		String fileDate = sf.format(date);
		
		fileName = excel_path + user_no +"_detailReport_" + fileDate + ".txt"; 
		
		try {
			File file = new File(fileName);
			
			 // 2. 파일 존재여부 체크 및 생성
            if (!file.exists()) {
                file.createNewFile();
            }
			 out = new FileOutputStream(fileName);
			 //byte[] bytes = resultList.toString().getBytes();
			 // 3. Buffer를 사용해서 File에 write할 수 있는 BufferedWriter 생성
            FileWriter fw = new FileWriter(file);
            BufferedWriter writer = new BufferedWriter(fw);
 
            // 4. 파일에 쓰기
            writer.write(jsonArray.toString());
 
            // 5. BufferedWriter close
            writer.close();
			 
		} catch (IOException e) {
			// TODO: handle exception
			log.info("File writer Error :: ");
			e.printStackTrace();
		} catch (Exception e) {
			log.info("Detail api Export Error :: " + e);
			e.printStackTrace();
		}
		result.put("fileName", fileName);
		result.put("rowLength", jsonArray.size());
		
		return result;
	}
	
	// 상세 보고서
		@Override
		public Map<String, Object> reportDetailData(HttpServletRequest request, HashMap<String, Object> params) throws Exception {
			String tid = (String) params.get("TARGET_ID");
			int ap_no = Integer.parseInt(params.get("AP_NO").toString());
			//String status = (String) params.get("SCH_DATE");
			String reg_date = (String) params.get("sch_SDATE");
			String end_date = (String) params.get("sch_EDAT");
			String HostName = "";
			
			Map<String, Object> resultMap = new HashMap<>();
			Map<String, Object> result = new HashMap<>();
			
			List<Map<String, Object>> resultList = new ArrayList<>();
			List<Map<String, Object>> chunksResultList = new ArrayList<>();
			List<Map<String, Object>> matchResultList = new ArrayList<>();
			List<Map<String, Object>> metasResultList = new ArrayList<>();
			
			Map<String, Object> chunksResultMap =  new HashMap<String, Object>();
			Map<String, Object> matchResultMap =  new HashMap<String, Object>();
			Map<String, Object> metasResultMap =  new HashMap<String, Object>();
			
			ReconUtil reconUtil = new ReconUtil();
			Map<String, Object> httpsResponse = null;
			Map<String, Object> httpsResponse_summary = null;
			
			JsonParser parser = new JsonParser();
			
			Properties properties = new Properties();
			String resource = "/property/config.properties";
			
			StringBuffer sb = new StringBuffer();
			Gson gson = new Gson();
			int timeStamp = 0;
			JSONArray jsonArry = null;
			
			List<Map<String, Object>> dataTypeResultList = new ArrayList<>();
			Map<String, Object> dataTypeResultMap =  new HashMap<String, Object>();
			
			JSONObject jsonObject = null;
			Map<String, Object> targetMap = null;
			
			try {
				// 기간내 검색 기록이 있는지
				List<Map<String, Object>> searchData = summaryDao.getTargetByNode(params);
				
				Reader reader = Resources.getResourceAsReader(resource);
				
				for (Map<String, Object> map : searchData) {
					String target_id = (String) map.get("TARGET_ID");
					String hash_id = (String) map.get("HASH_ID");
					String fid = (String) map.get("INFO_ID");
					String host_name = (String) map.get("NAME");
					String agent_ip = (String) map.get("AGENT_CONNECTED_IP");
					String agent_connected = (String) map.get("AGENT_CONNECTED");
					String modified_date = (String) map.get("MODIFIED_DATE");
					String owner = (String) map.get("ACCOUNT");
					String chk = (String) map.get("CHK");
					String path = (String) map.get("PATH");
					HostName = host_name;
					
					boolean infoIDNull = false;
					
					if(chk.equals(">"))  infoIDNull = true; // 하위경로 존재 O
					else infoIDNull = false; // 하위경로 존재 X
					
					resultMap =  new HashMap<String, Object>();
					resultMap.put("fid", fid);
					resultMap.put("hash_id", hash_id);
					resultMap.put("target_id", tid);
					resultMap.put("ap_no", ap_no);
					resultMap.put("host_name", host_name);
					resultMap.put("agent_ip", agent_ip);
					resultMap.put("agent_connected", agent_connected);
					resultMap.put("CHK", chk);
					resultMap.put("owner", owner);
					resultMap.put("path", path);
					
					if(infoIDNull) { // 하위 경로 존재 O
						log.info("IT CONTAINS SUB PATH.(FID ID IS NULL)");
						
						resultMap.put("modified_dt", modified_date);
						
						Map<String, Object> infoID = summaryDao.getInfoId(resultMap);
						
						if(infoID.get("FID") != null) {
							resultMap.put("fid", infoID.get("FID"));
							fid = infoID.get("FID").toString();
							
							resultMap.put("subpath_hash_id", infoID.get("HASH_ID"));
							
							targetMap= summaryDao.getsubpathTotal(resultMap);
							
							// 주민번호
							int type1 = Integer.parseInt(targetMap.get("TYPE1").toString());
							// 외국인번호
							int type2 = Integer.parseInt(targetMap.get("TYPE2").toString());
							// 여권번호
							int type3 = Integer.parseInt(targetMap.get("TYPE3").toString());
							// 운전면허번호
							int type4 = Integer.parseInt(targetMap.get("TYPE4").toString());
							// 계좌번호
							int type5 = Integer.parseInt(targetMap.get("TYPE5").toString());
							// 카드번호
							int type6 = Integer.parseInt(targetMap.get("TYPE6").toString());
							// 이메일
							int type7 = Integer.parseInt(targetMap.get("TYPE7").toString());
							// 전화번호
							int type8 = Integer.parseInt(targetMap.get("TYPE8").toString());
							int total = type1 + type2 + type3 + type4 + type5 + type6 + type7 + type8; 
							
							resultMap.put("TYPE1", type1);
							resultMap.put("TYPE2", type2);
							resultMap.put("TYPE3", type3);
							resultMap.put("TYPE4", type4);
							resultMap.put("TYPE5", type5);
							resultMap.put("TYPE6", type6);
							resultMap.put("TYPE7", type7);
							resultMap.put("TYPE8", type8);
							resultMap.put("TYPE",total);
						}
					}
					
					properties.load(reader);
					
					String recon_url = (ap_no == 0) ? properties.getProperty("recon.url") : properties.getProperty("recon.url_" + (ap_no+1)) ;
					String recon_id = (ap_no == 0) ? properties.getProperty("recon.id") : properties.getProperty("recon.id_" + (ap_no+1)) ;
					String recon_password = (ap_no == 0) ? properties.getProperty("recon.password") : properties.getProperty("recon.password_" + (ap_no+1)) ;
					
					httpsResponse = reconUtil.getServerData(recon_id, recon_password, recon_url + "/" + api_ver + "/targets/" + target_id + "/matchobjects/" + fid + "?details=true", "GET", null);
					
					if((Integer) httpsResponse.get("HttpsResponseCode") == 200) {
						
						jsonObject = JSONObject.fromObject(httpsResponse.get("HttpsResponseData"));
						
						JSONArray matches = jsonObject.getJSONArray("matches");
						JSONArray chunks = jsonObject.getJSONArray("chunks");
						JSONArray metas = jsonObject.getJSONArray("metas");
						
						if(!infoIDNull) {
							log.info("IT DOES NOT INCLUDE SUB PATH.(FID ID IS NOT NULL)");
							resultMap.put("path", jsonObject.get("path"));
						}
						matchResultList = new ArrayList<>();
						chunksResultList = new ArrayList<>();
						metasResultList = new ArrayList<>();	
						
						for(int j = 0 ; j < matches.size() ; j++) {
							matchResultMap =  new HashMap<String, Object>();

							JSONObject M_resultObject = matches.getJSONObject(j);
		    				
							matchResultMap.put("match_CON", M_resultObject.getString("content"));
							matchResultMap.put("match_offset", M_resultObject.getString("offset"));
							matchResultMap.put("match_length", M_resultObject.getString("length"));
							matchResultMap.put("match_Type", M_resultObject.getString("data_type"));
							
							matchResultList.add(matchResultMap);
						}
						
						for(int j = 0 ; j < chunks.size() ; j++) {
							chunksResultMap =  new HashMap<String, Object>();

							JSONObject C_resultObject = chunks.getJSONObject(j);
		    				
							chunksResultMap.put("chunks_CON", C_resultObject.getString("content"));
							chunksResultMap.put("chunks_length", C_resultObject.getString("length"));
							chunksResultMap.put("chunks_offset", C_resultObject.getString("offset"));
							
							chunksResultList.add(chunksResultMap);
						}
						
						for(int j = 0 ; j < metas.size() ; j++) {
							metasResultMap =  new HashMap<String, Object>();
							
							JSONObject M_resultObject = metas.getJSONObject(j);
							
							if(M_resultObject.getString("label").equals("File Owner")) {
								resultMap.put("owner", M_resultObject.getString("value"));
							}else if(M_resultObject.getString("label").equals("File Modified")) {
								resultMap.put("Modified_Date", M_resultObject.getString("value"));
							}else if(M_resultObject.getString("label").equals("File Created")) {
								resultMap.put("Created_Date", M_resultObject.getString("value"));
							}else {
								metasResultMap.put("metas_type", M_resultObject.getString("label"));
								metasResultMap.put("metas_val", M_resultObject.getString("value"));
								metasResultList.add(metasResultMap);
							}
						}
						
						resultMap.put("chunksResultList", chunksResultList);
						resultMap.put("matchResultList", matchResultList);
						resultMap.put("metasResultList", metasResultList);
						resultList.add(resultMap);
						
					}else if((Integer) httpsResponse.get("HttpsResponseCode") == 404) {
						log.info("Recon path Delete :: Response Code 404");
					}
				}
				
			}catch (Exception e) {
				// TODO: handle exception
				e.getStackTrace();
				log.error("Detail Error :: " + e.toString());
			}
			
			log.info(resultList.toString());
			result.put("resultData", resultList);
			result.put("resultHost", HostName);
			result.put("resultCode", "200");
			
			return result;
		}
		
		private String numberFormat(String dataSize) {
			String fomatSize = "";
			
			Double size = Double.parseDouble(dataSize);
			
			if(size > 0) {
				
				String[] s = {"bytes", "KB", "MB", "GB", "TB", "PB" };
				
				int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
	            DecimalFormat df = new DecimalFormat("#,###.##");
	            double ret = ((size / Math.pow(1024, Math.floor(idx))));
	            fomatSize = df.format(ret) + " " + s[idx];
			}
			
			return fomatSize;
		}
		
		// 상세 보고서
			@Override
		public List<Map<String, Object>> reportTargetList(HttpServletRequest request, HashMap<String, Object> params) throws Exception {
			List<Map<String, Object>> result = new ArrayList<>();
			log.info(params.toString());
				
			try {
				result = summaryDao.getDetailReportServers(params);
			} catch (Exception e) {
				// TODO: handle exception
				log.info("Error : " + e.toString());
			}
				
			return result;
		}
}