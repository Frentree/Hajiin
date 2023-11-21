package com.org.iopts.service;

import java.io.IOException;
import java.io.Reader;
import java.net.ProtocolException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.org.iopts.dao.Pi_QuartzDAO;
import com.org.iopts.util.ReconUtil;

@Service
public class Pi_QuartzServiceImpl implements Pi_QuartzService {

	private static Logger logger = LoggerFactory.getLogger(Pi_ExceptionServiceImpl.class);
	private ReconUtil reconUtil;
	
	Properties properties; 
	String recon_url;
	String recon_id;
	String recon_password;
	
	public Pi_QuartzServiceImpl() {
		try {
			properties = new Properties();
			String resource = "/property/config.properties";
			Reader reader = Resources.getResourceAsReader(resource);
			
			properties.load(reader);
			
			this.reconUtil = new ReconUtil();
			
			this.recon_url = properties.getProperty("recon.url");
			this.recon_id = properties.getProperty("recon.id");
			this.recon_password = properties.getProperty("recon.password");
			
			this.logger.info("recon_url : " + recon_url);
			this.logger.info("recon_id : " + recon_id);
			this.logger.info("recon_pw : " + recon_password);
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// schedule resume pause 기능은 정시 마다 실행 
	@Override
	public void executeScanSchedule() {
		Pi_QuartzDAO dao = new Pi_QuartzDAO();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String scan_dtm = sdf.format(date);
		logger.info("[" + scan_dtm + "] executeScanSchedule START...");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("weekday", new SimpleDateFormat("EEE", Locale.ENGLISH).format(date).toLowerCase());
		map.put("work_hour", new SimpleDateFormat("HH", Locale.ENGLISH).format(date));
		
		List<Map<String, String>> changeList = dao.getChangeScheduleList(map);
		
		logger.info("[" + sdf.format(date) + "] ChangeSchedule size : " + changeList.size());
		
		for(int i=0; i<changeList.size(); i++) {
			Map<String, String> listMap = changeList.get(i);
			String schedule_id = listMap.get("SCHEDULE_ID");
			String work_cd = listMap.get("WORK_CD");
			String action = "";
			if("01".equals(work_cd)) {
				action = "resume";
			}else if("02".equals(work_cd)) {
				action = "pause";
			}
			if(!"".equals(action)) {
				changeScanSchedule(scan_dtm, schedule_id, action, dao);
			}
			
		}
		logger.info("[" + scan_dtm + "] executeScanSchedule END...");
	}

	// schedule stop 기능은 1분당 실행
	@Override
	public void executeStopSchedule() {
		Pi_QuartzDAO dao = new Pi_QuartzDAO();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String stop_dtm = sdf.format(date);
		logger.info("[" + stop_dtm + "] executeStopSchedule START...");
		
		List<Map<String, String>> stopList = dao.getStopScheduleList(stop_dtm);
		
		logger.info("[" + stop_dtm + "] StopSchedule size : " + stopList.size());
		for(int i=0; i<stopList.size(); i++) {
			Map<String, String> listMap = stopList.get(i);
			String schedule_id = listMap.get("SCHEDULE_ID");
			changeScanSchedule(stop_dtm, schedule_id, "stop", dao);
			dao.stopScanSchedule(stopList.get(i).get("SCHEDULE_ID"));
		}
		
		logger.info("[" + stop_dtm + "] executeStopSchedule END...");
		
	}

	private void changeScanSchedule(String dtm, String schedule_id, String action, Pi_QuartzDAO dao) {
		try {
			String url = this.recon_url + "/beta/schedules/" + schedule_id + "/" + action;
			String method = "POST";
			String requestData = "";
			Map<String, String> conHistMap = new HashMap<>();
			String seq = String.format("%03d", dao.getConnectHistSeq());
			logger.info("dtm : " + dtm);
			logger.info("seq : " + seq);
			
			conHistMap.put("id", dtm+seq);
			conHistMap.put("recon_id", this.recon_id);
			conHistMap.put("url", url);
			conHistMap.put("method", method);
			conHistMap.put("req_data", requestData);
			
			if(dao.insConnectHist(conHistMap) > 0) {
				
				Map<String, Object> resultMap = reconUtil.getServerData(this.recon_id, this.recon_password, url, method, requestData);
				conHistMap.put("rsp_cd", resultMap.get("HttpsResponseCode").toString());
				conHistMap.put("rsp_msg", resultMap.get("HttpsResponseMessage").toString());
				
				logger.info("[" + schedule_id + "] "+ action +"UPDATE DB Schedule result : " + dao.uptConnectHist(conHistMap));
				
				logger.info("[" + schedule_id + "] "+ action +"Schedule result : " + resultMap.get("HttpsResponseCode"));
				logger.info("[" + schedule_id + "] "+ action +"Schedule result : " + resultMap.get("HttpsResponseMessage"));
				
			};
			
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
