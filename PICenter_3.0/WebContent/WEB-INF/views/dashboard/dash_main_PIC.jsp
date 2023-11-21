<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
section {
	padding: 0 65px 0 45px;
}

header {
	background: none;
}

h4 {
	margin: 20px 0 0 1px;
	font-size: 16px;
	font-weight: normal;
}

.circle_server_total_cnt, .circle_server_complete_cnt,
	.circle_db_total_cnt, .circle_db_complete_cnt {
	font-size: 14px !important;
	padding: 0 !important;
}

#todo_result_list, #todo_result_approval, #todo_result_schedule{
	text-align: right;
	font-size: 20px;
	color: #fff;
}

.ui-widget.ui-widget-content{
	border: none;
}
.ui-jqgrid-hdiv {
	border: 1px solid #c8ced3;
}
.ui-jqgrid tr.jqgrow td{
	height: 33.7px;
}
.left_area{
	top: 0;
}
#circleGraph canvas[data-zr-dom-id="zr_0"]{
	cursor: default;
}
@media screen and (-ms-high-contrast: active) , ( -ms-high-contrast :
	none) {
	body{
		height: auto !important;
	}
}

@font-face {
      font-family: "NotoSansKR-Light";
      src: url("../resources/assets/fonts/NotoSansKR-Light.otf");
}
</style>

