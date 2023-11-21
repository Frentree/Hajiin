<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>사용자 조회</title>

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js" type="text/javascript"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/select2.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/jquery-ui-PIC.css" />
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/ui.jqgrid-PIC.css" />
<%@ include file="../../include/session.jsp"%>
<style>
	.ui-widget.ui-widget-content{
		border: none;
		border-bottom: 1px solid #c8ced3;
		border-radius: unset !important;
	}
	body{
		width: auto;
	}
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		html{
			overflow: auto !important;
		}
		body{
			width: auto !important;
		}
	}
</style>
</head>
<body>
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c; width: 100%; height: 100%; background: #f9f9f9;">
		<div class="step_content_cell fl_l "style="overflow-y: auto; padding: 0 15px; width: 100%;">
			<h1 style="color: #222; font-size: 20px; padding: 0; box-shadow: none;">사용자 조회</h1>
			<!-- <p style="position: absolute; top: 33px; left: 133px; font-size: 14px; color: #9E9E9E;">담당자 정보가 틀릴 경우 사용자 정보에서 수정하시기 바랍니다.</p> -->
		
			<div class="select_location sch_left" style="height: 50px; min-height: 50px; margin-top: 10px; width:100%; background: #fff; border: 1px solid #c8ced3; border-radius: 0;">
				<div style="position: absolute; top: 10px; right: 10px; padding-top: 0px; font-size: 14px; font-weight: bold;">
				소속 : <input type="text" id="searchGroup" value="" class="edt_sch" style="width: 125px; margin-bottom: 3px;" onKeypress="javascript:if(event.keyCode==13) fnSearch()">
				담당자 : <input type="text" id="searchUser" value="" class="edt_sch" style="width: 125px; margin-bottom: 3px;" onKeypress="javascript:if(event.keyCode==13) fnSearch()">
				<button id="btnSearch" class="btn_sch">검색</button>
				</div>
			</div>
			<div class="grid_top" style="width: 100%; height: 80%;">
				<div class="left_box2" style="height: auto; min-height: 343px; overflow: hidden; width:100%; border-left: 1px solid #c8ced3; border-right: 1px solid #c8ced3; ">
			 		<table id="targetUserGrid"></table>
					<div id="targetUserGridPager"></div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
var info = "${info}";

$(document).ready(function() {
	fn_targetUserGrid();
	console.log(info);
});


