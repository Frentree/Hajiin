<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
<style>
	#targetGrid_SCHEDULE_ID2{
		border-right: none;
	}
	.user_info th {
		width: 100px;
	}
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
</style>
		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<h3 style="display: inline; top: 25px;">검색 스케줄</h3>
				<p class="container_comment" style="position: absolute; top: 32px; left: 166px; font-size: 13px; color: #9E9E9E;">서버 별 개인정보 검출 스케줄 및 진행사항을 확인 하실수 있습니다.</p>
				<!-- content -->
				<div class="content magin_t35" style="height: 740px;">
						<table class="user_info" style="display: inline-table; width: 835px;">
							<caption>스케줄 목록</caption>
							<tbody>
								<tr>
		                            <th style="text-align: center; border-radius: 0.25rem; padding: 5px 5px 0 5px;">스케줄명</th>
									<td style="padding: 5px 5px 0 5px;"><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="title" placeholder="스케줄명을 입력하세요."></td>
									
		                            <th style="text-align: center; padding: 5px 5px 0 5px;">작성자</th>
									<td style="padding: 5px 5px 0 5px;"><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="writer" placeholder="작성자를 입력하세요."></td>
		                            <td rowspan="3">
		                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-right: 5px;">
		                           	</td>
								</tr>
								<tr>                      
							<th style="text-align: center; border-radius: 0.25rem;">검색</th>
								<td>
									<select id="sch_type" name="sch_type" style="width:186px; font-size: 12px; padding-left: 5px;">
	                                	<option value="" selected>전체</option>
	                                    <option value="0" >서버</option>
	                                    <option value="1" >PC</option>
	                                    <!-- <option value="2" >망</option> -->
									</select>
								</td>      
							<th style="text-align: center;">검색일</th>
								<td>
		                            <input type="date" id="fromDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${befDate}" >
		                            <span style="width: 8px; margin-right: 3px;">~</span>
		                            <input type="date" id="toDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${curDate}" >
								</td>
							</tr>
						</tbody>
						
					</table>
					<div class="list_sch" style="right: 76px; top: 119px;">
						<div class="sch_area" style="margin-top: 50px;">
							<button type="button" id="btnScanRegist" class="btn_down">신규스캔등록</button>
						</div>
					</div>
					<div class="grid_top" style="width: 100%; padding-top:10px;">
						<div class="left_box2" style="height: auto; min-height: 630px; overflow: hidden; width:59vw;">
			    			<table id="targetGrid"></table>
			    			<div id="targetGridPager"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->
<!-- 그룹 선택 버튼 클릭 팝업 -->
<div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<ul>
		<li class="status">
			<button id="pauseScheduleAll">전체 일시정지</button></li>
		<li class="status">
			<button id="restartScheduleAll">전체 재개</button></li>
		<li class="status">
			<button id="stopScheduleAll">전체 정지</button></li>
		<!-- <li class="status">
			<button id="cancelScheduleAll">전체 취소</button></li> -->
		<!-- <li class="status">
			<button id="completeScheduleAll">전체 완료</button></li> -->
		<li  class="schmanager">
			<button id="manageSchedule">스케줄 관리</button></li>
		<!-- <li class="status">
			<button id="confirmScheduleAll">확인</button></li> -->
	</ul>
</div>
<!-- 그룹 선택 버튼 클릭 팝업 종료 -->
	
<div id="viewWindow" class="ui-widget-content" style="position:absolute; left: 700px; top: 300px; touch-action: none; 
		border: 1px solid #1F3546; max-width: 900px; z-index: 999; display:none">
	<div class="popup_top">
		<h1>스케줄 세부사항</h1>
	</div>
	<div class="popup_content">
		<div class="content-box" style="width: 900px;">
			<h2>세부사항</h2>
			<table class="popup_tbl">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>스캔명</th>
						<td id="scanLabel"></td>
					</tr>
					<tr>
						<th>스캔시간</th>
						<td id="scanNextScan"></td>
					</tr>
					<tr>
						<th>주기</th>
						<td id="scanRepeat"></td>
					</tr>
					<tr>
						<th>CPU</th>
						<td id="scanCPU"></td>
					</tr>
					<tr>
						<th>Throughput</th>
						<td id="scanThroughput"></td>
					</tr>
					<tr>
						<th>Memory 제한</th>
						<td id="scanMemory"></td>
					</tr>
					<tr>
						<th>개인정보 유형</th>
						<td id="scanDataType"></td>
					</tr>
				</tbody>
			</table>
			<h2 id="targets" style="padding-top: 10px;">targets</h2>
			<table class="popup_tbl">
				<colgroup>
					<col width="20%">
					<col width="*">
				</colgroup>
				<tbody id="targetBody">
					<tr>
						<th>서버이름</th>
						<td id="scanName"></td>
					</tr>
					<tr>
						<th>스캔경로</th>
						<td id="scanLocations"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<div class="popup_btn">
		<div class="btn_area" style="border: 1px solid #efefef;">
			<button type="button" id="viewWindowClose" style="font-weight: inherit; font-size: 12px; padding: 0 15px;">확인</button>
		</div>
	</div>
</div>

<div id="viewDetails" class="popup_layer" style="display:none">
	<div class="ui-widget-content" id="popup_datatype" style="position:absolute; height: 675px; left: 27%; top: 6%; touch-action: none; max-width: 920px; z-index: 999; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleViewDetails" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_container">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; box-shadow: none; padding: 0;">스케줄 세부 현황</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="width: 900px !important; background: #fff; border: 1px solid #c8ced3; border-bottom: none;">
					<table class="popup_tbl">
						<colgroup>
							<col width="20%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>스캔명</th>
								<td id="details_label"></td>
							</tr>
							<tr>
								<th>개인정보 유형명</th>
								<td id="details_datatype"></td>
							</tr>
						</tbody>
					</table>
					<table class="popup_tbl">
						<colgroup>
							<col width="20%">
							<col width="*">
						</colgroup>
						<tbody>
							<!-- <tr>
								<th>정책 시작 시간</th>
								<td id="search_start_time"></td>
							</tr> -->
							<tr>
								<th style="height: 80px;">개인정보 유형</th>
								<td id="datatype_area">
							</tr>
							<!-- <tr>
								<th>검출시 동작</th>
								<td><input type="radio" name="action" value="0">즉시 삭제 
									<input type="radio" name="action" value="1">즉시 암호화 
									<input type="radio" name="action" value="2">익일 삭제 
									<input type="radio" name="action" value="3">익일 암호화 
									<input type="radio" name="action" value="4">선택 안함</td>
							</tr> -->
							<tr>
								<th>주기</th>
								<td id="cycle">
							</tr>
						</tbody>
					</table>
				</div>
				<div class="content-table" style="background: #fff; border: 1px solid #c8ced3; border-top: none;">
					<table class="popup_tbl">
						<colgroup>
							<col width="55%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<tbody id="details_detail">
						</tbody>
					</table>
				</div>
			</div>
			
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 2px; margin: 0;">
					<p id="comment" style="position: absolute; bottom: 17px; right: 168px; font-size: 12px; color: #2C4E8C; text-align : center;">검색하는 파일 용량이 클 때, 진행률 변동이 없을 수 있습니다. 문의가 필요하시면 보안운영팀에 연락 바랍니다.</p>
					<button type="button" id="viewDetailsClose" style="font-weight: inherit; font-size: 12px; padding: 0 15px;">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 진행율 팝업 -->
