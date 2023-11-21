<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.list_sch{
		top: 198px !important;
	}
}
</style>
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>예외처리 관리</h3>
					<p class="location">예외처리 관리 > 검출 관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<h3>예외 관리</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<table class="user_info narrowTable" style="width: 1168px;">
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
	                            <th style="text-align: center; border-radius: 0.25rem;">망</th>
	                            <td style="width:233px">
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="net" placeholder="망을 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">그룹(조직)</th>
	                            <td style="width:233px;">
	                                <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="group" placeholder="그룹(조직)명을 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">호스트명</th>
	                            <td style="width:233px">
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="host" placeholder="호스트명을 입력하세요.">
	                            </td>
	                           	<td rowspan="3">
	                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
	                           	</td>
	                        </tr>
	                        <tr>
	                        	<th style="text-align: center;">서비스명</th>
	                            <td style="width:10vw">
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="service" placeholder="서비스명을 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">요청자</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="req" placeholder="요청자명를 입력하세요.">
	                            </td>
	                            <th style="text-align: center;">등록자</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="reg" placeholder="등록자명를 입력하세요.">
	                            </td>
	                        </tr>
	                        <tr>
	                           <th style="text-align: center; border-radius: 0.25rem;">종류(경로, 파일)</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="path" placeholder="종류(경로, 파일)를 입력하세요.">
	                            </td>
								<th style="text-align: center;">예외 항목</th>
	                            <td>
	                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="exception_content" placeholder="예외 항목명을 입력하세요.">
	                            </td>
	                        </tr>
                   		</tbody>
                    </table>
					<div class="list_sch" style="right: 76px; top: 155px;">
	                    <div class="sch_area">
							<button type="button" name="button" class="btn_down" id="btnCreate">추가</button>
	                    </div>
                	</div>
					<div class="grid_top" style="width: 100%; margin-top: 10px;">
						<div class="left_box2" style="max-height: 600px; height: 600px; overflow: hidden;">
		   					<table id="topNGrid"></table>
		   				 	<div id="topNGridPager"></div>
		   				</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->

	<%@ include file="../../include/footer.jsp"%>
	
<c:if test="${memberInfo.USER_GRADE == '9'}">
<!-- 팝업창 - 추가 시작 -->
<div id="selectPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">추가</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 90px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<tbody>
						<tr>
							<th style="width: 50px;">서버</th>
							<td>
								<input type="radio" id="selectServer" name="action" value="0">
							</td>
							<th>PC</th>
							<td>
								<input type="radio" id="selectPC" name="action" value="1">
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnSelect">선택</button>
				<button type="button" id="btnCancel">취소</button>
			</div>
		</div>
	</div>
</div>

<div id="serverCreatePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">추가</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 260px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<!-- 
						<tr>
							<th>망</th>
							<td><input type="text" id="createNet" value="" class="edt_sch" style="width: 220px; padding-left: 10px;"></td>
						</tr> 
						-->
						<tr>
							<th>그룹(조직)</th>
							<td>
								<input type="text" id="createServerGroup" value="" class="edt_sch" style="width: 173px; padding-left: 10px;">
								<input type="hidden" id="createServerGroup2" value="" class="edt_sch" style="width: 173px; padding-left: 10px;">
								<button type="button" style="text-align: center; width: 54px; padding: 7px 0; font-size: 12px;" id="selectGroupBtn">선택</button>
							</td>
						</tr>
						<tr>
							<th>호스트명</th>
							<td>
								<input type="text" id="createServerHost" value="" class="edt_sch" style="width: 173px; padding-left: 10px;">
								<button type="button" style="text-align: center; width: 54px; padding: 7px 0; font-size: 12px;" id="selectHostBtn">선택</button>
							</td>
						</tr>
						<tr>
							<th>서비스명</th>
							<td>
								<input type="text" id="createServerService" value="" class="edt_sch" style="width: 173px; padding-left: 10px;">
								<!-- <button type="button" style="text-align: center; width: 54px; padding: 7px 0; font-size: 12px;" id="selectServiceBtn">선택</button> -->
							</td>
						</tr>
						<tr>
							<th>요청자</th>
							<td>
								<input type="text" id="createServerUser" value="" class="edt_sch" style="width: 173px; padding-left: 10px;" readonly>
								<input type="hidden" id="createServerUserID" value="" class="edt_sch" style="width: 173px; padding-left: 10px;" readonly>
								
								<button type="button" style="text-align: center; width: 54px; padding: 7px 0; font-size: 12px;" id="selectUserBtn">선택</button>
							</td>
						</tr>
						<tr>
							<th>소속</th>
							<td>
								<input type="text" id="createServerUserGroup" value="" class="edt_sch" style="width: 173px; padding-left: 10px;" readonly>
								<input type="hidden" id="createServerUserGroupCode" value="" class="edt_sch" style="width: 173px; padding-left: 10px;" readonly>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnServerCreateSave">저장</button>
				<button type="button" id="btnServerCreateCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 추가 종료 -->