function fn_targetUserGrid() {
	
	var gridWidth = $("#targetUserGrid").parent().width();
	
	$("#targetUserGrid").jqGrid({
		url: "<%=request.getContextPath()%>/popup/selectUserList",
		datatype: "local",
		//data: temp,
	   	mtype : "POST",
		colNames:['ID','성명','팀코드','소속','전화번호', '이메일'],
		colModel: [
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 80, align: "center"},
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 80, align: "center"},
			{ index: 'INSA_CODE', 	name: 'INSA_CODE', 	width: 100, align: "left", hidden:true},
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 100, align: "center" },
			{ index: 'USER_PHONE', 	name: 'USER_PHONE', width: 100, align: "center"},
			{ index: 'USER_EMAIL', 	name: 'USER_EMAIL', width: 120, align: "left"},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 343,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 35, // 행번호 열의 너비	
		rowNum:20,
		rowList:[25,50,100],
	   	//editurl: 'clientArray',
	   	//cellEdit : true,
	   	//cellsubmit: 'clientArray',
	   	//multiselect:true,
		pager: "#targetUserGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	
	  		var user_no = $(this).getCell(rowid, 'USER_NO');
	  		var user_name = $(this).getCell(rowid, 'USER_NAME');
	  		var insa_code = $(this).getCell(rowid, 'INSA_CODE');
	  		var team_name = $(this).getCell(rowid, 'TEAM_NAME');
	  		var user_team = user_name + '(' + team_name + ')';
	  		
	  		if(info == "mngr1"){
	  			
  				$(opener.document).find("#targetSevermngr1").val(user_name);
	  			
		  		$(opener.document).find("#reachTargetMngr1Nm").val(user_name);
		  		$(opener.document).find("#reachTargetMngr1No").val(user_no);
		  		
	  		} else if(info == "mngr2") {
	  			
  				$(opener.document).find("#targetSevermngr2").val(user_name);
	  			
	  			$(opener.document).find("#reachTargetMngr2Nm").val(user_name);
	  			$(opener.document).find("#reachTargetMngr2No").val(user_no);
		  		
	  		} else if(info == "mngr3") {

	  			$(opener.document).find("#reachTargetMngr3No").val(user_no);
	  			$(opener.document).find("#reachTargetMngr3Nm").val(user_name);
	  			$(opener.document).find("#reachTargetMngr3Tm").val(team_name);
	  			
	  			opener.gridreload(1);
		  		
	  		} else if(info == "mngr4") {
	  			
	  			$(opener.document).find("#reachTargetMngr4No").val(user_no);
	  			$(opener.document).find("#reachTargetMngr4Nm").val(user_name);
	  			$(opener.document).find("#reachTargetMngr4Tm").val(team_name);
	  			
	  			opener.gridreload(2);
	  		} else if(info == "mngr5") {
	  			
	  			$(opener.document).find("#reachTargetMngr5No").val(user_no);
	  			$(opener.document).find("#reachTargetMngr5Nm").val(user_name);
	  			$(opener.document).find("#reachTargetMngr5Tm").val(team_name);
	  			
	  			opener.gridreload(3);
	  			
		  		
	  		} else if(info == "serviceManager"){
	  			if(team_name != "" && team_name != null){
	  				$(opener.document).find("#targetServiceManager").val(user_team);
	  			}else{
	  				$(opener.document).find("#targetServiceManager").val(user_name);
	  			}
	  			
	  			$(opener.document).find("#targetServiceManagerName").val(user_name);
	  			$(opener.document).find("#targetServiceManagerID").val(user_no);
		  		// $(opener.document).find("#targetServiceManager").val(user_name);
		  		$(opener.document).find("#targetServiceManagerTeamCode").val(insa_code);
		  		$(opener.document).find("#targetServiceManagerTeam").val(team_name);
	  		} else if(info == "user"){
	  			$(opener.document).find("#createServerUserID").val(user_no);
		  		$(opener.document).find("#createServerUser").val(user_name);
		  		$(opener.document).find("#createServerUserGroupCode").val(insa_code);
		  		$(opener.document).find("#createServerUserGroup").val(team_name);
	  		} else if(info == "PCManager"){
		  		$(opener.document).find("#PCtargetInfraID").val(user_no);
	  			$(opener.document).find("#PCtargetInfra").val(user_team);
	  		}else if(info == "lockMember"){
		  		$(opener.document).find("#LockMemberManager").val(user_name);
	  		}else if(info == "changeUser"){
	  			if('${memberInfo.USER_GRADE}' == '9'){
	        		var result = confirm(user_no+'으로 로그인 하시겠습니까?');
	        		if(result){
	        			changeLoginId(user_no);
	        		}
	        	}
	  		}
	  		window.close();
	  	},
	  	onCellSelect : function(rowid){
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
var aut = "${aut}"

$("#btnSearch").click( function(e) {
	fnSearch(e);
});	

function fnSearch(e) {
	var searchGroup = $("#searchGroup").val();
	var searchUser = $("#searchUser").val();
	
	if (isNull($("#searchGroup").val().trim()) && isNull($("#searchUser").val().trim())) {
		alert("소속 혹은 담당자를 입력하세요");
		return;
	}
	
	var postData = {
		user_nm : searchUser,
		team_nm :searchGroup
	};
	$("#targetUserGrid").setGridParam({url:"<%=request.getContextPath()%>/popup/selectUserList",page : 1, postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	
}

$(document).on('click', function(event){
	var target = event.target;
	var tr = target.parentElement.parentElement;
	var data_flag = tr.getAttribute('data-flag')
	if(data_flag == 'target'){
		var id = target.getAttribute('id')
		if($('tr[name='+id+']').is(':visible')){	// 보여지고 있을 때
			$('tr[name='+id+']').hide()
		} else {
			$('tr[name='+id+']').show()
		}
	}
});

function setLocationList(locList, level, id, mother, code){
	var html = "";
	var target_id = "";
	var target_name = "";
	locList.forEach(function(item, index) {
		if(code == "all"){
			html += "	<tr data-uptidx=\""+id+"\" data-flag=\"target\" data-mother=\""+mother+"\" ondblclick=\"setTargetId(event)\">"
			html += "		<th style=\"padding-top: 10px;\"><p id=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"cursor:pointer;\ margin-left:"+((level*10)+10)+"px;\"  data-apno=\"" + item.AP_NO + "\" >"+item.AGENT_NAME+"</p></th>"
			html += "	</tr>"
		} else if (code == "search"){
			html += "	<tr data-flag=\"target\" ondblclick=\"setTargetId(event)\">"
			html += "		<th style=\"padding-top: 10px;\"><p id=\""+item.TARGET_ID+"\" class=\"sta_tit4\" style=\"cursor:pointer;\" data-apno=\"" + item.AP_NO + "\" >"+item.AGENT_NAME+"</p></th>"
			html += "	</tr>"
		}
	})
	return html;
}

function getSearchData(host){

	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		data : {
			host: host,
			aut: aut
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var html = setLocationList(resultList, '', '', '', "search");
	    			$("#Tbl_search").html(html)
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide()
	    			alert('검색 결과가 없습니다.')
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.")
	        console.log("ERROR : ", error)
	    }
	});
}

function setTargetId(event){
	
	var id = $(event.target).attr('id')
	var name = $(event.target).text()
	var ap_no = $(event.target).data('apno')
	
	$(opener.document).find("#searchHost").val(name);
	$(opener.document).find("#searchHost").text(name);
	$(opener.document).find("#hostSelect").val(id);
	$(opener.document).find("#ap_no").val(ap_no);
	opener.findByPop();
	
	/* window.close(); */

}

function setGroup(event){
	var id = $(event.target).attr('id')
	var name = $(event.target).text()

	/* alert('click')
	console.log('id :: ' + id)
	console.log('name :: ' + name)
	
	console.log('') */
}

function changeLoginId(user_no){
	var postData = {
		user_no : user_no,
	};
	$.ajax({
		type: "POST",
		url: "/changeUser",
		async : false,
		data : postData,
	    success: function (resultMap) {
	    	if (resultMap.resultCode == 0) {
	    		if (resultMap.user_grade == "9"){
	    			opener.parent.location = "<%=request.getContextPath()%>/piboard";
		        } else if(resultMap.user_grade == "0" || resultMap.user_grade == "1" || resultMap.user_grade == "2" || resultMap.user_grade == "3" ) {
		        	opener.parent.location = "<%=request.getContextPath()%>/picenter_manager";
		        } else if(resultMap.user_grade == "4" || resultMap.user_grade == "5" || resultMap.user_grade == "6" ) {
		        	opener.parent.location = "<%=request.getContextPath()%>/picenter_server";
		        } else {
		        	opener.parent.location = "<%=request.getContextPath()%>/approval/pi_search_approval_list";
		        }
	    	}else if(resultMap.resultCode != -100){
	    		alert(resultMap.resultMessage);
	    	}else {
	    		alert('오류로 인해 사용자 계정을 변경 하지 못하였습니다.\n잠시후 다시 시도해 주세요.');
	    	}
	    }
	});
}
</script>
</html>
