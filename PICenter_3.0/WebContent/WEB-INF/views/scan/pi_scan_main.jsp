<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

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
				<h3>스캔 스케줄 검색</h3>
				<!-- content -->
				<div class="content magin_t25">
					<div class="location_area">
						<p class="location">스캔관리 > 스캔 스케줄</p>
					</div>
					<div class="left_area2 width_16 minW">
							<div class="scan_left">
								<div class="sch_left">
									<input type="text" id="searchHost" value="" class="edt_sch">
									<button id="btnSearchScan" class="btn_sch">검색</button>
								</div>
								<ul class="task">
									<li><input type="checkbox" name="chk_schedule" id="chk_completed" value="completed"> <label for="chk_completed">완료된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_deactivated"  value="deactivated"> <label for="chk_deactivated">비활성화된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_cancelled"  value="cancelled"> <label for="chk_cancelled">취소된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_stopped"  value="stopped"> <label for="chk_stopped">정지된 작업</label></li>
									<li><input type="checkbox" name="chk_schedule" id="chk_failed"  value="failed"> <label for="chk_failed">실패한 작업</label></li>
								</ul>
								<ul class="calendar">
									<li>
										<p>From</p>
										<input type="date" id="fromDate" value="${befDate}" style="text-align: center;" readonly="readonly">
									</li>
									<li>
										<p>To</p>
										<input type="date" id="toDate" value="${curDate}" style="text-align: center;" readonly="readonly">
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>


					<div class="grid_top" style="margin-left: 17vw;">
						<h3 style="padding: 0;">스케줄 리스트</h3>
						<div class="list_sch" style="top: 0;">
							<div class="sch_area">
								<button type="button" class="btn_down" onclick="javascript:executeChecked('start')">선택 시작</button>
								<button type="button" class="btn_down" onclick="javascript:executeChecked('pause')">선택 정지</button>
								<button type="button" id="btnDownloadExel" class="btn_down">다운로드</button>
								<button type="button" id="btnScanRegist" class="btn_down">신규스캔등록</button>
							</div>
						</div>
						<div class="left_box2" style="height: auto; min-height: 695px; overflow: hidden; width:59vw;">
    						<table id="targetGrid"></table>
    						<div id="targetGridPager"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #222222; box-shadow: 2px 2px 5px #ddd; display:none">
	<ul>
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed">
			<button id="viewSchedule" >보기</button></li>
		<li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
			<button id="deactivateSchedule">비활성화</button></li>
			<!-- 
		<li class="status status-scheduled status-scanning">
			<button id="modifySchedule" >수정</button></li>
			 -->
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped">
			<button id="skipSchedule">스킵</button></li>
		<li class="status status-scanning">
			<button id="pauseSchedule">일시정지</button></li>
		<li class="status status-completed status-paused status-stopped status-failed">
			<button id="restartSchedule">재시작</button></li>
		<li class="status status-scanning">
			<button id="stopSchedule">정지</button></li>
		<li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated">
			<button id="cancelSchedule">취소</button></li>
		<li  class="status status-deactivated">
			<button id="reactivateSchedule">활성화</button></li>
		<li  class="status status-completed status-scheduled status-scanning status-paused status-stopped status-failed status-deactivated">
			<button id="manageSchedule">스케줄 관리</button></li>
								
	</ul>
</div>
	
<div id="viewWindow" class="ui-widget-content" style="position:absolute; left: 700px; top: 300px; touch-action: none; 
		border: 1px solid #1F3546; max-width: 900px; z-index: 999; display:none">
	<div class="popup_top" style="cursor: grab;">
		<h1>스케줄 세부사항</h1>
	</div>
	<div class="popup_content">
		<div class="content-box">
			<h2>세부사항</h2>
			<table class="popup_tbl">
				<colgroup>
					<col width="30%">
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
					<col width="30%">
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
			<button type="button" id="viewWindowClose" style="background: #1898D2;">확인</button>
		</div>
	</div>
</div>
	
<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
	<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
	</div>
</div>	

