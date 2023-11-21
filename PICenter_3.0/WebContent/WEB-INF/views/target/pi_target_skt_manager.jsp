<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<style>
	#pcAdminPopup .ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	#input_targetUserGridPager .ui-pg-input{
		margin: 2px 5px 5px;
	}
</style>
		<section>
			<!-- container -->
				<div class="container">
					<%-- <%@ include file="../../include/menu.jsp"%> --%>
					<h3>중간관리자 관리</h3>
					<!-- content -->
					<div class="content magin_t25">
						<table class="user_info" style="display: inline-table; width: 910px;">
							<tbody>
								<tr>
									<th style="text-align: center; width: 100px; border-radius: 0.25rem;">사용자 ID</th>
									<td>
										<p style="width: 230px; margin-bottom: 5px;"><input type="text" id="searchID" style="font-size: 13px; line-height: 2; padding-left: 5px; width: 200px;" placeholder="ID를 입력하세요."/></p>
						            </td>
						            <th style="text-align: center; width: 100px; border-radius: 0.25rem;">사용자명</th>
									<td>
										<p style="width: 230px; margin-bottom: 5px;"><input type="text" id="searchName" style="font-size: 13px; line-height: 2; padding-left: 5px; width: 200px;" placeholder="성명을 입력하세요."/></p>
						            </td>
						            <th style="text-align: center; width: 100px; border-radius: 0.25rem;">담당 팀</th>
									<td>
										<p style="width: 230px; margin-bottom: 5px;"><input type="text" id="searchTeam" style="font-size: 13px; line-height: 2; padding-left: 5px; width: 200px;" placeholder="팀명를 입력하세요."/></p>
										<input type="button" name="button" class="btn_look" id="btnSearch" style="margin-top: -27px; margin-right: 5px;">
						            </td>
						        </tr>
						    </tbody>
						</table>
						<div class="list_sch" style="margin-top: 24px;">
							<div class="sch_area" style="margin-bottom: 10px;">
								<button type="button" class="btn_down" id="btn_new">추가</button>
								<button type="button" class="btn_down" id="btn_all_new">일괄 추가</button>
							</div>
						</div>
						<div class="grid_top" style="height: 100%; width: 100%; padding-top:10px;">
							<div class="left_box2" style="height: 94%; max-height: 700px; overflow: hidden;">
			   					<table id="topNGrid"></table>
			   				 	<div id="topNGridPager"></div>
			   				</div>
			   				<input type="hidden" id="targetUSER_NO" value="">
			   				<input type="hidden" id="targetUSER_NAME" value="">
			   				<input type="hidden" id="targetINSA_CODE" value="">
			   				<input type="hidden" id="targetTEAM_NAME" value="">
			   				<input type="hidden" id="targetUSER_PHONE" value="">
			   				<input type="hidden" id="targetUSER_EMAIL" value="">
			   				<input type="hidden" id="targetUSER_GRADE" value="">
						</div>
						
					</div>
				</div>
			<!-- container -->
		</section>
		<!-- section -->

<%@ include file="../../include/footer.jsp"%>

<div id="pcAdminPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="width: 410px; height: 200px; padding: 10px; background: #f9f9f9; left: 55%; top: 68%;">
		<img class="CancleImg" id="btnCanclepcAdminPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;">중간관리자 추가</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="background: #fff; width: 390px; height: 105px; border: 1px solid #c8ced3; overflow: auto;">
					<table class="user_info" style="width: 100%; border: none;">
						<caption>신규 스캔</caption>
						<tbody id="policyBody">
							<tr>
								<th style="width: 15% !important;">사용자</th>
								<td colspan="3">
									<input type="text" id="pcAdmin" value="" readonly="readonly" placeholder="사용자가 선택되지 않았습니다" style="width: 230px; padding-left: 5px;"> 
									<button type="button" id="btnUserChoice" class="btn_down">선택</button>
									<input type="hidden" id="pcAdminId" value=""> 
								</td>
							</tr>
							<tr>
								<th style="width: 15% !important;">담당 팀</th>
								<td colspan="3">
									<input type="text" id="pcAdminTeam" value=""  readonly="readonly" placeholder="담당 팀이 선택되지 않았습니다" style="width: 230px; padding-left: 5px;">  
									<button type="button" id="btnTeamChoice" class="btn_down">선택</button>
									<input type="hidden" id="pcAdminTeamCode" value=""> 
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		<div class="popup_btn">
			<div id="acesssBtn" class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnpcAdminPopupSave" >저장</button>
				<button type="button" id="btnpcAdminClose" >취소</button>
			</div>
		</div>
	</div>
