<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
h4 {
	margin : 5px 0;
	font-size: 0.8vw;
}
</style>
 
	<!-- section -->
	<section id="section">
		<!-- container -->
		<div class="container">
			<h3>개인정보 유형</h3>
			<div class="content magin_t25">
				<div class="grid_top">
					<table class="user_info" style="display: inline-table; width: 510px; position: relative; bottom: 32px;">
						<caption>개인정보 유형</caption>
						<tbody>
							<tr>
								<th style="text-align: center; width:40px; border-radius: 0.25rem;">유형 명</th>
								<td style="width:300px;">
									<input type="text" id="searchLocation" value="" class="edt_sch" style="width: 93%; height: 26.5px; margin: 5px 0; padding-left:5px;" placeholder="개인정보 유형명을 입력하세요.">
									<input type="button" name="button" class="btn_route" style="margin-top: 10px; margin-right: 5px;" id="btnSearch">
								</td>
							</tr>
						</tbody>
					</table>
					<div class="legend" style="margin-left: 575px; margin-top: 5px; border-radius: 0.25rem;">
						<div class="legend_info" >
							<p style="padding-left: 13px;">범례</p>
							<table class="legend_tbl">
								<colgroup>
									<col width="20%">
									<col width="*">
								</colgroup>
								<tbody id="legend_detail">
								<tr>
									<th>주민등록번호</th>
								</tr>
								<tr>
									<td style="padding-left: 25px;">
										1.<input type='checkbox' id='test_chk1' name='chk_dataType' class='chk_lock' value='rrn' style="margin-top: 2px; margin-left: 5px;" disabled="disabled">
										2.<input type='checkbox' id='test_chk2' style="margin-top: 2px; margin-left: 5px;"  disabled="disabled">
										3.<input type='text' id='test_cnt' size='4' disabled='disabled' style="margin-top: 2px; margin-left: 5px;">
									</td>
								</tr>
								</tbody>
							</table>
						</div>
						<div class="legend_description">
							<p style="padding-top: 6px;">1. 임계치 사용여부 체크</p>
							<p>2. 중복제거 사용여부 체크</p>
							<p>3. 임계치 사용 시 임계값 입력</p>
						</div>
					</div>
					<div class="list_sch" style="margin-top: 50px;">
						<div class="sch_area">
							<button type="button" class="btn_down" id="btnDataTypeBtn" class="btn_new">개인정보 유형 생성</button>
						</div>
					</div>
				</div>
				<div class="left_box2" style="height: auto; min-height: 630px; overflow: hidden; margin-top: 5px;">
					<table id="targetGrid"></table>
					<div id="targetGridPager"></div>
				</div>
			</div>
		</div>
	</section>
	<div id="taskWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
		border-top: 2px solid #222222; box-shadow: 2px 2px 5px #ddd; display:none">
		<ul>
			<!-- <li class="status status-completed status-scheduled status-scanning status-paused status-stopped status-cancelled status-deactivated status-failed">
				<button id="viewBtn" >보기</button></li> -->
			<li  class="status status-completed status-scheduled status-paused status-stopped status-failed">
				<button id="updateBtn">수정 </button></li>
				<!-- 
			<li class="status status-scheduled status-scanning">
				<button id="modifySchedule" >수정</button></li>
				 -->
			<li class="status status-completed status-scheduled status-scanning status-paused status-stopped">
				<button id="deleteBtn">삭제</button></li>
		</ul>
	</div>
	
	<div id="popup_manageSchedule" class="popup_layer" style="display:none;">
		<div class="popup_box" id="popup_box" style="height: 60%; width: 60%; left: 40%; top: 33%; right: 40%; ">
		</div>
	</div>
	<%@ include file="../../include/footer.jsp"%>

<script type="text/javascript"> 

var isCreateProfile = true;

var oGrid = $("#targetGrid");
var pattern = '${pattern}'.split('[{').join('').split('}]').join('');
pattern = pattern.split('}, {');

function change(ele, row) {
	if(ele.checked){
		$("#"+ele.value+"_cnt"+row).val("1");
		$("#"+ele.value+"_cnt"+row).prop('disabled', false);
	}else {
		$("#"+ele.value+"_cnt"+row).val("");
		$("#"+ele.value+"_cnt"+row).prop('disabled', true);
	}
}

