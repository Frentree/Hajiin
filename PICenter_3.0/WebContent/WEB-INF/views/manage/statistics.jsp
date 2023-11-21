<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/anychart/anychart-base.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/anychart/anychart-exports.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/anychart/anychart-ui.min.js"></script>
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/anychart-font.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/anychart-ui.min.css" />
<style>
	.wrap{
	  height: 180%;
	}
	#chart_top_div {
	  width: 100%;
	  height: 600px;
	}
	#chart_bottom_div {
	  width: 100%;
	  height: 600px;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		.ui-jqgrid-hdiv{
			width: 854px !important;
		}
 		.container{
 			width: 1900px !important;
 			height: 1880px !important;
 		}
 		.container_header{
 			width: 1900px !important;
 		}
 		.footer_area{
 			width: 1900px !important;
 		}
	}
	
	.inputHidden{
		border:none;
		border-right:0px; 
		border-top:0px; 
		boder-left:0px; 
		boder-bottom:0px;
	}
	
	.ui-th-ltr, .ui-jqgrid .ui-jqgrid-htable th.ui-th-ltr {
	    border-right: 1px solid #ddd;
	    border-bottom: 1px solid #ddd;
	}
</style>

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container" style="height: 1873px;">
			<!-- <div class="location_area">
				<p class="location">결과관리 > 보고서</p>
			</div> -->
			<h3>보고서</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>

				<!-- content -->
				<div class="content magin_t25" style="height: 1781px;">
					<!-- <div class="location_area">
						<p class="location">스캔관리 > 스캔 스케줄 등록</p>
					</div> -->
					<table class="user_info approvalTh" style="width: 27%; min-width: 240px; margin-bottom: 10px;">
							<caption>사용자정보</caption>
							<tbody>
								<tr>
									<th style="text-align: center; padding: 10px 3px; width: 15%; border-radius: 0.25rem;">검색기간</th>
									<td style="width: 22.3vw;">
										<input type="date" id="fromDate" style="text-align: center;  width:175px;" readonly="readonly" value="${fromDate}" >
										<span style="width: 10%; margin-right: 3px; color: #000">~</span>
										<input type="date" id="toDate" style="text-align: center;  width:175px;" readonly="readonly" value="${toDate}" >
										<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-top: 7px;">
									</td>
								</tr>
							</tbody>
						</table>
						<div class="content_left">
							<h3 style="display:inline; padding: 0;" id="titleTotal"></h3>
							<!-- 183대 서버(약2만개 파일, 49억 건)내 개인정보 정탐 확인 -->
							<div class="left_box" style="height:681px; width:100%; margin-top: 10px;">
								<ul>
									<li style="list-style:none; font-size: 12px;" class="totalStatistics"></li>
								</ul>
								<div id="chart_top_div"></div>
								<p style="font-weight:bold; text-align: center;" id="total_detection"></p>
								<!-- [ 862대(Swing, Swing 외) 서버 검출 결과('20.02월~11월까지) ] -->
							</div>
						</div>
						<div class="grid_top" style="float: right;">
							<h3 style="padding: 0;">TOP5 (전체서비스)</h3>
							<div class="left_box2" style="width: 863px !important; overflow: hidden;">
			   					<table id="topNGrid"></table>
			   				</div>
						</div>
						<div class="grid_top" style="float: right; margin: 23px 0;">
							<h3 style="padding: 0;">TOP5 (정탐 기준 - 운영서버)</h3>
							<div class="left_box2" style="width: 863px !important; overflow: hidden;">
			   					<table id="middleNGrid"></table>
			   				</div>
						</div>
						<div class="grid_top" style="float: right;">
							<h3 style="padding: 0;">TOP5 (정탐 기준 - 개발서버)</h3>
							<div class="left_box2" style="width: 863px !important; overflow: hidden;">
			   					<table id="bottomNGrid"></table>
			   				</div>
						</div>
					 <div class="grid_top" style="width: 100%; float: right; margin: 10px 0;">
						<h3 style="padding: 0;">전체 서버 점검 결과(의심 건수)</h3>
						<div class="left_box2" style="height: 265px; overflow: hidden;">
		   					<table id="totalNGrid"></table>
		   				</div>
					</div> 
					<div class="chart_box" style="width: 100%; height: 345px; margin: 10px 0; background: #fff;">
							<div id=bar_graph_left style="height: 100%; width: 50%; float: left;"></div>
								<script type="text/javascript">
								<!-- 바 그래프  -->
								function bar_graph_left(result, status, ansyn) {
									
									var total = [];
									var search = [];
									var succeed = [];
									var month = [];
									
									$.each(result, function(key, value){
									    $.each(value, function(key, value){
									    	if(key == "TOTAL") total.push(value);
									    	if(key == "SEARCH") search.push(value);
									    	if(key == "SUCCEED") succeed.push(value);
									        if(key == "MONTH") month.push(value);
									        
									    });
									    
									});
									
									var echartbar = echarts.init(document.getElementById('bar_graph_left'));
									echartbar.setOption({
									    tooltip: {
									        trigger: 'axis',
									        axisPointer: {
									            type: 'shadow'
									        }
									    },
									 	// 상단 옵션 데이터 종류
									    legend : {
											bottom: 10,
											data : [ '검색 서버', '검출 서버'],
										},
									    textStyle: {
											fontFamily: 'NotoSansR',
											fontSize: 14
										},
										xAxis: {
									    	type: 'category',
									        data: month,
									        axisLabel: {
									        	interval: 0
									        }
									    },
									    yAxis: {
									        type: 'value',
									        boundaryGap: [0, 0.01]
									    },
									    series: [
									        {
									        	name: '검색 서버',
									            type: 'bar',
									            barWidth: 30,
									            color: '#006eb6',
									            data: search,
									            itemStyle: {
									                normal: {
									                    label: {
									                        show: true,
									                        position: 'top',
									                        color: '#000'
									                    }
									                }
									            }
									        },
									        {
									        	name: '검출 서버',
									            type: 'bar',
									            barWidth: 30,
									            color :'#dc143c', 
									            data: succeed,
									            itemStyle: {
									                normal: {
									                    label: {
									                        show: true,
									                        position: 'top',
									                        color: '#000'
									                    }
									                }
									            }
									        }
									    ]
									});
								}
								</script>
								<div id="chart_bottom_div" style="height: 100%; width: 50%; float: right;"></div>
					</div>
					<div class="grid_top" style="width: 100%; bottom: 238px; float: right;">
						<h3 style="padding: 0;">이행점검 현황</h3>
						<div class="left_box2" style="height: 235px; overflow: hidden;">
		   					<table id="lowestNGrid"></table>
		   				</div>
					</div>
					  
				</div>
					
			</div>

			<!-- container -->
		</section>
		<!-- section -->
		
<%@ include file="../../include/footer.jsp"%>

<!-- 팝업창 - 상세정보 시작 -->
<div id="statisticsPopup" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px;  touch-action: none; width: 500px; z-index: 101; box-shadow: 0 2px 5px #ddd; display:none;">
	<div class="progress_container">
	<img class="CancleImg" id="btnCancleStatisticsPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="progress_top">
				<h1>상세 보기</h1>
		</div>
		<div class="popup_content" style="height: 100px;">
				<div class="content-box" style="width: 478px; !important; height: 103px; background: #fff; border: 1px solid #c8ced3; border-bottom: none; padding: 5px;">
					<table class="popup_tbl" style="border-top: 0px;">
						<colgroup>
							<col width="21%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>검출 개인정보 수</th>
								<td>
									<input type="text" style="width: 295px; padding-left: 5px;" size="10" id="total" class="inputHidden">
								</td>
							</tr>
						</tbody>
					</table>
					<table class="popup_tbl">
						<colgroup>
							<col width="30%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th >검출 개인정보 상세 건수</th>
								<td id="datatype_area"></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="content-table" style="width: 478px; !important; height: 200px; background: #fff; border: 1px solid #c8ced3; border-top: none;">
					<table class="popup_tbl" style="border-top : none;">
					<colgroup>
							<col width="50%">
							<col width="*">
						</colgroup>
						<tbody id="details_detail">
						</tbody>
					</table>
				</div> 
			</div>
		<button id="btnstatisticsClose" style="margin-top: 5px; margin-left : 424px;" >닫기</button>
	</div>
</div>

<script type="text/javascript">
anychart.onDocumentReady(function () {
    var chart_bottom = null ;
    
    var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();

	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate
	};
	
	var chart_top = null ;
    $.ajax({
		type: "POST",
		url: "/statistics/totalStatistics",
		async : false,
		data : postData,
		dataType : "json",
	    success: function(resultMap){
	    	
	    	if(resultMap.TARGET_ID == null){
	    		$('#chart_top_div').append("<div class='totalStatistics-box'>정탐으로 결재 완료된 내용이 없기 때문에 표시할 내용이 없습니다.</div>");
	    	}
	    	chart_top = anychart.pie3d([
            {x: '주민등록번호', value: resultMap.TYPE1},
            {x: '외국인등록번호', value: resultMap.TYPE2},
            {x: '여권번호', value: resultMap.TYPE3},
            {x: '운전면허번호', value: resultMap.TYPE4},
	    	{x: '신용카드번호', value: resultMap.TYPE5},
            {x: '계좌번호', value: resultMap.TYPE6},
            {x: '이메일', value: resultMap.TYPE7},
            {x: '핸드폰번호', value: resultMap.TYPE8},
            ])
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        console.log("ERROR : ", request);
	        console.log("ERROR : ", status);
	    }
	});
	
/* 	var chart_top = anychart.pie3d([
	     {x: '신용카드번호', value: 100000000},
	     {x: '운전면허번호', value: 0},
	     {x: '외국인등록번호', value: 0},
	     {x: '계좌번호', value: 0},
	     {x: '이메일번호', value: 260000000},
	     {x: '주민번호', value: 0},
	     {x: '여권번호', value: 140000000},
	     {x: '핸드폰번호', value: 4400000000},
	   ]); */
		
	   chart_top.palette(['#F0620A', '#11088D', '#FBCD1F', '68A62F', '#6F037F', '#CC0F2E', '#0297A2', '#0570AB'])
	chart_top.legend(false);
	
	chart_top.labels().position("outside");
	chart_top.connectorLength("65");
	chart_top.labels().fontSize(14);
	chart_top.labels().hAlign("center");
	chart_top.labels().useHtml(true);
	chart_top.labels().format("<b>{%x}<br/></b>" + "{%PercentValue}{decimalsCount:1}%");
	chart_top.container('chart_top_div');
	chart_top.draw();
	
	
	
	var chart_bottom = null ;
    $.ajax({
		type: "POST",
		url: "/statistics/manageList",
		async : false,
		data : postData,
		dataType : "json",
	    success: function(resultMap){
	    	
	    	var count = Object.keys(resultMap).length;
	    	
	    	if(resultMap != ""){
	    		chart_bottom = anychart.pie3d([
	                {x: '주민등록번호', value: resultMap[count-1].RRN},
	                {x: '핸드폰번호', value: resultMap[count-1].MOBILE_PHONE},
	                {x: '계좌번호', value: resultMap[count-1].ACCOUNT_NUM},
	    	    	{x: '신용카드번호', value: resultMap[count-1].CARD_NUM},
	                {x: '외국인등록번호', value: resultMap[count-1].FOREIGNER},
	                {x: '운전면허번호', value: resultMap[count-1].DRIVER},
	                {x: '이메일번호', value: resultMap[count-1].EMAIL},
	                {x: '여권번호', value: resultMap[count-1].PASSPORT},
	                ])
	    	}else{
	    		chart_bottom = anychart.pie3d([
	                {x: '주민등록번호', value: 0},
	                {x: '핸드폰번호', value: 0},
	                {x: '계좌번호', value: 0},
	    	    	{x: '신용카드번호', value: 0},
	                {x: '외국인등록번호', value: 0},
	                {x: '운전면허번호', value: 0},
	                {x: '이메일번호', value: 0},
	                {x: '여권번호', value: 0},
	                ])
	    	}
	    	
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        console.log("ERROR : ", request);
	        console.log("ERROR : ", status);
	    }
	});  
    
     
/*   	 var chart_bottom = anychart.pie3d([
    	{x: '신용카드번호', value: 3000000},
        {x: '운전면허번호', value: 0},
        {x: '외국인등록번호', value: 0},
        {x: '계좌번호', value: 0},
        {x: '이메일번호', value: 39000000},
        {x: '주민번호', value: 0},
        {x: '여권번호', value: 0},
        {x: '핸드폰번호', value: 58000000},
    ]);  */
    
    chart_bottom.palette(['#F0620A', '#0570AB', '#CC0F2E', '#6F037F', '#11088D', '#68A62F', '#0297A2', '#FBCD1F']);
    chart_bottom.legend(false);
    
    chart_bottom.labels().position("outside");
    chart_bottom.connectorLength("65");
    chart_bottom.labels().fontSize(14);
    chart_bottom.labels().hAlign("center");
    chart_bottom.labels().useHtml(true);
    chart_bottom.labels().format("<b>{%x}<br/></b>" + "{%PercentValue}{decimalsCount:1}%");
    chart_bottom.container('chart_bottom_div');
    chart_bottom.draw(); 
});

$(document).ready(function () {
	
	fn_drawTopNGrid();
	fn_drawMiddleNGrid();
	fn_drawBottomNGrid();
	fn_drawTotalNGrid();
	fn_lowestNGrid();
	$("#gbox_totalNGrid .ui-jqgrid-hbox").css("height","65px");
	$(".anychart-credits-text").css("padding", "0");
	$(".anychart-credits-text").css("font-size", "10px");
	
	// 전체 서버 점검 결과(의심건수)
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate
	};
	
	$.ajax({
		type: "POST",
		url: "/statistics/manageBarList",
		async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph_left,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        console.log("ERROR : ", request);
	        console.log("ERROR : ", status);
	    }
	}); 
	
	/* 
	var a1 = {"TOTAL": 157, "SEARCH": 146, "SUCCEED": 11, "MONTH": '2월' }
	var a2 = {"TOTAL": 239, "SEARCH": 152, "SUCCEED": 87, "MONTH": '3월' }
	var a3 = {"TOTAL": 237, "SEARCH": 183, "SUCCEED": 54, "MONTH": '4월' }
	var a4 = {"TOTAL": 290, "SEARCH": 232, "SUCCEED": 58, "MONTH": '5월' }
	var a5 = {"TOTAL": 310, "SEARCH": 253, "SUCCEED": 57, "MONTH": '6월' } 
	
	var result_left_bar = []
	result_left_bar.push(a1)
	result_left_bar.push(a2)
	result_left_bar.push(a3)
	result_left_bar.push(a4) 
	
	bar_graph_left(result_left_bar, 'success', '');  */
	$.ajax({
		type: "POST",
		url: "/statistics/totalStatistics",
		async : false,
		data: postData,
		dataType: "json",
		success: function (resultMap) {
	    	
	    	$(".totalStatistics").html("");
	    	$("#total_detection").html("");
	    	$("#titleTotal").html("");
	    	
			var content = "";
				    	
			content += " 주민등록번호: " + resultMap.TYPE1.toLocaleString('ko-KR') + "(" + resultMap.TYPE1_PERCENTAGE + ")";
			content += " 외국인등록번호: " + resultMap.TYPE2.toLocaleString('ko-KR') + "(" + resultMap.TYPE2_PERCENTAGE + ")";
			content += " 여권번호: " + resultMap.TYPE3.toLocaleString('ko-KR') + "(" + resultMap.TYPE3_PERCENTAGE + ")";
			content += " 운전면허번호: " + resultMap.TYPE4.toLocaleString('ko-KR') + "(" + resultMap.TYPE4_PERCENTAGE + ")<br>";
			content += " 신용카드번호: " + resultMap.TYPE5.toLocaleString('ko-KR') + "(" + resultMap.TYPE5_PERCENTAGE + ")";
			content += " 계좌번호: " + resultMap.TYPE6.toLocaleString('ko-KR') + "(" + resultMap.TYPE6_PERCENTAGE + ")";
			content += " 이메일: " + resultMap.TYPE7.toLocaleString('ko-KR') + "(" + resultMap.TYPE7_PERCENTAGE + ")";
			content += " 핸드폰번호: " + resultMap.TYPE8.toLocaleString('ko-KR') + "(" + resultMap.TYPE8_PERCENTAGE + ")";
			
			$(".totalStatistics").append(content);
			
			var total_detection = "[" + resultMap.COUNT_TARGET_ID.toLocaleString('ko-KR') +"대 서버 검출 결과]";
	    	$("#total_detection").append(total_detection);
	    	
	    	var contentlist = resultMap.COUNT_TARGET_ID.toLocaleString('ko-KR') + "대 서버(약 "+ resultMap.COUNT_HASH_ID.toLocaleString('ko-KR') + "개 파일" 
	    		contentlist += resultMap.TOTAL.toLocaleString('ko-KR') +"건)내 개인정보 정탐 확인";
	    	$("#titleTotal").append(contentlist);
	    	
	    },error: function (request, status, error) {
	        console.log("request : ", request);
	        console.log("status : ", status);
	        console.log("ERROR : ", error);
	    }
	});
	
	setSelectDate(); 
	
	
	$("#btnstatisticsClose").click(function(){ 
		$("#statisticsPopup").hide();
	});
	
	$("#btnCancleStatisticsPopup").click(function(){ 
		$("#statisticsPopup").hide();
	});
	
	
});

