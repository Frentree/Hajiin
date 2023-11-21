<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
#btnSearch {
	position: relative;
	top: 10px;
	right: 42px;
}
</style>

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
		<h3>통합 보고서</h3>
		<!-- content -->
		<div class="content magin_t25">
            <div class="grid_top">
                <table class="user_info narrowTable" style="width: 1315px;">
                    <caption>사용자정보</caption>
                    <tbody>
                        <tr>
                            <!-- <th style="text-align: center; background-color: #d6e4ed; min-width:6vw; width:6vw">호스트</th> -->
                            <th style="text-align: center; width: 100px; border-radius: 0.25rem; padding: 5px 5px 0 5px;">종류</th>
                            <td style="width: 210px; padding: 5px 5px 0 5px;">
                            	<label>서버 </label>
                            </td> 
                            <th style="text-align: center; width: 100px;  padding: 5px 5px 0 5px;">처리구분</th>
                            <td style=" padding: 5px 5px 0 5px;">
                            	<select id="SCH_PROCESSING_FLAG" name="SCH_PROCESSING_FLAG" style="width:186px;">
                                    <option value="" selected>전체</option>
                                    <c:forEach items="${dataProcessingFlagList}" var="dataProcessingFlagList">
                                    	<option value="${dataProcessingFlagList.PROCESSING_FLAG}">${dataProcessingFlagList.PROCESSING_FLAG_NAME}</option>
                                    </c:forEach>
                                    <option value="-1">미처리</option>
                                </select>
                            </td>
                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px; border-radius: 0.25rem;">기간별</th>
                            <td style="width: 400px; padding: 5px 5px 0 5px;">
                            	<select id="SCH_DATE" name="SCH_DATE" style="width: 186px; font-size: 12px; padding-left: 5px; text-align: center;">
                                    <option value="0" >검출일</option>
                                    <option value="1" >기안일</option>
                            	</select>
                            </td>
                            <td style="padding: 5px 5px 0 5px;">
                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
                           	</td>
                        </tr>
                        <tr>
                        	<th style="text-align: center; width: 100px; border-radius: 0.25rem;">호스트명</th>
                            <td style="width: 255px;">
                            	<input type="text" style="width: 186px; padding-left: 5px;" size="20" id="SCH_TARGET" placeholder="호스트명을 입력하세요." readonly="readonly">
                            	<input type="hidden" style="width: 186px; padding-left: 5px;" size="20" id="SCH_TARGET_ID" placeholder="호스트명을 입력하세요." readonly="readonly">
                            	<button type="button" class="btn_down" id="btnUserSelectClear" style="font-size : 12px; font-weight:0 ; margin-bottom: 0px; padding:0; width:55px !important; height:27px !important">Clear</button>
                            </td>
                            <th style="text-align: center; width: 100px;">그룹명</th>
                            <td style="width: 255px;">
                           		<div id="GROUP_DIV">
	                            	<input type="text" style="width: 186px; padding-left: 5px; padding-right: 7px;" size="10" id="SCH_GROUP" placeholder="그룹을 선택하세요." autocomplete="off" readonly="readonly">
	                            	<input type="hidden" style="width: 186px; display:none;" size="10" id="GROUP_ID" readonly="readonly">
	                            	<input type="hidden" style="width: 186px; display:none;" size="10" id="AP_NO" value="" readonly="readonly">
	                            	<button type="button" class="btn_down" id="btnGroupSelectClear" style="font-size : 12px; font-weight:0 ; margin-bottom: 0px; padding:0; width:55px !important; height:27px !important">Clear</button>
                            	</div>
                            </td>
                            <th style="text-align: center; width: 100px;">
                            </th>
                            <td>
                                <input type="date" id="SCH_FROM_CREDATE" style="text-align:center; width:186px;" readonly="readonly">
                                <span id="SCH_CREDATE_SPAN" style="width: 10%; margin-right: 3px; color: #000;">~</span>
                                <input type="date" id="SCH_TO_CREDATE" style="text-align:center; width:186px;" readonly="readonly">
                            	<input type="date" id="SCH_FROM_D_P_C_G_REGDATE" style="text-align:center; width:186px; display: none;" readonly="readonly">
                            	<span id="SCH_REGDATE_SPAN" style="width: 10%; margin-right: 3px; color: #000; display: none;">~</span>
                                <input type="date" id="SCH_TO_D_P_C_G_REGDATE" style="text-align:center; width:186px; display: none;" readonly="readonly">
                            </td>
                            <td>
                           		<button type="button" name="button" class="btn_down" id="detailExceldownload">다운로드</button>
                           		
                           		<input type="hidden" style="width: 186px; padding-left: 5px; padding-right: 7px;" size="10" id="sch_group_list" name="sch_group_list" >
                   				<input type="hidden" style="width: 186px; padding-left: 5px; padding-right: 7px;" size="10" id="sch_host_list"  name="sch_host_list">
                           	</td>
                         </tr>
                    </tbody>
                </table>
            </div>
			<!-- <div class="left_box2" style="overflow: hidden; max-height: 632px; height: 632px;"> -->
			<div class="left_box2" style="overflow: hidden; max-height: 635px; height: 635px; margin-top: 10px">
				<table id="targetGrid" style="width:100%"></table>
				<div id="targetGridPager"></div>
			</div>
		</div>
	</div>
	
	
	<!-- 담당자 지정 popup -->
	<div id="userSelect" class="popup_layer" style="display:none;">
	    <div class="popup_box" style="height: 200px; padding: 10px; background: #f9f9f9; left: 50%; top: 55%;">
	        <div class="popup_top" style="background: #f9f9f9;">
	            <h1 style="color: #222; padding: 0; box-shadow: none;">담당자 지정</h1>
	        </div>
	        <div class="popup_content">
	            <div class="content-box" style="height: 355px; background: #fff; padding: 0;">
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
	
	<!-- 팝업창 - 월간 리포트 다운로드 시작 -->
	<div id="monthlyReportPopup" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 100px; width: 462px; left:54%; top:53%;">
			<div class="popup_top">
				<h1>월간 리포트 다운로드</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" style="height: 100px;">
					<table class="popup_tbl">
						<colgroup>
							<col width="30%">
							<col width="*">
						</colgroup>
						<tbody>
							<tr>
								<th>연월 선택</th>
								<td>
									<jsp:useBean id="now" class="java.util.Date"/>
									<fmt:formatDate value="${now}" pattern="yyyy" var="now_year"/>
									<select id="monthly_year" name="monthly_year">
										<option value="" selected>선택</option>
										<c:forEach items="${monthly_year}" var="yearMap">
										<option value="${yearMap}" <c:if test="${yearMap == now_year}">selected</c:if>>${yearMap}</option>
										</c:forEach>
									</select>년&nbsp;
									<select id="monthly_month" name="monthly_month">
										<option value="1" <c:if test="${monthly_month == '1'}">selected</c:if>>1</option>
										<option value="2" <c:if test="${monthly_month == '2'}">selected</c:if>>2</option>
										<option value="3" <c:if test="${monthly_month == '3'}">selected</c:if>>3</option>
										<option value="4" <c:if test="${monthly_month == '4'}">selected</c:if>>4</option>
										<option value="5" <c:if test="${monthly_month == '5'}">selected</c:if>>5</option>
										<option value="6" <c:if test="${monthly_month == '6'}">selected</c:if>>6</option>
										<option value="7" <c:if test="${monthly_month == '7'}">selected</c:if>>7</option>
										<option value="8" <c:if test="${monthly_month == '8'}">selected</c:if>>8</option>
										<option value="9" <c:if test="${monthly_month == '9'}">selected</c:if>>9</option>
										<option value="10" <c:if test="${monthly_month == '10'}">selected</c:if>>10</option>
										<option value="11" <c:if test="${monthly_month == '11'}">selected</c:if>>11</option>
										<option value="12" <c:if test="${monthly_month == '12'}">selected</c:if>>12</option>
									</select>월&nbsp;
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area">
					<button type="button" id="btnDownloadMonthly">다운로드</button>
					<button type="button" id="btnCancelMonthly">취소</button>
				</div>
			</div>
		</div>
	</div>
	
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
    	//로딩
 	   var form = document.getElementById("excelDownForm");
 	   
 	   if($("#SCH_FROM_CREDATE").val() > $("#SCH_TO_CREDATE").val()){
 			alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
 			return;
 		}
 		// 기안일
 		if($("#SCH_FROM_D_P_C_G_REGDATE").val() > $("#SCH_TO_D_P_C_G_REGDATE").val()){
 			alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
 			return;
 		}
 		
 	   Loading2();
 	   
 	   if($("#SCH_DATE").val() == 0 ){ // 검출일
 		   
 		   var oPostDt = {};
 		   var group_list = $("#sch_group_list").val().split(",");
 		   var host_list = $("#sch_host_list").val().split(",");
 		 
 		   if($("#SCH_DATE").val() == 0 ){ // 검출일
 				oPostDt["sch_SDATE"] = $("#SCH_FROM_CREDATE").val();
 				oPostDt["sch_EDAT"] = $("#SCH_TO_CREDATE").val();
 				
 				$("#sch_SDATE").val($("#SCH_FROM_CREDATE").val());
 				$("#sch_EDAT").val($("#SCH_TO_CREDATE").val());
 		   }else if($("#SCH_DATE").val() == 1 ){ // 기안일
 				oPostDt["sch_SDATE"] = $("#SCH_FROM_D_P_C_G_REGDATE").val();
 				oPostDt["sch_EDAT"] = $("#SCH_TO_D_P_C_G_REGDATE").val();
 				
 			   $("#sch_SDATE").val($("#SCH_FROM_D_P_C_G_REGDATE").val());
 			   $("#sch_EDAT").val($("#SCH_TO_D_P_C_G_REGDATE").val());
 		   }
 		   
 			oPostDt["SCH_DATE"] = $("#SCH_DATE").val();
 			oPostDt["tid"] = $("#sch_host_list").val();
 			oPostDt["gid"] = $("#sch_group_list").val();

 			var jsonData = JSON.stringify(oPostDt);
 			console.log(jsonData);
 			var excelDownloadState = false;
 			
 	//		dataExcel();
 			
 			setTimeout(function(){
 				 $.ajax({
 					type: "POST",
 					url: "${getContextPath}/report/getExcelDownCNT",
 					async: false,
 					data: jsonData,
 					datatype: "json",
 					contentType: "application/json; charset=UTF-8",
 					success: function (result){
 						console.log(result);
 						
 						 if(result.rowLength <= 0){
 							alert("데이터가 없습니다.");
 							closeLoading2();
 							return;
 						}
 						
 					 	var form = document.createElement("form");
 						form.setAttribute("method", "POST");  //Post 방식
 						form.setAttribute("action", "/report/excelDown"); //요청 보낼 주소
 						form.setAttribute("id", "result_api"); //요청 보낼 주소
 						form.setAttribute("onsubmit", "return false;");
 						
 						var hiddenAPI = document.createElement("input");
 						hiddenAPI.setAttribute("type", "hidden");
 						hiddenAPI.setAttribute("name", "detailFileName");
 				        hiddenAPI.setAttribute("value",result.fileName );
 				        form.appendChild(hiddenAPI);
 				        
 				        document.body.appendChild(form);
 				         
 				        form.submit();
 					    closeLoading2();
 				         
 				        document.body.removeChild(form);  
 						 //로딩 해제
 					},
 					error: function (request, status, error) {
 						//alert('데이터가 없습니다.');
 						alert("엑셀 파일 생성에 실패하였습니다.");
 						closeLoading2();
 						//로딩 해제
 					}
 				});
 				 
 				 
 			},1000);
 		  
 	   }   	
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
    
    $('#SCH_TARGET').keyup(function(e) {
		if (e.keyCode == 13) {
			fn_search();
	    }        
	});
    
    $("#SCH_DATE").change(function() {
    	if($("#SCH_DATE option:selected").val() == 1){
    		$("#SCH_FROM_CREDATE").css('display', 'none');
    		$("#SCH_CREDATE_SPAN").css('display', 'none');
    		$("#SCH_TO_CREDATE").css('display', 'none');
    		$("#SCH_FROM_D_P_C_G_REGDATE").css('display', 'inline-block');
    		$("#SCH_REGDATE_SPAN").css('display', 'inline');
    		$("#SCH_TO_D_P_C_G_REGDATE").css('display', 'inline-block');
    	}else {
    		$("#SCH_FROM_CREDATE").css('display', 'inline-block');
    		$("#SCH_CREDATE_SPAN").css('display', 'inline');
    		$("#SCH_TO_CREDATE").css('display', 'inline-block');
    		$("#SCH_FROM_D_P_C_G_REGDATE").css('display', 'none');
    		$("#SCH_REGDATE_SPAN").css('display', 'none');
    		$("#SCH_TO_D_P_C_G_REGDATE").css('display', 'none');
    	}
    });
    
    var type = 0;
    $("#AP_NO").val(type);
    
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
    $("#btnGroupSelectClear").on("click", function(e) {
        $("#SCH_GROUP").val('');
        $("#GROUP_ID").val('');
        $("#AP_NO").val('');
    });
    
    $("#btnUserSelectClear").on("click", function(e) {
        $("#SCH_TARGET").val('');
        $("#SCH_TARGET_ID").val('');
    });
	
    loadJqGrid();
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
		/* colNames:['GROUP_ID','TARGET_ID',	'HASH_ID',	'ACCOUNT',	'OS',		'호스트',					'경로',				'팀명',				'사번',		'담당자명'
		 ,'주민번호',	'외국인번호',		'여권번호',	'운전번호',	'카드번호',	'계좌번호',				'총개수',				'검출일',				'삭제일',		'기안일'
		 ,'기안자NO',	'기안자',			'결재일',		'결재자NO',	'결재자',		'개인정보 여부(정탐 오탐) 코드','점검 결과',	'메모내용(문서 메모내용)',	'처리구분',	'조치예정일'], */
		colNames:['GROUP_ID',			'TARGET_ID','HASH_ID', 'AP_NO',	'ACCOUNT',	'OS',	'담당자',	'호스트',		'IP',		'경로',		'코멘트',		'그룹명',		'사번'
				 ,	'주민번호',	'외국인번호',	'여권번호',	'운전번호',	'계좌번호',	'카드번호',	'이메일',	'휴대폰번호',						'총개수'
				 ,'검출일',				'삭제일',		'기안일',		'기안자NO',	'기안자',		'결재일',		'결재자NO',	'결재자',		'개인정보 여부(정탐 오탐) 코드',	'점검 결과'
				 ,'메모내용(문서 메모내용)',	'처리구분'	,	'조치예정일'],
		colModel: [
			/* { index: 'GROUP_ID',				name: 'GROUP_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'TARGET_ID',				name: 'TARGET_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'HASH_ID',					name: 'HASH_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT',					name: 'ACCOUNT',				width: 100,		align: 'left',	hidden:true},
			{ index: 'PLATFORM',				name: 'PLATFORM',				width: 110,		align: 'left'},
			{ index: 'TARGET_NAME',				name: 'TARGET_NAME',			width: 140,		align: 'left'},
			{ index: 'PATH',					name: 'PATH',					width: 400,		align: 'left'},
			{ index: 'OFFICE_NM',				name: 'OFFICE_NM',				width: 130,		align: 'center'},
			{ index: 'USER_ID',					name: 'USER_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'USER_NM',					name: 'USER_NM',				width: 80,		align: 'center'},
			
			{ index: 'TYPE1',					name: 'TYPE1',					width: 70,		align: 'right'},
			{ index: 'TYPE2',					name: 'TYPE2',					width: 80,		align: 'right'},
			{ index: 'TYPE3',					name: 'TYPE3',					width: 70,		align: 'right'},
			{ index: 'TYPE4',					name: 'TYPE4',					width: 70,		align: 'right'},
			{ index: 'TYPE6',					name: 'TYPE6',					width: 70,		align: 'right'},
			{ index: 'TYPE5',					name: 'TYPE5',					width: 70,		align: 'right'},
			{ index: 'TYPE',					name: 'TYPE',					width: 90,		align: 'right'},
			{ index: 'CREDATE',					name: 'CREDATE',				width: 170,		align: 'center'},
			{ index: 'DELDATE',					name: 'DELDATE',				width: 170,		align: 'center'},
			{ index: 'D_P_C_G_REGDATE',			name: 'D_P_C_G_REGDATE',		width: 170,		align: 'center'},
			
			{ index: 'ACCOUNT_USER_NO',			name: 'ACCOUNT_USER_NO',		width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT_USER_NM',			name: 'ACCOUNT_USER_NM',		width: 80,		align: 'center'},
			{ index: 'OKDATE',					name: 'OKDATE',					width: 170,		align: 'center'},
			{ index: 'OKUSER_NO',				name: 'OKUSER_NO',				width: 100,		align: 'left',	hidden:true},
			{ index: 'OK_ACCOUNT_USER_NM',			name: 'OK_ACCOUNT_USER_NM',		width: 80,		align: 'center'},
			{ index: 'PROCESSING_FLAG',			name: 'PROCESSING_FLAG',		width: 100,		align: 'left',	hidden:true},
			{ index: 'PROCESSING_FLAG_TYPE',	name: 'PROCESSING_FLAG_TYPE',	width: 75,		align: 'center'},
			{ index: 'D_P_C_G_REASON',			name: 'D_P_C_G_REASON',			width: 200,		align: 'left'},
			{ index: 'PROCESSING_FLAG_NAME',	name: 'PROCESSING_FLAG_NAME',	width: 100,		align: 'center'},
			{ index: 'D_P_G_NEXT_DATE_REMEDI',	name: 'D_P_G_NEXT_DATE_REMEDI',	width: 170,		align: 'center'} */
			
			{ index: 'GROUP_ID',				name: 'GROUP_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'TARGET_ID',				name: 'TARGET_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'HASH_ID',					name: 'HASH_ID',				width: 100,		align: 'left',	hidden:true},
			{ index: 'AP_NO',					name: 'AP_NO',					width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT',					name: 'ACCOUNT',				width: 100,		align: 'left',	hidden:true},
			{ index: 'PLATFORM',				name: 'PLATFORM',				width: 110,		align: 'center'},
			{ index: 'USER_NAME',				name: 'USER_NAME',				width: 100,		align: 'center'},
			{ index: 'TARGET_NAME',				name: 'TARGET_NAME',			width: 140,		align: 'center'},
			{ index: 'IP',						name: 'IP',						width: 100,		align: 'center'},
			{ index: 'PATH',					name: 'PATH',					width: 450,		align: 'left'},
			{ index: 'COMMENTS',				name: 'COMMENTS',				width: 400,		align: 'left',	hidden:true},
			{ index: 'OFFICE_NM',				name: 'OFFICE_NM',				width: 130,		align: 'center'},
			{ index: 'USER_ID',					name: 'USER_ID',				width: 100,		align: 'left',	hidden:true},
			
			{ index: 'TYPE1',					name: 'TYPE1',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number',},
			{ index: 'TYPE2',					name: 'TYPE2',					width: 80,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE3',					name: 'TYPE3',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE4',					name: 'TYPE4',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE5',					name: 'TYPE5',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE6',					name: 'TYPE6',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE7',					name: 'TYPE7',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE8',					name: 'TYPE8',					width: 70,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'TYPE',					name: 'TYPE',					width: 90,		align: 'right', formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: ''}, sorttype: 'number' },
			{ index: 'CREDATE',					name: 'CREDATE',				width: 170,		align: 'center'},
			
			{ index: 'DELDATE',					name: 'DELDATE',				width: 170,		align: 'center'},
			{ index: 'D_P_C_G_REGDATE',			name: 'D_P_C_G_REGDATE',		width: 170,		align: 'center'},
			{ index: 'ACCOUNT_USER_NO',			name: 'ACCOUNT_USER_NO',		width: 100,		align: 'left',	hidden:true},
			{ index: 'ACCOUNT_USER_NM',			name: 'ACCOUNT_USER_NM',		width: 80,		align: 'center'},
			{ index: 'OKDATE',					name: 'OKDATE',					width: 170,		align: 'center'},
			{ index: 'OKUSER_NO',				name: 'OKUSER_NO',				width: 100,		align: 'left',	hidden:true},
			{ index: 'OK_ACCOUNT_USER_NM',		name: 'OK_ACCOUNT_USER_NM',		width: 80,		align: 'center'},
			{ index: 'PROCESSING_FLAG',			name: 'PROCESSING_FLAG',		width: 100,		align: 'left',	hidden:true},
			/* { index: 'PROCESSING_FLAG_TYPE',	name: 'PROCESSING_FLAG_TYPE',	width: 75,		align: 'center'},
			{ index: 'D_P_C_G_REASON',			name: 'D_P_C_G_REASON',			width: 200,		align: 'left'}, */
			{ index: 'PROCESSING_FLAG_TYPE',	name: 'PROCESSING_FLAG_TYPE',	width: 75,		align: 'center', hidden: true },
			{ index: 'D_P_C_G_REASON',			name: 'D_P_C_G_REASON',			width: 200,		align: 'left', hidden: true },
			
			{ index: 'PROCESSING_FLAG_NAME',	name: 'PROCESSING_FLAG_NAME',	width: 100,		align: 'center'},
			/* { index: 'D_P_G_NEXT_DATE_REMEDI',	name: 'D_P_G_NEXT_DATE_REMEDI',	width: 170,		align: 'center'} */
			{ index: 'D_P_G_NEXT_DATE_REMEDI',	name: 'D_P_G_NEXT_DATE_REMEDI',	width: 170,		align: 'center', hidden: true}
		],
		
		loadonce :true,
		viewrecords: false, // show the current page, data rang and total records on the toolbar
		width: 600,
		height: 555,
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

/* function downLoadExcel()
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
} */
function Loading2() {
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
     
    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg ='';
     
    loadingImg +=" <div id='loadingImg'>";
    loadingImg +=" <img src='${pageContext.request.contextPath}/resources/assets/images/spinner.gif' style='position:absolute; z-index:9500; text-align:center; display:block; top:650%; left:42%;'/>";
    loadingImg += "</div>";  
 
    $('body')
        .append(mask)
 
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' :'0.3'
    });
    
    $('#mask').show();
  
    $('.container_header').append(loadingImg);
    $('#loadingImg').show();
}