<div id="progressDetails" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 500px; z-index: 999; 
	box-shadow: 0 2px 5px #ddd; display:none;">
	<img class="CancleImg" id="btnCancleProgressDetails" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
	<div class="progress_container">
		<div class="progress_top" style="line-height: 20px;">
				<h1>검색 상세 현황</h1>
		</div>
		<input id="taskTargetid" type="hidden" val="" />
		<input id="taskApno" type="hidden" val="" />
		<input id="taskScheduleid" type="hidden" val="" />
		<input id="taskIndex" type="hidden" val="" />
		<ul style="background: #fff; border: 1px solid #c8ced3">
			<li class="status status-completed status-scheduled status-paused status-stopped status-failed" id="scanningDetailsName"></li>
			<li class="status status-completed status-scheduled status-paused status-stopped status-failed" id="scanningDetails"></li>
		</ul>
		<button id="confirmProgress" style="margin-top: 5px; margin-left : 424px;" >닫기</button>
	</div>
</div>

<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<input id="taskTargetid" type="hidden" val="" />
	<input id="taskApno" type="hidden" val="" />
	<input id="taskScheduleid" type="hidden" val="" />
	<input id="taskIndex" type="hidden" val="" />
	<ul>
		<!-- <li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed">
			<button id="viewSchedule" >보기</button></li> -->
		<!-- <li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
			<button id="deactivateSchedule">비활성화</button></li> -->
			<!-- 
		<li class="status status-scheduled status-scanning">
			<button id="modifySchedule" >수정</button></li>
			 -->
		<!-- <li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-queued">
			<button id="skipSchedule">스킵</button></li> -->
		<!-- <li class="status status-scanning">
			<button id="pauseSchedule">일시정지</button></li> -->
		<!-- <li class="status status-paused status-stopped">
			<button id="resumeSchedule">재개</button></li> -->
		<!-- <li class="status status-completed status-stopped status-failed">
			<button id="restartSchedule">재시작</button></li> -->
		<!-- <li class="status status-scanning status-queued">
			<button id="stopSchedule">정지</button></li> -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated status-queued">
			<button id="cancelSchedule" style="display: none;">정지</button>
			<button id="stopSchedule" style="display: none;">정지</button>
		</li>
		<!-- <li  class="status status-deactivated">
			<button id="reactivateSchedule">활성화</button></li> -->
		<li  class="datatype_btn">
			<button id="statusDataType">개인정보 유형</button></li>
		<!-- <li  class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated">
			<button id="manageSchedule">스케줄 관리</button></li> -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed status-queued">
			<button id="confirmSchedule" >닫기</button></li>
	</ul>
</div>

<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; padding: 10px; background: #f9f9f9; left: 37%; top: 44%; right: 40%; ">
	</div>
</div>	


<div id="popup_lbl_insertSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 85px; width: 15%; padding: 10px; background: #f9f9f9; left: 60%; top: 67%;">
	<img class="CancleImg" id="btnCancleInsertSchedule" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: none;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">스케줄 수동 입력</h1>
		</div>
		<div class="popup_insertSchedule_content" style="padding: 10px; margin-top:10px; background: #fff; border: 1px solid #c8ced3;">
			<table>
				<tr>
					<td style="padding-top: 20;">
						시작시간 : 
						<select name="start_weekday" id="start_weekday">
							<option value="0">월요일</option>
							<option value="1">화요일</option>
							<option value="2">수요일</option>
							<option value="3">목요일</option>
							<option value="4">금요일</option>
							<option value="5">토요일</option>
							<option value="6">일요일</option>
						</select>
						<select name="start_time" id="start_time">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
						</select>시
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				<tr style="margin-top: 10px;">
					<td>
						종료시간 : 
						<select name="end_weekday" id="end_weekday">
							<option value="0">월요일</option>
							<option value="1">화요일</option>
							<option value="2">수요일</option>
							<option value="3">목요일</option>
							<option value="4">금요일</option>
							<option value="5">토요일</option>
							<option value="6">일요일</option>
						</select>
						<select name="end_time" id="end_time">
							<option value="0">0</option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
							<option value="13">13</option>
							<option value="14">14</option>
							<option value="15">15</option>
							<option value="16">16</option>
							<option value="17">17</option>
							<option value="18">18</option>
							<option value="19">19</option>
							<option value="20">20</option>
							<option value="21">21</option>
							<option value="22">22</option>
							<option value="23">23</option>
						</select>시
					</td>
				</tr>
				<tr>
				</tr>
			</table>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="popup_done_insSchedule">저장</button>
				<button type="button" id="popup_cancel_insSchedule">취소</button>
			</div>
		</div>
	</div>
</div>

<!-- 개인 정보 유형 버튼 클릭 팝업 -->
<div id="SKTScheduleDataTypePopup" class="popup_layer" style="display:none"> 
	<div class="popup_box" style="height: 290px; width: 885px; padding: 10px; background: #f9f9f9; left: 44%; top: 62%;">
	<img class="CancleImg" id="btnCancleSKTScheduleDataTypePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9; display: block;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">개인정보 유형</h1>
		</div>
		<div class="popup_content" style="height: 240px;">
			<table class="user_info" style="width: 100%; height: 100%; margin-top: 10px; float: left;">
				<caption>정책 상세 정보</caption>
				<colgroup>
					<col width="15%">
					<col width="5%">
					<col width="80%">
				</colgroup>
				<tbody>
					<tr>
						<th style="border-bottom: 1px solid #c8ced3; border-radius: 0.25rem 0 0 0;">개인정보 유형 명</th>
						<td>-</td>
						<td id="left_datatype_name"></td>
					</tr>
					<tr>
						<th style="border-bottom: 1px solid #c8ced3;">개인정보유형</th>
						<td>-</td>
						<!-- <td id="left_datatype_name"></td> -->
						<td><table id="left_datatype" style="width: 90%;"></table></td>
					</tr>
					<tr>
						<th>검출시 동작</th>
						<td>-</td>
						<td id="action">
							<input type="checkbox" name="action" value="0" checked="checked"/>선택없음&nbsp;
							<input type="checkbox" name="action" value="1"/>즉시 삭제&nbsp;
							<input type="checkbox" name="action" value="2"/>즉시 암호화&nbsp;
							<input type="checkbox" name="action" value="3"/>익일 삭제&nbsp;
							<input type="checkbox" name="action" value="4"/>익일 암호화
						</td>
					</tr>
				</tbody>
			</table> 
		</div>
		<div class="popup_btn" style="height: 45px;">
			<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnDataTypePopupClose" style="margin-top: 10px;" >닫기</button>
			</div>
		</div>
	</div>
</div>	
	
<%@ include file="../../include/footer.jsp"%>
 
<script type="text/javascript"> 

var oGrid = $("#targetGrid");

