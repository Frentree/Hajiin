<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<%-- <%@ include file="../../include/header_approval.jsp"%> --%>

<%@ include file="../../include/header.jsp"%>

<!-- 검출관리 -->

<!-- section -->
<section>
    <!-- container -->
    <div class="container">
    <%-- <%@ include file="../../include/menu.jsp"%> --%>
        <!-- content -->
        <h3 style="display: inline; top: 25px;">결재내역 상세조회</h3>
        <p style="position: absolute; top: 33px; left: 228px; font-size: 14px; color: #9E9E9E;">전자결재 신청 내역(정탐, 오탐)을 확인하는 화면 입니다.</p>
        <div class="content magin_t35">
    			<div class="grid_top">
					<table class="user_info approvalTh" style="width: 805px;">
						<caption>사용자정보</caption>
						<tbody>
							<tr>
	                            <th style="text-align: center; width:100px; border-radius: 0.25rem;">종류</th>
	                            <td style="width:423px;">
	                                <select id="selectList" name="selectList" style="width:186px;">
	                                    <option value="" selected>전체</option>
	                                    <option value="1" >정탐(삭제)</option>
	                                    <option value="2" >정탐(삭제예정일)</option>
	                                    <option value="3" >오탐(법제도)</option>
	                                    <option value="4" >오탐(삭제 주기)</option>
	                                    <option value="5" >오탐(시스템 파일)</option>
	                                    <option value="6" >오탐(기타)</option>
	                                </select>
	                            </td>
	                            <th style="text-align: center; width:100px">경로</th>
								<td>
									<input type="text" style="width: 389px; font-size: 13px; padding-left: 5px;" size="20" id="schPath" placeholder="경로를 입력하세요.">
									<input type="hidden" id="ap_no" value="">
								</td>
	                            <td>
	                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
	                           	</td>
							</tr>
						</tbody>
					</table>
				</div>
            <div class="left_box2" style="overflow: hidden; max-height: 655px; margin-top: 10px;">
               <table id="targetGrid"></table>
               <div id="targetGridPager"></div>
            </div>
        </div>
    </div>
    <!-- container -->
</section>
<!-- section -->


<%
String browser = "";
String userAgent = request.getHeader("User-Agent");

%>

<!-- 팝업창 시작 하위 로케이션 상세정보 -->
<%
if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
%>
	<div id="pathWindow" style="position:absolute; left: 300px; top: 350px; touch-action: none; width: 60%; height: 365px; z-index: 999; display:none; min-width: 35%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 36px;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 8px;"><h2>하위 경로 정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: pointer;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="pathWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 88%; position:absolute; overflow:auto;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td style="width: 100%; height: 100%;">
								<div id="pathContent" style="overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
} else {
%>
	<div id="pathWindow" style="position:absolute; left: 300px; top: 350px; touch-action: none; width: 60%; height: 365px; z-index: 999; display:none; min-width: 35%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 100%;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 8px;"><h2>하위 경로 정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: pointer;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="pathWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 100%;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td style="width: 100%; height: 100%;">
								<div id="pathContent" style="overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
						
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
}
%>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 개인정보검출 상세정보 -->
<%
if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
%>
	<div id="taskWindow" style="position:absolute; left: 340px; top: 350px; touch-action: none; width: 70%; height: 365px; z-index: 999; display:none; min-width: 30%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 36px;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 8px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: pointer;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="taskWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 100%;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td id="matchCount" style="width: 195px; min-width: 195px; max-width: 195px; height: 50px; padding: 5px;">&nbsp;</td>
							<td style="width: 100%; height: 100%;" rowspan="2">
								<div id="bodyContents" style="background: white; overflow:scroll; height: 315px; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="matchData" style="background: white; overflow:scroll; height: 265px; padding: 5px">&nbsp;</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
} else {
%>
<div id="taskWindow" style="position:absolute; left: 650px; top: 350px; touch-action: none; width: 50%; height: 300px; z-index: 999; display:none; min-width: 30%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 100%;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 8px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: pointer;">
							<img src="${pageContext.request.contextPath}/resources/assets/images/close.gif" title="Close" id="taskWindowClose">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="mxWindowPane">
				<div class="mxWindowPane" style="width: 100%;height: 100%;">
					<table border="1" style="width: 100%;height: 100%;">
					<tbody>
						<tr>
							<td id="matchCount" style="width: 195px; min-width: 195px; max-width: 195px; height: 50px; padding: 5px;">&nbsp;</td>
							<td style="width: 100%; height: 100%;" rowspan="2">
								<div id="bodyContents" style="overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
							</td>
						</tr>
						<tr>
							<td>
								<div id="matchData" style="overflow-y:auto;height: 100%; padding: 5px">&nbsp;</div>
							</td>
						</tr>
					</tbody>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<%
}
%>
<!-- 팝업창 종료 -->


