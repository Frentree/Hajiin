<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
<style>
	.ui-jqgrid tr.jqgrow{
		height: 37px;
	}
	#topNGrid_SCHEDULE_ID2{
		border-right: none;
	}
	.ui-state-hover td{
		background: #dadada !important;
	}
	.user_info th{
		width: 110px;
	}
	#left_datatype th, #left_datatype td {
		padding: 0;
	}
	#policyNm{
		text-decoration: underline;
	}
	#policyNm:hover {
		font-weight: bold;
		cursor: pointer;
	}
	.btn_look_approval{
		background-position: 0px 2px;
	}
	.scanning_href:hover{
		font-weight: bolder;
	}
}
	
</style>
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>스캔 관리</h3>
					<p class="location">스캔 관리 > 스캔 스캐줄</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<h3 style="display: inline; top: 25px;">검색 현황</h3>
				<p class="container_comment" style="position: absolute; top: 32px; left: 146px; font-size: 13px; color: #9E9E9E;">서버별 검색 진행 현황을 확인하는 화면입니다.</p>
				<!-- content -->
				<div class="content magin_t35">
					<table class="user_info narrowTable" style="width: 698px;">
	                    <caption>사용자정보</caption>
	                    <tbody>
	                        <tr>
	                            <th style="text-align: center; border-radius: 0.25rem;">그룹</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_group" placeholder="그룹명을 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">호스트명</th>
	                            <td>
	                                <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_host" placeholder="호스트명을 입력하세요.">
	                            </td>
	                        	<!-- <th style="text-align: center; border-radius: 0.25rem;">서비스명</th>
	                            <td style="width:10vw">
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_svcName" placeholder="서비스명을 입력하세요.">
	                            </td> -->
	                           	<td>
	                           		<input type="button" name="button" class="btn_look_approval" id="sch_search">
	                           	</td>
	                        </tr>
	                    </tbody>
                	</table>
					<div class="grid_top" style="width: 100%; padding-top: 10px;">
						<div class="left_box2" style="max-height: 665px; height: 665px; overflow: hidden;">
		   					<table id="topNGrid"></table>
		   				 	<div id="topNGridPager"></div>
		   				</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->


<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 160px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 2px 2px 5px #ddd; display:none">
	<input id="taskTargetid" type="hidden" val="" />
	<input id="taskApno" type="hidden" val="" />
	<input id="taskScheduleid" type="hidden" val="" />
	<input id="taskIndex" type="hidden" val="" />
	<div id="grid_status">
	</div>
	<ul style="padding: 0 20px 10px 20px;">
		<!-- <li class="status status-scheduled status-scanning status-paused">
			<button id="changeBtn" style="width: 100%;">스케줄 확인/변경</button></li>
		<li class="status status-scheduled status-scanning status-paused">
			<button id="confirmBtn" style="width: 100%;">검색 확정</button></li> -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated status-queued">
			<button id="cancelBtn" style="width: 100%; display: none;">검색 정지</button>
			<button id="stopBtn" style="width: 100%; display: none;">검색 정지</button></li>
		<!-- <li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated status-queued">
			<button id="resumeBtn" style="width: 100%;">검색 재개</button></li> -->
		<li class="">
			<button id="confirmSchedule" style="width: 100%;">닫기</button></li> 
	</ul>
</div>

<!-- 팝업창 - 확정 시작 -->
<div id="selectConfirmPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="top: 66%; height: 150px; width: 410px; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleConfirmPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9; display: block;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">스케줄 확정</h1>
		</div>
		<div class="popup_content" style="height: 60px;">
			<div class="content-box" style="height: 60px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<tbody>
						<tr>
							<td style="padding-left: 4px;">
								<p>확정 하시겠습니까? 확정 하시는 경우 해당 스케줄로 검색이 실행 됩니다.</p>
								<input type="hidden" id="chk_id" val="">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnConfirmSave">확정</button>
				<button type="button" id="btnConfirmCancel">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 확정 종료 -->


<!-- 팝업창 - 스케줄 변경 시작 -->
<div id="changeSchedulePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 160px; width: 455px; top: 70%; left: 55%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleChangePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">스케줄 시간 변경</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="width: 440px; height: 75px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th class="" style="padding: 20px 0 20px 10px;">검색 시작 시간</th>
							<td id="start_time"></td>
						</tr>
						<tr style="display: none;">
							<th class="borderB">검색 정지 시간</th>
							<td id="stop_time"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn" style="height: 35px;">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnChangeSchduleSave">저장</button>
				<button type="button" id="btnChangeSchduleCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 스케줄 변경 종료 -->

<!-- 팝업창 - 스케줄 확인 시작 -->
<div id="viewSchedulePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 160px; width: 455px; top: 70%; left: 55%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleViewSchedulePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">스케줄 확인</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="width: 440px; height: 75px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th class="" style="padding: 20px 0 20px 10px;">검색 시작 시간</th>
							<td id="view_start_time"></td>
						</tr>
						<tr style="display: none;">
							<th class="borderB">검색 정지 시간</th>
							<td id="view_stop_time"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn" style="height: 35px;">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<!-- <button type="button" id="btnViewSchduleSave">저장</button> -->
				<button type="button" id="btnViewSchduleCancel">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 스케줄 확인 종료 -->

<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
	</div>
</div>	


<!-- <div id="popup_lbl_insertSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 20%; width: 15%; left: 60%; top: 60%;">
		<div class="popup_top">
			<h1>스케줄 수동 입력</h1>
		</div>
		<table style="margin-top: 20px; margin-left: 50px;">
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
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="popup_done_insSchedule">저장</button>
				<button type="button" id="popup_cancel_insSchedule">취소</button>
			</div>
		</div>
	</div>
</div> -->

<div id="dataTypePopup" class="popup_layer" style="display:none"> 
	<div class="popup_box" style="height: 290px; width: 885px; padding: 10px; background: #f9f9f9; left: 44%; top: 62%;">
	<img class="CancleImg" id="btnCancleDataTypePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
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

<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
	</div>
</div>

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

	
	
<%@ include file="../../include/footer.jsp"%>
 
<script type="text/javascript"> 

