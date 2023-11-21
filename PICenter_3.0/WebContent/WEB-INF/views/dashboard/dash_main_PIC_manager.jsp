<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
section {
	padding: 0 65px 0 45px;
}

header{
	background: none;
}
h4 {
	margin : 14px 0 0 1px;
	font-size: 16px;
	font-weight: normal;
}
.circle_server_total_cnt, .circle_server_complete_cnt, .circle_db_total_cnt, .circle_db_complete_cnt{
	font-size: 16px !important;
	padding: 0 !important;
}
.ui-widget.ui-widget-content{
	border: none;
}
.ui-jqgrid .ui-jqgrid-hdiv{
	border: 1px solid #c8ced3;
}
#main_graph canvas[data-zr-dom-id="zr_0"]{
	max-width: 990px !important;
	min-width: 990px !important;
	width: 990px !important;
	padding-top: 7px !important;
	padding-right: 15px !important;
}
#circleGraph canvas[data-zr-dom-id="zr_0"]{
	height: 265px !important;
	cursor: default;
}
</style>

		<!-- section -->
		<section id="section">
			<!-- container -->
			<div class="container_main">
				<!-- left list-->
				<c:set var="serverCnt" value="${fn:length(aList)}"/>
				<div class="left_area">
					<%-- <div class="sch_target_box" style="margin-top: 55px;">
						<table class="sch_target_tbl">	
	                			<tbody>
	                				<tr>
	                					 <td>
		                        		 	 <input type="text" name="targetSearch" class="" id="targetSearch" style="margin-top: 5px; width: 291px;">
		                        		 	 <button type="button" id="btn_sch_target" class="btn_sch_target" style="float: right; height: 27px;" ></button>
	                        		 	</td>
	                				</tr>
	                			</tbody>
						</table>
					</div>
					<div class="date_area">
						<table>
							<tbody>
								<tr>
									<th style="text-align: center; padding: 10px 3px; width: 15%;">검색기간</th>
									<td style="width: 326px;">
										<input type="date" id="fromDate" style="text-align: center;  width:138px;" readonly="readonly" value="${fromDate}" >
										<span style="width: 10%; margin-right: 3px; color: #000">~</span>
										<input type="date" id="toDate" style="text-align: center;  width:138px;" readonly="readonly" value="${toDate}" >
									</td>
								</tr>
							</tbody>
						</table>
					</div> --%>
					<h4 style="position: relative; color: #FF7F00; margin-top: 19px; margin-bottom: 5px;">자산 현황</h4>
