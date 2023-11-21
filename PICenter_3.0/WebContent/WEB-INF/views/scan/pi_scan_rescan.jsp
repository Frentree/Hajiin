<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>스캔 관리</h3>
					<p class="location">스캔 관리 > 스캔 스캐줄</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>검색 정책</h3>
		<!-- content -->
		<div class="content magin_t25">
			<div class="location_area">
				<p class="location">스캔 관리 > 재검색 정책</p>
			</div>
			<table class="user_info">
                    <caption>검출 리스트</caption>
                    <tbody>
                        <tr>
                            <th style="text-align: center; width:100px">정책 명</th>
                            <td style="width:350px;">
                            	<p style="margin-bottom: 5px;"><a id="searchHost" style="font-size: 13px; line-height: 2; padding-left: 5px;"></a>
                                <!-- <input type="text" id="searchHost" value="" class="edt_sch" style="width: 80%; height: 100%" readonly="readonly"> -->
                            	<input type="hidden" id="hostSelect" value="">
                            	<input type="hidden" id="ap_no" value="">
                            	</p>
                            	<input type="button" name="button" class="btn_look" id="btnSearchHost" style="margin-top: -27px;">
                            </td>
                        </tr>
                    </tbody>
                </table>
			<div class="grid_top" style="height: 100%; width: 100%; padding-top:10px;">
				<div class="left_box2" style="height: 300px; overflow: hidden;">
   					<table id="topNGrid"></table>
   				 	<div id="topNGridPager"></div>
   				</div>
			</div>
			<div class="grid_top" style="width: 50%; height: 372px; float: left; padding-top:20px;">
				<table class="user_info" style="width: 100%; height: 100%; float: left;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th style="border-bottom:1px solid #c8ced3;">정책명</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3;">개인정보유형</th>
							<td>-</td>
						</tr>
						<tr>
							<th>활성화 여부</th>
							<td>-</td>
						</tr>
					</tbody>
				</table> 
			</div>
			<div class="grid_top" style="width: 50%; height: 320px; float: right; padding-left:20px; padding-top:20px;">
				<table class="user_info" style="width: 100%; height: 100%; float: right;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th style="border-bottom:1px solid #c8ced3;">정책 상세 정보</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3;">정책명</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3;">개인정보 유형 명</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">정채 시작 시간</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">개인정보 유형</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">활성화</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">적용 범위</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">주기</th>
							<td>-</td>
						</tr>
						<tr>
							<th style="border-bottom:1px solid #c8ced3">일시정지 시간</th>
							<td>-</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right; padding: 8px 8px;">
								<button class="btn_down" type="button" id="btnSave" name="btnSave">수정/삭제</button> 
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- container -->
</section>
<!-- section -->
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>

$(document).ready(function () {
	fn_drawTopNGrid();
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
		colNames:['정책명','개인정보 유형'],
		colModel: [
			{ index: 'NAME', 	name: 'PATH', 	editable: true, width: 200 },
			//{ index: 'OWNER', 	name: 'OWNER', 	width: 100, align: "center" },
			{ index: 'TYPE', 	name: 'CNT', 	width: 200},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 210,
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

</script>

</body>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>

<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>스캔 관리</h3>
					<p class="location">스캔 관리 > 스캔 스캐줄</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
		<%-- <%@ include file="../../include/menu.jsp"%> --%>
		<h3>검색 정책</h3>
		<!-- content -->
		<div class="content magin_t25">
			<div class="location_area">
				<p class="location">스캔 관리 > 재검색 정책</p>
			</div>
			<table class="user_info">
                    <caption>검출 리스트</caption>
                    <tbody>
                        <tr>
                            <th style="text-align: center; width:100px">정책 명</th>
                            <td style="width:350px;">
                            	<p style="margin-bottom: 5px;"><a id="searchHost" style="font-size: 13px; line-height: 2; padding-left: 5px;"></a>
                                <!-- <input type="text" id="searchHost" value="" class="edt_sch" style="width: 80%; height: 100%" readonly="readonly"> -->
                            	<input type="hidden" id="hostSelect" value="">
                            	<input type="hidden" id="ap_no" value="">
                            	</p>
                            	<input type="button" name="button" class="btn_look" id="btnSearchHost" style="margin-top: -27px;">
                            </td>
                        </tr>
                    </tbody>
                </table>
			<div class="grid_top" style="height: 100%; width: 100%; padding-top:20px;">
				<div class="left_box2" style="height: 300px; overflow: hidden;">
   					<table id="topNGrid"></table>
   				 	<div id="topNGridPager"></div>
   				</div>
			</div>
			<div class="grid_top" style="width: 50%; height: 386.3px; float: left; padding-top:20px;">
				<table class="user_info" style="width: 100%; height: 100%; float: left;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th class="borderB">정책명</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">개인정보유형</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">활성화 여부</th>
							<td>-</td>
						</tr>
					</tbody>
				</table> 
			</div>
			<div class="grid_top" style="width: 50%; height: 350px; float: right; padding-left:20px; padding-top:20px;">
				<table class="user_info" style="width: 100%; height: 100%; float: right;">
					<caption>정책 상세 정보</caption>
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th class="borderB">정책 상세 정보</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">정책명</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">개인정보 유형 명</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">정채 시작 시간</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">개인정보 유형</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">활성화</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">적용 범위</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">주기</th>
							<td>-</td>
						</tr>
						<tr>
							<th class="borderB">일시정지 시간</th>
							<td>-</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: right; padding: 8px 8px;">
								<button class="btn_down" type="button" id="btnSave" name="btnSave">수정/삭제</button> 
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<!-- container -->
</section>
<!-- section -->
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>

$(document).ready(function () {
	fn_drawTopNGrid();
});

function fn_drawTopNGrid() {
	
	var gridWidth = $("#topNGrid").parent().width();
	$("#topNGrid").jqGrid({
		url: "<%=request.getContextPath()%>/target/selectAdminServerFileTopN",
		datatype: "local",
	   	mtype : "POST",
		colNames:['정책명','개인정보 유형'],
		colModel: [
			{ index: 'NAME', 	name: 'PATH', 	editable: true, width: 200 },
			//{ index: 'OWNER', 	name: 'OWNER', 	width: 100, align: "center" },
			{ index: 'TYPE', 	name: 'CNT', 	width: 200},
		],
		loadonce:true,
	   	autowidth: true,
		shrinkToFit: true,
		viewrecords: true, // show the current page, data rang and total records on the toolbar
		width: gridWidth,
		height: 220,
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

</script>

</body>
>>>>>>> refs/remotes/origin/skt
</html>