function getFormatDate(oDate) {
	var nYear = oDate.getFullYear(); // yyyy 
	var nMonth = (1 + oDate.getMonth()); // M 
	nMonth = ('0' + nMonth).slice(-2); // month 두자리로 저장 

	var nDay = oDate.getDate(); // d 
	nDay = ('0' + nDay).slice(-2); // day 두자리로 저장

	return nYear + '-' + nMonth + '-' + nDay;
}

function setSelectDate() {
	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat : 'yy-mm-dd'
	});

	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat : 'yy-mm-dd'
	});

	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));

	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
}

function fn_drawTopNGrid() {
	var gridWidth = $("#topNGrid").parent().width();
	/* var temp = [
		{SERVICE: "COMOS", FILE: "1696396", COUNT: "1259025973", TYPE: "핸드폰 번호"},
		{SERVICE: "상담IVR", FILE: "51918", COUNT: "1079104965", TYPE: "핸드폰 번호, 이메일"},
		{SERVICE: "SMS/MMS GW", FILE: "8418", COUNT: "504893872", TYPE: "핸드폰 번호"},
		{SERVICE: "Bill Letter", FILE: "1592", COUNT: "290257216", TYPE: "핸드폰 번호"},
		{SERVICE: "TRBS", FILE: "77112", COUNT: "273036992", TYPE: "핸드폰 번호"}
	]; // 임시 데이터 */
	
	$("#topNGrid").jqGrid({
		datatype: "local",
	   	mtype : "POST",
	   	colNames:['서비스명', '호스트명', '검출 파일 수','검출 개인정보 수','검출 개인정보 유형',
			  '주민등록번호', '핸드폰 번호', '계좌번호', '카드번호', '운전면허', '이메일', '여권번호'],
		colModel: [
			{ index: 'SERVICE_NM', 			name: 'SERVICE_NM', 	width: 100, align: 'center' },
			{ index: 'NAME', 				name: 'NAME', 			width: 100, align: 'center' },
			{ index: 'PATH_CNT', 			name: 'PATH_CNT', 		width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TOTAL', 				name: 'TOTAL',  		width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TYPE', 				name: 'TYPE', 			width: 100, align: 'center' },
			{ index: 'RRN', 				name: 'RRN', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'MOBILE_PHONE', 		name: 'MOBILE_PHONE', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'ACCOUNT_NUM', 		name: 'ACCOUNT_NUM', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'CARD_NUM', 			name: 'CARD_NUM', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'DRIVER', 				name: 'DRIVER', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'EMAIL', 				name: 'EMAIL', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'PASSPORT', 			name: 'PASSPORT', 		width: 0, 	align: 'center', hidden:true}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 149,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onCellSelect : function(rowid,icol,cellcontent,e){
	  		console.log(e);
	  		
	  		var clickY = e.pageY;
	  		var clickX = e.pageX;
/* 	  		var clickY = window.event.clientY;
	  		var clickX = window.event.clientX; */
	  		
	  		$("#details_detail").html("");
	  		$("#rowid").val(rowid);
	  		
	  		var SERVICE_NM = $(this).getCell(rowid, 'SERVICE_NM');
	  		var NAME = $(this).getCell(rowid, 'NAME');
	  		var PATH_CNT = $(this).getCell(rowid, 'PATH_CNT');
	  		var TOTAL = $(this).getCell(rowid, 'TOTAL');
	  		var TYPE = $(this).getCell(rowid, 'TYPE');
	  		
	  		var RRN = $(this).getCell(rowid, 'RRN');
	  		var MOBILE_PHONE = $(this).getCell(rowid, 'MOBILE_PHONE');
	  		var ACCOUNT_NUM = $(this).getCell(rowid, 'ACCOUNT_NUM');
	  		var CARD_NUM = $(this).getCell(rowid, 'CARD_NUM');
	  		var DRIVER = $(this).getCell(rowid, 'DRIVER');
	  		var EMAIL = $(this).getCell(rowid, 'EMAIL');
	  		var PASSPORT = $(this).getCell(rowid, 'PASSPORT');
	  		
	  		PATH_CNT = Number(PATH_CNT).toLocaleString('ko-KR');
	  		TOTAL = Number(TOTAL).toLocaleString('ko-KR');
	  		
	  		RRN = Number(RRN).toLocaleString('ko-KR');
	  		MOBILE_PHONE = Number(MOBILE_PHONE).toLocaleString('ko-KR');
	  		ACCOUNT_NUM = Number(ACCOUNT_NUM).toLocaleString('ko-KR');
	  		CARD_NUM = Number(CARD_NUM).toLocaleString('ko-KR');
	  		DRIVER = Number(DRIVER).toLocaleString('ko-KR');
	  		EMAIL = Number(EMAIL).toLocaleString('ko-KR');
	  		PASSPORT = Number(PASSPORT).toLocaleString('ko-KR');
	  		
	  		$("#total").val(TOTAL);
	  		
	  		var content = null;
	  		var content_th = '<th style="text-align: left;">';
	  		
	  		if(RRN != 0) content += '<tr>' + content_th + '주민등록번호 </th><td>' + RRN + '</td></tr>';
	  		if(MOBILE_PHONE != 0) content += '<tr>' + content_th + '휴대폰번호 </th><td>' + MOBILE_PHONE + '</td></tr>';
	  		if(ACCOUNT_NUM != 0) content += '<tr>' + content_th + '계좌번호 </th><td>' + ACCOUNT_NUM + '</td></tr>';
	  		if(CARD_NUM != 0) content += '<tr>' + content_th + '신용카드 </th><td>' + CARD_NUM + '</td></tr>';
	  		if(DRIVER != 0) content += '<tr>' + content_th + '운전면허 </th><td>' + DRIVER + '</td></tr>';
	  		if(EMAIL != 0) content += '<tr>' + content_th + '이메일 </th><td>' + EMAIL + '</td></tr>';
	  		if(PASSPORT != 0) content += '<tr>' + content_th + '여권번호 </th><td>' + PASSPORT + '</td></tr>';
	  		
	  		$("#details_detail").append(content);

	  		if(clickX > 1350){
	  			if(clickX <= 1483){
		  			$("#statisticsPopup").css("left", "805px");
		  			$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX <= 1655){
	  				$("#statisticsPopup").css("left", "969px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else{
	  				$("#statisticsPopup").css("left", "1132px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  			
	  		}else if (clickX < 1350){
	  			if(clickX > 1146){
	  				$("#statisticsPopup").css("left", "1307px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX > 981){
	  				$("#statisticsPopup").css("left", "1144px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  		} 

			$("#statisticsPopup").show();
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
	
	
	// TOP5 전체서비스
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();

	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate
	};
	$("#topNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/statisticsList", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
}


function fn_drawMiddleNGrid() {
	var gridWidth = $("#middleNGrid").parent().width();
	/* 
	var temp = [
		{SERVICE: "상담IVR", FILE: "51913", COUNT: "1079104965", TYPE: "핸드폰 번호, 이메일"},
		{SERVICE: "SMS/MMS GW", FILE: "8418", COUNT: "504893872", TYPE: "핸드폰 번호"},
		{SERVICE: "Bill Letter", FILE: "1564", COUNT: "283985133", TYPE: "핸드폰 번호"},
		{SERVICE: "RS", FILE: "76801", COUNT: "269301613", TYPE: "핸드폰 번호"},
		{SERVICE: "TRBS", FILE: "31133", COUNT: "244518326", TYPE: "핸드폰 번호"}
	]; // 임시 데이터 */
	
	$("#middleNGrid").jqGrid({
		datatype: "local",
	/* 	data : temp, */
	   	mtype : "POST",
		colNames:['서비스명', '호스트명', '검출 파일 수','검출 개인정보 수','검출 개인정보 유형',
			  	  '주민등록번호', '핸드폰 번호', '계좌번호', '카드번호', '운전면허', '이메일', '여권번호'],
		colModel: [
			{ index: 'SERVICE', 		name: 'SERVICE', 	width: 100, align: 'center' },
			{ index: 'NAME', 			name: 'NAME', 	width: 100, align: 'center' },
			{ index: 'COUNT_HASH_ID', 	name: 'COUNT_HASH_ID', 	width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TOTAL', 			name: 'TOTAL',  width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TYPE', 			name: 'TYPE', width: 100, align: 'center' },
			{ index: 'RRN', 				name: 'RRN', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'MOBILE_PHONE', 		name: 'MOBILE_PHONE', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'ACCOUNT_NUM', 		name: 'ACCOUNT_NUM', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'CARD_NUM', 			name: 'CARD_NUM', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'DRIVER', 				name: 'DRIVER', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'EMAIL', 				name: 'EMAIL', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'PASSPORT', 			name: 'PASSPORT', 		width: 0, 	align: 'center', hidden:true}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 149,
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
	  	onCellSelect : function(rowid,icol,cellcontent,e){
	  		
	  		var clickY = e.pageY;
	  		var clickX = e.pageX;
	  		
	  		$("#details_detail").html("");
	  		$("#rowid").val(rowid);
	  		
	  		var SERVICE = $(this).getCell(rowid, 'SERVICE');
	  		var NAME = $(this).getCell(rowid, 'NAME');
	  		var COUNT_HASH_ID = $(this).getCell(rowid, 'COUNT_HASH_ID');
	  		var TOTAL = $(this).getCell(rowid, 'TOTAL');
	  		var TYPE = $(this).getCell(rowid, 'TYPE');
	  		
	  		var RRN = $(this).getCell(rowid, 'RRN');
	  		var MOBILE_PHONE = $(this).getCell(rowid, 'MOBILE_PHONE');
	  		var ACCOUNT_NUM = $(this).getCell(rowid, 'ACCOUNT_NUM');
	  		var CARD_NUM = $(this).getCell(rowid, 'CARD_NUM');
	  		var DRIVER = $(this).getCell(rowid, 'DRIVER');
	  		var EMAIL = $(this).getCell(rowid, 'EMAIL');
	  		var PASSPORT = $(this).getCell(rowid, 'PASSPORT');
	  		
	  		TOTAL = Number(TOTAL).toLocaleString('ko-KR');
	  		COUNT_HASH_ID = Number(COUNT_HASH_ID).toLocaleString('ko-KR');
	  		
	  		RRN = Number(RRN).toLocaleString('ko-KR');
	  		MOBILE_PHONE = Number(MOBILE_PHONE).toLocaleString('ko-KR');
	  		ACCOUNT_NUM = Number(ACCOUNT_NUM).toLocaleString('ko-KR');
	  		CARD_NUM = Number(CARD_NUM).toLocaleString('ko-KR');
	  		DRIVER = Number(DRIVER).toLocaleString('ko-KR');
	  		EMAIL = Number(EMAIL).toLocaleString('ko-KR');
	  		PASSPORT = Number(PASSPORT).toLocaleString('ko-KR');
	  		
			$("#total").val(TOTAL);

			var content = null;
	  		var content_th = '<th style="text-align: left;">';
	  		
	  		if(RRN != 0) content += '<tr>' + content_th + '주민등록번호 </th><td>' + RRN + '</td></tr>';
	  		if(MOBILE_PHONE != 0) content += '<tr>' + content_th + '휴대폰번호 </th><td>' + MOBILE_PHONE + '</td></tr>';
	  		if(ACCOUNT_NUM != 0) content += '<tr>' + content_th + '계좌번호 </th><td>' + ACCOUNT_NUM + '</td></tr>';
	  		if(CARD_NUM != 0) content += '<tr>' + content_th + '신용카드 </th><td>' + CARD_NUM + '</td></tr>';
	  		if(DRIVER != 0) content += '<tr>' + content_th + '운전면허 </th><td>' + DRIVER + '</td></tr>';
	  		if(EMAIL != 0) content += '<tr>' + content_th + '이메일 </th><td>' + EMAIL + '</td></tr>';
	  		if(PASSPORT != 0) content += '<tr>' + content_th + '여권번호 </th><td>' + PASSPORT + '</td></tr>';
	  		
	  		$("#details_detail").append(content);

	  		if(clickX > 1350){
	  			if(clickX <= 1483){
		  			$("#statisticsPopup").css("left", "805px");
		  			$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX <= 1655){
	  				$("#statisticsPopup").css("left", "969px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else{
	  				$("#statisticsPopup").css("left", "1132px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  			
	  		}else if (clickX < 1350){
	  			if(clickX > 1146){
	  				$("#statisticsPopup").css("left", "1307px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX > 981){
	  				$("#statisticsPopup").css("left", "1144px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  		} 

			$("#statisticsPopup").show();
	  		
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
	
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate,
			prod : 2
	}; 
	$("#middleNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/TOPGridList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
}

function fn_drawBottomNGrid() {
	var gridWidth = $("#bottomNGrid").parent().width();
	/* var temp = [
		{SERVICE: "COMOS", FILE: "1696396", COUNT: "1259025973", TYPE: "핸드폰 번호"},
		{SERVICE: "URT", FILE: "1034", COUNT: "55036463", TYPE: "핸드폰 번호"},
		{SERVICE: "스마트오퍼링", FILE: "8115", COUNT: "28457042", TYPE: "핸드폰 번호"},
		{SERVICE: "ICAS", FILE: "124", COUNT: "24440681", TYPE: "핸드폰 번호, 이메일"},
		{SERVICE: "이메일청구서", FILE: "268", COUNT: "12513190", TYPE: "핸드폰 번호, 계좌번호, 이메일"}
	]; // 임시 데이터 */
	
	$("#bottomNGrid").jqGrid({
		datatype: "local",
		/* data : temp, */
	   	mtype : "POST",
	   	colNames:['서비스명', '호스트명', '검출 파일 수','검출 개인정보 수','검출 개인정보 유형',
		  	 	  '주민등록번호', '핸드폰 번호', '계좌번호', '카드번호', '운전면허', '이메일', '여권번호'],
		colModel: [
			{ index: 'SERVICE', 		name: 'SERVICE', 	width: 100, align: 'center' },
			{ index: 'NAME', 			name: 'NAME', 	width: 100, align: 'center' },
			{ index: 'COUNT_HASH_ID', 	name: 'COUNT_HASH_ID', 	width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TOTAL', 			name: 'TOTAL',  width: 100, align: 'center', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TYPE', 			name: 'TYPE', width: 100, align: 'center' },
			{ index: 'RRN', 				name: 'RRN', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'MOBILE_PHONE', 		name: 'MOBILE_PHONE', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'ACCOUNT_NUM', 		name: 'ACCOUNT_NUM', 	width: 0, 	align: 'center', hidden:true},
			{ index: 'CARD_NUM', 			name: 'CARD_NUM', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'DRIVER', 				name: 'DRIVER', 		width: 0, 	align: 'center', hidden:true},
			{ index: 'EMAIL', 				name: 'EMAIL', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'PASSPORT', 			name: 'PASSPORT', 		width: 0, 	align: 'center', hidden:true}
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 149,
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
	  	onCellSelect : function(rowid,icol,cellcontent,e){
	  		
	  		var clickY = e.pageY;
	  		var clickX = e.pageX;
	  		
	  		$("#details_detail").html("");
	  		$("#rowid").val(rowid);
	  		
	  		var SERVICE = $(this).getCell(rowid, 'SERVICE');
	  		var NAME = $(this).getCell(rowid, 'NAME');
	  		var COUNT_HASH_ID = $(this).getCell(rowid, 'COUNT_HASH_ID');
	  		var TOTAL = $(this).getCell(rowid, 'TOTAL');
	  		var TYPE = $(this).getCell(rowid, 'TYPE');
	  		
	  		var RRN = $(this).getCell(rowid, 'RRN');
	  		var MOBILE_PHONE = $(this).getCell(rowid, 'MOBILE_PHONE');
	  		var ACCOUNT_NUM = $(this).getCell(rowid, 'ACCOUNT_NUM');
	  		var CARD_NUM = $(this).getCell(rowid, 'CARD_NUM');
	  		var DRIVER = $(this).getCell(rowid, 'DRIVER');
	  		var EMAIL = $(this).getCell(rowid, 'EMAIL');
	  		var PASSPORT = $(this).getCell(rowid, 'PASSPORT');
	  		
	  		TOTAL = Number(TOTAL).toLocaleString('ko-KR');
	  		COUNT_HASH_ID = Number(COUNT_HASH_ID).toLocaleString('ko-KR');
	  		
	  		RRN = Number(RRN).toLocaleString('ko-KR');
	  		MOBILE_PHONE = Number(MOBILE_PHONE).toLocaleString('ko-KR');
	  		ACCOUNT_NUM = Number(ACCOUNT_NUM).toLocaleString('ko-KR');
	  		CARD_NUM = Number(CARD_NUM).toLocaleString('ko-KR');
	  		DRIVER = Number(DRIVER).toLocaleString('ko-KR');
	  		EMAIL = Number(EMAIL).toLocaleString('ko-KR');
	  		PASSPORT = Number(PASSPORT).toLocaleString('ko-KR');
	  		
			$("#total").val(TOTAL);
	  		
	  		var content = null;
	  		var content_th = '<th style="text-align: left;">';
	  		
	  		if(RRN != 0) content += '<tr>' + content_th + '주민등록번호 </th><td>' + RRN + '</td></tr>';
	  		if(MOBILE_PHONE != 0) content += '<tr>' + content_th + '휴대폰번호 </th><td>' + MOBILE_PHONE + '</td></tr>';
	  		if(ACCOUNT_NUM != 0) content += '<tr>' + content_th + '계좌번호 </th><td>' + ACCOUNT_NUM + '</td></tr>';
	  		if(CARD_NUM != 0) content += '<tr>' + content_th + '신용카드 </th><td>' + CARD_NUM + '</td></tr>';
	  		if(DRIVER != 0) content += '<tr>' + content_th + '운전면허 </th><td>' + DRIVER + '</td></tr>';
	  		if(EMAIL != 0) content += '<tr>' + content_th + '이메일 </th><td>' + EMAIL + '</td></tr>';
	  		if(PASSPORT != 0) content += '<tr>' + content_th + '여권번호 </th><td>' + PASSPORT + '</td></tr>';
	  		
	  		$("#details_detail").append(content);
	  		
	  		if(clickX > 1350){
	  			if(clickX <= 1483){
		  			$("#statisticsPopup").css("left", "805px");
		  			$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX <= 1655){
	  				$("#statisticsPopup").css("left", "969px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else{
	  				$("#statisticsPopup").css("left", "1132px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  			
	  		}else if (clickX < 1350){
	  			if(clickX > 1146){
	  				$("#statisticsPopup").css("left", "1307px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}else if(clickX > 981){
	  				$("#statisticsPopup").css("left", "1144px");
	  				$("#statisticsPopup").css("top", clickY + "px");
	  			}
	  		} 

			$("#statisticsPopup").show();
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
	
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate,
			prod : 1
	}; 
	$("#bottomNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/TOPGridList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid");
}

function fn_drawTotalNGrid() {
	
	var gridWidth = $("#totalNGrid").parent().width();
	/* var temp = [
		{MONTH: "2월", SEARCH: "146", SUCCEED: "11", FILE: "8646", TYPE1: "99820", TYPE2: "21386999", TYPE3: "14199", TYPE4: "15907742", TYPE5: "21223", TYPE6: "32428", TYPE7: "7733756", TYPE8: "3372769", TOTAL: "48068936"},
		{MONTH: "3월", SEARCH: "152", SUCCEED: "87", FILE: "51171", TYPE1: "4171529", TYPE2: "571199789", TYPE3: "2579463", TYPE4: "12418932", TYPE5: "4399792", TYPE6: "103997", TYPE7: "30896340", TYPE8: "3526", TOTAL: "631773348"},
		{MONTH: "4월", SEARCH: "183", SUCCEED: "54", FILE: "319170", TYPE1: "57891", TYPE2: "1497324475", TYPE3: "52633", TYPE4: "6923365", TYPE5: "10705", TYPE6: "5405", TYPE7: "1797021076", TYPE8: "801799", TOTAL: "3309679321"},
		{MONTH: "5월", SEARCH: "232", SUCCEED: "58", FILE: "34250", TYPE1: "767272", TYPE2: "552525830", TYPE3: "2387942", TYPE4: "563880", TYPE5: "347831", TYPE6: "665", TYPE7: "191356148", TYPE8: "272186", TOTAL: "748224454"},
		{MONTH: "6월", SEARCH: "253", SUCCEED: "57", FILE: "1009163", TYPE1: "873226", TYPE2: "1555975756", TYPE3: "227210", TYPE4: "139001863", TYPE5: "558126", TYPE6: "3213", TYPE7: "770388809", TYPE8: "233234", TOTAL: "2468105373"},
		{MONTH: "합계", SEARCH: "966", SUCCEED: "267", FILE: "1422400", TYPE1: "5969738", TYPE2: "4198412849", TYPE3: "5261447", TYPE4: "174815782", TYPE5: "5337677", TYPE6: "145688", TYPE7: "2797396129", TYPE8: "4683514", TOTAL: "7205851432"},
	]; // 임시 데이터  */
	
	$("#totalNGrid").jqGrid({
		datatype: "local",
		/* data : temp,  */
	   	mtype : "POST",
		colNames:['월','검색 서버','검출 서버','개인정보 파일','주민등록번호','핸드폰','계좌번호','신용카드','외국인번호','운전면허','이메일','여권번호','Total',],
		colModel: [
			{ index: 'MONTH', 			name: 'MONTH', 			width: 50, align: 'center', formatter : MonthType},
			{ index: 'SEARCH', 			name: 'SEARCH', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'SUCCEED', 		name: 'SUCCEED',  		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'PATH_CNT', 		name: 'PATH_CNT', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'RRN', 			name: 'RRN', 			width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'MOBILE_PHONE', 	name: 'MOBILE_PHONE',	width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'ACCOUNT_NUM', 	name: 'ACCOUNT_NUM', 	width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'CARD_NUM', 		name: 'CARD_NUM', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'FOREIGNER', 		name: 'FOREIGNER', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'DRIVER', 			name: 'DRIVER', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'EMAIL', 			name: 'EMAIL', 			width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'PASSPORT', 		name: 'PASSPORT', 		width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' },
			{ index: 'TOTAL', 			name: 'TOTAL', 			width: 50, align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number' }
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 195,
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
			
			 // pie chart
			var count = data.length;
			 
			if(count > 0){
				$('#chart_bottom_div').html("");
				var chart_bottom = null ;
				 chart_bottom = anychart.pie3d([
		            {x: '주민등록번호', value: data[count-1].RRN},
		            {x: '핸드폰번호', value: data[count-1].MOBILE_PHONE},
		            {x: '계좌번호', value: data[count-1].ACCOUNT_NUM},
			    	{x: '신용카드번호', value: data[count-1].CARD_NUM},
		            {x: '외국인번호', value: data[count-1].FOREIGNER},
		            {x: '운전면허번호', value: data[count-1].DRIVER},
		            {x: '이메일번호', value: data[count-1].EMAIL},
		            {x: '여권번호', value: data[count-1].PASSPORT},
		        ]);   
				chart_bottom.palette(['#F0620A', '#0570AB', '#CC0F2E', '#6F037F', '#11088D', '#68A62F', '#0297A2', '#FBCD1F']);
				chart_bottom.legend(false);
				chart_bottom.labels().position("outside");
				chart_bottom.connectorLength("65");
				chart_bottom.labels().fontSize(14);
				chart_bottom.labels().hAlign("center");
				chart_bottom.labels().useHtml(true);
				chart_bottom.labels().format("<b>{%x}<br/></b>" + "{%PercentValue}{decimalsCount:1}%");
				chart_bottom.container('chart_bottom_div');
				chart_bottom.draw();
				
			} 
			 
	    },
	    gridComplete : function() {
	    }
	});

	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate
	}; 
	$("#totalNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/manageList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
	$("#totalNGrid").jqGrid('setGroupHeaders', {
		useColSpanStyle: true,
		
		groupHeaders: [
			{startColumnName: 'RRN', numberOfColumns: 9, titleText: '개인정보 유형'}
		]
	});
}

function fn_lowestNGrid() {
	var grid_Width = $("#lowestNGrid").parent().width();
	
	$("#lowestNGrid").jqGrid({
		datatype: "local",
		/* data : temp,  */
	   	mtype : "POST",
		colNames:['호스트명','서비스명','현재 검출파일','현재 검출건','최초 검출파일','최초 검출건','최초 검출일','증감률','이행점검 회수','최근 실행일자'],
		colModel: [
			{ index: 'NAME', 			name: 'NAME', 	width: 100, align: 'center' },
			{ index: 'SERVICE_NM', 		name: 'SERVICE_NM', 	width: 100, formatter: serviceNm, align: 'center'  },
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
		width: grid_Width,
		height: 195,
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
	    gridComplete : function() {
	    }
	});
	
	var oToday = new Date();
	$("#toDate").val(getFormatDate(oToday));
	var toDate = $("#toDate").val();
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#fromDate").val(getFormatDate(oFromDate));
	var fromDate = $("#fromDate").val();
	
	var postData = {
			toDate : toDate,
			fromDate : fromDate
	}; 
	$("#lowestNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/dataImple", 
		postData : postData,
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
}

 // 월 출력
var MonthType = function(cellvalue, options, rowObject) {
	
	var index = cellvalue.indexOf("월");
	
	if(index != -1){		
		var printCon = cellvalue.substring(5, index+1);
		return printCon;
	}else{
		return cellvalue;
	}
}; 

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
function serviceNm(cellvalue, options, rowObject) {
	
	var serviceNm = rowObject.SERVICE_NM
	if(serviceNm != "" && serviceNm != null){
		return serviceNm;
	}else{
		return "-";
	}
};
//검색 조회
$("#btnSearch").click(function(e){
	
	if($("#fromDate").val() > $("#toDate").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val()
	};
	
	$(".totalStatistics").html("");
	$("#total_detection").html("");
	$("#titleTotal").html("");
	
	$.ajax({
		type: "POST",
		url: "/statistics/totalStatistics",
		async : false,
		data: postData,
		dataType: "json",
		success: function (resultMap) {
	    	
			var content = "";
				    	
			content += " 주민등록번호: " + resultMap.TYPE1.toLocaleString('ko-KR') + "(" + resultMap.TYPE1_PERCENTAGE + ")";
			content += " 외국인등록번호: " + resultMap.TYPE2.toLocaleString('ko-KR') + "(" + resultMap.TYPE2_PERCENTAGE + ")";
			content += " 여권번호: " + resultMap.TYPE3.toLocaleString('ko-KR') + "(" + resultMap.TYPE3_PERCENTAGE + ")";
			content += " 운전면허번호: " + resultMap.TYPE4.toLocaleString('ko-KR') + "(" + resultMap.TYPE4_PERCENTAGE + ")<br>";
			content += " 신용카드번호: " + resultMap.TYPE5.toLocaleString('ko-KR') + "(" + resultMap.TYPE5_PERCENTAGE + ")";
			content += " 계좌번호: " + resultMap.TYPE6.toLocaleString('ko-KR') + "(" + resultMap.TYPE6_PERCENTAGE + ")";
			content += " 이메일: " + resultMap.TYPE7.toLocaleString('ko-KR') + "(" + resultMap.TYPE7_PERCENTAGE + ")";
			content += " 핸드폰번호: " + resultMap.TYPE8.toLocaleString('ko-KR') + "(" + resultMap.TYPE8_PERCENTAGE + ")";
			
			$(".totalStatistics").append(content);
			
			var total_detection = "[" + resultMap.COUNT_TARGET_ID.toLocaleString('ko-KR') +"대 서버 검출 결과]";
	    	$("#total_detection").append(total_detection);
	    	
	    	var contentlist = resultMap.COUNT_TARGET_ID.toLocaleString('ko-KR') + "대 서버(약 "+ resultMap.COUNT_HASH_ID.toLocaleString('ko-KR') + "개 파일" 
    			contentlist += resultMap.TOTAL.toLocaleString('ko-KR') +"건)내 개인정보 정탐 확인";
	    	$("#titleTotal").append(contentlist);
	    	
	    	
	    	
	    },
	    error: function (request, status, error) {
	        console.log("request : ", request);
	        console.log("status : ", status);
	        console.log("ERROR : ", error);
	    }
	});

	
	// TOP 전체서비스
	$("#topNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/statisticsList", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
	
	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val(),
			prod : 2
	}; 
	// TOP5(정탐기준 - 운영서버)
	$("#middleNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/TOPGridList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val(),
			prod : 1
	}; 
	// TOP5(정탐기준 - 개발 서버)
	$("#bottomNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/TOPGridList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
	// 전체 서버 점검 결과 
	$("#totalNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/manageList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
	// 이행점검 현황
	$("#lowestNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/statistics/dataImple", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid"); 
	
	
	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val(),
	}; 
	
	// 막대 그래프
	$.ajax({
		type: "POST",
		url: "/statistics/manageBarList",
		async : false,
		data : postData,
		dataType : "json",
	    success: bar_graph_left,
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        console.log("ERROR : ", request);
	        console.log("ERROR : ", status);
	    }
	});
	
	// top pie_chart
	$('#chart_top_div').html("");
	var chart_top = null ;
    $.ajax({
		type: "POST",
		url: "/statistics/totalStatistics",
		async : false,
		data : postData,
		dataType : "json",
	    success: function(resultMap){
	    	
	    	var count = Object.keys(resultMap).length;
	    	if(resultMap.TARGET_ID == null){
	    		$('#chart_top_div').append("<div class='totalStatistics-box'>정탐으로 결재 완료된 내용이 없기 때문에 표시할 내용이 없습니다.</div>");
	    	}
	    	chart_top = anychart.pie3d([
            {x: '주민등록번호', value: resultMap.TYPE1},
            {x: '외국인등록번호', value: resultMap.TYPE2},
            {x: '여권번호', value: resultMap.TYPE3},
            {x: '운전면허번호', value: resultMap.TYPE4},
	    	{x: '신용카드번호', value: resultMap.TYPE5},
            {x: '계좌번호', value: resultMap.TYPE6},
            {x: '이메일', value: resultMap.TYPE7},
            {x: '핸드폰번호', value: resultMap.TYPE8},
            ])
	    },
	    error: function (request, status, error) {
	        console.log("ERROR : ", error);
	        console.log("ERROR : ", request);
	        console.log("ERROR : ", status);
	    }
	});
		
    chart_top.palette(['#F0620A', '#11088D', '#FBCD1F', '68A62F', '#6F037F', '#CC0F2E', '#0297A2', '#0570AB']);
	chart_top.legend(false);
	
	chart_top.labels().position("outside");
	chart_top.connectorLength("65");
	chart_top.labels().fontSize(14);
	chart_top.labels().hAlign("center");
	chart_top.labels().useHtml(true);
	chart_top.labels().format("<b>{%x}<br/></b>" + "{%PercentValue}{decimalsCount:1}%");
	chart_top.container('chart_top_div');
	chart_top.draw();

	var postData = {
			toDate : $("#toDate").val(),
			fromDate : $("#fromDate").val()
	};
	
	
})




</script>
	<!-- wrap -->
</body>
</html>