$(document).ready(function () {

	//var timer = setInterval(setScanStatus, 10000);
	$(document).click(function(e){
		$("#taskGroupWindow").hide();
		//$("#taskWindow").hide();
		//$("#viewDetails").hide(); 
	});
	$("#taskWindow").click(function(e){
		e.stopPropagation();
	});
	$("#taskWindowClose").click(function(){
		$("#taskWindow").hide();
	});

  	$("#viewWindow").draggable({
 	    containment: '.content',
 	 	cancel : '.popup_content, .popup_btn'
	});
	
	$("#viewWindowClose").click(function(){
		$("#viewWindow").hide();
	});
	
	$("#btnDataTypePopupClose").click(function(e){
		$("#SKTScheduleDataTypePopup").hide();
	});
	
	$("#btnCancleSKTScheduleDataTypePopup").click(function(e){
		$("#SKTScheduleDataTypePopup").hide();
	});
	
	$("#viewDetailsClose").click(function(){
		
		$("#taskTargetid").val("");
		$("#taskApno").val("");
		$("#taskScheduleid").val("");
		$("#taskIndex").val("");
		$("#taskWindow").hide();
		$("#viewDetails").hide();
		$("#progressDetails").hide();
	})
	
	$("#btnCancleViewDetails").click(function(){
		
		$("#taskTargetid").val("");
		$("#taskApno").val("");
		$("#taskScheduleid").val("");
		$("#taskIndex").val("");
		$("#taskWindow").hide();
		$("#viewDetails").hide();
		$("#progressDetails").hide();
	})

	var ifConnect = function(cellvalue, options, rowObject) {
		if(cellvalue == null || cellvalue == ''){
			cellvalue = '<target deleted>'
		}
		return cellvalue.indexOf("<") >= 0 ? '< ' + cellvalue.replace("<","").replace(">","") + ' >' : cellvalue;
	};
	
	var createType = function(cellvalue, options, rowObject) {
		//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
		return cellvalue == 0 ? "서버" : cellvalue == 1 ? "PC" : cellvalue == 2 ? "OneDrive" : "범위"; 
	};
	
	var createView = function(cellvalue, options, rowObject) {
		//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
		var status = rowObject.STATUS;
		var result = "";
		
		if(status == 1){
			result = "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
		} else if (status == 2){
			result = "<p>완료한 스케줄입니다</p>"
		} else {
			
		}
		
		
		return result; 
	};
	
	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});
	
	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 555;

	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['그룹번호','스케줄명','생성자ID','스케줄작성자','스캔 상태', '검색대상', '정책ID','스캔 정책명', '데이터타입ID', '데이터 타입명','생성일',''],
		colModel: [
			{ index: 'SCHEDULE_GROUP_ID', 			name: 'SCHEDULE_GROUP_ID', 			width: 250, align: 'left', hidden: true},
			{ index: 'SCHEDULE_GROUP_NAME', 		name: 'SCHEDULE_GROUP_NAME',		width: '30%', align: 'left'},
			{ index: 'USER_NO',						name: 'USER_NO',					width: 150, align: 'center', hidden: true},
			{ index: 'USER_NAME',					name: 'USER_NAME', 					width: '10%', align: 'center'},
			{ index: 'STATUS',						name: 'STATUS', 					width: 80, align: 'center', hidden: true },
			{ index: 'TYPE',						name: 'TYPE', 						width: '5%', align: 'center', formatter:createType},
			{ index: 'POLICY_ID',					name: 'POLICY_ID', 					width: 160, align: 'center', hidden: true},
			{ index: 'POLICY_NAME',					name: 'POLICY_NAME', 				width: '30%', align: 'center'},
			{ index: 'DATATYPE_ID',					name: 'DATATYPE_ID', 				width: 160, align: 'center', hidden: true},
			{ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL', 			width: '40%', align: 'center', hidden: true},
			{ index: 'REGDATE',						name: 'REGDATE',					width: '20%', align: 'center'},
			{ index: 'SCHEDULE_ID2', 				name: 'SCHEDULE_ID2', 				width: '10%', align: 'center', formatter:createView, exportcol : false}
		],
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:30,
	   	rowList:[30,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
		loadComplete: function(data) {
		
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
		  		/* var rowid = event.target.parentElement.parentElement.id;
		  		
		  		var group_id = data[(rowid-1)];
		  		console.log(group_id); */
		  		
				$("#targetGrid").setSelection(event.target.parentElement.parentElement.id);
		  		var type = $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'TYPE');
				// 조건에 따라 Option 변경
				// var status = ".status-" + $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STAT');
				$(".status").css("display", "none"); 
				$(".status").css("display", "block");
				$(".manage-schedule").css("display", "block");
				
				/* if(data[(rowid-1)].TYPE == 0){
					$(".schmanager").css("display", "block");
				} else {
					$(".schmanager").css("display", "none"); 
				} */
				if(type == '서버'){
					$(".schmanager").css("display", "block");
				} else {
					$(".schmanager").css("display", "none"); 
				}

				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 55 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskGroupWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskGroupWindow").css("top").replace("px","")) + $("#taskGroupWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskGroupWindow").css("top", Number($("#taskGroupWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				$("#taskGroupWindow").show();
			});
			//setScanStatus();
	    },
	    gridComplete : function() {},
	    onCellSelect : function(rowid, icol, cellcontent, e) {
	    	if(icol == 12){
	    		$("#viewDetails").hide();
			  	$("#taskWindow").hide();
	    		return;
	    	}
	    	var group_id = $(this).getCell(rowid, 'SCHEDULE_GROUP_ID');
            var policyid = $(this).getCell(rowid, 'POLICY_ID');
            
            var postData = {
            	group_id : group_id,
            	policyid : policyid
    	  	};
            if(policyid == -1){
            	$("#details_label").html("-");
            	$("#details_datatype").html("-");
            	$("#datatype_area").html("-");
            	$(".datatype_btn").css("display", "block");
            	$(".content-box").css("display", "none");
            	$(".content-table").css({"padding": "10px", "margin-top": "10px", "border-top": "1px solid #c8ced3"});
            	$("#popup_datatype").css({"height": "375px", "top": "27%"});
            	$("#comment").text("검색하는 파일 용량이 클 때, 진행률 변동이 없을 수 있습니다. 문의가 필요하시면 보안운영팀에 연락 바랍니다.");
            }else {
	            $("#details_label").html($("#targetGrid").getCell(rowid, 'SCHEDULE_GROUP_NAME'));
		    	$("#details_datatype").html($("#targetGrid").getCell(rowid, 'DATATYPE_LABEL'));
		    	$(".datatype_btn").css("display", "none");
		    	$(".content-box").css("display", "block");
            	$(".content-table").css({"padding": "0 10px", "margin-top": "0", "border-top": "none"});
            	$("#popup_datatype").css({"height": "675px", "top": "13%"});
            	$("#comment").text("검색하는 파일 용량이 클 때, 진행률 변동이 없을 수 있습니다. 문의가 필요하시면 보안운영팀에 연락 바랍니다.");
            }
	    	
            $.ajax({
				type: "POST",
				url: "/search/registScheduleTargets",
				async : false,
				data : postData,
			    success: function (result) {
			    	var details = "";
			    	details += "<tr style=\"height: 45px;\">";
			    	details += "	<th>자산명</th>";
			    	details += "	<th>상태</th>";
			    	details += "	<th>진행율</th>"; 
			    	details += "	<th>설정</th>";
			    	details += "</tr>";
			    	$.each(result, function(index, item) {
			    		var status = item.SCHEDULE_STATUS;
			    		var platform = item.PLATFORM;
			    		var staus = setStatusKR(status, status);
			    		/* if(status == 'cancelled'){
			    			staus = '검색취소';
			    		} else if(status == 'scheduled'){
			    			staus = '검색대기';
			    		}else if(status == 'failed'){
			    			staus = '검색실패';
			    		}else if(status == 'scanning'){
			    			staus = '검색중';
			    		}else if(status == 'paused'){
			    			staus = '검색일시정지';
			    		}else if(status == 'completed'){
			    			staus = '검색완료';
			    		}else if(status == 'stopped'){
			    			staus = '검색정지';
			    		}else if(status == 'stalled'){
			    			staus = '검색멈춤';
			    		}else if(status == 'paused'){
			    			staus = '검색정지';
			    		}else if(status == 'deactivated'){
			    			staus = '검색비활성';
			    		}else if(status == 'queued'){
			    			staus = '검색대기';
			    		}else if(status == 'interrupted'){
			    			staus = '검색중단';
			    		}else if(status == null){
			    			staus = '';
			    		}  */
			    		
			    		details += "<tr style=\"height: 45px;\">";
				    	details += "	<td style=\"text-align: left; padding-left: 0;\">"+item.NAME+"</td>";
			    		/* if(platform.indexOf("Apple") == -1){
					    	details += "	<td style=\"text-align: left; padding-left: 0;\">"+item.NAME+"</td>";
			    		}else{
			    			details += "	<td style=\"text-align: left; padding-left: 0;\">"+item.MAC_NAME+"</td>";
			    		} */
				    	details += "	<td id=\"status_"+index+"\" style=\"text-align: center; padding-left: 0;\">"+staus+"</td>";
				    	if(item.SCHEDULE_STATUS == 'scanning'){
				    		details += "<td style=\"text-align: center; padding-left: 0;\" data-indx="+index+" data-targetid="+item.TARGET_ID+" data-policyid="+item.POLICY_ID+" data-apno="+item.AP_NO+" data-datatypeid="+item.DATATYPE_ID+" data-id="+item.RECON_SCHEDULE_ID+" data-status="+item.SCHEDULE_STATUS+" >" ;
				    		details += "<img src=\"${pageContext.request.contextPath}/resources/assets/images/scanning.gif\" style=\"margin-left: 3px; margin-top: 4px; cursor:pointer;\" class=\"statusChoiseBtn\" width=\"15px;\">"+"</td>";
				    		//details += "<button type='button' style=\"text-align: center; width: 54px; margin: 3px 17px 3px 42px; font-size: 0.6vw;\" class=\"statusChoiseBtn\">선택</button>"+"</td>";
				    	}else{
				    		details += "<td style=\"text-align: center; height: 25px; padding-left: 0;\">"+""+"</td>"
				    	}
				    	details += "	<td style=\"text-align: center;\" data-indx="+index+" data-targetid="+item.TARGET_ID+" data-policyid="+item.POLICY_ID+" data-apno="+item.AP_NO+" data-datatypeid="+item.DATATYPE_ID+" data-id="+item.RECON_SCHEDULE_ID+" data-status="+item.SCHEDULE_STATUS+"><button type='button' style=\"text-align: center; width: 54px; margin: 3px 0 3px -20px; font-size: 11px;\" class=\"targetChoiseBtn\">선택</button></td>";
				    	details += "</tr>";
			    	});
			    	$("#details_detail").html(details);
			    },
			    error: function (request, status, error) {
			    	alert("정보를 불러오는데 실패하였습니다.");
			        console.log("ERROR : ", error);
			    }
	  		});
			var postData = {
		  		policyid : policyid,
				scheduleUse : 1
			};
		  	
		  	$.ajax({
				type: "POST",
				url: "/search/getPolicy",
				async : false,
				data : postData,
			    success: function (result) {
				   	/* var start_dtm = setStartdtm(result[0]);
					$('#search_start_time').html(start_dtm); */
				   	
				 	// 개인정보 유형 
					var datatype = setDatatype(result[0]);
					$('#datatype_area').html(datatype);
					
					$("#details_datatype").html(result[0].TYPE);
				   	
				   	var cycle = setCycle(result[0]);
					$('#cycle').html(cycle);
			    },
			    error: function (request, status, error) {
			    	alert("정책 정보를 갖고 올수 없습니다.");
			        console.log("ERROR : ", error);
			    }
		  	});
		  		
		  	$("#viewDetails").show();
		  	$("#taskWindow").hide();
		  	
			/* 검색 주기 확인 */
			$(".targetChoiseBtn").on("click", function(e) {
				var targetid = $(this).parent().data('targetid');
				var ap_no = $(this).parent().data('apno');
				var id = $(this).parent().data('id');
				var status = $(this).parent().data('status');
				var datatypeid = $(this).parent().data('datatypeid');
				var policyid = $(this).parent().data('policyid');
				var index = $(this).parent().data('index');
				
				//$("#targetGrid").setSelection(targetid);
				
				$("#taskTargetid").val(targetid);
				$("#taskApno").val(ap_no);
				$("#taskScheduleid").val(id);
				$("#taskIndex").val(index);
				
				// 조건에 따라 Option 변경
				var status = ".status-"+status;
				$(".status").css("display", "none"); 
				$(status).css("display", "block");
				$(".manage-schedule").css("display", "block");
				
				var offset = $(this).parent().offset();
				$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + 55 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				} 
				
				if(status == '.status-scheduled' || status == '.status-paused'){ // 대기일때는 취소만
					$("#cancelSchedule").show();
					$("#stopSchedule").hide();
				}else{
					$("#stopSchedule").show();
					$("#cancelSchedule").hide();
				}
				
				$("#taskWindow").show();
				
				$("#statusDataType").click(function(e){
					$("#SKTScheduleDataTypePopup").show();
					$("#taskWindow").hide();
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
				});

			});
			/* 검색 주기 확인 종료 */
			
			/* 진행율 확인 버튼 */
			$(".statusChoiseBtn").on("click", function(e) {
				var targetid = $(this).parent().data('targetid');
				var ap_no = $(this).parent().data('apno');
				var id = $(this).parent().data('id');
				var status = $(this).parent().data('status');
				var index = $(this).parent().data('index');
				
				var postData = {
					id : id,
					ap_no : ap_no,
				};
				if(status == 'scanning' ){
					$.ajax({
						type: "POST",
						url: "/search/getScanDetails",
						async : false,
						data : postData,
					    success: function (resultMap) {
					    	
					    	$.each(resultMap.resultData, function(index, item){
					    		
					    		var detailsContent = item.status + "(" + item.percentage + " 'File path";
					    			detailsContent += item.currentlyFile + ")";
					    		
					    		$("#scanningDetailsName").html(item.name);
					    		$("#scanningDetails").html(detailsContent);
					    	});
					        
					    },
					    error: function (request, status, error) {
							alert("ERROR");
					        console.log("ERROR : ", error);
					    }
					});			
				}
				
				$("#taskTargetid").val(targetid);
				$("#taskApno").val(ap_no);
				$("#taskScheduleid").val(id);
				$("#taskIndex").val(index);
				
				var offset = $(this).parent().offset();
				$("#progressDetails").css("left", "1113px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#progressDetails").css("top", offset.top + $(this).height() + 16 + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#progressDetails").css("top").replace("px","")) + $("#progressDetails").height();

				if (taskBottom > bottomLimit) { 
					$("#progressDetails").css("top", Number($("#progressDetails").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				} 
				$("#progressDetails").show();
				
			});
	    }
	});

	// 초기 조회
	var searchType = ['scheduled'];
	var postData = {
			fromDate : $("#fromDate").val(),
			toDate : $("#toDate").val(),
			searchType : JSON.stringify(searchType)};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/registScheduleGroup", postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	// 버튼 Action 설정
	$("#btnSearch").click(function() {
		
		if($("#fromDate").val() > $("#toDate").val()){
			alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
			return;
		}

		var postData = {
			fromDate : $("#fromDate").val(),
			toDate : $("#toDate").val(),
			title : $("#title").val(),
			writer : $("#writer").val(),
			sch_type : $("#sch_type").val(),
			searchType : JSON.stringify(searchType)
		};

		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/registScheduleGroup", postData : postData, datatype:"json" }).trigger("reloadGrid");
    });

	$("#title").keyup(function(e){
		if (e.keyCode == 13) {
			$("#btnSearch").click();
		}
	});
	
	$("#writer").keyup(function(e){
		if (e.keyCode == 13) {
			$("#btnSearch").click();
		}
	});
	
	$("#chk_completed, #chk_deactivated, #chk_cancelled, #chk_stopped, #chk_failed").change(function() {
		$("#btnSearchScan").click();
	});
	
	
	$("#deactivateSchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("deactivate");
	});
	$("#modifySchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("modify");
	});
	$("#skipSchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("skip");
	});
	$("#pauseSchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("pause");
	});
	
	$("#resumeSchedule").click(function(){
		$("#taskWindow").hide();
		//changeSchedule(id, "restart", row);
		changeSchedule("resume");
	});
	
	$("#restartSchedule").click(function(){
		$("#taskWindow").hide();
		//changeSchedule(id, "restart", row);
		changeSchedule("restart");
	});
	$("#stopSchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("stop");
	});
	$("#cancelSchedule").click(function(){
		$("#taskWindow").hide();
        changeSchedule("cancel");
	});
	$("#reactivateSchedule").click(function(){
		$("#taskWindow").hide();
		
		changeSchedule("reactivate");
	});
	
	$("#confirmSchedule").click(function(){
		$("#taskWindow").hide();
	});
	
	$("#confirmProgress").click(function(){
		$("#progressDetails").hide();
	});
	
	$("#btnCancleProgressDetails").click(function(){
		$("#progressDetails").hide();
	});
	
	$("#btnScanRegist").click(function(){
		//window.location = "${pageContext.request.contextPath}/scan/pi_scan_regist";
		window.location = "${pageContext.request.contextPath}/search/search_regist";
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});
	
	// 스케줄관리 click
	$("#manageSchedule").click(function(){
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_GROUP_ID');
		var name = $("#targetGrid").getCell(row, 'SCHEDULE_GROUP_NAME');
		// 스케줄관리 pop 생성
		setManageSchedulePop(id, name);
	});
	
	$("#pauseScheduleAll").click(function(){
		var statusList = ["scanning"];
		changeScheduleAll(statusList, "pause");
	});
	$("#restartScheduleAll").click(function(){
		var statusList = ["paused"];
		changeScheduleAll(statusList, "resume");
	});
	$("#stopScheduleAll").click(function(){
		var statusList = ["completed", "scheduled", "scanning", "paused", "stopped", "failed", "deactivated"];
		
		changeScheduleAll(statusList, "cancel");
	});
	$("#cancelScheduleAll").click(function(){
		var statusList = ["completed", "scheduled", "scanning", "paused", "stopped", "failed", "deactivated"];
		changeScheduleAll(statusList, "cancel");
	});
	// 전체 완료 버튼 클릭
	$("#completeScheduleAll").click(function(){
		var rowid = $("#targetGrid").jqGrid('getGridParam', "selrow" );  
	    var group_id =$("#targetGrid").getCell(rowid, 'SCHEDULE_GROUP_ID');
	 	
	 	var postData = {
	 		groupid : group_id,
	 	};
	 	var message = "대상 스케줄을 완료 처리하시겠습니까?";
	 	if (confirm(message)) {
		 	$.ajax({
		 		type: "POST",
		 		url: "/search/completedSchedule",
		 		async : false,
		 		data : postData,
		 	    success: function (resultMap) {
	
		 	        if (resultMap.resultCode != 0) {
		 	        	return;
		 		    }
		             	
		 	     	//$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);
	
		 	     	alert("대상 스케줄을 완료처리 하였습니다.");
		 	     	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/registScheduleGroup", postData : postData, datatype:"json" }).trigger("reloadGrid");
		 	       
		 	    },
		 	    error: function (request, status, error) {
		 			alert("ERROR");
		 	        console.log("ERROR : ", error);
		 	    }
		 	});
	 	}
	});
	
	var grade = ${memberInfo.USER_GRADE};
	var gradeChk = [0, 1, 2, 3, 7];
	
	if(gradeChk.indexOf(grade) != -1){
		$(".container_comment").html("대상별 개인정보 검색 스케줄 및 진행사황을 확인할 수 있습니다.");
		
	}
});

