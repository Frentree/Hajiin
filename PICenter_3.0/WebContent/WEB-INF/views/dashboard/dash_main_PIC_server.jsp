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
.ui-jqgrid .ui-jqgrid-hdiv{
	border: 1px solid #c8ced3;
}
.ui-widget.ui-widget-content{
	border: none;
}
#todo_result_list, #todo_result_approval, #todo_result_schedule{
	font-size: 20px;
	text-align: right;
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
				<c:set var="serverCnt" value="${fn:length(aList)}"/>
				<div class="left_area">
					<div class="sch_target_box" style="margin-top: 55px; display: none;">
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
					<div class="date_area" style="display: none;">
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
					</div>
					<h4 style="position: relative; color: #FF7F00; padding-bottom: 5px;">자산 현황</h4>
<!-- 					<h4 style="position: relative; color: #FF7F00; padding-bottom: 5px;"> SKT 자산 리스트</h4> -->
					<div class="left_box" style="height:606px; width: 351px;">
						<div id="jstree" class="left_box" style="height:593px; width: 329px; padding: 0; border: none;">
						</div>
					</div>
				</div>
				 
				<!-- chart area -->
				<div class="top_area_left" style="margin-left: 0;">
					<div style="margin-top: 31px; padding-bottom: 5px;">
						<h4 style="display: inline;">나의 할일</h4>
						<p style="position: absolute; top: 34px; left: 90px; font-size: 14px; color: #4A4A4A; font-family:NotoSansKR-Light">
							나의 할일을 통해 업무 프로세스를 진행하시기 바랍니다.
						</p>
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
						    				<input type="hidden" id="notice_detail" value="${list.NOTICE_ID}">
						    			</td>
						    			<td id="notice_date" style="font-size: 12px; text-align: right;">${list.REGDATE}</td>
						    		</tr>
						    	</table>
					    	</c:forEach>
				</div>
				<div class="chart_area">
					<div class="chart_left" style="margin-left: 20px;">
						<h4 style="position: relative; color: #FF7F00; margin-top: 13px; margin-bottom: 5px;">검출현황 요약</h4>
						<div class="left_box" style="width: 466px; height: 607px; margin-top: 2px; margin-right: 5px;">
							<ul>  
								<li style="width:455px; padding: 0;" > 
									<div class="chart_box" style="height: 560px; padding: 0; border: none; background: #fff;">
										<div id=circleGraph style="height: 100%; width: 455px; float: left;"></div>
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
											            center: ['50%', '45%'],
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
											totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 228px; top: 255px; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
											totalDiv += '<h4 style="margin: 0;" class="circle_cnt" >총 대상수 <br> ' + total[0] + '</h4></div>';
											$("#circleGraph").append(totalDiv);
										}
										</script>
									</div>
								</li>
							</ul>
						</div>
					</div>
					<div class="chart_center" style="margin-left: 27px;">
						<h4 style="color: #FF7F00; margin-top: 13px; margin-bottom: 5px;">개인정보 보유 순위</h4>
						<div class="left_box_dash_rank" style="width: 468px; height: 607px; padding: 7px 0;">
							<ul>
							  <li class="tagetBox" style="height: 590px; margin-left: 10px; padding-right: 10px;">
							    <div class="grid_top" style="float: right;">
									<div class="left_box2" style="overflow: hidden; max-height: 600px;">
					   					<table id="rankGrid"></table>
					   				</div>
								</div>
						      </li>
							</ul>
						</div>
					</div>
					<div class="chart_right">
						<h4 style="color: #FF7F00; margin-top: 13px; margin-bottom: 5px;">검출 현황</h4>
						<div class="left_box_dash_detection" style="width: 400px; height: 180px;">
							<ul>
							  <li class="tagetBox" style="margin-left: 5px; width: 388px;">
							    <div class="chart_box" style="background: #fff; border: 0 none;">
							      <table id="rrn_tbl" class="squareBox">
							    		<tr>
							    			<td>전체 검출 파일수</td>
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
							    			<td>전체 검출 테이블 수</td>
							    			<td style="text-align: right;">0</td>
							    		</tr>
							    	</table>
							    </div>
						     </li>
						    </ul>
				    	</div>
						<h4 style="color: #FF7F00; margin-top: 44px;">조치 완료 현황</h4>
					     <div class="left_box_dash_complete" style="width: 400px; height: 180px;">
				    		<ul>
				    		 <li class="tagetBox" style="margin-left: 5px; width: 388px;">
							    <div class="chart_box" style="background: #fff; border: 0 none;">
							      <table id="rrn_tbl" class="squareBox">
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
							    			<td>삭제 파일수</td>
							    			<td id="del_tbl" style="text-align: right;"></td>
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
					<div class="clear_l"></div>
				</div>
			<div class="clear"></div>
		</div>
		</section>
	<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript">

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
			$.ajax({
    			type: "POST",
    			url: "/dash_personal_server_detectionItemList",
    			////async : false,
    			data: {
    				targetList: targetList
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
    				targetList: targetList
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
			
			fn_drawrankGrid(data);
        })
	    .bind('select_node.jstree', function(evt, data, x) {
	    	var id = data.node.id;
	    	var type = data.node.data.type;
	    	var ap = data.node.data.ap;
	    	//$('#jstree').jstree(true).refresh();
	    	if(type == 1){
	    		console.log(ap + ", " + id);
	    		$.ajax({
	    			type: "POST",
	    			url: "/dash_dataDetectionItemList",
	    			////async : false,
	    			data: {
	    				target_id: id
	    			},
	    			dataType: "json",
	    		    success: function (resultMap) {
	    		    	$("#total_tbl").html(resultMap.PATCH_CNT);
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
					data: {
	    				target_id: id
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
		url: "/pi_systemcurrent_service",
		////async : false,
		data: postData,
		dataType : "json",
	    success: circleGraph,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	
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
	    	console.log(data.RECON_LINK); 
			$("#webdate").html(data.RECON_LINK);
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
	
	var postData = {
       	user_no : '${memberInfo.USER_NO}',
     	fromDate : $("#fromDate").val(),
     	toDate : $("#toDate").val()
    }
	
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
	
	$.ajax({
		type: "POST",
		url: "/dash_dataTodoSchedule",
		////async : false,
		data : postData,
		dataType: "json",
	    success: function (resultMap) {
	    	$("#todo_result_schedule").html(resultMap.SCHEDULE_TOTAL + "건");
	    	$("#todo_result_schedule").css("color", "#FFF");
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
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



function fn_drawrankGrid(data) {
	var gridWidth = $("#rankGrid").parent().width();
	var target_id = data.instance._model.data;
	var targetList = [];
	for(i in target_id){
		if(target_id[i].parent != null){
			targetList.push(target_id[i].id);
		}
	};
	
	var postData = {
		targetList: JSON.stringify(targetList)
	};

	$("#rankGrid").jqGrid({
		url: "<%=request.getContextPath()%>/dash_personal_server_rank",
		datatype: "json",
		postData: postData,
	   	mtype : "POST",
		colNames:['서버','검출파일수(컬럼수)','검출건수'],
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
		height: 550,
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
	       console.log(resultMap);
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
    	var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, left=0, top=0, resizable=no, location=no"; 	
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