package com.org.iopts.group.controller;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.org.iopts.group.service.GroupService;
import com.org.iopts.search.service.SearchService;
import com.org.iopts.service.Pi_TargetService;

import net.sf.json.JSONArray;

@Controller
@RequestMapping(value = "/group")
@Configuration
@PropertySource("classpath:/property/config.properties")
public class GroupController {

	private static Logger logger = LoggerFactory.getLogger(GroupController.class);

	@Value("${recon.api.version}")
	private String api_ver;
	
	@Inject
	private GroupService groupService;
	
	@RequestMapping(value = "/groupList", method = {RequestMethod.GET, RequestMethod.POST})
	public String groupList(Model model, HttpSession session, HttpServletRequest request) 
	{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("resultCode", 1);
		resultMap.put("resultMessage", "Log-Out");

		Map<String, Object> map = new HashMap<>();
		map.put("noGroup", "Y");
		try {
			String userGroupList = groupService.selectUserGroupList(map, request);
			model.addAttribute("userGroupList", userGroupList);
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		return "group/group_list";
	}
	
	@RequestMapping(value = "/dashListDept", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> insertListProfile(HttpServletRequest request, Model model, HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		logger.info("dashListDept");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		
		Map<String,Object> result = new HashMap<>();
		try {
			JSONArray resultGroup = groupService.selectDashDeptList(map, request);
			result.put("data", resultGroup);
			result.put("resultCode", 1);
		}
		catch (Exception e) {
			result.put("resultCode", -1);
		}
		logger.info("dashListDept Data >>> " + result);
		
		return result;
		
	}
	
	@RequestMapping(value = "/dashServerDept", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> insertServerProfile(HttpServletRequest request, Model model, HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		logger.info("dashServerDept");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		
		Map<String,Object> result = new HashMap<>();
		try {
			JSONArray resultGroup = groupService.selectDashSeverDept(map, request);
			result.put("data", resultGroup);
			result.put("resultCode", 1);
		}
		catch (Exception e) {
			result.put("resultCode", -1);
		}
		logger.info("dashServerDept Data >>> " + result);
		
		return result;
		
	}
	
	@RequestMapping(value = "/dashPCDept", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> insertPCProfile(HttpServletRequest request, Model model, HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		logger.info("dashPCDept");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String fromDate = request.getParameter("fromDate");
		String toDate = request.getParameter("toDate");
		
		map.put("fromDate", fromDate);
		map.put("toDate", toDate);
		
		Map<String,Object> result = new HashMap<>();
		try {
			JSONArray resultGroup = groupService.selectDashPCDept(map, request);
			result.put("data", resultGroup);
			result.put("resultCode", 1);
		}
		catch (Exception e) {
			result.put("resultCode", -1);
		}
		logger.info("dashPCDept Data >>> " + result);
		
		return result;
		
	}
	
	@RequestMapping(value = "/moveTargetGroup", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> moveTargetGroup(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("moveTargetGroup");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			resultCode = groupService.moveTargetGroup(map, request);
			if(resultCode != -1) {
				JSONArray resultGroup = groupService.selectTomsGroup(map, request);
				result.put("data", resultGroup.toString());
				
				/*JSONArray resultNotGroup = groupService.selectTomsNotGroup(map, request);
				result.put("dataNot", resultNotGroup.toString());*/
			}
			
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		logger.info("moveTargetGroup Data >>> " + result);
		
		return result;
		
	}
	
	
	/*@RequestMapping(value = "/selectTomsNotGroup", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> selectTomsNotGroup(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("selectTomsNotGroup");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			JSONArray resultGroup = groupService.selectTomsNotGroup(map, request);
			result.put("data", resultGroup.toString());
			
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		logger.info("selectTomsNotGroup Data >>> " + result);
		
		return result;
		
	}*/
	
	@RequestMapping(value = "/insertUserCreateGroup", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> insertUserCreateGroup(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("insertUserCreateGroup");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			JSONArray resultGroup = groupService.insertUserCreateGroup(map, request);
			result.put("data", resultGroup.toString());
			resultCode = 0;
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		logger.info("insertUserCreateGroup Data >>> " + result);
		
		return result;
		
	}
	
	@RequestMapping(value = "/updateUserCreateGroup", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> updateUserCreateGroup(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("updateUserCreateGroup");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			resultCode = groupService.updateUserCreateGroup(map, request);
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		
		return result;
		
	}
	
	@RequestMapping(value = "/insertUserTargets", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> insertUserTargets(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("insertUserTargets");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			JSONArray resultGroup = groupService.insertUserTargets(map, request);
			result.put("data", resultGroup.toString());
			resultCode = 0;
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		logger.info("insertUserTargets Data >>> " + result);
		
		return result;
		
	}
	
	@RequestMapping(value = "/deleteUserCreateGroup", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> deleteUserCreateGroup(HttpServletRequest request, Model model, HttpServletResponse response){
		//response.setCharacterEncoding("UTF-8");
		logger.info("deleteUserCreateGroup");
		//logger.info("treeArr >>> " + treeArr);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String,Object> result = new HashMap<String,Object>();
		int resultCode = -1;
		
		try {
			String resultGroup = groupService.deleteUserCreateGroup(map, request);
			result.put("data", resultGroup.toString());
			resultCode = 0;
		}
		catch (Exception e) {
			logger.error(e.toString());
			result.put("resultCode", -1);
		}
		result.put("resultCode", resultCode);
		logger.info("deleteUserCreateGroup Data >>> " + result);
		
		return result;
		
	}
	

	@RequestMapping(value = "/netList", method = {RequestMethod.GET, RequestMethod.POST})
	public @ResponseBody Map<String,Object> netList(HttpServletRequest request, Model model, HttpServletResponse response){
		response.setCharacterEncoding("UTF-8");
		logger.info("netList");
		
		Map<String, Object> map = new HashMap<String, Object>();
		String netid = request.getParameter("netid");
		
		map.put("netid", netid);
		
		Map<String,Object> result = new HashMap<>();
		try {
			JSONArray resultGroup = groupService.selectNetList(map, request);
			result.put("data", resultGroup);
			result.put("resultCode", 1);
		}
		catch (Exception e) {
			result.put("resultCode", -1);
		}
		logger.info("netList Data >>> " + result);
		
		return result;
		
	}
}