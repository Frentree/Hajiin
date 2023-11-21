<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/xlsx.full.min.js"></script>
	<section id="section">
		<div class="container">
			<h3>검색 불가 경로</h3>
			<div class="content magin_t25">
				<table class="user_info" style="display: inline-table; width: 830px;">
					<caption>예외 관리</caption>
					<tbody>
						<tr>
                            <th style="text-align: center; width:63px; padding: 5px; border-radius: 0.25rem;">대상</th>
							<td style="width: 210px;">
								<p style="width: 100px; margin-bottom: 5px;">
								<input type="text" style="width: 200px; font-size: 12px; padding-left: 5px;" size="10" id="host_name" placeholder="대상을 입력하세요.">
							</td>
							<th style="text-align: center; width:63px; padding: 5px;">경로</th>
							<td>
								<p style="width: 100%; margin-bottom: 5px;">
								<input type="text" style="width: 94%; font-size: 12px; padding-left: 5px;" size="20" id="path" placeholder="경로를 입력하세요.">
								<input type="button" name="button" class="btn_look_approval" id="btnSearch" style="margin-top: 5px; margin-right: 5px;">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="list_sch" style="margin-top: 24px;">
					<div class="sch_area">
						<button type="button" class="btn_down " id="btnRegist">적용</button>
						<button type="button" class="btn_down" id="btnDownloadExcel">다운로드</button>
					</div>
                </div>
				<div class="left_box2" style="height: auto; min-height: 665px; overflow: hidden; width:59vw; margin-top: 10px;">
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
		</div>
	</section>
<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript"> 

$(document).ready(function () {

	fn_drawTargetNGrid();
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectInaccessibleList", postData : "", datatype:"json" }).trigger("reloadGrid");
	// 엔터 입력시 발생하는 이벤트
	$('#host_name, #path').keyup(function(e) {
		if (e.keyCode == 13) {
		    $("#btnSearch").click();
	    }        
	});
	
	// 검색 조회
	$("#btnSearch").click(function(e){
		var postData = {
			host_name : $("#host_name").val(),
			path : $("#path").val()
		};

		$("#targetGrid").setGridParam({
			url:"<%=request.getContextPath()%>/target/selectInaccessibleList",
			postData : postData, 
			datatype:"json" 
		}).trigger("reloadGrid");
	});
	
});

var resetFomatter = null;

function fn_drawTargetNGrid() {
	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 585;
	
	$("#targetGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectInaccessibleList",
		datatype: "local",
	   	mtype : "POST",
		colNames:[ '확인 여부', '초기 확인 여부', '등록 여부', '초기 등록 여부', 'TARGET_ID', 'AGENT_ID', 'AP_NO', '연결 서버', '서버 구분', '호스트명', 'IP',  '검출 불가 경로', 'SEVERITY', 'DESCRIPTION', 'TIMESTAMP', 'SCHEDULE_CHK', 'LOCATION_ID'],
		colModel: [      
			{ index: 'CHK_STATUS', 				name: 'CHK_STATUS', 			width: 5, 	align: 'center', formatter: createCheckbox},
			{ index: 'CHK_STATUS_F', 			name: 'CHK_STATUS_F', 			width: 5, 	align: 'center', hidden:true},
			{ index: 'REG_STATUS', 				name: 'REG_STATUS', 			width: 5, 	align: 'center', formatter: regCheck},
			{ index: 'REG_STATUS_F', 			name: 'REG_STATUS_F', 			width: 5, 	align: 'center', hidden:true},
			{ index: 'TARGET_ID', 				name: 'TARGET_ID',				width: 0, 	align: 'left', hidden:true},
			{ index: 'AGENT_ID', 				name: 'AGENT_ID',				width: 0, 	align: 'left', hidden:true},
			{ index: 'AP_NO', 					name: 'AP_NO',					width: 0, 	align: 'left', hidden:true},
			{ index: 'SERVER_NM', 				name: 'SERVER_NM',				width: 10, 	align: 'center'},
			{ index: 'HOSTNAME', 				name: 'HOSTNAME',				width: 10, 	align: 'center', hidden:true},
			{ index: 'NAME', 					name: 'NAME',					width: 10, 	align: 'center'},
			{ index: 'AGENT_CONNECTED_IP', 		name: 'AGENT_CONNECTED_IP',		width: 10, 	align: 'center'},
			{ index: 'PATH', 					name: 'PATH',					width: 70, 	align: 'left'},
			{ index: 'SEVERITY',				name: 'SEVERITY',				width: 0, 	align: 'center', hidden:true},
			{ index: 'DESCRIPTION', 			name: 'DESCRIPTION',			width: 0, 	align: 'left', hidden:true},
			{ index: 'TIMESTAMP', 				name: 'TIMESTAMP', 				width: 0, 	align: 'center', hidden:true},
			{ index: 'SCHEDULE_CHK', 			name: 'SCHEDULE_CHK', 			width: 0, 	align: 'center', hidden:true},
			{ index: 'LOCATION_ID', 			name: 'LOCATION_ID', 			width: 0, 	align: 'center', hidden:true},
		],
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		shrinkToFit: true,
		pager: "#targetGridPager",
		rownumbers : false, // 행번호 표시여부
// 		multiselect: true,
		mutipageSelection: true,
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:20,  
		rowList:[25,50,100],			
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
	  	},
	  	ondblClickRow: function(nRowid, icol, cellcontent, e){
	  	},
	  	onCellSelect: function(rowid,icol,cellcontent,e) {
	    },
		loadComplete: function(data) {
		},
		gridComplete : function() {
		},
		beforeSelectRow: function(nRowid, e) {
        	if (e.target.type !== "checkbox") {
        		return false;
        	}
        }
	});
}