var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();

if(dd<10) {
    dd='0'+dd
} 

if(mm<10) {
    mm='0'+mm
} 

today = yyyy + "" + mm + dd;

function downLoadExcel()
{
    oGrid.jqGrid("exportToCsv",{
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
        fileName : "스케줄리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

/**
 * id : schedule ID, 
 * task : 변경할 Task 
 * row : 그리드의 변경 Row ID
 * Task 변경 규칙 
 * 	- deactivate -->  deactivated
 * 	- modify --> 스캐줄 정의 및 등록 화면으로 이동, 
 * 	- skip --> scheduled
 * 	- pause --> paused
 * 	- restart --> scheduled
 * 	- stop --> scheduled
 * 	- cancel --> cancelled
 * 	- reactivate --> scheduled
 */
function changeSchedule(task)
{

	var id = $("#taskScheduleid").val();
	var apno = $("#taskApno").val();
	var targetid = $("#taskTargetid").val();
	var index = $("#taskIndex").val();
	
	var postData = {
		ap_no : apno,
		target_id : targetid,
		id : id, 
		task : task
	};
	$.ajax({
		type: "POST",
		url: "/search/changeSchedule",
		async : false,
		data : postData,
	    success: function (resultMap) {

	        if ((resultMap.resultCode != 0) && (resultMap.resultCode != 200) && (resultMap.resultCode != 204)) {
		        alert("FAIL : " + resultMap.resultMessage);
	        	return;
		    }
	     	// 작업변경이 성공하면 상태도 변경 해 준다.
	     	var changedTask = "scheduled";
	     	switch (task) {
	     	case "deactivate" :
	     		changedTask = "deactivated";
	     		break;
	     	case "skip" :
	     		changedTask = "scheduled";
	     		break;
	     	case "pause" :
	     		changedTask = "pause";
	     		break;
	     	case "restart" :
	     		changedTask = "scheduled";
	     		break;
	     	case "stop" :
	     		break;
	     	case "cancel" :
	     		changedTask = "cancelled";
	     		break;
	     	case "reactivate" :
	     		changedTask = "scheduled";
	     		break;
     		default :
	     		changedTask = "scheduled";
     		break;
	     	}
	     	
	     	var rowid = $("#targetGrid").jqGrid('getGridParam', "selrow" );  
	     	
	     	var group_id =$("#targetGrid").getCell(rowid, 'SCHEDULE_GROUP_ID');
            
            var postData = {
            	group_id : group_id,
    	  	};
	    	
            $.ajax({
				type: "POST",
				url: "/search/registScheduleTargets",
				async : false,
				data : postData,
			    success: function (result) {
			    	console.log(result);
			    	
			    	var details = "";
			    	details += "<tr style=\"height: 45px;\">";
			    	details += "	<th>자산명</th>";
			    	details += "	<th>상태</th>";
			    	details += "	<th>진행율</th>"; 
			    	details += "	<th>설정</th>";
			    	details += "</tr>";
			    	$.each(result, function(index, item) {

				    	var status = item.SCHEDULE_STATUS;
			    		var staus = setStatusKR(status, status);
			    		
			    		details += "<tr style=\"height: 45px;\">";
				    	details += "	<td style=\"text-align: left; padding-left: 0;\">"+item.NAME+"</td>";
				    	details += "	<td id=\"status_"+index+"\" style=\"text-align: center; padding-left: 0;\">"+staus+"</td>";
				    	if(item.SCHEDULE_STATUS == 'scanning'){
				    		details += "<td style=\"text-align: center; padding-left: 0;\" data-indx="+index+" data-targetid="+item.TARGET_ID+" data-policyid="+item.POLICY_ID+" data-apno="+item.AP_NO+" data-datatypeid="+item.DATATYPE_ID+" data-id="+item.RECON_SCHEDULE_ID+" data-status="+item.SCHEDULE_STATUS+" >" ;
				    		details += "<img src=\"${pageContext.request.contextPath}/resources/assets/images/scanning.gif\" style=\"margin-left: 5px; margin-top: 4px; cursor:pointer;\" class=\"statusChoiseBtn\" width=\"15px;\">"+"</td>";
				    		//details += "<button type='button' style=\"text-align: center; width: 54px; margin: 3px 17px 3px 42px; font-size: 0.6vw;\" class=\"statusChoiseBtn\">선택</button>"+"</td>";
				    	}else{
				    		details += "<td style=\"text-align: center; height: 25px; padding-left: 0;\">"+""+"</td>"
				    	}
				    	details += "	<td style=\"text-align: center;\" data-indx="+index+" data-targetid="+item.TARGET_ID+" data-policyid="+item.POLICY_ID+" data-apno="+item.AP_NO+" data-datatypeid="+item.DATATYPE_ID+" data-id="+item.RECON_SCHEDULE_ID+" data-status="+item.SCHEDULE_STATUS+"><button type='button' style=\"text-align: center; width: 54px; margin: 3px 0 3px -20px; font-size: 11px;\" class=\"targetChoiseBtn\">선택</button></td>";
				    	details += "</tr>";
			    	});
			    	$("#details_detail").html(details);
			    },
			    error: function (request, status, error) {
			    	alert("정보를 불러오는데 실패하였습니다.");
			        console.log("ERROR : ", error);
			    }
	  		});


        	/* 검색 주기 확인 */
        	$(".targetChoiseBtn").on("click", function(e) {
        		var targetid = $(this).parent().data('targetid');
        		var ap_no = $(this).parent().data('apno');
        		var id = $(this).parent().data('id');
        		var status = $(this).parent().data('status');
        		var index = $(this).parent().data('index');
        		
        		//$("#targetGrid").setSelection(targetid);
        		
        		$("#taskTargetid").val(targetid);
        		$("#taskApno").val(ap_no);
        		$("#taskScheduleid").val(id);
        		$("#taskIndex").val(index);
        		
        		// 조건에 따라 Option 변경
        		var status = ".status-"+status;
        		$(".status").css("display", "none"); 
        		$(status).css("display", "block");
        		$(".manage-schedule").css("display", "block");
        		
        		var offset = $(this).parent().offset();
        		$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + "px");
        		// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
        		$("#taskWindow").css("top", offset.top + $(this).height() + "px");

        		var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
        		var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

        		if (taskBottom > bottomLimit) { 
        			$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
        		} 
        		$("#taskWindow").show();
        	});
        	/* 검색 주기 확인 종료 */
        	
	     	/* 초기화  */
	     	$("#taskScheduleid").val("");
	    	$("#taskApno").val("");
	    	$("#taskTargetid").val("");
	    	$("#taskIndex").val("");	     	
	     	//$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);

	     	alert("스캔 스케줄의 상태가 변경되었습니다.");
		    
	    },
	    error: function (request, status, error) {
			alert("ERROR");
	        console.log("ERROR : ", error);
	    }
	});
}
 
 
 

 /**
  * id : schedule ID, 
  * task : 변경할 Task 
  * row : 그리드의 변경 Row ID
  * Task 변경 규칙 
  * 	- deactivate -->  deactivated
  * 	- modify --> 스캐줄 정의 및 등록 화면으로 이동, 
  * 	- skip --> scheduled
  * 	- pause --> paused
  * 	- restart --> scheduled
  * 	- stop --> scheduled
  * 	- cancel --> cancelled
  * 	- reactivate --> scheduled
  */
 function changeScheduleAll(tasks, task)
 {
    var rowid = $("#targetGrid").jqGrid('getGridParam', "selrow" );  
    var group_id =$("#targetGrid").getCell(rowid, 'SCHEDULE_GROUP_ID');
    
    console.log(tasks);
 	
 	var postData = {
 		groupid : group_id,
 		task : task,
 		tasks : tasks
 	};
 	$.ajax({
 		type: "POST",
 		url: "/search/changeScheduleAll",
 		async : false,
 		data : postData,
 	    success: function (resultMap) {

 	        if ((resultMap.resultCode != 0) && (resultMap.resultCode != 200) && (resultMap.resultCode != 204)) {
 		        alert("FAIL : " + resultMap.resultMessage);
 	        	return;
 		    }
             	
 	     	//$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);

 	     	alert("스캔 스케줄의 상태가 변경되었습니다.");
 	     	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/registScheduleGroup", postData : postData, datatype:"json" }).trigger("reloadGrid");
 	       
 	    },
 	    error: function (request, status, error) {
 			alert("ERROR");
 	        console.log("ERROR : ", error);
 	    }
 	});
 }


function setManageSchedulePop(id, name){
	$("#taskWindow").hide();
	var pop_html = '';

	var colName = ['start', 'end', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
	
	pop_html += '	<img class="CancleImg" id="btnCancleManageSchedule" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">';
	pop_html += '	<div class="popup_top" style="background: none;">';
	pop_html += '		<h1 style="color: #222; padding: 0; box-shadow: none;">스케줄 관리</h1>';
	pop_html += '	</div>';
	pop_html += '	<input type="hidden" id="pop_manageSchedule_schedule_id" value="'+id+'">';
	pop_html += '	<input type="hidden" id="pop_manageSchedule_schedule_name" value="'+name+'">';
	pop_html += '	<table id="popup_table_manageSchedule" style="width:100%; margin-top: 10px; table-layout: fixed;" border="1">';
	pop_html += '		<tr style="background: #cccccc; text-align: center;">';
	pop_html += '			<th>시작시간</th>';
	pop_html += '			<th>종료시간</th>';
	pop_html += '			<th>월</th>';
	pop_html += '			<th>화</th>';
	pop_html += '			<th>수</th>';
	pop_html += '			<th>목</th>';
	pop_html += '			<th>금</th>';
	pop_html += '			<th>토</th>';
	pop_html += '			<th>일</th>';
	pop_html += '		</tr>';
	
	for(var i=0; i<24; i++){
		pop_html += '<tr>';
		for(var j=0; j<9; j++){
			if(j == 0){
				pop_html += '<td style="text-align: center;">'+i+":00</td>";
			} else if (j == 1){
				pop_html += '<td style="text-align: center;">'+(i+1)+":00</td>";
			} else {
				if(i<10){
					pop_html += '<td data-key="'+colName[j]+'_0'+i+'"></td>';
				} else {
					pop_html += '<td data-key="'+colName[j]+'_'+i+'"></td>';
				}
			}
		}
		pop_html += '</tr>';
	}
	
	pop_html += '	</table>';
	pop_html += '	<div class="popup_btn">';
	pop_html += '		<p style="text-align : right; padding-top: 10px;">';
	pop_html += '			종료일시 입력 : <input type="date" id="stopDate" value="" style="text-align: center;" readonly="readonly">';
	pop_html += '			&nbsp;<input type="text" id="stop_hour" data-type="number" maxlength="2" style="text-align:right; width:50px;"/>&nbsp;시&nbsp;&nbsp;<input type="text" id="stop_minute" data-type="number" maxlength="2" style="text-align:right; width:50px; "/>&nbsp;분';
	pop_html += '		</p>';
	pop_html += '		<div class="btn_area" style="padding: 10px 0;">';
	pop_html += '			<button type="button" id="popup_insert_schedule" style="float: left;">스케줄 수동 입력</button>';
	pop_html += '			<button type="button" id="popup_delete_Schedule">스케줄 삭제</button>&nbsp;&nbsp;&nbsp;';
	pop_html += '			<button type="button" id="popup_save_manageSchedule">저장</button>';
	pop_html += '			<button type="button" id="popup_cancel_manageSchedule">취소</button>';
	pop_html += '		</div>';
	pop_html += '	</div>';
	$('#popup_box').html(pop_html);

	$.ajax({
		type: "POST",
		url: "/scan/getScanSchedule",
		async : false,
		data : {
			schedule_id: id
		},
		dataType: "text",
	    success: function (resultMap) {
	    	console.log(resultMap);
	    	var data = JSON.parse(resultMap);
	    	if(data.resultSize > 0){
	    		var resultList = data.resultList;
	    		$.each(resultList, function(index, item) {
	    			$('td[data-key="'+item+'"]').data('value', true);
	    			$('td[data-key="'+item+'"]').attr('data-value', true);
	    			$('td[data-key="'+item+'"]').attr('style', 'text-align: center; background: #4dff4d');
	    			$('td[data-key="'+item+'"]').text('ON');
	    		});
		    	if(data.stop_date != '' && data.stop_hour != '' && data.stop_minute != ''){
		    		//console.log(data.stop_date);
		    		$('#stopDate').val(data.stop_date);
		    		$('#stop_hour').val(data.stop_hour);
		    		$('#stop_minute').val(data.stop_minute);
		    	}
	    	}
	    	if(data.resultCode != '0'){
	    		alert(data.resultMessage);
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("스케줄을 불러올 수 없습니다.");
	        console.log("ERROR : ", error);
	    }
	});
	
	
	$('#popup_table_manageSchedule > ').on('click', function(event){
		var key = $(event.target).data('key');
		var checked = $(event.target).data('value');
		
		console.log('checked : ' + checked);
		if(checked == null || checked == false){
			$(event.target).data('value', true);
			$(event.target).attr('data-value', true);
			$('td[data-key="'+key+'"]').attr('style', 'text-align: center; background: #4dff4d');
			$('td[data-key="'+key+'"]').text('ON');
		} else {
			$(event.target).data('value', false);
			$(event.target).attr('data-value', false);
			$('td[data-key="'+key+'"]').attr('style', '');
			$('td[data-key="'+key+'"]').text('');
		}
		
	});
	
	$('#popup_manageSchedule').show();
	
	// 스케줄 관리 영역
	$('#popup_delete_Schedule').click(function(){		// 스케줄 삭제
		if(confirm("현재 스케줄을 삭제 하시겠습니까?")){
			deleteSchedule();
		}
	});
	$("#popup_cancel_manageSchedule").click(function(){	// 취소버튼
		$('#popup_manageSchedule').hide();
	});
	
	$("#btnCancleManageSchedule").click(function(){	// 취소버튼
		$('#popup_manageSchedule').hide();
	});
	
	$("#popup_save_manageSchedule").click(function(){	// 저장
		//alert('저장이지롱');
		if(confirm("현재 내용을 저장하시겠습니까?")){
			saveSchedule();
		}
	});
	
	$("#popup_insert_schedule").click(function(){	// 스케줄 수동입력 
		$('#popup_lbl_insertSchedule').show();
	});

	$("#stopDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			//$("#btnSearchScan").click();
			console.log($("#stopDate").val());
		}
	});
	
	$('input:text[data-type="number"]').on('keyup', function() {
		$(this).val($(this).val().replace(/[^0-9]/g,""))
		if($(this).val() == ''){
			$(this).val('00');
		}
	});

	
}

$(function() { 
	$.datepicker.setDefaults({ 
		closeText: "확인", 
		currentText: "오늘", 
		prevText: '이전 달', 
		nextText: '다음 달', 
		monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
		monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'], 
		dayNames: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'], 
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
		yearRange: 'c-5:c+5'
	}); 
});


function saveSchedule(){
	//alert($('td[data-value="true"]').length);
	var checkedKey = '';
	var stopDate = $('#stopDate').val();
	var stopHour = $('#stop_hour').val();
	var stopMinute = $('#stop_minute').val();
	
	$('td[data-value=true]').each(function(index, key){
		if(index != 0){
			checkedKey += ',';
		}
		checkedKey += $(key).data('key');
		
	});
	
	if(stopMinute < 10 && stopMinute != '' && stopMinute != 00) {
		stopMinute = '0' + stopMinute;
	}
	console.log('checkedKey : ' + checkedKey);
	console.log('stopDate : ' + stopDate);
	console.log('stopTime : ' + stopHour + ":" + stopMinute);
	
	if(checkedKey == null || checkedKey == ''){
		alert('스케줄을 선택하여 주세요.');
		return false;
	}
	
	$.ajax({
		type: "POST",
		url: "/scan/manageSchedule",
		async : false,
		data : {
			checkedKey: checkedKey,
			schedule_id: $('#pop_manageSchedule_schedule_id').val(),
			schedule_name: $('#pop_manageSchedule_schedule_name').val(),
			stopDate: stopDate,
			stopTime: stopHour + ":" + stopMinute
		},
		dataType: "text",
	    success: function (resultMap) {
			$('#popup_manageSchedule').hide();
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error);
	    }
	});
	
}

function deleteSchedule(){
	$.ajax({
		type: "POST",
		url: "/scan/deleteSchedule",
		async : false,
		data : {
			schedule_id: $('#pop_manageSchedule_schedule_id').val(),
			schedule_name: $('#pop_manageSchedule_schedule_name').val()
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
		    	setManageSchedulePop($('#pop_manageSchedule_schedule_id').val());
				alert('스케줄을 삭제 하였습니다.');
	    	} else {
	    		alert('스케줄을 실패하는데 실패하였습니다.');
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error);
	    }
	});
}

