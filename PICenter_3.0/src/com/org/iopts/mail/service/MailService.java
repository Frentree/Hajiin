package com.org.iopts.mail.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.group.vo.GroupTreeServerVo;
import com.org.iopts.mail.vo.MailVo;
import com.org.iopts.mail.vo.UserVo;

import net.sf.json.JSONArray;

public interface MailService {

	Map<String, List<String>> serverGroupMail(HttpServletRequest request) throws Exception;

	Map<String, Object> serverGroupMailContent(HttpServletRequest request) throws Exception;

	List<UserVo> approvalSendMail(HashMap<String, Object> params) throws Exception;
	
	Map<String, Object> templateInsert(HttpServletRequest request) throws Exception;
	
}