function numberChange(ele) {
	ele.value = ele.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
}

function careteProfile(rowID){
	var rowData = $("#targetGrid").getRowData(rowID);
	var scheduleData = {};  // Scan Data Mater Json

	var datatype_name = $("#datatypeName"+rowID).val();
	if (isNull(datatype_name)) {
		alert("저장할 유형명을 입력하세요.");
		return;
	}
	
	// profile(Datatype) 넣기
	var datatypeArr = new Array(); 
	var cntArr = new Array(); 
	var dupArr = new Array(); 
    $('[name=chk_dataType'+rowID+']').each(function(i, element){
	    if (element.checked) {
		    var id = $(element).val();
		    datatypeArr.push(id);
		    cntArr.push($("#" + id+"_cnt"+rowID).val());
			dupArr.push(($("#dup_" + id).is(":checked"))?1:0)
	    }
    });

	if (datatypeArr.length == 0) {
		alert("개인정보 유형을 선택하세요.");
		return;
	}
	
	var profileArr = datatypeArr.toString();
	var profileCntArr = cntArr.toString();
	var profileDupArr = dupArr.toString();
	console.log("profileArr : " + profileArr);
	
	var ocr = $("#chkOcr"+rowID).is(":checked") ? "1" : "0";
	var recent = $("#chkRecent"+rowID).is(":checked") ? "1" : "0";
	var capture = "1";
	
	var postData = {
		datatype_name : datatype_name,
		profileArr : profileArr, 
		cntArr : profileCntArr, 
		dupArr : profileDupArr, 
		ocr : ocr,
		capture : capture,
		recent: recent,
		datatype_id: rowData.DATATYPE_ID
	};
	
	var tttt = JSON.stringify(postData);
	console.log("postData 확인 : " + tttt);
	
	var message = "개인정보 유형을 만드시겠습니까?";
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			//url: "/scan/insertProfile",
			url: "/search/insertProfile",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode == 201) {
		        	alert("개인정보유형 생성되었습니다.");
		        	
		        } else {
			        alert("데이터 유형 변경이 실패 되었습니다.\n관리자에게 문의 하십시오");
			    }
		        isCreateProfile = true;
		        var postData = {};
	        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
		    	
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
}

function updateProfile(rowID){
	var rowData = $("#targetGrid").getRowData(rowID);
	var scheduleData = {};  // Scan Data Mater Json

	var datatype_name = $("#datatypeName"+rowID).val();
	if (isNull(datatype_name)) {
		alert("저장할 유형명을 입력하세요.");
		return;
	}

	// profile(Datatype) 넣기
	var datatypeArr = new Array(); 
	var cntArr = new Array(); 
	var dupArr = new Array(); 
    $('[name=chk_dataType'+rowID+']').each(function(i, element){
	    if (element.checked) {
		    var id = $(element).val();
		    datatypeArr.push(id);
		    cntArr.push($("#" + id+"_cnt"+rowID).val());
			dupArr.push(($("#dup_" + id).is(":checked"))?1:0)
	    }
    });

	if (datatypeArr.length == 0) {
		alert("개인정보 유형을 선택하세요.");
		return;
	}
	
	var profileArr = datatypeArr.toString();
	var profileCntArr = cntArr.toString();
	var profileDupArr = dupArr.toString();
	console.log("profileArr : " + profileArr);
	
	var ocr = $("#chkOcr"+rowID).is(":checked") ? "1" : "0";
	var recent = $("#chkRecent"+rowID).is(":checked") ? "1" : "0";
	var capture = "1";
	
	var postData = {
		datatype_name : datatype_name,
		profileArr : profileArr, 
		cntArr : profileCntArr, 
		dupArr : profileDupArr, 
		ocr : ocr,
		recent : recent,
		capture : capture,
		datatype_id: rowData.DATATYPE_ID,
		std_id: rowData.STD_ID
	};
	
	var tttt = JSON.stringify(postData);
	
	var message = "개인정보 유형을 변경하시겠습니까?";
	if (confirm(message)) {
		$.ajax({
			type: "POST",
			url: "/search/updateProfile",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode == 201) {
		        	alert("데이터 유형 변경하였습니다.");
		        	var postData = {};
		        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
			    } else {
			        alert("데이터 유형 변경이 실패 되었습니다.\n관리자에게 문의 하십시오");
			    }
		    },
		    error: function (request, status, error) {
				alert("Server Error : " + error);
		        console.log("ERROR : ", error);
		    }
		});
	}
}