<!-- 팝업창 - 수정/삭제 팝업 시작 -->
<div id="dataPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 300px; width: 400px; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">수정 및 삭제</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" id="div_update_user" style="height: 210px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>그룹(조직)</th>
							<td><input type="text" id="updateGroup" value="" class="edt_sch" style="width: 231px; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>호스트명</th>
							<td><input type="text" id="updateHost" value="" class="edt_sch" style="width: 231px; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>서비스명</th>
							<td><input type="text" id="updateService" value="" class="edt_sch" style="width: 231px; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>요청자</th>
							<td><input type="text" id="updateRequest" value="" class="edt_sch" style="width: 231px; padding-left: 10px;"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnDataDelete">삭제</button>
				<button type="button" id="btnDataSave">저장</button>
				<button type="button" id="btnDataCancel">취소</button>
			</div>
		</div>
	</div>
</div>
</c:if>
<!-- 팝업창 - 수정/삭제 팝업 종료 -->

<script type="text/javascript"> 

$(document).ready(function () {
	fn_drawTopNGrid();
	
	$("#btnCreate").click(function() {
		$("#selectPopup").show();
	});
	$("#btnSelect").click(function() {
		if(document.getElementById('selectServer').checked){
			$("#serverCreatePopup").show();
			$("#selectPopup").hide();
		}
	});
	$("#btnCancel").click(function(){
		$("#selectPopup").hide();
	});
	$("#btnServerCreateSave").click(function() {
		alert("저장 되었습니다.");
		$("#serverCreatePopup").hide();
	});
	$("#btnServerCreateCancel").click(function() {
		$("#serverCreatePopup").hide();
	});
	$("#btnDataDelete").click(function(){
		alert("삭제 하시겠습니까?");
		setDeleteData($('#rowid').val());
		alert("삭제 되었습니다.");
		$("#dataPopup").hide();
	});
	$("#btnDataSave").click(function() {
		alert("저장 되었습니다.");
		setRowData($('#rowid').val());
		$("#dataPopup").hide();
	});
	$("#btnDataCancel").click(function() {
		$("#dataPopup").hide();
	});
	

function setRowData(rowid){
	//$("#targetGrid").setCell(rowId, "DATATYPE_LABEL_COPY", rowData.DATATYPE_LABEL);
	$('#topNGrid').setCell(rowid, "NET", $("#updateNet").val());
	$('#topNGrid').setCell(rowid, "GROUP", $("#updateGroup").val());
	$('#topNGrid').setCell(rowid, "HOST", $("#updateHost").val());
	$('#topNGrid').setCell(rowid, "SERVICE", $("#updateService").val());
	$('#topNGrid').setCell(rowid, "REQUEST", $("#updateRequest").val());
	$('#topNGrid').setCell(rowid, "DATE", $("#updateDate").val());
	$('#topNGrid').setCell(rowid, "REGIST", $("#updateRegist").val());
	$('#topNGrid').setCell(rowid, "REASON", $("#updateReason").val());
	$('#topNGrid').setCell(rowid, "KINDS", $("#updateKinds").val());
	$('#topNGrid').setCell(rowid, "EXCEPTION", $("#updateException").val());
}

function setDeleteData(rowid){
	$('#topNGrid').delRowData(rowid);
}

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		datatype: "local",
	   	mtype : "POST",
		colNames:['타겟ID','번호','망','망ID','그룹(조직)','그룹ID','호스트명','서비스명','서비스ID','요청자','요청자ID','등록자','등록자ID','적용일','사유','종류(경로,파일)','예외 내용'],
		colModel: [
			{ index: 'TARGET_ID', 	name: 'TARGET_ID', 	width: 0, align: 'center', hidden: true },
			{ index: 'AP_NO', 		name: 'AP_NO', 	width: 0, align: 'center', hidden: true },
			{ index: 'NET', 		name: 'NET', 	width: 50, align: 'center' },
			{ index: 'NET_ID', 	name: 'NET_ID', 	width: 0, align: 'center', hidden: true },
			{ index: 'GROUP', 		name: 'GROUP', 	width: 50, align: 'center' },
			{ index: 'GROUP_ID', 	name: 'GROUP_ID', 	width: 0, align: 'center', hidden: true },
			{ index: 'HOST', 		name: 'HOST',  width: 50, align: 'center' },
			{ index: 'SERVICE_NM', 	name: 'SERVICE_NM', width: 50, align: 'center' },
			{ index: 'SERVICE_CODE', 	name: 'SERVICE_CODE', 	width: 0, align: 'center', hidden: true },
			{ index: 'REQ_USER_NO', 	name: 'REQ_USER_NO', width: 50, align: 'center' },
			{ index: 'REQ_USER_ID', 	name: 'REQ_USER_ID', 	width: 0, align: 'center', hidden: true },
			{ index: 'REG_USER_NO', 	name: 'REG_USER_NO', width: 50, align: 'center' },
			{ index: 'REG_USER_ID', 	name: 'REG_USER_ID', 	width: 0, align: 'center', hidden: true },
			{ index: 'REGDATE', 		name: 'REGDATE', width: 100, align: 'center' },
			{ index: 'REASON', 		name: 'REASON', width: 100, align: 'center' },
			{ index: 'PATH', 		name: 'PATH', width: 400, align: 'left' },
			{ index: 'EXCEPTION_CONTENT', 	name: 'EXCEPTION_CONTENT', width: 200, align: 'left' },
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 505,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#topNGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  		
	  	},
	  	onCellSelect : function(rowid) {
	  		$("#rowid").val(rowid)
	  		var GROUP = $(this).getCell(rowid, 'GROUP');
	  		var HOST = $(this).getCell(rowid, 'HOST');
	  		var SERVICE_NM = $(this).getCell(rowid, 'SERVICE_NM');
	  		var REQ_USER_NO = $(this).getCell(rowid, 'REQ_USER_NO');
	  		$("#updateGroup").val(GROUP);
	  		$("#updateHost").val(HOST);
	  		$("#updateService").val(SERVICE_NM);
	  		$("#updateRequest").val(REQ_USER_NO);
	  		$("#dataPopup").show();
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

var postData = {};

$("#topNGrid").setGridParam({
	url:"<%=request.getContextPath()%>/target/getExceptionList", 
	postData : postData, 
	datatype:"json" 
}).trigger("reloadGrid");


$("#btnSearch").click(function(e){
	var postData = {
			net : $("#net").val(),
			group : $("#group").val(),
			host : $("#host").val(),
			service : $("#service").val(),
			req : $("#req").val(),
			reg : $("#reg").val(),
			path: $("#path").val(),
			exception_content : $("#exception_content").val()
	};
	
	console.log(postData);
	
	$("#topNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/target/exceptionSearchList", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
}) 

});

$("#selectGroupBtn").on("click", function(){
	   var pop_url = "${getContextPath}/popup/exceptionServerList";
	   var id = "targetList"
	   var winWidth = 700;
	   var winHeight = 620;
	   var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no";    
	   //var pop = window.open(pop_url,"lowPath",popupOption);
	   var pop = window.open(pop_url,id,popupOption);
	   /* popList.push(pop);
   	   sessionUpdate(); */
	   
	   //pop.check();
	   var newForm = document.createElement('form');
	   newForm.method='POST';
	   newForm.action=pop_url;
	   newForm.name='newForm';
	   //newForm.target='lowPath';
	   newForm.target=id;
	   
	   var data = document.createElement('input');
	   data.setAttribute('type','hidden');
	   data.setAttribute('name','hash_id');
	   data.setAttribute('value',id);
	   
	   newForm.appendChild(data);
	   document.body.appendChild(newForm);
	   newForm.submit();
	   
	   document.body.removeChild(newForm);
	   
})

$("#selectHostBtn").on("click", function(){
	   var pop_url = "${getContextPath}/popup/exceptionHostList";
	   var id = "targetList"
	   var winWidth = 700;
	   var winHeight = 570;
	   var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no";    
	   //var pop = window.open(pop_url,"lowPath",popupOption);
	   
	   var test = $("#createServerGroup2").val();
	   var pop = window.open(pop_url,id,popupOption,test);
	   /* popList.push(pop);
   	   sessionUpdate(); */
	   
	   //pop.check();
	   var newForm = document.createElement('form');
	   newForm.method='POST';
	   newForm.action=pop_url + "/" + test;
	   newForm.name='newForm';
	   //newForm.target='lowPath';
	   newForm.target=id;
	   
	   var data = document.createElement('input');
	   data.setAttribute('type','hidden');
	   data.setAttribute('name','hash_id');
	   data.setAttribute('value',id);
	   
	   newForm.appendChild(data);
	   document.body.appendChild(newForm);
	   newForm.submit();
	   
	   document.body.removeChild(newForm);
	   
})

// 요청자 선택 버튼
$("#selectUserBtn").on("click", function(){
	userListWindows("user");
})

function userListWindows(info){
	var pop_url = "${getContextPath}/popup/userList";
	var id = "targetList"
	var winWidth = 700;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no"; 	
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





function findByPop(){
	$("#taskWindow").hide();
	$("#pathWindow").hide();
	$("#targetGrid").clearGridData();
	$("#searchLocation").val("");
    fnSearchFindSubpath();
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
	    			$("#div_search").hide()
	    			/* alert('검색 결과가 없습니다.') */
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.")
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

$("#net, #group, #host, #service, #req, #reg, #path, #exception_content").keyup(function(e){
    if (e.keyCode == 13) {
    	$("#btnSearch").click();
    }
});


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
	    			var discon_cnt = 0
	    			$('#hostCnt').text(resultList.length+' 대')
	    			
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide()
	    			/* alert('검색 결과가 없습니다.') */
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.")
	        console.log("ERROR : ", error)
	    }
	});
}