<div id="popup_lbl_insertSchedule" class="popup_layer" style="display:none;">
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
</div>	
	
	
<div id="viewDetails" class="ui-widget-content" style="position:absolute; left: 700px; top: 300px; touch-action: none; 
		border: 1px solid #1F3546; max-width: 900px; z-index: 999; display:none">
	<div class="popup_top" style="cursor: grab;">
		<h1>스케줄 현재상황</h1>
	</div>
	<div class="popup_content">
		<div class="content-box">
			<table class="popup_tbl">
				<colgroup>
					<col width="30%">
					<col width="*">
				</colgroup>
				<tbody>
					<tr>
						<th>스캔명</th>
						<td id="details_label"></td>
					</tr>
					<tr>
						<th>개인정보 유형</th>
						<td id="details_datatype"></td>
					</tr>
				</tbody>
			</table>
			<table class="popup_tbl">
				<colgroup>
					<col width="20%">
					<col width="10%">
					<col width="20%">
					<col width="50%">
				</colgroup>
				<tbody id="details_detail">
				</tbody>
			</table>
		</div>
	</div>
	<div class="popup_btn">
		<div class="btn_area" style="border: 1px solid #efefef;">
			<button type="button" id="vieDetailsClose" style="background: #1898D2;">확인</button>
		</div>
	</div>
</div>
	
<%@ include file="../../include/footer.jsp"%>
 
<script type="text/javascript"> 

var oGrid = $("#targetGrid");