<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript"> 

/* function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['CHK'] == "1")
		return "<b style='font-size:14px;'>+</b>"; 
	else 
		return ""; 
} */

//검출 리스트 하위경로 표시
function createPathbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['CHK'] == "1")
		return '&gt; ' + rowObject['SHORTNAME'];
	else 
		return rowObject['SHORTNAME'];
}
//검출 리스트 그리드 CheckBox 생성
function createCheckbox(cellvalue, options, rowObject) 
{
    var value = rowObject['ID'];
    var str = '';
    /* if(rowObject['APPROVAL_STATUS'] == 'E'){
	    console.log(rowObject['APPROVAL_STATUS']);
    	str = "<input type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + " disabled=\"disabled\" >";
    }else{
    } */
    str = "<input type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + ">";

    if (rowObject['LEVEL'] == "1") return str;
    else return "";
}

String.prototype.replaceAll = function(org, dest){
	return this.split(org).join(dest);
}

function loadTargetGrid(oGrid)
{
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["idx"] = $("#idx").val();

    oGrid.jqGrid({
        //url: "${getContextPath}/manage/selectFindSubpath",
        
        //postData : oPostDt,
        //datatype: "json",
        url: "${getContextPath}/manage/getDetectionApprovalList",
        postData : oPostDt,
        datatype: "local",
        mtype : "POST",
        ajaxGridOptions : {
            type    : "POST",
            async   : true
        },
        colNames:['', '', '', '종류','문서번호','요청자','기안자','결재자','경로'],
        colModel: [
        	{ index: 'ID',            	name: 'ID',          width: 35,  align: 'center', sortable: false, hidden:true},
        	{ index: 'CHK_C',           name: 'CHK_C',          width: 35,  align: 'center', sortable: false, hidden:true},
        	{ index: 'AP_NO',           name: 'AP_NO',          width: 35,  align: 'center', sortable: false, hidden:true},
          	{ index: 'FLAG',       		name: 'FLAG',      width: '10%', align: 'center', sortable: true},
            { index: 'PATH',     		name: 'PATH',           width: '20%', align: 'left', sortable: true},
            { index: 'USER_NAME',     	name: 'USER_NAME',          width: '10%', align: 'center', sortable: true},
            { index: 'OK_USER_NAME',  	name: 'OK_USER_NAME', width: '10%', align: 'center', sortable: true},
            { index: 'ADMIN_USER_NAME',  	name: 'ADMIN_USER_NAME', width: '10%', align: 'center', sortable: true},
            { index: 'FILE_PATH',       name: 'FILE_PATH',      width: '50%', align: 'left', sortable: true},
        ],
        loadonce :true,
        viewrecords: true,
        width: oGrid.parent().width(),
        height: 566,
        loadonce: true,
        shrinkToFit: true,
        pager: "#targetGridPager",
        rownumbers : false,
        rownumWidth : 75,
        jsonReader : {
            id : "ID",
        },
        rowNum:100,
		rowList:[100, 150, 200, 250],
        onCellSelect: function(rowid,icol,cellcontent,e) {
        	$("#pathWindow").hide();
            $("#taskWindow").hide();
            if (icol == 0) return;
            
            e.stopPropagation();
            var isChk = $(this).getCell(rowid, 'CHK_C');
            var isLeaf = $(this).getCell(rowid, 'LEAF');
            var id = $(this).getCell(rowid, 'ID');
            //var ap_no = $('#ap_no').val();
            var ap_no = $(this).getCell(rowid, 'AP_NO');
            
            if (isChk == "0") {
            	
                var pop_url = "${getContextPath}/popup/detectionDetail";
            	var winWidth = 1142;
            	var winHeight = 365;
            	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
            	//var pop = window.open(pop_url,"detail",popupOption);
            	var pop = window.open(pop_url,id,popupOption);
            	/* popList.push(pop);
            	sessionUpdate(); */
            	//pop.check();
            	
            	var newForm = document.createElement('form');
            	newForm.method='POST';
            	newForm.action=pop_url;
            	newForm.name='newForm';
            	//newForm.target='detail';
            	newForm.target=id;
            	
            	var input_id = document.createElement('input');
            	input_id.setAttribute('type','hidden');
            	input_id.setAttribute('name','id');
            	input_id.setAttribute('value',id);
            	
            	var input_ap = document.createElement('input');
            	input_ap.setAttribute('type','hidden');
            	input_ap.setAttribute('name','ap_no');
            	input_ap.setAttribute('value',ap_no);
            	
            	newForm.appendChild(input_id);
            	newForm.appendChild(input_ap);
            	document.body.appendChild(newForm);
            	newForm.submit();
            	
            	document.body.removeChild(newForm);
            }
            else {
            	getLowPath(id, ap_no);
            }
        },
        loadComplete: function(data) {
        }
    });
}
function downLoadExcel()
{
	//$('#targetGrid').jqGrid('hideCol', ['CHK_B']);

	var oPostDt = {};
	oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val();
	oPostDt["status"]  = $("#selectStatus").val();

    var jsonData = JSON.stringify(oPostDt);
    //datatype: "json",
    //mtype : "POST",
    console.log(jsonData)
	$.ajax({
        type: "POST",
        url: "${getContextPath}/detection/getDownloadData",
        async: false,
        data: jsonData,
        datatype: 'json',
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
        	console.log(result);
        	executeDownload(result);
        },
        error: function (request, status, error) {
            console.log('error');
        }
    });
	
    //$('#targetGrid').jqGrid('showCol', ['CHK_B']);
    
}
function executeDownload(resultList){
	var result = "경로,호스트,주민번호,외국인번호,여권번호,운전면허,계좌번호,카드번호,전화번호,이메일,합계\r\n";
	$.each(resultList, function(i, item){
		result +=  item.SHORTNAME + "," + item.HOST + "," + item.TYPE1 + "," + item.TYPE2 + "," + item.TYPE3 + "," + item.TYPE4 + "," + item.TYPE5 + "," + item.TYPE6 + "," + item.TYPE7 + "," + item.TYPE8 + "," + item.TYPE+"\r\n";
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
	
	/* var downloadLink = document.createElement("a");
	var blob = new Blob(["\ufeff"+result], { type: "text/csv;charset=utf-8" });
	var url = URL.createObjectURL(blob);
	downloadLink.href = url;
	downloadLink.download = "검출_리스트_" + today + ".csv";

	document.body.appendChild(downloadLink);
	downloadLink.click();
	document.body.removeChild(downloadLink); */
	
	var blob = new Blob(["\ufeff"+result], { type: "text/csv;charset=utf-8" });
	if(navigator.msSaveBlob){
		window.navigator.msSaveOrOpenBlob(blob, "검출_리스트_" + today + ".csv");
	} else {
		var downloadLink = document.createElement("a");
		var url = URL.createObjectURL(blob);
		downloadLink.href = url;
		downloadLink.download = "검출_리스트_" + today + ".csv";

		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	}
}



$(document).ready(function () {
	
	//$("#hostSelect").select2();
	$("#btnDownloadExcel").click(function(){
		downLoadExcel();
	});

    $("#taskWindowClose").click(function(e){
        $("#taskWindow").hide();
    });
    
    $("#pathWindowClose").click(function(e){
        $("#pathWindow").hide();
    });

    $("#btnSearch").click(function(e){
    	fnc_search();
    });

	$("#taskWindow").draggable({
		containment: '.content',
   	 	cancel : '.mxWindowPane'
   	});
	
	$("#pathWindow").draggable({
		containment: '.content',
   	 	cancel : '.mxWindowPane'
   	});

	var agent = navigator.userAgent.toLowerCase();
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
	}
	else {
		$("#taskWindow").resizable({
	   	});
		
		$("#pathWindow").resizable({
	   	});
	}
	
	$("#selectList").change(function(e){
	    $("#targetGrid").clearGridData();
		$("#schPath").val("");
    	if($(this).val() != 'all'){
    		fnc_search();
    	} 
    });

    $("#schPath").keyup(function(e){
        if (e.keyCode == 13) {
        	fnc_search();
        }
    });

    loadTargetGrid($("#targetGrid")); 
    
    
    fnc_search();
}); 

function fnc_search(){
	var postData = {
		selectList: $("select[name='selectList']").val(),
		schPath: $('#schPath').val(),
		idx : "${idx}"
	}
	
	console.log(postData);
	
	$("#targetGrid").setGridParam({url:"/manage/getDetectionApprovalList", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

//전체선택
function fn_allChkTargetGrid(chk, e) {
	e = e||event; 
	e.stopPropagation? e.stopPropagation() : e.cancelBubble = true; 
	
	var ids = $('#targetGrid').getDataIDs();
	if (ids.length > 0) {
		if($(chk).is(":checked")) {		// 선택시
			for(var i=0 ; i<ids.length ; i++){
				var rowid = ids[i];
				var dtObj = $('#targetGrid').getRowData(rowid);
				//if(rowObject['APPROVAL_STATUS'] == 'E'){
				if(dtObj.APPROVAL_STATUS != 'E'){
					$("#"+rowid).find(':checkbox').prop('checked', true);
				}
				//if (dtObj.APPROVAL_STATUS == '' && dtObj.PROCESSING_FLAG == '') {
				//	$("#"+rowid).find(':checkbox').prop('checked', true);
				//}
			}
		} else {						// 해제시
			for(var i=0 ; i<ids.length ; i++){
				var rowid = ids[i];
				var dtObj = $('#targetGrid').getRowData(rowid);
				if(dtObj.APPROVAL_STATUS != 'E'){
					$("#"+rowid).find(':checkbox').prop('checked', false);
				}
				//if (dtObj.APPROVAL_STATUS == '' && dtObj.PROCESSING_FLAG == '') {
				//	$("#"+rowid).find(':checkbox').prop('checked', false);
				//}
			}
		}
	}
}

$('#btnApproval').on('click', function(){
	var date = new Date();
	var aDeletionList = [];
	$('[name=gridChk]').each(function(i, item){
    	if (item.checked) {
    		var status = $('#targetGrid').getCell(item.value, 'APPROVAL_STATUS'); 

    		if(status != 'E'){
	    		console.log('gridChk :: ' + item.value);
	    		aDeletionList.push(item.value);
    		}
        }
    	
    });
	
	if (aDeletionList.length == 0) {
        alert("처리 항목을 선택하세요.");
        return;
    }
	
	var sChargeNm = '오탐처리_'+date.getFullYear()+''+(date.getMonth()+1)+''+date.getDate()+'_'+"${memberInfo.USER_NO}" + "_";
	var sFlag = '5';
	var oPostDt = {};
	oPostDt["deletionList"]             = aDeletionList;
    oPostDt["processing_flag"]          = sFlag;
    oPostDt["data_processing_name"]     = sChargeNm;
   	//console.log(confirm('Do u want use confirm box?'));
   	
   	var oJson = JSON.stringify(oPostDt);
   	if(confirm('선택하신 내용을 예외 처리 하시겠습니까?')){
   		
	    $.ajax({
	        type: "POST",
	        url: "${getContextPath}/manage/registProcess",
	        async : false,
	        data : oJson,
	        contentType: 'application/json; charset=UTF-8',
	        success: function (result) {
	            if (result.resultCode != "0") {
	                alert(result.resultCode + "처리 등록을 실패 하였습니다.");
	                return;
	            }
	
	           alert("처리를 등록 하였습니다.");
	
	           fnSearchFindSubpath();
	        },
	        error: function (request, status, error) {
	        	console.log(status);
	            alert("처리 등록을 실패 하였습니다.");
	
	            return;
	        }
	    });
   	}
});

$('#btnCancelApproval').on('click', function(){
	var aDeletionList = [];
	$('[name=gridChk]').each(function(i, item){
    	if (item.checked) {
    		var status = $('#targetGrid').getCell(item.value, 'APPROVAL_STATUS'); 
			
    		if(status == 'E'){
	    		aDeletionList.push(item.value);
    		}
        }
    	
    });
	
	if (aDeletionList.length == 0) {
        alert("처리 항목을 선택하세요.");
        return;
    }
	
	var sFlag = '5';
	var oPostDt = {};
	oPostDt["target_id"]				= $("#hostSelect").val();
	oPostDt["deletionList"]             = aDeletionList;
    oPostDt["processing_flag"]          = sFlag;
    
   	var oJson = JSON.stringify(oPostDt);
   	if(confirm('선택하신 경로를 예외 처리 해제 하시겠습니까?')){
   		
	    $.ajax({
	        type: "POST",
	        url: "${getContextPath}/manage/cancelApproval",
	        async : false,
	        data : oJson,
	        contentType: 'application/json; charset=UTF-8',
	        success: function (result) {
	            if (result.resultCode != "0") {
	                alert(result.resultCode + "예외 해제 실패 하였습니다.");
	                return;
	            }
	
	           alert("예외 해제 하였습니다.");
	
	           fnSearchFindSubpath();
	        },
	        error: function (request, status, error) {
	        	console.log(status);
	            alert("처리 등록을 실패 하였습니다.");
	
	            return;
	        }
	    });
   	}
});


function findByPop(){
	$("#taskWindow").hide();
	$("#pathWindow").hide();
	$("#targetGrid").clearGridData();
	$("#schPath").val("");
    fnSearchFindSubpath();
}

function getLowPath(id, ap_no){
	
	var pop_url = "${getContextPath}/popup/lowPath";
	var winWidth = 1142;
	var winHeight = 365;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=yes, resizable=no, location=no"; 	
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
	
	var input_id = document.createElement('input');
	input_id.setAttribute('type','hidden');
	input_id.setAttribute('name','hash_id');
	input_id.setAttribute('value',id);
	
	var input_ap = document.createElement('input');
	input_ap.setAttribute('type','hidden');
	input_ap.setAttribute('name','ap_no');
	input_ap.setAttribute('value',ap_no);
	
	newForm.appendChild(input_id);
	newForm.appendChild(input_ap);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
	
}
</script>

</body>
</html>