</div>

<div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<ul>
		<li class="status">
			<button id="deleteManagerAll">삭제</button></li>
		<li class="status">
			<button id="closeManagerAll">닫기</button></li>
	</ul>
</div>

<div id="pcAdminExcelPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="width: 620px; height: 540px; padding: 10px; background: #f9f9f9; left: 50%; top: 51%;">
		<img class="CancleImg" id="btnCancleExcelPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">중간관리자 일괄 등록</h1>
			<p style="position: absolute; top: 14px; left: 195px; font-size: 12px; color: #9E9E9E;">PIMC에서 제공하는 형식이 아닌 다른 형식으로 업로드시 생성이 불가합니다.</p>
		</div>
		<div class="popup_content">
			<div class="content-box" style="background: #fff; width: 100%; height:457px; border: 1px solid #c8ced3; overflow: auto;">
				<table class="popup_tbl" style="width: 100%;">
					<colgroup>
						<col width="15%">
						<col width="85%">
					</colgroup>
					<tbody>
						<tr>
							<th>파일 다운로드</th>
							<td>
								<form id="btnDownLoadXlsx" action="<%=request.getContextPath()%>/download/downloadExcel" method="post" style="width: 49px; padding: 0px;">
									<input id="downloadFile" type="hidden" name="filename" value="PIMC_중관관리자_관리.xlsx">
									<input id="downloadRealFile" type="hidden" name="realfilename" value="pc_admin_ver1.xlsx">
									<input type="submit" id="btnExcelDown" value="다운로드"> 
								</form>
							</td>
						</tr>
					</tbody>
				</table>
				<table class="popup_tbl2" style="width: 100%;">
					<colgroup>
						<col width="15%">
						<col width="85%">
					</colgroup>
					<tbody >
						<tr>
							<th>
								파일 업로드
							</th>
							<td>
								<button type="button" id="clickimportBtn">파일선택</button>
								<input type="file" id="importExcel" name="importExcel" style="width: 955px; padding-left: 10px; display: none; ">
								<input type="text" id="importExcelNm" style="width: 373px; font-size: 12px; margin: 0 0 0 7px;" readonly="">
							</td>
						</tr>
					</tbody>
				</table>
				<div class="content-table" style="width: 100%; height: 340px; padding: 0;">
					<table class="popup_tbl" style="width: 100%;">
						<colgroup>
							<col width="30%">
							<col width="70%">
						</colgroup>
						<tbody id="import_pcAdminList_excel">
							<tr height="45px;">
								<th>사번</th>
								<th>인사코드</th>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;" id="pcAdminExcelBtn">
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	fn_drawTopNGrid();
	
	$(document).click(function(e){
		$("#taskGroupWindow").hide();
	});
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectSKTManagerList",
		datatype: "json",
		//data: temp,
	   	mtype : "POST",
		colNames:['사용자 ID','사용자명','팀코드','담당 팀','이메일','전화번호', ''],
		colModel: [
			{ index: 'USER_NO', 	name: 'USER_NO', 	width: 80, align: "center"},
			{ index: 'USER_NAME', 	name: 'USER_NAME', 	width: 80, align: "center"},
			{ index: 'INSA_CODE', 	name: 'INSA_CODE', 	width: 100, align: "left", hidden:true},
			{ index: 'TEAM_NAME', 	name: 'TEAM_NAME', 	width: 100, align: "center" },
			{ index: 'USER_EMAIL', 	name: 'USER_EMAIL', width: 120, align: "center"},
			{ index: 'USER_PHONE', 	name: 'USER_PHONE', width: 100, align: "center"},
			{ index: 'VIEW', 		name: 'VIEW', width:30, align: 'center', formatter:createView, exportcol : false},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 583,
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
	  	onCellSelect : function(rowid){
	  	},
	  	afterSaveCell : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
	  	afterSaveRow : function(rowid,name,val,iRow,ICol){ // 로우 데이터 변경하고 엔터치거나 다른 셀 클릭했을때 발동
        },
		loadComplete: function(data) {
			//console.log(data);
			$(".gridSubSelBtn").on("click", function(e) {
		  		e.stopPropagation();
				
				$("#topNGrid").setSelection(event.target.parentElement.parentElement.id);
				// 조건에 따라 Option 변경
				//var status = ".status-" + $("#targetGrid").getCell(event.target.parentElement.parentElement.id, 'SCHEDULE_STAT');
				$(".status").css("display", "none"); 
				$(".status").css("display", "block");

				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 55 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskGroupWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskGroupWindow").css("top").replace("px","")) + $("#taskGroupWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskGroupWindow").css("top", Number($("#taskGroupWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				$("#taskGroupWindow").show();
			});
	    },
	    gridComplete : function() {
	    }
	});
}