$(document).ready(function () {

	var timer = setInterval(setScanStatus, 10000);
	$(document).click(function(e){
		$("#taskWindow").hide();
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
	
	
	$("#vieDetailsClose").click(function(){
		$("#viewDetails").hide();
	})

	var ifConnect = function(cellvalue, options, rowObject) {
		if(cellvalue == null || cellvalue == ''){
			cellvalue = '<target deleted>'
		}
		return cellvalue.indexOf("<") >= 0 ? '< ' + cellvalue.replace("<","").replace(">","") + ' >' : cellvalue;
	};
	
	var createView = function(cellvalue, options, rowObject) {
		//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
		return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>"; 
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
	var gridHeight = 602;

	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['','서버 이름','스캔명','개인정보 유형','스캔 상태','STATUS','스캔 시간','작업','','','','AP_NO'],
		colModel: [      
			{ index: 'CHKBOX', 		name: 'CHKBOX',		width: 80,  align: 'center', editable: true, edittype: 'checkbox', 
				editoptions: { value: '1:0' }, formatoptions: { disabled: true }, formatter: createCheckbox, stype: 'select',
				searchoptions: { sopt: ['eq'], value: ':전체;1:선택;0:미선택' }
			},
			{ index: 'SCHEDULE_TARGET_NAME', 		name: 'SCHEDULE_TARGET_NAME', 		width: 250, align: 'left', formatter:ifConnect},
			{ index: 'SCHEDULE_LABEL', 				name: 'SCHEDULE_LABEL',				width: 400, align: 'left'},
			{ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL',				width: 150, align: 'center'},
			/* { index: 'SCHEDULE_STATUS',				name: 'SCHEDULE_STATUS', 			width: 80, align: 'center', formatter:'select',
			editoptions:{value:{'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'}}}, */
			{ index: 'SCHEDULE_STATUS',				name: 'SCHEDULE_STATUS', 			width: 80, align: 'center'},
			{ index: 'SCHEDULE_STAT',				name: 'SCHEDULE_STAT', 			width: 80, align: 'center', hidden: true },
			{ index: 'SCHEDULE_NEXT_SCAN_DATE_STATUS',		name: 'SCHEDULE_NEXT_SCAN_DATE_STATUS', 	width: 160, align: 'center'},
			{ index: 'SCHEDULE_ID2', 				name: 'SCHEDULE_ID2', 				width: 100, align: 'center', formatter:createView, exportcol : false},
			{ index: 'SCHEDULE_NEXT_SCAN_DATE',		name: 'SCHEDULE_NEXT_SCAN_DATE', 	width: 160, align: 'center', hidden: true},
			{ index: 'SCHEDULE_DATATYPE_PROFILES',	name: 'SCHEDULE_DATATYPE_PROFILES',	width: 200, align: 'center', hidden: true},
			{ index: 'SCHEDULE_ID', 				name: 'SCHEDULE_ID', 				width: 100, align: 'center', hidden: true},
			{ index: 'AP_NO', 						name: 'AP_NO',		 				width: 100, align: 'center', hidden: true}
		],
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:15,
	   	rowList:[15,30,50],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
	  	},
	  	ondblClickRow: function(nRowid, icol, cellcontent, e){
	  		
	  		var id = $("#targetGrid").getCell(icol, 'SCHEDULE_ID');
	  		var status = $("#targetGrid").getCell(icol, 'SCHEDULE_STAT');
	  		var ap_no = $("#targetGrid").getCell(icol, 'AP_NO');
	  		var postData = {
	  			id : id,
	  			ap_no : ap_no
	  		};
	  		
	  		if(status == 'scheduled' || status == 'paused' || status == 'scanning'){
		  		$.ajax({
					type: "POST",
					url: "/scan/getDetails",
					async : false,
					data : postData,
				    success: function (result) {
				    	$("#details_label").html($("#targetGrid").getCell(icol, 'SCHEDULE_LABEL'));
				    	$("#details_datatype").html($("#targetGrid").getCell(icol, 'DATATYPE_LABEL'));
				    	
				    	var details = "";
				    	details += "<tr>";
				    	details += "	<th>서버이름</th>";
				    	details += "	<th>상태</th>";
				    	details += "	<th>완료율</th>";
				    	details += "	<th>현재 검색 파일</th>";
				    	details += "</tr>";
				    	$.each(result.resultData, function(index, item) {
				    		details += "<tr>";
					    	details += "	<td style=\"text-align: center;\">"+item.name+"</td>";
					    	details += "	<td style=\"text-align: center;\">"+item.status+"</td>";
					    	details += "	<td style=\"text-align: center;\">"+item.percentage+"</td>";
					    	details += "	<td>"+item.currentlyFile+"</td>";
					    	details += "</tr>";
				    	});
				    	$("#details_detail").html(details);
				    	$("#viewDetails").show();
				    },
				    error: function (request, status, error) {
				    	alert("Recon Server에 접속할 수 없습니다.");
				        console.log("ERROR : ", error);
				    }
		  		});
	  		}
	  		
	  	},
		loadComplete: function(data) {
			
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#targetGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				var status = ".status-" + $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STAT');
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
			setScanStatus();
	    },
	    gridComplete : function() {
	    }
	});

	// 초기 조회
	var searchType = ['scheduled'];
	var postData = {searchType : JSON.stringify(searchType)};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/scan/pi_scan_schedule", postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	// 버튼 Action 설정
	$("#btnSearchScan").click(function() {

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
    });

	$("#searchHost").keyup(function(e){
		
		if (e.keyCode == 13) {
			$("#btnSearchScan").click();
		}
	});
	
	$("#chk_completed, #chk_deactivated, #chk_cancelled, #chk_stopped, #chk_failed").change(function() {
		$("#btnSearchScan").click();
	});
	
	$("#viewSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');

		var postData = {id : id};
		$.ajax({
			type: "POST",
			url: "/scan/viewSchedule",
			async : false,
			data : postData,
		    success: function (resultMap) {

		        if (resultMap.resultCode != 0) {
			        alert("FAIL : " + resultMap.resultMessage);
		        	return;
			    }
			    /* Scan 상세 내역 찍기 */ 
			    var data = resultMap.resultData;

			    $("#scanLabel").html(resultMap.resultData.label);

				/*
			    CPU low	낮음
			    CPU - 기타
			    */
			    var useCPU = "";
			    if (resultMap.resultData.cpu == "low") useCPU = "낮음";
			    else useCPU = "보통";
			    $("#scanCPU").html(useCPU);

			    $("#scanNextScan").html(convertUnixTime2Date(resultMap.resultData.next_scan));
			    //$("#scanNextScan").html(resultMap.resultData.next_scanDate);
				/*
			    <repeat_days> 1	매일
			    <repeat_days> 7	일주일 마다
			    <repeat_days> 14	2주일 마다
			    <repeat_months> 1	한달마다
			    <repeat_months> 3	분기마다
			    <repeat_months> 6	6개월 마다
			    <repeat_months> 12	1년 마다
			    */
			    var repeat = "";
			    if (resultMap.resultData.repeat_days == "1") repeat = "매일";
			    else if (resultMap.resultData.repeat_days == "7") repeat = "일주일 마다";
			    else if (resultMap.resultData.repeat_days == "14") repeat = "2주일 마다";
			    else if (resultMap.resultData.repeat_months == "1") repeat = "한달 마다";
			    else if (resultMap.resultData.repeat_months == "3") repeat = "분기 마다";
			    else if (resultMap.resultData.repeat_months == "6") repeat = "6개월 마다";
			    else if (resultMap.resultData.repeat_months == "12") repeat = "1년 마다";
			    else repeat = "한번만";
			    $("#scanRepeat").html(repeat);
			    
			    // Throughput 없으면 unlimited			    
			    if (isNull(resultMap.resultData.throughput)) {
			    	$("#scanThroughput").html("제한없음");
				}
			    else {
			    	$("#scanThroughput").html(resultMap.resultData.throughput + " MB");
				}
			    
			    if (isNull(resultMap.resultData.memory)) {
			    	$("#scanMemory").html("1024 MB");
				}
			    else {
			    	$("#scanMemory").html(resultMap.resultData.memory + " MB");
				}
			    
			    
			    var profiles  = resultMap.resultData.profilesLabel; //", datatypeLabelList
			    var profilesLabel = "";
				for (var i = 0; i < profiles.length; i++) {
					profilesLabel += profiles[i].DATATYPE_LABEL + " v" + profiles[i].VERSION + "</br>";
				}
				$("#scanDataType").html(profilesLabel);
			    
			    var targets = resultMap.resultData.targets;
			    if (targets.length == 1) $("#targets").html(targets.length + " Target");
			    else $("#targets").html(targets.length + " Targets");
			    $("#targetBody").empty();
				for (var i = 0; i < targets.length; i++) {
					var locationNames = "";
					var locations = targets[i].locations;
					if(!isNull(locations)) {
						for (var j = 0; j < locations.length; j++) {
							locationNames += locations[j].name + "</br>";
						}
					}
					var html = "<tr><th>서버이름</th><td>" + targets[i].name + "</td></tr><tr><th>스캔경로</th><td>" + locationNames + "</td></tr>";
					$("#targetBody").append( html );
				}
				/*
				<tbody id="targetBody">
					<tr>
						<th>서버이름</th>
						<td id="scanName"></td>
					</tr>
					<tr>
						<th>스캔경로</th>
						<td id="scanLocations"></td>
					</tr>
			    $("#scanName").html(targets[0].name);			    
			    var locationNames = "";
			    var locations = targets[0].locations;
				for (var i = 0; i < locations.length; i++) {
					locationNames += locations[i].name + "</br>";
				}
			    $("#scanLocations").html(locationNames);
			    */
				// 위치 잡기
			    $("#viewWindow").css("top","170px");
			    $("#viewWindow").css("left","600px");
		        $("#viewWindow").show();
		    },
		    error: function (request, status, error) {
		    	alert("Recon Server에 접속할 수 없습니다.");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	$("#deactivateSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "deactivate", row);
	});
	$("#modifySchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "modify", row);
	});
	$("#skipSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "skip", row);
	});
	$("#pauseSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "pause", row);
	});
	$("#restartSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		//changeSchedule(id, "restart", row);
		changeSchedule(id, "resume", row);
	});
	$("#stopSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "stop", row);
	});
	$("#cancelSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "cancel", row);
	});
	$("#reactivateSchedule").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		
		changeSchedule(id, "reactivate", row);
	});
	
	$("#btnScanRegist").click(function(){
		window.location = "${pageContext.request.contextPath}/scan/pi_scan_regist";
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});
	
	// 스케줄관리 click
	$("#manageSchedule").click(function(){
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'SCHEDULE_ID');
		// 스케줄관리 pop 생성
		console.log(id);
		setManageSchedulePop(id);
	});
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
function changeSchedule(id, task, row)
{
	var postData = {id : id, task : task};
	$.ajax({
		type: "POST",
		url: "/scan/changeSchedule",
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
	     		changedTask = "stoped";
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
	     	$("#targetGrid").jqGrid('setCell', row, 'SCHEDULE_STATUS', changedTask);

	     	alert("스캔 스케줄의 상태가 변경되었습니다.");
		    
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
	var postData = {id : id, ap_no};
	
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
	if('completed' == status){
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
	}
	
	return result;
}

function setStatusEN(status){
	//'completed':'완료','deactivated':'비활성화','cancelled':'취소','stopped':'중지','failed':'실패','scheduled':'예약','paused':'일시정지','scanning':'스캔중'
	var result = status;
	if(status.indexOf("완료") >= 0){
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
	}
	
	return result;
}
</script>


</body>
</html>