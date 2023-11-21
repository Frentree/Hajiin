package com.org.iopts.statistics.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.org.iopts.statistics.service.StatisticsService;
import com.org.iopts.statistics.vo.StatisticsVo;
import com.org.iopts.util.SessionUtil;

/**
 * Handles requests for the application home page.
 */

@Controller
@RequestMapping(value = "/statistics")
public class StatisticsController {

	private static Logger logger = LoggerFactory.getLogger(StatisticsController.class);
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private StatisticsService service;
	
	@RequestMapping(value = "/statisticsList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> statisticsList(HttpServletRequest request, Model model){
		logger.info("statisticsList");
		
		List<Map<String, Object>> resultMap = null ;
		try {
			resultMap = service.statisticsList(request);
			
			logger.info(resultMap.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
		
	}
    
	//  전체 서버 점검 결과(의심건수) 조회
	@RequestMapping(value = "/manageList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> manageList(HttpServletRequest request, Model model){
		logger.info("manageList");
      
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.manageList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		      
		return resultMap;
      
	}
	
	//  전체 서버 점검 결과(의심건수) 조회 - 그래프
	@RequestMapping(value = "/manageBarList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> manageBarList(HttpServletRequest request, Model model){
		logger.info("manageBarList");
      
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.manageBarList(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		      
		return resultMap;
      
	}
	
	// 메인 그래프
	/*@RequestMapping(value = "/mainChartStatistics", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> mainChartStatistics(HttpServletRequest request, Model model){
		logger.info("mainChartStatistics");
		
		List<Map<String, Object>> resultMap = null;
		try {
			resultMap = service.mainChartStatistics(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
		
	}*/
	
	// TOP5 정탐기준 - 운영서버 , 개발서버
	@RequestMapping(value = "/TOPGridList", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> TOPGridList(HttpServletRequest request, Model model){
		logger.info("TOPGridList");
		
		List<Map<String, Object>> resultMap = null ;
		try {
			resultMap = service.TOPGridList(request);
			
			logger.info(resultMap.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return resultMap;
		
	}
	
	// top그래프 데이터 값
	@RequestMapping(value = "/totalStatistics", method = { RequestMethod.POST })
	public @ResponseBody Map<String, Object> totalStatistics(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("totalStatistics");
		Map<String, Object> resultMap = service.totalStatistics(request);
		return resultMap;
	}
	
	
	@RequestMapping(value = "/dataImple", method = { RequestMethod.POST })
	public @ResponseBody List<Object> selectDashDataImple(HttpSession session, HttpServletRequest request, Model model,
			HttpServletResponse response) throws Exception {
		logger.info("selectDataImple");
		List<Object> datatypesList = service.selectDataImple(request);
		return datatypesList;
	}
	
	
}
