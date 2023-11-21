package com.org.iopts.statistics.service.impl;

import java.io.Reader;
import java.net.ProtocolException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.org.iopts.statistics.dao.StatisticsDAO;
import com.org.iopts.statistics.service.StatisticsService;
import com.org.iopts.statistics.vo.StatisticsVo;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import scala.Console;

@Service
@Transactional
public class StatisticsServiceImpl implements StatisticsService{

	private static Logger logger = LoggerFactory.getLogger(StatisticsServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private StatisticsDAO dao;

	@Override
	public List<Map<String, Object>> statisticsList(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		List<Map<String, Object>> resultMap  =  dao.statisticsList(result);
		
		/*StatisticsVo vo = new StatisticsVo();
		*/
		for(Map<String, Object> map : resultMap) {
			String type = "";
			String max = "";
			String two_max = "";
			
			int rrnNum = Integer.parseInt(map.get("RRN").toString());
			int mobile_phone = Integer.parseInt(map.get("MOBILE_PHONE").toString());
			int account_num = Integer.parseInt(map.get("ACCOUNT_NUM").toString());
			int card_num = Integer.parseInt(map.get("CARD_NUM").toString());
			int foreigner = Integer.parseInt(map.get("FOREIGNER").toString());
			int driver = Integer.parseInt(map.get("DRIVER").toString());
			int email = Integer.parseInt(map.get("EMAIL").toString());
			int passport = Integer.parseInt(map.get("PASSPORT").toString());
			int max_result = Integer.parseInt(map.get("MAXRESULT").toString());
			int two_max_result = Integer.parseInt(map.get("TWOMAXRESULT").toString());
			
			if(rrnNum == max_result) {
				max = "주민등록번호";
			}
			if(mobile_phone == max_result) {
				if(max == "") {
					max = "휴대폰번호";
				}else {
					max += ", 휴대폰번호";
				}
			}
			if(account_num == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "계좌번호";
					}else {
						max += ", 계좌번호";
					}
				}
			}
			if(card_num == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "신용카드";
					}else {
						max += ", 신용카드";
					}
				}
			}
			if(foreigner == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "외국인번호";
					}else {
						max += ", 외국인번호";
					}
				}
			}
			if(driver == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "운전면허";
					}else {
						max += ", 운전면허";
					}
				}
				
			}
			if(email == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "이메일";
					}else {
						max += ", 이메일";
					}
				}
					
			}
			if(passport == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "여권번호";
					}else {
						max += ", 여권번호";
					}
				}
			}
			
			type = max;
			
			if(two_max_result != 0) {
				if(!(max.contains(","))) {
					if(rrnNum == two_max_result) {
						two_max = ", 주민등록번호";
					}else if(mobile_phone  == two_max_result){
						two_max = ", 휴대폰번호";
					}else if(account_num == two_max_result){
						two_max = ", 계좌번호";
					}else if(card_num  == two_max_result){
						two_max = ", 신용카드";
					}else if(foreigner  == two_max_result){
						two_max = ", 외국인번호";
					}else if(driver  == two_max_result){
						two_max = ", 운전면허";
					}else if(email  == two_max_result){
						two_max = ", 이메일";
					}else if(passport  == two_max_result){
						two_max = ", 여권번호";
					}
					type += two_max;
				}
			}
			map.put("TYPE", type);
		}
		logger.info("resultMap >> " + resultMap);
		
		return resultMap;
	}

    // 전체 서버 점검 결과 (의심 건수) 조회
	@Override
	public List<Map<String, Object>> manageList(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		List<Map<String, Object>> resultMap  =  dao.manageList(result);
		
        return resultMap;
	}

	@Override
	public List<Map<String, Object>> manageBarList(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		List<Map<String, Object>> resultMap  =  dao.manageBarList(result);
		
        return resultMap;
	}

	@Override
	public List<Map<String, Object>> mainChartStatistics(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		logger.info("mainChart >> " + result);
		
		List<Map<String, Object>> resultMap  =  dao.mainChartStatistics(result);
		
        return resultMap;
	}

	@Override
	public List<Map<String, Object>> TOPGridList(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		String prod = request.getParameter("prod");
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		result.put("prod", prod);
		
		List<Map<String, Object>> resultMap  =  dao.TOPGridList(result);
		
		for(Map<String, Object> map : resultMap) {
			String type = "";
			String max = "";
			String two_max = "";
			
			int rrnNum = Integer.parseInt(map.get("RRN").toString());
			int mobile_phone = Integer.parseInt(map.get("MOBILE_PHONE").toString());
			int account_num = Integer.parseInt(map.get("ACCOUNT_NUM").toString());
			int card_num = Integer.parseInt(map.get("CARD_NUM").toString());
			int foreigner = Integer.parseInt(map.get("FOREIGNER").toString());
			int driver = Integer.parseInt(map.get("DRIVER").toString());
			int email = Integer.parseInt(map.get("EMAIL").toString());
			int passport = Integer.parseInt(map.get("PASSPORT").toString());
			int max_result = Integer.parseInt(map.get("MAXRESULT").toString());
			int two_max_result = Integer.parseInt(map.get("TWOMAXRESULT").toString());
			
			if(rrnNum == max_result) {
				max = "주민등록번호";
			}
			if(mobile_phone == max_result) {
				if(max == "") {
					max = "휴대폰번호";
				}else {
					max += ", 휴대폰번호";
				}
			}
			if(account_num == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "계좌번호";
					}else {
						max += ", 계좌번호";
					}
				}
			}
			if(card_num == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "신용카드";
					}else {
						max += ", 신용카드";
					}
				}
			}
			if(foreigner == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "외국인번호";
					}else {
						max += ", 외국인번호";
					}
				}
			}
			if(driver == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "운전면허";
					}else {
						max += ", 운전면허";
					}
				}
				
			}
			if(email == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "이메일";
					}else {
						max += ", 이메일";
					}
				}
					
			}
			if(passport == max_result) {
				if(max.contains(",")) {
				}else {
					if(max == "") {
						max = "여권번호";
					}else {
						max += ", 여권번호";
					}
				}
			}
			
			type = max;
			
			if(two_max_result != 0) {
				if(!(max.contains(","))) {
					if(rrnNum == two_max_result) {
						two_max = ", 주민등록번호";
					}else if(mobile_phone  == two_max_result){
						two_max = ", 휴대폰번호";
					}else if(account_num == two_max_result){
						two_max = ", 계좌번호";
					}else if(card_num  == two_max_result){
						two_max = ", 신용카드";
					}else if(foreigner  == two_max_result){
						two_max = ", 외국인번호";
					}else if(driver  == two_max_result){
						two_max = ", 운전면허";
					}else if(email  == two_max_result){
						two_max = ", 이메일";
					}else if(passport  == two_max_result){
						two_max = ", 여권번호";
					}
					type += two_max;
				}
			}
			map.put("TYPE", type);
		}
		logger.info("resultMap >> " + resultMap);
		
		return resultMap;
	}

	@Override
	public Map<String, Object> totalStatistics(HttpServletRequest request) {
		
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		logger.info("result >> " + result);
		Map<String, Object> resultMap = new HashMap<>();
		resultMap = dao.totalStatistics(result);
		
		if(resultMap == null) {

			Map<String, Object> map = new HashMap<>();
			int type = 0;
			String percentage = "0.0%";
			
			map.put("COUNT_TARGET_ID", type);
			map.put("COUNT_HASH_ID", type);
			map.put("TOTAL", type);

			map.put("TYPE1", type);
			map.put("TYPE1_PERCENTAGE", percentage);
			map.put("TYPE2", type);
			map.put("TYPE2_PERCENTAGE", percentage);
			map.put("TYPE3", type);
			map.put("TYPE3_PERCENTAGE", percentage);
			map.put("TYPE4", type);
			map.put("TYPE4_PERCENTAGE", percentage);
			map.put("TYPE5", type);
			map.put("TYPE5_PERCENTAGE", percentage);
			map.put("TYPE6", type);
			map.put("TYPE6_PERCENTAGE", percentage);
			map.put("TYPE7", type);
			map.put("TYPE7_PERCENTAGE", percentage);
			map.put("TYPE8", type);
			map.put("TYPE8_PERCENTAGE", percentage);
			
			resultMap = map;
		}
		
		return resultMap;
	}

	@Override
	public List<Object> selectDataImple(HttpServletRequest request) {
		String toDate = request.getParameter("toDate");
		String fromDate = request.getParameter("fromDate");
		
		Map<String, Object> result = new HashMap<>();
		
		result.put("toDate", toDate);
		result.put("fromDate", fromDate);
		
		
		logger.info("selectDataImple check");
		return dao.selectDataImple(result);
	}

	
	

}