// 스케줄 수동 입력 관련 script 
$('#popup_done_insSchedule').click(function(){
	var weekday = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일']
	var msg = '';
	var starttime = $('#start_time').val();
	var endtime = $('#end_time').val();
	msg += weekday[$('#start_weekday').val()] + ' ' + (starttime < 10 ? '0'+String(starttime) : starttime) + '시 부터 ';
	msg += weekday[$('#end_weekday').val()] + ' ' + (endtime < 10 ? '0'+String(endtime) : endtime) + '시 까지 \n';
	msg += '스케줄을 등록 하시겠습니까?';
	
	if(confirm(msg)){
		setSchedule();	
		$('#popup_lbl_insertSchedule').hide();
	}
});

$('#popup_cancel_insSchedule').click(function(){
	$('#popup_lbl_insertSchedule').hide();
});

$('#btnCancleInsertSchedule').click(function(){
	$('#popup_lbl_insertSchedule').hide();
});

function setSchedule(){
	var weekday = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
	var startweek = $('#start_weekday').val();
	var starttime = $('#start_time').val();
	var endweek = $('#end_weekday').val();
	var endtime = $('#end_time').val();
	
	if(startweek == endweek && starttime == endtime){
		var key = weekday[startweek] + '_' + (starttime < 10 ? '0'+String(starttime) : starttime);
        $('td[data-key="'+key+'"]').data('value', true);
        $('td[data-key="'+key+'"]').attr('data-value', true);
        $('td[data-key="'+key+'"]').attr('style', 'text-align: center; background: #4dff4d');
        $('td[data-key="'+key+'"]').text('ON');	
        
        $('#start_weekday').val('0').attr('selected', 'selected');
    	$('#start_time').val('0').attr('selected', 'selected');
    	$('#end_weekday').val('0').attr('selected', 'selected');
    	$('#end_time').val('0').attr('selected', 'selected');
    	return;
	}
	
	var week = Number(startweek);
	var time = Number(starttime);
	var flag = true;
	while(flag){
		var key = weekday[week] + '_' + (time < 10 ? '0'+String(time) : time);
        $('td[data-key="'+key+'"]').data('value', true);
        $('td[data-key="'+key+'"]').attr('data-value', true);
        $('td[data-key="'+key+'"]').attr('style', 'text-align: center; background: #4dff4d');
        $('td[data-key="'+key+'"]').text('ON');	
        time = (time + 1) % 24;
        if(time == 0){
        	week = (week+1) % 7;
        }
        if(endweek == week && endtime == time){
        	flag = false;
        }
	}
	
	$('#start_weekday').val('0').attr('selected', 'selected');
	$('#start_time').val('0').attr('selected', 'selected');
	$('#end_weekday').val('0').attr('selected', 'selected');
	$('#end_time').val('0').attr('selected', 'selected');
	
}
function createCheckbox(cellvalue, options, rowObject) {
	//'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'
	var arr_disable = ['completed', 'cancelled', 'pending'];
	var status = rowObject['SCHEDULE_STATUS'];
	
	if (arr_disable.indexOf(status) > 0)
		return "<input type='checkbox' name='chkbox' data-id='" + rowObject['SCHEDULE_ID'] + "' data-status='" + status + "' disabled='disabled'>"; 
	else 
		return "<input type='checkbox' name='chkbox' data-id='" + rowObject['SCHEDULE_ID'] + "' data-status='" + status + "'>";
}

