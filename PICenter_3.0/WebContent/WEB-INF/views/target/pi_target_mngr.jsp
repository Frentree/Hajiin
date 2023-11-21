<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<%@ include file="../../include/header.jsp"%>
<style>
.ui-state-hover td{
	background: #dadada !important;
}
.user_info th{
	width: 110px; 
}
.ui-jqgrid tr.ui-row-ltr td{
	cursor: pointer;
}
#pcAdminPopup .ui-jqgrid tr.ui-row-ltr td{
	cursor: default;
}
#left_datatype th, #left_datatype td {
	padding: 0;
}
.popup_tbl tbody td {
	height: 45px;
}
</style>
		<!-- section -->
		<section>
			<!-- container -->
			<div class="container minMenu">
				<h3 id= "headerText" style="display: inline; top: 25px;">대상조회 및 현행화</h3>
					<p id="commit" style="position: absolute; top: 32px; left: 228px; font-size: 13px; color: #9E9E9E;">관리 대상 서버의 상세 정보, 담당자 정보를 확인하고 필요 시 수정 할 수 있습니다.</p>
				<!-- content -->
				<div class="content magin_t35">
					<table class="user_info narrowTable" style="width: 70%;">
                    <caption>검색 현황</caption>
                    <tbody>
                        <tr>
                            <th class="user_info_th" style="text-align: center; border-radius: 0.25rem; padding: 5px 5px 0 5px;">그룹명</th>
                            <td class="user_info_td" style="padding: 5px 5px 0 5px;">
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="groupNm" placeholder="그룹명을 입력하세요.">
                            </td>
                            <th class="user_info_th" style="text-align: center; padding: 5px 5px 0 5px;">호스트명</th>
                            <td class="user_info_td" style="padding: 5px 5px 0 5px;">
                                <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="hostNm" placeholder="호스트명을 입력하세요.">
                            </td>
                            <th class="user_info_th" id="serviceNmText" style="text-align: center; padding: 5px 5px 0 5px;">서비스명</th>
                            <td class="user_info_td" style="padding: 5px 5px 0 5px;">
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="serviceNm" placeholder="서비스명을 입력하세요.">
                            </td>
                            <th class="user_info_th" style="text-align: center; padding: 5px 5px 0 5px;">IP</th>
							<td class="user_info_td" style="padding: 5px 5px 0 5px;">
								<input type="text" style="width: 186px; padding-left: 5px;" id="userIP" placeholder="IP를 입력하세요">
							</td>
                           	<td rowspan="4">
                           		<input type="button" name="button" class="btn_look_approval" id="serach_btn" style="margin-top: 2px;">
                           	</td>
                        </tr>
                        <tr id="infratbl">
                        	<th style="text-align: center; border-radius: 0.25rem;">인프라담당자명</th>
                            <td>
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="infraUser" placeholder="인프라담당자명을 입력하세요.">
                            </td>
                            <th style="text-align: center;">서비스담당자명</th>
                            <td>
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="20" id="serviceUser" placeholder="서비스담당자명을 입력하세요.">
                            </td>
                            <th style="text-align: center;">서비스관리자명</th>
                            <td>
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="serviceManager" placeholder="서비스관리자명을 입력하세요.">
                            </td>
                        </tr>
                    </tbody>
                	</table>
					<div class="left_area2" style="margin-top: 10px; height: 90%;">
						<div class="left_box2" style="max-height: 640px;">
		   					<div id="jstree" class="select_location" style="overflow-y: auto; overflow-x: auto; height: 627px; background: #ffffff; border: 1px solid #c8ced3; white-space:nowrap;">
								
							</div>
							<div id="div_search" class="select_location" style="overflow-y: auto; height: 513px; background: #ffffff; display: none;">
								<table id="Tbl_search" class="tbl_input" id="location_table">
									<tbody>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="grid_top" style="margin-left: 335px;">
						<div class="list_sch" style="position: relative; bottom: 26px;">
							<div class="sch_area">
								<!-- <button type="button" id="btnUploadExel" class="btn_down">업로드</button> -->
								<button type="button" id="btnDownloadServerExel" class="btn_down">다운로드</button>
								<button type="button" id="btnDownloadPCExel" class="btn_down" style="display: none;">다운로드</button>
							</div>
						</div> 
						<div class="left_box2" id="serverGridBox" style="position: relative; height: 640px; max-height: 640px; bottom: 17px; overflow: hidden;">
		   					<table id="serverGrid"></table>
		   				 	<div id="serverGridPager"></div>
		   				</div>
		   				<div class="left_box2" id="PCGridBox" style="position: relative; height: 690px; max-height: 690px; bottom: 16px; overflow: hidden; display: none;">
		   					<table id="PCGrid"></table>
		   				 	<div id="PCGridPager"></div>
		   				</div>
					</div>
					
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>
	
<!-- 팝업창 - 상세정보 시작 -->
<div id="targetPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 468px; width: 505px; left: 54%; top: 54%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleTargetPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">상세정보</h1>
			<p style="position: absolute; top: 16px; left: 88px; font-size: 12px; color: #9E9E9E;">담당하고 있는 서버 정보가 맞는지 확인 후 수정하시기 바랍니다.</p>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 391px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tbody>
						<tr>
							<th>그룹명</th>
							<td><input type="text" id="targetGroup" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>호스트명</th>
							<td>
								<input type="text" id="targetHost" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly>
								<input type="hidden" id="targetHostId" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly>
								<input type="hidden" id="targetHostApNo" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly>
							</td>
						</tr>
						<tr>
							<th>서비스명</th>
							<td><input type="text" id="targetService" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>IP</th>
							<td><input type="text" id="targetIP" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>업무 담당자(정)</th>
							<td><input type="text" id="targetSevermngr1" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrNm1" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrId1" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<input type="hidden" id="reachTargetMngr1No" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr1Nm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<button type="button" style="width: 63px; height: 27px;" onclick="userListWindows('mngr1')">선택</button></td>
						</tr>
						<tr>
							<th>업무 담당자(부)</th>
							<td><input type="text" id="targetSevermngr2" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrNm2" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrId2" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<input type="hidden" id="reachTargetMngr2No" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr2Nm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<button type="button" style="width: 63px; height: 27px;"  onclick="userListWindows('mngr2')">선택</button></td>
						</tr>
						<tr>
							<th>업무 담당자</th>
							<td><input type="text" id="targetSevermngr3" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrNm3" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="targetSevermngrId3" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<input type="hidden" id="reachTargetMngr3No" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr3Nm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr3Tm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr4No" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr4Nm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr4Tm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr5No" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr5Nm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								<input type="hidden" id="reachTargetMngr5Tm" value="" class="edt_sch" style="width: 218px; padding-left: 10px;" readonly>
								
								<button type="button" id="targetServiceManagerBtn" style="width: 63px; height: 27px;">조회</button></td>
						</tr>
						<tr>
							<th>적용 정책</th>
							<td>
								<input type="text" id="targetPolicy" value="" class="edt_sch" style="width: 285px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly>
								<input type="hidden" id="PCtargetPolicyID" value="">
							</td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btntargetSave">저장</button>
				<button type="button" id="btntargetCancel">취소</button>
			</div>
		</div>
	</div>
</div>