$(document).ready(function () {
	
	var grade = ${memberInfo.USER_GRADE};
	var gradeChk = [0, 1, 2, 3, 7];
	if(gradeChk.indexOf(grade) != -1){
		fn_drawPCNGrid();
	}else {
		fn_drawTopNGrid();
	}
	fnc_search();
	
	$(document).click(function(e){
		//$("#taskGroupWindow").hide();
		$("#taskWindow").hide();
		$("#viewDetails").hide(); 
	});
	
	$("#sch_group").keyup(function(e){
		if (e.keyCode == 13) {
			$("#sch_search").click();
		}
	});
	
	$("#sch_host").keyup(function(e){
		if (e.keyCode == 13) {
			$("#sch_search").click();
		}
	});
	
	$("#sch_svcName").keyup(function(e){
		if (e.keyCode == 13) {
			$("#sch_search").click();
		}
	});
	
	$("#sch_svcManager").keyup(function(e){
		if (e.keyCode == 13) {
			$("#sch_search").click();
		}
	});
	
	$("#taskWindow").click(function(e){
		e.stopPropagation();
	});
	
	$("#taskWindowClose").click(function(){
		$("#taskWindow").hide();
	});
	
	/* 확정 버튼 클릭 이벤트 */
	$("#confirmBtn").click(function(){
		var row = $("#topNGrid").getGridParam( "selrow" );
		var confirm = $("#topNGrid").getCell(row, 'CONFIRM');
		
		if(confirm == 1){
			alert("이미 확정된 스케줄입니다.");
			return;
		}
		
		$("#selectConfirmPopup").show();
	});
	
	/* 확정 저장 버튼 클릭 이벤트 */
	$("#btnConfirmSave").click(function(){
		var row = $("#topNGrid").getGridParam( "selrow" );
		var id = $("#topNGrid").getCell(row, 'SCHEDULE_ID');
		var apno = $("#topNGrid").getCell(row, 'AP_NO');
		var target_id = $("#topNGrid").getCell(row, 'TARGET_ID');
		
		var postData = {
			confirm : 1,
			schedule_id : id,
			ap_no : apno,
			target_id : target_id,
			task : "cancelled"
		};
		
		$.ajax({
			type: "POST",
			url: "/search/confirmApply",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	alert(resultMap.resultMessage);
		    	if(resultMap.resultCode == 0){
		    		
		    	}

		    	$("#topNGrid").setGridParam({url:"/search/getStatusList", postData : '', datatype:"json" }).trigger("reloadGrid");
		    },
		    error: function (request, status, error) {
				alert("ERROR");
		        console.log("ERROR : ", error);
		    }
		});
		$("#selectConfirmPopup").hide();

		$("#changeSchedulePopup").hide();
	});
	/* 확정 닫기 버튼 클릭 이벤트 */
	$("#btnConfirmCancel").click(function(){
		$("#selectConfirmPopup").hide();
		$("#changeSchedulePopup").hide();
		$("#topNGrid").setGridParam({url:"/search/getStatusList", postData : '', datatype:"json" }).trigger("reloadGrid");
	});
	
	$("#btnCancleConfirmPopup").click(function(){
		$("#selectConfirmPopup").hide();
		$("#changeSchedulePopup").hide();
		$("#topNGrid").setGridParam({url:"/search/getStatusList", postData : '', datatype:"json" }).trigger("reloadGrid");
	});
	
	/* 스케줄 취소 버튼 클릭 이벤트 */
	$("#cancelBtn").click(function(){
		var msg = '검색 스케줄 정지 시 복구가 불가능하며, 검색을 실행하시고자 하는경우 [검색실행] 절차를 다시 수행하셔야 합니다. 해당 스케줄을 정지 하시겠습니까?';
		/* var msg = '검색 스케줄 취소 시 복구가 불가능하며, 검색을 실행하시고자 하는경우 [검색실행] 절차를 다시 수행하셔야 합니다. 해당 스케줄을 취소 하시겠습니까?'; */
		
		$("#taskWindow").hide();
		if(confirm(msg)){
			changeSchedule("cancel");
		}

	});
	
	/* 스케줄 정지 버튼 클릭 이벤트 */
	$("#stopBtn").click(function(){
		var msg = '검색 스케줄 정지 시 복구가 불가능하며, 검색을 실행하시고자 하는경우 [검색실행] 절차를 다시 수행하셔야 합니다. 해당 스케줄을 정지 하시겠습니까?';

		$("#taskWindow").hide();
		if(confirm(msg)){
			changeSchedule("stop");
		}

	});
	
	/* 스케줄 변경 버튼 클릭 이벤트 시작 */
	/* $("#changeBtn").click(function(){
		var row = $("#topNGrid").getGridParam( "selrow" );
		
		var start_dtm = setStartdtm($("#topNGrid").getRowData(row));
		$('#start_time').html(start_dtm);
		
		var stop_dtm = setStopdtm($("#topNGrid").getRowData(row));
		$('#stop_time').html(stop_dtm);
		$("#changeSchedulePopup").show();

	}); */
	
	/* 스케줄 변경 - 저장 버튼 클릭 이벤트 */
	$("#btnChangeSchduleSave").click(function(){
		var row = $("#topNGrid").getGridParam( "selrow" );
		var id = $("#topNGrid").getCell(row, 'SCHEDULE_ID');
		var apno = $("#topNGrid").getCell(row, 'AP_NO');
		var act_confirm = $("#topNGrid").getCell(row, 'CONFIRM');
		var schedule_id = $("#topNGrid").getCell(row, 'SCHEDULE_ID');
		
		var location = $("#topNGrid").getCell(row, 'LOCATION_ID');
		var repeat_days = $("#topNGrid").getCell(row, 'SCHEDULE_REPEAT_DAYS');
		var repeat_months = $("#topNGrid").getCell(row, 'SCHEDULE_REPEAT_MONTHS');
		
		var cpu = 'low';
		var throughput = 0;
		var memory = 0;
		var trace = true;
		var timezone = "Default";
		var capture = false;
		var pause_chk = ($('#stop_chk').is(':checked')? '1': '0');
		
		/* if(apno != 0){
			alert("PC 대상은 스케줄시간을 변경하실 수 없습니다.");
			return;
		}*/
		
		var pause = {};
		if(pause_chk == 1) {
			pause.start = ($("#from_time_hour").val()* 60 * 60) + ($("#from_time_minutes").val()*60);
			pause.end = ($("#to_time_hour").val()* 60 * 60) + ($("#to_time_minutes").val() * 60);
			
			if(pause.start == pause.end) {
				alert("검색 정지 시작 시간과 끝 시간을 다르게 설정해주세요");
				return;
			}
			pause.days = 127;
		}

		var start_ymd = $('#start_ymd').val();
		var start_hour = $('#start_hour').val();
		var start_minutes = $('#start_minutes').val();
		
		var start = start_ymd.toString() + ' ' + start_hour.toString() + ':' + start_minutes.toString();
		
		// 타겟 별 개별 실행
		var scheduleArr = new Array();
		
		var thisDateTime = getDateTime(null, "mi", 1);
		var nowDate = thisDateTime.substring(0,4) + "-"
				+ thisDateTime.substring(4,6) + "-" 
				+ thisDateTime.substring(6,8) + " " 
				+ thisDateTime.substring(8,10) + ":" 
				+ thisDateTime.substring(10,12) + ":" 
				+ thisDateTime.substring(12,14);
		
		var nowDatas = new Date(nowDate);
		var newData = new Date(start);
		nowDatas.setMinutes(nowDatas.getMinutes() + 10);
		
		if(nowDatas >= newData){
			alert("10분 이내에 수정 불가능합니다.");
			return;
		}
			
			//var target_id = $(element).data("targetid");
			//var locationid = $(element).data("locationid");
			
		var name = $("#topNGrid").getCell(row, 'NAME');
		var locationid = $("#topNGrid").getCell(row, 'LOCATION_ID');
		
		var data = {};
		
		data.label = name+"_"+nowDate;
		
		var targetsArr = new Array();
		var locationArr = new Array();
		
		var targets = {};
		var locations = {};
		targets.id = $("#topNGrid").getCell(row, 'TARGET_ID');
		
		locations.id = locationid;
		locationArr.push(locations);
		targets.locations = locationArr;
		targetsArr.push(targets);
		
		// target 등록
		data.targets = targetsArr;
		
		var profileArr = new Array();
		profileArr.push($("#topNGrid").getCell(row, 'DATATYPE_ID'));
		
		// target 등록
		data.profiles = profileArr;
		data.start = start;
		data.repeat_days = repeat_days;
		data.repeat_months = repeat_months;
		data.cpu = cpu;
		data.throughput = throughput;
		data.memory = memory;
		data.pause = pause;
		data.trace = trace;
		data.timezone = timezone;
		data.capture = capture;
		
		var param = {
			scheduleData : data,
			ap_no : apno,
			target_id : $("#topNGrid").getCell(row, 'TARGET_ID'),
			schedule_id : id,
		}
		
		scheduleArr.push(param);
		
		console.log(scheduleArr);
		
		var postData = {
			scheduleArr : JSON.stringify(scheduleArr),
			scheduleid : $("#topNGrid").getCell(row, 'SCHEDULE_ID'),
			ap_no: apno
		};
		var message = "스캔 스케줄을 변경하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/search/updateSchedule",
				async : false,
				data : postData,
			    success: function (resultMap) {
					console.log(resultMap);
			        
			        if (resultMap.resultCode == 409) {
				        alert("스캔 스케줄 변경이 실패 되었습니다.\n\n스캔 스케줄명이 중복 되었습니다.");
						$("#changeSchedulePopup").hide();
			        	return;
				    }
			        if (resultMap.resultCode == 422) {
			        	alert("스캔 스케줄 변경이 실패 되었습니다.\n\n스케줄 시작시간을 확인 하십시요.");
			    		$("#changeSchedulePopup").hide();
			        	return;
				    }
			        
			        if (resultMap.resultCode == 204) {
				        alert("스캔 스케줄이 변경되었습니다.");
				        $("#changeSchedulePopup").hide();
				        if(act_confirm != 1 && apno == 0){
				        	 $("#selectConfirmPopup").show();
				        }
				    }
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}	 
		
		setTimeout(function(){
			$.ajax({
				type: "POST",
				url: "/search/updateReconSchedule",
				async : false,
				data : {
					scheduleid : $("#topNGrid").getCell(row, 'SCHEDULE_ID'),
					ap_no: apno
				},
			    success: function (resultMap) {
			    	if(act_confirm == 1 || apno != 0){
			        	$("#topNGrid").setGridParam({url:"/search/getStatusList", postData : postData, datatype:"json" }).trigger("reloadGrid");
			    	}
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
			
		}, 2000);
	});
	
	
	/* 스케줄 변경 - 닫기 버튼 클릭 이벤트 */
	$("#btnChangeSchduleCancel").click(function(){
		$("#changeSchedulePopup").hide();
	});
	
	$("#btnCancleChangePopup").click(function(){
		$("#changeSchedulePopup").hide();
	});
	/* 스케줄 변경 버튼 클릭 이벤트 종료 */
	
	/* 스케줄 확인 - 닫기 버튼 클릭 이벤트 */
	$("#btnViewSchduleCancel").click(function(){
		$("#viewSchedulePopup").hide();
	});
	
	$("#btnCancleViewSchedulePopup").click(function(){
		$("#viewSchedulePopup").hide();
	});
	/* 스케줄 변경 버튼 클릭 이벤트 종료 */
	
	/* 스케줄 닫기 버튼 클릭 이벤트 */
	$("#confirmSchedule").click(function(){
		$("#taskWindow").hide();
	});
	
	// 스케줄관리 click
	$("#manageSchedule").click(function(){
		var row = $("#topNGrid").getGridParam( "selrow" );
		var id = $("#topNGrid").getCell(row, 'SCHEDULE_ID');
		
		// 스케줄관리 pop 생성
		console.log(id);
		setManageSchedulePop(id);
	});
	
	var grade = ${memberInfo.USER_GRADE};
	var gradeChk = [0, 1, 2, 3, 7];
	
	if(gradeChk.indexOf(grade) != -1){
		$(".container_comment").html("대상별 검색 진행 상태를 확인하는 화면입니다.");
		
	}
	
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	
	$("#topNGrid").jqGrid({
		//data:dataArr,
		datatype: "local",
	   	mtype : "POST",
		colNames:['그룹명', 'TARGETID', 'APNO', '타겟상태', '호스트명', '서비스명', '업무 담당자(정)ID', '업무 담당자(정)', '소속','업무 담당자(부)ID', '업무 담당자(부)', '소속',
			'업무 담당자ID', '업무 담당자', '업무 담당자4', '업무 담당자5', '소속', '스케줄ID', 'ENABLE', '로케이션ID','데이타타입ID', '스케줄정지일','스케줄 정지종료', '스케줄 정지시작','주기DAY','주기MONTH', '상태EN', '검색진행 상태', '진행율' , '검색시작시간', 
			'검출파일 수', '검출 수', '컨펌','정책ID', '개인정보 유형', '메모', ''],
		colModel: [
			{ index: 'GROUP_NAME', 					name: 'GROUP_NAME',				width: 150, align: "center",
			  cellattr: function(rowId, tv, rowObject, cm, rdata) {
					return 'style="background-color: #f9f9f9;"'	  
			  }
			},
			{ index: 'TARGET_ID', 					name: 'TARGET_ID',				width: 150, hidden:true},
			{ index: 'AP_NO', 						name: 'AP_NO', 					width: 150, hidden:true},
			{ index: 'TARGET_USE', 					name: 'TARGET_USE', 			width: 150, hidden:true},
			{ index: 'NAME', 						name: 'NAME', 					width: 150, align: "center",
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SERVICE_NM', 					name: 'SERVICE_NM', 			width: 150, align: "center", hidden: true, formatter: serviceNm,
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SERVICE_MNGR_NO', 			name: 'SERVICE_MNGR_NO', 		width: 150, hidden:true},
			{ index: 'SERVICE_MNGR', 				name: 'SERVICE_MNGR', 			width: 150, align: "center"},
			{ index: 'TEAM_NAME', 					name: 'TEAM_NAME', 				width: 150, hidden:true},
			{ index: 'SERVICE_MNGR2_NO', 			name: 'SERVICE_MNGR2_NO', 		width: 150, hidden:true},
			{ index: 'SERVICE_MNGR2', 				name: 'SERVICE_MNGR2', 			width: 150, align: "center",
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SERVICE_USER_TEAM', 			name: 'SERVICE_USER_TEAM', 		width: 150, hidden:true},
			{ index: 'SERVICE_MNGR3_NO', 			name: 'SERVICE_MNGR3_NO', 		width: 150, hidden:true},
			{ index: 'SERVICE_MNGR3', 				name: 'SERVICE_MNGR3', 			width: 150, align: "center", formatter:mngr_nm},
			{ index: 'SERVICE_MNGR4', 				name: 'SERVICE_MNGR4', 			width: 150, hidden:true},
			{ index: 'SERVICE_MNGR5', 				name: 'SERVICE_MNGR5', 			width: 150, hidden:true},
			{ index: 'ADMIN_TEAM',		 			name: 'ADMIN_TEAM', 			width: 150, hidden:true},
			{ index: 'SCHEDULE_ID', 				name: 'SCHEDULE_ID', 			width: 150, hidden:true},
			{ index: 'ENABLE', 						name: 'ENABLE', 				width: 150, hidden:true},
			{ index: 'LOCATION_ID', 				name: 'LOCATION_ID', 			width: 150, hidden:true},
			{ index: 'DATATYPE_ID', 				name: 'DATATYPE_ID', 			width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_DAYS', 		name: 'SCHEDULE_PAUSE_DAYS', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_FROM', 		name: 'SCHEDULE_PAUSE_FROM', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_TO', 			name: 'SCHEDULE_PAUSE_TO', 		width: 150, hidden:true},
			{ index: 'SCHEDULE_REPEAT_DAYS', 		name: 'SCHEDULE_REPEAT_DAYS', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_REPEAT_MONTHS', 		name: 'SCHEDULE_REPEAT_MONTHS', width: 150, hidden:true},
			{ index: 'SCHEDULE_STATUS_EN', 			name: 'SCHEDULE_STATUS', 		width: 150, align: "center", hidden:true},
			{ index: 'SCHEDULE_STATUS', 			name: 'SCHEDULE_STATUS', 		width: 150, align: "center", formatter:formatScheduleStatus,
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SCANNING', 					name: 'SCANNING', 				width: 150, align: "center", hidden:true, formatter:ScanningStatus},
			{ index: 'SCAN_TIME', 					name: 'SCAN_TIME', 				width: 150, align: "center"},
			{ index: 'PATH_CNT', 					name: 'PATH_CNT', 				width: 150, align: "center", hidden: true, formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sortable: true, sorttype: 'number'},
			{ index: 'TOTAL', 						name: 'TOTAL',  				width: 150, align: "center", hidden: true, formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sortable: true, sorttype: 'number'},
			{ index: 'CONFIRM', 					name: 'CONFIRM', 				width: 150, hidden:true },
			{ index: 'POLICY_ID', 					name: 'POLICY_ID', 				width: 150, hidden:true },
			{ index: 'POLICY_NM', 					name: 'POLICY_NM', 				width: 150, align: "center", formatter:policyNm,
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
			  	  }	
			},
			{ index: 'MEMO', 						name: 'MEMO', 					width: 150, hidden: true},
			{ index: 'SCHEDULE_ID2', 				name: 'SCHEDULE_ID2', 			width: 100, align: 'center', formatter:createView, exportcol : false}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 590,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data,iRow,ICol) {
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
		  		
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				var ap_no = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'AP_NO');
				var status = ".status-" + $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
				
				if(status == '.status-scheduled' || status == '.status-paused'  ){ // 대기일때는 취소만
					$("#cancelBtn").show();
					$("#stopBtn").hide();
				}else{
					$("#stopBtn").show();
					$("#cancelBtn").hide();
				}
				
				if(ap_no == 0){
					
					$(".status").css("display", "none"); 
					//$(".status").css("display", "block");
	
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
					
					$("#grid_status").html("");
					
					if(status != '.status-scanning'){
						
						$("#grid_status").css("padding-bottom", "0px");
						
						var grid_status = "";
						
						;
						
						if(status != '.status-paused'){
								
								grid_status = '<ul style="padding-bottom: 0px;"><li class="status status-scheduled status-scanning status-paused">';
								grid_status += '<button id="changeBtn" style="width: 100%;">스케줄 확인/변경</button></li>';
								grid_status += '<li class="status status-scheduled status-scanning status-paused">';
								grid_status += '<button id="confirmBtn" style="width: 100%;">검색 확정</button></li>';
								
								/* grid_status += '<li class="status status-scheduled status-scanning status-paused">';
								grid_status += '<button id="manageSchedule" style="width: 100%;">스케줄 관리</button></li></ul>'; */
								
							$("#grid_status").prepend(grid_status);
							
							$("#changeBtn").click(function(){
								scheduleChangePopup();
							});
							
							$("#confirmBtn").click(function(){
								ConfirmPopup();
							});
							
							// 스케줄관리 click
							$("#manageSchedule").click(function(){
								var row = $("#targetGrid").getGridParam( "selrow" );
								var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
								// 스케줄관리 pop 생성
								console.log(id);
								setManageSchedulePop(id);
							});
						}else{
							
							grid_status = '<ul style="padding-bottom: 0px;">';
							grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="resumeBtn" style="width: 100%;">검색 재개</button></li>';
							
							$("#grid_status").prepend(grid_status);
							
							$("#resumeBtn").click(function(){
								changeSchedule("resume");
							}); 
						}
						
					}else{
						$("#grid_status").css("padding-bottom", "0px");
						
						
						var grid_status = "";
							grid_status = '<ul style="padding-bottom: 0px;">';
							grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="pauseBtn" style="width: 100%;">일시 정지</button></li>';
							/* grid_status += '<li class="status status-scheduled status-scanning status-resume">';
							grid_status += '<button id="resumeBtn" style="width: 100%;">재개</button></li>'; */
						
						$("#grid_status").prepend(grid_status);
						
						$("#pauseBtn").click(function(){
							changeSchedule("pause");
						});
						
						
					}
					$("#taskWindow").show();
				}else {
					var status = ".status-" + $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
					$(".status").css("display", "none"); 
					//$(".status").css("display", "block");

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
					
					$("#grid_status").html("");
					
					if(status != '.status-scanning'){
						
						$("#grid_status").css("padding-bottom", "0px");
						
						var grid_status = "";
						
						if(status != '.status-paused'){
							
							grid_status = '<ul style="padding-bottom: 0px;"><li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="viewScheduleBtn" style="width: 100%;">스케줄 확인</button></li>';
							/* grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="confirmBtn" style="width: 100%;">검색 확정</button></li>'; */
							/* grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="manageSchedule" style="width: 100%;">스케줄 관리</button></li></ul>'; */
								
							$("#grid_status").prepend(grid_status);
							
							$("#viewScheduleBtn").click(function(){
								viewSchedulePopup();
							});
							
							$("#confirmBtn").click(function(){
								ConfirmPopup();
							});
						}else{
							grid_status = '<ul style="padding-bottom: 0px;">';
							grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="resumeBtn" style="width: 100%;">검색 재개</button></li>';
							
							$("#grid_status").prepend(grid_status);
							
							$("#resumeBtn").click(function(){
								changeSchedule("resumeBtn");
							}); 
						}
						// 스케줄관리 click
						$("#manageSchedule").click(function(){
							var row = $("#targetGrid").getGridParam( "selrow" );
							var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
							// 스케줄관리 pop 생성
							console.log(id);
							setManageSchedulePop(id);
						});
						
					}else{
						$("#grid_status").css("padding-bottom", "0px");
						
						var grid_status = "";
							grid_status = '<ul style="padding-bottom: 0px;">';
							grid_status += '<li class="status status-scheduled status-scanning status-paused">';
							grid_status += '<button id="pauseBtn" style="width: 100%;">일시 정지</button></li>';
						
						$("#grid_status").prepend(grid_status);
						
						$("#pauseBtn").click(function(){
							changeSchedule("pause");
						});
					}
					$("#taskWindow").show();
				}
			});
			var name = $("#topNGrid").find("[aria-describedby='topNGrid_NAME']");
				name.css("text-decoration", "underline");
			name.mouseover(function(e){
				$(this).css("text-decoration", "underline");
				$(this).css("font-weight", "bold");
				$(this).css("cursor", "pointer");
			});
			name.mouseleave(function(e){
				$(this).css("text-decoration", "underline");
				$(this).css("font-weight", "normal");
			});
			
			/* var policy_nm = $("#topNGrid").find("[aria-describedby='topNGrid_POLICY_NM']");
			for (var i = 0; i < data.length; i++) {
				var policy_title = data[i].POLICY_NM;
				
				if(policy_title != ""){
					policy_nm.css("text-decoration", "underline");
					policy_nm.mouseover(function(e){
						$(this).css("text-decoration", "underline");
						$(this).css("font-weight", "bold");
						$(this).css("cursor", "pointer");
					});
					policy_nm.mouseleave(function(e){
						$(this).css("text-decoration", "underline");
						$(this).css("font-weight", "normal");
					});
				}else {
					policy_nm.css("text-decoration", "none");
				}
			} */
			
			$(".scanning_href").on("click", function(e) {
				e.stopPropagation();
		  		
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				
				var ap_no = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'AP_NO');
				var target_id = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'TARGET_ID');
				var id = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_ID');
				var status = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
				
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
					    	
					    	if(resultMap.resultCode == 0) {
						    	$.each(resultMap.resultData, function(index, item){
						    		var detailsContent = item.status + "(" + item.percentage + " 'File path";
						    			detailsContent += item.currentlyFile + ")";
						    		
						    		$("#scanningDetailsName").css("display", "block");
						    		$("#scanningDetailsName").html(item.name);
						    		$("#scanningDetails").html(detailsContent);
						    	});
					    	}else {
					    		$("#scanningDetailsName").css("display", "none");
					    		$("#scanningDetails").html("스캔 준비 중 입니다. <br /> 잠시만 기다려 주시면 곧 스캔이 시작됩니다.");
					    	}
					        
					    },
					    error: function (request, status, error) {
							alert("ERROR");
					        console.log("ERROR : ", error);
					    }
					});			
				}
				
				$("#taskTargetid").val(target_id);
				$("#taskApno").val(ap_no);
				$("#taskScheduleid").val(id);
				
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
			
			$("#confirmProgress").click(function(){
				$("#progressDetails").hide();
			});
			
			$("#btnCancleProgressDetails").click(function(){
				$("#progressDetails").hide();
			});
	    },
	    gridComplete : function() {
	    },
	    onCellSelect: function(rowid,icol,cellcontent,e) {
            var ap_no = $(this).getCell(rowid, 'AP_NO');
            var target_id = $(this).getCell(rowid, 'TARGET_ID');
            var host = $(this).getCell(rowid, 'NAME');
            var policy_id = $(this).getCell(rowid, 'POLICY_ID');
            var policy_name = $(this).getCell(rowid, 'POLICY_NM');
            var enable = $(this).getCell(rowid, 'ENABLE');
            var id = $(this).getCell(rowid, 'SCHEDULE_ID');
            var status = $(this).getCell(rowid, 'SCHEDULE_STATUS');
            var group_name = $(this).getCell(rowid, 'GROUP_NAME');
            if(icol == 4) {
            	var form = document.createElement("form");
            	 form.setAttribute("charset", "UTF-8");
                 form.setAttribute("method", "POST");  //Post 방식
                 if(group_name == "OneDrive") {
	                 form.setAttribute("action", "/manage/pi_detection_list_onedrive_skt"); //요청 보낼 주소
                 }else {
	                 form.setAttribute("action", "/manage/pi_detection_list"); //요청 보낼 주소
                 }
                 
                 var hiddenField = document.createElement("input");

                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "targetid");
                 hiddenField.setAttribute("value", target_id);
                 form.appendChild(hiddenField);
                 
                 hiddenField = document.createElement("input");
                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "apno");
                 hiddenField.setAttribute("value", ap_no);
                 form.appendChild(hiddenField);
                 
                 hiddenField = document.createElement("input");
                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "host");
                 hiddenField.setAttribute("value", host);
                 form.appendChild(hiddenField);

                 document.body.appendChild(form);
                 form.submit();
            } else if(icol == 32) {
            	if(policy_id != null && policy_id != '' && enable == 1){
	            	$.ajax({
	            		type: "POST",
	            		url: "/search/getPolicy",
	            		async : false,
	            		data : {
	            			policyid : policy_id,
	            			scheduleUse : 1
	            		},
	            	    success: function (result) {
	            	    	/* var start_dtm = setStartdtm(result[0]);
	            			$('#search_start_time').html(start_dtm); */
	            		 	// 개인정보 유형 
	            		 	$("#dataTypePopup").show();
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
            }
	    }
	});
}

function fn_drawPCNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	
	$("#topNGrid").jqGrid({
		//data:dataArr,
		datatype: "local",
	   	mtype : "POST",
		colNames:['그룹명', 'TARGETID', 'APNO', '타겟상태', '호스트명', '서비스명', '담당자ID', '담당자', '소속','중간관리자ID', '중간관리자', '소속',
			'스케줄ID','로케이션ID','데이타타입ID', '스케줄정지일','스케줄 정지종료', '스케줄 정지시작','주기DAY','주기MONTH', '상태EN', '검색진행 상태', '검색시작시간', 
			'검출파일 수', '검출 수', '컨펌','정책ID', '개인정보 유형', '메모', ''],
		colModel: [
			{ index: 'GROUP_NAME', 			name: 'GROUP_NAME',			width: 150, align: "center",
			  cellattr: function(rowId, tv, rowObject, cm, rdata) {
					return 'style="background-color: #f9f9f9;"'	  
			  }
			},
			{ index: 'TARGET_ID', 			name: 'TARGET_ID',			width: 150, hidden:true},
			{ index: 'AP_NO', 				name: 'AP_NO', 				width: 150, hidden:true},
			{ index: 'TARGET_USE', 			name: 'TARGET_USE', 		width: 150, hidden:true},
			{ index: 'NAME', 				name: 'NAME', 				width: 150, align: "center",
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SERVICE_NM', 			name: 'SERVICE_NM', 		width: 150, align: "center", formatter: serviceNm, hidden: true},
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 150, hidden:true},
			{ index: 'USER_NAME', 			name: 'USER_NAME', 			width: 150, align: "center"},
			{ index: 'TEAM_NAME', 			name: 'TEAM_NAME', 			width: 150, hidden:true},
			{ index: 'SERVICE_USER_NO', 	name: 'SERVICE_USER_NO', 	width: 150, hidden:true},
			{ index: 'SERVICE_USER_NM', 	name: 'SERVICE_USER_NM', 	width: 150, align: "center",
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'SERVICE_USER_TEAM', 	name: 'SERVICE_USER_TEAM', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_ID', 		name: 'SCHEDULE_ID', 		width: 150, hidden:true},
			{ index: 'LOCATION_ID', 		name: 'LOCATION_ID', 		width: 150, hidden:true},
			{ index: 'DATATYPE_ID', 		name: 'DATATYPE_ID', 		width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_DAYS', 	name: 'SCHEDULE_PAUSE_DAYS', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_FROM', 	name: 'SCHEDULE_PAUSE_FROM', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_PAUSE_TO', 		name: 'SCHEDULE_PAUSE_TO', 		width: 150, hidden:true},
			{ index: 'SCHEDULE_REPEAT_DAYS', 	name: 'SCHEDULE_REPEAT_DAYS', 	width: 150, hidden:true},
			{ index: 'SCHEDULE_REPEAT_MONTHS', 	name: 'SCHEDULE_REPEAT_MONTHS', width: 150, hidden:true},
			{ index: 'SCHEDULE_STATUS_EN', 	name: 'SCHEDULE_STATUS', 	width: 150, align: "center", hidden:true},
			{ index: 'SCHEDULE_STATUS', 	name: 'SCHEDULE_STATUS', 	width: 150, align: "center", formatter:formatScheduleStatus},
			{ index: 'SCAN_TIME', 			name: 'SCAN_TIME', 			width: 150, align: "center",
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			},
			{ index: 'PATH_CNT', 			name: 'PATH_CNT', 			width: 150, align: "center", formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sortable: true, sorttype: 'number', hidden: true},
			{ index: 'TOTAL', 				name: 'TOTAL',  			width: 150, align: "center", formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sortable: true, sorttype: 'number', hidden: true},
			{ index: 'CONFIRM', 			name: 'CONFIRM', 			width: 150, hidden:true },
			{ index: 'POLICY_ID', 			name: 'POLICY_ID', 			width: 150, hidden:true },
			{ index: 'POLICY_NM', 			name: 'POLICY_NM', 			width: 150, align: "center",formatter:policyNm},
			{ index: 'MEMO', 				name: 'MEMO', 				width: 150, hidden: true},
			{ index: 'SCHEDULE_ID2', 		name: 'SCHEDULE_ID2', 		width: 100, align: 'center', formatter:createView, exportcol : false,
				  cellattr: function(rowId, tv, rowObject, cm, rdata) {
						return 'style="background-color: #f9f9f9;"'	  
				  }
			}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 590,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data,iRow,ICol) {
			//console.log(data);
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
		  		
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				var status = ".status-" + $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
				$(".status").css("display", "none"); 
				//$(".status").css("display", "block");

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
				
				$("#grid_status").html("");
				
				if(status != '.status-scanning'){
					
					$("#grid_status").css("padding-bottom", "0px");
					
					var grid_status = "";
					
					if(status != '.status-paused'){
						
						grid_status = '<ul style="padding-bottom: 0px;"><li class="status status-scheduled status-scanning status-paused">';
						grid_status += '<button id="changeBtn" style="width: 100%;">스케줄 확인</button></li>';
						/* grid_status += '<li class="status status-scheduled status-scanning status-paused">';
						grid_status += '<button id="confirmBtn" style="width: 100%;">검색 확정</button></li>'; */
						/* grid_status += '<li class="status status-scheduled status-scanning status-paused">';
						grid_status += '<button id="manageSchedule" style="width: 100%;">스케줄 관리</button></li></ul>'; */
							
						$("#grid_status").prepend(grid_status);
						
						$("#changeBtn").click(function(){
							scheduleChangePopup();
						});
						
						$("#confirmBtn").click(function(){
							ConfirmPopup();
						});
					}else{
						grid_status = '<ul style="padding-bottom: 0px;">';
						grid_status += '<li class="status status-scheduled status-scanning status-paused">';
						grid_status += '<button id="restartBtn" style="width: 100%;">검색 재시작</button></li>';
						
						$("#grid_status").prepend(grid_status);
						
						$("#restartBtn").click(function(){
							changeSchedule("resume");
						});
					}
					// 스케줄관리 click
					$("#manageSchedule").click(function(){
						var row = $("#targetGrid").getGridParam( "selrow" );
						var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
						// 스케줄관리 pop 생성
						console.log(id);
						setManageSchedulePop(id);
					});
					
				}else{
					$("#grid_status").css("padding-bottom", "0px");
					
					var grid_status = "";
						grid_status = '<ul style="padding-bottom: 0px;">';
						grid_status += '<li class="status status-scheduled status-scanning status-paused">';
						grid_status += '<button id="pauseBtn" style="width: 100%;">일시 정지</button></li>';
					
					$("#grid_status").prepend(grid_status);
					
					$("#pauseBtn").click(function(){
						changeSchedule("pause");
					});
				}
				$("#taskWindow").show();
			});
			var name = $("#topNGrid").find("[aria-describedby='topNGrid_NAME']");
				name.css("text-decoration", "underline");
			name.mouseover(function(e){
				$(this).css("text-decoration", "underline");
				$(this).css("font-weight", "bold");
				$(this).css("cursor", "pointer");
			});
			name.mouseleave(function(e){
				$(this).css("text-decoration", "underline");
				$(this).css("font-weight", "normal");
			});
			/* var policy_nm = $("#topNGrid").find("[aria-describedby='topNGrid_POLICY_NM']");
			for (var i = 0; i < data.length; i++) {
				var policy_title = data[i].POLICY_NM;
				
				if(policy_title != ""){
					policy_nm.css("text-decoration", "underline");
					policy_nm.mouseover(function(e){
						$(this).css("text-decoration", "underline");
						$(this).css("font-weight", "bold");
						$(this).css("cursor", "pointer");
					});
					policy_nm.mouseleave(function(e){
						$(this).css("text-decoration", "underline");
						$(this).css("font-weight", "normal");
					});
				}else {
					policy_nm.css("text-decoration", "none");
				}
			} */
			$(".scanning_href").on("click", function(e) {
				e.stopPropagation();
		  		
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				
				var ap_no = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'AP_NO');
				var target_id = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'TARGET_ID');
				var id = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_ID');
				var status = $("#topNGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STATUS');
				
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
				
				$("#taskTargetid").val(target_id);
				$("#taskApno").val(ap_no);
				$("#taskScheduleid").val(id);
				
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
			
			$("#confirmProgress").click(function(){
				$("#progressDetails").hide();
			});
			
			$("#btnCancleProgressDetails").click(function(){
				$("#progressDetails").hide();
			});
	    },
	    gridComplete : function() {
	    },
	    onCellSelect: function(rowid,icol,cellcontent,e) {
            var ap_no = $(this).getCell(rowid, 'AP_NO');
            var target_id = $(this).getCell(rowid, 'TARGET_ID');
            var host = $(this).getCell(rowid, 'NAME');
            var policy_id = $(this).getCell(rowid, 'POLICY_ID');
            
            if(icol == 4) {
            	var form = document.createElement("form");
            	 form.setAttribute("charset", "UTF-8");
                 form.setAttribute("method", "POST");  //Post 방식
                 form.setAttribute("action", "/manage/pi_detection_list"); //요청 보낼 주소
                 
                 var hiddenField = document.createElement("input");

                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "targetid");
                 hiddenField.setAttribute("value", target_id);
                 form.appendChild(hiddenField);
                 
                 hiddenField = document.createElement("input");
                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "apno");
                 hiddenField.setAttribute("value", ap_no);
                 form.appendChild(hiddenField);
                 
                 hiddenField = document.createElement("input");
                 hiddenField.setAttribute("type", "hidden");
                 hiddenField.setAttribute("name", "host");
                 hiddenField.setAttribute("value", host);
                 form.appendChild(hiddenField);

                 document.body.appendChild(form);
                 form.submit();
            } else if(icol == 27) {
            	if(policy_id != null && policy_id != ''){
	            	$("#dataTypePopup").show();
	            	$.ajax({
	            		type: "POST",
	            		url: "/search/getPolicy",
	            		async : false,
	            		data : {
	            			policyid : policy_id,
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
            	}
            }
	    }
	});
}

$("#btnDataTypePopupClose").click(function(e){
	$("#dataTypePopup").hide();
});

$("#btnCancleDataTypePopup").click(function(e){
	$("#dataTypePopup").hide();
});

/* 스케줄 변경 버튼 클릭 이벤트 시작 */
function scheduleChangePopup (){
	var row = $("#topNGrid").getGridParam( "selrow" );
	
	var start_dtm = setStartdtm($("#topNGrid").getRowData(row));
	$('#start_time').html(start_dtm);
	
	var stop_dtm = setStopdtm($("#topNGrid").getRowData(row));
	$('#stop_time').html(stop_dtm);
	$("#changeSchedulePopup").show();
	
	$("#start_ymd").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
}

/* 스케줄 확인 버튼 클릭 이벤트 시작 */
function viewSchedulePopup (){
	var row = $("#topNGrid").getGridParam( "selrow" );
	
	var start_dtm = setStartdtm($("#topNGrid").getRowData(row));
	$('#view_start_time').html(start_dtm);
	
	var stop_dtm = setStopdtm($("#topNGrid").getRowData(row));
	$('#view_stop_time').html(stop_dtm);
	$("#viewSchedulePopup").show();
	
	/* $("#start_ymd").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	}); */
}

/* 확정 버튼 클릭 이벤트 */
function ConfirmPopup(){
	var row = $("#topNGrid").getGridParam( "selrow" );
	var confirm = $("#topNGrid").getCell(row, 'CONFIRM');
	
	if(confirm == 1){
		alert("이미 확정된 스케줄입니다.");
		return;
	}
	
	$("#selectConfirmPopup").show();
}


/* function schedulePausePopup(){
	var row = $("#topNGrid").getGridParam( "selrow" );

	changeSchedule("pause");
}


function scheduleRestartPopup(){
	var row = $("#topNGrid").getGridParam( "selrow" );
	changeSchedule("restart");
}

 */
function setStartdtm(rowData){
	/* var today = new Date();
	today.setMinutes(today.getMinutes() + 7);
	var hours = today.getHours();
	var minutes = today.getMinutes();
	const year = today.getFullYear(); 
	const month = today.getMonth() + 1; 
	const date = today.getDate(); */
	console.log(rowData.AP_NO);
	if(rowData.AP_NO == 0){
		var start_dtm = rowData.SCAN_TIME;
		var start_ymd = '';
		var start_hour = '';
		vainutes = '';
		if(start_dtm != null && start_dtm != ''){
			start_ymd = start_dtm.substr(0,10);
			console.log(start_ymd);
			start_hour = start_dtm.substr(11,2);
			start_minutes = start_dtm.substr(14,2);
		}
		
		var html = "";
		html += "<input type='date' id='start_ymd' readonly='readonly' style='text-align: center; height: 27px;' value='"+
		start_ymd+"'>&nbsp;";

		html += "<select name=\"start_hour\" id=\"start_hour\" >"
		for(var i=0; i<24; i++){
			var hour = (parseInt(i));
			var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
			html += "<option value=\""+hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
		}
		html += "</select> : "

		html += "<select name=\"start_minutes\" id=\"start_minutes\" >"
		for(var i=0; i<60; i++){
			var minute = parseInt(i)
			var str_minutes = (parseInt(start_minutes) < 10) ? '0'+minute : minute
			html += "<option value=\""+minute+"\" "+(minute == parseInt(start_minutes)? 'selected': '')+">"+(minute < 10 ? "0" + minute : minute)+"</option>"
		}
		html += "</select>"
		
		$("#start_ymd").datepicker({
			changeYear : true,
			changeMonth : true,
			dateFormat: 'yy-mm-dd'
		});
		
	}else {
		var start_dtm = rowData.SCAN_TIME;
		var start_ymd = '';
		var start_hour = '';
		vainutes = '';
		if(start_dtm != null && start_dtm != ''){
			start_ymd = start_dtm.substr(0,10);
			console.log(start_ymd);
			start_hour = start_dtm.substr(11,2);
			start_minutes = start_dtm.substr(14,2);
		}
		var html = "";
		html += "<input type='text' id='start_ymd' readonly='readonly' style='text-align: center; width: 100px; height: 27px; border-style: none' value='"+
		start_ymd+"'>&nbsp;";
		
		html += "<input type='text' id='start_hour' readonly='readonly' style='text-align: center; width: 45px; height: 27px; border-style: none' value='"+
		start_hour + " : " + start_minutes + "'>&nbsp;";
		
		/* html += "<select name=\"start_hour\" id=\"start_hour\" >"
		for(var i=0; i<24; i++){
			var hour = (parseInt(i));
			var str_hour = (parseInt(hour) < 10) ? '0'+hour : hour
			html += "<option value=\""+hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
		}
		html += "</select> : "

		html += "<select name=\"start_minutes\" id=\"start_minutes\" >"
		for(var i=0; i<60; i++){
			var minute = parseInt(i)
			var str_minutes = (parseInt(start_minutes) < 10) ? '0'+minute : minute
			html += "<option value=\""+minute+"\" "+(minute == parseInt(start_minutes)? 'selected': '')+">"+(minute < 10 ? "0" + minute : minute)+"</option>"
		}
		html += "</select>" */
	}
	
	return html;
}


function setStopdtm(rowData){
	var pause_from = rowData.SCHEDULE_PAUSE_FROM;
	var pause_from_minu = 0;
	var pause_to = rowData.SCHEDULE_PAUSE_TO;
	var pause_to_minu = 0;
	
	console.log(pause_from + ", " + pause_from_minu)
	var start_hour = '';
	var start_minutes = '';
	var stop_hour = '';
	var stop_minutes = '';
	var chk = 0;
	var sel_chk = 0;
	start_hour = 9;
	stop_hour = 18;
	if(pause_from != null && pause_from != ''){
		start_hour = pause_from / (60 * 60);
		pause_from_minu = pause_from % (60 * 60);
		start_minutes = pause_from_minu / 60;
		stop_hour = pause_to / (60 * 60);
		pause_to_minu = pause_to % (60 * 60);
		stop_minutes = pause_to_minu / 60;
		sel_chk = 1;
	}
	
	if(rowData != null && rowData != ''){
		chk = 1;
	}

	var html = "";
	html += "<input type='checkbox' "+ (pause_from != '' && pause_from != null ? 'checked' : '')  +  " id='stop_chk' />&nbsp;&nbsp;시작 : &nbsp;";
	//html += "<input type='checkbox' id='stop_chk' />&nbsp;&nbsp;시작 : &nbsp;";

	//html += "<select name=\"start_hour\" id=\"from_time_hour\" disabled='disabled'>"
	html += "<select name=\"start_hour\" id=\"from_time_hour\">"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		html += "<option value=\""+hour+"\" "+(hour == parseInt(start_hour)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"from_time_minutes\">"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		html += "<option value=\""+minutes+"\" "+(minutes == parseInt(start_minutes)? 'selected': '')+">"+(minutes < 10 ? "0" + minutes : minutes)+"</option>"
	}
	html += "</select>"
	html += "&nbsp;&nbsp;~&nbsp;&nbsp;정지 : &nbsp;";

	html += "<select name=\"start_hour\" id=\"to_time_hour\">"
	for(var i=0; i<24; i++){
		var hour = (parseInt(i));
		html += "<option value=\""+hour+"\" "+(hour == parseInt(stop_hour)? 'selected': '')+">"+(hour < 10 ? "0" + hour : hour)+"</option>"
	}
	html += "</select> : "

	html += "<select name=\"start_minutes\" id=\"to_time_minutes\">"
	for(var i=0; i<60; i++){
		var minutes = parseInt(i)
		html += "<option value=\""+minutes+"\" "+(minutes == parseInt(stop_minutes)? 'selected': '')+">"+(minutes < 10 ? "0" + minutes : minutes)+"</option>"
	}
	html += "</select>"


	
	return html;
}


$('#sch_search').on('click', function(){
	fnc_search();
});

function fnc_search(){
	var postData = {
		sch_group: $('#sch_group').val(),
		sch_host: $('#sch_host').val(),
		sch_svcName: $('#sch_svcName').val(),
		sch_svcManager: $('#sch_svcManager').val()
	}
	$("#topNGrid").setGridParam({url:"/search/getStatusList", postData : postData, datatype:"json" }).trigger("reloadGrid");
};

function serviceNm(cellvalue, options, rowObject) {
	
	var serviceNm = rowObject.SERVICE_NM
	if(serviceNm != "" && serviceNm != null){
		return serviceNm;
	}else{
		return "-";
	}
};

function mngr_nm(cellvalue, options, rowObject) {

	var mngr3 = rowObject.SERVICE_MNGR3;
	var mngr4 = rowObject.SERVICE_MNGR4;
	var mngr5 = rowObject.SERVICE_MNGR5;
	
	var mngr_con = 0;
	
	var result = "";
	
	if(mngr3 != null && mngr3 != "") ++mngr_con;
	if(mngr4 != null && mngr4 != "") ++mngr_con;
	if(mngr5 != null && mngr5 != "") ++mngr_con;
	
	
	if(result == "" && mngr3 != null && mngr3 != "") result = mngr3;
	if(result == "" && mngr4 != null && mngr4 != "") result = mngr4;
	if(result == "" && mngr5 != null && mngr5 != "") result = mngr5;
	
	if(mngr_con > 1){
		result += " 외 "+ (mngr_con-1) +" 명";
	}
	
	return result;
}

var formatScheduleStatus = function(cellvalue, options, rowObject) {
	var status = cellvalue;
	if(cellvalue == 'cancelled'){
		status = '정지';
/* 		status = '취소'; */
	} else if(cellvalue == 'scheduled'){
		status = '대기';
	}else if(cellvalue == 'failed'){
		status = '실패';
	}else if(cellvalue == 'scanning'){
		status = '<label class=\"scanning_href\" style=\"text-decoration: underline; cursor:pointer;\">진행중</label>';
	}else if(cellvalue == 'paused'){
		status = '일시정지';
	}else if(cellvalue == 'completed'){
		status = '완료';
	}else if(cellvalue == 'stopped'){
		status = '정지';
	}else if(cellvalue == 'stalled'){
		status = '멈춤';
	}else if(cellvalue == 'paused'){
		status = '정지';
	}else if(cellvalue == 'deactivated'){
		status = '비활성';
	}else if(cellvalue == 'queued'){
		status = '대기';
	}else if(cellvalue == 'interrupted'){
		status = '완료';
	}else if(cellvalue == null){
		status = '';
	}
	
	return status; 
};

var createView = function(cellvalue, options, rowObject) {
	
	var schedule_status = rowObject.SCHEDULE_STATUS;
	
	if(schedule_status != "scheduled" && schedule_status != "scanning" && schedule_status != "paused"){
		return ""; 
	}else{
		return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>"; 
	}
	//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
};

var policyNm = function(cellvalue, options, rowObject) {
	
	var policy_nm = rowObject.POLICY_NM;
	if(policy_nm != "" && policy_nm != null){
		return "<span id='policyNm'>"+policy_nm+"</span>";	
	}else {
		return "-";
	}
	
};

var ScanningStatus = function(cellvalue, options, rowObject) {
	
	var status = rowObject.SCHEDULE_STATUS;
	if(status == 'scanning'){
		return "<img src=\"${pageContext.request.contextPath}/resources/assets/images/scanning.gif\" style=\"margin-top: 4px; cursor:pointer;\" class=\"statusChoiseBtn\" width=\"15px;\">"+"</td>";
	}else {
		return "-";
	}
	
};

/* 
function ScanningStatus(){
	 var row = $("#topNGrid").getGridParam( "selrow" );
	 var status = $("#topNGrid").getCell(row, 'SCHEDULE_STATUS');
	 console.log(row);
	 console.log(status);
} 
*/


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

	var row = $("#topNGrid").getGridParam( "selrow" );
	var id = $("#topNGrid").getCell(row, 'SCHEDULE_ID');
	var apno = $("#topNGrid").getCell(row, 'AP_NO');
	var targetid = $("#topNGrid").getCell(row, 'TARGET_ID');

	/* var id = $("#taskScheduleid").val();
	var apno = $("#taskApno").val();
	var targetid = $("#taskTargetid").val();
	var index = $("#taskIndex").val(); */
	
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
	     	case "resume" :
	     		changedTask = "scheduled";
	     		break;
	     	case "stop" :
	     		changedTask = "stopped";
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
	     	
	     	/* 초기화  */
	     	$("#taskScheduleid").val("");
	    	$("#taskApno").val("");
	    	$("#taskTargetid").val("");
	    	$("#taskIndex").val("");	     	
	     	//$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);

	     	alert("스캔 스케줄의 상태가 변경되었습니다.");
	     	$("#taskWindow").hide();
	     	setTimeout(function(){
				$.ajax({
					type: "POST",
					url: "/search/updateReconSchedule",
					async : false,
					data : {
						scheduleid : id,
						ap_no: apno
					},
				    success: function (resultMap) {
				        $("#topNGrid").setGridParam({url:"/search/getStatusList", postData : postData, datatype:"json" }).trigger("reloadGrid");
				    },
				    error: function (request, status, error) {
						alert("Server Error : " + error);
				        console.log("ERROR : ", error);
				    }
				});
				
			}, 2000);
	    },
	    error: function (request, status, error) {
			alert("ERROR");
	        console.log("ERROR : ", error);
	    }
	});
	
}
 
 function setManageSchedulePop(id){
		$("#taskWindow").hide();
		var pop_html = '';

		var colName = ['start', 'end', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
		
		pop_html += '	<div class="popup_top">';
		pop_html += '		<h1>스케줄 관리</h1>';
		pop_html += '	</div>';
		pop_html += '	<input type="hidden" id="pop_manageSchedule_schedule_id" value="'+id+'">';
		pop_html += '	<table id="popup_table_manageSchedule" width="100%" border="1">';
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
		pop_html += '		<p style="text-align:right;margin-right: 2%;">';
		pop_html += '			종료일시 입력 : <input type="date" id="stopDate" value="" style="text-align: center;" readonly="readonly">';
		pop_html += '			&nbsp;<input type="text" id="stop_hour" data-type="number" maxlength="2" style="text-align:right; width:50px;"/>&nbsp;시&nbsp;&nbsp;<input type="text" id="stop_minute" data-type="number" maxlength="2" style="text-align:right; width:50px; "/>&nbsp;분';
		pop_html += '		</p>';
		pop_html += '		<div class="btn_area">';
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
		$("#popup_save_manageSchedule").click(function(){	// 저장
			//alert('저장이지롱');
			if(confirm("현재 내용을 저장하시겠습니까?")){
				saveSchedule();
			}
		});
		
		$("#popup_insert_schedule").click(function(){	// 스케줄 수동입력 
			$('#popup_lbl_insertSchedule').show();
		});
		
		$('input:text[data-type="number"]').on('keyup', function() {
			$(this).val($(this).val().replace(/[^0-9]/g,""))
			if($(this).val() == ''){
				$(this).val('00');
			}
		});

		
	}
 

 function deleteSchedule(){
 	$.ajax({
 		type: "POST",
 		url: "/scan/deleteSchedule",
 		async : false,
 		data : {
 			schedule_id: $('#pop_manageSchedule_schedule_id').val()
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
 

 function setManageSchedulePop(id){
 	$("#taskWindow").hide();
 	var pop_html = '';

 	var colName = ['start', 'end', 'mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
 	
 	pop_html += '	<div class="popup_top">';
 	pop_html += '		<h1>스케줄 관리</h1>';
 	pop_html += '	</div>';
 	pop_html += '	<input type="hidden" id="pop_manageSchedule_schedule_id" value="'+id+'">';
 	pop_html += '	<table id="popup_table_manageSchedule" width="100%" border="1">';
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
 	pop_html += '		<p style="text-align:right;margin-right: 2%;">';
 	pop_html += '			종료일시 입력 : <input type="date" id="stopDate" value="" style="text-align: center;" readonly="readonly">';
 	pop_html += '			&nbsp;<input type="text" id="stop_hour" data-type="number" maxlength="2" style="text-align:right; width:50px;"/>&nbsp;시&nbsp;&nbsp;<input type="text" id="stop_minute" data-type="number" maxlength="2" style="text-align:right; width:50px; "/>&nbsp;분';
 	pop_html += '		</p>';
 	pop_html += '		<div class="btn_area">';
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
 			schedule_id: $('#pop_manageSchedule_schedule_id').val()
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