function closeLoading2() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').remove(); 
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
	
	var oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#SCH_FROM_CREDATE").val(getFormatDate(oFromDate));
	oToday = new Date();
	oFromDate = new Date(oToday.setDate(oToday.getDate() - 30));
	$("#SCH_FROM_D_P_C_G_REGDATE").val(getFormatDate(oFromDate));
}

//검색
function fn_search() 
{
	
	// 검출일
	if($("#SCH_FROM_CREDATE").val() > $("#SCH_TO_CREDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	// 기안일
	if($("#SCH_FROM_D_P_C_G_REGDATE").val() > $("#SCH_TO_D_P_C_G_REGDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	
	// 정탐/오탐 리스트 그리드
	var oPostDt = {};
	oPostDt["SCH_TARGET"]				= $("#SCH_TARGET").val();
	oPostDt["SCH_TARGET_ID"]			= $("#SCH_TARGET_ID").val();
	// oPostDt["SCH_PATH"]					= $("#SCH_PATH").val();
	oPostDt["SCH_FROM_CREDATE"]			= $("#SCH_FROM_CREDATE").val();
	oPostDt["SCH_TO_CREDATE"]			= $("#SCH_TO_CREDATE").val();
	
	// oPostDt["SCH_OFFICE_CODE"]			= $("#SCH_OFFICE_CODE").val();
	oPostDt["SCH_OWNER"]				= $("#SCH_OWNER").val();
	oPostDt["SCH_PROCESSING_FLAG"]		= $("#SCH_PROCESSING_FLAG").val();
	oPostDt["SCH_FROM_D_P_C_G_REGDATE"]	= $("#SCH_FROM_D_P_C_G_REGDATE").val();
	oPostDt["SCH_TO_D_P_C_G_REGDATE"]	= $("#SCH_TO_D_P_C_G_REGDATE").val();
	oPostDt["SCH_DMZ_SELECT"]   		= $("input[name='ra_new']:checked").val();
	oPostDt["SCH_D_P_C_G_REGDATE_CHK"]	= $("#SCH_D_P_C_G_REGDATE_CHK").is(":checked") ? "Y" : "N";		// 조회조건 기안일 사용여부
	// oPostDt["SCH_OBJECT"]				= $("#SCH_OBJECT").val();
	oPostDt["SCH_GROUP"]				= $("#SCH_GROUP").val();
	oPostDt["GROUP_ID"]					= $("#GROUP_ID").val();
	oPostDt["AP_NO"]					= $("#AP_NO").val();
	oPostDt["SCH_DATE"]					= $("#SCH_DATE option:selected").val();
	
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
			console.log(result);
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
	
	today = yyyy + "" + mm + dd;
	
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

/*
$('#SCH_OBJECT').on('change', function(){
	if($('#SCH_OBJECT').val() == 'group'){
		$('#SCH_TARGET').val('')
		$('#SCH_TARGET').css('display', 'none')
		$('#GROUP_DIV').css('display', 'block')
		//selectGroup();
	} else if ($('#SCH_OBJECT').val() == 'host') {
		//$('#SCH_TARGET').attr('placeholder', '호스트명을 입력해주세요.')
		$('#SCH_TARGET').css('display', 'block')
		$('#GROUP_DIV').css('display', 'none')
		$('#SCH_GROUP').val('')
		$('#GROUP_ID').val('')
	}
})
*/

$('#SCH_GROUP').on('click', function(){
	var type = 0;
	selectGroup(type);
});

$('#SCH_TARGET').on('click', function(){
	var type = 0;
	selectHost(type);
});

function selectGroup(typeChk) {
	var pop_url = "${getContextPath}/popup/reportGroupList";
	var id = "reportGroupList"
	var winWidth = 700;
	var winHeight = 565;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
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
	data.setAttribute('name','typeChk');
	data.setAttribute('value',typeChk);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
	
}

function selectHost(typeChk) {
	var pop_url = "${getContextPath}/popup/reportHostList";
	var id = "reportGroupList"
	var winWidth = 700;
	var winHeight = 565;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
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
	data.setAttribute('name','typeChk');
	data.setAttribute('value',typeChk);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
	
}

function fn_excel() 
{
	
	// 검출일
	if($("#SCH_FROM_CREDATE").val() > $("#SCH_TO_CREDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	// 기안일
	if($("#SCH_FROM_D_P_C_G_REGDATE").val() > $("#SCH_TO_D_P_C_G_REGDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	
	// 정탐/오탐 리스트 그리드
	var oPostDt = {};
	oPostDt["SCH_TARGET"]				= $("#SCH_TARGET").val();
	oPostDt["SCH_TARGET_ID"]			= $("#SCH_TARGET_ID").val();
	// oPostDt["SCH_PATH"]					= $("#SCH_PATH").val();
	oPostDt["SCH_FROM_CREDATE"]			= $("#SCH_FROM_CREDATE").val();
	oPostDt["SCH_TO_CREDATE"]			= $("#SCH_TO_CREDATE").val();
	
	// oPostDt["SCH_OFFICE_CODE"]			= $("#SCH_OFFICE_CODE").val();
	oPostDt["SCH_OWNER"]				= $("#SCH_OWNER").val();
	oPostDt["SCH_PROCESSING_FLAG"]		= $("#SCH_PROCESSING_FLAG").val();
	oPostDt["SCH_FROM_D_P_C_G_REGDATE"]	= $("#SCH_FROM_D_P_C_G_REGDATE").val();
	oPostDt["SCH_TO_D_P_C_G_REGDATE"]	= $("#SCH_TO_D_P_C_G_REGDATE").val();
	oPostDt["SCH_DMZ_SELECT"]   		= $("input[name='ra_new']:checked").val();
	oPostDt["SCH_D_P_C_G_REGDATE_CHK"]	= $("#SCH_D_P_C_G_REGDATE_CHK").is(":checked") ? "Y" : "N";		// 조회조건 기안일 사용여부
	// oPostDt["SCH_OBJECT"]				= $("#SCH_OBJECT").val();
	oPostDt["SCH_GROUP"]				= $("#SCH_GROUP").val();
	oPostDt["GROUP_ID"]					= $("#GROUP_ID").val();
	oPostDt["AP_NO"]					= $("#AP_NO").val();
	oPostDt["SCH_DATE"]					= $("#SCH_DATE option:selected").val();
	
	console.log(oPostDt);
	$.ajax({
		type: "POST",
		url: "${getContextPath}/report/searchSummaryList",
		////async: false,
		data: oPostDt,
		datatype: "json",
		success: function (result){
			console.log(result);
			executeReportDownload(result);
		},
		error: function (request, status, error) {
			alert('데이터가 없습니다.');
		}
	});
}

function executeReportDownload(resultList){
	var result = "OS,담당자,호스트,IP,경로,그룹명,";
		result += "주민번호,외국인번호,여권번호,운전번호,계좌번호,카드번호,이메일,휴대폰번호,총개수,";
		result += "검출일,삭제일,기안일,기안자,결재일,결재자,처리구분\r\n";

	$.each(resultList, function(i, item){
		result += item.PLATFORM + "," + item.USER_NAME + "," + item.TARGET_NAME + "," + item.IP + "," + item.PATH2 + "," + item.OFFICE_NM + ",";
		result += item.TYPE1 + "," + item.TYPE2 + "," + item.TYPE3 + "," + item.TYPE4 + "," + item.TYPE5 + "," + item.TYPE6 + "," + item.TYPE7 + "," + + item.TYPE8 + "," + + item.TYPE + ",";
		result += item.CREDATE + "," + item.DELDATE + "," + item.D_P_C_G_REGDATE + "," + item.ACCOUNT_USER_NM + "," + item.OKDATE + "," + item.OK_ACCOUNT_USER_NM + "," + item.PROCESSING_FLAG_NAME + "\r\n";
	});
	
	var mm = $("#monthly_month").val();
	var yyyy = $("#monthly_year").val();
	
	if(mm<10) {
		mm='0'+mm;
	}
	
	today = yyyy + "" + mm + dd;
	
	var blob = new Blob(["\ufeff"+result], {type: "text/csv;charset=utf-8" });
	if(navigator.msSaveBlob){
		window.navigator.msSaveOrOpenBlob(blob, "통합_보고서_" + today + ".csv");
	} else {
		var downloadLink = document.createElement("a");
		var url = URL.createObjectURL(blob);
		downloadLink.href = url;
		downloadLink.download = "통합_보고서_" + today + ".csv";
		
		document.body.appendChild(downloadLink);
		downloadLink.click();
		document.body.removeChild(downloadLink);
	}
}


/*  */
$("#detailExceldownload").on("click", function(){
	if($("#SCH_FROM_CREDATE").val() > $("#SCH_TO_CREDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	// 기안일
	if($("#SCH_FROM_D_P_C_G_REGDATE").val() > $("#SCH_TO_D_P_C_G_REGDATE").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
	/* 
	1. 선택된 호스트 or 보고서 다운로드 될 서버를 목록
	2. 서버별로 순차적으로 검출 경로 불러오기
	3. excel 생성
	4. 저장
	*/
	
	var ap_list = [];
	var host_list = [];
	
	// Host 선택이 있으면
	if($("#sch_host_list").val() != ""){
		host_list = $("#sch_host_list").val().split(",");
		ap_list = $("#sch_ap_list").val().split(",");
	}
	
	// Excel 객체 생성
	var workbook = new ExcelJS.Workbook();
	// 1. 선택된 호스트 or 보고서 다운로드 될 서버를 목록
	
	var oPostDt = {};
	// 엑세 down 서버 Count
	var count = 0;
	// 엑셀 download 결과
	var resultCnt = 0;
	 
	if($("#SCH_DATE").val() == 0 ){ // 검출일
		oPostDt["sch_SDATE"] = $("#SCH_FROM_CREDATE").val();
		oPostDt["sch_EDAT"] = $("#SCH_TO_CREDATE").val();
		
		$("#sch_SDATE").val($("#SCH_FROM_CREDATE").val());
		$("#sch_EDAT").val($("#SCH_TO_CREDATE").val());
   }else if($("#SCH_DATE").val() == 1 ){ // 기안일
		oPostDt["sch_SDATE"] = $("#SCH_FROM_D_P_C_G_REGDATE").val();
		oPostDt["sch_EDAT"] = $("#SCH_TO_D_P_C_G_REGDATE").val();
		
	   $("#sch_SDATE").val($("#SCH_FROM_D_P_C_G_REGDATE").val());
	   $("#sch_EDAT").val($("#SCH_TO_D_P_C_G_REGDATE").val());
   }
	
	if(host_list.length > 0){
		resultCnt = 0;
		for(var i = 0; i < host_list.length; i++) {
			oPostDt["TARGET_ID"] = host_list[i];
			oPostDt["AP_NO"] = ap_list[i];
			
			var jsonData = JSON.stringify(oPostDt);
			$.ajax({
		        type: "POST",
		        url: "${getContextPath}/report/reportDetailData",
		        async : false,
		        data : jsonData, 
		        contentType: 'application/json; charset=UTF-8',
		        success: function (result) {
		            if (result.resultCode != "200") {
		               // alert(result.resultCode + "처리 등록을 실패 하였습니다.");
		                return;
		            } else if(result.resultCode == "200"){
		            	
		            	if(result.resultHost != "")
		            	resultCnt = detailExcelDwonload(workbook, result.resultHost, result.resultData);
		            }
		        },
		        error: function (request, status, error) {
		        	console.log(status);
		            //alert("처리 등록을 실패 하였습니다.");
		
		            return;
		        }
		    });
			
			if(resultCnt == 1){
				count++;
			}
		}
	} else {
		oPostDt["GROUP_ID"]					= $("#GROUP_ID").val();
		oPostDt["SCH_OWNER"]				= $("#SCH_OWNER").val();
		if($("#SCH_DATE").val() == 0 ){ // 검출일
			oPostDt["sch_SDATE"] = $("#SCH_FROM_CREDATE").val();
			oPostDt["sch_EDAT"] = $("#SCH_TO_CREDATE").val();
			
			$("#sch_SDATE").val($("#SCH_FROM_CREDATE").val());
			$("#sch_EDAT").val($("#SCH_TO_CREDATE").val());
	   }else if($("#SCH_DATE").val() == 1 ){ // 기안일
			oPostDt["sch_SDATE"] = $("#SCH_FROM_D_P_C_G_REGDATE").val();
			oPostDt["sch_EDAT"] = $("#SCH_TO_D_P_C_G_REGDATE").val();
			
		   $("#sch_SDATE").val($("#SCH_FROM_D_P_C_G_REGDATE").val());
		   $("#sch_EDAT").val($("#SCH_TO_D_P_C_G_REGDATE").val());
	   }

		var jsonData = JSON.stringify(oPostDt); 
		
		$.ajax({
	        type: "POST", 
	        url: "${getContextPath}/report/reportTargetList",
	        async : false,
	        data : jsonData, 
	        contentType: 'application/json; charset=UTF-8',
	        success: function (result) {
	        	console.log(result);
	            if (result.resultCode == -1) {
	                alert(result.resultCode + "처리 등록을 실패 하였습니다.");
	                return;
	            }else {
	            	for(var i = 0; i < result.resultData.length; i ++){ 
	            		console.log(result.resultData[i]);
	            		oPostDt["TARGET_ID"] = result.resultData[i].TARGET_ID;
	        			oPostDt["AP_NO"] = result.resultData[i].AP_NO;
	        			
	        			jsonData = JSON.stringify(oPostDt);
	        			$.ajax({
	        		        type: "POST",
	        		        url: "${getContextPath}/report/reportDetailData",
	        		        async : false,
	        		        data : jsonData, 
	        		        contentType: 'application/json; charset=UTF-8',
	        		        success: function (result) {
	        		            if (result.resultCode != "200") {
	        		               // alert(result.resultCode + "처리 등록을 실패 하였습니다.");
	        		                return;
	        		            } else if(result.resultCode == "200"){
	        		            	
	        		            	if(result.resultHost != "")
	        		            	resultCnt = detailExcelDwonload(workbook, result.resultHost, result.resultData);
	        		            }
	        		        },
	        		        error: function (request, status, error) {
	        		        	console.log(status);
	        		            //alert("처리 등록을 실패 하였습니다.");
	        		
	        		            return;
	        		        }
	        		    });
	        			
	        			if(resultCnt == 1){
	        				count++;
	        			}
	            	}
	            		
	            }
	
	        },
	        error: function (request, status, error) {
	        	console.log(status);
	            alert("다운로드 진행중 에러가 발생하였습니다.");
	
	            return;
	        }
	    });
		

	}
	var now = new Date();
	const year = now.getFullYear();
	const month = now.getMonth() + 1;
	const date = now.getDate(); 

	var reportDate = year +'' + (month >= 10 ? month : '0' + month) + '' + (date >= 10 ? date : '0' + date);
	
	if(count > 0) download(workbook, "server_result_detail_admin_"+ reportDate);
	else alert("다운로드 할 목록이 없습니다.");
	
});

function detailExcelDwonload(workbook, name, data) {
	var result = 0;
	
	var sheet =  workbook.addWorksheet(name);
	var headers = [
		{header: 'ID', key: 'id', width: 6, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: 'hash_id', key: 'hash_id', width: 10, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: 'Target_id', key: 'target_id', width: 20, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '호스트', key: 'host', width: 20, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: 'IP', key: 'ip', width: 15, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '연결상태', key: 'connected', width: 15, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: ' ', key: 'subpath', width: 5, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '위치', key: 'location', width: 25, style: {font: {size: 10}}},
		{header: '파일소유자', key: 'owner', width: 10, style: {font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '파일수정일', key: 'updated', width: 15, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '검출수', key: 'total', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '주민번호', key: 'rrn', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '외국인번호', key: 'frn', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '여권번호', key: 'pass', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '운전번호', key: 'drive', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '계좌번호', key: 'acc', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '카드번호', key: 'card', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '이메일', key: 'email', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '휴대폰', key: 'phone', width: 8, style: { font: {size: 10}, alignment: {horizontal: 'center'}}},
		{header: '검출데이터', key: 'data', width: 30, style: { font: {size: 10}, }},
		{header: '검출내역', key: 'path', width: 30, style: { font: {size: 10}}},
		{header: '상세결과', key: 'detail', width: 35, style: { font: {size: 10}}},
		{header: '비고', key: 'note', width: 5, style: { font: {size: 10}}}, 
		{header: '접속상태', key: 'status', width: 10, style: { font: {size: 10}, alignment: {horizontal: 'center'}}}];
	
	sheet.getRow(1).fill = {
		type: 'pattern',
		pattern:'solid',
		fgColor:{ argb:'ff8080' } 
	}
	sheet.getRow(1).font = {
		size: 10,
        bold: true
    };
	
	sheet.getRow(1).alignment = {
		horizontal: 'center'
    };
	
	sheet.columns = headers;
	
	
	var row = [];
	// 하위경로 체크
    var infoIDNull = false;
	var contentList = []
	
	for(var i = 0; i < data.length; i++){
		var matchList = [];
 	    var metasCount = [0,0,0,0,0,0,0,0,0,0];
 	    var uri = "";
 	    
 	    if(data[i].CHK != "") infoIDNull = true;
 	    else infoIDNull = false; 
 	   
		var type1=0, type2=0, type3=0, type4=0, type5=0, type6=0, type7=0, type8=0, type_total = 0;
		
		
		if(!infoIDNull){
			uri = window.location.protocol + "//" + window.location.host +"/popup/detectionDetail?tid="+data[i].target_id+"&fid="+data[i].fid;
			
			if(data[i].metasResultList != null){
				for(var j=0 ; j < data[i].metasResultList.length; j++) {
					var type = data[i].metasResultList[j].metas_type;
					var metas_val = data[i].metasResultList[j].metas_val;
					
					if(type.toUpperCase().indexOf("South Korean RRN".toUpperCase()) > -1){
						type1 = parseInt(metas_val);
						type_total += type1;
					}else if(type.toUpperCase().indexOf("South Korean Foreigner Number".toUpperCase()) > -1){
						type2 = parseInt(metas_val);
						type_total += type2;
					}else if(type.toUpperCase().indexOf("South Korean Passport".toUpperCase()) > -1){
						type3 = parseInt(metas_val);
						type_total += type3;
					}else if(type.toUpperCase().indexOf("South Korean Driver License Number".toUpperCase()) > -1){
						type4 = parseInt(metas_val);
						type_total += type4;
					}else if(type.toUpperCase().indexOf("Account Number".toUpperCase()) > -1){
						type5 = parseInt(metas_val);
						type_total += type5;
					}else if(type.toUpperCase().indexOf("Email".toUpperCase()) > -1){
						type6 = parseInt(metas_val);
						type_total += type6;
					}else if(type.toUpperCase().indexOf("Phone Number".toUpperCase()) > -1){
						type7 = parseInt(metas_val);
						type_total += type7;
					}else if(
							type.toUpperCase().indexOf("VISA") > -1 || 
							type.toUpperCase().indexOf("MAESTRO") > -1 || 
		                    type.toUpperCase().indexOf("PRIVATE LABEL CARD") > -1 || 
		                    type.toUpperCase().indexOf("DINERS CLUB") > -1 || 
		                    type.toUpperCase().indexOf("JCB") > -1 || 
		                    type.toUpperCase().indexOf("LASER") > -1 || 
		                    type.toUpperCase().indexOf("MASTERCARD") > -1 || 
		                    type.toUpperCase().indexOf("CHINA UNION PAY") > -1 || 
		                    type.toUpperCase().indexOf("DISCOVER") > -1 || 
		                    type.toUpperCase().indexOf("TROY") > -1 || 
		                    type.toUpperCase().indexOf("AMERICAN") > -1  
		                 ){
						type8 = parseInt(metas_val);
						type_total += type8;
					}
				}
			}
		} else {
			uri = window.location.protocol + "//" + window.location.host + "/popup/lowPath?tid="+data[i].target_id+"&hash_id="+data[i].hash_id;
			type1=parseInt(data[i].TYPE1);
			type2=parseInt(data[i].TYPE2); 
			type3=parseInt(data[i].TYPE3); 
			type4=parseInt(data[i].TYPE4); 
			type5=parseInt(data[i].TYPE5);
			type6=parseInt(data[i].TYPE6); 
			type7=parseInt(data[i].TYPE7); 
			type8=parseInt(data[i].TYPE8);
			type_total = parseInt(data[i].TYPE);
		}
		
        var content_cnt = 0;
        var result_content;
        var richText = [];
        var matchData = "";
        
        result_content = new Array(data[i].chunksResultList.length);
        
		for(var j=0 ; j < data[i].chunksResultList.length; j++) {
			var chunks = data[i].chunksResultList[j]; 
			
     	    var chunk_offset = parseInt(chunks.chunks_offset);
     	    var chunk_length = parseInt(chunks.chunks_length);
     	    result_content[j] = chunks.chunks_CON;
     	     
			for(content_cnt; content_cnt < data[i].matchResultList.length; content_cnt++){
     		   var matchs = data[i].matchResultList[content_cnt]; 
     		   
    		   var content_offset = parseInt(matchs.match_offset);
    		   var check_offset = (parseInt(chunk_offset) <= parseInt(content_offset)) && (parseInt(content_offset) <= (parseInt(chunk_offset) + parseInt(chunk_length)));
     		   
    		   if(check_offset) {
    			   
    			   var con_length = matchs.match_length;
    			   var pi_detection = matchs.match_CON;
    			   //matchData += pi_detection + `\r\n${tags.join(', ')}`;
    			   matchData += pi_detection + '\r\n';
    			   
    			   var index = result_content[j].indexOf(pi_detection);
    			   var firstCon = result_content[j].substring(0, index);
    			   if(firstCon != ""){
    				   richText.push({ 
        				   text: firstCon, font: {size : 10}, 
        			   });
    			   }
    			   
    			   richText.push({ 
    				   text: pi_detection, font: {color: {argb: '00FF0000',theme: 1}, size : 10, bold:true}, 
    			   });
    			   
    			   // 작성한 내용은 날려준다.
    			   result_content[j] = result_content[j].substring((index+con_length));
    			   
    			    
    		   } else {
    			   break;
    		   }
    		   
     	   } 
			if(result_content[j] != ""){ 
				richText.push({ 
				 	text: result_content[j], font: {size : 10}, 
				});
			}
			/* richText.push({
			  text: `\r\n${tags.join(', ')}`,
			}); */
		 richText.push({
			  text: '\r\n',
			});
		}
		
		const rowData = {
			'id' :data[i].fid,
			'hash_id' : data[i].hash_id,
			'target_id' : data[i].target_id,
			'host' : name,
			'ip' : data[i].agent_ip,
			'connected' : data[i].agent_connected,
			'subpath' : data[i].CHK,
			'location' : data[i].path,
			'owner' : data[i].owner,
			'updated' : data[i].Modified_Date,
			'total' : type_total,
			'rrn' : type1,
			'frn' : type2,
			'pass' : type3,
			'drive' : type4,
			'acc' : type5,
			'card' : type6,
			'email' : type7,
			'phone' : type8,
			'data' : matchData,
			'path' : {
				richText : richText
			},
			'detail' : uri,
			'note' : '',
			'status' : '',
		}
		
		
		row.push(rowData);
		result = 1;
	}
	if(result == 1){
		sheet.addRows(row);
	}
	return result;
}

function download (workbook, fileName) {
	
	const buffer = new Promise(function (resolve, reject) {
		  resolve(workbook.xlsx.writeBuffer());
	});
	
	/* 비동기 처리를 위한 작업 */
	buffer.then(function(val){
	  	var blob = new Blob([val], {
	    	type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
	    });  
	    //var blob = new Blob(["Hello, world!"], {type: "text/plain;charset=utf-8"});
	    saveAs(blob, fileName + '.xlsx');
	});
};


</script>

</body>
</html>