<div id="PCtargetPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 355px; width: 485px; left: 52%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCanclePCtargetPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png" style="z-index: 999;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">상세정보</h1>
			<p style="position: absolute; top: 12px; left: 88px; font-size: 13px; color: #9E9E9E;">담당하고 있는 대상 정보가 맞는지 확인 후 수정하시기 바랍니다.</p>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 290px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>그룹명</th>
							<td><input type="text" id="PCtargetGroup" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
						<th>호스트명</th>
							<td><input type="text" id="PCtargetHost" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>IP</th>
							<td><input type="text" id="PCtargetIP" value="" class="edt_sch" style="width: 300px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly></td>
						</tr>
						<tr>
							<th>담당자(소속)</th>
							<td><input type="text" id="PCtargetInfra" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								<input type="hidden" id="PCtargetInfraID" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								
								<input type="hidden" id="PCreachTargetInfra" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								<input type="hidden" id="PCreachTargetInfraID" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								
								<button type="button" id="PCtargetInfraBtn" style="width: 63px">선택</button></td>
						</tr>
						<tr>
							<th>중간관리자(소속)</th>
							<td><input type="text" id="PCtargetServiceUser" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								<input type="hidden" id="PCtargetServiceUserID" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								
								<input type="hidden" id="PCreachTargetServiceUser" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								<input type="hidden" id="PCreachTargetServiceUserID" value="" class="edt_sch" style="width: 233px; padding-left: 10px;" readonly>
								
								<!-- <button type="button" id="PCtargetServiceUserBtn" style="width: 63px">선택</button> -->
								<button type="button" id="PCtargetServiceUserViewBtn" style="width: 63px">보기</button></td>
						</tr>
						<tr>
							<th>적용 정책</th>
							<td>
								<input type="text" id="PCtargetPolicy" value="" class="edt_sch" style="width: 193px; padding-left: 10px; background-color: rgba(210, 210, 210, 0.35);" readonly>
								<input type="hidden" id="PCtargetPolicyID" value="">
								<input type="hidden" id="PCtargetEnable" value="">
								<button type="button" id="PCtargetPolicyViewBtn" style="width: 103px">개인정보 유형</button></td>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnPCtargetSave">저장</button>
				<button type="button" id="btnPCtargetCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 상세정보 종료 -->

<div id="pcAdminPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 758px; padding: 10px; background: #f9f9f9; left: 46%; top: 56%">
	<img class="CancleImg" id="btnCanclePCAdminPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png" style="z-index: 999;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">담당 중간관리자</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" id="div_update_user" style="height: auto; background: #fff; border: 1px solid #c8ced3;">
				<table id="targetUserGrid"></table>
				<div id="targetUserGridPager"></div>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnAdminClose">닫기</button>
			</div>
		</div>
	</div>
</div>

<div id="selectUserListPopup" class="popup_layer" style="display:none"> 
	<div class="popup_box" style="height: 290px; width: 885px; padding: 10px; background: #f9f9f9; left: 44%; top: 52%;">
	<img class="CancleImg" id="btnCancleServerMngrPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png" style="z-index: 999;">
		<div class="popup_top" style="background: #f9f9f9; display: block;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">업무 담당자</h1>
		</div>
		<div class="popup_content" style="height: 240px;">
			<div class="content-box" id="div_mngr_list" style="height: auto; background: #fff; border: 1px solid #c8ced3;">
				<table id="mngrListGrid"></table>
				<div id="mngrListGridPager"></div>
			</div>
		</div>
		<div class="popup_btn" style="height: 45px;">
			<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
				<!-- <button type="button" id="btnServerMngrPopupUpdate" style="margin-top: 10px;"  onclick="userListWindows('mngr3')">추가</button> -->
				<button type="button" id="btnServerMngrListSave" style="margin-top: 10px;" >저장</button>
			</div>
		</div>
	</div>
</div>	
<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #222222; box-shadow: 2px 2px 5px #ddd; display:none">
	<ul>
		<li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
			<button id="updateMngrBtn">수정 </button></li>
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped">
			<button id="deleteMngrBtn">삭제</button></li>
	</ul>
</div>

