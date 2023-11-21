<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>
<style>
.ui-jqgrid tr.ui-row-ltr td{
	cursor: pointer;
}
.ui-jqgrid td select{
	padding: 0;
}
.grid_top{
	width: 50%;
	float: left;
	padding: 0 25px 22px 0;
}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.popup_tbl td input[type="date"]{
		width: 160px !important;
	}
}
</style>
<section>
	<div class="container">
		<h3>연동 관리</h3>
			<div class="content magin_t25">
				<!-- user info -->
<!-- 				[{mail=Y}, {approval=Y}, {parttern=Y}, {mailCon=Y}] -->
				<c:forEach var="set" items="${setMap}">
	            	<c:if test="${set.mail == 'Y'}">
						<div class="grid_top" >
		            		<table style="width: 100%;">
	                    		<caption>메일 연동</caption>
								<colgroup>
									<col width="*"/>
									<col width="500px"/>
								</colgroup>
								<tr>
									<td><h3 style="padding: 0;">${set.NAME}</h3></td>
								</tr>
							</table>
							<table class="user_info narrowTable" style="width: 100%; display: inline-block;">
	                    		<tbody>
	                    			
	                        		<tr>
	                            		<th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">사용자명</th>
			                            <td style="padding: 5px 5px 0 5px;;">
			                            </td>
			                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">팀명</th>
			                            <td style="padding: 5px 5px 0 5px;">
			                            </td>
	                        		</tr>
	                    		</tbody>
	               			</table>
						</div>
	             	</c:if>
	            	<c:if test="${set.mailCon == 'Y'}">
						<div class="grid_top">
		            		<table style="width: 100%;">
	                    		<caption>메일 내용 관리</caption>
								<colgroup>
									<col width="*"/>
									<col width="500px"/>
								</colgroup>
								<tr>
									<td><h3 style="padding: 0;">${set.NAME}</h3></td>
								</tr>
							</table>
							<table class="user_info narrowTable" style="width: 100%; display: inline-block;">
	                    		<tbody>
	                    			
	                        		<tr>
	                            		<th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">사용자명</th>
			                            <td style="padding: 5px 5px 0 5px;;">
			                            </td>
			                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">팀명</th>
			                            <td style="padding: 5px 5px 0 5px;">
			                            </td>
	                        		</tr>
	                    		</tbody>
	               			</table>
						</div>
	             	</c:if>
	            	<c:if test="${set.approval == 'Y'}">
						<div class="grid_top">
		            		<table style="width: 100%;">
	                    		<caption>결재 관리</caption>
								<colgroup>
									<col width="*"/>
									<col width="500px"/>
								</colgroup>
								<tr>
									<td><h3 style="padding: 0;">${set.NAME}</h3></td>
								</tr>
							</table>
							<table class="user_info narrowTable" style="width: 100%; display: inline-block;">
	                    		<tbody>
	                    			
	                        		<tr>
	                            		<th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">사용자명</th>
			                            <td style="padding: 5px 5px 0 5px;;">
			                            </td>
			                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">팀명</th>
			                            <td style="padding: 5px 5px 0 5px;">
			                            </td>
	                        		</tr>
	                    		</tbody>
	               			</table>
						</div>
	             	</c:if>
	            	<c:if test="${set.parttern == 'Y'}">
						<div class="grid_top">
		            		<table style="width: 100%;">
	                    		<caption>개인정보 유형</caption>
								<colgroup>
									<col width="*"/>
									<col width="500px"/>
								</colgroup>
								<tr>
									<td><h3 style="padding: 0;">${set.NAME}</h3></td>
								</tr>
							</table>
							<div class="left_box2" style="overflow: hidden; max-height: 555px; height: 555px;">
			   					<table id="patternGrid"></table>
			   					<div id="patternGridPager"></div>
							</div>
						</div>
	             	</c:if>
				</c:forEach>
			</div>
	</div>
</section>
<!-- section -->
<%@ include file="../../include/footer.jsp"%>

