package com.org.iopts.mail.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.mail.service.MailService;
import com.org.iopts.mail.vo.MailVo;
import com.org.iopts.mail.vo.UserVo;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/mail")
@Configuration
@PropertySource("classpath:/property/config.properties")
public class MailController {

	private static Logger logger = LoggerFactory.getLogger(MailController.class);

	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private MailService mailService;
	
	// 메일 발송
	@RequestMapping(value="/serverGroupMailContent", method={RequestMethod.POST})
	public @ResponseBody Map<String, Object> serverGroupMailContent(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("serverGroupMailContent");
		Map<String, Object> serverGroupMail = new HashMap<String, Object>();
		
		try {
			serverGroupMail = mailService.serverGroupMailContent(request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return serverGroupMail;
	}

	// 메일 발송
    @RequestMapping(value="/serverGroupMail", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> serverGroupMail(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
        logger.info("serverGroupMail");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, List<String>> serverGroupMail = new HashMap<String, List<String>>();
        
        try {
        	serverGroupMail = mailService.serverGroupMail(request);
        	resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "메일 발송이 완료되었습니다.");
		} catch (Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "메일 발송에 실패하였습니다.");
			e.printStackTrace();
		}
        
        return resultMap;
    }
    
    // 결재 관리 메일 발송
    @RequestMapping(value="/approvalSendMail", method={RequestMethod.POST})
	@ResponseBody
    public Map<String, Object> approvalSendMail(@RequestBody HashMap<String, Object> params) throws Exception 
	{
    	Map<String, Object> resultMap = new HashMap<String, Object>();
		List<UserVo> chargeMap = new ArrayList<>();

		try {

			chargeMap = mailService.approvalSendMail(params);
			
			if(chargeMap.get(0).getUser_email() != null) {
				resultMap.put("resultCode", 0);
				resultMap.put("resultMessage", "결재 요청을 등록 하였습니다. \n해당 기안자에게 메일 발송이 완료되었습니다.");
			}else {
				resultMap.put("resultCode", -1);
				resultMap.put("resultMessage", "결재 요청을 등록 하였습니다. \n해당 기안자에게 등록된 메일 주소가 없습니다.");
			}
			
		}
		catch (Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "결재 요청을 등록 하였습니다. \n메일발송에 실패하였습니다.");
			e.printStackTrace();
		}

		return resultMap;
    }
	
    @RequestMapping(value="/templateInsert", method={RequestMethod.POST})
    public @ResponseBody Map<String, Object> templateInsert(HttpSession session, HttpServletRequest request, Model model, HttpServletResponse response) throws Exception {
		logger.info("templateInsert");
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			mailService.templateInsert(request);
			resultMap.put("resultCode", 0);
			resultMap.put("resultMessage", "SUCCESS");
		}
		catch(Exception e) {
			resultMap.put("resultCode", -100);
			resultMap.put("resultMessage", "시스템오류입니다.</br>관리자에게 문의하세요.");
			e.printStackTrace();
		}
		
		return resultMap;
    }
	
}