<script type="text/javascript">
$(function() {
	$('#jstree').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${userGroupList}
		},
		"types" : {
			    "#" : {
			      "max_children" : 1,
			      "max_depth" : 4,
			      "valid_children" : ["root"]
			    },
			    "default" : {
			      "valid_children" : ["default","file"]
			    },
			    "file" : {
			      "icon" : "glyphicon glyphicon-file",
			      "valid_children" : []
			    }
		},
		'plugins' : [""]
	})
    .bind('select_node.jstree', function(evt, data, x) {
    	var id = data.node.id;
    	var type = data.node.original.type;
    	var text = data.node.text;
		var connected = data.node.original.connected;
		var parents = data.node.parents;
		var parent = data.node.parent;
		var children = data.node.children;
		var user_grade = "${memberInfo.USER_GRADE}";
		
		console.log(data);
		
		var pc = false;
		var server = false;
		
		if(parents.length > 1){
			for (var i = 0; i < parents.length; i++) {
				if(parents[i] == "pc"){
					pc = true;
				}else if(parents[i] == "server"){
					server = true;
				}			
			}
		}
		
		// 서버 일 경우
		if(server || id == "server"){
			$("#PCGridBox").css("display", "none");
			$("#serverGridBox").css("display", "block");
			$("#btnDownloadServerExel").css("display", "block");
			$("#btnDownloadPCExel").css("display", "none");
			$("#serviceNmText").html("서비스명");
			$("#serviceNm").attr("placeholder", "서비스명을 입력하세요.");
			$("#infratbl").css("display", "table-row");
			$(".left_area2").css("height", "90%");
			$(".left_box2").css("max-height", "640px");
			$("#jstree").css("height", "625px");
			$(".user_info_th").css("padding", "5px 5px 0 5px");
			$(".user_info_td").css("padding", "5px 5px 0 5px");
			$("#userHelpIcon").css("display", "");
			$("#userHelpPCIcon").css("display", "none");
			var postData = {};
			fn_drawserverGrid();
			
			if(id == "server"){ // 서버 선택 시
				postData = {id : "", groupNm : "", hostNm : "", target_id : "", name : ""};
			}else if(id == "noGroup"){ // 미분류 선택 시
				postData = {id : id, groupNm : "", hostNm : "", target_id : "", name : ""};
			}else if(parent == "server" && data.node.data.type == 0 ){ // 그룹 선택 시
				postData = {id : id, groupNm : text, hostNm : "", target_id : "", name : ""};
			}else if(data.node.data.type == 1){ // 호스트명 선택 시
				var name = text.split("(");
				postData = {id : id, groupNm : "", hostNm : "", target_id : "", name : name[0]};
			}
			
			console.log(postData);
			$("#serverGrid").setGridParam({
				url:"<%=request.getContextPath()%>/target/searchServerTargetUser", 
				page: 1 ,
				postData : postData, 
				datatype:"json" 
			}).trigger("reloadGrid");
			
		}
		
		// pc 일 경우
		if(pc || id == "pc"){ 
			$("#serverGridBox").css("display", "none");
			$("#PCGridBox").css("display", "block");
			$("#btnDownloadServerExel").css("display", "none");
			$("#btnDownloadPCExel").css("display", "block");
			$("#serviceNmText").html("담당자명");
			$("#serviceNm").attr("placeholder", "담당자명을 입력하세요.");
			$("#infratbl").css("display", "none");
			$(".left_area2").css("height", "95%");
			$(".left_box2").css("max-height", "661px");
			$("#jstree").css("height", "661px");
			$(".user_info_th").css("padding", "5px");
			$(".user_info_td").css("padding", "5px");
			$("#userHelpIcon").css("display", "none");
			$("#userHelpPCIcon").css("display", "");
			var postData = {};
			
			if(id == "pc"){ // pc 선택 시
				postData = {id : "", target_id : "", name : ""};
				$("#PCGrid").setGridParam({
					url:"<%=request.getContextPath()%>/target/selectPCTargetUser", 
					page: 1 ,
					postData : postData, 
					datatype:"json" 
				}).trigger("reloadGrid");
			}
			
			if(user_grade == 9){ // 보안 관리자
				
				if(id == "noGroupPC"){// 미분류 선택 시
					postData = {id : id, target_id : "", name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}else if(parent != "pc" && data.node.original.type == 0){ // 그룹 선택 시
					var postData = {id : id, target_id : "", name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUserData", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}else if(parent != "pc" && data.node.original.type == 1){ // 사용자 선택 시
					var postData = {id : id, target_id : "", name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}else if(parent == "noGroupPC" ){ // 호스트 선택 시
					var name = text.split("(");
					var postData = {id : "", target_id : id, name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/searchPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}
				
			}else if(user_grade == 2 || user_grade == 3){ // 중간 관리자
				if(id == "mypc"){ // 내 pc 선택 시  
					postData = {id : id, target_id : "", name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}else if(id != "mypc" && data.node.original.ap == 0){ // 그룹 선택 시
					var postData = {id : id, target_id : "", name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUserData", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}else if(parent == "mypc" ){ // 호스트 선택 시
					var name = text.split("(");
					var postData = {id : "", target_id : id, name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/searchPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}
				else if(parent != "pc" && data.node.original.ap != 0){ // 사용자 선택 시
					var postData = {parent : parent, id : id};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/selectPCTargetUserName", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}
			}else{ // 그외 사용자
				if(id != "pc"){ // 호스트 선택 시
					var name = text.split("(");
					var postData = {id : "", target_id : id, name : ""};
					$("#PCGrid").setGridParam({
						url:"<%=request.getContextPath()%>/target/searchPCTargetUser", 
						page: 1 ,
						postData : postData, 
						datatype:"json" 
					}).trigger("reloadGrid");
				}
			}
			
		}
    });
});

				
var resetFomatter = null;
				
$(document).ready(function () {
	
	$(document).click(function(e){
		$("#taskWindow").hide();
	});
	
	fn_drawserverGrid(); 
	fn_targetUserGrid();
	fn_targetMngrGrid();
	var grade = "${userGrade}";
	var gradeList = ["0", "1", "2", "3", "7"];
	
	if(gradeList.indexOf(grade) == -1){
		setServer();
		var helpIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 666px; cursor: pointer;" id="userHelpIcon">';
		var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="display: none; width: 24px; position: absolute; top: 30px; left: 666px; cursor: pointer;" id="userHelpPCIcon">';
		$("#commit").after(helpIcon);
		$("#commit").after(helpPCIcon);
		
	} else {
		$("#headerText").html("대상조회");
		$("#commit").html("담당하는 대상의 상세정보, 중간관리자 정보를 확인할 수 있습니다.");
		$("#commit").css("left", "141px");
		
		$("#serverGridBox").css("display", "none");
		$("#PCGridBox").css("display", "block");
		$("#btnDownloadServerExel").css("display", "none");
		$("#btnDownloadPCExel").css("display", "block");
		$("#serviceNmText").html("담당자명");
		$("#serviceNm").attr("placeholder", "담당자명을 입력하세요.");
		$("#infratbl").css("display", "none");
		$(".left_area2").css("height", "95%");
		$(".left_box2").css("max-height", "662px");
		$("#jstree").css("height", "662px");
		$(".user_info_th").css("padding", "5px");
		$(".user_info_td").css("padding", "5px");
		
		var helpIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 500px; cursor: pointer;" id="userHelpIcon">';
		var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 500px; cursor: pointer;" id="userHelpPCIcon">';
		$("#userHelpIcon").css("display", "none");
		$("#commit").after(helpPCIcon);
		setPC();
	}
	
	$("#btnDownloadServerExel").click(function(){
		downLoadServerExcel();
	});
	
	$("#btnDownloadPCExel").click(function(){
		downLoadPCExcel();
	});

	$("#btntargetSave").click(function(){
		
		var mngr1_no = $("#reachTargetMngr1No").val();
		var mngr2_no = $("#reachTargetMngr2No").val();
		var mngr3_no = $("#reachTargetMngr3No").val();
		var mngr4_no = $("#reachTargetMngr4No").val();
		var mngr5_no = $("#reachTargetMngr5No").val();
		
		var row = $("#serverGrid").getGridParam("selrow" );
		var target_id = $("#serverGrid").getCell(row, 'TARGET_ID');
		var ap_no = $("#serverGrid").getCell(row, 'AP_NO');
		
		var massage = "사용자를 지정하시겠습니까?";
		
		if(confirm(massage)){
		 var postData = {
				mngr1_no : mngr1_no,
				mngr2_no : mngr2_no,
				mngr3_no : mngr3_no,
				mngr4_no : mngr4_no,
				mngr5_no : mngr5_no,
				target_id : target_id,
				ap_no : ap_no
			};
		 console.log(postData);
		  $.ajax({
				type: "POST",
				url: "/popup/updateTargetUser",
				async : false,
				data : postData,
			    success: function (result) {
			    	if(result.resultCode != 0){
		            	alert(result.resultMeassage);
		            } else {
		            	alert("사용자 지정에 완료하였습니다");
		            	
		            }
			    },
			    error: function (request, status, error) {
			        console.log("ERROR : ", error);
			        result = setStatusKR(status, status);
			        $("#serverGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',result);
			    }
			});  
			
			$("#targetInfraID").val("");
			$("#targetServiceUserID").val("");
			$("#targetServiceManagerID").val("");
			
			$("#targetPopup").hide();
			setServer();
		}
		
	});
	
	$("#btnPCtargetSave").click(function(){
		var user_name = $("#PCtargetInfra").val();
		var user_no = $("#PCtargetInfraID").val();
		var service_user_name = $("#PCtargetServiceUser").val();
		var service_user_no = $("#PCtargetServiceUserID").val();
		var reach_infra_name = $("#PCreachTargetInfra").val();
		var reach_infra_no = $("#PCreachTargetInfraID").val();

		var row = $("#PCGrid").getGridParam("selrow" );
		var target_id = $("#PCGrid").getCell(row, 'TARGET_ID');
		var ap_no = $("#PCGrid").getCell(row, 'AP_NO');
		
		var massage = "사용자를 지정하시겠습니까?";
		
		if(confirm(massage)){
		 var postData = {
				user_no : user_no,
				service_user_no : service_user_no,
				target_id : target_id,
				ap_no : ap_no,
			};
		  $.ajax({
				type: "POST",
				url: "/popup/updatePCTargetUser",
				async : false,
				data : postData,
			    success: function (result) {
			    	if(result.resultCode != 0){
		            	alert(result.resultMeassage);
		            } else {
		            	alert("사용자 지정에 완료하였습니다");
		            	
		            }
			    },
			    error: function (request, status, error) {
			        console.log("ERROR : ", error);
			        result = setStatusKR(status, status);
			        $("#PCGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',result);
			    }
			});  
			
		 	$("#PCtargetInfra").val("");
			$("#PCtargetInfraID").val("");
			
			$("#PCtargetPopup").hide();
			setPC();
		}
		
	});
	
	$("#btntargetCancel").click(function(){ 
		$("#targetPopup").hide();
	});
	
	$("#btnCancleTargetPopup").click(function(){ 
		$("#targetPopup").hide();
	});
	
	$("#btnPCtargetCancel").click(function(){ 
		$("#PCtargetPopup").hide();
	});
	
	$("#btnCanclePCtargetPopup").click(function(){ 
		$("#PCtargetPopup").hide();
	});

	$("#targetServiceManagerBtn").click(function() {
		selectUserListPop();
		// userListWindows("serviceManager");
	});
	
	$("#PCtargetInfraBtn").click(function() {
		userListWindows("PCManager");
	});
	
	$("#PCtargetServiceUserBtn").click(function() {
		userListWindows("serviceUser");
	});
	
	$("#PCtargetServiceUserViewBtn").click(function() {
		showUserAdmin();
	});
	
	/* $("#btnClose").click(function() {
		$("#pcDetailPopup").hide();
	}); */
	
	$("#btnAdminClose").click(function() {
		$("#pcAdminPopup").hide();
	});
	
	$("#btnCanclePCAdminPopup").click(function() {
		$("#pcAdminPopup").hide();
	});
	
	$("#userHelpIcon").on("click", function(e) {
		/* $("#userHelpPopup").show(); */
		var id = "target_mngr";
		var pop_url = "${getContextPath}/popup/helpDetail";
    	var winWidth = 1140;
    	var winHeight = 655;
    	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
    	//var pop = window.open(pop_url,"detail",popupOption);
    	var pop = window.open(pop_url ,id, popupOption);
    	
    	var newForm = document.createElement('form');
    	newForm.method='POST';
    	newForm.action=pop_url;
    	newForm.name='newForm';
    	newForm.target=id;
    	
    	var data = document.createElement('input');
    	data.setAttribute('type','hidden');
    	data.setAttribute('name','id');
    	data.setAttribute('id','id');
    	data.setAttribute('value',id);
    	
    	newForm.appendChild(data);
    	document.body.appendChild(newForm);
    	newForm.submit();
    	
    	document.body.removeChild(newForm);
	});
	
	$("#userHelpPCIcon").on("click", function(e) {
		/* $("#userHelpPopup").show(); */
		var id = "target_mngr_pc";
		var pop_url = "${getContextPath}/popup/helpDetail";
    	var winWidth = 1140;
    	var winHeight = 655;
    	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
    	//var pop = window.open(pop_url,"detail",popupOption);
    	var pop = window.open(pop_url ,id, popupOption);
    	
    	var newForm = document.createElement('form');
    	newForm.method='POST';
    	newForm.action=pop_url;
    	newForm.name='newForm';
    	newForm.target=id;
    	
    	var data = document.createElement('input');
    	data.setAttribute('type','hidden');
    	data.setAttribute('name','id');
    	data.setAttribute('id','id');
    	data.setAttribute('value',id);
    	
    	newForm.appendChild(data);
    	document.body.appendChild(newForm);
    	newForm.submit();
    	
    	document.body.removeChild(newForm);
	});
	
	/* $("#btnCancleUserHelpPopup, #btnCloseUserHelpPopup").on("click", function(e) {
		$("#userHelpPopup").hide();
	}); */
	
});
/* 
$(document).mouseup(function (e){
	  var LayerPopup = $("#userHelpPopup");
	  if(LayerPopup.has(e.target).length === 0){
		  $("#userHelpPopup").hide();
	  }
}); 
*/

function showUserAdmin(){
	var postData = {
		user_no : $("#PCtargetServiceUserID").val(),
	};
	
	$("#targetUserGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectPCAdmin", page: 1 ,postData : postData, datatype:"json" }).trigger("reloadGrid");

	 /* $.ajax({
		type: "POST",
		url: "/user/selectPCAdmin",
		async : false,
		data : postData,
	    success: function (result) {
	    	if(result.resultCode != 0){
            	alert(result.resultMeassage);
            } else {
            	alert("사용자 지정에 완료하였습니다");
            	
            }
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        result = setStatusKR(status, status);
	        $("#serverGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',result);
	    }
	});   */
	
	$("#pcAdminPopup").show();
}

function selectUserListPop(){
	
	$("#mngrListGrid").jqGrid('clearGridData');
	
	var mydata = [
	    {NUM: "3", USER_NO: $("#reachTargetMngr3No").val(), USER_SOSOK: $("#reachTargetMngr3Tm").val(), USER_NAME: $("#reachTargetMngr3Nm").val()},
	    {NUM: "4", USER_NO: $("#reachTargetMngr4No").val(), USER_SOSOK: $("#reachTargetMngr4Tm").val(), USER_NAME: $("#reachTargetMngr4Nm").val()},
	    {NUM: "5", USER_NO: $("#reachTargetMngr5No").val(), USER_SOSOK: $("#reachTargetMngr5Tm").val(), USER_NAME: $("#reachTargetMngr5Nm").val()}
	];

	for (var i = 0; i <= mydata.length; i++) {
	    $("#mngrListGrid").jqGrid('addRowData', i + 1, mydata[i]);
	}
	
	<%-- 
	var postData = {target_id : $("#targetHostId").val(), ap_no  : $("#targetHostApNo").val()};
	$("#mngrListGrid").setGridParam({
		url:"<%=request.getContextPath()%>/target/selectMngrList", 
		page: 1 ,
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid");
 --%>	
	 $("#selectUserListPopup").show();
}

function userListWindows(info){
	var pop_url = "${getContextPath}/popup/userList";
	var id = "targetList"
	var winWidth = 700;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,id,popupOption);
	/* popList.push(pop);
	sessionUpdate(); */
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=id;
	
	var data = document.createElement('input');
	data.setAttribute('type','hidden');
	data.setAttribute('name','info');
	data.setAttribute('value',info);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
}

function setServer(){
	var postData = {id :""};
	$("#serverGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectServerTargetUser", page: 1 , postData : postData, datatype:"json" }).trigger("reloadGrid");
	
}
 
function gridreload(rowid){
	
	var newData = {
			USER_NO  : $("#reachTargetMngr"+(Number(rowid)+2)+"No").val(),
			USER_NAME : $("#reachTargetMngr"+(Number(rowid)+2)+"Nm").val(),
			USER_SOSOK : $("#reachTargetMngr"+(Number(rowid)+2)+"Tm").val()
	};
	
	$("#mngrListGrid").jqGrid('setRowData',rowid,newData);
	$("#mngrListGrid tr#" + rowid + " td:eq(" + 1 + ")").removeAttr('style').css({ 'text-align': 'center'});
	$("#mngrListGrid tr#" + rowid + " td:eq(" + 2 + ")").removeAttr('style').removeAttr('colspan').css({ 'text-align': 'center'});
	$("#mngrListGrid tr#" + rowid + " td:eq(" + 3 + ")").removeAttr('style').css({ 'text-align': 'center'});
}
 
function fn_drawserverGrid() {
	
	var gridWidth = $("#serverGrid").parent().width();
	
	$("#serverGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectServerTargetUser",
		datatype: "local",
		//data: temp,
	   	mtype : "POST",
		colNames:['그룹명','TARGET_ID', 'AP_NO', '호스트명', '서버 연결 상태', '서버 연결 IP', '서비스명', '업무 담당자(정) 사번', '업무 담당자(정)', '업무 담당자(부) 사번', '업무 담당자(부)', 
				  '업무 담당자 사번', '업무 담당자', '업무 담당자 소속', '업무 담당자 사번4', '업무 담당자 소속4', '업무 담당자4','업무 담당자 사번5', '업무 담당자5', '업무 담당자 소속5', '적용 정책ID','적용 정책'],
		colModel: [
			{ index: 'GROUP_NAME', 			name: 'GROUP_NAME', 			width: 100, align: "center"},
			{ index: 'TARGET_ID', 			name: 'TARGET_ID', 				width: 100, align: "center", hidden:true},
			{ index: 'AP_NO', 				name: 'AP_NO', 					width: 100, align: "center", hidden:true},
			{ index: 'NAME', 				name: 'NAME', 					width: 100, align: "center"},
			{ index: 'AGENT_CONNECTED', 	name: 'AGENT_CONNECTED', 		width: 100, align: "center", formatter: con_icon},
			{ index: 'AGENT_CONNECTED_IP', 	name: 'AGENT_CONNECTED_IP', 	width: 100, align: "center"},
			{ index: 'SERVICE_NM', 			name: 'SERVICE_NM', 			width: 100, align: "center"},
			{ index: 'SERVICE_MNGR_NO', 	name: 'SERVICE_MNGR_NO', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR_NM', 	name: 'SERVICE_MNGR_NM', 		width: 100, align: "center"}, 
			{ index: 'SERVICE_MNGR2_NO', 	name: 'SERVICE_MNGR2_NO', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR2_NM', 	name: 'SERVICE_MNGR2_NM', 		width: 100, align: "center"},
			{ index: 'SERVICE_MNGR3_NO', 	name: 'SERVICE_MNGR3_NO', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR3_NM', 	name: 'SERVICE_MNGR3_NM', 		width: 100, align: "center", formatter: mngr_nm},
			{ index: 'SERVICE_MNGR3_TM', 	name: 'SERVICE_MNGR3_TM', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR4_NO', 	name: 'SERVICE_MNGR4_NO', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR4_NM', 	name: 'SERVICE_MNGR4_NM', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR4_TM', 	name: 'SERVICE_MNGR4_TM', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR5_NO', 	name: 'SERVICE_MNGR5_NO', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR5_NM', 	name: 'SERVICE_MNGR5_NM', 		width: 100, align: "center", hidden:true},
			{ index: 'SERVICE_MNGR5_TM', 	name: 'SERVICE_MNGR5_TM', 		width: 100, align: "center", hidden:true},
			{ index: 'POLICY_ID', 			name: 'POLICY_ID', 				width: 100, align: "center"},
			{ index: 'POLICY_NM', 			name: 'POLICY_NM', 				width: 100, align: "center"}
			
		], 
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 553,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#serverGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	onCellSelect : function(rowid){
	  		$("#rowid").val(rowid);
	  		
	  		var GROUP = $(this).getCell(rowid, 'GROUP_NAME');
	  		var HOST = $(this).getCell(rowid, 'NAME');
	  		var IP = $(this).getCell(rowid, 'AGENT_CONNECTED_IP');
	  		var SERVICE = $(this).getCell(rowid, 'SERVICE_NM');
	  		var TARGET_ID = $(this).getCell(rowid, 'TARGET_ID');
	  		var AP_NO = $(this).getCell(rowid, 'AP_NO');
	  		var SERVICE_MNGR_NO = $(this).getCell(rowid, 'SERVICE_MNGR_NO');
	  		var SERVICE_MNGR_NM = $(this).getCell(rowid, 'SERVICE_MNGR_NM');
	  		var SERVICE_MNGR2_NO = $(this).getCell(rowid, 'SERVICE_MNGR2_NO');
	  		var SERVICE_MNGR2_NM = $(this).getCell(rowid, 'SERVICE_MNGR2_NM');
	  		var SERVICE_MNGR3_NO = $(this).getCell(rowid, 'SERVICE_MNGR3_NO');
	  		var SERVICE_MNGR3_NM = $(this).getCell(rowid, 'SERVICE_MNGR3_NM');
	  		var SERVICE_MNGR3_TM = $(this).getCell(rowid, 'SERVICE_MNGR3_TM');
	  		var SERVICE_MNGR4_NO = $(this).getCell(rowid, 'SERVICE_MNGR4_NO');
	  		var SERVICE_MNGR4_NM = $(this).getCell(rowid, 'SERVICE_MNGR4_NM');
	  		var SERVICE_MNGR4_TM = $(this).getCell(rowid, 'SERVICE_MNGR4_TM');
	  		var SERVICE_MNGR5_NO = $(this).getCell(rowid, 'SERVICE_MNGR5_NO');
	  		var SERVICE_MNGR5_NM = $(this).getCell(rowid, 'SERVICE_MNGR5_NM');
	  		var SERVICE_MNGR5_TM = $(this).getCell(rowid, 'SERVICE_MNGR5_TM');
	  		var POLICY_ID = $(this).getCell(rowid, 'POLICY_ID');
	  		var POLICY_NM = $(this).getCell(rowid, 'POLICY_NM');
	  		
	  		$("#targetGroup").val(GROUP);
	  		$("#targetHost").val(HOST);
	  		$("#targetHostId").val(TARGET_ID);
	  		$("#targetHostApNo").val(AP_NO);
	  		$("#targetIP").val(IP);
	  		$("#targetService").val(SERVICE);
	  		
	  		$("#targetSevermngr1").val(SERVICE_MNGR_NM);
	  		$("#targetSevermngrId1").val(SERVICE_MNGR_NO);
	  		$("#targetSevermngrNm1").val(SERVICE_MNGR_NM);
	  		$("#reachTargetMngr1No").val(SERVICE_MNGR_NO);
	  		$("#reachTargetMngr1Nm").val(SERVICE_MNGR_NM);
	  		
	  		$("#targetSevermngr2").val(SERVICE_MNGR2_NM);
	  		$("#targetSevermngrId2").val(SERVICE_MNGR2_NO);
	  		$("#targetSevermngrNm2").val(SERVICE_MNGR2_NM);
	  		$("#reachTargetMngr2No").val(SERVICE_MNGR2_NO);
	  		$("#reachTargetMngr2Nm").val(SERVICE_MNGR2_NM);
	  		
	  		$("#targetSevermngr3").val(SERVICE_MNGR3_NM);
	  		$("#targetSevermngrId3").val(SERVICE_MNGR3_NO);
	  		$("#targetSevermngrNm3").val(SERVICE_MNGR3_NM);
	  		
	  		$("#reachTargetMngr3No").val(SERVICE_MNGR3_NO);
	  		$("#reachTargetMngr3Nm").val(SERVICE_MNGR3_NM);
	  		$("#reachTargetMngr3Tm").val(SERVICE_MNGR3_TM);
	  		$("#reachTargetMngr4No").val(SERVICE_MNGR4_NO);
	  		$("#reachTargetMngr4Nm").val(SERVICE_MNGR4_NM);
	  		$("#reachTargetMngr4Tm").val(SERVICE_MNGR4_TM);
	  		$("#reachTargetMngr5No").val(SERVICE_MNGR5_NO);
	  		$("#reachTargetMngr5Nm").val(SERVICE_MNGR5_NM);
	  		$("#reachTargetMngr5Tm").val(SERVICE_MNGR5_TM);
	  		
	  		$("#targetPopup").show();
	  		
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
	    },
	    gridComplete : function() {
	    }
	});
}

function fn_targetMngrGrid(){
	
	var gridWidth = $("#mngrListGrid").parent().width();
	$("#mngrListGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectMngrList",
		datatype: "local",
		postData : {},
	   	mtype : "POST",
		colNames:['No','사번','소속','성명', ''],
		colModel: [
			{ index: 'NUM', 		name: 'NUM', 			width: 80, align: "center", },
			{ index: 'USER_NO', 	name: 'USER_NO', 		width: 250, align: "center", cellattr: team_style2},
			{ index: 'USER_SOSOK', 	name: 'USER_SOSOK', 	width: 250, align: "center", formatter: team_name, cellattr: team_style},
			{ index: 'USER_NAME', 	name: 'USER_NAME', 		width: 250, align: "center", cellattr: team_style2},
			{ index: 'BUTTON', 		name: 'BUTTON', 		width: 100, align: "center", formatter:createView},
		],
		loadonce:true,
	   	autowidth: false,
		shrinkToFit: false,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 343,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : false,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#mngrListGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	onCellSelect : function(rowid){
	  		/* var result = confirm((Number(rowid) + 2) + "번째 담당자를 지정하시겠습니까?");
	  		if(result){
	  			userListWindows('mngr'+(Number(rowid) + 2));
	  		} */
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
	    },
	    gridComplete : function() {
	    }
	});
}

$(document).on("click", ".gridSubSelBtn", function(e) {
	e.stopPropagation();
	
	$("#mngrListGrid").setSelection(event.target.parentElement.parentElement.id);
	
	var offset = $(this).parent().offset();
	$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + 37 + "px");
	// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
	$("#taskWindow").css("top", offset.top + $(this).height()  + "px");

	var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
	var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

	if (taskBottom > bottomLimit) { 
		$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
	}
	$("#taskWindow").show();
});

function setPC(){
	var postData = {id : ""};
	$("#PCGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectPCTargetUser", page: 1 ,postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	
}

function downLoadServerExcel()
{
	$("#serverGrid").jqGrid("hideCol",["CHK"]);

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy + "" + mm + dd;
	console.log(today);
	
	$("#serverGrid").jqGrid("exportToCsv",{
        separator: ",",
        separatorReplace : "", // in order to interpret numbers
        quote : '"', 
        escquote : '"', 
        newLine : "\r\n", // navigator.userAgent.match(/Windows/) ? '\r\n' : '\n';
        replaceNewLine : " ",
        includeCaption : true,
        includeLabels : true,
        includeGroupHeader : true,
        includeFooter: true,
        fileName : "대상_조회_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    });
	$("#serverGrid").jqGrid("showCol",["CHK"]);
} 

function downLoadPCExcel()
{
	resetFomatter = "downloadClick";
	
	$("#PCGrid").jqGrid("hideCol",["CHK"]);

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy + "" + mm + dd;
	console.log(today);
	
	$("#PCGrid").jqGrid("exportToCsv",{
        separator: ",",
        separatorReplace : "", // in order to interpret numbers
        quote : '"', 
        escquote : '"', 
        newLine : "\r\n", // navigator.userAgent.match(/Windows/) ? '\r\n' : '\n';
        replaceNewLine : " ",
        includeCaption : true,
        includeLabels : true,
        includeGroupHeader : true,
        includeFooter: true,
        fileName : "대상_조회_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    });
	
	resetFomatter = null;
	$("#PCGrid").jqGrid("showCol",["CHK"]);
} 

$("#updateMngrBtn").on("click", function() {
	
	var rowid = $("#mngrListGrid").jqGrid("getGridParam","selrow");
	
	userListWindows('mngr'+(Number(rowid) + 2));
});
$("#deleteMngrBtn").on("click", function() {
	
	var rowid = $("#mngrListGrid").jqGrid("getGridParam","selrow");
	
	var result = confirm((Number(rowid) + 2) + "번째 담당자를 제외하시겠습니까?");
	
	if(result){
		
		var mngrNo = $("#reachTargetMngr"+(Number(rowid) + 2)+"No").val();
		
		if(mngrNo == null || mngrNo == ""){
			alert("지정된 담당자가 없습니다.");
			return;
		}
		
		$("#reachTargetMngr"+(Number(rowid) + 2)+"No").val('');
		$("#reachTargetMngr"+(Number(rowid) + 2)+"Nm").val('');
		
		var newData = {
				USER_NO  :'',
				USER_NAME : '지정된 담당자가 없습니다.',
				USER_SOSOK : ''
		};

		$("#mngrListGrid").jqGrid('setRowData',rowid,newData);
		$("#mngrListGrid tr#" + rowid + " td:eq(" + 1 + ")").css({ 'display': 'none'});
		$("#mngrListGrid tr#" + rowid + " td:eq(" + 2 + ")").attr('colspan', '3');
		$("#mngrListGrid tr#" + rowid + " td:eq(" + 3 + ")").css({ 'display': 'none'});
		
		$("#taskWindow").hide();
	} 
});

var aut = "manager"

$("#personal_server").on("click", function() {
	
	var postData = {
			fromDate : $("#fromDate").val(),
			toDate : $("#toDate").val(),
    }
   	$.ajax({
   		type: "POST",
   		url: "/dash_personal_server",
   		async : false,
   		data : postData,
   		dataType : "JSON",
   		success: function (resultMap) {
            $("#personalServer").nextAll().html("");
            
            var addRow  = "";
            $.each(resultMap, function(index, item) {
            	
            	console.log(item.RESULT);
            	
               addRow += '<tr class="server_result" style="display:none;" data-uptidx="personal_server" data-level="2" data-mother="server" data-targetcnt="0" data-id="server">' 
                        +'<th><p class="sta_tit" style="cursor:pointer; margin-left:20px;" >' + item.RESULT;
               addRow += '</p></th></tr>';
            });
            
            $("#personalServer").after(addRow);
            
      	},
   	});
	
});

	$("#personal_PC").on("click", function() {
		
		var postData = {
				fromDate : $("#fromDate").val(),
				toDate : $("#toDate").val(),
	    }
	   	$.ajax({
	   		type: "POST",
	   		url: "/dash_personal_PC",
	   		async : false,
	   		data : postData,
	   		dataType : "JSON",
	   		success: function (resultMap) {
	            $("#personalPC").nextAll().html("");
	            
	            var addRow  = "";
	            $.each(resultMap, function(index, item) {
	               addRow += '<tr class="pc_result" style="display:none;" data-uptidx="personal_PC" data-level="2" data-mother="pc" data-targetcnt="0" data-id="pc">' 
	                        +'<th><p class="sta_tit" style="cursor:pointer; margin-left:20px;" >' + item.RESULT;
	               addRow += '</p></th></tr>';
	            });
	            
	            $("#personalPC").after(addRow);
	            
	      	},
	   	});
		
	});
	

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\"\">"
			html += 	"<td style=\"padding-bottom: 0px; cursor: pointer;\">"
			html += 		"<p style=\"padding-bottom: 0px; margin-left:20px;\""
			html +=			 "data-targetid=\""+item.TARGET_ID+"\" data-name=\""+item.AGENT_NAME+"\" data-connected=\""+item.AGENT_CONNECTED+"\" data-version=\""+item.AGENT_VERSION+"\" data-platform=\""+item.AGENT_PLATFORM+"\""
			html +=			 "data-apc=\""+item.AGENT_PLATFORM_COMPATIBILITY+"\" data-verified=\""+item.AGENT_VERIFIED+"\" data-user=\""+item.AGENT_USER+"\" data-cpu=\""+item.AGENT_CPU+"\" data-cores=\""+item.AGENT_CORES+"\""
			html +=			 "data-boot=\""+item.BOOT+"\" data-ram=\""+item.AGENT_RAM+"\" data-ip=\""+item.AGENT_CONNECTED_IP+"\" data-searchdt=\""+item.SEARCH_DATETIME+"\" data-apno=\""+item.AP_NO+"\""
			html +=			">"
			if(item.AGENT_CONNECTED == '1'){
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" style=\"width: 13px;\"  />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" style=\"width: 13px;\"  />"
			}
			if(item.AGENT_CONNECTED_IP != null){
				html +=		item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		item.AGENT_NAME 
			} 
			html += 		"</p>"
			html +=		"</td>"
			html += "	</tr>"
		} else if (code == "search"){
			html += "	<tr data-flag=\"target\"\">"
			html += 	"<td style=\"padding-bottom: 0px;\">"
			html += 		"<p style=\"padding-bottom: 0px; margin-left:"+(((level-1)*10))+"px;\""
			html +=			 "data-targetid=\""+item.TARGET_ID+"\" data-name=\""+item.AGENT_NAME+"\" data-connected=\""+item.AGENT_CONNECTED+"\" data-version=\""+item.AGENT_VERSION+"\" data-platform=\""+item.AGENT_PLATFORM+"\""
			html +=			 "data-apc=\""+item.AGENT_PLATFORM_COMPATIBILITY+"\" data-verified=\""+item.AGENT_VERIFIED+"\" data-user=\""+item.AGENT_USER+"\" data-cpu=\""+item.AGENT_CPU+"\" data-cores=\""+item.AGENT_CORES+"\""
			html +=			 "data-boot=\""+item.BOOT+"\" data-ram=\""+item.AGENT_RAM+"\" data-ip=\""+item.AGENT_CONNECTED_IP+"\" data-searchdt=\""+item.SEARCH_DATETIME+"\" data-apno=\""+item.AP_NO+"\""
			html +=			">"
			if(item.AGENT_CONNECTED == '1'){
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" style=\"width: 13px;\"  />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" style=\"width: 13px;\"  />"
			}
			if(item.AGENT_CONNECTED_IP != null){
				html +=		item.AGENT_NAME +" ("+item.AGENT_CONNECTED_IP+")" 
			}else{
				html +=		item.AGENT_NAME 
			} 
			html += 		"</p>"
			html +=		"</td>"
			html += "	</tr>"
		}
	})
	return html;
}

function getSearchData(host){
	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		data : {
			host: host
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	console.log('resultMap :: ' + resultMap)
	    	if(data.resultCode == '0'){
	    		console.log('data :: ' + data)
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var html = setLocationList(resultList, '', '', '', "search");
	    			//console.llg
	    			$("#Tbl_search").html(html)
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide();
	    			alert('검색 결과가 없습니다.')
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error)
	    }
	});
}

function fnSearchHost(e) {
	var searchHost = $("#txt_host").val();
	
	if (isNull(searchHost)) {
		$("#div_all").show();
		$("#div_search").hide();	
		return;
	}
	
	$("#div_all").hide();
	$("#div_search").show();
	getSearchData(searchHost);
	
}

function setServerCnt(){
	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var discon_cnt = 0;
	    			$('#hostCnt').text(resultList.length+' 대')
	    			
	    		} else {
	    			$("#div_all").show();
	    			$("#div_search").hide();
	    			/* alert('검색 결과가 없습니다.') */
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error)
	    }
	});
}

//엔터 입력시 발생하는 이벤트
$('#groupNm, #hostNm, #serviceNm, #infraUser, #serviceUser, #serviceManager, #userIP').keyup(function(e) {
	if (e.keyCode == 13) {
	    $("#serach_btn").click();
    }        
});


$("#serach_btn").on("click", function() {
	
	var postData = {
			groupNm : $("#groupNm").val(),
			hostNm : $("#hostNm").val(),
			serviceNm : $("#serviceNm").val(),
			userIP : $("#userIP").val(),
			infraUser : $("#infraUser").val(),
			serviceUser : $("#serviceUser").val(),
			serviceManager : $("#serviceManager").val()
    }
	$("#serverGrid").setGridParam({
		url:"<%=request.getContextPath()%>/target/searchServerTargetUser", 
		page: 1 ,
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	$("#PCGrid").setGridParam({
		url:"<%=request.getContextPath()%>/target/searchPCTargetUser", 
		page: 1 ,
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
});

function pcName(cellvalue, options, rowObject) {
	
	if(rowObject.USER_NAME == null){
		if(rowObject.USER_NM != null){
			return rowObject.USER_NM;
		}else{
			return "";
		}
	}else{
		return rowObject.USER_NAME;
	}
};
function pcServiceName(cellvalue, options, rowObject) {
	
	if(rowObject.SERVICE_USER_NAME == null){
		if(rowObject.SERVICE_USER_NM != null){
			return rowObject.SERVICE_USER_NM;
		}else{
			return "";
		}
	}else{
		return rowObject.SERVICE_USER_NAME;
	}
};
function infraName(cellvalue, options, rowObject) {
	
	if(rowObject.USER_NAME == null){
		if(rowObject.USER_NM != null){
			return rowObject.USER_NM;
		}else{
			return "";
		}
	}else{
		return rowObject.USER_NAME;
	}
};
function serviceName(cellvalue, options, rowObject) {
	if(rowObject.SERVICE_USER_NAME == null){
		if(rowObject.SERVICE_USER_NM != null){
			return rowObject.SERVICE_USER_NM;
		}else{
			return "";
		}
	}else{
		return rowObject.SERVICE_USER_NAME;
	}
	
};
function adminName(cellvalue, options, rowObject) {
	if(rowObject.ADMIN_NAME == null){
		if(rowObject.ADMIN_NM != null){
			return rowObject.ADMIN_NM;
		}else{
			return "";
		}
	}else{
		return rowObject.ADMIN_NAME;
	}
};
function serviceNm(cellvalue, options, rowObject) {
	
	var serviceNm = rowObject.SERVICE_NM
	if(serviceNm != "" && serviceNm != null){
		return serviceNm;
	}else{
		return "-";
	}
};


function fn_targetUserGrid() {
	
	var gridWidth = $("#targetUserGrid").parent().width();
	
	$("#targetUserGrid").jqGrid({
		url: "<%=request.getContextPath()%>/popup/selectUserList",
		datatype: "local",
		//data: temp,
	   	mtype : "POST",
		colNames:['ID','성명','팀코드','소속','전화번호', '이메일'],
		colModel: [
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 80, align: "center"},
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 80, align: "center"},
			{ index: 'INSA_CODE', 	name: 'INSA_CODE', 	width: 100, align: "left", hidden:true},
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 100, align: "center" },
			{ index: 'USER_PHONE', 	name: 'USER_PHONE', width: 100, align: "center"},
			{ index: 'USER_EMAIL', 	name: 'USER_EMAIL', width: 120, align: "left"},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 343,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#targetUserGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	onCellSelect : function(rowid){
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
	    },
	    gridComplete : function() {
	    }
	});
}

$("#PCtargetPolicyViewBtn").click(function(e){
	var policyid = $("#PCtargetPolicyID").val();
	var enable = $("#PCtargetEnable").val();
	if(policyid != null && policyid != '' && enable == 1){
		$("#pcTargetDataTypePopup").show();
		$.ajax({
			type: "POST",
			url: "/search/getPolicy",
			async : false,
			data : {
				policyid : policyid,
				scheduleUse : 1
			},
		    success: function (result) {
		    	/* var start_dtm = setStartdtm(result[0]);
				$('#search_start_time').html(start_dtm); */
			 	// 개인정보 유형 
				var datatype = setDatatype(result[0]);
				$('#left_datatype').html(datatype);
				
				$("#left_datatype_name").html(result[0].TYPE);
			   	
			   	var cycle = setCycle(result[0]);
				$('#cycle').html(cycle);
				
				$("input:checkbox[name='action']").prop("checked", false);
				$("input:checkbox[name='action'][value='"+result[0].ACTION+"']").prop("checked", true);
				$("input:checkbox[name='action']").attr("disabled", "disabled");
		    },
		    error: function (request, status, error) {
		    	alert("정보를 불러오는데 실패하였습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	}else if(enable == 0){
		alert("해당 PC에 설정된 정책이 없습니다.\n관리자에게 문의해 주세요.");
	}
});

$("#btnServerMngrPopupUpdate").click(function(e){
	
	isCreateProfile = false;
});

$("#btnServerMngrListSave").click(function(e){
	
	var mngr3 = $("#reachTargetMngr3Nm").val();
	var mngr4 = $("#reachTargetMngr4Nm").val();
	var mngr5 = $("#reachTargetMngr5Nm").val();
	
	var mngr_con = 0;
	
	var result = "";
	
	if(mngr3 != null && mngr3 != "") ++mngr_con;
	if(mngr4 != null && mngr4 != "") ++mngr_con;
	if(mngr5 != null && mngr5 != "") ++mngr_con;
	
	
	if(result == "" && mngr3 != null) result = mngr3;
	if(result == "" && mngr4 != null) result = mngr4;
	if(result == "" && mngr5 != null) result = mngr5;
	
	if(mngr_con > 1){
		result += " 외 "+ (mngr_con-1) +" 명";
	}
	
	$("#targetSevermngr3").val(result);
	$("#selectUserListPopup").hide();
});

$("#btnCancleServerMngrPopup").click(function(e){
	$("#selectUserListPopup").hide();
});

/* 검색 정책 데이터유형 확인 */
function setDatatype(rowData){
	var html = "<table style=\"width: 90%;\">";
	
	html += "<tr>"
	html += "	<th>주민등록번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.RRN == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.RRN_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.RRN_CNT > 0)? rowData.RRN_CNT : '';
	html += "	</td>"
	html += "	<th>외국인등록번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.FOREIGNER_CNT > 0)? rowData.FOREIGNER_CNT : '';
	html += "	</td>"
	html += "	<th>운전면허번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.DRIVER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.DRIVER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.DRIVER_CNT > 0)? rowData.DRIVER_CNT : '';
	html += "	</td>"
	html += "</tr>"
	html += "<tr>"
	html += "	<th>여권번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.PASSPORT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.PASSPORT_CNT > 0)? rowData.PASSPORT_CNT : '';
	html += "	</td>"
	html += "	<th>계좌번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.ACCOUNT_CNT > 0)? rowData.ACCOUNT_CNT : '';
	html += "	</td>"
	html += "	<th>카드번호</th>"
	html += "	<td style=\"width: 15%;\"><input type='checkbox' disabled='disabled' "+((rowData.CARD == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.CARD_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.CARD_CNT > 0)? rowData.CARD_CNT : '';
	html += "	</td>"
	html += "</tr>"
	html += "<tr>"
	html += "	<th>이메일</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.EMAIL_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.EMAIL_CNT > 0)? rowData.EMAIL_CNT : '';
	html += "	</td>"
	html += "	<th>휴대전화번호</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += 	(rowData.MOBILE_PHONE_CNT > 0)? rowData.MOBILE_PHONE_CNT : '';
	html += "	</td>"
	html += "	<th>증분검사</th>"
	html += "	<td><input type='checkbox' disabled='disabled' "+((rowData.RECENT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "	</td>"
	html += "</tr>"
	html += "</table>"
	
	return html;
}
/* 검색 정책 데이터유형 확인 종료 */


/* 검색 주기 확인 */
function setCycle(rowData){
	var cycle = rowData.CYCLE;
	
	var html = "";
	html += "<select name=\"cycle\" id=\"cycle\" disabled=\"disabled\">"
	html += "	<option value=\"0\" "+((cycle == 0)? 'selected': '')+">한번만</option>"
	html += "	<option value=\"1\" "+((cycle == 1)? 'selected': '')+">매일</option>"
	html += "	<option value=\"2\" "+((cycle == 2)? 'selected': '')+">매주</option>"
	html += "	<option value=\"3\" "+((cycle == 3)? 'selected': '')+">매월</option>"
	html += "</select>"
	
	return html;
}
/* 검색 주기 확인 종료 */


function nullCheck(cellvalue, options, rowObject) {
	
	if(cellvalue == "" || cellvalue == null){
		return '-';
	}else{
		return cellvalue;
	}
}


function con_icon(cellvalue, options, rowObject) {
	
	if(resetFomatter == "downloadClick"){
		return cellvalue;
	}else{
		if(cellvalue == "1"){
			return '<img style="width:15%; padding-top: 5px;" src="${pageContext.request.contextPath}/resources/assets/images/icon_con.png">';
		}else{
			return '<img style="width:15%; padding-top: 5px;" src="${pageContext.request.contextPath}/resources/assets/images/icon_dicon.png">';
			
		}
	}
	
}

function team_name(cellvalue, options, rowObject) {
	
	var user_no = rowObject.USER_NO;
	
	if(user_no != "" && user_no != null){
		return cellvalue;
	}else{
		return "지정된 담당자가 없습니다.";
	}
	
}
function team_style(rowId, cellvalue, rowObject, cm, rdata) {
	
	var user_no = rowObject.USER_NO;
	
	if(user_no != "" && user_no != null){
	}else{
		return "colspan=3;"
	}
	
}
function team_style2(rowId, cellvalue, rowObject, cm, rdata) {
	
	var user_no = rowObject.USER_NO;
	
	if(user_no != "" && user_no != null){
	}else{
		return "style=display:none;";
	}
	
}

var createView = function(cellvalue, options, rowObject) {
	
	result = "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
	return result; 
};

function mngr_nm(cellvalue, options, rowObject) {

	var mngr3 = rowObject.SERVICE_MNGR3_NM;
	var mngr4 = rowObject.SERVICE_MNGR4_NM;
	var mngr5 = rowObject.SERVICE_MNGR5_NM;
	
	var mngr_con = 0;
	
	var result = "";
	
	if(mngr3 != null) ++mngr_con;
	if(mngr4 != null) ++mngr_con;
	if(mngr5 != null) ++mngr_con;
	
	
	if(result == "" && mngr3 != null) result = mngr3;
	if(result == "" && mngr4 != null) result = mngr4;
	if(result == "" && mngr5 != null) result = mngr5;
	
	if(mngr_con > 1){
		result += " 외 "+ (mngr_con-1) +" 명";
	}
	
	return result;
}
</script>

</body>
</html>