function executeChecked(action){
	var obj = {};
	var nextStepFlag = true;
	if('start' == action){
		var arr_able = ['stopped', 'failed', 'paused', 'deactivated'];
		$('input:checkbox[name=chkbox]:checked').each(function(){
			var id = $(this).data('id');
			var status = $(this).data('status');
			if(arr_able.indexOf(status) < 0){
				nextStepFlag = false;
			} else {
				obj[id] = status;
			}
		});
	} else if ('pause' == action){
		var arr_able = ['pending', 'scanning', 'scheduled'];
		$('input:checkbox[name=chkbox]:checked').each(function(){
			var id = $(this).data('id');
			var status = $(this).data('status');
			if(arr_able.indexOf(status) < 0){
				nextStepFlag = false;
			} else {
				obj[id] = status;
			}
		});
	}
	
	if(!nextStepFlag) {
		var action_kr = ('start' == action)? '시작': '정지';
		alert(action_kr + '할 수 없는 상태의 스케줄이 체크되었습니다.\n체크된 항목들을 확인 부탁드립니다.');
		return;
	}
	
	$.ajax({
		type: "POST",
		url: "/scan/executeChecked",
		async : false,
		contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify(obj),
		dataType: "json",
	    success: function (resultMap) {
			console.log(resultMap);
			var action_kr = ('start' == action)? '시작': '정지';
			if('00' == resultMap.resultCode){
				alert('성공적으로 '+action_kr + ' 되었습니다.');
				location.reload();
			} else {
				alert(action_kr + '이 실패하였습니다.');
			}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error);
	    }
	});
}

