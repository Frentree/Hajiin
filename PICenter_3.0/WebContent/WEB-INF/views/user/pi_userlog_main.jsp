<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>


		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">사용자 관리 > 접속로그관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<!-- <div class="container" style="max-width:1400px; min-width:1200px;"> -->
			<div class="container" >
			<h3>접속로그관리</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<!-- user info -->
					<div class="grid_top">
						<table class="user_info approvalTh" style="width: 825px;">
							<caption>사용자정보</caption>
							<tbody>
								<tr>
									<th style="text-align: center; padding: 10px 3px; width: 100px; padding: 5px 5px 0 5px; border-radius: 0.25rem;">사용자 ID</th>
									<td style="padding: 5px 5px 0 5px;">
										<input type="text" style="width: 186px; padding-left: 5px;" id="userNo" placeholder="사용자 ID를 입력하세요">
									</td>
									<th style="text-align: center; padding: 10px 3px; width: 100px; padding: 5px 5px 0 5px;">사용자 명</th>
									<td style="padding: 5px 5px 0 5px;">
										<input type="text" style="width: 186px; padding-left: 5px;" id="userName" placeholder="사용자명을 입력하세요">
									</td>
									<td rowspan="3">
		                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
		                           	</td>
								</tr>
								<tr>
									<th style="text-align: center; padding: 10px 3px; width: 100px; padding: 5px 5px 0 5px;">사용 구분</th>
									<td style="padding: 5px 5px 0 5px;">
										<select id="selectStatus" name="selectStatus" style="width: 186px;">
		                                	<option value="" selected>전  체</option>
		                                	<c:forEach items="${log_flag_list}" var="item">
			                                    <option value="${item.FLAG}">${item.FLAG_NAME}</option>
		                                    </c:forEach>
		                                </select>
									</td>
									<th style="text-align: center; padding: 10px 3px; width: 100px; padding: 5px 5px 0 5px;">IP</th>
									<td style="padding: 5px 5px 0 5px;">
										<input type="text" style="width: 186px; padding-left: 5px;" id="userIP" placeholder="IP를 입력하세요">
									</td>
								</tr>
								<tr>
									<th style="text-align: center; padding: 10px 3px; width: 100px;">일자</th>
									<td>
										<input type="date" id="fromDate" style="text-align: center;  width:186px;" readonly="readonly" value="${fromDate}" >
										<span style="width: 10%; margin-right: 3px; color: #000">~</span>
										<input type="date" id="toDate" style="text-align: center;  width:186px;" readonly="readonly" value="${toDate}" >
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					<!-- list -->
					<div class="grid_top" style="margin-top: 10px;">
						<h3 style="padding: 0; display: inline;">사용 현황</h3>
						<div class="list_sch" style="position: relative; bottom: -3px;">
							<div class="sch_area">
								<button type="button" name="button" class="btn_down" id="btnDownloadExel">다운로드</button>
							</div>
						</div>
						<div class="left_box2 minH_2" style="overflow: hidden; margin-top: 10px; max-height: 565px; height: 565px;">
		   					<table id="userGrid"></table>
		   					<div id="userGridPager"></div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		
	<%@ include file="../../include/footer.jsp"%>
	
<script type="text/javascript">

var oGrid = $("#userGrid");

function fn_search () {
	
    if($("#fromDate").val() > $("#toDate").val()){
        alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
        return;
    }
	
	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		userIP : $("#userIP").val(),
		fromDate : $("#fromDate").val(),
		toDate : $("#toDate").val(),
		logFlag : $('#selectStatus').val()
	};
	
	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/pi_userlog_list", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

$(document).ready(function () {

	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
	
	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 480;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['사용자 ID','사용자명','IP', '사용화면', '작업내용', '일자'],
		colModel: [      
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 250,	align: 'center'},
			{ index: 'USER_NAME',			name: 'USER_NAME',			width: 250, align: 'center'},
			{ index: 'USER_IP',				name: 'USER_IP',			width: 250, align: 'center'},
			{ index: 'MENU_NAME',			name: 'MENU_NAME',			width: 200, align: 'left', hidden: true},
			{ index: 'JOB_INFO',			name: 'JOB_INFO',			width: 250, align: 'center'},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 200, align: 'center'}
		],
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : true, // 행번호 표시여부
		rownumWidth : 50, // 행번호 열의 너비	
		rowNum:30,
	   	rowList:[10,20,30],
	    search: true,			
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  		
	  	},
		loadComplete: function(data) {
	    },
	    gridComplete : function() {
	    }
	});

	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#fromDate").val(),
		toDate : $("#toDate").val() 
	};
	$("#userGrid").setGridParam({
		url:"<%=request.getContextPath()%>/user/pi_userlog_list",
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
	});

	$("#btnSearch").click(function() {
		fn_search();
    });

	$('#userNo').keyup(function(e) { //userNo userName
		if (e.keyCode == 13) {
			fn_search();
	    }
	});

	$('#userName').keyup(function(e) { //userNo userName
		if (e.keyCode == 13) {
			fn_search();
	    }
	});
	
	$('#userIP').keyup(function(e) { //userNo userName
		if (e.keyCode == 13) {
			fn_search();
	    }
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
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
        fileName : "접속_로그_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

$('#selectStatus').on('change', function(){
	fn_search();
})
</script>

</body>
</html>