package com.org.iopts.mail.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.org.iopts.group.vo.DashScheduleServerVo;
import com.org.iopts.group.vo.GroupPCTargetVo;
import com.org.iopts.group.vo.GroupTargetVo;
import com.org.iopts.group.vo.GroupTomsVo;
import com.org.iopts.group.vo.GroupTreeServerVo;
import com.org.iopts.group.vo.GroupTreeVo;
import com.org.iopts.group.vo.PCGroupVo;
import com.org.iopts.group.vo.SchedulePCTargetVo;
import com.org.iopts.group.vo.ScheduleServerNotTargetVo;
import com.org.iopts.group.vo.ScheduleServerVo;
import com.org.iopts.group.vo.ScheduleUserVo;
import com.org.iopts.mail.vo.MailVo;
import com.org.iopts.mail.vo.UserVo;

public interface MailDAO {

	List<MailVo> serverGroupMail(Map<String, Object> map);

	List<MailVo> serverGroupMailUser(Map<String, Object> map);

	List<UserVo> selectUserList(Map<String, Object> userMap);

	List<UserVo> selectSendUserList(HashMap<String, Object> params);

	List<MailVo> selectDate();
	
	void templateInsert(Map<String, Object> input);
	
	String selectTemplate(String mailFlag);

	void templateUpdate(Map<String, Object> input);
	/*List<UserVo> selectApprovalList(HashMap<String, Object> params);
*/
	
	
}
