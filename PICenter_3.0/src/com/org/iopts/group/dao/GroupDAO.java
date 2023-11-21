package com.org.iopts.group.dao;

import java.util.List;
import java.util.Map;

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

public interface GroupDAO {
	List<GroupTreeVo> selectUserGroupList(Map<String, Object> map) throws Exception;
	
	// 서버 그룹 리스트(서버 포함)
	List<GroupTreeServerVo> selectServerGroupList(Map<String, Object> map) throws Exception;
	
	List<GroupTreeServerVo> selectExceptionServerList(Map<String, Object> map) throws Exception;
	
	// PC 타겟 리스트
	List<GroupPCTargetVo> selectPCTarget(Map<String, Object> map) throws Exception;
	
	List<GroupTargetVo> selectNotGroup(Map<String, Object> map) throws Exception;
	
	// 자기 자산 목록
	List<GroupTargetVo> selectUserTargets(Map<String, Object> map) throws Exception;
	
	// 중간관리자 담당 시스템 (PC)
	List<GroupTargetVo> selectUserPCTargets(Map<String, Object> map) throws Exception;
	
	// 서버운영자 담당 시스템 (서버/PC)
	List<GroupTargetVo> selectUserServerTargets(Map<String, Object> map) throws Exception;
	
	// 스케줄 서버 리스트
	List<ScheduleServerVo> selectScheduleServerList(Map<String, Object> map) throws Exception;

	// 스케줄 중간관리자 PC 리스트
	List<ScheduleServerVo> selectCenterAdminSchedule(Map<String, Object> map) throws Exception;
	
	// 스케줄 PC 리스트
	List<ScheduleServerVo> selectSchedulePCList(Map<String, Object> map) throws Exception;
	
	// 스케줄 OneDrive 리스트
	List<ScheduleServerVo> selectScheduleOneDriveList(Map<String, Object> map) throws Exception;
	
	// 스케줄 유저 서버
	List<ScheduleUserVo> selectScheduleUser(Map<String, Object> map) throws Exception;
	
	// 스케줄 서버 리스트(미그룹)
	List<ScheduleServerNotTargetVo> selectScheduleServerNotGroup(Map<String, Object> map) throws Exception;
	
	// 스케줄 PC
	List<SchedulePCTargetVo> selectSchedulePCTarget(Map<String, Object> map) throws Exception;
	
	// 대시보드 서버
	List<DashScheduleServerVo> selectDashSeverDept(Map<String, Object> map) throws Exception;
	
	// 대시보드 PC
	List<DashScheduleServerVo> selectDashPCDept(Map<String, Object> map) throws Exception;
	
	// 대시보드 PC
	List<PCGroupVo> selectPCGroup(Map<String, Object> map) throws Exception;

	List<GroupTreeServerVo> selectExceptionHostList(Map<String, Object> map);

	List<GroupTreeServerVo> selectExceptionNoGroupHostList(Map<String, Object> map);

	//그룹 데이터
	List<Map<String, Object>> selectGroup(Map<String, Object> map);
	
	//SKT Toms 데이터
	List<GroupTomsVo> selectTomsGroup(Map<String, Object> map);
	List<GroupTomsVo> selectTomsGroupList(Map<String, Object> map);
	List<GroupTomsVo> selectReportTomsServerGroup(Map<String, Object> map);
	
	List<GroupTomsVo> selectTargetGroupList(Map<String, Object> map);
	
	//SKT Toms 미그룹 데이터
	List<GroupTomsVo> selectTomsNotGroup(Map<String, Object> map);
	
	List<ScheduleServerVo> selectPCList(Map<String, Object> map) throws Exception;
	
	void updateTomsGroup(Map<String, Object> map);
	
	List<GroupTomsVo> selectTomsUserGroup(Map<String, Object> map);

	void insertServerGroup(Map<String, Object> map);
	
	void updateServerGroup(Map<String, Object> map);

	void insertUserTargets(Map<String, Object> map);

	void deleteUserServer(Map<String, Object> map);

	void deleteUserServerGroup(Map<String, Object> map);

	void deleteUserGroup(Map<String, Object> map);
	
	List<SubPathVo> selectSubPath(Map<String, Object> map) throws Exception;
	
	List<GroupNetListVo> selectNetList(Map<String, Object> map) throws Exception;
	List<GroupNetListVo> selectGroupList(Map<String, Object> map) throws Exception;
	List<GroupNetListVo> selectNetPCList(Map<String, Object> map) throws Exception;
	List<GroupNetListVo> selectNetOneDriveList(Map<String, Object> map) throws Exception;
	
	// 중간관리자 PC 조직도
	List<GroupPCManagerVO> selectUserManagerGroupList(Map<String, Object> map) throws Exception;
	
	List<ScheduleServerVo> selectReportGroupPCList(Map<String, Object> map) throws Exception;
	
	List<GroupTomsVo> selectReportTomsGroup(Map<String, Object> map);

	List<GroupPCManagerVO> selectMyPcList(Map<String, Object> map) throws Exception;

	List<ScheduleServerVo> selectScheduleUserGroup1(Map<String, Object> map) throws Exception;

	int selectServer(Map<String, Object> map) throws Exception;

	List<LicenseGroupsVo> selectLicenseGroup(Map<String, Object> map) throws Exception;
	
	List<LicenseGroupVo> selectLicenseNoGroup(Map<String, Object> map) throws Exception;
	
	List<LicenseGroupsVo> selectLicenseServer(Map<String, Object> map) throws Exception;
	
	List<LicenseGroupVo> searchLicenseGroup(Map<String, Object> map) throws Exception;
	
	List<LicenseGroupVo> searchLicenseServer(Map<String, Object> map) throws Exception;
	
	List<Map<String,Object>> selectNASList(Map<String, Object> map) throws Exception;

	List<GroupTomsVo> selectPICenterServer(Map<String, Object> map) throws Exception;
}
