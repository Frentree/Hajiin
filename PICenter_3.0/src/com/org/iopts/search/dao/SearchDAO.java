package com.org.iopts.search.dao;

import java.util.List;
import java.util.Map;

import com.org.iopts.search.vo.DataTypeVo;

public interface SearchDAO {

	void insertProfile(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getProfile(Map<String, Object> map) throws Exception;

	void updateProfile(Map<String, Object> map) throws Exception;

	int getDatatypesUserSize(String datatype_id) throws Exception;

	void updateStandardId(Map<String, Object> map) throws Exception;

	Map<String, Object> selectDataTypeById(Map<String, Object> map) throws Exception;

	void deleteProfile(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getPolicy(Map<String, Object> map) throws Exception;

	void deletePolicy(Map<String, Object> map) throws Exception;

	void modifyPolicy(Map<String, Object> map) throws Exception;

	void insertPolicy(Map<String, Object> map) throws Exception;

	void updateDatatypeInPolicy(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> getStatusList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> getUserList(Map<String, Object> map) throws Exception;

	void updateScanSchedule(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectScheduleGroup(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectScheduleTargets(Map<String, Object> map) throws Exception;
	
	int insertScheduleGroup(Map<String, Object> map) throws Exception;
	
	int insertScheduleGroupOneDrive(Map<String, Object> map) throws Exception;

	void failedSchedule(Map<String, Object> map) throws Exception;
	
	void insertScheduleTargets(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectScanDataTypes(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectSKTScanDataTypes(Map<String, Object> map) throws Exception;
	
	void updateConfirmApply(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectNetHost(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectSchedulePCStatus(Map<String, Object> map) throws Exception;
	
	int selectScheduleId() throws Exception;
	
	void updateScheduleGroupStatus(Map<String, Object> map) throws Exception;
	
	void insertNetPolicy(Map<String, Object> map) throws Exception;
	
	void insertOneDrivePolicy(Map<String, Object> map) throws Exception;
	
	void deleteNetPolicy(Map<String, Object> map) throws Exception;
	
	void updateNetPolicy(Map<String, Object> map) throws Exception;
	
	void updateOneDrivePolicy(Map<String, Object> map) throws Exception;
	
	void insertNetSchedule(Map<String, Object> map) throws Exception;
	
	void deleteNetSchedule(Map<String, Object> map) throws Exception;
	
	void updateNetSchedule(Map<String, Object> map) throws Exception;
	
	void updateNetTarget(Map<String, Object> map) throws Exception;
	
	void updateNetDeptTarget(Map<String, Object> map) throws Exception;
	
	void updateNetOneDrive(Map<String, Object> map) throws Exception;
	
	void updateNetStatus(Map<String, Object> map) throws Exception;
	
	void updateNetOneDriveTarget(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectPCPolicy(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectPCPolicyTime(Map<String, Object> map) throws Exception;
	
	void deletePCPolicy(Map<String, Object> map) throws Exception;
	
	void updatePCPolicy(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectPCSearchStatus(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectUpGroupPolicy(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectUpPCPolicy(Map<String, Object> map) throws Exception;
	
	void updateUpNetwork(Map<String, Object> map) throws Exception;

	Map<String, Object> selectUserSearchCount(Map<String, Object> map);

	List<Map<String, Object>> netList(Map<String, Object> map);

	void insertNetIp(Map<String, Object> map) throws Exception;
	
	void updateNetIp(Map<String, Object> map) throws Exception;
	
	void deleteNetIp(Map<String, Object> map) throws Exception;

	void updateScheduleStatus(Map<String, Object> scheduleMap) throws Exception;

	void deleteNetId(Map<String, Object> map) throws Exception;

	void deleteNetGroup(Map<String, Object> map) throws Exception;
	
	void deleteOneDriveNetId(Map<String, Object> map) throws Exception;
	
	void deleteOneDriveNetId2(Map<String, Object> map) throws Exception;

	int selectNetMask(Map<String, Object> map) throws Exception;

	void insertNetList(Map<String, Object> mapList) throws Exception;

	int selectNetIpCheck(Map<String, Object> map) throws Exception;

	Map<String, Object> selectTargetIdAll(Map<String, Object> map) throws Exception;
	
	Map<String, Object> selectTargetId(Map<String, Object> map) throws Exception;


}
