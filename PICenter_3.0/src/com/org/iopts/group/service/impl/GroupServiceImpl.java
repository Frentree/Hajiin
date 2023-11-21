package com.org.iopts.group.service.impl;

import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.org.iopts.group.dao.GroupDAO;
import com.org.iopts.group.service.GroupService;
import com.org.iopts.group.vo.DashScheduleServerVo;
import com.org.iopts.group.vo.GroupNetListVo;
import com.org.iopts.group.vo.GroupPCManagerVO;
import com.org.iopts.group.vo.GroupPCTargetVo;
import com.org.iopts.group.vo.GroupTargetVo;
import com.org.iopts.group.vo.GroupTomsVo;
import com.org.iopts.group.vo.GroupTreeServerVo;
import com.org.iopts.group.vo.GroupTreeVo;
import com.org.iopts.group.vo.LicenseGroupVo;
import com.org.iopts.group.vo.LicenseGroupsVo;
import com.org.iopts.group.vo.PCGroupVo;
import com.org.iopts.group.vo.SchedulePCTargetVo;
import com.org.iopts.group.vo.ScheduleServerNotTargetVo;
import com.org.iopts.group.vo.ScheduleServerVo;
import com.org.iopts.group.vo.ScheduleUserVo;
import com.org.iopts.group.vo.SubPathVo;
import com.org.iopts.util.SessionUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
@Transactional
public class GroupServiceImpl implements GroupService {

	private static Logger logger = LoggerFactory.getLogger(GroupServiceImpl.class);

	@Value("${recon.id}")
	private String recon_id;

	@Value("${recon.password}")
	private String recon_password;

	@Value("${recon.url}")
	private String recon_url;

	@Value("${recon.api.version}")
	private String api_ver;

	@Inject
	private GroupDAO dao;

	@Override
	public String selectUserGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectUserGroupList");
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
		if (user_grade.equals("9")) {

			// 서버 리스트
			List<GroupTomsVo> groupServer = dao.selectTargetGroupList(map);
			
			for (GroupTomsVo vo : groupServer) {
				name = vo.getName();
				
				// 서버 타겟 오브젝트
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getIdx());
				
				// 상위 그룹 일 경우
				if (vo.getUp_idx().equals("0")) {
					jSTObject.put("parent", "server");
				} else { // 하위 그룹
					jSTObject.put("parent", vo.getUp_idx());
					
					if(vo.getType() != 0) { // 서버인 경우
						data.put("target_id", vo.getTarget_id());
	
						if(vo.getAgent_connected().equals("1")) {
							icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
						} else {
							icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
						}
						
						if (!vo.getAgent_connected_ip().equals(" ")) {
							name += " (" + vo.getAgent_connected_ip() + ")";
						}
						
						name += " [0" + (vo.getAp_no() + 1) +"]";
						
					}else { // 그룹인 경우
						
					}
					
					data.put("name", vo.getName());
					jSTObject.put("icon", icon);
				}
				data.put("type", vo.getType());
				jSTObject.put("data", data);
				jSTObject.put("text", name);
				
				jArr.add(jSTObject);
			}
			