function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
    var chkValue = rowObject['CHK_STATUS'];
    var id = rowObject['TARGET_ID'];
    var path = rowObject['PATH'];
    
    if(resetFomatter == "downloadClick"){
	    if (cellvalue == "Y"){
	    	return "확인";
	    } else {
	    	return "미확인";
	    }
    }else {
	    if (cellvalue == "Y"){
	    	return "<input id=gridChkValue" + rowID + " type=\"checkbox\" name=\"chkValue\" value=\""+rowID+"\" checked onclick='changeStatus(\""+rowID+"\", \"gridChkValue\")'>"
	    			+ "<input style=\"display: none;\" id=\"firstChkValue_"+rowID+"\" value=\"Y\")'>";
	    } else {
	    	return "<input id=gridChkValue" + rowID + " type=\"checkbox\" name=\"chkValue\" value=\""+rowID+"\" onclick='changeStatus(\""+rowID+"\", \"gridChkValue\")'>"
	    			+ "<input style=\"display: none;\" id=\"firstChkValue_"+rowID+"\" value=\"N\")'>";
	    }
	}
  }
    

function regCheck(cellvalue, options, rowObject) {
    var rowID = options['rowId'];
    var regValue = rowObject['REG_STATUS'];
    var id = rowObject['TARGET_ID'];
    var path = rowObject['PATH'];
    
    if(resetFomatter == "downloadClick"){
	    if (regValue == "Y"){
	    	return "등록";
	    } else {
	    	return "미등록";
	    }
    }else {
	    if (cellvalue == "Y"){
	    	return "<input id=gridRegValue" + rowID + " type=\"checkbox\" name=\"regValue\" value=\""+rowID+"\" checked onclick='changeStatus(\""+rowID+"\", \"gridRegValue\")'>" 
	    			+ "<input style=\"display: none;\" id=\"firstRegValue_"+rowID+"\" value=\"Y\")'>";
	    } else {
	    	return "<input id=gridRegValue" + rowID + " type=\"checkbox\" name=\"regValue\" value=\""+rowID+"\" onclick='changeStatus(\""+rowID+"\", \"gridRegValue\")'>";
	    			+ "<input style=\"display: none;\"  id=\"firstRegValue_"+rowID+"\" value=\"N\")'>"
	    }
	}
    
}

/* 등록 List */
var chkMap = new Map();
var regMap = new Map();

function changeStatus(rowID, status) {
	
	if(status=="gridChkValue"){ // 확인 여부
		
		var value = $("#"+status+rowID).val();
		
		console.log("=====================");
		console.log(value);
	
		if(value == null){
			value = 'Y';
		}
		
		// 체크된 대상 기본 값 정의
		
		if($("#gridChkValue"+rowID).prop("checked")){
			$("#targetGrid").jqGrid('setCell', rowID, 'CHK_STATUS', "Y");
			chkMap.set(rowID, "Y");
		}else{
			$("#targetGrid").jqGrid('setCell', rowID, 'CHK_STATUS', "N");
			chkMap.set(rowID, "N");
		}
	}else if(status=="gridRegValue"){ // 등록 여부
		
		var value = $("#"+status+rowID).val();
		
		if(value == null){
			value = 'Y';
		}
		
		// 체크된 대상 기본 값 정의
		
		/* 중복 선택 방지  */
		if($("#gridRegValue"+rowID).prop("checked")){
			$("#targetGrid").jqGrid('setCell', rowID, 'REG_STATUS', "Y");
			regMap.set(rowID, "Y");
		}else{
			$("#targetGrid").jqGrid('setCell', rowID, 'REG_STATUS', "N");
			regMap.set(rowID, "N");
		}
	}
}
	
// 	var value = "";
	
// 	var postData = {
// 		id : id,
// 		path : path,
// 		value : $("#gridRegValue"+rowID).is(":checked") ? "Y" : "N"
// 	}
	
// 	$.ajax({
// 		type: "POST",
// 		url: "${getContextPath}/target/updateChkStatus",
// 		async : false,
// 		data : postData,
// 		datatype: "json",
// 		success: function (result) {
// 			if (result.resultCode != 0) {
// 		        alert("FAIL : " + result.resultMessage);
// 		        $("#taregtGrid").trigger("reloadGrid");
// 	        	return;
// 		    }
// 	        if (result.resultCode == 0) {
// 	        	$("#taregtGrid").jqGrid('setCell',rowid,'CHK_STATUS',value);
// 	        }
// 		},
// 		error: function (request, status, error) {
// 	        console.log("ERROR : ", error);
// 	    }
// 	});  
// }


