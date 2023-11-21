<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>정책 조회</title>

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
	#gview_targetUserGrid{
		width: 1503px !important;
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
		#gview_targetUserGrid{
			width: 1496px !important;
		}
	}
</style>
</head>
<body>
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c; width: 100%; height: 100%; background: #f9f9f9;">
		<div class="step_content_cell fl_l "style="overflow-y: auto; padding: 0 15px; width: 100%;">
		
			<div class="select_location sch_left" style="height: 60px; min-height: 60px; width:100%; background: #fff; border: 1px solid #c8ced3; border-radius: 0;">
				<div style="position: absolute; top: 10px; right: 10px; padding-top: 0px; font-size: 14px; font-weight: bold;">
				정책명 : <input type="text" id="searchGroup" value="" class="edt_sch" style="width: 180px; margin-bottom: 2px;">
				<button id="btnSearch" class="btn_sch" style="margin-top: 2px;">검색</button>
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

$(document).ready(function() {
	fn_targetUserGrid();
	
	var postData = {
		"policyNm" : ""
	};
	$("#targetUserGrid").setGridParam({url:"<%=request.getContextPath()%>/popup/selectNetPolicy", postData : postData, datatype:"json" }).trigger("reloadGrid");
});


function fn_targetUserGrid() {
	
	var gridWidth = $("#targetUserGrid").parent().width();
	$("#targetUserGrid").jqGrid({
		url: "<%=request.getContextPath()%>/popup/selectUserList",
		datatype: "local",
		//data: temp,
	   	mtype : "POST",
		colNames:['ID','정책명','데이터유형ID', '개인정보 유형',
			'주민등록번호','주민체크','주민갯수','주민중복',
			'외국인등록번호','외국인체크','외국인갯수','외국인중복',
			'운전면허번호','운전체크', '운전갯수','운전중복',
			'여권번호','여권체크','여권갯수','여권중복',
			'계좌번호','계좌체크','계좌갯수','계좌중복',
			'카드번호','카드체크', '카드갯수','카드중복',
			'이메일','이메일체크','이메일갯수','전화중복',
			'휴대전화번호','휴대전화체크','휴대전화갯수','휴대전화중복',
			'OCR', 'OCR체크','증분검사CHK', '증분검사','검출시 동작'],
		colModel: [
			{ index: 'IDX', 			name: 'IDX', 			width: 50, align: "center", hidden:true},
			{ index: 'POLICY_NAME', 	name: 'POLICY_NAME', 	width: 50, align: "center"},
			{ index: 'STD_ID', 			name: 'STD_ID', 		width: 70, align: "left", hidden:true},
			{ index: 'DATATYPE_LABEL', 	name: 'DATATYPE_LABEL', width: 70, align: "center",},
			{ index: 'RRN_CHK', 					name: 'RRN_CHK', 					width: 40, align: 'left', sortable: false },
			{ index: 'RRN', 						name: 'RRN', 						width: 40, align: 'left', hidden: true},
			{ index: 'RRN_CNT', 					name: 'RRN_CNT', 					width: 40, align: 'left', hidden: true},
			{ index: 'RRN_DUP', 					name: 'RRN_DUP', 					width: 40, align: 'left', hidden: true},
			{ index: 'FOREIGNER_CHK', 				name: 'FOREIGNER_CHK', 				width: 40, align: 'left', sortable: false },
			{ index: 'FOREIGNER', 					name: 'FOREIGNER', 					width: 40, align: 'left', hidden: true},
			{ index: 'FOREIGNER_CNT', 				name: 'FOREIGNER_CNT', 				width: 40, align: 'left', hidden: true},
			{ index: 'FOREIGNER_DUP', 				name: 'FOREIGNER_DUP', 				width: 40, align: 'left', hidden: true},
			{ index: 'DRIVER_CHK', 					name: 'DRIVER_CHK', 				width: 40, align: 'left', sortable: false },
			{ index: 'DRIVER', 						name: 'DRIVER', 					width: 40, align: 'left', hidden: true},
			{ index: 'DRIVER_CNT', 					name: 'DRIVER_CNT', 				width: 40, align: 'left', hidden: true},
			{ index: 'DRIVER_DUP', 					name: 'DRIVER_DUP', 				width: 40, align: 'left', hidden: true},
			{ index: 'PASSPORT_CHK', 				name: 'PASSPORT_CHK', 				width: 40, align: 'left', sortable: false },
			{ index: 'PASSPORT', 					name: 'PASSPORT', 					width: 40, align: 'left', hidden: true},
			{ index: 'PASSPORT_CNT', 				name: 'PASSPORT_CNT', 				width: 40, align: 'left', hidden: true},
			{ index: 'PASSPORT_DUP', 				name: 'PASSPORT_DUP', 				width: 40, align: 'left', hidden: true},
			{ index: 'ACCOUNT_CHK', 				name: 'ACCOUNT_CHK', 				width: 40, align: 'left', sortable: false },
			{ index: 'ACCOUNT', 					name: 'ACCOUNT', 					width: 40, align: 'left', hidden: true},
			{ index: 'ACCOUNT_CNT', 				name: 'ACCOUNT_CNT', 				width: 40, align: 'left', hidden: true },
			{ index: 'ACCOUNT_DUP', 				name: 'ACCOUNT_DUP', 				width: 40, align: 'left', hidden: true },
			{ index: 'CARD_CHK', 					name: 'CARD_CHK', 					width: 40, align: 'left', sortable: false },
			{ index: 'CARD', 						name: 'CARD', 						width: 40, align: 'left', hidden: true},
			{ index: 'CARD_CNT', 					name: 'CARD_CNT', 					width: 40, align: 'left', hidden: true },
			{ index: 'CARD_DUP', 					name: 'CARD_DUP', 					width: 40, align: 'left', hidden: true },
			{ index: 'EMAIL_CHK', 					name: 'EMAIL_CHK', 					width: 40, align: 'left', sortable: false },
			{ index: 'EMAIL', 						name: 'EMAIL', 						width: 40, align: 'left', hidden: true},
			{ index: 'EMAIL_CNT', 					name: 'EMAIL_CNT', 					width: 40, align: 'left', hidden: true},
			{ index: 'EMAIL_DUP', 					name: 'EMAIL_DUP', 					width: 40, align: 'left', hidden: true},
			{ index: 'MOBILE_PHONE_CHK', 			name: 'MOBILE_PHONE_CHK', 			width: 40, align: 'left', sortable: false },
			{ index: 'MOBILE_PHONE', 				name: 'MOBILE_PHONE', 				width: 40, align: 'left', hidden: true},
			{ index: 'MOBILE_PHONE_CNT', 			name: 'MOBILE_PHONE_CNT', 			width: 40, align: 'left', hidden: true},
			{ index: 'MOBILE_PHONE_DUP', 			name: 'MOBILE_PHONE_DUP', 			width: 40, align: 'left', hidden: true},
			{ index: 'OCR_CHK', 					name: 'OCR_CHK', 					width: 40, align: 'left', sortable: false, hidden: true },
			{ index: 'OCR', 						name: 'OCR', 						width: 40, align: 'left', hidden: true },
			{ index: 'RECENT', 						name: 'RECENT', 					width: 20, align: 'left', hidden: true },
			{ index: 'RECENT_CHK', 					name: 'RECENT_CHK', 				width: 30, align: 'center'},
			{ index: 'ACTION', 			name: 'ACTION', 		width: 50, align: "center", formatter:createView},
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
	  		var idx = $(this).getCell(rowid, 'IDX');
	  		var policyNm = $(this).getCell(rowid, 'POLICY_NAME');
	  		
	  		$(opener.document).find("#policyId").val(idx);
	  		$(opener.document).find("#policyNm").val(policyNm);
	  		$(opener.document).find("#updatePolicyId").val(idx);
	  		$(opener.document).find("#updatePolicyNm").val(policyNm);
	  		
	  		window.close();
	  	},
	  	onCellSelect : function(rowid){
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			var ids = $("#targetUserGrid").getDataIDs() ;
            $.each(ids, function(idx, rowId) {
                rowData = $("#targetUserGrid").getRowData(rowId) ;
                $("#targetUserGrid").setCell(rowId, 'DATATYPE_LABEL_COPY', rowData.DATATYPE_LABEL);
                
                var html = ""; 
                	
                html = "<input type='checkbox' disabled='disabled' "+((rowData.RRN == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.RRN_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.RRN_CNT > 0)? rowData.RRN_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'RRN_CHK', html);
              
                html = "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.FOREIGNER_CNT > 0)? rowData.FOREIGNER_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'FOREIGNER_CHK', html);
                
                html = "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
             	html += (rowData.DRIVER_CNT > 0)? rowData.DRIVER_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'DRIVER_CHK', html);
                
                html = "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.PASSPORT_CNT > 0)? rowData.PASSPORT_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'PASSPORT_CHK', html);
            	
                html = "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.ACCOUNT_CNT > 0)? rowData.ACCOUNT_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'ACCOUNT_CHK', html);
                
                html = "<input type='checkbox' disabled='disabled' "+((rowData.CARD == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.CARD_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.CARD_CNT > 0)? rowData.CARD_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'CARD_CHK', html);
            	
                html = "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.LOCAL_PHONE_CNT > 0)? rowData.LOCAL_PHONE_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'LOCAL_PHONE_CHK', html);
            	
                html = "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.EMAIL_CNT > 0)? rowData.EMAIL_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'EMAIL_CHK', html);
                
                html = "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
            	html += "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
            	html += (rowData.MOBILE_PHONE_CNT > 0)? rowData.MOBILE_PHONE_CNT : '';
            	$("#targetUserGrid").setCell(rowId, 'MOBILE_PHONE_CHK', html);
                
                /* if(rowData.OCR == 1) $("#targetUserGrid").setCell(rowId, 'OCR_CHK', "<img src='${pageContext.request.contextPath}/resources/assets/images/img_check.png' />");
                else $("#targetUserGrid").setCell(rowId, 'OCR_CHK', '<p></p>'); */
                html = "<input type='checkbox' disabled='disabled' "+((rowData.OCR == 1)?"checked='checked'":"")+">&nbsp;";
                $("#targetUserGrid").setCell(rowId, 'OCR_CHK', html);

                html = "<input type='checkbox' disabled='disabled' "+((rowData.RECENT == 1)?"checked='checked'":"")+">&nbsp;";
                $("#targetUserGrid").setCell(rowId, 'RECENT_CHK', html);
                
                $("#targetUserGrid").setCell(rowId, 'BUTTON', "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn' style='margin-left: 7px'>선택</button>");
            });
	    },
	    gridComplete : function() {
	    }
	});
}

var createView = function(cellvalue, options, rowObject) {
	//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
	var action = rowObject.ACTION;
	var result = "";
	
	if(action == 1){
		result = "즉시 삭제";
	} else if (action == 2){
		result = "즉시 암호화";
	} else if (action == 3){
		result = "익일 삭제"
	} else if (action == 4){
		result = "익일 암호화";
	} else {
		result = "선택 안됨";
	}
	
	
	return result; 
};

$('#searchGroup').keyup(function(e) {
	if (e.keyCode == 13) {
		 search_policy();
    }        
});

$("#btnSearch").click(function(e){
	 search_policy();
})

function search_policy(){
	var postData = {policyNm: $('#searchGroup').val()}
	$("#targetUserGrid").setGridParam({url:"<%=request.getContextPath()%>/popup/selectNetPolicy", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

$(document).on('click', function(event){
	
});

</script>
</html>