<!-- 개인정보 상세 보기 팝업 -->
<div id="btnPatternPop" class="popup_layer" style="display: none;">
	<div class="ui-widget-content" id="popup_datatype" style="position:absolute; height: 515px; left: 27%; top: 18%; touch-action: none; max-width: 920px; z-index: 999; background: #f9f9f9;">
		<img class="CancleImg" id="btnCanclebtnPatternPop" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
			<div class="popup_container">
				<div class="popup_top" style="background: #f9f9f9;">
					<h1 style="color: #222; box-shadow: none; padding: 0;" id="patternNm">개인정보 유형 수정</h1>
				</div>
				<div class="popup_content">
					<div class="content-box" style="width: 900px !important; height: 417px; background: #fff; border: 1px solid #c8ced3; ">
						<table class="popup_tbl">
							<colgroup>
								<col width="20%">
								<col width="*">
								<col width="20%">
								<col width="*">
								<col width="3%">
							</colgroup>
							<tr>
								<th>개인정보 검출 유형 명</th>
								<td colspan="3" id="patternReconNmTd"><input type="text" id="patternReconNm" style="width: 100%;"></td>
							</tr>
							<tr>
								<th>영문 개인정보 유형 명</th>
								<td><input type="text" id="patternNameKr" style="width: 100%;"></td>
								<th>한글 개인정보 유형 명</th>
								<td><input type="text" id="patternNameEr" style="width: 100%;"></td>
							</tr>
							<tr>
								<th>마스킹 위치</th>
								<td>
									<select id="patternMaskType" name="patternMaskType" style="width: 100%;">
	                                	<option value="T" > 처음</option>
	                                	<option value="B"> 마지막</option>
	                                </select>
								</td>
								<th>마스킹 기준</th>
								<td><input type="text" id="patternMaskChk" style="width: 100%;" placeholder=" 기준이 될 마스킹 위치를 입력해주세요"></td>
							</tr>
							<tr>
								<th>마스킹 개수</th>
								<td><input type="number" id="patternMaskCnt" style="width: 100%;"></td>
								<th>개인정보 색상</th>
								<td>
									<input type="text" id="patternColor" style="width: 50%;">
									<div style="width: 40%; float:right; margin-top:7px;" id="bakPatternColor">&nbsp;</div>
								</td>
							</tr>
							<tr>
								<th>개인정보 규칙</th>
								<td colspan="3" id="patternRuleTd">
									<textarea id="patternRule" style="width: 100%; height:200px;  resize: none;"></textarea>
								</td>
							</tr>
						</table>
					</div>
				<div class="popup_btn">
					<div class="btn_area" style="padding: 10px 2px; margin: 0;">
						<p id="comment" style="position: absolute; bottom: 17px; right: 247px; font-size: 12px; color: #2C4E8C; text-align : center;">개인정보 유형을 자주 수정할 시 올바른 데이터가 조회되지 않을 수도 있습니다.</p>
						<button type="button" id="btnPatternPopClose" style="font-weight: inherit; font-size: 12px; padding: 0 15px;">닫기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 개인정보 상세보기 팝업 종료 -->


<script type="text/javascript">

$(document).ready(function () {
	patternGrid();
});