<!-- section -->
<section id="section">
	<!-- container -->
	<div class="container_main">
		<!-- left list-->
		<c:set var="serverCnt" value="${fn:length(aList)}" />
		<div class="left_area">
			<h4 style="position: relative; color: #FF7A00; margin-top: 31px; padding-bottom: 5px;">검색 스케줄 현황</h4>
			<table class="sch_target_tbl" style="margin-bottom: 5px;">
				<tbody>
					<tr>
						<td style="width: 352px;">
							<input type="date" id="fromDate" style="text-align: center; width: 168px; height: 30px; padding-left: 5px; border: 1px solid #c8ced3;"
									readonly="readonly" value="${fromDate}"> 
							<span style="width: 10%; margin-right: 3px; color: #000">~</span> 
							<input type="date" id="toDate" style="text-align: center; width: 168px; height: 30px; padding-left: 5px; border: 1px solid #c8ced3;"
									readonly="readonly" value="${toDate}">
							<input type="hidden" id="oldDate" readonly="readonly" value="">
						</td>
					</tr>
				</tbody>
			</table>
			<div class="left_box"
				style="height: 313px; width: 351px;">
				<div id="div_all" class="select_location"
					style="overflow-y: auto; overflow-x: auto; height: 100%; background: #ffffff; white-space: nowrap; border: none;">
					<div id="div_List"></div>
				</div>
			</div>
			<h4 style="position: relative; color: #FF7A00; margin-top: 13px;">자산 현황</h4>
			<table class="sch_target_tbl">
				<tbody>
					<tr>
						<td><input type="text" name="targetSearch" class=""
							id="targetSearch" placeholder="호스트명, IP, 그룹을 기입하세요"
							style="width: 293px; height: 30px; padding-left: 5px; border: 1px solid #c8ced3;">
						</td>
						<td>
							<button type="button" id="btn_sch_target" class="btn_sch_target"
								style="margin: 5px;"></button>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="left_box" style="height: 313px; width: 351px;">
				<div id="jstree" class="left_box"
					style="height: 300px; width: 339px; padding: 0; border: none;"></div>
			</div>
		</div>

		<div class="top_area_left">
			<div style="margin-top: 54px; padding-bottom: 5px;">
			</div>
			<div class="todo_box_list" style="background: #FF7A00;">
				<p style="color: #fff;">
					개인정보 조치<br> (미완료 누적)
				</p>
				<p id="todo_result_list">건</p>
			</div>
			<div class="todo_box_approval"
				style="margin: 1px 27px;background: #FF7A00;">
				<p style="color: #fff;">
					결재 신청/관리<br> &nbsp;
				</p>
				<p id="todo_result_approval">건</p>
			</div>
			<div class="todo_box_schedule"
				style="background: #FF7A00;">
				<p style="color: #fff;">
					스케줄 현황<br> &nbsp;
				</p>
				<p id="todo_result_schedule">건</p>
			</div>
		</div>
		<div class="top_area_right">
			<h4 style="margin-top: 31px; padding-bottom: 6px;">공지사항</h4>
			<div class="location_notice_area">
				<a href="<%=request.getContextPath()%>/user/pi_notice_main">more</a>
			</div>
				<c:forEach items="${noticeList}" var="list">
					<table class="squareBox" style="table-layout: fixed;">
						<tr>
							<td id="notice_title" style="cursor: pointer; width: 300px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
								${list.NOTICE_TITLE} 
								<input type="hidden" id="notice_detail"	value="${list.NOTICE_ID}">
							</td>
							<td id="notice_date" style="font-size: 12px; text-align: right;">${list.REGDATE}</td>
						</tr>
					</table>
				</c:forEach>
		</div>
		<div class="chart_area">
			<div class="chart_left" style="margin-left: 20px;">
				<h4 id="systemStatus" style="position: relative; display: inline-block; color: #FF7A00; margin-top: 23px; padding-bottom: 5px;">서버 검출현황 요약</h4>
				<button type="button" id="btnDownloadCircleExel" class="btn_down" style="font-size: 12px; height: 22px; margin-left: 249px; margin-bottom: 5px;" onclick="btnDownload()">다운로드</button>
				<div class="left_box"
					style="width: 466px; height: 600px; margin-right: 5px; padding: 0 20px;">
					<ul>
						<li style="width: 444px; padding: 0;">
							<div class="chart_box"
								style="height: 470px; padding: 0; border: none; background: #fff;">
								<div id=circleGraph
									style="height: 100%; width: 448px; float: left;"></div>
								<div id="circleData" style="display: none;"></div>
								<script type="text/javascript"> 
									<!-- 원그래프  -->
									/* 서버 */
									function circleGraph(result, status, ansyn) {
										
										var total = [];
										var error = [];
										var searched = [];
										var wait = [];
										var complete = [];
										var scancomp = [];
										var pause = [];
										
									    /* 
									    for(var i = 0; i < result.length; i++){
											total.push(result[i].TOTAL);
											error.push(result[i].ERROR);
											searched.push(result[i].SEARCHED);
											wait.push(result[i].WAIT);
											complete.push(result[i].COMPLETE);
											scancomp.push(result[i].SCANCOMP);
											pause.push(result[i].PAUSE);
											notconnect.push(result[i].NOTCONNECT);
										} 
									    */
										 
										
									    
									    for(var i = 0; i < result.length; i++){
									    	if(i == 0){
											    $.each(result[0], function(key, value){
											        if(key == "TOTAL") total.push(value);
											        if(key == "ERROR") error.push(value);
											        if(key == "SEARCHED") searched.push(value);
											        if(key == "WAIT") wait.push(value);
											        if(key == "COMPLETE") complete.push(value);
											        if(key == "SCANCOMP") scancomp.push(value);
											        if(key == "PAUSE") pause.push(value);
											    });
									    	}
									    }
									
										var echartdoughnut = echarts.init(document.getElementById('circleGraph'));
										echartdoughnut.setOption({
										    tooltip : {
										        trigger: 'item',
										        formatter: "{a} <br/>{b} : {c} ({d}%)"
										    }, 
										    legend: {
										        data:['오류','검색중','결과없음','검출','미검색','일시정지'],
										        padding: [0, 100, 30, 100],
										        bottom: 0
										    },
											textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 14
											},
										    series : [
										        {
										            name: '시스템현황',
										            type: 'pie',
										            radius : ['30%', '60%'],
										            color : ['#CC0F2E', '#68A62F', '#11088D', '#038FDA', '#6F037F', '#FBCD1F'],
										            center: ['49%', '40%'],
										            data:[
												         {value:error, name:'오류'},
												         {value:searched, name:'검색중'},
												         {value:wait, name:'미검색'},
												         {value:complete, name:'결과없음'},
												         {value:pause, name:'일시정지'},
												         {value:scancomp, name:'검출'}
										            ],
										            itemStyle: {
										                emphasis: {
										                    shadowBlur: 10,
										                    shadowOffsetX: 0,
										                    shadowColor: 'rgba(0, 0, 0, 0.5)'
										                }
										            }
										        }
										    ]
										});
										
										$(".circle_server_total_cnt").html(result[0].TOTAL + "대");
										$(".circle_server_complete_cnt").html(result[0].PROGRESS_COMPLETE + "대");
										
										var server_percent = result[0].PERCENT;
										var server_per = server_percent.split(".");
										
										if(server_per[1] == "0%"){
											server_percent = server_per[0] + "%";
										}
										
										$(".circle_server_percent").html(server_percent);
										$(".file_progress").val(result[0].VALUE);
										
										
										$(".circle_db_total_cnt").html(result[1].TOTAL + "대");
										$(".circle_db_complete_cnt").html(result[1].PROGRESS_COMPLETE + "대");
										
										var db_percent = result[1].PERCENT;
										var db_per = db_percent.split(".");
										
										if(db_per[1] == "0%"){
											db_percent = db_per[0] + "%";
										}
										
										$(".circle_db_percent").html(db_percent);
										$(".db_progress").val(result[1].VALUE); 
										var totalDiv;
										totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 221px; top: 188px; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
										totalDiv += '<h4 style="margin: 0;" class="circle_cnt" >총 대상수 <br> ' + total[0] + '</h4></div>';
										
										$("#circleGraph").append(totalDiv);
									};
									
									/* PC */
									function pcCircleGraph(result, status, ansyn) {
										
										var total = [];
										var error = [];
										var searched = [];
										var wait = [];
										var complete = [];
										var scancomp = [];
										var pause = [];
										
									    for(var i = 0; i < result.length; i++){
									    	if(i == 0){
											    $.each(result[0], function(key, value){
											        if(key == "TOTAL") total.push(value);
											        if(key == "ERROR") error.push(value);
											        if(key == "SEARCHED") searched.push(value);
											        if(key == "WAIT") wait.push(value);
											        if(key == "COMPLETE") complete.push(value);
											        if(key == "SCANCOMP") scancomp.push(value);
											        if(key == "PAUSE") pause.push(value);
											    });
									    	}
									    }
									
										var echartdoughnut = echarts.init(document.getElementById('circleGraph'));
										echartdoughnut.setOption({
										    tooltip : {
										        trigger: 'item',
										        formatter: "{a} <br/>{b} : {c} ({d}%)"
										    }, 
										    legend: {
										        data:['오류','검색중','결과없음','검출','미검색','일시정지'],
										        padding: [0, 100, 30, 100],
										        bottom: 0
										    },
											textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 14
											},
										    series : [
										        {
										            name: '시스템현황',
										            type: 'pie',
										            radius : ['30%', '60%'],
										            color : ['#CC0F2E', '#68A62F', '#11088D', '#038FDA', '#6F037F', '#FBCD1F'],
										            center: ['49%', '40%'],
										            data:[
												         {value:error, name:'오류'},
												         {value:searched, name:'검색중'},
												         {value:wait, name:'미검색'},
												         {value:complete, name:'결과없음'},
												         {value:pause, name:'일시정지'},
												         {value:scancomp, name:'검출'}
										            ],
										            itemStyle: {
										                emphasis: {
										                    shadowBlur: 10,
										                    shadowOffsetX: 0,
										                    shadowColor: 'rgba(0, 0, 0, 0.5)'
										                }
										            }
										        }
										    ]
										});
										
										/* $(".circle_server_total_cnt").html(result[0].TOTAL + "대");
										$(".circle_server_complete_cnt").html(result[0].PROGRESS_COMPLETE + "대");
										$(".circle_server_percent").html(result[0].PERCENT);
										$(".file_progress").val(result[0].VALUE);
										
										
										$(".circle_db_total_cnt").html(result[1].TOTAL + "대");
										$(".circle_db_complete_cnt").html(result[1].PROGRESS_COMPLETE + "대");
										$(".circle_db_percent").html(result[1].PERCENT);
										$(".db_progress").val(result[1].VALUE);  */
										var totalDiv;
										totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 221px; top: 188px; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
										totalDiv += '<h4 style="margin: 0;" class="circle_cnt" >총 대상수 <br> ' + total[0] + '</h4></div>';
										
										$("#circleGraph").append(totalDiv);
									}
								</script>
							</div>
							<div class="chart_box" style="background: #fff; border: 0 none;">
								<p style="height: 42px; margin-left: 13px; font-size: 14px; line-height: 47px;">
									<label id="topStatus">파일서버</label> 검출진행률 <span class="circle_server_percent"
										style="font-size: 28px; color: #0078D7;"></span> 총 <span
										class="circle_server_total_cnt"></span> 중 <span
										class="circle_server_complete_cnt"></span> 완료
								</p>
								<progress class="file_progress" value="" max="100"></progress>
								<p style="height: 42px; margin-left: 13px; font-size: 14px; line-height: 47px;">
									<label id="bottomStatus">DB서버</label> 검출진행률 <span class="circle_db_percent"
										style="font-size: 28px; color: #0078D7;"></span> 총 <span
										class="circle_db_total_cnt"></span> 중 <span
										class="circle_db_complete_cnt"></span> 완료
								</p>
								<progress class="db_progress" value="0" max="100"></progress>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="chart_center" style="margin-left: 27px;">
				<h4 id="serverRank" style="color: #FF7A00; display:inline-block; margin-top: 23px; padding-bottom: 5px;">개인정보 보유 서버순위</h4>
				<div class="left_box_dash_rank"
					style="width: 468px; height: 600px; padding: 10px 0;">
					<ul>
						<li class="tagetBox"
							style="width: 456px; margin-left: 10px;">
							<div class="grid_top" style="float: right;">
								<div class="left_box2"
									style="overflow: hidden; max-height: 575px;">
									<table id="rankGrid"></table>
								</div>
							</div>
						</li>
					</ul>
				</div>
				<div id="excelData" style="display: none;"></div>
			</div>
			<div class="chart_right">
				<h4 style="color: #FF7A00; margin-top: 23px; padding-bottom: 5px;">검출 현황</h4>
				<div class="left_box_dash_detection"
					style="width: 400px; height: 180px;">
					<ul>
						<li class="tagetBox" style="width: 388px; margin-top: 5px; margin-left: 5px;">
							<div class="chart_box" style="background: #fff; border: 0 none;">
								<table id="rrn_detection_tbl" class="squareBox">
									<tr>
										<td>검출 파일수</td>
										<td id="total_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td>미조치 파일수</td>
										<td id="incomplete_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td>조치 파일수</td>
										<td id="complete_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td>검출불가 파일수</td>
										<td style="text-align: right;">0</td>
									</tr>
									<tr>
										<td style="border-bottom: none;">전체 검출 테이블 수</td>
										<td style="text-align: right; border-bottom: none;">0</td>
									</tr>
								</table>
							</div>
						</li>
					</ul>
				</div>
				<h4 style="color: #FF7A00; display:inline-block; padding-bottom: 5px;">조치 현황</h4>
				<div class="left_box_dash_complete"
					style="width: 400px; height: 180px;">
					<ul>
						<li class="tagetBox" style="width: 388px; margin-top: 5px; margin-left: 5px;">
							<div class="chart_box" style="background: #fff; border: 0 none;">
								<table id="rrn_complete_tbl" class="squareBox">
									<tr>
										<td>보유등록 파일수</td>
										<td id="own_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td>오탐등록 파일수</td>
										<td id="fal_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td style="width: 50%;">법제도에 의해 예외된 파일수</td>
										<td id="legal_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td>시스템 파일수</td>
										<td id="sys_tbl" style="text-align: right;"></td>
									</tr>
									<tr>
										<td style="border-bottom: none;">삭제 파일수</td>
										<td id="del_tbl" style="text-align: right; border-bottom: none;"></td>
									</tr>
								</table>
							</div>
						</li>
					</ul>
					<!-- <li class="tagetBox" style="width: 14.5vw; margin-right:17px; margin-top: 55.6px; float: right;">
							    <h4>마지막 접속 일자</h4> 
							    <div class="chart_box" style="background: #fff;">
							        <tr>
							          <td>
							            <p class="target_tit" id="webdate">2019-12-26</p>
							          </td>
							        </tr>
							    </div>
							    <h4>리콘 연동 시간</h4> 
							    <div class="chart_box" style="background: #fff;">
							        <tr>
							          <td>
							            <p class="target_tit" id="webdate">2019-12-26</p>
							          </td>
							        </tr>
							    </div>
							  </li> -->
					</ul>
				</div>
			</div>
		</div>
		<div class="clear"></div>
	</div>