function createProfileCencel(rowId) {
	var postData = {};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");

	isCreateProfile = true;
}

function cancelProfile(rowId) {
	var rowData = $("#targetGrid").getRowData(rowId);
	
	$("#targetGrid").setCell(rowId, "DATATYPE_LABEL_COPY", rowData.DATATYPE_LABEL);
    
    var html = ""; 
	
    html = "<input type='checkbox' disabled='disabled' "+((rowData.RRN == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.RRN_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.RRN_CNT > 0)? rowData.RRN_CNT : '';
	$("#targetGrid").setCell(rowId, 'RRN_CHK', html);
  
    html = "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.FOREIGNER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.FOREIGNER_CNT > 0)? rowData.FOREIGNER_CNT : '';
	$("#targetGrid").setCell(rowId, 'FOREIGNER_CHK', html);
    
    html = "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.DRIVER_DUP == 1)?"checked='checked'":"")+">&nbsp;";
 	html += (rowData.DRIVER_CNT > 0)? rowData.DRIVER_CNT : '';
	$("#targetGrid").setCell(rowId, 'DRIVER_CHK', html);
    
    html = "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.PASSPORT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.PASSPORT_CNT > 0)? rowData.PASSPORT_CNT : '';
	$("#targetGrid").setCell(rowId, 'PASSPORT_CHK', html);
	
    html = "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.ACCOUNT_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.ACCOUNT_CNT > 0)? rowData.ACCOUNT_CNT : '';
	$("#targetGrid").setCell(rowId, 'ACCOUNT_CHK', html);
    
    html = "<input type='checkbox' disabled='disabled' "+((rowData.CARD == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.CARD_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.CARD_CNT > 0)? rowData.CARD_CNT : '';
	$("#targetGrid").setCell(rowId, 'CARD_CHK', html);
	
	html = "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.EMAIL == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.EMAIL_CNT > 0)? rowData.EMAIL_CNT : '';
	$("#targetGrid").setCell(rowId, 'EMAIL_CHK', html);
	
    html = "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.LOCAL_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.LOCAL_PHONE_CNT > 0)? rowData.LOCAL_PHONE_CNT : '';
	$("#targetGrid").setCell(rowId, 'LOCAL_PHONE_CHK', html);
    
    html = "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE == 1)?"checked='checked'":"")+">&nbsp;";
	html += "<input type='checkbox' disabled='disabled' "+((rowData.MOBILE_PHONE_DUP == 1)?"checked='checked'":"")+">&nbsp;";
	html += (rowData.MOBILE_PHONE_CNT > 0)? rowData.MOBILE_PHONE_CNT : '';
	$("#targetGrid").setCell(rowId, 'MOBILE_PHONE_CHK', html);
    
	html = "<input type='checkbox' disabled='disabled' "+((rowData.OCR == 1)?"checked='checked'":"")+">&nbsp;";
    $("#targetGrid").setCell(rowId, 'OCR_CHK', html);
    
    html = "<input type='checkbox' disabled='disabled' "+((rowData.RECENT == 1)?"checked='checked'":"")+">&nbsp;";
    $("#targetGrid").setCell(rowId, 'RECENT_CHK', html);
    
    $("#targetGrid").setCell(rowId, 'BUTTON', "<button type='button' class='gridSubSelBtn' style='margin-left: 7px' name='gridSubSelBtn'>선택</button>");

    $(".gridSubSelBtn").on("click", function(e) {
  		e.stopPropagation();
		
		$("#targetGrid").setSelection(event.target.parentElement.parentElement.id);
		
		var offset = $(this).parent().offset();
		$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + "px");
		// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
		$("#taskWindow").css("top", offset.top + $(this).height() + "px");

		var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
		var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

		if (taskBottom > bottomLimit) { 
			$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
		}
		$("#taskWindow").show();
	}); 
}

$(document).ready(function () {

	$(document).click(function(e){
		$("#taskWindow").hide();
	});
	
	$("#btnDataTypeBtn").click(function(){
		var rowId = $("#targetGrid").getGridParam("reccount");
		
		isCreateProfile = false;
		
		var rowData = {
			"DATATYPE_ID": " ",
			"DATATYPE_LABEL_COPY": "<input type='text' name='datatypeName"+rowId+"' id='datatypeName"+rowId+"' value='' style='width: 100%;' placeholder='개인정보 유형명을 입력하세요.'>",
			"DATATYPE_LABEL": " "};
			
			 for(var i = 0; pattern.length > i; i++){
             	
             	var row = pattern[i].split(', ');
         		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
         		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
         		var data_id = PATTERN_NAME.split('=')[1];
         		
         		var custom_nm = data_id;
         		var custom_nm_dup = data_id+"_DUP";
         		var custom_nm_cnt = data_id+"_CNT";
         		var custom_nm_chk = data_id+"_CHK";

         		rowData[custom_nm_chk] = "<input type='checkbox' id='chk_'"+custom_nm+" name='chk_dataType"+rowId+"' class='chk_lock' onchange='change(this,"+rowId+")' value='"+custom_nm+"'>&nbsp;"
    			+ "<input type='checkbox' id='dup_"+custom_nm+"'>&nbsp;"
                + "<input type='text' id='"+custom_nm+"_cnt"+rowId+"' disabled='disabled' size='4' oninput='numberChange(this)'>",
         		rowData[custom_nm] =" ";
         		rowData[custom_nm_cnt] = " ";
         		
			 };
			
			 rowData["OCR_CHK"] = "<input type='checkbox' id='chkOcr"+rowId+"' name='chkOcr"+rowId+"' class='chk_lock' />" ;
			 rowData["OCR"] = " ";
			 rowData["VOICE"] = "0";
			 rowData["RECENT_CHK"] = "<input type='checkbox' id='chkRecent"+rowId+"' name='chkRecent"+rowId+"' class='chk_lock' />";
			 rowData["RECENT"] = " ";
			 rowData["BUTTON"] = "<button type='button' class='gridSubSelBtn' name='updateProfileBtn' onclick='careteProfile("+rowId+")'>생성</button>"
				+"<button type='button' class='gridSubSelBtn' name='cancelProfileBtn' onclick='createProfileCencel("+rowId+")'>취소</button>";
			 
		$("#targetGrid").addRowData(rowId+1, rowData, 'first');
		//window.location = "${pageContext.request.contextPath}/scan/pi_datatype_insert";
	});
	
	$("#taskWindow").click(function(e){
		e.stopPropagation();
	});
	$("#taskWindowClose").click(function(){
		$("#taskWindow").hide();
	});
	
  	$("#viewWindow").draggable({
 	    containment: '.content',
 	 	cancel : '.popup_content, .popup_btn'
	});
	
	$("#viewWindowClose").click(function(){
		$("#viewWindow").hide();
	});
	
	
	$("#vieDetailsClose").click(function(){
		$("#viewDetails").hide();
	})

	var ifConnect = function(cellvalue, options, rowObject) {
		console.log('cellvalue BEFORE :: ' + cellvalue);
		if(cellvalue == null || cellvalue == ''){
			cellvalue = '<target deleted>'
		}
		console.log('cellvalue AFTER :: ' + cellvalue);
		return cellvalue.indexOf("<") >= 0 ? '< ' + cellvalue.replace("<","").replace(">","") + ' >' : cellvalue;
	};
	
	var createView = function(cellvalue, options, rowObject) {
		//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
		return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>"; 
	};
	
	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd',
		onSelect: function(dateText) {
			$("#btnSearchScan").click();
		}
	});

	targetGridLoad();
	
	// 초기 조회
	var postData = {};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
	
	// 버튼 Action 설정
	$("#btnSearchScan").click(function() {

		var idx = 1;		
		var searchType = ['scheduled'];
		$("input[name=chk_schedule]:checked").each(function(i, elem) {
			searchType[idx++] = $(elem).val();	
		});

		var postData = {};

		$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
    });

	$("#searchHost").keyup(function(e){
		if (e.keyCode == 13) {
			$("#btnSearchScan").click();
		}
	});
	
	$("#updateBtn").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		
		var rowData = $("#targetGrid").getRowData(row);
		
		$("#targetGrid").setCell(row, "DATATYPE_LABEL_COPY", "<input type='text' name='datatypeName"+row+"' id='datatypeName"+row+"' value='"+ rowData.DATATYPE_LABEL +"' style='width: 100%;'>");

		var text = "";
		
		 for(var i = 0; pattern.length > i; i++){
         	
         	var patternRow = pattern[i].split(', ');
     		var ID = patternRow[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
     		var PATTERN_NAME = patternRow[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
     		var data_id = PATTERN_NAME.split('=')[1];
         	
     		var custom_nm = data_id;
     		var custom_nm_dup = data_id+"_DUP";
     		var custom_nm_cnt = data_id+"_CNT";
     		var custom_nm_chk = data_id+"_CHK";
     		
     		text = "<input type='checkbox' id='chk_'"+custom_nm+" name='chk_dataType"+row+"' class='chk_lock' onchange='change(this,"+row+")' value='"+custom_nm+"' "
    		text += ((rowData[custom_nm] == 1)? "checked" : "") + ">&nbsp;"
    		text += "<input type='checkbox' id='dup_"+custom_nm+"' ";
    		text += ((rowData[custom_nm_dup] == 1)? "checked" : "") + ">&nbsp;"
    		text += "<input type='text' id='"+custom_nm+"_cnt"+row+"' size='4' oninput='numberChange(this)' "
    		text += (rowData[custom_nm] == 1)? "value='"+ rowData[custom_nm_cnt] +"'" : "disabled"
    		text += ">"
    		$("#targetGrid").setCell(row, custom_nm_chk, text);
         }
		
		if(rowData.OCR == 1){
			$("#targetGrid").setCell(row, "OCR_CHK", "<input type='checkbox' id='chkOcr"+row+"' name='chkOcr"+row+"' class='chk_lock' checked/>");
		} else {
			$("#targetGrid").setCell(row, "OCR_CHK", "<input type='checkbox' id='chkOcr"+row+"' name='chkOcr"+row+"' class='chk_lock' />");
		}
		
		if(rowData.RECENT == 1){
			$("#targetGrid").setCell(row, "RECENT_CHK", "<input type='checkbox' id='chkRecent"+row+"' name='chkRecent"+row+"' class='chk_lock' checked/>");
		} else {
			$("#targetGrid").setCell(row, "RECENT_CHK", "<input type='checkbox' id='chkRecent"+row+"' name='chkRecent"+row+"' class='chk_lock' />");
		}
		
		$("#targetGrid").setCell(row, "BUTTON", "<button type='button' class='gridSubSelBtn' name='updateProfileBtn' onclick='updateProfile("+row+")'>수정</button>"
				+"<button type='button' class='gridSubSelBtn' name='cancelProfileBtn' onclick='cancelProfile("+row+")'>취소</button>");
		
	});
	
	
	$("#deleteBtn").click(function(){
		$("#taskWindow").hide();
		var row = $("#targetGrid").getGridParam( "selrow" );
		var id = $("#targetGrid").getCell(row, 'STD_ID');
		var name = $("#targetGrid").getCell(row, 'DATATYPE_LABEL');
		
		var postData = {datatype_id: id, datatype_label : name};
		
		var message = "정말 삭제하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/search/deleteProfile",
				async : false,
				data : postData,
			    success: function (resultMap) {
			    	console.log("asdf");
			    	console.log(resultMap);
			        if (resultMap.resultCode == 0) {
			        	alert("삭제를 완료하였습니다.");
			        	var postData = {};
			        	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
				    } else if(resultMap.resultCode == -9) {
				        alert("삭제 할 수 없는 정책 입니다.");
				    } else {
				    	alert("삭제를 실패하였습니다.");
				    }
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
	});
	
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});
	
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
        fileName : "스케줄리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        returnAsString : false
    })
}