var createView = function(cellvalue, options, rowObject) {
	//return '<img src="/resources/assets/images/img_check.png" style="cursor: pointer;" name="gridSubSelBtn" class="gridSubSelBtn" value=" 선택 "></a>';
	var status = rowObject.STATUS;
	var result = "";
	
	result = "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>";
	
	return result; 
};

$('#searchID').keyup(function(e) {
	if (e.keyCode == 13) {
		search_Manager();
	}        
});

$('#searchName').keyup(function(e) {
	if (e.keyCode == 13) {
		search_Manager();
	}        
});

$('#searchTeam').keyup(function(e) {
	if (e.keyCode == 13) {
		search_Manager();
	}        
});

$("#btnSearch").click(function(e){
	search_Manager();
});

function search_Manager(){
	var postData = {
		"user_no": $('#searchID').val(), 
		"user_name": $('#searchName').val(),
		"team_name": $('#searchTeam').val()
	};
	$("#topNGrid").setGridParam({url:"<%=request.getContextPath()%>/target/selectSKTManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
};

$("#btn_new").click(function(e){
	$("#pcAdminPopup").show();
});

$("#btnpcAdminClose").click(function(e){
	$("#pcAdmin").val("");
	$("#pcAdminId").val("");
	$("#pcAdminTeam").val("");
	$("#pcAdminTeamCode").val("");
	$("#pcAdminPopup").hide();
});

$("#btnCanclepcAdminPopup").click(function(e){
	$("#pcAdmin").val("");
	$("#pcAdminId").val("");
	$("#pcAdminTeam").val("");
	$("#pcAdminTeamCode").val("");
	$("#pcAdminPopup").hide();
});

$("#btnUserChoice").click(function(e){
	userListWindows("SKTManager");
});

$("#btnTeamChoice").click(function(e){
	groupListWindows();
});

function userListWindows(info){
	var pop_url = "${getContextPath}/popup/userList";
	var id = "targetList"
	var winWidth = 700;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
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
};

function groupListWindows(){
	var netid = 1;
	var netType = "SKTManager";
	
	var pop_url = "${getContextPath}/popup/netList";
	var winWidth = 760;
	var winHeight = 0;
	if(netid == 3 ){
		winHeight = 580;
	}else{
		winHeight = 565;
	}
	
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	var pop = window.open(pop_url,netid,popupOption);
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	newForm.target=netid;
	
	var net_id = document.createElement('input');
	net_id.setAttribute('type','hidden');
	net_id.setAttribute('name','netid');
	net_id.setAttribute('id','netid');
	net_id.setAttribute('value',netid);
	
	var net_type = document.createElement('input');
	net_type.setAttribute('type','hidden');
	net_type.setAttribute('name','netType');
	net_type.setAttribute('id','netType');
	net_type.setAttribute('value',netType);
	
	newForm.appendChild(net_id);
	newForm.appendChild(net_type);
	
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
}

$("#btnpcAdminPopupSave").click(function(e){
	var user_no = $("#pcAdminId").val();
	var user_name = $("#pcAdmin").val();
	var insa_code = $("#pcAdminTeamCode").val();
	var team_name = $("#pcAdminTeam").val();
	
	if(user_no == '') {
		alert("담당자를 선택하지 않았습니다.");
		return;
	}
	if(insa_code == '') {
		alert("담당 팀을 선택하지 않았습니다.");
		return;
	}
	
	var message = user_name + "님을 " + team_name + "의 중간관리자로 지정 하시겠습니까?";
	
	if (confirm(message)) {
		var postData = {
			USER_NO : user_no,
			USER_NAME : user_name,
			INSA_CODE : insa_code,
			TEAM_NAME : team_name
		}
		$.ajax({
			type: "POST",
			url: "/target/insertSKTManager",
			async : false,
			data : postData,
			dataType: "json",
		    success: function (resultMap) {
		    	if (resultMap.resultCode == 0) {
		        	alert("등록을 완료하였습니다.");
		        	var postData = {};
			    	$("#topNGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/target/selectSKTManagerList", 
			    		postData : postData, 
			    		datatype:"json" 
		    		}).trigger("reloadGrid");
			    	$("#pcAdmin").val("");
			    	$("#pcAdminId").val("");
			    	$("#pcAdminTeam").val("");
			    	$("#pcAdminTeamCode").val("");
			    	$("#pcAdminPopup").hide();
			    } else {
			        alert(resultMap.resultMeassage);
			    }
		    },
		    error: function (request, status, error) {
		        console.log("ERROR : ", error);
		    }
		});
	}
});

$("#deleteManagerAll").click(function(e){
	
    var row = $("#topNGrid").getGridParam("selrow");
    var user_no = $("#topNGrid").getCell(row, "USER_NO");
    var insa_code = $("#topNGrid").getCell(row, "INSA_CODE");
	
	var message = "정말 삭제하시겠습니까?";
	
	if (confirm(message)) {
		var postData = {
			USER_NO : user_no,
			INSA_CODE : insa_code
		}
		$.ajax({
			type: "POST",
			url: "/target/deleteSKTManager",
			async : false,
			data : postData,
			dataType: "json",
		    success: function (resultMap) {
		    	if (resultMap.resultCode == 0) {
		        	alert("삭제를 완료하였습니다.");
		        	var postData = {};
			    	$("#topNGrid").setGridParam({
			    		url:"<%=request.getContextPath()%>/target/selectSKTManagerList", 
			    		postData : postData, 
			    		datatype:"json" 
		    		}).trigger("reloadGrid");
			    } else {
			    	alert(resultMap.resultMeassage);
			    }
		    },
		    error: function (request, status, error) {
		        console.log("ERROR : ", error);
		    }
		});
	}
});

$("#btn_all_new").click(function(e){
	$("#pcAdminExcelPopup").show();
});

$("#btnCancleExcelPopup").click(function(e){
	$("#importExcel").val("");
	$("#importExcelNm").val("");
	
	var details = "";
	$("#pcAdminExcelBtn").html(details);
	$("#import_pcAdminList_excel").html(details);
	$("#pcAdminExcelPopup").hide();
	$("#pcAdminExcelPopup").hide();
});

$("#clickimportBtn").click(function(){
	$("#importExcel").click();
});

$("#importExcel").change(function(){
	var checkFileNm = $("#importExcel").val();
	var filelength = checkFileNm.lastIndexOf('\\');
	var fileNm = checkFileNm.substring(filelength+1, checkFileNm.length);
	var resulList = [];
	var CNT = 0;
	let input = event.target;
    let reader = new FileReader();
    reader.onload = function () {
        let data = reader.result;
        let workBook = XLSX.read(data, { type: 'binary' });
        workBook.SheetNames.forEach(function (sheetName) {
            let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
            var details = "";
            
            var user_no = "";
            var insa_code = "";
            var firstRowChk = false;
	    	
	    	details += "<tr height=\"45px;\" >";
	    	details +=  "<th>사번</th>";
	    	details +=	"<th>인사코드</th>";
	    	details += "</tr>";
	    	
	    	
	    	if(
	    			rows[0].hasOwnProperty('사번')	
    			 &&	rows[0].hasOwnProperty('인사코드')
    			 
	    	){
	    		$.each(rows, function(index, item) {
					var user_no = item.사번;
					var insa_code = item.인사코드;
					firstRowChk = false;
					
					if(user_no == '1234' && insa_code == 'p123456'){
						firstRowChk = true;
					}else if(!firstRowChk) {
						details += "<tr style=\"height: 45px;\">";
						details += "	<td style=\"text-align: center; padding-left: 0;\">"+user_no+"</td>";
						details += "	<td style=\"text-align: center; padding-left: 0;\">"+insa_code+"</td>";
						details += "</tr>";
						
						resulList.push({"user_no" : user_no, "insa_code" : insa_code})
					}
						
				});
	    		
		    	var btnCss ="<button type=\"button\" id=\"btnNewPopupExcelSave\" style=\"margin-right: 5px\" >저장</button>";
					btnCss +="<button type=\"button\" id=\"btnNewPopupExcelCencel\" >취소</button>";
				$("#pcAdminExcelBtn").html(btnCss)
				
				$("#btnNewPopupExcelCencel").click(function(e){
					$("#importExcel").val("");
					$("#importExcelNm").val("");
					
					var details = "";
					$("#pcAdminExcelBtn").html(details);
					$("#import_pcAdminList_excel").html(details);
					$("#pcAdminExcelPopup").hide();
	        	});
				
				$('#btnNewPopupExcelSave').on('click', function(){
					
					var message = ("아래 담당자들을 해당 팀의 담당자로 지정하시겠습니까?");
	            	
					if (confirm(message)) {
	            		$.ajax({
	        				type: "POST",
	        				url: "/target/insertSKTManagerList",
	        				async : false,
	        				data : {
	        					"resulList": JSON.stringify(resulList)
	        				},
	        			    success: function (resultMap) {
	        			    	var resultPerson = resultMap.resultMapSize - resultMap.resultValue;
	        			    	if(resultMap.resultValue == 0) {
		        			    	alert("등록을 완료하였습니다.");
		        			    	setNewSetting();
	        			    	}else if(resultMap.resultValue == resultMap.resultMapSize) {
	        			    		alert("해당 담당자들은 이미 해당 팀의 중간관리자로 지정되어 있습니다.");
	        			    	}else {
	        			    		alert(resultMap.resultValue + "명의 담당자는 이미 해당 팀의 중간관리자로 지정되어 있습니다. \n해당 담당자를 제외한 " + resultPerson + "명의 중간관리자 등록을 완료하였습니다.");
		        			    	setNewSetting();
	        			    		
	        			    	}
	        			    },
	        			    error: function (request, status, error) {
	        			        console.log("ERROR : ", error);
	        			    }
	        			});
	            	}
            	});
	    		
	    	}else {
	    		alert("올바른 형식의 엑셀이 아닙니다. 확인 후 다시 시도해 주세요.");
	    		return;
	    	}
	    	
	    	 $("#import_pcAdminList_excel").html(details);
	    	 
	    	 
	         $("#importExcelNm").val(fileNm);
	    	
        })
    };
    reader.readAsBinaryString(input.files[0]);
});

function setNewSetting() {
	var postData = {};
	$("#topNGrid").setGridParam({
		url:"<%=request.getContextPath()%>/target/selectSKTManagerList", 
		postData : postData, 
		datatype:"json" 
	}).trigger("reloadGrid");
	$("#importExcel").val("");
	$("#importExcelNm").val("");
	
	var details = "";
	$("#pcAdminExcelBtn").html(details);
	$("#import_pcAdminList_excel").html(details);
	$("#pcAdminExcelPopup").hide();
}
</script>
</body>
</html>