$(".sta_tit").on("click", function() {
	var id = $(this).attr('id');
	var tr = $(this).closest('tr');
	var level = tr.data('level');
	var mother = tr.data('mother');
	
	if(id == 'noGroup'){
		if($('tr[data-uptidx="'+id+'"]').is(':visible')){
			$('tr[data-uptidx="'+id+'"]').remove();
		}else{
			$.ajax({
				type: "POST",
				url: "/popup/getTargetList",
				async : false,
				data : {
					noGroup: id,
					aut: aut
				},
				dataType: "text",
			    success: function (resultMap) {
			    	//console.log(resultMap)
			    	console.log(resultMap)
			    	var data = JSON.parse(resultMap);
			    	if(data.resultCode == '0'){
			    		var resultList = data.resultData
			    		if(resultList.length > 0){
			    			var html = setLocationList(resultList, 1, id, mother, 'all');
			    			tr.after(html)
			    		}
			    	}
			    },
			    error: function (request, status, error) {
			    	alert("Recon Server에 접속할 수 없습니다.");
			        console.log("ERROR : ", error);
			    }
			});
			return;
		}
		//tr.clear();
	}
	
	if($('tr[data-uptidx="'+id+'"]').is(':visible')){	// 보여지고 있을 때
		var up_id = [id]
		var up_idx = up_id.length
		var flag = true
		while(flag){
			var below_id = []
			up_id.forEach(function(idx){
				$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
					$('tr[data-uptidx="'+idx+'"][data-flag="target"]').remove();
					$('tr[data-uptidx="'+idx+'"][data-flag="path"]').remove(); 
					$(value).hide();
					var bel_id = $(value).children('th').children('p').attr('id')
					below_id.push(bel_id)
				});
			})
			if(below_id.length < 1){
				flag = false;
			} else {
				up_id = below_id
			}
			
		}
	} else {											// 안 보여지고 있을 때
		if($('tr[data-id="pc"]')){
			$.ajax({
				type: "POST",
				url: "/popup/getUserTargetList",
				async : false,
				data : {
					groupID: id,
				},
				dataType: "text",
			    success: function (resultMap) {
			    	var data = JSON.parse(resultMap);
			    	if(data.resultCode == '0'){
			    		var resultList = data.resultData
			    		if(resultList.length > 0){
			    			var html = setLocationList(resultList, level, id, mother, 'all');
			    			if($('tr[data-uptidx="'+id+'"]').length > 0){
			    				var str_tr = $('tr[data-uptidx="'+id+'"]')[($('tr[data-uptidx="'+id+'"]').length-1)]
			    				var str_id = $(str_tr).children('th').children('p').attr('id')
			    				
			    				var up_id = [str_id]
			    				var flag = true
			    				while(flag){
			    					var below_id = []
			    					up_id.forEach(function(idx){
			    						$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
			    							var bel_id = $(value).children('th').children('p').attr('id')
			    							below_id.push(bel_id)
			    						});
			    					})
			    					if(below_id.length < 1){
			    						flag = false;
			    						$('p#'+up_id[(up_id.length-1)]).parent().parent().after(html)
			    					} else {
			    						up_id = below_id
			    					}
			    				}
			    			} else {
			    				tr.after(html)
			    			}
			    		}
			    	}
			    },
			    error: function (request, status, error) {
			    	alert("Recon Server에 접속할 수 없습니다.");
			        console.log("ERROR : ", error);
			    }
			});
		} else {
			$.ajax({
				type: "POST",
				url: "/popup/getTargetList",
				async : false,
				data : {
					group_id: id,
					aut: aut
				},
				dataType: "text",
			    success: function (resultMap) {
			    	var data = JSON.parse(resultMap);
			    	if(data.resultCode == '0'){
			    		var resultList = data.resultData
			    		if(resultList.length > 0){
			    			var html = setLocationList(resultList, level, id, mother, 'all');
			    			if($('tr[data-uptidx="'+id+'"]').length > 0){
			    				var str_tr = $('tr[data-uptidx="'+id+'"]')[($('tr[data-uptidx="'+id+'"]').length-1)]
			    				var str_id = $(str_tr).children('th').children('p').attr('id')
			    				
			    				var up_id = [str_id]
			    				var flag = true
			    				while(flag){
			    					var below_id = []
			    					up_id.forEach(function(idx){
			    						$('tr[data-uptidx="'+idx+'"]').each(function(bi, value){
			    							var bel_id = $(value).children('th').children('p').attr('id')
			    							below_id.push(bel_id)
			    						});
			    					})
			    					if(below_id.length < 1){
			    						flag = false;
			    						$('p#'+up_id[(up_id.length-1)]).parent().parent().after(html)
			    					} else {
			    						up_id = below_id
			    					}
			    				}
			    			} else {
			    				tr.after(html)
			    			}
			    		}
			    	}
			    },
			    error: function (request, status, error) {
			    	alert("Recon Server에 접속할 수 없습니다.");
			        console.log("ERROR : ", error);
			    }
			});
		}
		$('tr[data-uptidx="'+id+'"][data-flag!="path"]').show();
	}
});

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\"\">"
			html += 	"<td style=\"padding-bottom: 0px; cursor: pointer;\">"
			html += 		"<p style=\"padding-bottom: 0px; margin-left:"+(((level-1)*10))+"px;\""
			html +=			 "data-targetid=\""+item.TARGET_ID+"\" data-name=\""+item.AGENT_NAME+"\" data-connected=\""+item.AGENT_CONNECTED+"\" data-version=\""+item.AGENT_VERSION+"\" data-platform=\""+item.AGENT_PLATFORM+"\""
			html +=			 "data-apc=\""+item.AGENT_PLATFORM_COMPATIBILITY+"\" data-verified=\""+item.AGENT_VERIFIED+"\" data-user=\""+item.AGENT_USER+"\" data-cpu=\""+item.AGENT_CPU+"\" data-cores=\""+item.AGENT_CORES+"\""
			html +=			 "data-boot=\""+item.BOOT+"\" data-ram=\""+item.AGENT_RAM+"\" data-ip=\""+item.AGENT_CONNECTED_IP+"\" data-searchdt=\""+item.SEARCH_DATETIME+"\" data-apno=\""+item.AP_NO+"\""
			html +=			">"
			if(item.AGENT_CONNECTED == '1'){
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" />"
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
				html +=		"<img src=\"/resources/assets/images/icon_con.png\" value=\"1\" />"
			} else {
				html +=		"<img src=\"/resources/assets/images/icon_dicon.png\" value=\"0\" />"
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

	
</script>

</body>
</html>