/**
 * id : schedule ID, 
 * task : 변경할 Task 
 * row : 그리드의 변경 Row ID
 * Task 변경 규칙 
 * 	- deactivate -->  deactivated
 * 	- modify --> 스캐줄 정의 및 등록 화면으로 이동, 
 * 	- skip --> scheduled
 * 	- pause --> paused
 * 	- restart --> scheduled
 * 	- stop --> scheduled
 * 	- cancel --> cancelled
 * 	- reactivate --> scheduled
 */
 
function targetGridLoad(){
	 
		
	var gridWidth = $("#targetGrid").parent().width();
	var gridHeight = 550;
 
	var patternCnt = ${patternCnt};
	var colNames = [];
	var colModel = [];
	
	colNames.push('아이디','통괄아이디','개인정보유형명', '타입 유형명카피');
	
	for(var i=0; i < patternCnt ; i++){
		var row = pattern[i].split(', ');
		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
		var data_id = PATTERN_NAME.split('=')[1];
		
		colNames.push(ID.split('=')[1]);
		colNames.push(ID.split('=')[1]+" 체크");
		colNames.push(ID.split('=')[1]+" 임계치");
		colNames.push(ID.split('=')[1]+" 중복");
	}
	colNames.push('OCR', 'OCR체크', '증분검사CHK', '증분검사', 'VOICE', '작업');
	
	colModel.push({ index: 'DATATYPE_ID', 				name: 'DATATYPE_ID',				width:1, align:'center', hidden:true});
	colModel.push({ index: 'STD_ID', 						name: 'STD_ID',				width:1, align:'center', hidden:true});
	colModel.push({ index: 'DATATYPE_LABEL_COPY',			name: 'DATATYPE_LABEL_COPY',		width: 100, align: 'left'});
	colModel.push({ index: 'DATATYPE_LABEL',				name: 'DATATYPE_LABEL',				width: 150, align: 'left', hidden: true});
	
	for(var i = 0; pattern.length > i; i++){
		
		var row = pattern[i].split(', ');
		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
		var data_id = PATTERN_NAME.split('=')[1];
		
		colModel.push({ index: data_id+"_CHK", 				name: data_id+"_CHK", 				width: 40, align: 'left', sortable: false });
		colModel.push({ index: data_id, 					name: data_id, 						width: 40, align: 'left', hidden: true});
		colModel.push({ index: data_id+"_CNT", 				name: data_id+"_CNT", 				width: 40, align: 'left', hidden: true});
		colModel.push({ index: data_id+"_DUP", 				name: data_id+"_DUP", 				width: 40, align: 'left', hidden: true});
	};
	
	colModel.push({ index: 'OCR_CHK', 					name: 'OCR_CHK', 					width: 40, align: 'left', sortable: false, hidden: true });
	colModel.push({ index: 'OCR', 						name: 'OCR', 						width: 40, align: 'left', hidden: true });
	colModel.push({ index: 'RECENT', 						name: 'RECENT', 					width: 20, align: 'left', hidden: true });
	colModel.push({ index: 'RECENT_CHK', 					name: 'RECENT_CHK', 				width: 20, align: 'center'});
	colModel.push({ index: 'VOICE', 						name: 'VOICE', 						width: 40, align: 'center', hidden: true});
	colModel.push({ index: 'BUTTON', 						name: 'BUTTON',						width: 40, align: 'center', sortable: false });
	
	console.log(colModel);
	
	$("#targetGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:colNames,
		colModel:colModel,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:20,
	   	rowList:[20,50,100],			
		pager: "#targetGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  	
	  	},
	  	ondblClickRow: function(nRowid, icol, cellcontent, e){
	  		
	  	},
		loadComplete: function(data) {
			var ids = $("#targetGrid").getDataIDs() ;
            $.each(ids, function(idx, rowId) {
                rowData = $("#targetGrid").getRowData(rowId, true) ;
                $("#targetGrid").setCell(rowId, 'DATATYPE_LABEL_COPY', rowData.DATATYPE_LABEL);
                
                var html = ""; 
                
                for(var i = 0; pattern.length > i; i++){
                	
                	var row = pattern[i].split(', ');
            		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
            		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
            		var data_id = PATTERN_NAME.split('=')[1];
                	
            		var custom_nm = data_id;
             		var custom_nm_dup = data_id+"_DUP";
             		var custom_nm_cnt = data_id+"_CNT";
             		var custom_nm_chk = data_id+"_CHK";
            		
            		html = "<input type='checkbox' disabled='disabled' "+((rowData[data_id] == 1)?"checked='checked'":"")+">&nbsp;";
	            	html += "<input type='checkbox' disabled='disabled' "+((rowData[custom_nm_dup] == 1)?"checked='checked'":"")+">&nbsp;";
	            	html += (rowData[custom_nm_cnt] > 0)? rowData[custom_nm_cnt] : '';
	            	
	            	console.log(html);
	            	$("#targetGrid").setCell(rowId, custom_nm_chk, html);
                }
                
                $("#targetGrid").setCell(rowId, 'BUTTON', "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn' style='margin-left: 7px'>선택</button>");
            });
			
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#targetGrid").setSelection(event.target.parentElement.parentElement.id);
				
				var offset = $(this).parent().offset();
				$("#taskWindow").css("left", (offset.left - $("#taskWindow").width()) + 45 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskWindow").css("top").replace("px","")) + $("#taskWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskWindow").css("top", Number($("#taskWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				$("#taskWindow").show();
			}); 
			$('.ui-jqgrid-hdiv').css('height', '35px')
	    },
	    gridComplete : function() {
	    }
	});
}

 