function patternGrid(){
	$("#patternGrid").jqGrid({
<%-- 		url: "<%=request.getContextPath()%>/setting/patternList", --%>
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		colNames:['', '순서', '구분', '개인정보 유형 명','염문 유형명',  '표기 색상', '표기 색상', '마스킹 개수', '마스킹 기준', '마스킹 위치', '마스킹 순서', '','개인정보 패턴'],
		colModel: [
			{ index: 'PATTERN_IDX', 		name: 'PATTERN_IDX', 		width : 5, align : 'center', hidden:true},
			{ index: 'PATTERN_CNT', 		name: 'PATTERN_CNT',		width: 10, align: 'left', hidden:true},
			{ index: 'PATTERN_KR_NAME', 	name: 'PATTERN_KR_NAME',	width: 20, align: 'left'},
			{ index: 'PATTERN_CODE', 		name: 'PATTERN_CODE',		width: 50, align: 'left'}, 
			{ index: 'PATTERN_EN_NAME', 	name: 'PATTERN_EN_NAME',	width: 0, align: 'left', hidden:true},
			{ index: 'COLOR_CODE', 			name: 'COLOR_CODE',			width: 40, align: 'left', hidden:true},
			{ index: 'COLOR', 				name: 'COLOR',				width: 40, align: 'left',  formatter: dataColor},
			{ index: 'MASK_CNT', 			name: 'MASK_CNT',			width: 0, align: 'center', hidden:true},
			{ index: 'MASK_CHK',			name: 'MASK_CHK',			width: 0, align: 'center', hidden:true},
			{ index: 'MASK_TYPE', 			name: 'MASK_TYPE', 			width: 0, align: 'center', hidden:true},
			{ index: 'MASK_DETAIL', 		name: 'MASK_DETAIL', 		width: 35, align: 'center', formatter: maskType},
			{ index: 'PATTERN_UPDATED', 	name: 'PATTERN_UPDATED', 	width: 20, align: 'center', formatter: btnCreate},
			{ index: 'PATTERN_RULE',		name: 'PATTERN_RULE',		width: 0, align: 'center', hidden:true}
		],
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: $("#patternGrid").parent().width(),
		height: 200,
		loadonce: true, // this is just for the demo
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 30, // 행번호 열의 너비	
		rowNum:25,
		rowList:[25,50,100],		
		pager: "#patternGridPager",
		cmTemplate: {sortable: false},
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
	    }
	});
	
	var postData = {};
	$("#patternGrid").setGridParam({
		url:"<%=request.getContextPath()%>/setting/patternList", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
	
}

function btnPatternPop(rowId, status){
	 var data = $('#patternGrid').getRowData(rowId);
	 
	 var PATTERN_KR_NAME = data.PATTERN_KR_NAME;
	 var PATTERN_EN_NAME = data.PATTERN_EN_NAME;
	 var COLOR_CODE = data.COLOR_CODE;
	 var MASK_CNT = data.MASK_CNT;
	 var MASK_CHK = data.MASK_CHK;
	 var MASK_TYPE = data.MASK_TYPE;
	 var PATTERN_RULE = data.PATTERN_RULE;
	 var PATTERN_CODE = data.PATTERN_CODE;
	 
	 $("#patternNm").html(PATTERN_KR_NAME +" 유형 수정");
	 
	 $("#patternColor").val(COLOR_CODE);
	 $("#bakPatternColor").css("background-color", COLOR_CODE);
	 
	 $("#patternReconNm").val(PATTERN_CODE);
	 $("#patternNameKr").val(PATTERN_EN_NAME);
	 $("#patternNameEr").val(PATTERN_KR_NAME);
	 $("#patternMaskCnt").val(MASK_CNT);
	 $("#patternMaskChk").val(MASK_CHK);
	 $("#patternRule").val(PATTERN_RULE);
	 
	 if(status != 'Y'){
		 $("#patternReconNm").hide();
		 $("#patternRule").hide();
		 
		 $("#patternReconNmTd").html(PATTERN_CODE);
		 $("#patternRuleTd").html(PATTERN_RULE);
		 
	 }
	 
	 $("select[name=patternMaskType]").val(MASK_TYPE).prop("selected", true);
	 $("#btnPatternPop").show();
};

$("#btnPatternPopClose, #btnCanclebtnPatternPop").click(function(){
	
	$("#patternNm").html("개인정보 유형 수정");
	$("#btnPatternPop").hide();
})

$("#patternColor").change( function(){
	
	var bColor = $("#patternColor").val();
	
	if(bColor.match(/^#([0-9a-f]{3}){1,2}$/i)){
		 $("#bakPatternColor").css("background-color", bColor);
	}
	
});
		

function dataColor(cellvalue, options, rowObject) {
	
	var result = cellvalue;
	
	var COLOR_CODE = rowObject.COLOR_CODE;
	
	if( COLOR_CODE != null &&  COLOR_CODE.match(/^#([0-9a-f]{3}){1,2}$/i)){
		
		result =  COLOR_CODE +"<div style=\"width: 54%; float:right; background-color : "+ COLOR_CODE+"; \">&nbsp;</div>"
	}else{
		 result = "지정된 색상이 없습니다.";
	}
	return result;
}

function maskType(cellvalue, options, rowObject) {
	
	var cnt = rowObject.MASK_CNT;
	var chk = rowObject.MASK_CHK;
	
	var result = "";
	
	if(rowObject.MASK_TYPE =="T"){
		result = "앞 " + cnt + " 자리";
	}else if(rowObject.MASK_TYPE =="B"){
		result = "뒤 " + cnt + " 자리";;		
	}
	
	if(chk != null && chk != ""){
		result +=" ( 기준 : " + chk + ")";
	}
	return result;
}

function btnCreate(cellvalue, options, rowObject) {
	if(cellvalue == 'Y'){
		return "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' onClick='btnPatternPop("+options.rowId+", \"Y\")'>선택</button>";
	}else {
		return "<button type='button' style='padding-top: 4px; padding-bottom:4px;' class='gridSubSelBtn' onClick='btnPatternPop("+options.rowId+", \"N\")'>조회</button>";
	}
}


</script>
	
</body>
</html>