var regResultMap = new Map();
var regResultList = [];
var chkResultMap = new Map();
var chkResultList = [];
/* 적용 버 튼 클릭 */
$("#btnRegist").on("click", function(e) {
	var TotalData = $("#targetGrid").jqGrid('getGridParam', 'data');
	regResultList = [];
	for (var [key, value] of regMap) {
		regResultMap = new Map();

		var rowData = TotalData[key-1];

		var rowStatus_F = rowData["REG_STATUS_F"];
		var rowStatus 	= value;
				 
		console.log(rowStatus_F);
		console.log(rowStatus);
		
		if(rowStatus_F != rowStatus){ // 값의 변동이 있는경우
			regResultList.push({"target_id": rowData["TARGET_ID"], 
								"agent_id": rowData["AGENT_ID"],
								"location_id": rowData["LOCATION_ID"],
								"path": rowData["PATH"], 
								"ap_no": rowData["AP_NO"]+"", 
								"rowStatus": rowStatus})
			
// 			regResultMap.set("target_id", rowData["TARGET_ID"]);
// 			regResultMap.set("agent_id", rowData["AGENT_ID"]);
// 			regResultMap.set("path", rowData["PATH"]);
// 			regResultMap.set("rowStatus", rowStatus);
	 			
// 			regResultList.push(regResultMap);
		}
	}
	
	chkResultList = [];
	console.log(chkMap);
	for (var [key, value] of chkMap) {
		chkResultMap = new Map();

		var rowData = TotalData[key-1];
 		
		var rowStatus_F = rowData["REG_STATUS_F"];
		var rowStatus 	= value;
		
		if(rowStatus_F != rowStatus){ // 값의 변동이 있는경우
			chkResultList.push({"target_id": rowData["TARGET_ID"], 
								"agent_id": rowData["AGENT_ID"],
								"location_id": rowData["LOCATION_ID"],
								"path": rowData["PATH"], 
								"ap_no": rowData["AP_NO"]+"", 
								"rowStatus": rowStatus})
							
// 			chkResultMap.set("target_id", rowData["TARGET_ID"]);
// 			chkResultMap.set("agent_id", rowData["AGENT_ID"]);
// 			chkResultMap.set("path", rowData["PATH"]);
// 			chkResultMap.set("rowStatus", rowStatus);
	 			
// 			chkResultList.push(chkResultMap);
		}
	}
	
	console.log(regResultList);
	console.log(chkResultMap);
	
	if(regResultList == null || chkResultMap == null ){
		alert("변경된 값이 존재하지 않습니다.");
		return;
	}
	
	var oPostDt = {};
    oPostDt["regResultList"] = regResultList;
    oPostDt["chkResultList"] = chkResultList;
	
	var postData = {regResultList : regResultList, chkResultList :chkResultList};
	$.ajax({
		type: "POST",
        url: "${getContextPath}/target/updateInaccess",
        async : false,
        data : JSON.stringify(oPostDt),
        contentType: 'application/json; charset=UTF-8',
		success: function (result) {
			if (result.resultCode != 0) {
		        alert("FAIL : " + result.resultMessage);
		        $("#taregtGrid").trigger("reloadGrid");
	        	return;
		    }
	        if (result.resultCode == 0) {
	        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectInaccessibleList", postData : "", datatype:"json", page:1 }).trigger("reloadGrid");
	        	alert("적용이 완료되었습니다.");
	        }
		},
		error: function (request, status, error) {
	        console.log("ERROR : ", error);
	    }
	});  
	
});

$("#btnDownloadExcel").click(function(){
	resetFomatter = "downloadClick";
	
	$("#targetGrid").jqGrid("exportToCsv",{
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
        includeHeader: false,
        exportHiddenColumns: false,
        fileName : "INACCESSIBLE_LOCATIONS.csv",
        mimetype : "text/csv; charset=utf-8",
        event : resetFomatter,
        returnAsString : false,
        customFormatter: function (options, rowId, rowData, colModel) {
            // rowData는 내보내려는 행의 데이터
            // colModel은 그리드의 열 모델 설정
            var row = '', colValue;
            for (var i = 0; i < colModel.length; i++) {
                // exportable 속성이 설정되지 않았거나 true로 설정된 열만 처리
                if (colModel[i].exportable !== false) {
                    colValue = rowData[colModel[i].name];
                    // 필요한 경우 colValue를 조작할 수 있음
                    // CSV 형식에 맞춰서 데이터를 row에 추가
                    row += '"' + colValue + '"' + (i < colModel.length - 1 ? ',' : '');
                }
            }
            return row;
        }
    });
	
	resetFomatter = null;
	$("#targetGrid").jqGrid("showCol",["CHK"]);
});

</script>
</body>

</html>