function setScanStatus(){
	var rows = $("#targetGrid").getDataIDs();
	$.each(rows, function(index, rowid) {
		var rowData = $("#targetGrid").getRowData(rowid);
		var id = rowData["SCHEDULE_ID"];
		var status = rowData["SCHEDULE_STATUS"];
		var ap_no = rowData["AP_NO"];
		status = setStatusEN(status);
		if('completed' == status || 'cancelled' == status){
			status = setStatusKR(status, status);
			$("#targetGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',status);
		}else{
			setStatusExecute(rowid, status, id, ap_no);
		}

	});

}

function setStatusExecute(rowid, status, id, ap_no){
	var result = "";
	var postData = {
			id : id, 
			ap_no : ap_no
			};
	
	$.ajax({
		type: "POST",
		url: "/scan/getDetails",
		async : false,
		data : postData,
	    success: function (result) {
	    	if(result.resultCode == '404'){
	    		var idx = 1;		
	    		var searchType = ['scheduled'];
	    		$("input[name=chk_schedule]:checked").each(function(i, elem) {
	    			searchType[idx++] = $(elem).val();	
	    		});

	    		var postData = {
	    				fromDate : $("#fromDate").val(),
	    				toDate : $("#toDate").val(),
	    				hostName : $("#searchHost").val(),
	    				searchType : JSON.stringify(searchType)
	    		};

	    		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/scan/pi_scan_schedule", postData : postData, datatype:"json" }).trigger("reloadGrid");
	    	} else {
		    	$.each(result.resultData, function(index, item) {
		    		var stat = "";
		    		if(index == 0){
		    			console.log(item)
		    			stat = setStatusKR(item.status, status);
		    			if(item.percentage != ''){
		    				stat = stat+'\n'+item.percentage;
		    				console.log(stat)
		    			}
		    			result = stat;
		    			$("#targetGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',result);
						$("#targetGrid").jqGrid('setCell',rowid,'SCHEDULE_STAT',setStatusEN(result));
		    		}
		    	});
	    	}
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        result = setStatusKR(status, status);
	        $("#targetGrid").jqGrid('setCell',rowid,'SCHEDULE_STATUS',result);
	    }
	});
}

function setStatusKR(status, status_ori){
	//'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'
	var result = status_ori;
	/* if('completed' == status){
		result = "완료";
	}else if('deactivated' == status){
		result = "비활성화";
	}else if('cancelled' == status){
		result = "취소";
	}else if('stopped' == status){
		result = "중지";
	}else if('failed' == status){
		result = "실패";
	}else if('scheduled' == status){
		result = "예약";
	}else if('paused' == status || 'autopaused' == status){
		result = "일시정지";
	}else if('scanning' == status){
		result = "스캔중";
	}else if('error' == status){
		result = "중지";
	}else if('queued' == status){
		result = "대기중";
	}else if('scheduled' == status){
		result = "예정";
	}else if('notscanned' == status){
		result = "미검색";
	} */
	if(status == 'cancelled'){
		result = '검색정지';
/* 		result = '검색취소'; */
	} else if(status == 'scheduled'){
		result = '검색대기';
	}else if(status == 'failed'){
		result = '검색실패';
	}else if(status == 'scanning'){
		result = '검색중';
	}else if(status == 'paused'){
		result = '검색일시정지';
	}else if(status == 'completed'){
		result = '검색완료';
	}else if(status == 'stopped'){
		result = '검색정지';
	}else if(status == 'stalled'){
		result = '검색멈춤';
	}else if(status == 'paused'){
		result = '검색정지';
	}else if(status == 'deactivated'){
		result = '검색비활성';
	}else if(status == 'queued'){
		result = '검색대기';
	}else if(status == 'interrupted'){
		result = '검색중단';
	}else if(status == null){
		result = '';
	}
	
	return result;
}

function setStatusEN(status){
	//'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'
	var result = status;
	/* if(status.indexOf("완료") >= 0){
		result = "completed";
	}else if(status.indexOf("비활성화") >= 0){
		result = "deactivated";
	}else if(status.indexOf("취소") >= 0){
		result = "cancelled";
	}else if(status.indexOf("중지") >= 0){
		result = "stopped";
	}else if(status.indexOf("실패") >= 0){
		result = "failed";
	}else if(status.indexOf("예약") >= 0){
		result = "scheduled";
	}else if(status.indexOf("일시정지") >= 0){
		result = "paused";
	}else if(status.indexOf("스캔중") >= 0){
		result = "scanning";
	}else if(status.indexOf("대기중") >= 0){
		result = "queued";
	}else if(status.indexOf("예정") >= 0){
		result = "schduled";
	}else if(status.indexOf("미검색") >= 0){
		result = "notscanned";
	} */
	
	return result;
}

/* 검색 시작 시간 확인 */
function setStartdtm(rowData){
	var start_dtm = rowData.START_DTM;
	var start_ymd = '';
	var start_hour = '';
	var start_minutes = '';
	if(start_dtm != null && start_dtm != ''){
		start_ymd = start_dtm.substr(0,10);
		start_hour = start_dtm.substr(11,2);
		start_minutes = start_dtm.substr(14,2);
	}
	
	var html = "";
	html += "<input type='date' id='start_ymd' style='text-align: center; height: 27px;' value='"+start_ymd+"' disabled='disabled'>&nbsp;";

	html += "<select name=\"start_hour\" id=\"start_hour\" disabled='disabled'>"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i)+1);
		var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
		html += "<option value=\""+str_hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+str_hour+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"start_minutes\" disabled='disabled'>"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		var str_minutes = (parseInt(minutes) < 10) ? '0'+minutes : minutes
		html += "<option value=\""+str_minutes+"\" "+(minutes == parseInt(start_minutes)? 'selected': '')+">"+str_minutes+"</option>"
	}
	html += "</select>"
	
	return html;
}
/* 검색 시작 시간 확인 종료 */


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


</script>


</body>
</html>