<!-- 					<h4 style="position: relative; color: #FF7F00; margin-top: 21px; margin-bottom: 5px;"> SKT 자산 리스트</h4> -->
					<div class="left_box" style="height:605px; width: 351px;">
						<div id="jstree" class="left_box" style="height:593px; width: 329px; padding: 0; border: none;">
						</div>
					</div>
				</div>
				 
				<!-- chart area -->
				<div class="top_area_left" style="margin-left: 0;">
					<h4 style="margin-top:30px;">공지사항</h4>
						<div class="location_notice_area_manager">
							<a href="<%=request.getContextPath()%>/user/pi_notice_main">more</a>
						</div>
						<c:forEach items="${noticeList}" var="list">
						<table class="squareBox" style="table-layout: fixed;">
							<tr>
								<td id="notice_title"
									style="cursor: pointer; width: 300px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">
									${list.NOTICE_TITLE} <input type="hidden" id="notice_detail"
									value="${list.NOTICE_ID}">
								</td>
								<td id="notice_date" style="font-size: 12px; text-align: right;">${list.REGDATE}</td>
							</tr>
						</table>
			</c:forEach>
				</div>
				<div class="chart_area">
					<div class="chart_left">
						<h4 style="position: relative; color: #FF7F00; margin-top: 18px; margin-bottom: 5px;">검출현황 요약</h4>
						<div class="left_box" style="width: 413px; margin-right: 5px;">
							<ul>  
								<li style="width:380px; padding: 0;" > 
									<div class="chart_box" style="height: 265px; padding: 0; border: none; background: #fff;">
										<div id=circleGraph style="height: 100%; width: 405px; float: left;"></div>
										<script type="text/javascript"> 
										<!-- 원그래프  -->
										function circleGraph(result, status, ansyn) {
											
											var total = [];
											var error = [];
											var searched = [];
											var wait = [];
											var complete = [];
											var scancomp = [];
											var pause = [];
											
										    /* for(var i = 0; i < result.length; i++){
												total.push(result[i].TOTAL);
												error.push(result[i].ERROR);
												searched.push(result[i].SEARCHED);
												wait.push(result[i].WAIT);
												complete.push(result[i].COMPLETE);
												scancomp.push(result[i].SCANCOMP);
												pause.push(result[i].PAUSE);
												notconnect.push(result[i].NOTCONNECT);
											}  */ 
											 
											
											$.each(result, function(key, value){
											    $.each(value, function(key, value){
											        if(key == "TOTAL") total.push(value);
											        if(key == "ERROR") error.push(value);
											        if(key == "SEARCHED") searched.push(value);
											        if(key == "WAIT") wait.push(value);
											        if(key == "COMPLETE") complete.push(value);
											        if(key == "SCANCOMP") scancomp.push(value);
											        if(key == "PAUSE") pause.push(value);
											        
											    });
											}); 
										
											var echartdoughnut = echarts.init(document.getElementById('circleGraph'));
											echartdoughnut.setOption({
											    tooltip : {
											        trigger: 'item',
											        formatter: "{a} <br/>{b} : {c} ({d}%)"
											    }, 
											    legend: {
											        data:['오류','검색중','결과없음','검출','미검색','일시정지'],
											        padding: [0, 75, 0, 75],
											        bottom: 3
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
											            center: ['50%', '43%'],
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
											$(".circle_server_percent").html(result[0].PERCENT);
											$(".file_progress").val(result[0].VALUE);
											var totalDiv;
											totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 202px; top: 117px; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
											totalDiv += '<h4 style="margin: 0; font-size: 14px;" class="circle_cnt" >총 대상수 <br> ' + total + '</h4></div>';
											
											$("#circleGraph").append(totalDiv);
										}
										</script>
									</div>
								</li>
							</ul>
						</div>
						<h4 id="managerRank" style="color: #FF7A00; display:inline-block; margin-top: 23px; padding-bottom: 5px;">개인정보 보유 순위</h4>
						<div class="left_box_dash_rank"
							style="width: 413px; height: 276px; padding: 10px 0;">
							<ul>
								<li class="tagetBox"
									style="width: 400px; margin-left: 10px;">
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
					<div class="chart_center" style="margin-left: 5px;">
						<h4 style="color: #FF7F00; margin-top: 16px; margin-bottom: 5px;">검출 현황</h4>
						<div class="chart_box" style="width: 992px; height: 607px; background: #fff;">
						  <div class="date" style="float: right;">
				   		   <select class="" id="days">
					        <option value="days">7일 전</option>
					        <option value="month">1개월 전</option>
					        <option value="three_month">3개월 전</option>
					        <option value="six_month">6개월 전</option>
					        <option value="year" selected>1년 전</option>
					       </select>
					       <input type="hidden" id="tree_id" value="">
						  </div>
					      <div id="main_graph" style="margin-top: 30px; height: 565px; width: 990px;"></div>
							<script type="text/javascript">
							<!-- 첫번째 개인정보 유형 그래프 -->
							function resizeGraph_One(result, status, ansyn) {
								
								console.log(result);
								
								var regdate = [];
								var type1 = [];
								var type2 = [];
								var type3 = [];
								var type4 = [];
								var type5 = [];
								var type6 = [];
								var type7 = [];
								var type8 = [];
								var days = [];
								
								 for(var i = 0; i < result.length; i++){
									days.push(result[i].DAYS);
									type1.push(result[i].TYPE1);
									type2.push(result[i].TYPE2);
									type3.push(result[i].TYPE3);
									type4.push(result[i].TYPE4);
									type5.push(result[i].TYPE5);
									type6.push(result[i].TYPE6);
									type7.push(result[i].TYPE7);
									type8.push(result[i].TYPE8);
								} 
								
								var echartPie = echarts.init(document.getElementById('main_graph'));
								echartPie.setOption({
									// 제목
									title : {
										text : '개인정보 유형',
										subtext : '리스트',
										textStyle : {
											fontFamily: 'NotoSansR',
											fontSize : '13px',
											color : '#5d4fff'
										},
										show : false
									},
									tooltip : {
										trigger : 'axis',
										axisPointer : {
											type : 'shadow'
										}
									},
									grid: {
								        left: '4%',
								        containLabel: true
								    },
									// 상단 옵션 데이터 종류
									legend : {
										data : [ '주민등록번호', '외국인등록번호', '여권번호', '운전면허번호', '계좌번호', '카드번호', '이메일', '휴대폰번호'],
										color : ['#DC143C', '#006EB6', '#DC143C', '#30a1ce', '#FF8C00', '#66FF66', '#ff99ff'],
									},
									// 가로
									xAxis : [ {
										type : 'category',
										data : days
									} ],
									// 세로
									yAxis : [ {
										type : 'value',
										axisLable : {
											textStyle : {
												fontSize : 8
											}
										}
										
									} ],
									series : [ {
										name : '주민등록번호',
										type : 'bar',
										color: '#DC143C',
										data : type1
									}, {
										name : '외국인등록번호',
										type : 'bar',
										data : type2
									}, {
										name : '여권번호',
										type : 'bar',
										color: '#006EB6',
										data : type3
									}, {
										name : '운전면허번호',
										type : 'bar',
										data : type4
									}, {
										name : '계좌번호',
										type : 'bar',
										color:'#FF8C00',
										data : type5
									}, {
										name : '카드번호',
										type : 'bar',
										color:'#30a1ce',
					
										data : type6
									}, {
										name : '이메일',
										type : 'bar',
										color:'#66FF66',
					
										data : type7
									}, {
										name : '휴대폰번호',
										type : 'bar',
										color:'#ff99ff',
					
										data : type8
									}
									],
									// 상단 차트종류 옵션 버튼
									toolbox : {
										show : true,
										bottom: 15,
										right: 60,
										textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: '13px'
										},
										feature : {
											dataView : {
												show : true,
												readOnly : false,
												title : '데이터',
												optionToContent: function(opt) {
				                                    var axisData = opt.xAxis[0].data;
				                                    var series = opt.series;
				                                    var table = '<div class="list_sch" style="top: 0px">' 
				                                        		 +'<div class="sch_area"><button type="button" name="button" class="btn_down" style="margin:4px;" onclick="btnDownload();">다운로드</button></div></div>'
				                                    			 + '<table id="chartdata" style="width:100%;text-align:center"><tbody><tr>'
				                                                 + '<td>날짜</td>'
				                                                 + '<td>' + series[0].name + '</td>'
				                                                 + '<td>' + series[1].name + '</td>'
				                                                 + '<td>' + series[2].name + '</td>'
				                                                 + '<td>' + series[3].name + '</td>'
				                                                 + '<td>' + series[4].name + '</td>'
				                                                 + '<td>' + series[5].name + '</td>'
				                                                 + '<td>' + series[6].name + '</td>'
				                                                 + '<td>' + series[7].name + '</td>'
				                                                 + '</tr>';
				                                    for (var i = 0, l = axisData.length; i < l; i++) {
				                                        table += '<tr>'
				                                                 + '<td>' + axisData[i] + '</td>'
				                                                 + '<td>' + series[0].data[i] + '</td>'
				                                                 + '<td>' + series[1].data[i] + '</td>'
				                                                 + '<td>' + series[2].data[i] + '</td>'
				                                                 + '<td>' + series[3].data[i] + '</td>'
				                                                 + '<td>' + series[4].data[i] + '</td>'
				                                                 + '<td>' + series[5].data[i] + '</td>'
				                                                 + '<td>' + series[6].data[i] + '</td>'
				                                                 + '<td>' + series[7].data[i] + '</td>'
				                                                 + '</tr>';
				                                    }
				                                    table += '</tbody></table>';
				                                    return table;
				                                },
				                                contentToOption: function () {
				                                  console.log(arguments);
				                                }
											},
											magicType : {
												show : true,
												title: {
										          line: '선형차트',
										          bar: '막대차트',
												},
												type : [ 'line', 'bar' ],
											}, 
											restore : {
												show : true,
												title : '복원'
											},
											saveAsImage : {
												show : true,
												title : '이미지로저장',
												leng : ['저장']
											},
											
										}
									},
								});
							}
						</script>
					    </div>
					</div>
					<div class="clear_l"></div>
				</div>
			<div class="clear"></div>
		</div>
		</section>
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
	<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript">
var id = null;
$(function() {
	   
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
			'plugins' : ["search"],
		})
		.bind('loaded.jstree', function(event, data) {
			var target_id = data.instance._model.data;
			var targetList = [];
			for(i in target_id){
				if(target_id[i].parent != null){
					targetList.push(target_id[i].id);
				}
			};
			fn_drawrankGrid(data);
		})
	    .bind('select_node.jstree', function(evt, data, x) {
	    	console.log(data);
	    	var id = data.node.id;
	    	var connected = data.node.original.connected;
	    	
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
	    	
	    	var type = data.node.data.type;
	    	var ap = data.node.data.ap;
	    	var postData = {
	    			target_id: id,
                	days : $("#days").val()
            }
	    	//$('#jstree').jstree(true).refresh();
	    	if(type == 1){
	    		console.log(data);
	    	
	    		$.ajax({
	    			type: "POST",
	    			url: "/pi_datatype_manager",
	    			async : false,
	    			data : postData,
	    			dataType : "json",
	    		    success: resizeGraph_One,
	    		    error: function (request, status, error) {
	    				alert("fail");
	    		        console.log("ERROR : ", error);
	    		    }
	    		});
	    		$("#days").on("change", function(){
	    			var postData = {
	    				days : $("#days").val(),
	    				target_id : id,
	    				user_no : '${memberInfo.USER_NO}'
	    			};
	    			
	    			$.ajax({
	    				type: "POST",
	    				url: "/pi_datatype_manager",
	    				async : false,
	    				data : postData,
	    				dataType : "json",
	    			    success: resizeGraph_One,
	    			    error: function (request, status, error) {
	    					alert("fail");
	    			        console.log("ERROR : ", error);
	    			    }
	    			});
	    		});
	    		
	    	}
	    	
	    });
});
function btnDownload(){
	exportTableToCsv("chartdata", "data");
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
	$.ajax({
		type: "POST",
		url: "/pi_systemcurrent_manager",
		////async : false,
		data: postData,
		dataType : "json",
	    success: circleGraph,
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
	
	$("#days").on("change", function(){
		var postData = {
			days : $("#days").val(),
			target_id : id,
			user_no : '${memberInfo.USER_NO}'
		};
		
		$.ajax({
			type: "POST",
			url: "/pi_datatype_manager",
			async : false,
			data : postData,
			dataType : "json",
		    success: resizeGraph_One,
		    error: function (request, status, error) {
				alert("fail");
		        console.log("ERROR : ", error);
		    }
		});
	});
	
	var postData = {
		days : $("#days").val(),
		user_no : '${memberInfo.USER_NO}'
	};
	
	
	$.ajax({
		type: "POST",
		url: "/pi_datatype_manager",
		async : false,
		data : postData,
		dataType : "json",
	    success: resizeGraph_One,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	
	/*
	$.ajax({
		type: "POST",
		url: "/pi_datatypes",
		async : false,
		data : "",
		dataType : "json",
	    success: function(data) {
	    	console.log(data); 
			datatype(data.RRN, "rrn");
			datatype(data.FOREIGNER, "foreigner");
			datatype(data.DRIVER, "driver");
			datatype(data.PASSPORT, "passport");
			datatype(data.ACCOUNT_NUM, "account_num");
			datatype(data.CARD_NUM, "card_num"); 
			datatype(data.PHONE, "phone"); 
			datatype(data.CARNUM, "carnum"); 
			datatype(data.VEHICLEID, "vehicleid"); 
		},
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	*/
	
	/*
	$.ajax({
		type: "POST",
		url: "/selectWebLink",
		////async : false,
		data : "",
		dataType : "json",
	    success: function(data) {
	    	console.log(data.RECON_LINK); 
			$("#webdate").html(data.RECON_LINK);
		},
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
	var postData = {
       	user_no : '${memberInfo.USER_NO}',
     	fromDate : $("#fromDate").val(),
     	toDate : $("#toDate").val()
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
    });
    
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
	*/
	
    $("#btnClose").click(function() {
    	$("#pcDetailPopup").hide();
    });
	
    $("#btnCanclePCDetailPopup").click(function() {
    	$("#pcDetailPopup").hide();
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
   	console.log(postData);
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

    var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
    $("#fromDate").val(getFormatDate(oFromDate));
}

/*
$("#btnApproval").on("click", function(e) {
	$.ajax({
		type: "POST",
		url: "/approvalTest",
		//async : false,
	    success: function (resultMap) {
	       console.log(resultMap);
	    },
	    error: function (request, status, error) {
			alert("인증번호 인증 실패하셨습니다. ");
	    }
	});
});
*/

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
	
	console.log(id);
	
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

function fn_drawrankGrid(data) {
	var gridWidth = $("#rankGrid").parent().width();
	
	var postData = {
			user_no : '${memberInfo.USER_NO}'
	};

	$("#rankGrid").jqGrid({
		url: "<%=request.getContextPath()%>/dash_personal_manager_rank",
		datatype: "json",
		postData: postData,
	   	mtype : "POST",
		colNames:['PC','검출파일수(컬럼수)','검출건수'],
		colModel: [
			{ index: 'SERVER', 	name: 'SERVER', 	width: 100, align: 'center'},
			{ index: 'FILE', 	name: 'FILE',  width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'COUNT', 	name: 'COUNT', width: 100, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' }
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 217,
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

</script>
</body>
</html>