</section>
<%@ include file="../../include/footer.jsp"%>

<div id="pcDetailPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 850px; padding: 10px; background: #f9f9f9; left: 43%;">
	<img class="CancleImg" id="btnCanclePCDetailPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">상세 조회</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" id="div_update_user" style="height: auto; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="20%">
						<col width="25%">
						<col width="15%">
						<col width="20%">
						<col width="20%">
					</colgroup>
					<tbody id="popup_details">
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnClose">닫기</button>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">

$(function() {
	   $('#div_List').jstree({
			// List of active plugins
		   "core" : {
			    "animation" : 0,
			    "check_callback" : true,
				"themes" : { "stripes" : false },
				"data" : ${deptList},
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
			'plugins' : ["search"],
		})
	    .bind('select_node.jstree', function(evt, data, x) {
	    	var id = data.node.id;
	    	var type = data.node.data.type;
	    	var ap = data.node.data.ap_no;
	    	var parent = data.node.parent;
	    	
	    	if(id == "pc" || parent == "pc"){
    			$("#systemStatus").html("PC 검출현황 요약");
    			$("#serverRank").html("개인정보 보유 PC순위");
    			$("#topStatus").html("PC");
    			$("#bottomStatus").html("OneDrive");
    			$("#btnDownloadCircleExel").css("margin-left", "258px");
    		}else if(id == "server" || parent == "server"){
    			$("#systemStatus").html("서버 검출현황 요약");
    			$("#serverRank").html("개인정보 보유 서버순위");
    			$("#topStatus").html("파일서버");
    			$("#bottomStatus").html("DB서버");
    			$("#btnDownloadCircleExel").css("margin-left", "249px");
    		}
	    	$(".circle_cnt").html("");
	    	//$('#jstree').jstree(true).refresh();
	    	if(type == 1){
	    		var target_id = data.node.data.targets;
	    		if(id == "server" || parent == "server"){
	    			$.ajax({
		    	   		type: "POST",
		    	   		url: "/dash_personal_server_circle",
		    	   		////async : true,
		    	   		data : {
		    	   			targetList: target_id,
		    	   			id: id,
		    				type: type,
		    				ap: ap
		    			},
		    	   		dataType : "JSON",
		    	   		success: circleGraph,
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	});
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_personal_server_detectionItemList",
		    			////async : false,
		    			data: {
		    				targetList: target_id,
		    				ap: ap,
		    				id: id
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#total_tbl").html(resultMap.PATH_CNT);
		    		    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
		    		    	$("#complete_tbl").html(resultMap.COMPLETE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_personal_server_complete",
		    			////async : false,
		    			data: {
		    				targetList: target_id,
		    				ap: ap,
		    				id: id
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#own_tbl").html(resultMap.OWN);
		    		    	$("#fal_tbl").html(resultMap.FAL);
		    		    	$("#legal_tbl").html(resultMap.LEGAL);
		    		    	$("#sys_tbl").html(resultMap.SYS);
		    		    	$("#del_tbl").html(resultMap.DEL);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		var postData = {
		    			targetList: JSON.stringify(target_id),
		    			ap: ap,
		    			id: id
		    		};
		    		
		    		$("#rankGrid").setGridParam({
		    			url:"<%=request.getContextPath()%>/dash_personal_server_rank", 
		    			postData : postData, 
		    			datatype:"json" 
	    			}).trigger("reloadGrid");
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/pi_server_excelDownloadList",
		    			////async : false,
		    			data: {
		    				targetList: target_id,
		    				ap: ap,
		    				id: id,
		    				fromDate : $("#fromDate").val(),
		    		     	toDate : $("#toDate").val()
		    			},
		    			dataType : "json",
		    		    success: function (resultMap){
		    		    	var html = '<table id="excelTable"><tbody>';
		    				html += '<tr>'
		    				html += 	'<th>구분</th>';
		    				html += 	'<th>호스트</th>';
		    				html += 	'<th>날짜</th>';
		    				html += 	'<th>검출파일수(컬럼수)</th>';
		    				html += 	'<th>주민등록번호</th>';
		    				html += 	'<th>핸드폰</th>';
		    				html += 	'<th>계좌번호</th>';
		    				html += 	'<th>신용카드</th>';
		    				html += 	'<th>외국인번호</th>';
		    				html += 	'<th>운전면허</th>';
		    				html += 	'<th>이메일</th>';
		    				html += 	'<th>여권번호</th>';
		    				html += 	'<th>검출건수</th>';
		    				html += 	'<th>검출상태</th>';
		    				html += 	'<th>보유등록 파일수</th>';
		    				html += 	'<th>오탐등록 파일수</th>';
		    				html += 	'<th>법제도에 의해 예외된 파일수</th>';
		    				html += 	'<th>시스템 파일수</th>';
		    				html += 	'<th>삭제 파일수</th>';
		    				html += '</tr>';
		    				$.each(resultMap, function(index, item) {
		    					html += '<tr>';
		    					html += 	'<td>서버</td>';
		    					html += 	'<td>' + resultMap[index].SERVER + '</td>';
		    					html += 	'<td>' + resultMap[index].REGDATE + '</td>';
		    					html += 	'<td>' + resultMap[index].FILE + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE1 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE2 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE3 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE4 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE5 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE6 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE7 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE8 + '</td>';
		    					html += 	'<td>' + resultMap[index].COUNT + '</td>';
		    					html += 	'<td>' + resultMap[index].STATUS + '</td>';
		    					html += 	'<td>' + resultMap[index].OWN + '</td>';
		    					html += 	'<td>' + resultMap[index].FAL + '</td>';
		    					html += 	'<td>' + resultMap[index].LEGAL + '</td>';
		    					html += 	'<td>' + resultMap[index].SYS + '</td>';
		    					html += 	'<td>' + resultMap[index].DEL + '</td>';
		    					html += '</tr>';
		    				});
		    				html += '</tbody>';
		    				$("#excelData").html(html);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
	    		}else if(id == "pc" || parent == "pc"){
	    			
	    			// pc progress
	    			$.ajax({
		    	   		type: "POST",
		    	   		url: "/dash_personal_progress_pc",
		    	   		////async : true,
		    	   		data : {
		    	   			targetList: target_id,
		    	   			id: id,
		    				type: type,
		    				ap: ap,
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: function (result) {
		    	   			$(".circle_server_total_cnt").html(result[0].TOTAL + "대");
							$(".circle_server_complete_cnt").html(result[0].PROGRESS_COMPLETE + "대");
							
							var server_percent = result[0].PERCENT;
							var server_per = server_percent.split(".");
							
							if(server_per[1] == "0%"){
								server_percent = server_per[0] + "%";
							}
							
							$(".circle_server_percent").html(server_percent);
							$(".file_progress").val(result[0].VALUE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	});
	    			
	    			var date = data.node.text.split("_");
	    			
	    			$.ajax({
		    	   		type: "POST",
		    	   		url: "/dash_personal_progress_oneDrive",
		    	   		////async : true,
		    	   		data : {
		    	   			targetList: target_id,
		    	   			id: id,
		    				type: type,
		    				ap: ap,
		    				date: date[0],
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: function (result) {
		    	   			$(".circle_db_total_cnt").html(result[0].TOTAL + "건");
							$(".circle_db_complete_cnt").html(result[0].PROGRESS_COMPLETE + "건");
							
							var db_percent = result[0].PERCENT;
							var db_per = db_percent.split(".");
							
							if(db_per[1] == "0%"){
								db_percent = db_per[0] + "%";
							}
							
							$(".circle_db_percent").html(db_percent);
							$(".db_progress").val(result[0].VALUE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	}); 
	    			
	    			$.ajax({
		    	   		type: "POST",
		    	   		url: "/dash_personal_server_pc",
		    	   		////async : true,
		    	   		data : {
		    	   			targetList: target_id,
		    	   			id: id,
		    				type: type,
		    				ap: ap,
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: pcCircleGraph,
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	});
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_personal_server_detectionItemList",
		    			////async : false,
		    			data: {
		    				targetList: target_id,
		    				ap: ap,
		    				id: id
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#total_tbl").html(resultMap.PATH_CNT);
		    		    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
		    		    	$("#complete_tbl").html(resultMap.COMPLETE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		var postData = {
		    			targetList: JSON.stringify(target_id),
		    			ap: ap,
		    			id: id
		    		};
		    		
		    		$("#rankGrid").setGridParam({
		    			url:"<%=request.getContextPath()%>/dash_personal_pc_rank", 
		    			postData : postData, 
		    			datatype:"json" 
	    			}).trigger("reloadGrid");
		    		
		    		$("#own_tbl").html(0);
    		    	$("#fal_tbl").html(0);
    		    	$("#legal_tbl").html(0);
    		    	$("#sys_tbl").html(0);
    		    	$("#del_tbl").html(0);
    		    	
    		    	$.ajax({
		    			type: "POST",
		    			url: "/pi_pc_excelDownloadList",
		    			////async : false,
		    			data: {
		    				targetList: target_id,
		    				ap: ap,
		    				id: id,
		    				fromDate : $("#fromDate").val(),
		    		     	toDate : $("#toDate").val()
		    			},
		    			dataType : "json",
		    		    success: function (resultMap){
		    		    	var html = '<table id="excelTable"><tbody>';
		    				html += '<tr>'
		    				html += 	'<th>구분</th>';
		    				html += 	'<th>호스트</th>';
		    				html += 	'<th>날짜</th>';
		    				html += 	'<th>검출파일수(컬럼수)</th>';
		    				html += 	'<th>주민등록번호</th>';
		    				html += 	'<th>핸드폰</th>';
		    				html += 	'<th>계좌번호</th>';
		    				html += 	'<th>신용카드</th>';
		    				html += 	'<th>외국인번호</th>';
		    				html += 	'<th>운전면허</th>';
		    				html += 	'<th>이메일</th>';
		    				html += 	'<th>여권번호</th>';
		    				html += 	'<th>검출건수</th>';
		    				html += 	'<th>검출상태</th>';
		    				html += 	'<th>보유등록 파일수</th>';
		    				html += 	'<th>오탐등록 파일수</th>';
		    				html += 	'<th>법제도에 의해 예외된 파일수</th>';
		    				html += 	'<th>시스템 파일수</th>';
		    				html += 	'<th>삭제 파일수</th>';
		    				html += '</tr>';
		    				$.each(resultMap, function(index, item) {
		    					var platform =  resultMap[index].PLATFORM.indexOf("Apple");
		    					html += '<tr>';
		    					html += 	'<td>PC</td>';
		    					if(platform == -1){
			    					html += 	'<td>' + resultMap[index].PC + '</td>';
		    					}else {
		    						html += 	'<td>' + resultMap[index].MAC_NAME + '</td>';
		    					}
		    					html += 	'<td>' + resultMap[index].REGDATE + '</td>';
		    					html += 	'<td>' + resultMap[index].FILE + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE1 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE2 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE3 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE4 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE5 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE6 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE7 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE8 + '</td>';
		    					html += 	'<td>' + resultMap[index].COUNT + '</td>';
		    					html += 	'<td>' + resultMap[index].STATUS + '</td>';
		    					html += 	'<td>' + resultMap[index].OWN + '</td>';
		    					html += 	'<td>' + resultMap[index].FAL + '</td>';
		    					html += 	'<td>' + resultMap[index].LEGAL + '</td>';
		    					html += 	'<td>' + resultMap[index].SYS + '</td>';
		    					html += 	'<td>' + resultMap[index].DEL + '</td>';
		    					html += '</tr>';
		    				});
		    				html += '</tbody>';
		    				$("#excelData").html(html);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
	    		}
	    	}else if(type == 0){
	    		if(id == "server" || parent == "server"){
	    			$.ajax({
		    			type: "POST",
		    			url: "/pi_systemcurrent",
		    			data: {
		    				id: id,
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    			////async : false,
		    			dataType : "json",
		    		    success: circleGraph,
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_dataDetectionServerList",
		    			////async : false,
		    			data: {
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#total_tbl").html(resultMap.PATH_CNT);
		    		    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
		    		    	$("#complete_tbl").html(resultMap.COMPLETE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		var to_date = $("#toDate").val();
	   		    	var from_date = $("#fromDate").val();
	    		     
    		     	var postData = {
	   		    		 id: id,
	   		    		 toDate : to_date,
		    			 fromDate : from_date
	    		    }
	    		     
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_dataCompleteList",
		    			data: postData,
		    			////async : false,
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#own_tbl").html(resultMap.OWN);
		    		    	$("#fal_tbl").html(resultMap.FAL);
		    		    	$("#legal_tbl").html(resultMap.LEGAL);
		    		    	$("#sys_tbl").html(resultMap.SYS);
		    		    	$("#del_tbl").html(resultMap.DEL);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		$("#rankGrid").setGridParam({
		    			url:"<%=request.getContextPath()%>/dash_dataRank", 
		    			postData : postData, 
		    			datatype:"json" 
	    			}).trigger("reloadGrid");
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/pi_server_excelDownload",
		    			////async : false,
		    			data: postData,
		    			dataType : "json",
		    		    success: function (resultMap){
		    		    	var html = '<table id="excelTable"><tbody>';
		    				html += '<tr>'
		    				html += 	'<th>구분</th>';
		    				html += 	'<th>호스트</th>';
		    				html += 	'<th>날짜</th>';
		    				html += 	'<th>검출파일수(컬럼수)</th>';
		    				html += 	'<th>주민등록번호</th>';
		    				html += 	'<th>핸드폰</th>';
		    				html += 	'<th>계좌번호</th>';
		    				html += 	'<th>신용카드</th>';
		    				html += 	'<th>외국인번호</th>';
		    				html += 	'<th>운전면허</th>';
		    				html += 	'<th>이메일</th>';
		    				html += 	'<th>여권번호</th>';
		    				html += 	'<th>검출건수</th>';
		    				html += 	'<th>검출상태</th>';
		    				html += 	'<th>보유등록 파일수</th>';
		    				html += 	'<th>오탐등록 파일수</th>';
		    				html += 	'<th>법제도에 의해 예외된 파일수</th>';
		    				html += 	'<th>시스템 파일수</th>';
		    				html += 	'<th>삭제 파일수</th>';
		    				html += '</tr>';
		    				$.each(resultMap, function(index, item) {
		    					html += '<tr>';
		    					html += 	'<td>서버</td>';
		    					html += 	'<td>' + resultMap[index].SERVER + '</td>';
		    					html += 	'<td>' + resultMap[index].REGDATE + '</td>';
		    					html += 	'<td>' + resultMap[index].FILE + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE1 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE2 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE3 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE4 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE5 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE6 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE7 + '</td>';
		    					html += 	'<td>' + resultMap[index].TYPE8 + '</td>';
		    					html += 	'<td>' + resultMap[index].COUNT + '</td>';
		    					html += 	'<td>' + resultMap[index].STATUS + '</td>';
		    					html += 	'<td>' + resultMap[index].OWN + '</td>';
		    					html += 	'<td>' + resultMap[index].FAL + '</td>';
		    					html += 	'<td>' + resultMap[index].LEGAL + '</td>';
		    					html += 	'<td>' + resultMap[index].SYS + '</td>';
		    					html += 	'<td>' + resultMap[index].DEL + '</td>';
		    					html += '</tr>';
		    				});
		    				html += '</tbody>';
		    				$("#excelData").html(html);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    		}
    			else if(id == "pc" || parent == "pc"){
    				
    				$.ajax({
		    	   		type: "POST",
		    	   		url: "/pi_systemcurrent_progress_pc",
		    	   		////async : true,
		    	   		data : {
		    	   			id: id,
		    	   			fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: function (result) {
		    	   			$(".circle_server_total_cnt").html(result[0].TOTAL + "대");
							$(".circle_server_complete_cnt").html(result[0].PROGRESS_COMPLETE + "대");
							
							var server_percent = result[0].PERCENT;
							var server_per = server_percent.split(".");
							
							if(server_per[1] == "0%"){
								server_percent = server_per[0] + "%";
							}
							
							$(".circle_server_percent").html(server_percent);
							$(".file_progress").val(result[0].VALUE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	});
    				
    				$.ajax({
		    	   		type: "POST",
		    	   		url: "/pi_systemcurrent_progress_oneDrive",
		    	   		////async : true,
		    	   		data : {
		    	   			id: id,
		    	   			fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: function (result) {
		    	   			$(".circle_db_total_cnt").html(result[0].TOTAL + "건");
							$(".circle_db_complete_cnt").html(result[0].PROGRESS_COMPLETE + "건");
							
							var db_percent = result[0].PERCENT;
							var db_per = db_percent.split(".");
							
							if(db_per[1] == "0%"){
								db_percent = db_per[0] + "%";
							}
							
							$(".circle_db_percent").html(db_percent);
							$(".db_progress").val(result[0].VALUE); 
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    	   	}); 
    				
    				
    				
    				$.ajax({
		    	   		type: "POST",
		    	   		url: "/pi_systemcurrent_pc",
		    	   		////async : true,
		    	   		data : {
		    	   			id: id,
		    	   			fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    	   		dataType : "JSON",
		    	   		success: pcCircleGraph,
		    		    error: function (request, status, error) {
		    		    	console.log("ERROR : ", error);
		    		    }
		    	   	});
		    		
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_dataDetectionPCList",
		    			////async : false,
		    			data: {
		    				fromDate : $("#fromDate").val(),
		    				toDate : $("#toDate").val()
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#total_tbl").html(resultMap.PATH_CNT);
		    		    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
		    		    	$("#complete_tbl").html(resultMap.COMPLETE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		var to_date = $("#toDate").val();
	   		    	var from_date = $("#fromDate").val();
		    		var postData = {
		    			targetList: JSON.stringify(target_id),
		    			ap: ap,
		    			id: id,
		    			toDate : to_date,
	    			 	fromDate : from_date
		    		};
		    		
		    		$("#rankGrid").setGridParam({
		    			url:"<%=request.getContextPath()%>/dash_dataRank", 
		    			postData : postData, 
		    			datatype:"json" 
	    			}).trigger("reloadGrid");
		    		
		    		$("#own_tbl").html(0);
    		    	$("#fal_tbl").html(0);
    		    	$("#legal_tbl").html(0);
    		    	$("#sys_tbl").html(0);
    		    	$("#del_tbl").html(0);
    			}
	    		
	    		$.ajax({
	    			type: "POST",
	    			url: "/pi_pc_excelDownload",
	    			////async : false,
	    			data: postData,
	    			dataType : "json",
	    		    success: function (resultMap){
	    		    	var html = '<table id="excelTable"><tbody>';
	    				html += '<tr>'
	    				html += 	'<th>구분</th>';
	    				html += 	'<th>호스트</th>';
	    				html += 	'<th>날짜</th>';
	    				html += 	'<th>검출파일수(컬럼수)</th>';
	    				html += 	'<th>주민등록번호</th>';
	    				html += 	'<th>핸드폰</th>';
	    				html += 	'<th>계좌번호</th>';
	    				html += 	'<th>신용카드</th>';
	    				html += 	'<th>외국인번호</th>';
	    				html += 	'<th>운전면허</th>';
	    				html += 	'<th>이메일</th>';
	    				html += 	'<th>여권번호</th>';
	    				html += 	'<th>검출건수</th>';
	    				html += 	'<th>검출상태</th>';
	    				html += 	'<th>보유등록 파일수</th>';
	    				html += 	'<th>오탐등록 파일수</th>';
	    				html += 	'<th>법제도에 의해 예외된 파일수</th>';
	    				html += 	'<th>시스템 파일수</th>';
	    				html += 	'<th>삭제 파일수</th>';
	    				html += '</tr>';
	    				$.each(resultMap, function(index, item) {
	    					var platform =  resultMap[index].PLATFORM.indexOf("Apple");
	    					html += '<tr>';
	    					html += 	'<td>PC</td>';
	    					if(platform == -1){
		    					html += 	'<td>' + resultMap[index].PC + '</td>';
	    					}else {
	    						html += 	'<td>' + resultMap[index].MAC_NAME + '</td>';
	    					}
	    					html += 	'<td>' + resultMap[index].REGDATE + '</td>';
	    					html += 	'<td>' + resultMap[index].FILE + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE1 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE2 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE3 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE4 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE5 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE6 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE7 + '</td>';
	    					html += 	'<td>' + resultMap[index].TYPE8 + '</td>';
	    					html += 	'<td>' + resultMap[index].COUNT + '</td>';
	    					html += 	'<td>' + resultMap[index].STATUS + '</td>';
	    					html += 	'<td>' + resultMap[index].OWN + '</td>';
	    					html += 	'<td>' + resultMap[index].FAL + '</td>';
	    					html += 	'<td>' + resultMap[index].LEGAL + '</td>';
	    					html += 	'<td>' + resultMap[index].SYS + '</td>';
	    					html += 	'<td>' + resultMap[index].DEL + '</td>';
	    					html += '</tr>';
	    				});
	    				html += '</tbody>';
	    				$("#excelData").html(html);
	    		    },
	    		    error: function (request, status, error) {
	    		        console.log("ERROR : ", error);
	    		    }
	    		});
    		}
	    });
	   
	  /*  $('#div_pc').jstree({
			// List of active plugins
			"core" : {
			    "animation" : 0,
			    "check_callback" : true,
				"themes" : { "stripes" : false },
				"data" : ${pcDept},
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
			'plugins' : ["search"],
		}); */
		
		$('#jstree').jstree({
			// List of active plugins
			"core" : {
			    "animation" : 0,
			    "check_callback" : true,
				"themes" : { "stripes" : false },
				"data" : ${userGroupList},
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
			'search': {
		        'case_insensitive': false,
		        'show_only_matches' : true,
		        "show_only_matches_children" : true
		    },
			'plugins' : ["search"],
		})
	    .bind('select_node.jstree', function(evt, data, x) {
	    	
	    	var id = data.node.id;
	    	var type = null;
	    	var ap = null;
	    	var text = null;
	    	var connected = null;
	    	// 서버
	    	if(data.node.data != "" && data.node.data != null ){
	    		type = data.node.data.type;
	    		ap = data.node.data.ap;
	    		if(type == 1){
		    		$.ajax({
		    			type: "POST",
		    			url: "/dash_dataDetectionItemList",
		    			////async : false,
		    			data: {
		    				ap_no: ap,
		    				target_id: id
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	$("#total_tbl").html(resultMap.PATH_CNT);
		    		    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
		    		    	$("#complete_tbl").html(resultMap.COMPLETE);
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
		    		
		    	}
	    	}else{ // pc
	    		type = data.node.original.type;
	    		text = data.node.text;
	    		connected = data.node.original.connected;
	    		console.log(connected);
	    		if(connected != "0" && connected != null && connected != ""){
	    			$.ajax({
		    			type: "POST",
		    			url: "/dash_PC_jstree_popup",
		    			////async : false,
		    			data: {
		    				target_id: id
		    			},
		    			dataType: "json",
		    		    success: function (resultMap) {
		    		    	var details = "";
					    	details += "<tr style=\"height: 45px;\">";
					    	details += "	<th>호스트명</th>";
					    	details += "	<th>에이전트 IP</th>";
					    	details += "	<th>에이전트 연결상태</th>"; 
					    	details += "	<th>플랫폼</th>"; 
					    	details += "	<th>검색 완료 시간</th>"; 
					    	details += "</tr>";
					    	$.each(resultMap, function(index, item) {
					    		var platform =  resultMap[index].PLATFORM.indexOf("Apple");
					    		details += "<tr style=\"height: 45px;\">";
						    	details += "	<td style=\"text-align: center; padding-left: 0;\">"+ resultMap[index].NAME +"</td>";
						    	details += "	<td style=\"text-align: center; padding-left: 0;\">"+ resultMap[index].AGENT_CONNECTED_IP +"</td>";
						    	if(resultMap[index].AGENT_CONNECTED == 1){
						    		details += "<td style=\"text-align: center; padding-left: 0;\">";
						    		details += "<img src=\"${pageContext.request.contextPath}/resources/assets/images/img_agent_connected.png\" style=\" width:32px;\" >"+"</td>";
						    	}else{
						    		details += "<td style=\"text-align: center; padding-left: 0;\">";
						    		details += "<img src=\"${pageContext.request.contextPath}/resources/assets/images/img_agent_disconnected.png\" style=\" width:32px;\">"+"</td>";
						    	}
						    	details += "	<td style=\"text-align: center; padding-left: 0;\">"+ resultMap[index].AGENT_PLATFORM +"</td>";
						    	details += "	<td style=\"text-align: center; padding-left: 0;\">" +resultMap[index].SEARCHENDTIME +"</td>";
						    	details += "</tr>";
					    	});
					    	$("#popup_details").html(details);
					    	$("#pcDetailPopup").show();
		    		    },
		    		    error: function (request, status, error) {
		    		        console.log("ERROR : ", error);
		    		    }
		    		});
	    		}
	    	}
	    	
	    });
});

$("#btnClose").click(function() {
	$("#pcDetailPopup").hide();
});

$("#btnCanclePCDetailPopup").click(function() {
	$("#pcDetailPopup").hide();
});

function btnDownload(){
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
    exportTableToCsv("excelTable", "검출현황_요약_" + today);
}

function exportTableToCsv(tableId, filename) {
    if (filename == null || typeof filename == undefined)
        filename = tableId;
    filename += ".csv";
 
    var BOM = "\uFEFF";
 
    var table = document.getElementById(tableId);
    var csvString = BOM;
    for (var rowCnt = 0; rowCnt < table.rows.length; rowCnt++) {
        var rowData = table.rows[rowCnt].cells;
        for (var colCnt = 0; colCnt < rowData.length; colCnt++) {
            var columnData = rowData[colCnt].innerHTML;
            if (columnData == null || columnData.length == 0) {
                columnData = "".replace(/"/g, '""');
            }
            else {
                columnData = columnData.toString().replace(/"/g, '""'); // escape double quotes
            }
            csvString = csvString + '"' + columnData + '",';
        }
        csvString = csvString.substring(0, csvString.length - 1);
        csvString = csvString + "\r\n";
    }
    csvString = csvString.substring(0, csvString.length - 1);
 
    // IE 10, 11, Edge Run
    if (window.navigator && window.navigator.msSaveOrOpenBlob) {
 
        var blob = new Blob([decodeURIComponent(csvString)], {
            type: 'text/csv;charset=utf8'
        });
 
        window.navigator.msSaveOrOpenBlob(blob, filename);
 
    } else if (window.Blob && window.URL) {
        // HTML5 Blob
        var blob = new Blob([csvString], { type: 'text/csv;charset=utf8' });
        var csvUrl = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.setAttribute('style', 'display:none');
        a.setAttribute('href', csvUrl);
        a.setAttribute('download', filename);
        document.body.appendChild(a);
 
        a.click()
        a.remove();
    } else {
        // Data URI
        var csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csvString);
        var blob = new Blob([csvString], { type: 'text/csv;charset=utf8' });
        var csvUrl = URL.createObjectURL(blob);
        var a = document.createElement('a');
        a.setAttribute('style', 'display:none');
        a.setAttribute('target', '_blank');
        a.setAttribute('href', csvData);
        a.setAttribute('download', filename);
        document.body.appendChild(a);
        a.click()
        a.remove();
    }
}

var ch_target_id = "";
function change_target_id(target_id) {
	ch_target_id = target_id;
}
$(document).ready(function() {
	
	setSelectDate();
	
	var postData = {
       	user_no : '${memberInfo.USER_NO}',
     	fromDate : $("#fromDate").val(),
     	toDate : $("#toDate").val()
    }
	fn_drawrankGrid(postData);
	fn_drawBottomNGrid();
	
	
	$.ajax({
		type: "POST",
		url: "/pi_systemcurrent",
		////async : false,
		data: postData,
		dataType : "json",
	    success: circleGraph,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/pi_server_excelDownload",
		////async : false,
		data: postData,
		dataType : "json",
	    success: function (resultMap){
	    	var html = '<table id="excelTable"><tbody>';
			html += '<tr>'
			html += 	'<th>구분</th>';
			html += 	'<th>호스트</th>';
			html += 	'<th>날짜</th>';
			html += 	'<th>검출파일수(컬럼수)</th>';
			html += 	'<th>주민등록번호</th>';
			html += 	'<th>핸드폰</th>';
			html += 	'<th>계좌번호</th>';
			html += 	'<th>신용카드</th>';
			html += 	'<th>외국인번호</th>';
			html += 	'<th>운전면허</th>';
			html += 	'<th>이메일</th>';
			html += 	'<th>여권번호</th>';
			html += 	'<th>검출건수</th>';
			html += 	'<th>검출상태</th>';
			html += 	'<th>보유등록 파일수</th>';
			html += 	'<th>오탐등록 파일수</th>';
			html += 	'<th>법제도에 의해 예외된 파일수</th>';
			html += 	'<th>시스템 파일수</th>';
			html += 	'<th>삭제 파일수</th>';
			html += '</tr>';
			$.each(resultMap, function(index, item) {
				html += '<tr>';
				html += 	'<td>서버</td>';
				html += 	'<td>' + resultMap[index].SERVER + '</td>';
				html += 	'<td>' + resultMap[index].REGDATE + '</td>';
				html += 	'<td>' + resultMap[index].FILE + '</td>';
				html += 	'<td>' + resultMap[index].TYPE1 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE2 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE3 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE4 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE5 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE6 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE7 + '</td>';
				html += 	'<td>' + resultMap[index].TYPE8 + '</td>';
				html += 	'<td>' + resultMap[index].COUNT + '</td>';
				html += 	'<td>' + resultMap[index].STATUS + '</td>';
				html += 	'<td>' + resultMap[index].OWN + '</td>';
				html += 	'<td>' + resultMap[index].FAL + '</td>';
				html += 	'<td>' + resultMap[index].LEGAL + '</td>';
				html += 	'<td>' + resultMap[index].SYS + '</td>';
				html += 	'<td>' + resultMap[index].DEL + '</td>';
				html += '</tr>';
			});
			html += '</tbody>';
			$("#excelData").html(html);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	/* $.ajax({
		type: "POST",
		url: "/selectJumpUpHost",
		//async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	}); */
	
	/* var circle_total = {"TOTAL":5,"ERROR":0,"SEARCHED":0,"WAIT":1,"COMPLETE":2,"SCANCOMP":0,"PAUSE":2,"NOTCONNECT":19}
	var result_circle_graph = []
	result_circle_graph.push(circle_total)
	
	circleGraph(result_circle_graph, 'success', '') */
	
	//var test = JSON.parse(result);
	//console.log(test)
	/* $.ajax({
		type: "POST",
		url: "/pi_datatype",
		//async : false,
		data : postData,
		dataType : "json",
	    success: resizeGraph_One,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	}); */
	
	
	$.ajax({
		type: "POST",
		url: "/selectWebLink",
		////async : false,
		data : "",
		dataType : "json",
	    success: function(data) {
			$("#webdate").html(data.RECON_LINK);
		},
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	
	$.ajax({
		type: "POST",
		url: "/dash_dataDetectionServerList",
		////async : false,
		data: postData,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#total_tbl").html(resultMap.PATH_CNT);
	    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
	    	$("#complete_tbl").html(resultMap.COMPLETE);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/dash_dataCompleteList",
		////async : false,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#own_tbl").html(resultMap.OWN);
	    	$("#fal_tbl").html(resultMap.FAL);
	    	$("#legal_tbl").html(resultMap.LEGAL);
	    	$("#sys_tbl").html(resultMap.SYS);
	    	$("#del_tbl").html(resultMap.DEL);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/dash_personal_server_count",
		////async : false,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#server").html("서버 ( " + resultMap.SERVER_CNT + " )");
	    	$("#pc").html("PC ( " + resultMap.PC_CNT + " )");
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$(".todo_box_list").click(function() {
		document.location.href = "<%=request.getContextPath()%>/approval/pi_search_list";
	});
	$(".todo_box_approval").click(function() {
		document.location.href = "<%=request.getContextPath()%>/approval/pi_search_approval_list";
	});
	$(".todo_box_schedule").click(function() {
		document.location.href = "<%=request.getContextPath()%>/search/search_list";
	});
	
	$.ajax({
		type: "POST",
		url: "/dash_dataTodoList",
		////async : false,
		data : postData,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#todo_result_list").html(resultMap.LIST_TOTAL + "건");
	    	$("#todo_result_list").css("color", "#FFF");
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/dash_dataTodoApproval",
		////async : false,
		data : postData,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#todo_result_approval").html(resultMap.APPROVAL_TOTAL + "건");
	    	$("#todo_result_approval").css("color", "#FFF");
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));

	var oOldeDate = new Date(oToday.setDate(oToday.getDate() - 91));
	$("#oldDate").val(getFormatDate(oOldeDate));
	
	
	var dashData = {
       	user_no : '${memberInfo.USER_NO}',
       	fromDate : $("#fromDate").val(),
     	toDate : $("#toDate").val()
    }
	
	$.ajax({
		type: "POST",
		url: "/dash_dataTodoSchedule",
		////async : false,
		data : dashData,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#todo_result_schedule").html(resultMap.SCHEDULE_TOTAL + "건");
	    	$("#todo_result_schedule").css("color", "#FFF");
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	$.ajax({
		type: "POST",
		url: "/group/dashListDept",
		////async : false,
		data: postData,
	    success: function (result) {
	    	if(result.resultCode == -1){
	    		return;
	    	}
	    	$('#div_List').jstree(true).settings.core.data = result.data;
	    	$('#div_List').jstree(true).refresh();
	    	
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error)
	    }
	});
	
    $("#fromDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
         	var postData = {
         		fromDate : $("#fromDate").val(),
         		toDate : $("#toDate").val(),
         	}
         	$.ajax({
        		type: "POST",
        		url: "/group/dashListDept",
        		////async : false,
        		data: postData,
        	    success: function (result) {
        	    	if(result.resultCode == -1){
        	    		return;
        	    	}
        	    	
        	    	$('#div_List').jstree(true).settings.core.data = result.data;
        	    	$('#div_List').jstree(true).refresh();
        	    	
        	    },
        	    error: function (request, status, error) {
        	        console.log("ERROR : ", error)
        	    }
        	});
        	
	    }
        
    });

    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
	        console.log("Selected date: " + dateText + "; input's current value: " + this.value);
	        var postData = {
	         		fromDate : $("#fromDate").val(),
	         		toDate : $("#toDate").val(),
	         	}
	         	$.ajax({
	        		type: "POST",
	        		url: "/group/dashListDept",
	        		////async : false,
	        		data: postData,
	        	    success: function (result) {
	        	    	if(result.resultCode == -1){
	        	    		return;
	        	    	}
	        	    	
	        	    	$('#div_List').jstree(true).settings.core.data = result.data;
	        	    	$('#div_List').jstree(true).refresh();
	        	    	
	        	    },
	        	    error: function (request, status, error) {
	        	        console.log("ERROR : ", error)
	        	    }
	        	});
	        	
	    }
    });
	
	/* $.ajax({
		type: "POST",
		url: "/group/dashServerDept",
		////async : false,
		data: postData,
	    success: function (result) {
	    	console.log(result);
	    	if(result.resultCode == -1){
	    		return;
	    	}
	    	$('#div_server').jstree(true).settings.core.data = result.data;
	    	$('#div_server').jstree(true).refresh();
	    	
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error)
	    }
	});
	
    $("#fromDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
         	var postData = {
         		fromDate : $("#fromDate").val(),
         		toDate : $("#toDate").val(),
         	}
         	$.ajax({
        		type: "POST",
        		url: "/group/dashServerDept",
        		////async : false,
        		data: postData,
        	    success: function (result) {
        	    	console.log(result);
        	    	
        	    	if(result.resultCode == -1){
        	    		return;
        	    	}
        	    	
        	    	$('#div_server').jstree(true).settings.core.data = result.data;
        	    	$('#div_server').jstree(true).refresh();
        	    	
        	    },
        	    error: function (request, status, error) {
        	        console.log("ERROR : ", error)
        	    }
        	});
        	
	    }
        
    });

    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
	        console.log("Selected date: " + dateText + "; input's current value: " + this.value);
	        var postData = {
	         		fromDate : $("#fromDate").val(),
	         		toDate : $("#toDate").val(),
	         	}
	         	$.ajax({
	        		type: "POST",
	        		url: "/group/dashServerDept",
	        		////async : false,
	        		data: postData,
	        	    success: function (result) {
	        	    	console.log(result);
	        	    	
	        	    	if(result.resultCode == -1){
	        	    		return;
	        	    	}
	        	    	
	        	    	$('#div_server').jstree(true).settings.core.data = result.data;
	        	    	$('#div_server').jstree(true).refresh();
	        	    	
	        	    },
	        	    error: function (request, status, error) {
	        	        console.log("ERROR : ", error)
	        	    }
	        	});
	        	
	    }
    });
    
    $.ajax({
		type: "POST",
		url: "/group/dashPCDept",
		////async : false,
		data: postData,
	    success: function (result) {
	    	console.log(result);
	    	if(result.resultCode == -1){
	    		return;
	    	}
	    	$('#div_pc').jstree(true).settings.core.data = result.data;
	    	$('#div_pc').jstree(true).refresh();
	    	
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error)
	    }
	});
	
    $("#fromDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
         	var postData = {
         		fromDate : $("#fromDate").val(),
         		toDate : $("#toDate").val(),
         	}
         	$.ajax({
        		type: "POST",
        		url: "/group/dashPCDept",
        		////async : false,
        		data: postData,
        	    success: function (result) {
        	    	console.log(result);
        	    	
        	    	if(result.resultCode == -1){
        	    		return;
        	    	}
        	    	
        	    	$('#div_pc').jstree(true).settings.core.data = result.data;
        	    	$('#div_pc').jstree(true).refresh();
        	    	
        	    },
        	    error: function (request, status, error) {
        	        console.log("ERROR : ", error)
        	    }
        	});
        	
	    }
        
    });

    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateText) {
	        console.log("Selected date: " + dateText + "; input's current value: " + this.value);
	        var postData = {
	         		fromDate : $("#fromDate").val(),
	         		toDate : $("#toDate").val(),
	         	}
	         	$.ajax({
	        		type: "POST",
	        		url: "/group/dashPCDept",
	        		////async : false,
	        		data: postData,
	        	    success: function (result) {
	        	    	console.log(result);
	        	    	
	        	    	if(result.resultCode == -1){
	        	    		return;
	        	    	}
	        	    	
	        	    	$('#div_pc').jstree(true).settings.core.data = result.data;
	        	    	$('#div_pc').jstree(true).refresh();
	        	    	
	        	    },
	        	    error: function (request, status, error) {
	        	        console.log("ERROR : ", error)
	        	    }
	        	});
	        	
	    }
    }); */
    var to = true;
    $('#btn_sch_target').on('click', function(){
    	
    	if($("#fromDate").val() > $("#toDate").val()){
			alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
			return;
		}

        var v = $('#targetSearch').val();
    	console.log(v);
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#jstree').jstree(true).search(v);
        }, 250);
    });
    
    $('#targetSearch').keyup(function (e) {
    	var v = $('#targetSearch').val();
    	if (e.keyCode == 13) {
        	
        	if(to) { clearTimeout(to); }
            to = setTimeout(function () {
              $('#jstree').jstree(true).search(v);
            }, 250);
        }
    });
});
   
   function datatype(result, type) {
   	if(result.length != 0){
   		for(var i = 0; i < result.length; i++){
   			var addRow = "";
   			if(result[i].IP != null){
   				addRow += "<tr><td>" + result[i].NAME + "<br>(" + result[i].IP + ")</td>"
   			} else {
   				addRow += "<tr><td>" + result[i].NAME + "<br>(연결안됨)</td>"
   			}
   			
   			var regexp = /\B(?=(\d{3})+(?!\d))/g;
   			var type1 = String(result[i].TYPE1).replace(regexp, ',');
   			
   			addRow += '<td style="text-align: right;">' + type1 + '</td>'
   			
   			
   			$("#" + type + "_tbl").append(addRow);
   			
   		}
   	}
   }


   function exception(target_id) {
		var form = document.createElement("form");
		var input   = document.createElement("input");
		input.type   = "hidden";
		input.name  = "target_id";
		input.value  = target_id;
		form.action = "<%=request.getContextPath()%>/exception/pi_exception_regist";
		form.method = "post";
		
		
		form.appendChild(input);
		document.body.appendChild(form);
		form.submit();
		/* var target_id = $("#"+id).find("title").text(); */
	}

	var aut = "manager"

	$("#personal_server").on("click", function() {
		
		var postData = {
				fromDate : $("#fromDate").val(),
				toDate : $("#toDate").val(),
	    }
	   	$.ajax({
	   		type: "POST",
	   		url: "/dash_personal_server",
	   		////async : false,
	   		data : postData,
	   		dataType : "JSON",
	   		success: function (resultMap) {
	            $("#personalServer").nextAll().html("");
	            
	            var addRow  = "";
	            $.each(resultMap, function(index, item) {
	            	
	            	addRow += '<tr class="server_result" style="display:none;" data-uptidx="personal_server" data-level="2" data-mother="server" data-targetcnt="0" data-id="server">' 
                       		+'<th><p id="server_result_p'+ item.SCHEDULE_GROUP_ID +'" class="personal_server_tit" style="cursor:pointer; margin-left:20px;" >' + item.RESULT + "" ;
                    addRow += '</p><input type="hidden" id="groupId" value="'+ item.SCHEDULE_GROUP_ID  + '">';
                 	addRow += '</th></tr>';
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
	   		////async : false,
	   		data : postData,
	   		dataType : "JSON",
	   		success: function (resultMap) {
	            $("#personalPC").nextAll().html("");
	            
	            var addRow  = "";
	            $.each(resultMap, function(index, item) {
	            	
	               addRow += '<tr class="pc_result" style="display:none;" data-uptidx="personal_PC" data-level="2" data-mother="PC" data-targetcnt="0" data-id="PC">' 
	                        +'<th><p id="pc_result_p'+ item.SCHEDULE_GROUP_ID +'" class="sta_tit" style="cursor:pointer; margin-left:20px;" >' + item.RESULT + "";
	               addRow += '</p></th></tr>';
	            });
	            
	            $("#personalPC").after(addRow);
	            
	      	},
	   	});
		
	});
	
$(document).on("click", ".personal_server_tit", function (e){
   	var id = $(this).attr('id');
   	var postData = {
   		id : id,
   		groupId : $("#groupId").val(),
   		fromDate : $("#fromDate").val(),
		toDate : $("#toDate").val(),
    }
   	$.ajax({
   		type: "POST",
   		url: "/dash_personal_server_circle",
   		////async : false,
   		data : postData,
   		dataType : "JSON",
   		success: circleGraph,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
   	});
});	

function skt_item_list(e){
	var ap_no = e.getAttribute('data-apno');
	var target_id = e.getAttribute('data-targetid');
	console.log(ap_no + ", " + target_id);
	
	$.ajax({
		type: "POST",
		url: "/dash_dataDetectionItemList",
		////async : false,
		data: {
			ap_no: ap_no,
			target_id: target_id
		},
		dataType: "json",
	    success: function (resultMap) {
	    	$("#total_tbl").html(resultMap.PATH_CNT);
	    	$("#incomplete_tbl").html(resultMap.INCOMPLETE);
	    	$("#complete_tbl").html(resultMap.COMPLETE);
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
}



function fn_drawrankGrid(postData) {
	var gridWidth = $("#rankGrid").parent().width();
	
	$("#rankGrid").jqGrid({
		url: "<%=request.getContextPath()%>/dash_dataRank",
		datatype: "json",
		postData: postData,
	   	mtype : "POST",
		colNames:['서버','검출파일수(컬럼수)','검출건수'],
		colModel: [
			{ index: 'SERVER', 	name: 'SERVER', 	width: 130, align: 'center'},
			{ index: 'FILE', 	name: 'FILE',  width: 70, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'COUNT', 	name: 'COUNT', width: 70, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' }
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 540,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:50,
		rowList:[50,100,200],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
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

function fn_drawBottomNGrid() {
	var gridWidth = $("#bottomNGrid").parent().width();
	
	$("#bottomNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/dash_dataImple",
		datatype: "json",
	   	mtype : "POST",
		colNames:['번호','호스트명','서비스명','현재 검출파일','현재 검출건','최초 검출파일','최초 검출건','최초 검출일','증감률','이행점검 회수','최근 실행일자'],
		colModel: [
			{ index: 'NUM', 			name: 'NUM', 	width: 30, align: 'right', sorttype: 'number'},
			{ index: 'NAME', 			name: 'NAME', 	width: 100, align: 'center' },
			{ index: 'SERVICE_NM', 		name: 'SERVICE_NM', 	width: 100, align: 'center' },
			{ index: 'MAX_PATH_CNT', 	name: 'MAX_PATH_CNT',  width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'MAX_TOTAL', 		name: 'MAX_TOTAL', width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
			{ index: 'MIN_PATH_CNT', 	name: 'MIN_PATH_CNT', width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'MIN_TOTAL', 		name: 'MIN_TOTAL', width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'MIN_DATE', 		name: 'MIN_DATE', width: 100, align: 'center' },
			{ index: 'RATE', 			name: 'RATE', width: 100, align: 'right' , sorttype: 'number' },
			{ index: 'COMPLETED', 		name: 'COMPLETED', width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'DATE_COMPLETED', 	name: 'DATE_COMPLETED', width: 100, align: 'center'}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 91,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  		
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

function getFormatDate(oDate)
{
    var nYear = oDate.getFullYear();           // yyyy 
    var nMonth = (1 + oDate.getMonth());       // M 
    nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 

    var nDay = oDate.getDate();                // d 
    nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장

    return nYear + '-' + nMonth + '-' + nDay;
}

function setSelectDate() 
{
    var oToday = new Date();
    $("#toDate").val(getFormatDate(oToday));

    var oFromDate = new Date(oToday.setDate(oToday.getDate() - 91));
    $("#fromDate").val(getFormatDate(oFromDate));
}

$("#btnApproval").on("click", function(e) {
	$.ajax({
		type: "POST",
		url: "/approvalTest",
		//async : false,
	    success: function (resultMap) {
	       // console.log(resultMap);
	    },
	    error: function (request, status, error) {
			alert("인증번호 인증 실패하셨습니다. ");
	    }
	});
});

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

$(document).on("click", "#notice_title", function (e){
	var id = $(this).children("#notice_detail").val();
	
	if (id != "0") {
        var pop_url = "${getContextPath}/popup/noticeDetail";
    	var winWidth = 1260;
    	var winHeight = 750;
    	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
    	//var pop = window.open(pop_url,"detail",popupOption);
    	var pop = window.open(pop_url + "?id=" + id,id,popupOption);
    	/* popList.push(pop);
    	sessionUpdate(); */
    	//pop.check();
    	
    	/* var newForm = document.createElement('form');
    	newForm.method='POST', 'GET';
    	newForm.action=pop_url + "/" + id;
    	newForm.name='newForm';
    	//newForm.target='detail';
    	newForm.target=id;
    	
    	var input_id = document.createElement('input');
    	input_id.setAttribute('type','hidden');
    	input_id.setAttribute('name','id');
    	input_id.setAttribute('value',id);

    	newForm.appendChild(input_id);
    	document.body.appendChild(newForm);
    	newForm.submit();
    	
    	document.body.removeChild(newForm); */
    }
    else {
    	getLowPath(id);
    }
});	

</script>
</body>
</html>