			jServerObject.put("id", "noGroup");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "server");
			jArr.add(jServerObject);
			
		} else if (user_grade.equals("0") || user_grade.equals("1") || user_grade.equals("7")) {
			List<GroupTargetVo> list = dao.selectUserPCTargets(map);
			for (GroupTargetVo vo : list) {
				String platform = vo.getPlatform();
				name = vo.getName();
				String mac_name = vo.getMac_name();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "pc");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
		}else if(user_grade.equals("2") || user_grade.equals("3")) {
			
			jServerObject.put("id", "mypc");
			jServerObject.put("text", "내 PC");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);
			
			List<GroupPCManagerVO> myPcList = dao.selectMyPcList(map);
			for (GroupPCManagerVO vo : myPcList) {
				JSONObject jSTObject = new JSONObject();
				name = vo.getName();
				String mac_name = vo.getMac_name();
				String platform = vo.getPlatform();
				
				if (!vo.getAgent_connected_ip().equals("")) {
					/*if(platform.substring(0,5).equals("Apple")) {
						mac_name += " (" + vo.getAgent_connected_ip() + ")";
					}else {
						name += " (" + vo.getAgent_connected_ip() + ")";
					}*/
					name += " (" + vo.getAgent_connected_ip() + ")";
				}
				
				jSTObject.put("id", vo.getTARGET_ID());
				/*if(platform.substring(0,5).equals("Apple")) {
					jSTObject.put("text", mac_name);
				}else {
					jSTObject.put("text", name);
				}*/
				jSTObject.put("text", name);
				jSTObject.put("parent", "mypc");
				jSTObject.put("connected", vo.getConnected()); 
				
				if(vo.getConnected().equals("1") && vo.getConnected() != null) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				jSTObject.put("icon", icon); 
				
				jArr.add(jSTObject);
			}
			
			List<GroupPCManagerVO> groupManager = dao.selectUserManagerGroupList(map);
			/* map.put("group", ""); */
			// 그룹 pc 포함 여부
			for (GroupPCManagerVO vo : groupManager) {
				JSONObject jSTObject = new JSONObject();
				
				jSTObject.put("id", vo.getInsa_code());
				jSTObject.put("text", vo.getTeam_name());
				jSTObject.put("parent", vo.getParent());
				jSTObject.put("connected", vo.getConnected());
				jSTObject.put("ap", vo.getAp_no());
				
				if (vo.getLevel() == 99) {
					if(!vo.getConnected().equals("0")) {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
					}
					jSTObject.put("icon", icon);
				} 
				
				jArr.add(jSTObject);
			}
			
		} else if (user_grade.equals("4") || user_grade.equals("5") || user_grade.equals("6") || user_grade.equals("7")) {
			List<GroupTargetVo> list = dao.selectUserServerTargets(map);
			for (GroupTargetVo vo : list) {
				name = vo.getName();
				String platform = vo.getPlatform();
				
				/*if(vo.getAp_no() != 0 && platform.substring(0,5).equals("Apple") ) {
					name = vo.getMac_name();
				}else {
					name = vo.getName();
				}*/
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}
				
				/*if(vo.getComdate() != null) {
					name += " (" + vo.getComdate() + ")";
				}*/
				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx());
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
		} else {
			List<GroupTargetVo> list = dao.selectUserTargets(map);
			for (GroupTargetVo vo : list) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "server");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}

		}

		/*logger.info(jArr.toString());*/

		return jArr.toString();
	}
	
	@Override
	public String selectUserListGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();
		
		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);

		if (user_grade.equals("9")) {
			
			// 서버 리스트
			List<GroupTomsVo> groupServer = dao.selectTomsGroupList(map);
			for (GroupTomsVo vo : groupServer) {
				name = vo.getName();
				
				// 서버 타겟 오브젝트
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getIdx());
				
				// 상위 그룹 일 경우
				if (vo.getUp_idx().equals("0")) {
					jSTObject.put("parent", "server");
				} else { // 하위 그룹
					jSTObject.put("parent", vo.getUp_idx());
					
					if(vo.getType() != 0) { // 서버인 경우
						data.put("target_id", vo.getTarget_id());

						if(vo.getAgent_connected().equals("1")) {
							icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
						} else {
							icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
						}
						
						if (!vo.getAgent_connected_ip().equals(" ")) {
							name += " (" + vo.getAgent_connected_ip() + ")";
						}
						
						name += " [0" + (vo.getAp_no() + 1) +"]";
						
					}else { // 그룹인 경우
						
					}
					
					data.put("name", vo.getName());
					jSTObject.put("icon", icon);
				}
				data.put("type", vo.getType());
				jSTObject.put("data", data);
				jSTObject.put("text", name);
				
				jArr.add(jSTObject);
			}
			
			jServerObject.put("id", "noGroup");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "server");
			jArr.add(jServerObject);
			
		} else if (user_grade.equals("4") || user_grade.equals("6") || user_grade.equals("7") || user_grade.equals("5")) {
			
			List<GroupTargetVo> list = dao.selectUserServerTargets(map);
			for (GroupTargetVo vo : list) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}
				
				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx());
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
		} else {
			List<GroupTargetVo> list = dao.selectUserTargets(map);
			for (GroupTargetVo vo : list) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}
				
				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "server");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
			
		}
		
		/*logger.info(jArr.toString());*/
		
		return jArr.toString();
	}
	
	

	@Override
	public String selectServerGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		map.put("user_no", user_no);
		map.put("ap_no", 0);
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		data.put("ap", 0);
		data.put("type", "0");
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
		jServerObject.put("id", "noGroup");
		jServerObject.put("text", "미분류");
		data.put("ap", 0);
		data.put("type", 0);
		jServerObject.put("data", data);
		jServerObject.put("parent", "server");
		jArr.add(jServerObject);
		

		if(user_grade.equals("9")) {
			
			try {
				
				List<ScheduleServerVo> groupServer = dao.selectScheduleServerList(map);
				
				logger.info("	logger.info(\"test1\"); >>> " + groupServer);
				
				for (ScheduleServerVo vo : groupServer) {
					
					name = vo.getName();
					if (!vo.getAgent_connected_ip().equals("")) {
						name += " / " + vo.getAgent_connected_ip();
					}
					logger.info("dsadf1");
					// 서버 타겟 오브젝트
					JSONObject jSTObject = new JSONObject();
					
					if (vo.getUp_idx().equals("0")) {
						jSTObject.put("parent", "server");
					} else {
						jSTObject.put("parent", vo.getUp_idx());
					}
						
					logger.info("dsadf2");
					data.put("ap", 0);
					data.put("type", vo.getType());
					
					logger.info("dsadf3");
					
					if (vo.getType() == 1) {
						if (vo.getAgent_connected_chk() == 1) {
							icon = request.getContextPath() + "/resources/assets/images/db.png";
						} else {
							if(!vo.isAgent_connected()) {
								icon = request.getContextPath() + "/resources/assets/images/server_dicon.png";
							}else {
								icon = request.getContextPath() + "/resources/assets/images/server_icon.png";
							}
						}
						
						
						if(vo.getComdate() != null && !vo.getComdate().equals("")) {
							name += " / " + vo.getComdate() ;
						}else {
							name += " / 미검색";
						}
						
						if(!vo.isAgent_connected()) {
							//name += " (연결안됨)"; 
						}
						
						jSTObject.put("icon", icon);
						data.put("name", vo.getName());
						data.put("core", vo.getCores());
						data.put("targets", vo.getTarget_id());
						data.put("location", vo.getLocation_id());
						data.put("agent_connected", vo.isAgent_connected());
						
						logger.info("data >>>> " + data);
					}

					
					jSTObject.put("id", vo.getIdx());
					jSTObject.put("text", name);
					jSTObject.put("data", data);
					jArr.add(jSTObject);
				}
				
				logger.info("test1");
				
				jServerObject.put("id", "group");
				jServerObject.put("text", "그룹");
				jServerObject.put("parent", "#");
				data.put("ap", 0);
				data.put("type", 3);
				jServerObject.put("data", data);
				jServerObject.put("parent", "#");
				jArr.add(jServerObject);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 서버 리

			/*// 서버 미분류 그룹 추가
			List<ScheduleServerNotTargetVo> notGroup = dao.selectScheduleServerNotGroup(map);
			for (ScheduleServerNotTargetVo vo : notGroup) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (!vo.getTarget_use().equals("")) {
					name += vo.getTarget_use();
				}
				if (vo.getAgent_connected_chk() == 1) {
					icon = request.getContextPath() + "/resources/assets/images/db.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/file.png";
				}
				data.put("ap", 0);
				data.put("type", "1");
				data.put("name", vo.getName());
				data.put("location", vo.getLocation_id());
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "noGroup");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}*/
		} else {
			List<ScheduleUserVo> list = dao.selectScheduleUser(map);
			for (ScheduleUserVo vo : list) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " / " + vo.getAgent_connected_ip();
				}

				/*if (!vo.getTarget_use().equals("")) {
					name += vo.getTarget_use();
				}*/
				
				if(vo.getComdate() != null && !vo.getComdate().equals("")) {
					name += " / " + vo.getComdate() ;
				}else {
					name +=" / 미검색";
				}

				if (vo.getAgent_connected_chk() == 1) {
					if(vo.getTarget_use().equals("Y")) {
						icon = request.getContextPath() + "/resources/assets/images/db.png";
					}else {
						icon = request.getContextPath() + "/resources/assets/images/d_db.png";
					}
					
				} else {
					if(vo.getTarget_use().equals("Y")) {
						icon = request.getContextPath() + "/resources/assets/images/server_icon.png";
					}else {
						icon = request.getContextPath() + "/resources/assets/images/server_dicon.png";
					}
				}
				data.put("ap", vo.getAp_no());
				data.put("type", "1");
				data.put("name", vo.getName());
				data.put("location", vo.getLocation_id());
				data.put("targets", vo.getTarget_id());
				data.put("core", vo.getCores());
				
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "server");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
		}
		logger.info("test2");
		logger.info(jArr.toString());
		
		

		return jArr.toString();
	}

	@Override
	public String selectDeptGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		map.put("user_no", user_no);
		map.put("ap_no", 1);
		map.put("user_grade", user_grade);
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "pc");
		jServerObject.put("text", "PC");
		data.put("type", 0);
		data.put("net_type", 99);
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
/*		jServerObject.put("id", "onedrive");
		jServerObject.put("text", "OneDrive");
		data.put("type", 0);
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);*/
		

		if (user_grade.equals("9")) {
			jServerObject.put("id", "sktoa");
			jServerObject.put("text", "OA망");
			data.put("type", 0);
			data.put("net_type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktut");
			jServerObject.put("text", "VDI");
			data.put("type", 0);
			data.put("net_type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "noGroupPC");
			jServerObject.put("text", "미분류");
			data.put("ap", 0);
			data.put("type", "0");
			data.put("net_type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);
			
			/*jServerObject.put("id", "sktoa_onedrive");
			jServerObject.put("text", "OA망");
			data.put("type", 0);
			jServerObject.put("data", data);
			jServerObject.put("parent", "onedrive");
			jArr.add(jServerObject);
			
			jServerObject.put("id", "sktut_onedrive");
			jServerObject.put("text", "VDI");
			data.put("type", 0);
			jServerObject.put("data", data);
			jServerObject.put("parent", "onedrive");
			jArr.add(jServerObject);
			
			jServerObject.put("id", "noGroup_onedrive");
			jServerObject.put("text", "미분류");
			data.put("ap", 0);
			data.put("type", "0");
			jServerObject.put("data", data);
			jServerObject.put("parent", "onedrive");
			jArr.add(jServerObject);*/
			
			/*// 그룹 망 추가
			jServerObject.put("id", "net");
			jServerObject.put("text", "망");
			data.put("ap", 0);
			data.put("type", 4);
			//jServerObject.put("state", "{'checkbox_disabled' : true}");
			jServerObject.put("data", data);
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);*/
			
			jServerObject.put("id", "onedrive");
			jServerObject.put("text", "OneDrive");
			data.put("ap", 0);
			data.put("type", 0);
			data.put("net_type", 99);
			//jServerObject.put("state", "{'checkbox_disabled' : true}");
			jServerObject.put("data", data);
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);
/*
			// 그룹 망 추가
			jServerObject.put("id", "type1");
			jServerObject.put("text", "OA(SOC)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type2");
			jServerObject.put("text", "OA(N-SOC)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type3");
			jServerObject.put("text", "유통망(서비스 ACE/TOP지점) - 검색 진행 불가(IP대역대 확인중)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type4");
			jServerObject.put("text", "유통망(대리점) - 검색 진행 불가(IP대역대 확인중)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type5");
			jServerObject.put("text", "유통망(F&U/미납센터, PS&M본사) - 검색 진행 불가(IP대역대 확인중)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("rules", "{'multiple': false}");
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type6");
			jServerObject.put("text", "VDI - 검색 진행 불가(IP대역대 확인중)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("rules", "{'multiple': false}");
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);
			
			jServerObject.put("id", "type7");
			jServerObject.put("text", "VDI(SOC)");
			data.put("ap", 0);
			data.put("type", 3);
			jServerObject.put("data", data);
			jServerObject.put("parent", "net");
			icon = request.getContextPath() + "/resources/assets/images/net.png";
			jServerObject.put("icon", icon);
			jArr.add(jServerObject);*/
			
			
			logger.info("selectSchedulePCList");
			List<ScheduleServerVo> groupPC = dao.selectSchedulePCList(map);

			for(ScheduleServerVo vo : groupPC) {
				
				String id = vo.getIdx();
				String platform = vo.getPlatform();
				
				/*if(vo.getAp_no() != 0 && platform.substring(0,5).equals("Apple") ) {
					name = vo.getMac_name();
				}else {
					name = vo.getName();
				}*/
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " / " + vo.getAgent_connected_ip();
				}

				JSONObject jSTObject = new JSONObject();
				data.put("ap", vo.getAp_no());
				data.put("type", (vo.getType() != 1 ? 0 : 1));
				
				if (vo.getType() == 1) {
					if(vo.getUp_idx().equals("onedrive")) {
						id += "_" + vo.getLocation_id();
						icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
						data.put("net_type", 3);
					}else if (vo.getAgent_connected_chk() == 1) {
						icon = request.getContextPath() + "/resources/assets/images/db.png";
						data.put("net_type", 2);
					} else {
						icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
						data.put("net_type", 1);
					}
					
					if(!vo.isAgent_connected() && !vo.getUp_idx().equals("onedrive")) {
						name += " (연결안됨)"; 
					}
					jSTObject.put("icon", icon);
					data.put("name", vo.getName());
					data.put("targets", vo.getTarget_id());
					data.put("location", vo.getLocation_id());
				} else if (vo.getType() == 2) {
					if (vo.getConnected() != 0) {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
					}
					jSTObject.put("icon", icon);
				}
				jSTObject.put("id", id);
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx());
				jSTObject.put("data", data);
				
				jArr.add(jSTObject);

			}
			
			/*logger.info("selectScheduleOneDriveList");
			List<ScheduleServerVo> groupOneDrive = dao.selectScheduleOneDriveList(map);

			for(ScheduleServerVo vo : groupOneDrive) {
				name = vo.getName();
				
				String id = vo.getIdx();
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				JSONObject jSTObject = new JSONObject();
				data.put("ap", vo.getAp_no());
				data.put("type", (vo.getType() != 1 ? 0 : 1));
				
				if (vo.getType() == 1) {
					id += "_" + vo.getLocation_id();
					icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
					
					if(!vo.isAgent_connected()) {
						name += " (연결안됨)"; 
					}
					jSTObject.put("icon", icon);
					data.put("name", vo.getName());
					data.put("targets", vo.getTarget_id());
					data.put("location", vo.getLocation_id());
				} else if (vo.getType() == 2) {
					if (vo.getConnected() != 0) {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
					}
					jSTObject.put("icon", icon);
				}
				jSTObject.put("id", id+"_onedrive");
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx()+"_onedrive");
				jSTObject.put("data", data);
				
				jArr.add(jSTObject);

			}*/
			
			
			/*List<GroupTreeVo> group = dao.selectUserGroupList(map);
			 map.put("group", ""); 
			// 그룹 pc 포함 여부
			for (GroupTreeVo vo : group) {
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getIdx());
				jSTObject.put("text", vo.getName());
				data.put("type", "0");
				jSTObject.put("data", data);
				jSTObject.put("parent", vo.getUp_idx());
				// jSTObject.put("icon", request.getContextPath() +
				// "/resources/assets/images/file.png");
				jArr.add(jSTObject);
			}

			// 서버 미분류 그룹 추가
			map.put("group", "");
			List<SchedulePCTargetVo> pcTarget = dao.selectSchedulePCTarget(map);
			for (SchedulePCTargetVo vo : pcTarget) {
				JSONObject jSTObject = new JSONObject();
				name = vo.getUser_name();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (!vo.getTarget_use().equals("")) {
					name += vo.getTarget_use();
				}

				icon = request.getContextPath() + "/resources/assets/images/file.png";

				data.put("ap", vo.getAp_no());
				data.put("type", "1");
				data.put("name", vo.getName());
				data.put("location", vo.getLocation_id());

				jSTObject.put("data", data);

				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getInsa_code());
				jSTObject.put("icon", icon);

				jArr.add(jSTObject);
			}

			jServerObject.put("id", "noGroupPC");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			map.put("group", "pc");
			pcTarget = dao.selectSchedulePCTarget(map);
			for (SchedulePCTargetVo vo : pcTarget) {
				JSONObject jSTObject = new JSONObject();

				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (!vo.getTarget_use().equals("")) {
					name += vo.getTarget_use();
				}

				icon = request.getContextPath() + "/resources/assets/images/file.png";

				data.put("ap", vo.getAp_no());
				data.put("type", "1");
				data.put("name", vo.getName());
				data.put("location", vo.getLocation_id());

				jSTObject.put("data", data);

				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("icon", icon);
				jSTObject.put("parent", "noGroupPC");
				jArr.add(jSTObject);
			}*/
		} else if(user_grade.equals("2") || user_grade.equals("3")) {

			logger.info("selectCenterAdminSchedule");
			
			jServerObject.put("id", "mypc");
			jServerObject.put("text", "내 PC");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);
			
			List<GroupPCManagerVO> myPcList = dao.selectMyPcList(map);
			for (GroupPCManagerVO vo : myPcList) {
				JSONObject jSTObject = new JSONObject();
				name = vo.getName();
				String mac_name = vo.getMac_name();
				String platform = vo.getPlatform();
				
				/*if (!vo.getAgent_connected_ip().equals("")) {
					if(platform.substring(0,5).equals("Apple")) {
						mac_name += " (" + vo.getAgent_connected_ip() + ")";
					}else {
						name += " (" + vo.getAgent_connected_ip() + ")";
					}
				}*/
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " / " + vo.getAgent_connected_ip();
				}
				
				jSTObject.put("id", vo.getTARGET_ID());
				/*if(platform.substring(0,5).equals("Apple")) {
					jSTObject.put("text", mac_name);
				}else {
					jSTObject.put("text", name);
				}*/
				jSTObject.put("text", name);
				jSTObject.put("parent", "mypc");
				jSTObject.put("connected", vo.getConnected());
				
				if(vo.getConnected().equals("1") && vo.getConnected() != null) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				jSTObject.put("icon", icon);
				
				jArr.add(jSTObject);
			}
			
			List<ScheduleServerVo> groupPC = dao.selectCenterAdminSchedule(map);

			for(ScheduleServerVo vo : groupPC) {
				name = vo.getName();
				
				String id = vo.getIdx();
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " / " + vo.getAgent_connected_ip();
				}

				JSONObject jSTObject = new JSONObject();
				data.put("ap", vo.getAp_no());
				data.put("type", (vo.getType() != 1 ? 0 : 1));
				
				if (vo.getType() == 1) {
					if(vo.getUp_idx().equals("onedrive")) {
						id += "_" + vo.getLocation_id();
						icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
					}else if (vo.getAgent_connected_chk() == 1) {
						icon = request.getContextPath() + "/resources/assets/images/db.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
					}
					
					if(!vo.isAgent_connected()) {
						name += " (연결안됨)"; 
					}
					jSTObject.put("icon", icon);
					data.put("name", vo.getName());
					data.put("targets", vo.getTarget_id());
					data.put("location", vo.getLocation_id());
				} else if (vo.getType() == 2) {
					if (vo.getConnected() != 0) {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
					}
					jSTObject.put("icon", icon);
				}
				jSTObject.put("id", id);
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx());
				jSTObject.put("data", data);
				jArr.add(jSTObject);

			}
			
			
		} else {
			List<ScheduleUserVo> list = dao.selectScheduleUser(map);
			for (ScheduleUserVo vo : list) {
				name = vo.getName();
				String platform = vo.getPlatform();
				
				/*if(vo.getAp_no() != 0 && platform.substring(0,5).equals("Apple") ) {
					name = vo.getMac_name();
				}else {
					name = vo.getName();
				}*/
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " / " + vo.getAgent_connected_ip();
				}

				if (vo.getAgent_connected_chk() == 1) {
					icon = request.getContextPath() + "/resources/assets/images/db.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
				}
				
				if(!vo.isAgent_connected()) {
					name += " (연결안됨)"; 
				}
				
				data.put("ap", vo.getAp_no());
				data.put("type", 1);
				data.put("name", vo.getName());
				data.put("location", vo.getLocation_id());
				data.put("targets", vo.getTarget_id());
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "pc");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}
		}
		return jArr.toString();
	}

	@Override
	public JSONArray selectExceptionServerList(Map<String, Object> map, HttpServletRequest request) throws Exception {

		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);

		// 서버 리스트
		List<GroupTreeServerVo> groupServer = dao.selectExceptionServerList(map);
		for (GroupTreeServerVo vo : groupServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			jSTObject.put("text", name);
			if (vo.getUp_idx().equals("0")) {
				jSTObject.put("parent", "server");
			} else
				jSTObject.put("parent", vo.getUp_idx());
			data.put("ap", "0");
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jArr.add(jSTObject);
		}

		if (!"N".equals(map.get("noGroup"))) {
			jServerObject.put("id", "noGroup");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "server");
			data.put("type", 1);
			jServerObject.put("data", data);
			jArr.add(jServerObject);
		}

		return jArr;
	}

	@Override
	public JSONArray selectExceptionHostList(Map<String, Object> map, HttpServletRequest request) throws Exception {

		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		String noGroupCheck = (String) map.get("test");

		List<GroupTreeServerVo> groupServer = null;

		if (noGroupCheck.equals("noGroup")) {
			groupServer = dao.selectExceptionNoGroupHostList(map);
		} else {
			// 서버 리스트
			groupServer = dao.selectExceptionHostList(map);
		}

		for (GroupTreeServerVo vo : groupServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			jSTObject.put("text", name);
			data.put("ap", "0");
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jArr.add(jSTObject);
		}

		return jArr;
	}

	/*
	 * 대시보드 스케줄 그룹화
	 */
	@Override
	public JSONArray selectDashSeverDept(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		logger.info("selectSeverDashDept");
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		data.put("type", "0");
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);

		List<DashScheduleServerVo> group = dao.selectDashSeverDept(map);
		List<String> targets = new ArrayList<>();
		String parentId = "";

		int count = 0;
		String name = "";

		data.put("type", "1");
		data.put("ap_no", 0);
		DashScheduleServerVo one = null;
		JSONObject jSTObject = new JSONObject();

		if (group.size() != 0) {
			count = 1;
			one = group.get(0);
			name = one.getRegdate() + "_";
			targets.add(one.getTarget_id());
			jSTObject.put("parent", "server");
			jSTObject.put("id", one.getId());
			parentId = one.getId();

		}

		for (int i = 1; i < group.size(); i++) {
			DashScheduleServerVo vo = group.get(i);

			if (!parentId.equals(vo.getId())) {
				jSTObject.put("text", name + count + "대");
				data.put("targets", targets);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
				targets.clear();
				count = 0;
			}
			jSTObject = new JSONObject();
			jSTObject.put("parent", "server");
			jSTObject.put("id", vo.getId());
			targets.add(vo.getTarget_id());
			name = vo.getRegdate() + "_";

			count++;

			parentId = vo.getId();
		}

		if (group.size() != 0) {
			jSTObject.put("text", name + count + "대");
			data.put("targets", targets);
			jSTObject.put("data", data);
			jArr.add(jSTObject);
			count = 0;
		}

		/*logger.info("selectSeverDashDept  >>> " + jArr.toString());*/

		return jArr;
	}

	@Override
	public JSONArray selectDashPCDept(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		logger.info("selectDashPCDept");
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "pc");
		jServerObject.put("text", "PC");
		data.put("type", "0");
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);

		List<DashScheduleServerVo> group = dao.selectDashPCDept(map);
		List<String> targets = new ArrayList<>();
		String parentId = "";

		int count = 0;
		String name = "";

		data.put("type", "1");
		data.put("ap_no", 0);
		DashScheduleServerVo one = null;
		JSONObject jSTObject = new JSONObject();

		if (group.size() != 0) {
			count = 1;
			one = group.get(0);
			name = one.getRegdate() + "_";
			targets.add(one.getTarget_id());
			jSTObject.put("parent", "pc");
			jSTObject.put("id", one.getId());
			parentId = one.getId();

		}

		for (int i = 1; i < group.size(); i++) {
			DashScheduleServerVo vo = group.get(i);

			if (!parentId.equals(vo.getId())) {
				jSTObject.put("text", name + count + "대");
				data.put("targets", targets);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
				targets.clear();
				count = 0;
			}
			jSTObject = new JSONObject();
			jSTObject.put("parent", "pc");
			jSTObject.put("id", vo.getId());
			targets.add(vo.getTarget_id());
			name = vo.getRegdate() + "_";

			count++;

			parentId = vo.getId();
		}

		if (group.size() != 0) {
			jSTObject.put("text", name + count + "대");
			data.put("targets", targets);
			jSTObject.put("data", data);
			jArr.add(jSTObject);
			count = 0;
		}

		/*logger.info("selectDashPCDept  >>> " + jArr.toString());*/

		return jArr;
	}

	@Override
	public JSONArray selectPCGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		if (user_grade.equals("9")) {
			jServerObject.put("id", "server");
			jServerObject.put("text", "서버");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);

			jServerObject.put("id", "pc");
			jServerObject.put("text", "PC");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktoa");
			jServerObject.put("text", "OA망");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktut");
			jServerObject.put("text", "VDI");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			// 서버 리스트
			List<GroupTreeServerVo> groupServer = dao.selectServerGroupList(map);
			for (GroupTreeServerVo vo : groupServer) {
				name = vo.getName();

				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
					// name = "<a href='#' class='targets' data-apno='0'
					// data-targetid="+vo.getIdx()+">" + name + "</a>";
				}

				// 서버 타겟 오브젝트
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getIdx());
				jSTObject.put("text", name);
				if (vo.getUp_idx().equals("0")) {
					jSTObject.put("parent", "server");
				} else
					jSTObject.put("parent", vo.getUp_idx());
				data.put("ap", "0");
				data.put("type", vo.getType());
				if (vo.getType() == 1) {

					if (vo.isAgent_connected() == true) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
					jSTObject.put("icon", icon);
				}
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}

			jServerObject.put("id", "noGroup");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "server");
			jArr.add(jServerObject);
			// 서버 미분류 그룹 추가
			List<GroupTargetVo> notGroup = dao.selectNotGroup(map);
			for (GroupTargetVo vo : notGroup) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", "0");
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "noGroup");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}

			List<PCGroupVo> group = dao.selectPCGroup(map);
			/* map.put("group", ""); */
			// 그룹 pc 포함 여부
			for (PCGroupVo vo : group) {
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getInsa_code());
				jSTObject.put("text", vo.getName());
				jSTObject.put("parent", vo.getUp_idx());
				// jSTObject.put("icon", request.getContextPath() +
				// "/resources/assets/images/file.png");

				if (vo.getType() == 1) { // 사용자
					if (vo.getT_cnt() != 0) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
						jSTObject.put("icon", icon);
					} else {
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
					jSTObject.put("icon", icon);
				}

				data.put("ap", 1);
				data.put("type", vo.getType());
				jSTObject.put("data", data);

				jArr.add(jSTObject);
			}

		} else {
			List<GroupTargetVo> list = dao.selectUserTargets(map);
			for (GroupTargetVo vo : list) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", String.valueOf(vo.getAp_no()));
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "server");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}

		}

		/*logger.info("selectPCGroup >> " + jArr.toString());*/

		return jArr;
	}
	
	@Override
	public JSONArray selectDashDeptList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectDashDeptList");
		
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		data.put("type", "0");
		jServerObject.put("data", data);
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
		// 서버 리스트
		List<DashScheduleServerVo> groupSever = dao.selectDashSeverDept(map);
		List<String> targetsSever = new ArrayList<>();
		String parentId = "";

		int count = 0;
		String name = "";

		data.put("type", "1");
		data.put("ap_no", 0);
		DashScheduleServerVo one = null;
		JSONObject jSTObjectSever = new JSONObject();

		if (groupSever.size() != 0) {
			count = 1;
			one = groupSever.get(0);
			name = one.getRegdate() + "_";
			targetsSever.add(one.getTarget_id());
			jSTObjectSever.put("parent", "server");
			jSTObjectSever.put("id", one.getId()+"_sever");
			parentId = one.getId();

		}

		for (int i = 1; i < groupSever.size(); i++) {
			DashScheduleServerVo vo = groupSever.get(i);

			if (!parentId.equals(vo.getId())) {
				jSTObjectSever.put("text", name + count + "대");
				data.put("targets", targetsSever);
				jSTObjectSever.put("data", data);
				jArr.add(jSTObjectSever);
				targetsSever.clear();
				count = 0;
			}
			jSTObjectSever = new JSONObject();
			jSTObjectSever.put("parent", "server");
			jSTObjectSever.put("id", vo.getId()+"_sever");
			targetsSever.add(vo.getTarget_id());
			name = vo.getRegdate() + "_";

			count++;

			parentId = vo.getId();
		}

		if (groupSever.size() != 0) {
			jSTObjectSever.put("text", name + count + "대");
			data.put("targets", targetsSever);
			jSTObjectSever.put("data", data);
			jArr.add(jSTObjectSever);
			count = 0;
		}
		
		return jArr;
		
	}

	// 그룹 데이터
	@Override
	public List<Map<String, Object>> selectGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		return dao.selectGroup(map);
	}

	// 그룹 데이터
	@Override
	public int moveTargetGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String group_id = (String) request.getParameter("group_id");
		String treeArr = request.getParameter("treeArr");
		int result = -1;
		//String[] treeArr = request.getParameterValues("treeArr");
		logger.info("Group move >> " + group_id + ", treeArr > " + treeArr);
		
		JSONArray treeJArr = JSONArray.fromObject(treeArr);
		List<String> dataArr = new ArrayList<>();

		
		for(int i = 0; i < treeJArr.size(); i++) {
			logger.info("Size >> " + treeArr.length());
			
			String data = (String) treeJArr.get(i);
			dataArr.add(data);
		}
		
		map.put("groupId", group_id);
		map.put("treeArr", dataArr);
		try {
			dao.updateTomsGroup(map);
			result = 1;
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}

	@Override
	public JSONArray selectTomsGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		/*String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		map.put("user_no", user_no);
		map.put("user_grade", user_grade);*/
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");

		data.put("type", 0);
		jServerObject.put("data", data);
		jArr.add(jServerObject);

		// 서버 리스트
		List<GroupTomsVo> groupServer = dao.selectTomsGroup(map);
		for (GroupTomsVo vo : groupServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			if (vo.getUp_idx().equals("0")) {
				jSTObject.put("parent", "server");
			} else {
				jSTObject.put("parent", vo.getUp_idx());

				data.put("target_id", vo.getTarget_id());

				if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					name += "(미설치)";
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("name", vo.getName());
				jSTObject.put("icon", icon);
			}
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			jArr.add(jSTObject);
		}


		jServerObject.put("id", "noGroup");
		jServerObject.put("text", "미분류");
		jServerObject.put("parent", "server");

		data.put("type", 0);
		jServerObject.put("data", data);
		jArr.add(jServerObject);

		// 서버 리스트
		List<GroupTomsVo> groupNotServer = dao.selectTomsNotGroup(map);
		for (GroupTomsVo vo : groupNotServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			jSTObject.put("parent", "noGroup");

			data.put("target_id", vo.getTarget_id());

			if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
				icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
			} else {
				name += "(미설치)";
				icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
			}
			data.put("name", vo.getName());
			jSTObject.put("icon", icon);
			
			
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			jArr.add(jSTObject);
		}
		/*logger.info("selectTomsGroup >> " + jArr.toString());*/

		return jArr;
	}
	/*

	@Override
	public JSONArray selectTomsNotGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "noGroup");
		jServerObject.put("text", "미분류");
		jServerObject.put("parent", "#");

		data.put("type", 0);
		jServerObject.put("data", data);
		jArr.add(jServerObject);

		// 서버 리스트
		List<GroupTomsVo> groupServer = dao.selectTomsNotGroup(map);
		for (GroupTomsVo vo : groupServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			jSTObject.put("parent", "noGroup");

			data.put("target_id", vo.getTarget_id());

			if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
				icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
			} else {
				name += "(미설치)";
				icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
			}
			data.put("name", vo.getName());
			jSTObject.put("icon", icon);
			
			
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			jArr.add(jSTObject);
		}

		logger.info("selectTomsNotGroup >> " + jArr.toString());

		return jArr;
	}
	*/
	/*
	 * 보안 모듈이 생성한 그룹화
	 */	
	@Override
	public JSONArray selectUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// 트리 아이콘 설정
		String icon = "";
		// 트리 이름 설정
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		jServerObject.put("id", "group");
		jServerObject.put("text", "그룹");
		jServerObject.put("parent", "#");

		data.put("type", 0);
		jServerObject.put("data", data);
		jArr.add(jServerObject);
		

		// 서버 리스트
		List<GroupTomsVo> groupServer = dao.selectTomsUserGroup(map);
		for (GroupTomsVo vo : groupServer) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			if (vo.getUp_idx().equals("0")) {
				jSTObject.put("parent", "group");
			} else {
				jSTObject.put("parent", vo.getUp_idx());

				data.put("target_id", vo.getTarget_id());
				if(vo.getType() != 0) {
					jSTObject.put("id", vo.getUp_idx() + "_" + vo.getIdx());
					if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
					} else {
						name += "(미설치)";
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
				}
				data.put("name", vo.getName());
				jSTObject.put("icon", icon);
			}
			data.put("type", vo.getType());
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			jArr.add(jSTObject);
		}

		return jArr;
	}

	/*
	 * 보안 모듈이 생성
	 */	
	@Override
	public JSONArray insertUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		String name = (String) request.getParameter("name");
		String idx = request.getParameter("idx");
		
		logger.info("NAME >>> " + name + ", IDX >>> " +idx.toString());
		
		map.put("name", name);
		map.put("up_idx", idx);
		
		dao.insertServerGroup(map);
		

		return selectUserCreateGroup(map, request);
	}
	
	/*
	 * 보안 모듈이 변경
	 */	
	@Override
	public int updateUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		int resultCode = -1;
		
		String name = (String) request.getParameter("name");
		String idx = request.getParameter("idx");
		try {
			logger.info("NAME >>> " + name + ", IDX >>> " +idx.toString());
			
			map.put("name", name);
			map.put("idx", idx);
			
			dao.updateServerGroup(map);
			resultCode = 0;
			
		} catch (Exception e) {
			logger.error(e.toString());
		}

		return resultCode;
	}
	
	/*
	 * 보안 모듈이 생성한 그룹 삭제
	 */	
	@Override
	public String deleteUserCreateGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		String groupArr = (String) request.getParameter("groupArr");
		String serverArr = (String) request.getParameter("serverArr");
		
		logger.info("NAME >>> " + groupArr.toString() + ", IDX >>> " +serverArr.toString());
		
		// 선택한 서버 삭제
		JSONArray serverJArr = JSONArray.fromObject(serverArr);
		
		for(int i = 0; i < serverJArr.size(); i++) {
			logger.info("Size >> " + serverJArr.size());
			JSONObject serverObj = serverJArr.getJSONObject(i);
			
			// 개개인 서버 삭제
			map.put("groupID", serverObj.get("groupID"));
			map.put("serverID", serverObj.get("serverID"));
			
			dao.deleteUserServer(map);
		}
		
		//선택한 그룹 삭제
		JSONArray groupJArr = JSONArray.fromObject(groupArr);
		List<String> groupList = new ArrayList<>();
		
		for(int i = 0; i < groupJArr.size(); i++) {
			logger.info("Size >> " + groupJArr.size());
			String groupID = (String) groupJArr.get(i);
			
			groupList.add(groupID);
		}
		map.put("groupList", groupList);
		
		// 그룹 삭제에 그룹이 선택 안된 경우
		
		logger.info(groupList.size() + " < 사이즈 ");
		if(groupList.size() != 0) {
			dao.deleteUserServerGroup(map);
			dao.deleteUserGroup(map);
		}
		
		return selectUserCreateGroup(map, request).toString();
	}
	

	/*
	 * 보안 모듈이 생성
	 */	
	@Override
	public JSONArray insertUserTargets(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String groupArr = request.getParameter("groupArr");
		String treeArr = request.getParameter("treeArr");
		int result = -1;
		logger.info("Group move >> " + groupArr + ", treeArr > " + treeArr);
		
		// 선택한 toms 자산정보
		JSONArray treeJArr = JSONArray.fromObject(treeArr);

		// 선택한 group
		JSONArray groupJArr = JSONArray.fromObject(groupArr);
		
		for(int i = 0; i < groupJArr.size(); i++) {
			String data = (String) groupJArr.get(i);
			// 그룹에 저장
			for(int j = 0; j < treeJArr.size(); j++) {
				map.put("group_id", data);
				map.put("toms_id", (String) treeJArr.get(j));

				dao.insertUserTargets(map);
			}
		}
		

		return selectUserCreateGroup(map, request);
	}
	
	
	
	@Override
	public String selectUserHostGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");

		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		

		jServerObject.put("id", "noGroup");
		jServerObject.put("text", "미분류");
		jServerObject.put("parent", "server");
		jArr.add(jServerObject);

		try {
			if (user_grade.equals("9")) {
//				jServerObject.put("id", "db");
//				jServerObject.put("text", "DB");
//				jServerObject.put("parent", "#");
//				jArr.add(jServerObject);
				
				// 서버 리스트
				List<GroupTomsVo> groupServer = dao.selectPICenterServer(map);
				icon = "";
				for (GroupTomsVo vo : groupServer) { 
					
					name = vo.getName(); 
					
					// 서버 타겟 오브젝트
					JSONObject jSTObject = new JSONObject();
					jSTObject.put("id", vo.getIdx());
					
					if(vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
						jSTObject.put("id", vo.getTarget_id());
					} else {
						jSTObject.put("id", vo.getIdx());
					}

					
					data.put("ap", vo.getAp_no());
					
						// 상위 그룹 일 경우
						if (vo.getUp_idx().equals("0")) {
							jSTObject.put("parent", "server");
						} else { // 하위 그룹
							jSTObject.put("parent", vo.getUp_idx());
							
							data.put("target_id", vo.getTarget_id());
							
							if(vo.getType() != 0) {
								if(vo.getAgent_connected().equals("1")) {
									icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
									if (!vo.getAgent_connected_ip().equals("")) {
										name += " (" + vo.getAgent_connected_ip() + ")";
									}
								} else {
									icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
									
								}
								name += " [0" + (vo.getAp_no() +1)+ "]";
								data.put("name", vo.getName());
								jSTObject.put("icon", icon);
							}
						}
						
						// name += "[" + vo.getAp_no() + "]";
					
					
					data.put("type", vo.getType());
					jSTObject.put("data", data);
					jSTObject.put("text", name);

					jArr.add(jSTObject);
				} 
				
				
			} else if (user_grade.equals("4") || user_grade.equals("5") || user_grade.equals("6")) {
				
				List<GroupTargetVo> list = dao.selectUserServerTargets(map);
				for (GroupTargetVo vo : list) {
					name = vo.getName();
					String platform = vo.getPlatform();
					
					if (!vo.getAgent_connected_ip().equals("")) {
						name += " (" + vo.getAgent_connected_ip() + ")";
					}

					if (vo.isAgent_connected() == true) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
					data.put("ap", String.valueOf(vo.getAp_no()));
					data.put("type", "1");
					JSONObject jSTObject = new JSONObject();
					jSTObject.put("id", vo.getTarget_id());
					jSTObject.put("text", name);
					jSTObject.put("parent", vo.getUp_idx());
					jSTObject.put("icon", icon);
					jSTObject.put("data", data);
					jArr.add(jSTObject);
				}
			} else {
				List<GroupTargetVo> list = dao.selectUserTargets(map);
				for (GroupTargetVo vo : list) {
					name = vo.getName();
					if (!vo.getAgent_connected_ip().equals("")) {
						name += " (" + vo.getAgent_connected_ip() + ")";
					}

					if (vo.isAgent_connected() == true) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
					data.put("ap", String.valueOf(vo.getAp_no()));
					data.put("type", "1");
					JSONObject jSTObject = new JSONObject();
					
					jSTObject.put("id", vo.getTarget_id());
					jSTObject.put("text", name);
					jSTObject.put("parent", "server");
					jSTObject.put("icon", icon);
					jSTObject.put("data", data);
					jArr.add(jSTObject);
				}

			}
		} catch (Exception e) {
			logger.error("Select Group Error :: " + e);
		}

	//	logger.info(jArr.toString());
		
		return jArr.toString();
	}
	
	@Override
	public String selectUserHostOneDriveList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectUserHostOneDriveList");
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		List<GroupNetListVo> netList = null;
		
		netList = dao.selectNetOneDriveList(map);
		
		jServerObject.put("id", "onedirve");
		jServerObject.put("text", "OneDrive");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
		for (int i = 0; i < netList.size(); i++) {
			GroupNetListVo vo = netList.get(i);
			String id = vo.getId();
			String location_id = vo.getLocation_id();
			jServerObject.put("text", vo.getName());
			data.put("name", vo.getOnedrive_name());
			data.put("type", vo.getType());
			jServerObject.put("data", data);
			jServerObject.put("target", id);
			jServerObject.put("id", location_id);
			jServerObject.put("parent", "onedirve");
			jServerObject.put("icon", request.getContextPath() + "/resources/assets/images/onedrive16px.png");
			jArr.add(jServerObject);
		}
		
		return jArr.toString();
		
	}

	@Override
	public JSONArray selectSubPath(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		logger.info("selectSubPath");
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		String hash_id = request.getParameter("hash_id");
		String tid = request.getParameter("tid");
		String ap_no = request.getParameter("ap_no");
		String icon = "";
		
		map.put("hash_id", hash_id);
		map.put("tid", tid);
		map.put("ap_no", ap_no);
		
		List<SubPathVo> subPathVo = dao.selectSubPath(map);
		for (SubPathVo vo : subPathVo) {
			jServerObject.put("id", vo.getIdx());
			jServerObject.put("text", vo.getName());
			jServerObject.put("parent", vo.getParent_id());
			jServerObject.put("ap_no", vo.getAp_no());
			
			icon = request.getContextPath() + "/resources/assets/images/file.png";
			jServerObject.put("icon", icon);
			
			if(vo.getFid() != null && !vo.getFid().equals("")) {
				data.put("type", 1);
				data.put("tid", vo.getTarget_id());
			} else {
				data.put("type", 0);
				data.put("tid", vo.getTarget_id());
			}
			jServerObject.put("data", data);
			jArr.add(jServerObject);
		}
		
		/*logger.info("selectSubPath End Json Data >>> " + jArr.toString());*/

		return jArr;
	}
	

	@Override
	public JSONArray selectNetList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		logger.info("selectNetList");
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		int netid = Integer.parseInt(map.get("netid").toString());

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		List<GroupNetListVo> netList = null;
		
		switch (netid) {
		case 0: // 망
			// 서버 리스트
			netList = dao.selectNetList(map);
			
			for (int i = 0; i < netList.size(); i++) {
				GroupNetListVo vo = netList.get(i);
				jServerObject.put("id", "TYPE" + vo.getId());
				jServerObject.put("text", vo.getName());
				data.put("type", vo.getType());
				data.put("name", vo.getName());
				jServerObject.put("data", data);
				jServerObject.put("parent", vo.getParent());
				jServerObject.put("icon", request.getContextPath() + "/resources/assets/images/net.png");
				jArr.add(jServerObject);
			}
			
			break;
			
		case 1: // 그룹
			jServerObject.put("id", "pc");
			jServerObject.put("text", "PC");
			data.put("type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktoa");
			jServerObject.put("text", "OA망");
			data.put("type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktut");
			jServerObject.put("text", "VDI");
			data.put("type", 99);
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

					
			netList = dao.selectGroupList(map);
			
			for (int i = 0; i < netList.size(); i++) {
				GroupNetListVo vo = netList.get(i);
				jServerObject.put("id", vo.getId());
				jServerObject.put("text", vo.getName());
				data.put("type", vo.getType());
				data.put("name", vo.getName());
				jServerObject.put("data", data);
				jServerObject.put("parent", vo.getParent());
				jArr.add(jServerObject);
			}
			
			break;
					
		case 2: // PC
			netList = dao.selectNetPCList(map);
			
			for (int i = 0; i < netList.size(); i++) {
				GroupNetListVo vo = netList.get(i);
				
				String name = vo.getName();
				String platform = vo.getPlatform();
				
				jServerObject.put("id", vo.getId());
				
				data.put("name", name);
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}else {
					name += " (연결안됨)";
				}
				
				jServerObject.put("text", name);
				
				data.put("type", vo.getType());
				
				jServerObject.put("data", data);
				jServerObject.put("parent", vo.getParent());
				jServerObject.put("icon", request.getContextPath() + "/resources/assets/images/pc_icon.png");
				jArr.add(jServerObject);
			}
			
			break;
			
		case 3: // OneDrive
			netList = dao.selectNetOneDriveList(map);
			
			for (int i = 0; i < netList.size(); i++) {
				GroupNetListVo vo = netList.get(i);
				String id = vo.getId();
				String location_id = vo.getLocation_id();
				jServerObject.put("text", vo.getName());
				data.put("name", vo.getName());
				data.put("type", vo.getType());
				jServerObject.put("data", data);
				jServerObject.put("target", id);
				jServerObject.put("id", location_id);
				jServerObject.put("parent", vo.getParent());
				jServerObject.put("icon", request.getContextPath() + "/resources/assets/images/onedrive16px.png");
				jArr.add(jServerObject);
			}
			
			break;

		default:
			break;
		}
		
		return jArr;
		
	}
	
	@Override
	public String userReportGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();
		
		String typeChk = map.get("typeChk").toString();
		
		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		if (user_grade.equals("9")) {
			
			if(typeChk.equals("0")) {
				jServerObject.put("id", "server");
				jServerObject.put("text", "서버");
				jServerObject.put("parent", "#");
				jArr.add(jServerObject);
			}else if(typeChk.equals("1")) {
				jServerObject.put("id", "pc");
				jServerObject.put("text", "PC");
				jServerObject.put("parent", "#");
				jArr.add(jServerObject);
			}
			
			/*jServerObject.put("id", "db");
			jServerObject.put("text", "DB");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);
			
			jServerObject.put("id", "onedirve");
			jServerObject.put("text", "OneDrive");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);*/

			jServerObject.put("id", "sktoa");
			jServerObject.put("text", "OA망");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktut");
			jServerObject.put("text", "VDI");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			// 서버 리스트
			List<GroupTomsVo> groupServer = dao.selectReportTomsGroup(map);
			for (GroupTomsVo vo : groupServer) {
				name = vo.getName();

				// 서버 타겟 오브젝트
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getIdx());
				if(vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
					jSTObject.put("id", vo.getTarget_id());
				} else {
					jSTObject.put("id", vo.getIdx());
				}

				data.put("ap", vo.getAp_no());
				if(vo.getPlatform().equals("Remote Access Only")) {
					
					// 상위 그룹 일 경우
					if (vo.getUp_idx().equals("0")) {
						jSTObject.put("parent", "db");
					} else { // 하위 그룹
						jSTObject.put("parent", "db");
						
						data.put("target_id", vo.getTarget_id());
						icon = request.getContextPath() + "/resources/assets/images/db.png";
						
						data.put("name", vo.getName());
						jSTObject.put("icon", icon);
					}
				}else {
					// 상위 그룹 일 경우
					if (vo.getUp_idx().equals("0")) {
						jSTObject.put("parent", "server");
					} else { // 하위 그룹
						jSTObject.put("parent", vo.getUp_idx());
						
						data.put("target_id", vo.getTarget_id());
						
						// 서버 (그룹x)
						if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
							icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
						} else {
							name += "(미설치)";
							icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
						}
						data.put("name", vo.getName());
						jSTObject.put("icon", icon);
					}
				}

				data.put("type", vo.getType());
				jSTObject.put("data", data);
				jSTObject.put("text", name);

				jArr.add(jSTObject);
			}
			
			/*
			jServerObject.put("id", "noGroup");
			jServerObject.put("text", "미분류");
			jServerObject.put("parent", "server");
			jArr.add(jServerObject);
			jServerObject.put("id", "noGroupPC");
			jServerObject.put("text", "미분류");
			data.put("ap", 0);
			data.put("type", "0");
			jServerObject.put("data", data);
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);
			*/
			logger.info("selectPCList");
			List<ScheduleServerVo> groupPC = dao.selectReportGroupPCList(map);
			for(ScheduleServerVo vo : groupPC) {
				name = vo.getName();
				
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				JSONObject jSTObject = new JSONObject();
				data.put("ap", vo.getAp_no());
				data.put("type", (vo.getType() != 1 ? 0 : 1));
				/*
				if (vo.getType() == 1) {
					if(vo.getUp_idx().equals("onedirve")) {
						icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
						
					}else if (vo.getAgent_connected_chk() == 1) {
						icon = request.getContextPath() + "/resources/assets/images/db.png";
						data.put("name", "onedrive");
					} else {
						icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
						data.put("name", vo.getName());
					}
					
					if(!vo.isAgent_connected()) {
						name += " (연결안됨)"; 
					}
					jSTObject.put("icon", icon);
					data.put("location", vo.getLocation_id());
				} else if (vo.getType() == 2) {
					if (vo.getConnected() != 0) {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
					}
					jSTObject.put("icon", icon);
				}
				*/
				jSTObject.put("id", vo.getIdx());
				jSTObject.put("text", name);
				jSTObject.put("parent", vo.getUp_idx());
				jSTObject.put("data", data);
				jArr.add(jSTObject);

			}
			
			// 서버 미분류 그룹 추가
			/*List<GroupTargetVo> notGroup = dao.selectNotGroup(map);
			for (GroupTargetVo vo : notGroup) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", "0");
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "noGroup");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}*/

			/*map.put("group", "pc");
			List<GroupPCTargetVo> pcTarget = dao.selectPCTarget(map);
			for (GroupPCTargetVo vo : pcTarget) {
				JSONObject jSTObject = new JSONObject();

				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}

				data.put("ap", vo.getAp_no());
				data.put("type", "1");
				jSTObject.put("data", data);

				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("icon", icon);
				jSTObject.put("parent", "noGroupPC");
				jArr.add(jSTObject);
			}*/
		
		}

		/*logger.info(jArr.toString());*/

		return jArr.toString();
	}
	
	@Override
	public String userReportHostList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		map.put("user_no", user_no);
		map.put("user_grade", user_grade);
		// TODO Auto-generated method stub
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();
		
		String typeChk = map.get("typeChk").toString();
		
		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();

		if (user_grade.equals("9")) {
			
			if(typeChk.equals("0")) {
				jServerObject.put("id", "server");
				jServerObject.put("text", "서버");
				jServerObject.put("parent", "#");
				jArr.add(jServerObject);
			}else if(typeChk.equals("1")) {
				jServerObject.put("id", "pc");
				jServerObject.put("text", "PC");
				jServerObject.put("parent", "#");
				jArr.add(jServerObject);
			}
			
			/*jServerObject.put("id", "db");
			jServerObject.put("text", "DB");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);
			
			jServerObject.put("id", "onedirve");
			jServerObject.put("text", "OneDrive");
			jServerObject.put("parent", "#");
			jArr.add(jServerObject);*/

			jServerObject.put("id", "sktoa");
			jServerObject.put("text", "OA망");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			jServerObject.put("id", "sktut");
			jServerObject.put("text", "VDI");
			jServerObject.put("parent", "pc");
			jArr.add(jServerObject);

			if(typeChk.equals("0")) {
				
				// 서버 리스트
				List<GroupTomsVo> groupServer = dao.selectTomsGroup(map);
				for (GroupTomsVo vo : groupServer) {
					name = vo.getName();
					
					// 서버 타겟 오브젝트
					JSONObject jSTObject = new JSONObject();
					jSTObject.put("id", vo.getIdx());
					if(vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
						jSTObject.put("id", vo.getTarget_id());
					} else {
						jSTObject.put("id", vo.getIdx());
					}
					
					data.put("ap", vo.getAp_no());
					if(vo.getPlatform().equals("Remote Access Only")) {
						
						// 상위 그룹 일 경우
						if (vo.getUp_idx().equals("0")) {
							jSTObject.put("parent", "db");
						} else { // 하위 그룹
							jSTObject.put("parent", "db");
							
							data.put("target_id", vo.getTarget_id());
							icon = request.getContextPath() + "/resources/assets/images/db.png";
							
							data.put("name", vo.getName());
							jSTObject.put("icon", icon);
						}
					}else {
						// 상위 그룹 일 경우
						if (vo.getUp_idx().equals("0")) {
							jSTObject.put("parent", "server");
						} else { // 하위 그룹
							jSTObject.put("parent", vo.getUp_idx());
							
							data.put("target_id", vo.getTarget_id());
							
							// 서버 (그룹x)
							if (vo.getTarget_id() != null && !vo.getTarget_id().equals("")) {
								icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
							} else {
								name += "(미설치)";
								icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
							}
							data.put("name", vo.getName());
							jSTObject.put("icon", icon);
						}
					}
					
					data.put("type", vo.getType());
					jSTObject.put("data", data);
					jSTObject.put("text", name);
					
					jArr.add(jSTObject);
				}
				
				jServerObject.put("id", "noGroup");
				jServerObject.put("text", "미분류");
				jServerObject.put("parent", "server");
				jArr.add(jServerObject);
				
				// 서버 미분류 그룹 추가
				List<GroupTargetVo> notGroup = dao.selectNotGroup(map);
				for (GroupTargetVo vo : notGroup) {
					name = vo.getName();
					/*if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}*/
					
					/*if(vo.getComdate() != null) {
					name += " (" + vo.getComdate() + ")";
				}*/
					
					if (vo.isAgent_connected() == true) {
						icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
					} else {
						icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
					}
					data.put("ap", "0");
					data.put("type", "1");
					JSONObject jSTObject = new JSONObject();
					jSTObject.put("id", vo.getTarget_id());
					jSTObject.put("text", name);
					jSTObject.put("parent", "noGroup");
					jSTObject.put("icon", icon);
					jSTObject.put("data", data);
					jArr.add(jSTObject);
				}
			}else {
				jServerObject.put("id", "noGroupPC");
				jServerObject.put("text", "미분류");
				data.put("ap", 0);
				data.put("type", "0");
				jServerObject.put("data", data);
				jServerObject.put("parent", "pc");
				jArr.add(jServerObject);
				
				logger.info("selectPCList");
				List<ScheduleServerVo> groupPC = dao.selectPCList(map);
				for(ScheduleServerVo vo : groupPC) {
					name = vo.getName();
					String platform = vo.getPlatform();
					
					/*if(vo.getAp_no() != 0 && platform.substring(0,5).equals("Apple") ) {
						name = vo.getMac_name();
					}else {
						name = vo.getName();
					}*/
					if (!vo.getAgent_connected_ip().equals("")) {
						name += " (" + vo.getAgent_connected_ip() + ")";
					}else {
						name += " (연결안됨)";
					}

					JSONObject jSTObject = new JSONObject();
					data.put("ap", vo.getAp_no());
					data.put("type", (vo.getType() != 1 ? 0 : 1));
					
					if (vo.getType() == 1) {
						if(vo.getUp_idx().equals("onedirve")) {
							icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
							
						}else if (vo.getAgent_connected_chk() == 1) {
							icon = request.getContextPath() + "/resources/assets/images/db.png";
							data.put("name", "onedrive");
						} else {
							icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
							data.put("name", vo.getName());
						}
						
						/*if(!vo.isAgent_connected()) {
							name += " (연결안됨)"; 
						}*/
						jSTObject.put("icon", icon);
						data.put("location", vo.getLocation_id());
					} else if (vo.getType() == 2) {
						if (vo.getConnected() != 0) {
							icon = request.getContextPath() + "/resources/assets/images/img_pc_con.png";
						} else {
							icon = request.getContextPath() + "/resources/assets/images/img_pc_dicon.png";
						}
						jSTObject.put("icon", icon);
					}
					
					jSTObject.put("id", vo.getIdx());
					jSTObject.put("text", name);
					jSTObject.put("parent", vo.getUp_idx());
					jSTObject.put("data", data);
					jArr.add(jSTObject);

				}
			}
			
			// 서버 미분류 그룹 추가
			/*List<GroupTargetVo> notGroup = dao.selectNotGroup(map);
			for (GroupTargetVo vo : notGroup) {
				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}
				data.put("ap", "0");
				data.put("type", "1");
				JSONObject jSTObject = new JSONObject();
				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("parent", "noGroup");
				jSTObject.put("icon", icon);
				jSTObject.put("data", data);
				jArr.add(jSTObject);
			}*/

			/*map.put("group", "pc");
			List<GroupPCTargetVo> pcTarget = dao.selectPCTarget(map);
			for (GroupPCTargetVo vo : pcTarget) {
				JSONObject jSTObject = new JSONObject();

				name = vo.getName();
				if (!vo.getAgent_connected_ip().equals("")) {
					name += " (" + vo.getAgent_connected_ip() + ")";
				}

				if (vo.isAgent_connected() == true) {
					icon = request.getContextPath() + "/resources/assets/images/icon_con.png";
				} else {
					icon = request.getContextPath() + "/resources/assets/images/icon_dicon.png";
				}

				data.put("ap", vo.getAp_no());
				data.put("type", "1");
				jSTObject.put("data", data);

				jSTObject.put("id", vo.getTarget_id());
				jSTObject.put("text", name);
				jSTObject.put("icon", icon);
				jSTObject.put("parent", "noGroupPC");
				jArr.add(jSTObject);
			}*/
		
		}

		/*logger.info(jArr.toString());*/

		return jArr.toString();
	}
	
	@Override
	public String selectPopupServerGroupList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		// TODO Auto-generated method stub
		String user_no = SessionUtil.getSession("memberSession", "USER_NO");
		String user_grade = SessionUtil.getSession("memberSession", "USER_GRADE");
		
		logger.info("map >>>> " + map);
		
		map.put("user_no", user_no);
		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		jServerObject.put("id", "all");
		jServerObject.put("text", "전체");
		jServerObject.put("parent", "#");
		data.put("ap", 0);
		data.put("type", "0");
		jServerObject.put("data", data);
		jArr.add(jServerObject);
		
		
		List<ScheduleServerVo> serverList = new ArrayList<>();
		
		try {
			/*int is_server = dao.selectServer(map);*/
			
			serverList = dao.selectScheduleUserGroup1(map);
			/*
			if(is_server != 3) { // OneDrive가 아닌 경우
				serverList = dao.selectScheduleUserGroup1(map);
			}else {
				serverList = dao.selectScheduleUserGroup2(map);
			}
			*/
			
			for (ScheduleServerVo vo : serverList) {
				
				jServerObject.put("id", vo.getId());
				jServerObject.put("text", vo.getName());
				data.put("type", "1");
				data.put("ap", vo.getAp_no());
				data.put("name", vo.getName());
				data.put("is_server", vo.getType());
				jServerObject.put("data", data);
				jServerObject.put("parent", "all");
				
				
				if(vo.getType() == 0) { // PC
					if(vo.isAgent_connected()) {
						icon = request.getContextPath() + "/resources/assets/images/server_icon.png";
					}else {
						icon = request.getContextPath() + "/resources/assets/images/server_dicon.png";
					}
					
				}else if(vo.getType() == 1) { // 서버
					icon = request.getContextPath() + "/resources/assets/images/pc_icon.png";
					
				}else if(vo.getType() == 2) {
					
				}else if(vo.getType() == 3) { // OneDrive
					icon = request.getContextPath() + "/resources/assets/images/onedrive16px.png";
				}
				
				jServerObject.put("icon", icon);
				jArr.add(jServerObject);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return jArr.toString();
	}
	
	@Override
	public JSONArray selectLicenseGroup(Map<String, Object> map, HttpServletRequest request) throws Exception {

		String icon = "";
		String name = "";
		Map<String, Object> data = new HashMap<String, Object>();
		
        String toDate = request.getParameter("toDate");
        String fromDate = request.getParameter("fromDate");
        map.put("toDate", toDate);
        map.put("fromDate", fromDate);

		Map<String, Object> serverMap = new HashMap<String, Object>();

		serverMap.put("toDate", toDate);
		serverMap.put("fromDate", fromDate);

		JSONArray jArr = new JSONArray();
		JSONObject jServerObject = new JSONObject();
		
		jServerObject.put("id", "all");
		jServerObject.put("text", "전체");
		jServerObject.put("parent", "#");

		data.put("type", 0);
		data.put("parent_name", "");
		jServerObject.put("data", data);
		jArr.add(jServerObject);
		
		jServerObject.put("id", "group");
		jServerObject.put("text", "그룹");
		jServerObject.put("parent", "all");

		jServerObject.put("data", data);
		jArr.add(jServerObject);
		
		// 서버 리스트
		//List<LicenseGroupVo> group = dao.selectLicenseGroup(map);
		//List<LicenseGroupVo> server = dao.selectLicenseServer(map); 
		
		//List<LicenseGroupVo> group = new ArrayList<>() ;
		List<LicenseGroupsVo> group = dao.selectLicenseGroup(map);
		List<LicenseGroupsVo> server = dao.selectLicenseServer(map); 
		
		// List<LicenseGroupVo> noGroup = dao.selectLicenseNoGroup(map);
		
		for (LicenseGroupsVo vo : group) {
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx()); 
			
			/*if(!vo.getTeam().equals("0")) {
				if(vo.getTeam().equals("1")) {
					// icon = request.getContextPath() + "/resources/assets/images/group_icon2.png";
				}else {
					// icon = request.getContextPath() + "/resources/assets/images/group_icon.png";
				}
				// jSTObject.put("icon", icon);
			}*/
			
			jSTObject.put("parent", vo.getUp_idx().equals("0") ? "group" : vo.getUp_idx());
			
			String byteDt = byteDataCompare(vo.getIdx(), group) + "";
			String accByteDt = byteAccDataCompare(vo.getIdx(), group) + "";
			
			data.put("team",vo.getTeam());
			data.put("usage", byteDt);
			data.put("diff_usage", accByteDt);
			data.put("parent_name", vo.getParent_group());
			
			name += numberFormat(accByteDt);
			
			jSTObject.put("icon", null);
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			jArr.add(jSTObject);
		}

		data = new HashMap<String, Object>();
		jServerObject.put("id", "noGroup");
		jServerObject.put("text", "미그룹");
		jServerObject.put("parent", "all");

		data.put("type", 0);
		data.put("parent_name", "");
		jServerObject.put("data", data);
		jArr.add(jServerObject);
		

		jServerObject.put("id", "deleteServer");
		jServerObject.put("text", "삭제된서버"); 
		jServerObject.put("parent", "all");

		data.put("type", 0);
		data.put("parent_name", "");
		jServerObject.put("data", data);
		jArr.add(jServerObject);
		
		for (LicenseGroupsVo vo : server) {
			
			name = vo.getName();

			// 서버 타겟 오브젝트
			JSONObject jSTObject = new JSONObject();
			jSTObject.put("id", vo.getIdx());
			
			jSTObject.put("parent", vo.getUp_idx());
			data.put("target_id", vo.getTarget_id());
			icon = request.getContextPath() + "/resources/assets/images/server_icon.png";
			data.put("name", name);
			jSTObject.put("icon", icon);
			
			String retFormat = "0";
			// 넘버 포벳 변경
			data.put("usage", vo.getLicense_usage());
			data.put("diff_usage", vo.getDiff_license_usage());
			name += numberFormater(vo.getDiff_license_usage());
			
			jSTObject.put("parent", vo.getUp_idx());

			data.put("team", vo.getTeam());
			data.put("stype", vo.getStype());
			data.put("target_id", vo.getTarget_id());
			jSTObject.put("data", data);
			jSTObject.put("text", name);

			
			jArr.add(jSTObject);
		}
		
		return jArr;
	}
	
	private long byteDataCompare(String idx, List<LicenseGroupsVo> licentscList) {
		long result = 0;
		
		for(LicenseGroupsVo vo : licentscList) {
			if(!vo.getIdx().equals(idx) && vo.getUp_idx().equals("0")) {
				continue;
			} 
			
			if(vo.getIdx().equals(idx)) {
				result += vo.getLicense_usage();
			} else if(vo.getUp_idx().equals(idx) && !vo.getUp_idx().equals("0")) {
				result += byteDataCompare(vo.getIdx(), licentscList);
			}
		}
		
		return result;
	}
	
	private long byteAccDataCompare(String idx, List<LicenseGroupsVo> licentscList) {
		long result = 0;
		
		for(LicenseGroupsVo vo : licentscList) {
			if(!vo.getIdx().equals(idx) && vo.getUp_idx().equals("0")) {
				continue;
			} 
			
			if(vo.getIdx().equals(idx)) {
				result += vo.getDiff_license_usage();
			} else if(vo.getUp_idx().equals(idx) && !vo.getUp_idx().equals("0")) {
				result += byteAccDataCompare(vo.getIdx(), licentscList);
			}
		}
		
		return result;
	}
	
	private long byteData(String idx, List<LicenseGroupVo> licentscList) {
		long result = 0;
		
		for(LicenseGroupVo vo : licentscList) {
			if(!vo.getIdx().equals(idx) && vo.getUp_idx().equals("0")) { 
				continue;
			}
			
			if(vo.getIdx().equals(idx)) {
				result += Long.parseLong(vo.getData_usage());
			} else if(vo.getUp_idx().equals(idx) && !vo.getUp_idx().equals("0")) {
				result += byteData(vo.getIdx(), licentscList);
			}
		}
		
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
            fomatSize = "("+ df.format(ret) + " " + s[idx] +")";
		}
		
		return fomatSize;
	}
	
	private String numberFormater(Long dataSize) {
		String fomatSize = "";
		
		Double size = (double) dataSize;
		
		if(size > 0) {
			
			String[] s = {"bytes", "KB", "MB", "GB", "TB", "PB" };
			
			int idx = (int) Math.floor(Math.log(size) / Math.log(1024));
			DecimalFormat df = new DecimalFormat("#,###.##");
			double ret = ((size / Math.pow(1024, Math.floor(idx))));
			fomatSize = "("+ df.format(ret) + " " + s[idx] +")";
		}
		
		return fomatSize;
	}
	
	private String sumName(String idx, String up_idx, List<LicenseGroupVo> groupList) {
		String result = "";
		
		for(LicenseGroupVo vo : groupList) {
			
			if(vo.getIdx().equals(idx)) {
				if(result.equals("")) {
					result += vo.getName() ;
				}else {
					result += " / "+ vo.getName();
				}
			}else if(vo.getIdx().equals(up_idx)) {
				if(result.equals("")) {
					result += sumName(vo.getIdx(), vo.getUp_idx(),groupList);
				}else {
					result = sumName(vo.getIdx(), vo.getUp_idx(),groupList) + "/" + result;
				}
			}
		}
		return result;
	}
	
	private String sumName2(String idx, String up_idx, List<LicenseGroupVo> groupList, String name) {
		String result = "";
		
		for(LicenseGroupVo vo : groupList) {
			if(vo.getIdx().equals(idx) && vo.getIdx().equals("0") && vo.getUp_idx().equals("0")) {
				continue;
			}
			
			if(vo.getIdx().equals(up_idx) && !vo.getIdx().equals("0") ) {
				
				if(result.equals("")) {
					result = sumName(vo.getIdx(), vo.getUp_idx(), groupList);
				}else {
					result = sumName(vo.getIdx(), vo.getUp_idx(), groupList) + " / " + result;
				}
			}
			
		}
		
		return result;
	}
	
	public JSONArray selectNASList(Map<String, Object> map, HttpServletRequest request) throws Exception {
		JSONArray jArr = new JSONArray();
		 
		JSONObject jServerObject = new JSONObject();
		jServerObject.put("id", "server");
		jServerObject.put("text", "서버");
		jServerObject.put("parent", "#");
		jArr.add(jServerObject);
		
		try {
			List<Map<String,Object>> list = dao.selectNASList(map);

			String icon = request.getContextPath();
			
			logger.info("list :::: " + list);
			
			for (Map<String, Object> data : list) {
				
				logger.info("data :::: " + data);
				
				String up_idx = "";
				int type = Integer.parseInt(data.get("TYPE").toString());
				
				if(data.get("UP_IDX").equals("0")) {
					up_idx = "server";
				}else {
					up_idx = (String) data.get("UP_IDX");
				}
				
				
				
				data.put("type", type);
				data.put("ap", data.get("AP_NO"));
				data.put("name", data.get("NAME"));
				data.put("target_id", data.get("TARGET_ID"));
				data.put("location_id", data.get("LOCATION_ID"));
				data.put("agent_connected_ip", data.get("AGENT_CONNECTED_IP"));
				
				String id = data.get("IDX").toString();
				
				if(type == 1) {
					jServerObject.put("icon", icon + "/resources/assets/images/server_icon.png");
				} else if(type ==2 ) {
					jServerObject.put("icon", icon + "/resources/assets/images/file.png");
				}
				
				jServerObject.put("id", id);
				jServerObject.put("text", data.get("NAME"));
				jServerObject.put("data", data);
				jServerObject.put("parent", up_idx);

				jArr.add(jServerObject);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		
		logger.info("jArr ::: " + jArr);
		return jArr;
	}
}
