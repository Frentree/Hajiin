<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>이행 관리</h3>
		<!-- content -->
		<div class="content magin_t25">
			<div class="location_area">
				<p class="location">리포트관리 > 이행 관리</p>
			</div>
            <div class="grid_top">
                <ul>
						<li style=" margin-bottom: 20px; width: 100%;" > 
							<div class="chart_box" style="height: 262px; background: #fff;">
								<!-- 대상별 조치 현황 -->							
								<div id=circle_left_graph style="height: 100%; width: 25%; float: left;"></div>
								<script type="text/javascript"> 
								<!-- 원그래프  -->
								function circle_left_graph(result, status, ansyn) {
									
									var total = [];
									var error = [];
									var searched = [];
									var wait = [];
									var complete = [];
									var scancomp = [];
									var pause = [];
									var notconnect = [];
									
									$.each(result, function(key, value){
									    $.each(value, function(key, value){
									        if(key == "TOTAL") total.push(value);
									        if(key == "ERROR") error.push(value);
									        if(key == "SEARCHED") searched.push(value);
									        if(key == "WAIT") wait.push(value);
									        if(key == "COMPLETE") complete.push(value);
									        if(key == "SCANCOMP") scancomp.push(value);
									        if(key == "PAUSE") pause.push(value);
									        if(key == "NOTCONNECT") notconnect.push(value);
									        
									    });
									});
								
									var echartdoughnut = echarts.init(document.getElementById('circle_left_graph'));
									echartdoughnut.setOption({
										title : {
									        text: '대상별 조치 현황',
									        x:'center',
									        textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 12
											}
									    },
									    tooltip : {
									        trigger: 'item',
									        formatter: "{a} <br/>{b} : {c} ({d}%)"
									    }, 
									    legend: {
									        left: 'center',
									        bottom: 10,
									        data:['결과없음','미검색', '검출']
									    },
										textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: 10
										},
									    series : [
									        {
									            name: '시스템현황',
									            type: 'pie',
									            radius : ['45%', '70%'],
									            color : ['#015E0C', '#FF8C00', '#DC143C'],
									            center: '50%',
									            data:[
									                //{value:error, name:'오류'},
									                //{value:searched, name:'검색중'},
									                {value:wait, name:'미검색'},
									                {value:complete, name:'결과없음'},
									                //{value:pause, name:'일시정지'},
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
									/* var totalDiv;
									totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 50%; top:50%; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
									totalDiv += '<h2>미접속수 : ' + notconnect + '</h2>';
									totalDiv += '<h1>총 대상수 : ' + total + '</h1></div>'; 
									
									$("#circle_left_graph").append(totalDiv);*/
								}
								</script>
								
								<!-- 경로별 조치 현황 -->
								<div id=circle_center_graph style="height: 100%; width: 25%; float: left;"></div>
								<script type="text/javascript">
								<!-- 원그래프  -->
								function circle_center_graph(result, status, ansyn) {
									
									var nonepath = [];
									var delpath = [];
									var exception = [];
									
									$.each(result, function(key, value){
									    $.each(value, function(key, value){
									        if(key == "NONEPATH") nonepath.push(value);
									        if(key == "DELPATH") delpath.push(value);
									        if(key == "EXCEPTION") exception.push(value);
									        
									    });
									});
								
									var echartdoughnut = echarts.init(document.getElementById('circle_center_graph'));
									echartdoughnut.setOption({
										title : {
									        text: '경로별 조치 현황',
									        x:'center',
									        textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 14
											}
									    },
									    tooltip : {
									        trigger: 'item',
									        formatter: "{a} <br/>{b} : {c} ({d}%)"
									    }, 
									    legend: {
									        left: 'center',
									        bottom: 10,
									        data:['미조치', '삭제', '예외처리']
									    },
										textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: 10
										},
									    series : [
									        {
									            name: '시스템현황',
									            type: 'pie',
									            radius : ['45%', '70%'],
									            color : ['#898796', '#006EB6', '#015E0C'],
									            center: '50%',
									            data:[
									                {value:nonepath, name:'미조치'},
									                {value:delpath, name:'삭제'},
									                {value:exception, name:'예외처리'},
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
									/*var totalDiv;
									totalDiv = "<div id='spanid' style='display:inline-block; position:absolute; left: 50%; top:50%; transform: translateX(-50%) translateY(-50%); text-align:center;'>";
									 totalDiv += '<h2>미접속수 : ' + notconnect + '</h2>';
									totalDiv += '<h1>총 대상수 : ' + total + '</h1></div>'; 
									
									$("#circle_center_graph").append(totalDiv);*/
								}
								</script>
								
								<!-- 팀별 미처리 현황 -->
								<div id="bar_graph_left" style="height: 100%; width: 25%; float: left;"></div>
								<script type="text/javascript">
								<!-- 바 그래프  -->
								function bar_graph_left(result, status, ansyn) {
									//var total = ['1000','981','587','371','260','157','104','83','32','1'];
									var total_pre = [];
									var total_gap = [];
									//var name = ["기획부","시스템부","디지털금융부","프렌트리","경영정보부","보안부","경제유통팀","디지털서비스팀","디지털관리팀","보안운영팀"];
									var total = []
									var name = []
									/* $.each(result, function(key, value){
									    $.each(value, function(key, value){
									    	if(key == "TOTAL") total.push(value);
									    	if(key == "TOTAL_PRE") total_pre.push(value);
									        if(key == "TOTAL_GAP") total_gap.push(value);
									        if(key == "NAME") name.push(value);
									    });
									    
									}); */
									
									result.forEach(function(item, index){
										name.push(item.TEAM_NAME)
										total.push(item.NOTCOMCNT)
									});
									
									total.reverse();
									//total_pre.reverse();
									name.reverse();
									
									var echartbar = echarts.init(document.getElementById('bar_graph_left'));
									echartbar.setOption({
									 title: {
									        text: '팀별 미처리 현황',
									        x:'center',
									        textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 14
											}
									    },
									    tooltip: {
									    	
									        trigger: 'axis',
									        axisPointer: {
									            type: 'shadow'
									        }
									    },
									 	// 상단 옵션 데이터 종류
										/* legend : {
											left: '27%',
											data : [ '마지막 검색결과', '이전 검색 결과'],
											
										}, */
									    grid: {
									        left: '3%',
									        right: '4%',
									        bottom: '3%',
									        containLabel: true
									    },
									    textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: 10
										},
									    xAxis: {
									        type: 'value',
									        boundaryGap: [0, 0.01]
									    },
									    yAxis: {
									        type: 'category',
									        data: name
									    },
									    series: [
									        {
									            name: '미처리',
									            type: 'bar',
									            color :'#dc143c', 
									            data: total
									        }
									    ]
									});
								}
								</script>
								
								<!-- 담당자별 미처리 현황 -->
								<div id="bar_graph_right" style="height: 100%; width: 25%; float: left;"></div>
								<script type="text/javascript">
								<!-- 바 그래프  -->
								function bar_graph_right(result, status, ansyn) {
									var total = []
									var name = []
									result.forEach(function(item, index){
										console.log(item)
										name.push(item.USER_NAME)
										total.push(item.NOTCOMCNT)
									});
									
									total.reverse();
									name.reverse();
									
									var echartbar = echarts.init(document.getElementById('bar_graph_right'));
									echartbar.setOption({
									 title: {
									        text: '담당자별 미처리 현황',
									        x:'center',
									        textStyle: {
												fontFamily: 'NotoSansR',
												fontSize: 14
											}
									    },
									    tooltip: {
									        trigger: 'axis',
									        axisPointer: {
									            type: 'shadow'
									        }
									    },
									 	// 상단 옵션 데이터 종류
										/* legend : {
											left: '27%',
											data : [ '마지막 검색결과', '이전 검색 결과'],
											
										}, */
									    grid: {
									        left: '3%',
									        right: '4%',
									        bottom: '3%',
									        containLabel: true
									    },
									    textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: 10
										},
									    xAxis: {
									        type: 'value',
									        boundaryGap: [0, 0.01]
									    },
									    yAxis: {
									        type: 'category',
									        data: name
									    },
									    series: [
									        {
									            name: '미처리',
									            type: 'bar',
									            color: '#006eb6',
									            data: total
									        }
									    ]
									});
								}
								</script>
							</div>  
						</li>
					</ul>
                <!-- <div class="list_sch">
                    <div class="sch_area">
                        <input type="radio" name="ra_new" class="ra_new" id="ra_new" value="0" checked>내부</button>
                        <input type="radio" name="ra_new" class="ra_new" id="ra_new" style="margin-left: 10px;" value="1">DMZ</button>
                        <button type="button" name="button" class="btn_new" id="btnSearch" style="margin-left: 30px;">Search</button>
                        <button type="button" name="button" class="btn_new" id="btnDownloadExel">다운로드</button>
                        <button type="button" name="button" class="btn_new" id="btnDownloadMonthlyExcel">월간 보고서 다운로드</button>
                    </div>
                </div> -->
                <div class="list_sch" style="top:380px;">
               		<div class="sch_area">
               			<button type="button" name="button" class="btn_down" id="btnDownloadExel">다운로드</button>
               		</div>
                </div>
                <table class="user_info narrowTable" style="width: 76.9%;">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <!-- <th style="text-align: center; background-color: #d6e4ed; width:4vw; font-size:.85vw">업무구분</th>
                            <td style="width:7vw;">
                                <select id="selectList" name="selectList" style="width:6.5vw;">
                                    <option value="/report/pi_report_summary" selected>통합 보고서</option>
                                    <option value="/report/pi_report_exception">예외/오탐수용 보고서</option>
                                </select>
                            </td> -->
                            <th style="text-align: center; width: 7%;">호스트</th>
                            <td style="width:25%">
                            	<input type="text" style="width: 9.7vw; padding-left: 5px;" size="10" id="SCH_TARGET" placeholder="호스트명을 입력하세요">
                            </td>
                            <th style="text-align: center;">팀명</th>
                            <td style="width:21%;">
                                <select id="SCH_OFFICE_CODE" name="SCH_OFFICE_CODE" style="width:9.7vw;">
                                    <option value="" selected>전체</option>
                                    <c:forEach items="${accountOfficeList}" var="accountOfficeList">
                                    	<option value="${accountOfficeList.OFFICE_CODE}">${accountOfficeList.OFFICE_NM}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <th style="text-align: center; width: 7%;">담당자</th>
                            <td style="width:21%">
                            	<input type="text" style="width:7.7vw;" size="10" id="SCH_OWNER_NM" placeholder="" readonly="readonly" disabled>
                            	<input type="text" style="display:none;" id="SCH_OWNER" value="">
                            	<button type="button" class="btn_down" id="btnUserSelectPopup" style="font-size : 0.6vw; font-weight:0 ; margin-bottom: 0px; padding:0; width:20% !important; height:30px !important">Find</button>
                            	<button type="button" class="btn_down" id="btnUserSelectClear" style="font-size : 0.6vw; font-weight:0 ; margin-bottom: 0px; padding:0; width:20% !important; height:30px !important">Clr</button>
                            </td>
                           	<td rowspan="3" style="width: 2%;">
                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
                           	</td>
                        </tr>
                        <tr>
                        	<th style="text-align: center; width: 7%;">처리구분</th>
                            <td style="width:10vw">
                            	<select id="SCH_PROCESSING_FLAG" name="SCH_PROCESSING_FLAG" style="width:9.7vw;">
                                    <option value="" selected>전체</option>
                                    <c:forEach items="${dataProcessingFlagList}" var="dataProcessingFlagList">
                                    	<option value="${dataProcessingFlagList.PROCESSING_FLAG}">${dataProcessingFlagList.PROCESSING_FLAG_NAME}</option>
                                    </c:forEach>
                                    <option value="-1">미처리</option>
                                </select>
                            </td>
                            <th style="text-align: center;">경로명</th>
                            <td>
                            	<input type="text" style="width: 9.7vw; padding-left: 5px;" size="20" id="SCH_PATH" placeholder="경로명을 입력하세요">
                            </td>
                            
                            <!-- <th style="text-align: center; background-color: #d6e4ed; width:5.5vw">문서생성일</th>		문구 변경 및 조건변경 요청: 문서생성일->기안일. 쿼리 조회조건도 수정 (프렌트리 전준현K 2019.10.15)-->
                            <!-- <th style="text-align: center; background-color: #d6e4ed; min-width:6vw; width:6.5vw">
                            	기안일&nbsp;<input type="checkbox" id="SCH_D_P_C_G_REGDATE_CHK" checked="checked">
                            </th>
                            <td style="width:15.5vw;">
                            	<input type="date" id="SCH_FROM_CREDATE" style="text-align:center; width:8.5vw;" readonly="readonly">
                            	<input type="date" id="SCH_FROM_D_P_C_G_REGDATE" style="text-align:center; width:45%;" readonly="readonly">
                            	<span style="width: 10%; margin-right: 3px; color: #000;">~</span>
                                <input type="date" id="SCH_TO_CREDATE" style="text-align:center; width:8.5vw;" readonly="readonly">
                                <input type="date" id="SCH_TO_D_P_C_G_REGDATE" style="text-align:center; width:45%;" readonly="readonly">
                            </td> -->
                        </tr>
                        <tr>
                        	<!-- <th style="text-align: center; background-color: #d6e4ed; width:5.5vw">문서저장일</th>			문구 변경 요청: 문서저장일->검출일. (프렌트리 전준현K 2019.10.15) -->
                            <th style="text-align: center; width: 7%;">검출일</th>
                            <td colspan="2" style="width:15.5vw;">
                                <!-- <input type="date" id="SCH_FROM_REGDATE" style="text-align:center; width:8.5vw;" readonly="readonly"> -->
                                <input type="date" id="SCH_FROM_CREDATE" style="text-align:center; width:9.7vw;" readonly="readonly">
                                <span style="width: 10%; margin-right: 3px; color: #000;">~</span>
                                <!-- <input type="date" id="SCH_TO_REGDATE" style="text-align:center; width:8.5vw;" readonly="readonly"> -->
                                <input type="date" id="SCH_TO_CREDATE" style="text-align:center; width:9.7vw;" readonly="readonly">
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
			<!-- <div class="left_box2" style="overflow: hidden; max-height: 632px; height: 632px;"> -->
			<div class="left_box2" style="overflow: hidden; max-height: 325px; height: 325px; margin-top: 10px">
				<table id="targetGrid" style="width:100%"></table>
				<div id="targetGridPager"></div>
			</div>
		</div>
	</div>
	
	
	<!-- 담당자 지정 popup -->
    <div id="ownerList" class="popup_box" style="width: auto; height: auto; z-index: 9999; display: none;">
        <div class="popup_content">
            <div class="content-box" style="width: auto; height: auto;">
                <table id="ownerGrid"></table>
            </div>
        </div>
    </div>
	<!-- 팝업창 종료 -->
	
	<!-- 담당자 지정 popup -->
	<div id="userSelect" class="popup_layer" style="display:none;">
	    <div class="popup_box" style="height: 200px;">
	        <div class="popup_top">
	            <h1>담당자 지정</h1>
	        </div>
	        <div class="popup_content">
	            <div class="content-box" style="height: 450px;">
	                <table id="userGrid"></table>
	                <div id="userGridPager"></div>
	            </div>
	        </div>
	        <div class="popup_btn">
	            <div class="btn_area">
	                <button type="button" id="btnUserSelect">선택</button>
	                <button type="button" id="btnUserCancel">취소</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- 팝업창 종료 -->
</section>
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript">
// var postData = {target_id : $("#hostSelect").val()};
// var gridWidth = $("#targetGrid").parent().width();
var oGrid = $("#targetGrid");

$(document).ready(function () {
    // 날짜 설정
    setSelectDate();
    
    // SelectList를 선택하면 선택된 화면으로 이동한다.
    $("#selectList").change(function () {
        location.href = $("#selectList").val();
    });

    $("#btnDownloadExel").on("click", function(){
    	downLoadExcel();
    });
    
    $("#btnDownloadMonthlyExcel").on("click", function(){
    	$('#monthlyReportPopup').show();
    });
    
    $("#btnDownloadMonthly").on("click", function(){
    	downLoadMonthlyReports();
    });

    $("#btnCancelMonthly").on("click", function(){
    	$('#monthlyReportPopup').hide();
    });
    
    $("#btnSearch").on("click", function(){
    	fn_search();
    });
	
    
    // 기안일 checkbox check event
    $("#SCH_D_P_C_G_REGDATE_CHK").change(function() {
    	if($(this).is(":checked") == true) {
    		// 달력 활성
    		$("#SCH_FROM_D_P_C_G_REGDATE").datepicker('enable');
    		$("#SCH_TO_D_P_C_G_REGDATE").datepicker('enable');
    		$("#SCH_FROM_D_P_C_G_REGDATE").css({'background-color':'#FFFFFF'});
    		$("#SCH_TO_D_P_C_G_REGDATE").css({'background-color':'#FFFFFF'});
    	} else {
    		// 달력 비활성
    		$("#SCH_FROM_D_P_C_G_REGDATE").datepicker('disable');
    		$("#SCH_TO_D_P_C_G_REGDATE").datepicker('disable');
    		$("#SCH_FROM_D_P_C_G_REGDATE").css({'background-color':'#F0F0F0'});
    		$("#SCH_TO_D_P_C_G_REGDATE").css({'background-color':'#F0F0F0'});
    	}
    });
    
	// 조회조건 - 담당자 Find button click event
    $("#btnUserSelectPopup").click(function(e) {

        $("#userSelect").show();

        if ($("#userGrid").width() == 0) {
            $("#userGrid").jqGrid({
                url: "${getContextPath}/detection/selectTeamMember",
                datatype: "json",
                data: JSON.stringify({ type: "change" }),
                contentType: 'application/json; charset=UTF-8',

                mtype : "POST",
                ajaxGridOptions : {
                    type    : "POST",
                    async   : true
                },
                colNames:['팀명','담당자','직책', '사번'],
                colModel: [
                	{ index: 'OFFICE_NM',   name: 'OFFICE_NM',  width: 180, align: 'center' },
                	{ index: 'USER_NAME',   name: 'USER_NAME',  width: 180, align: 'center' },
                    { index: 'JIKGUK',      name: 'JIKGUK',     width: 180, align: 'center' },
                    { index: 'USER_NO',     name: 'USER_NO',    width: 180, align: 'center', hidden: true }
                ],
                id: "USER_NO",
                loadonce:true,
                viewrecords: true,
                width: 600,
                height: 280,
                autowidth: true,
                shrinkToFit: true,
                loadonce: true,
                rownumbers : false,
                rownumWidth : 75,   
                rowNum:25,
                rowList:[25,50,100],
                pager: "#userGridPager",
                onSelectRow : function(rowid,celname,value,iRow,iCol) { 
                },
                afterEditCell: function(rowid, cellname, value, iRow, iCol){
                },
                afterSaveCell : function(rowid,name,val,iRow,ICol){
                },
                afterSaveRow : function(rowid,name,val,iRow,ICol){
                },
                ondblClickRow: function(rowid,iRow,iCol) {
                    var user_name = $(this).getCell(rowid, 'USER_NAME'); 
                    var jikguk = $(this).getCell(rowid, 'JIKGUK'); 
                    var user_no = $(this).getCell(rowid, 'USER_NO');
                    
                    $("#SCH_OWNER").val(user_no);
                    $("#SCH_OWNER_NM").val(user_name + " " + jikguk);
                    
                    $("#userSelect").hide();
                },
                loadComplete: function(data) {
                },
                gridComplete : function() {
                }
            }).filterToolbar({
                  autosearch: true,
                  stringResult: true,
                  searchOnEnter: true,
                  defaultSearch: "cn"
            }); 

            $("#userGridPager_left").css("width", "10px");
            $("#userGridPager_right").css("display", "none");
        }
        else {
            $("#userGrid").setGridParam({
                url:"${getContextPath}/detection/selectTeamMember", 
                datatype:"json"
            }).trigger("reloadGrid");
        }
    });
    
    // 담당자 지정 popup - 선택 button click event
    $("#btnUserSelect").on("click", function(e) {
        var rowid = $("#userGrid").getGridParam("selrow");
        if(rowid == "" || rowid == null || rowid == "undefined" || rowid < 0) {
        	alert("담당자를 선택하십시오");
        	return false;
        }
        
        var user_name = $("#userGrid").getCell(rowid, 'USER_NAME'); 
        var jikguk = $("#userGrid").getCell(rowid, 'JIKGUK'); 
        var user_no = $("#userGrid").getCell(rowid, 'USER_NO');
		
        $("#SCH_OWNER").val(user_no);
        $("#SCH_OWNER_NM").val(user_name + " " + jikguk);
        
        $("#userSelect").hide();
    });
    
	// 담당자 지정 popup - 취소 button click event
    $("#btnUserCancel").on("click", function(e) {
        $("#SCH_OWNER").val('');
        $("#SCH_OWNER_NM").val('');
        $("#userSelect").hide();
    });
	
    // 조회조건 - Clear button click event
    $("#btnUserSelectClear").on("click", function(e) {
        $("#SCH_OWNER").val('');
        $("#SCH_OWNER_NM").val('');
    });
    loadJqGrid();
    var postData = {}
    $.ajax({
		type: "POST",
		url: "${getContextPath}/pi_systemcurrent",
		async : false,
		data : postData,
		dataType : "json",
	    success: circle_left_graph,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
    $.ajax({
		type: "POST",
		url: "${getContextPath}/pi_pathcurrent",
		async : false,
		data : postData,
		dataType : "json",
	    success: circle_center_graph,
	    error: function (request, status, error) {
			alert("fail");
	        console.log("ERROR : ", error);
	    }
	});
	$.ajax({
		type: "POST",
		url: "/report/teamNotCom",
		async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph_left,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	$.ajax({
		type: "POST",
		url: "/report/personNotCom",
		async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph_right,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});
	var ownerWidth = document.body.offsetWidth * 0.15;
	var ownerHeight = document.body.offsetHeight * 0.15;
	
	$("#ownerGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['팀명', '담당자 명'],
		colModel: [
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 200 },
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 200 },
		],
		id: "USER_NO",
		loadonce:true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: ownerWidth,
		height: ownerHeight,
		loadonce: true, // this is just for the demo
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 75, // 행번호 열의 너비	
		rowNum:25,
	   	rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	});
});

function loadJqGrid()
{
	var oPostDt = {};
	oPostDt["owner"]    = $("#schOwner").val();
	oPostDt["filename"] = $("#schFilename").val();
	oPostDt["fromDate"] = $("#fromDate").val();
	oPostDt["toDate"]   = $("#toDate").val();
	
	oGrid.jqGrid({
		//url: "${getContextPath}/report/searchSummaryList",
		datatype: "json",
	   	mtype : "POST",
	   	postData: oPostDt, 
	   	contentType:"application/x-www-form-urlencoded; charset=utf-8",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true 
		},
		colNames:['GROUP_ID',	'TARGET_ID',			'HASH_ID',	'ACCOUNT',	'OS',		'호스트',		'경로',		'코멘트',		'팀명',		'사번'
				 ,'담당자명',		'주민번호',				'외국인번호',	'여권번호',	'운전번호',	'계좌번호',	'카드번호',	'전화번호',	'휴대폰번호',	'총개수'
				 ,'검출일',		'삭제일',					'기안일',		'기안자NO',	'기안자',		'결재일',		'결재자NO',	'결재자',		'결재 상태',	'개인정보 여부(정탐 오탐) 코드',	
				 '점검 결과',		'메모내용(문서 메모내용)',		'처리구분'	,	'조치예정일',	'OWNER_CNT'],
		colModel: [
			
			{ index: 'GROUP_ID',				name: 'GROUP_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'TARGET_ID',				name: 'TARGET_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'HASH_ID',					name: 'HASH_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT',					name: 'ACCOUNT',				width: 100,		align: 'left',	hidden:true},
			{ index: 'PLATFORM',				name: 'PLATFORM',				width: 110,		align: 'left'},
			{ index: 'TARGET_NAME',				name: 'TARGET_NAME',			width: 140,		align: 'left'},
			{ index: 'PATH',					name: 'PATH',					width: 400,		align: 'left'},
			{ index: 'COMMENTS',				name: 'COMMENTS',				width: 400,		align: 'left',	hidden:true},
			{ index: 'OFFICE_NM',				name: 'OFFICE_NM',				width: 130,		align: 'center'},
			{ index: 'USER_ID',					name: 'USER_ID',				width: 100,		align: 'left',	hidden:true},
			
			{ index: 'USER_NM',					name: 'USER_NM',				width: 80,		align: 'center'},
			{ index: 'TYPE1',					name: 'TYPE1',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE2',					name: 'TYPE2',					width: 80,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE3',					name: 'TYPE3',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE4',					name: 'TYPE4',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE5',					name: 'TYPE5',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE6',					name: 'TYPE6',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE7',					name: 'TYPE7',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE8',					name: 'TYPE8',					width: 70,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			{ index: 'TYPE',					name: 'TYPE',					width: 90,		formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, align: 'right', sorttype: 'number' },
			
			{ index: 'CREDATE',					name: 'CREDATE',				width: 170,		align: 'center'},
			{ index: 'DELDATE',					name: 'DELDATE',				width: 170,		align: 'center'},
			{ index: 'D_P_C_G_REGDATE',			name: 'D_P_C_G_REGDATE',		width: 170,		align: 'center',	hidden:true},
			{ index: 'ACCOUNT_USER_NO',			name: 'ACCOUNT_USER_NO',		width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT_USER_NM',			name: 'ACCOUNT_USER_NM',		width: 80,		align: 'center',	hidden:true},
			{ index: 'OKDATE',					name: 'OKDATE',					width: 170,		align: 'center',	hidden:true},
			{ index: 'OKUSER_NO',				name: 'OKUSER_NO',				width: 100,		align: 'left',	hidden:true},
			{ index: 'OK_ACCOUNT_USER_NM',		name: 'OK_ACCOUNT_USER_NM',		width: 80,		align: 'center',	hidden:true},
			{ index: 'APPROVAL_REGULT',			name: 'APPROVAL_REGULT',		width: 80,		align: 'center'},
			{ index: 'PROCESSING_FLAG',			name: 'PROCESSING_FLAG',		width: 100,		align: 'left',	hidden:true},
			
			{ index: 'PROCESSING_FLAG_TYPE',	name: 'PROCESSING_FLAG_TYPE',	width: 75,		align: 'center', hidden: true },
			{ index: 'D_P_C_G_REASON',			name: 'D_P_C_G_REASON',			width: 200,		align: 'left', hidden: true },
			{ index: 'PROCESSING_FLAG_NAME',	name: 'PROCESSING_FLAG_NAME',	width: 100,		align: 'center'},
			{ index: 'D_P_G_NEXT_DATE_REMEDI',	name: 'D_P_G_NEXT_DATE_REMEDI',	width: 170,		align: 'center', hidden: true},
			{ index: 'OWNER_CNT',				name: 'OWNER_CNT',				width: 170,		align: 'center', hidden: true}
		],
		
		loadonce :true,
		viewrecords: false, // show the current page, data rang and total records on the toolbar
		width: 600,
		height: 230,
		loadonce: true, // this is just for the demo
		autowidth: true,
		shrinkToFit: false,
		pager: "#targetGridPager",
		rownumbers : true, // 행번호 표시여부
		rownumWidth : 60, // 행번호 열의 너비	
		rowNum:100,
		rowList:[100,200,500,1000],
		jsonReader : {
			id : "ID"
		},
		gridComplete: function(){
			$('[aria-describedby=targetGrid_USER_NM]').mouseover(function(e) {
				var rowid = $(this).parent().attr('id')
				var cnt = $('#targetGrid').getCell(rowid, 'OWNER_CNT')
				if(cnt > 1){
					var postData = {target : $('#targetGrid').getCell(rowid, 'TARGET_ID')};
					$("#ownerGrid").clearGridData();
					$("#ownerGrid").setGridParam({url:"/report/selectOwnerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
					var name = $('#targetGrid').getCell(rowid, 'USER_NM')
					var target_id = $('#targetGrid').getCell(rowid, 'TARGET_ID')
					//console.log($('#targetGrid').getCell(rowid, 'USER_NM'));
					var width = e.pageX + ($('#ownerList').width()/2) + 200
					var height = e.pageY + ($('#ownerList').height()) + 40
					$('#ownerList').css({
						"top": height,
						"left": width,
						"position": "absolute"
					})
					$('#ownerList').show();
				} else {
					$('#ownerList').hide();
				}
			})
			$('[aria-describedby=targetGrid_USER_NM]').mouseleave(function(e) {
				$('#ownerList').mouseleave(function(e){
					$('#ownerList').hide();
				})
			})
			$('[aria-describedby=targetGrid_OFFICE_NM]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE1]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE2]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE3]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE4]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE5]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE6]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE7]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE8]').mouseover(function(e) {
				$('#ownerList').hide();
			})
			$('[aria-describedby=targetGrid_TYPE]').mouseover(function(e) {
				$('#ownerList').hide();
			})
		}
	});
}


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
        fileName :  "통합_보고서_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

//문서 기안일
function setSelectDate() 
{
	$("#SCH_FROM_CREDATE").datepicker({
	    changeYear : true,
	    changeMonth : true,
	    dateFormat: 'yy-mm-dd'
	});
	
	$("#SCH_TO_CREDATE").datepicker({
	    changeYear : true,
	    changeMonth : true,
	    dateFormat: 'yy-mm-dd'
	});
	
	$("#SCH_FROM_D_P_C_G_REGDATE").datepicker({
	    changeYear : true,
	    changeMonth : true,
	    dateFormat: 'yy-mm-dd'
	});
	
	$("#SCH_TO_D_P_C_G_REGDATE").datepicker({
	    changeYear : true,
	    changeMonth : true,
	    dateFormat: 'yy-mm-dd'
	});
	
	var oToday = new Date();
	$("#SCH_TO_CREDATE").val(getFormatDate(oToday));
	$("#SCH_TO_D_P_C_G_REGDATE").val(getFormatDate(oToday));
	
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 92));
	$("#SCH_FROM_CREDATE").val(getFormatDate(oFromDate));
	oToday = new Date();
	oFromDate = new Date(oToday.setDate(oToday.getDate() - 92));
	$("#SCH_FROM_D_P_C_G_REGDATE").val(getFormatDate(oFromDate));
}

//검색
function fn_search() 
{
	// 정탐/오탐 리스트 그리드
	var oPostDt = {};
	oPostDt["SCH_TARGET"]				= $("#SCH_TARGET").val();
	oPostDt["SCH_PATH"]					= $("#SCH_PATH").val();
	oPostDt["SCH_FROM_CREDATE"]			= $("#SCH_FROM_CREDATE").val();
	oPostDt["SCH_TO_CREDATE"]			= $("#SCH_TO_CREDATE").val();
	
	oPostDt["SCH_OFFICE_CODE"]			= $("#SCH_OFFICE_CODE").val();
	oPostDt["SCH_OWNER"]				= $("#SCH_OWNER").val();
	oPostDt["SCH_PROCESSING_FLAG"]		= $("#SCH_PROCESSING_FLAG").val();
	oPostDt["SCH_FROM_D_P_C_G_REGDATE"]	= $("#SCH_FROM_D_P_C_G_REGDATE").val();
	oPostDt["SCH_TO_D_P_C_G_REGDATE"]	= $("#SCH_TO_D_P_C_G_REGDATE").val();
	oPostDt["SCH_DMZ_SELECT"]   			= "0";
	oPostDt["SCH_D_P_C_G_REGDATE_CHK"]	= "N";		// 조회조건 기안일 사용여부
	
	oGrid.clearGridData();
	oGrid.setGridParam({
	    url: "${getContextPath}/report/searchSummaryList",
	    postData: oPostDt,
	    datatype: "json"
	}).trigger("reloadGrid");
}

//
function getFormatDate(oDate)
{
	var nYear = oDate.getFullYear();           // yyyy 
	var nMonth = (1 + oDate.getMonth());       // M 
	nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 
	
	var nDay = oDate.getDate();                // d 
	nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장
	
	return nYear + '-' + nMonth + '-' + nDay;
}

function downLoadMonthlyReports(){
	
	var oPostDt = {};
	oPostDt["year"] = $("#monthly_year").val();
	oPostDt["month"] = $("#monthly_month").val();
	
	var jsonData = JSON.stringify(oPostDt);
	
	$.ajax({
		type: "POST",
		url: "${getContextPath}/report/getMonthlyReport",
		async: false,
		data: jsonData,
		datatype: "json",
		contentType: "application/json; charset=UTF-8",
		success: function (result){
			//console.log(result);
			executeDownload(result);
		},
		error: function (request, status, error) {
			alert('데이터가 없습니다.');
		}
	});
	$('#monthlyReportPopup').hide();
}

function executeDownload(resultList){
	var result = "호스트,검출경로 수,주민번호,외국인번호,여권번호,";
		result += "운전면허,계좌번호,카드번호,전화번호,합계,";
		result += "정탐(삭제),정탐(암호화),정탐(마스킹),정탐(기타),정탐(임시보관),";
		result += "오탐(예외처리),오탐(오탐수용),오탐(기타),조치 예정,미조치\r\n";

	$.each(resultList, function(i, item){
		result += item.NAME + "," + item.PATH + "," + item.RRN + "," + item.FOREIGNER + "," + item.PASSPORT + ",";
		result += item.DRIVER + "," + item.ACCOUNT + "," + item.CARD + "," + item.PHONE + "," + item.TOTAL + ",";
		result += item.DEL + "," + item.ENCODING + "," + item.MASKING + "," + item.CONFIRM_ETC + "," + item.TEMP_STOR + ",";
		result += item.EXCEPTION + "," + item.FALSE_AGREE + "," + item.FALSE_ETC + "," + item.ACT + "," + item.ACT_NOT + "\r\n";
	});
	
	var mm = $("#monthly_month").val();
	var yyyy = $("#monthly_year").val();
	
	if(mm<10) {
		mm='0'+mm;
	}
	
	today = yyyy + "" + mm;
	
	var blob = new Blob(["\ufeff"+result], {type: "text/csv;charset=utf-8" });
	if(navigator.msSaveBlob){
		window.navigator.msSaveOrOpenBlob(blob, "월간리포트_" + today + ".csv");
	} else {
		var downloadLink = document.createElement("a");
		var url = URL.createObjectURL(blob);
		downloadLink.href = url;
		downloadLink.download = "월간리포트_" + today + ".csv";
		
		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	}
}

</script>

</body>
</html>
