package com.org.iopts.setting.service.impl;

import java.io.IOException;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

// import org.apache.http.ParseException;
import org.apache.ibatis.io.Resources;
import org.jdom2.Document;
import org.jdom2.Element;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.org.iopts.cbh.scbh000001.SCBH000001;
import com.org.iopts.cbh.scbh000001.vo.GetSmsInfoVo;
import com.org.iopts.csp.comm.Config;
import com.org.iopts.csp.comm.CspUtil;
import com.org.iopts.csp.comm.vo.HeaderVo;
import com.org.iopts.csp.comm.vo.ResultVo;
import com.org.iopts.dao.Pi_ScanDAO;
import com.org.iopts.dao.Pi_TargetDAO;
import com.org.iopts.dao.Pi_UserDAO;
import com.org.iopts.setting.dao.Pi_SetDAO;
import com.org.iopts.setting.service.Pi_SetService;
import com.org.iopts.util.ReconUtil;
import com.org.iopts.util.ServletUtil;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class Pi_SetServiceImpl implements Pi_SetService {

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;
	
	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private Pi_SetDAO dao;
	
	private static Logger logger = LoggerFactory.getLogger(Pi_SetServiceImpl.class);

	@Override
	public List<Map<Object, Object>> selectSetting() throws Exception {
		List<Map<Object, Object>> resultList = dao.selectSetting();
		List<Map<Object, Object>> setting = new ArrayList<>();
		
		for (Map<Object, Object> map : resultList) {
			Map<Object, Object> resultMap = new HashMap<>();
			resultMap.put(map.get("NAME"), map.get("STATUS"));
			resultMap.put("NAME", map.get("DETAIL_NAME"));
			setting.add(resultMap);
		}
		return setting;
	}
	
	@Override
	public List<Map<String, Object>> patternList(HttpServletRequest request) {
		return dao.patternList();
	}
}