function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if(rowObject[options.colModel['index']] == "1" && options.colModel['index'] == "OCR")
		return "<img src='${pageContext.request.contextPath}/resources/assets/images/img_check.png' />";
	
	if (rowObject[options.colModel['index']] == "1")
		return "<img src='${pageContext.request.contextPath}/resources/assets/images/img_check.png' /><p>"+ rowObject[options.colModel['index'] + "_CNT"] +"</p>";
		//return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' checked disabled>"; 
	else 
		return "";
		//return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' disabled>";
}

function deleteSchedule(){
	$.ajax({
		type: "POST",
		url: "/scan/deleteSchedule",
		async : false,
		data : {
			schedule_id: $('#pop_manageSchedule_schedule_id').val()
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	if(data.resultCode == '0'){
		    	setManageSchedulePop($('#pop_manageSchedule_schedule_id').val());
				alert('스케줄을 삭제 하였습니다.');
	    	} else {
	    		alert('스케줄을 실패하는데 실패하였습니다.');
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error);
	    }
	});
}

function setSchedule(){
	var weekday = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun']
	var startweek = $('#start_weekday').val();
	var starttime = $('#start_time').val();
	var endweek = $('#end_weekday').val();
	var endtime = $('#end_time').val();
	
	if(startweek == endweek && starttime == endtime){
		var key = weekday[startweek] + '_' + (starttime < 10 ? '0'+String(starttime) : starttime);
        $('td[data-key="'+key+'"]').data('value', true);
        $('td[data-key="'+key+'"]').attr('data-value', true);
        $('td[data-key="'+key+'"]').attr('style', 'text-align: center; background: #4dff4d');
        $('td[data-key="'+key+'"]').text('ON');	
        
        $('#start_weekday').val('0').attr('selected', 'selected');
    	$('#start_time').val('0').attr('selected', 'selected');
    	$('#end_weekday').val('0').attr('selected', 'selected');
    	$('#end_time').val('0').attr('selected', 'selected');
    	return;
	}
	
	var week = Number(startweek);
	var time = Number(starttime);
	var flag = true;
	while(flag){
		var key = weekday[week] + '_' + (time < 10 ? '0'+String(time) : time);
        $('td[data-key="'+key+'"]').data('value', true);
        $('td[data-key="'+key+'"]').attr('data-value', true);
        $('td[data-key="'+key+'"]').attr('style', 'text-align: center; background: #4dff4d');
        $('td[data-key="'+key+'"]').text('ON');	
        time = (time + 1) % 24;
        if(time == 0){
        	week = (week+1) % 7;
        }
        if(endweek == week && endtime == time){
        	flag = false;
        }
	}
	
	$('#start_weekday').val('0').attr('selected', 'selected');
	$('#start_time').val('0').attr('selected', 'selected');
	$('#end_weekday').val('0').attr('selected', 'selected');
	$('#end_time').val('0').attr('selected', 'selected');
	
}

$('#searchLocation').keyup(function(e) {
	if (e.keyCode == 13) {
	    $("#btnSearch").click();
    }        
});

$("#btnSearch").click(function(e){
	var postData = {name : $('#searchLocation').val()};
	$("#targetGrid").setGridParam({url:"<%=request.getContextPath()%>/search/getProfile", postData : postData, datatype:"json" }).trigger("reloadGrid");
})

</script>
</body>

</html>