<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../include/header.jsp"%>
<style>
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
		white-space: nowrap;
	}
</style> 
<!-- 검출관리 -->

<!-- section -->
<section>
	<!-- container -->
	<div class="container">
	<%-- <%@ include file="../../include/menu2.jsp"%> --%>
		<!-- content -->
		<h3 style="display: inline; top: 25px;">조치계획 승인요청</h3>
		<p style="position: absolute; top: 33px; left: 221px; font-size: 13px; color: #9E9E9E;">처리 진행 상태(정탐,오탐)를 확인 하실수 있습니다.</p>
		<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 496px; cursor: pointer;" id="userHelpIcon">
		<%-- <div id="userHelpPopup" class="popup_layer" style="display:none">
			<div class="popup_box" style="height: 200px; width: 1130px; padding: 10px; background: #f9f9f9; top: 44%; left: 34%;">
				<img class="CancleImg" id="btnCancleUserHelpPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
				<div class="popup_top" style="background: #f9f9f9;">
					<h1 style="color: #222; padding: 0; box-shadow: none;"></h1>
				</div>
				<div class="popup_content">
					<div class="content-box" id="userHelpImg" style="height: 612px; background: #fff; border: 1px solid #c8ced3; text-align: center;">
						<img src="${pageContext.request.contextPath}/resources/assets/images/search_list_help_icon.png" style="height: 100%;">
					</div>
				</div>
				<div class="popup_btn">
					<div class="btn_area" style="padding: 10px 0; margin: 0;">
						<!-- <button type="button" id="btnUserDateDelete">계정삭제</button> -->
						<button type="button" id="btnCloseUserHelpPopup">닫기</button>
					</div>
				</div>
			</div>
		</div> --%>
		<div class="content magin_t35">
			<div class="grid_top">
				<div class="list_sch">
					<div class="sch_area" style="margin-top: 47px;">
						<button type="button" name="button" class="btn_down" id="btnDeleteItem">항목 삭제</button>
						<button type="button" name="button" class="btn_down" id="btnApprovalRequest">결재 요청</button>
						<button type="button" name="button" class="btn_down" id="btnDownloadExel">다운로드</button>
					</div>
				</div>
				<table class="user_info approvalTh" style="width: 1135px;">
					<caption>사용자정보</caption>
					<tbody>
						<tr>
                            <th style="text-align: center; width:100px; padding: 5px 5px 0 5px; border-radius: 0.25rem;">업무 구분</th>
                            <td style="padding: 5px 5px 0 5px;">
                                <select id="selectList" name="selectList" style="width:186px;">
                                    <option value="/approval/pi_search_list" selected>조치계획 승인요청</option>
                                    <option value="/approval/pi_search_approval_list" >결재 진행현황</option>
                                    <!-- <option value="">경로 예외 리스트</option>
                                    <option value="">경로 예외 결재 리스트</option> 
                                    <option value=""> 담당자 변경 리스트</option>
                                    <option value="">경로 담당자 변경 리스트</option> -->
                                </select>
                            </td>
                            <th style="text-align: center; padding: 5px 5px 0 5px; width:100px;">상태</th>
                            <td style="padding: 5px 5px 0 5px;">
                                <select id="statusList" name="statusList" style="width:186px;">
                                    <option value="">전체</option>
                                    <option value="E">승인완료</option>
                                    <option value="D">반려</option>
                                    <option value="W">승인대기</option>
                                    <option value="NR" selected>미요청</option>
                                </select>
                            </td>
                            <th style="text-align: center; padding: 5px 5px 0 5px; width:100px;">처리구분</th>
                            <td style="padding: 5px 5px 0 5px;">
                                <select id="processingFlag" name="statusList" style="width:186px;">
                                    <option value="">전체</option>
                                    <option value="1">정탐(수동삭제)</option>
                                    <option value="2">정탐(자동삭제)</option>
                                    <option value="3">정탐(암호화저장)</option>
                                    <option value="4">정탐(평문유지)</option>
                                    <option value="5">오탐(수동삭제)</option>
                                    <option value="6">오탐(평문유지)</option>
                                </select>
                            </td>
                            <%-- <th style="text-align: center; width:100px; border-radius: 0.25rem;">문서 기안일</th>
                            <td style="padding: 5px 5px 0 5px;">
                                <input type="date" id="fromDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
                            </td> --%>
                            <td rowspan="3">
                           		<input type="button" name="button" class="btn_look_approval" id="btnSearch">
                           	</td>
						</tr>
						<tr>                            
                            <th style="text-align: center; padding: 5px 5px 0 5px; width:100px">호스트</th>
							<td style="padding: 5px;"><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="schOwner" placeholder="호스트명을 입력하세요"></td>
							<th style="text-align: center; padding: 5px 5px 0 5px; width:100px">문서명</th>
							<td style="padding: 5px;"><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="20" id="schFilename" placeholder="문서명을 입력하세요"></td>
							<th style="text-align: center; width:100px; border-radius: 0.25rem;">문서 기안일</th>
                            <td>
                                <input type="date" id="fromDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
								<input type="date" id="toDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${toDate}" >
                            </td>
<!-- 							<td>
							</td>
 -->						</tr>
						<%-- <tr>
							<th style="text-align: center; width:100px; border-radius: 0.25rem;">문서 기안일</th>
                            <td>
                                <input type="date" id="fromDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${fromDate}" >
                                <span style="width: 8%; margin-right: 3px;">~</span>
                                <input type="date" id="toDate" style="text-align: center; width:186px; font-size:12px;" readonly="readonly" value="${toDate}" >
                            </td>
                        </tr> --%>
					</tbody>
				</table>
			</div>
			<div class="left_box2" style="overflow: hidden; max-height: 635px; height: 635px; margin-top: 10px">
  					<table id="processGrid"></table>
  					<div id="Pages"></div>
			</div>
		</div>
	</div>
	<!-- container --

<!-- 팝업창 시작 : 정탐/오탐 결재요청 -->
<div id="ApprovalPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="width: 600px; height: 425px; top: 57%; left: 50%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleApprovalPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 id="approvalRegis" style="color: #222; padding: 0; box-shadow: none;">승인 요청 등록</h1>
			<p style="position: absolute; top: 13px; left: 138px; font-size: 12px; color: #9E9E9E;"></p>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 368px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="130">
						<col width="*">
						<col width="130">
					</colgroup>
					<tbody>
						<tr>
							<th>요청자</th>
							<td colspan="2"><input type="text" id="reg_user_name" value="" class="edt_sch" style="border: 0px solid #cdcdcd; " readonly></td>
						</tr>
						<tr>
							<th>전자결재 기안자</th>
							<td>
								<input type="text" id="ok_user_name" value="" class="edt_sch" style="border: 0px solid #cdcdcd; width:100%;" readonly>
                            </td>
                            <td class="btn_area" style="padding-left: 30px !important; text-align: left;">
								<button type="button" id="btnUserSelectPopup" style="margin: 0; padding: 0 15px; width: 100px;">선택</button>
								<input type="text" id="ok_user_no" value="" class="edt_sch" style="border: 0px solid #cdcdcd; display:none;">
							</td>
						</tr>
						<tr>
							<th>요청일자</th>
							<td colspan="2"><input type="text" id="regdate" value="" class="edt_sch" style="border: 0px solid #cdcdcd;" readonly></td>
						</tr>
						<tr>
							<th rowspan="2">의견</th>
							<td colspan="2">
								<textarea id="comment" class="edt_sch" placeholder="" style="border: 1px solid #cdcdcd; width: 100%; height: 200px; margin-top: 5px; margin-bottom: 5px; resize: none;"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<span style="font-size: 12px; color: #9E9E9E;">저장 시 전자 결재 문서가 생성되며 작성한 의견은 결재자가 참고하는 내용이니<br> 상세히 작성 바랍니다.</span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0;">
				<p style="position: absolute; bottom: 17px; right: 148px; font-size: 12px; color: #2C4E8C;">전자결재 문서가 생성되고, 선택하신 기안자에게 메일이 전송됩니다.</p>
				<button type="button" id="btnApprovalSave" value="W">저장</button>
				<button type="button" id="btnApprovalCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 담당자 지정 -->
<div id="userSelect" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 200px; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleUserSelect" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">기안자 지정</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 425px; background: #fff; border: 1px solid #c8ced3;">
				<table style="padding-bottom: 10px;">
					<tbody>
					<tr>
						<th style="text-align: center; width:100px">팀명</th>
						<td><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="searchTeamName" placeholder="팀명을 입력하세요"></td>
                           <th style="text-align: center; width:100px">기안자</th>
						<td><input type="text" style="width: 186px; font-size: 12px; padding-left: 5px;" size="10" id="searchName" placeholder="기안자를 입력하세요."></td>
                           <td rowspan="3" >
                          		<input type="button" name="button" class="btn_look_approval" id="popBtnSearch" style="margin-left: 10px;">
                          	</td>
					</tr>
					</tbody>
				</table>
  				<table id="userGrid"></table>
   				<div id="userGridPager"></div>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0;">
				<button type="button" id="btnUserSelect">선택</button>
				<button type="button" id="btnUserCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 정탐/오탐 신청 내역-->
<div id="insertPathExcepPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 570px; top: 52%; left: 50%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleInsertPathExcepPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 id="groupName" style="color: #222; padding: 0; box-shadow: none;"></h1>
		</div> 
		<div class="popup_content">
			<div class="content-box" style="height: 500px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="130">
						<col width="*">
					</colgroup>
					<tbody> 
						<tr>
							<th style="border-bottom: 1px solid #cdcdcd;">이름</th>
							<td style="border-bottom: 1px solid #cdcdcd;">
								<div style="overflow-y: auto; height: 280px;">
									<table style="border: 0px solid #cdcdcd; width: 425px; height: 266px; margin-top: 5px; margin-bottom: 5px; resize: none; " >
									<tbody>
										<tr id="excepPath" style="border:none;">
										</tr>
									</tbody>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<th style="border-bottom: 1px solid #cdcdcd;">판단근거</th>
							<td style="border-bottom: 1px solid #cdcdcd;">
								<table style="border: 0px solid #cdcdcd; width: 430px; height: 90px; margin-top: 5px; margin-bottom: 5px; resize: none; " >
								<tbody>
									<tr id="BasisName" style="border:none;">
									</tr>
								</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<th style="border-bottom: 1px solid #cdcdcd;">사유</th>
							<td style="border-bottom: 1px solid #cdcdcd;">
								<input type="text" name="trueFalseChk" id="reason" value="" class="edt_sch" style=" border: 0px solid #cdcdcd;" readonly>
							</td>  
						</tr>
						<tr>
							<th style="border-bottom: 1px solid #cdcdcd;">등록서버</th>
							<td style="border-bottom: 1px solid #cdcdcd;">
								<input type="text" id="regisServer" value="" class="edt_sch" style=" border: 0px solid #cdcdcd;" readonly>
							</td>  
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnCheck">확인</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 종료  -->
<%
String browser = "";
String userAgent = request.getHeader("User-Agent");
%>
<%
if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
%>
	<div id="pathWindow" style="position:absolute; left: 400px; top: 350px; touch-action: none; width: 60%; height: 365px; z-index: 999; display:none; min-width: 35%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="background: #006EB6; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 36px;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>하위 경로 정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
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
} else {
%>
	<div id="pathWindow" style="position:absolute; left: 400px; top: 350px; touch-action: none; width: 60%; height: 365px; z-index: 999; display:none; min-width: 35%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="background: #006EB6; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 100%;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>하위 경로 정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
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
<%
if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
%>
	<div id="taskWindow" style="position:absolute; left: 340px; top: 350px; touch-action: none; width: 70%; height: 365px; z-index: 999; display:none; min-width: 30%; min-height: 200px;" class="ui-widget-content">
	<table class="mxWindow" style="width: 100%; height: 100%;">
	<tbody>
		<tr>
			<td class="mxWindowTitle" style="background: #006EB6; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 36px;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
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
							<td id="matchCount" style="width: 335px; min-width: 335px; max-width: 335px; height: 50px; padding: 5px;">&nbsp;</td>
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
			<td class="mxWindowTitle" style="background: #006EB6; cursor: grab; touch-action: none;">
				<table style="width: 100%; height: 100%;">
					<colgroup>
						<col width="*">
						<col width="30px">
					</colgroup>
					<tr>
						<td style="color: #ffffff; text-align: left; padding-left: 20px;"><h2>개인정보검출 상세정보</h2>
						</td>
						<td style="display: inline-block; padding-top: 6px; cursor: default;">
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
							<td id="matchCount" style="width: 35%; height: 50px; padding: 5px;">&nbsp;</td>
							<td style="width: 65%; height: 100%;" rowspan="2">
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

</section>
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>
var resetFomatter = null;
$(document).ready(function () {

	// 그리드 다운로드
	$("#btnDownloadExel").click(function(){
		downLoadExcel();
	});
	
    // 날짜 설정
    setSelectDate();

    // 상급자 설정
    var boss_user_name = "${teamManager.USER_NAME}"; 
    var boss_jikguk = "${teamManager.JIKGUK}"; 
    var boss_user_no = "${teamManager.USER_NO}";

    $("#ok_user_no").val(boss_user_no);
    $("#ok_user_name").val(boss_user_name + " " + boss_jikguk);

    // SelectList를 선택하면 선택된 화면으로 이동한다.
    $("#selectList").change(function () {
        location.href = $("#selectList").val();
    });

    // 조회조건 담당자 inputbox Keydown Event (사용자 조회)
    $("#schOwner, #schFilename").keydown(function(e) {
        if(e.keyCode == 13) 
            fn_search();
    });
    
    // 모달 검색 엔터 이벤트
    $("#searchTeamName, #searchName").keydown(function(e) {
        if(e.keyCode == 13) 
        	popSearch();
    });

    // 검색
    $("#statusList").change(function() {
        fn_search();
    });

    // 검색
    $("#btnSearch").click(function() {
    	fn_search();
    });

    $("#btnRescan").click(function() {
    	fn_rescan();
    });
    
    $("#popBtnSearch").click(function() {
    	popSearch();
    });
	
 	// 결재 요청전 항목 삭제 버튼
    $("#btnDeleteItem").click(function() {
    	delItem();
	});
    
    // 결재 요청 버튼
    $("#btnApprovalRequest").click(function() {
    	reqApproval();
	});

	// 결재 요청 > 취소
	$("#btnApprovalCancel").click(function (e) {
		$("#ApprovalPopup").hide();
		$("#comment").val("");
	});
	
	$("#btnCancleApprovalPopup").click(function (e) {
		$("#ApprovalPopup").hide();
		$("#comment").val("");
	});

	// 확인
	$("#btnCheck").click(function (e) {
		$("#insertPathExcepPopup").hide();
		var tr = $("#excepPath").children();
		tr.remove();
		$("#pathWindow").hide();
		$("#taskWindow").hide();
	});
	
	$("#btnCancleInsertPathExcepPopup").click(function (e) {
		$("#insertPathExcepPopup").hide();
	});

	// 결재 요청 - 담당자 선택
	$("#btnUserSelectPopup").click(function (e) {
	    $("#userSelect").show();
	    searchAppUserSelect();
	});

	// 결재 요청 - 담당자 선택 취소
	$("#btnUserCancel").on("click", function(e) {
		$("#searchName").val("");
        $("#searchTeamName").val("");
		
		$("#userSelect").hide();
	});
	
	$("#btnCancleUserSelect").on("click", function(e) {
		$("#searchName").val("");
        $("#searchTeamName").val("");
		
		$("#userSelect").hide();
	});

	$("#btnUserSelect").on("click", function(e) {
		var nRowid  = $("#userGrid").getGridParam("selrow");
		
		if(nRowid == "" || nRowid == null || nRowid == "undefined" || nRowid < 0) {
			alert("담당자를 선택하십시오");
			return false;
		}
		
		var sUserNm = $("#userGrid").getCell(nRowid, 'USER_NAME'); 
		var sJikguk = $("#userGrid").getCell(nRowid, 'JIKGUK'); 
		var sUserNo = $("#userGrid").getCell(nRowid, 'USER_NO');
		
		$("#ok_user_no").val(sUserNo);
		$("#ok_user_name").val(sUserNm);
		$("#userSelect").hide();
		
		$("#searchName").val("");
		$("#searchTeamName").val("");
		
		
	});

	// 결재 요청 - 저장
	$("#btnApprovalSave").click(function(e) {
		saveApproval();
	});
	
	$("#userHelpIcon").on("click", function(e) {
		/* $("#userHelpPopup").show(); */
		var id = "search_list";
		var pop_url = "${getContextPath}/popup/helpDetail";
    	var winWidth = 1140;
    	var winHeight = 655;
    	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
    	//var pop = window.open(pop_url,"detail",popupOption);
    	var pop = window.open(pop_url ,id, popupOption);
    	
    	var newForm = document.createElement('form');
    	newForm.method='POST';
    	newForm.action=pop_url;
    	newForm.name='newForm';
    	newForm.target=id;
    	
    	var data = document.createElement('input');
    	data.setAttribute('type','hidden');
    	data.setAttribute('name','id');
    	data.setAttribute('id','id');
    	data.setAttribute('value',id);
    	
    	newForm.appendChild(data);
    	document.body.appendChild(newForm);
    	newForm.submit();
    	
    	document.body.removeChild(newForm);
	});
    /* $("#btnCancleUserHelpPopup, #btnCloseUserHelpPopup").on("click", function(e) {
		$("#userHelpPopup").hide();
	}); */
	
    loadJqGrid($("#processGrid"));
});

/* $(document).mouseup(function (e){
	  var LayerPopup = $("#userHelpPopup");
	  if(LayerPopup.has(e.target).length === 0){
		  $("#userHelpPopup").hide();
	  }
}); */

// 정탐/오탐 리스트 그리드 조회
function loadJqGrid(oGrid)
{
    // 정탐/오탐 리스트 그리드
    var oPostDt = {};
    oPostDt["status"]   = $("select[name='statusList']").val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();
    oPostDt["toDate"]   = $("#toDate").val();

    oGrid.jqGrid({

        url: "${getContextPath}/approval/searchProcessList",
        postData: oPostDt,
        datatype: "json",
        mtype: "POST",
        async: true,
        contentType: "application/json; charset=UTF-8",
        colModel: [
            {label: 'IDX',			index: 'IDX',             name: 'IDX',             width: 10,  hidden:true},
            {label: '호스트', 	    index: 'NAME',           name: 'NAME',           width: 80,  align: 'center', formatter: macName},
            {label: '조치자',		index: 'USER_NO',         name: 'USER_NO',         width: 50, align: 'center'},
            {label: '문서명',			index: 'FILENAME',        name: 'FILENAME',        width: 200, align: 'left'},  
            {label: '문서 저장일',		index: 'REGDATE',         name: 'REGDATE',         width: 100,  align: 'center'}, 
            {label: '문서 기안일',		index: 'OKDATE',          name: 'OKDATE',          width: 100,  align: 'center'},
            //{label: '상태',			index: 'APPROVAL_STATUS', name: 'APPROVAL_STATUS', width: 50,  align: 'center', formatter:'select', editoptions:{value:{'E':'승인완료','D':'반려','W':'승인대기'}}},
            {label: '승인 상태',		index: 'APPROVAL_STATUS', name: 'APPROVAL_STATUS', width: 50,  align: 'center', formatter:formatColor},
            {label: '상태1',			index: 'STATUS', 		  name: 'STATUS', 		   width: 50,  align: 'center',  hidden:true},
            {label: '비고',			index: 'NOTE',            name: 'NOTE',            width: 130, align: 'left'},
            {label: 'BASIS',		index: 'BASIS',        	  name: 'BASIS',           width: 10,  hidden:true},
            {label: 'ADD_CONTENT',	index: 'ADD_CONTENT',     name: 'ADD_CONTENT',     width: 10,  hidden:true},
            {label: 'OK_USER_NO',	index: 'OK_USER_NO',      name: 'OK_USER_NO',      width: 10,  hidden:true},
            {label: 'LEVEL',		index: 'LEVEL',           name: 'LEVEL',           width: 100, align: 'left', hidden:true},
            {label: 'TARGET_ID',	index: 'TARGET_ID',       name: 'TARGET_ID',       width: 100, align: 'left', hidden:true},
            {label: 'AP_NO',		index: 'AP_NO',       	  name: 'AP_NO',  	       width: 100, align: 'left', hidden:true}
        ],
        loadonce: true,
        viewrecords: true, // show the current page, data rang and total records on the toolbar
        width: oGrid.parent().width(),
        height: 555,
        multiselect: true,
        shrinkToFit: true, 
        rownumbers: false,              // 행번호 표시여부
        rownumWidth: 75,                // 행번호 열의 너비    
        rowNum: 25,
        rowList: [25,50,100,500],       
        pager: "#Pages",
        onCellSelect: function(nRowid, icol, cellcontent, e) {
			
        	if(icol != 0){
        		//팝업 호출 전 data clear
            	$("#excepPath tr[name=excepPathAddTr]").remove();
            	$("#reason").val("");
            	
                // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
                var oPostDt = {};
                oPostDt["data_processing_group_idx"] = oGrid.getCell(nRowid, 'IDX');
                var tid = oGrid.getCell(nRowid, 'TARGET_ID');
                $.ajax({
                    type: "POST",
                    url: "${getContextPath}/approval/selectProcessPath",
                    async: true,
                    data: JSON.stringify(oPostDt),
                    contentType: 'application/json; charset=UTF-8',
                    success: function (searchList) {
                        var arr = [];
                        var getPathex = [];
                        if (searchList.length > 0) {
                            $.each(searchList, function (i, s) {

                                arr.push(s);
                                getPathex.push(arr[i].PATH);
                                var reason = arr[0].FLAG
 
                                 
                                $("#excepPath").append(
                                		"<tr name='excepPathAddTr' style='border:none;'>"+
                                			"<th style='padding:0px; background: transparent; text-align: left;'>"+
                                				"경로 : <a style=\"color: blue; cursor: pointer;\" onclick=\"showDetail("+s.FID+", "+s.hash_id+","+s.AP_NO+","+nRowid+");\">"+getPathex[i]+"</a>"+
                                				"<br><br> 미리보기 :  " + 
                                				"<br><br> 검출 내역 :  " + 
                                				"<br><br>============================================================<br>"+
                                			"</th>" +  
                               			"</tr>"
                               	);
                                $("#reason").val(reason);
                            });
                        }
                        return;
                    },
                    error: function (request, status, error) {
                        alert("실패 하였습니다.");
                    }
                });

                var detailName = oGrid.getCell(nRowid, 'FILENAME');
                var serverName = oGrid.getCell(nRowid, 'NAME');  
                var BasisName  = oGrid.getCell(nRowid, 'BASIS');

                $("#BasisName").html(BasisName);
                $("#groupName").html(detailName);
                $("#regisServer").val(serverName);
                $("#insertPathExcepPopup").show();
        	}
        	
        },
        beforeSelectRow: function(nRowid, e) {
        	if (e.target.type !== "checkbox") {
        		return false;
        	}
        }
    });
}

//결재 요청 전 항목 삭제
function delItem() {
	
	var aRowIdx = []; // 삭제할 항목의 idx를 저장하는 배열
	var aRowStatus = []; // 삭제할 항목의 status를 저장하는 배열
	var bProcessChk = false;
    var aSelRows = $("#processGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRows.length; i += 1)
    {
    	aRowIdx.push($("#processGrid").getCell(aSelRows[i], 'IDX'));
        aRowStatus.push($("#processGrid").getCell(aSelRows[i], 'APPROVAL_STATUS'));
        
        var status = $("#processGrid").getCell(aSelRows[i], 'APPROVAL_STATUS');

        // 결재요청이 이루어진 경우 변경불가
        if (!isNull(status)) {
        	bProcessChk = true;
        }
        
    }
    
 	// 이미 결재 요청된 항목 있으면 삭제 불가 알림
    if (bProcessChk) {
        alert("이미 요청된 항목은 삭제할 수 없습니다.");
        return;
    }

    // 체크된 항목 없으면 알림
    if (aRowIdx.length == 0){
    	alert("삭제할 항목을 선택하세요");
    	return;
    }
	
	var delChk = confirm("선택한 항목을 삭제 하시겠습니까?");
	if(delChk) {
		
		// IDX 가져와서 pi_data_proccesing, pi_data_proccesing_group 각각 삭제 
		var oPostDt = {};
		oPostDt["idxList"]  = aRowIdx;
		console.log(JSON.stringify(oPostDt));
		$.ajax({
		    type: "POST",
		    url: "${getContextPath}/approval/deleteItem",
		    async: true,
		    data: JSON.stringify(oPostDt),
		    contentType: 'application/json; charset=UTF-8',
		    success: function (result) {
		
				if (result.resultCode != "0") {
					alert(result.resultMessage + "삭제를 실패 했습니다.");
					return;
				}

		        console.log(result)
		        alert("삭제 처리 되었습니다.");
		
			  var oPostDt = { USER_NO : '${memberInfo.USER_NO}'};
			
			  $("#processGrid").clearGridData();
			  $("#processGrid").setGridParam({
				  url: "${getContextPath}/approval/searchProcessList",
			      postData: $("#processGrid").getGridParam('postData'), 
			      datatype: "json"
			  }).trigger("reloadGrid");
			        return;
		    },
		    error: function (request, status, error) {
		        alert("삭제를 실패 했습니다.");
		    }
		});
	}
}


// 정탐/오탐 리스트 결재 요청 팝업 호출
function reqApproval()
{
	// 상급자 설정
    var boss_user_name = "${teamManager.USER_NAME}"; 
    var boss_jikguk = "${teamManager.JIKGUK}"; 
    var boss_user_no = "${teamManager.USER_NO}";

    $("#ok_user_no").val(boss_user_no);
    $("#ok_user_name").val(boss_user_name + " " + boss_jikguk + "");
	
    var bDeletion = false;
    var userCheck = false;
    var aDeletion = [];
    var aSelRows = $("#processGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRows.length; i += 1)
    {
        aDeletion.push($("#processGrid").getRowData(aSelRows[i]));
        var status = $("#processGrid").getCell(aSelRows[i], 'APPROVAL_STATUS');
        var user_no = $("#processGrid").getCell(aSelRows[i], 'USER_NO');
        var login_user_no = "${memberInfo.USER_NO}";
        
		if(user_no != login_user_no){
			userCheck = true;
		}
        
        // 결재요청이 이루어진 경우 변경불가
        if (!isNull(status)) {
        	bDeletion = true;
        }
    }

    if (bDeletion) {
        alert("이미 처리된 항목이 있습니다.");
        return;
    }

    if(userCheck){
    	alert("다른 사용자에 의해 조치된 파일이 포함되어 있습니다.");
    	return;
    }
    
    if (aDeletion.length == 0) {
        alert("결재요청 항목을 선택하세요.");
        return;
    }

    var oToday = getToday();

    $("#reg_user_name").val("${memberInfo.USER_NAME}");
    $("#regdate").val(oToday.substring(0,4) + "-" + oToday.substring(4,6) + "-" + oToday.substring(6,8));
    $("#ApprovalPopup").show();
    $("#comment").focus();
}

// 정탐/오탐 리스트 결재 요청 내용 저장
function saveApproval()
{
    var aIdxList = [];
    var aExcepScope = [];
    var aSelRow = $("#processGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
        aIdxList.push($("#processGrid").getCell(aSelRow[i], 'IDX'));
        aExcepScope.push($("#processGrid").getCell(aSelRow[i], 'OWNER'));
    }

    var sApprType = $('#btnApprovalSave').val();
    var oDate = new Date();
    var sToday = getFormatDate(oDate).replace(/[^0-9]/g, "");
    var sDocuSeq;

    $.ajax({
        type: "POST",
        url: "${getContextPath}/approval/selectDocuNum",
        async : false,
        data : { "today": sToday },
        datatype: "json",
        success: function (result) {
            sDocuSeq = ""+result.SEQ;
        }
    });
 	
 	// 담당자 미지정시 결재요청 진행 불가
    if($("#ok_user_no").val() == "" || $("#ok_user_no").val() == null || $("#ok_user_no").val() == "undefined") {
    	alert("결재자를 지정하십시오");
    	return false;
    }
	
	if($("#comment").val().trim() == ""){
    	alert("사유를 적어주세요.");
    	return false;
    }
    
    var oPostDt = {};
    oPostDt["ok_user_no"] = $("#ok_user_no").val();
    oPostDt["doc_seq"]    = sDocuSeq;
    oPostDt["idxList"]    = aIdxList;
    oPostDt["apprType"]   = sApprType;
    oPostDt["comment"]    = $("#comment").val();
    oPostDt["today"]      = sToday.substring(2);
    
    var confirmCheck = confirm('해당 내용으로 등록하시겠습니까?');
	 
	if(confirmCheck == true){
	    $.ajax({
	
	        type: "POST",
	        url: "${getContextPath}/approval/registProcessCharge",
	        async : false,
	        data : JSON.stringify(oPostDt),
	        contentType: 'application/json; charset=UTF-8',
	
	        success: function (result) {
	
	            alert("결재 요청을 등록 하였습니다."); 
	            /* approvalSendMail(); */
	            
	            var oPostDt = { USER_NO : '${memberInfo.USER_NO}'};
	
	            $("#processGrid").clearGridData();
	            $("#processGrid").setGridParam({
	                url: "${getContextPath}/approval/searchProcessList",
	                postData: $("#processGrid").getGridParam('postData'), 
	                datatype: "json"
	            }).trigger("reloadGrid");
	
	            $("#deletionRegistPopup").hide();
	            $("input:radio[name=trueFalseChk]").prop("checked",false);
	            $("input:radio[name=processing_flag]").prop("checked",false);
	            $("#selecetProcessPopup").val();
	            $("#comment").val("");
	            $("#ok_user_no").val("");
	            $("#ok_user_name").val("");
	            return;
	        },
	        error: function (request, status, error) {
	            alert("결재 요청에 실패 하였습니다.");
	            console.log("ERROR : ", error);
	
	            $("input:radio[name=trueFalseChk]").prop("checked",false);
	            $("input:radio[name=processing_flag]").prop("checked",false);
	            $("#selecetProcessPopup").val();
	            $("#comment").val("");
	            $("#ok_user_no").val("");
	            $("#ok_user_name").val("");
	            return;
	        }
	    });

	    $("#ApprovalPopup").hide();
	    
	} 

}

function approvalSendMail(){
	
	var aIdxList = [];
	var aSelRow = $("#processGrid").getGridParam('selarrrow');      //체크된 row id들을 배열로 반환

    for (var i = 0; i < aSelRow.length; i += 1)
    {
        aIdxList.push($("#processGrid").getCell(aSelRow[i], 'IDX'));
    }
	
	var oPostDt = {};
    oPostDt["ok_user_no"] = $("#ok_user_no").val();
    oPostDt["idxList"]    = aIdxList;
    oPostDt["comment"]    = $("#comment").val().trim().replace(/\n\r?/g,"\n<br>")
//    oPostDt["comment"]    = $("#comment").val();
	
	$.ajax({
        type: "POST",
        url: "${getContextPath}/mail/approvalSendMail",
        async : false,
        data : JSON.stringify(oPostDt),
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
            if (result.resultCode == 0) {
                alert(result.resultMessage);
            } else if (result.resultCode == -1) {
                alert(result.resultMessage);
            }else{
            	alert(result.resultMessage);
            }
        },
        error: function (request, status, error) {
            alert("결재 요청에 실패 하였습니다.");
            return;
        }
    }); 
	
}


// 담당자 조회
function searchAppUserSelect()
{
    if ($("#userGrid").width() == 0) {

        $("#userGrid").jqGrid({
           url: "${getContextPath}/approval/selectTeamMember",
            datatype: "json",
            mtype: "POST",
            ajaxGridOptions: {
                type  : "POST",
                async : true
            },
            colModel: [
            	{label: 'ID', index: 'USER_NO',   name: 'USER_NO',   width: 180, align: 'center' },
                {label: '팀명',    index: 'OFFICE_NM', name: 'OFFICE_NM', width: 180, align: 'center' },
                {label: '기안자',  index: 'USER_NAME', name: 'USER_NAME', width: 180, align: 'center' },
                {label: '전화번호',    index: 'USER_PHONE',    name: 'USER_PHONE',    width: 180, align: 'center' }
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
            onSelectRow : function(nRowid,celname,value,iRow,iCol) {    
            },
            afterEditCell: function(nRowid, cellname, value, iRow, iCol){
            },
            afterSaveCell : function(nRowid,name,val,iRow,ICol){
            },
            afterSaveRow : function(nRowid,name,val,iRow,ICol){
            },
            ondblClickRow: function(nRowid,iRow,iCol) {

                var sUserNm = $(this).getCell(nRowid, 'USER_NAME'); 
                var sofficeNm = $(this).getCell(nRowid, 'OFFICE_NM'); 
                var sUserNo = $(this).getCell(nRowid, 'USER_NO');
                
                $("#ok_user_no").val(sUserNo);
                $("#ok_user_name").val(sUserNm);
                $("#ok_user_name").val(sUserNm + " " + sofficeNm + "");
                
                $("#searchName").val("");
                $("#searchTeamName").val("");
                
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
            url:"${getContextPath}/approval/selectTeamMember", 
            datatype:"json"
        }).trigger("reloadGrid");
    }
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
console.log(today);

function fn_rescan()
{
	var aGridListIds = $("#processGrid").getDataIDs();         // grid의 id 값을 배열로 가져옴
	var aGroupList = [];
	var bChecked, oRowDt, sGroupId;

	for (var i = 0; i < aGridListIds.length; i++) 
	{
		// checkbox checked 여부 판단
		bChecked = $("input:checkbox[id='jqg_processGrid_"+aGridListIds[i]+"']").is(":checked");
	    if (bChecked) {
	        oRowDt = $("#processGrid").getRowData(aGridListIds[i]);     // 해당 id의 row 데이터를 가져옴
	        sGroupId = oRowDt.IDX;

	        // 결재 상태가 승인 완료인 경우만 처리 가능
	        if (oRowDt.STATUS != "E") {
	            alert("결재가 완료되지 않은 항목이 있습니다.");
	            return;
	        }
	        if (aGroupList.indexOf(sGroupId) < 0) 
	            aGroupList.push(sGroupId);
	    }
	}

    if (aGroupList.length == 0) {
    	alert("재검출 항목을 선택하세요.");
        return;
    }

    $.ajax({
        type: "POST",
        url: "${getContextPath}/approval/selectScanPolicy",
        async : false,
        data : JSON.stringify(oPostDt),
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
        	oScan = result[0];
        },
        error: function (request, status, error) {
            alert("재검색 스캔 조회를 실패 하였습니다.");
            return;
        }
    });

    var oPostDt = {};
    oPostDt["groupList"] = aGroupList;

    $.ajax({
        type: "POST",
        url: "${getContextPath}/approval/selectReScanTarget",
        async : false,
        data : JSON.stringify(oPostDt),
        contentType: 'application/json; charset=UTF-8',
        success: function (result) {
        	oTarget = result;
        },
        error: function (request, status, error) {
            alert("Target 정보 조회를 실패 하였습니다.");
            return;
        }
    });

    var now = new Date();
    var hour = now.getHours(); 
    if (hour.length == 1) { 
    	hour = "0" + hour; 
    	}
   	var minute = now.getMinutes(); if (minute.length == 1) { minute = "0" + minute; }
   	var second = now.getSeconds(); if (second.length == 1) { second = "0" + second; }

   	var nowTime = hour+""+minute+second;
    var scheduleData = {};  // Scan Data Mater Json

    // 레이블 넣기
    // 레이블이 중복되면 리콘에서 에러로 나옴. (Response Code : 409)
    // 레이블명을 바꾸는데 아래처럼 뒤에 날자를 붙이는 방법이 있음.
    // scheduleData.label = oScan.SCHEDULE_LABEL + "-"  + getDateTime();
    
	if (oScan == null) {
		alert("재검출 정책이 설정 되어 있지 않습니다.\n관리자에게 문의 하십시오")
	} else {
		scheduleData.label = oScan.SCHEDULE_LABEL;
		scheduleData.label = oScan.SCHEDULE_LABEL + "_" + today + "_" + "${memberInfo.USER_NO}" + "_" + nowTime
   
    var sTargetId = "";
    var aTarget = [];
    var nRow;
    for (var i = 0; i < oTarget.length; i += 1) {
    	if (sTargetId != oTarget[i].TARGET_ID) {
	    	nRow = aTarget.push({id: oTarget[i].TARGET_ID, locations: []});
	    	sTargetId = oTarget[i].TARGET_ID;
	    }

    	aTarget[nRow - 1].locations.push({id: oTarget[i].LOCATION_ID, subpath: oTarget[i].PATH});
    }

	// target 넣기
    scheduleData.targets = aTarget;

    // profile(Datatype) 넣기
    var profileArr = (oScan.DATATYPE_ID+"").split(",");
    scheduleData.profiles = profileArr;

    // 실행 주기 넣기 - 시작시간
    var startDate = "";
    var thisDateTime = getDateTime(null, "mi", 5);
    startDate = thisDateTime.substring(0,4) + "-"
            + thisDateTime.substring(4,6) + "-" 
            + thisDateTime.substring(6,8) + " " 
            + thisDateTime.substring(8,10) + ":" 
            + thisDateTime.substring(10,12); // + ":" + thisDateTime.substring(12,14); 
    scheduleData.start = startDate;

    // 실행 주기 넣기 - 실행주기
    scheduleData.repeat_days = 0;
    scheduleData.repeat_months = 0;

    // CPUs
    scheduleData.cpu = oScan.SCHEDULE_CPU;

    // Throughput
    scheduleData.throughput = +oScan.SCHEDULE_DATA;

    // memory
    scheduleData.memory = +oScan.SCHEDULE_MEMORY;

    // Pause
    var pause = {};
    pause.start = +oScan.SCHEDULE_PAUSE_FROM; 
    pause.end   = +oScan.SCHEDULE_PAUSE_TO;
    pause.days  = +oScan.SCHEDULE_PAUSE_DAYS;
    scheduleData.pause = pause;

    // 스캔 로그
    scheduleData.trace = new Boolean(oScan.SCHEDULE_TRACE);

    scheduleData.timezone = "Default";
    scheduleData.capture = false;
    var postData = {scheduleData : JSON.stringify(scheduleData)};

    var message = "재검출을 요청 하시겠습니까?";
    if (confirm(message)) {
        $.ajax({
            type: "POST",
            url: "${getContextPath}/scan/registSchedule",
            async : false,
            data : postData,
            success: function (resultMap) {
                if (resultMap.resultCode == 201) {
                    alert("재검출 요청이 정상 적용 되었습니다.");
                    return;
                }
                if (resultMap.resultCode == 409) {
                    alert("재검출 요청이 실패 되었습니다.\n\n스캔 스케줄명이 중복 되었습니다.");
                    return;
                }
                if (resultMap.resultCode == 422) {
                    alert("재검출 요청이 실패 되었습니다.\n\n스케줄 시작시간을 확인 하십시오.");
                    return;
                }
                alert("재검출 요청이 실패 되었습니다.\n관리자에게 문의 하십시오");
            },
            error: function (request, status, error) {
                alert("Server Error : " + error);
                console.log("ERROR : ", error);
            }
        });
    }
	}
}

function popSearch(){
	
	var postData = {
			searchTeamName : $("#searchTeamName").val(),
			searchName : $("#searchName").val()
		};
	$("#userGrid").setGridParam({
		url:"<%=request.getContextPath()%>/approval/searchTeamMember", 
		postData : postData, 
		datatype:"json" 
		}).trigger("reloadGrid");
}

// 문서 기안일
function setSelectDate() 
{
    $("#fromDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    $("#toDate").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    var oToday = new Date();
    $("#toDate").val(getFormatDate(oToday));

    var oFromDate = new Date(oToday.setDate(oToday.getDate() - 90));
    $("#fromDate").val(getFormatDate(oFromDate));
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

// 검색
function fn_search(obj) 
{
	if($("#fromDate").val() > $("#toDate").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}
	
    // 정탐/오탐 리스트 그리드
    var oPostDt = {};
    oPostDt["status"]   = $("select[name='statusList']").val();
    oPostDt["owner"]    = $("#schOwner").val();
    oPostDt["filename"] = $("#schFilename").val();
    oPostDt["fromDate"] = $("#fromDate").val();
    oPostDt["toDate"]   = $("#toDate").val();
    oPostDt["processingFlag"]   = $("#processingFlag").val();

    $("#processGrid").clearGridData();
    $("#processGrid").setGridParam({
        url: "${getContextPath}/approval/searchProcessList",
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

function downLoadExcel()
{
	resetFomatter = "downloadClick";
	
	$("#processGrid").jqGrid("exportToCsv",{
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
        fileName : "정탐/오탐_리스트_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        event : resetFomatter,
        returnAsString : false
    });
	
	resetFomatter = null;
	$("#processGrid").jqGrid("showCol",["CHK"]);
}

/* 20201214 추가 */
$("#taskWindowClose").click(function(e){
	$("#taskWindow").hide();
});
$("#pathWindowClose").click(function(e){
	$("#pathWindow").hide();
});

function showDetail(fid, id, ap_no, rowid){
	
	$("#pathWindow").hide();
	$("#taskWindow").hide();
	
	var tid = $('#processGrid').getCell(rowid, 'TARGET_ID');
	
	console.log('fid :: ' + fid)
	console.log('id :: ' + id)
	console.log('ap_no :: ' + fid)
	console.log('tid :: ' + tid)
	
	if (fid == "0") {
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
		
		var input_tid = document.createElement('input');
		input_tid.setAttribute('type','hidden');
		input_tid.setAttribute('name','tid');
		input_tid.setAttribute('value',tid);
		
		var input_ap = document.createElement('input');
		input_ap.setAttribute('type','hidden');
		input_ap.setAttribute('name','ap_no');
		input_ap.setAttribute('value',ap_no);
		
		newForm.appendChild(input_id);
		newForm.appendChild(input_tid);
		newForm.appendChild(input_ap);
		document.body.appendChild(newForm);
		newForm.submit();
		
		document.body.removeChild(newForm);
	} else {
		getLowPath(id, tid, ap_no);
	}
}

function getLowPath(id, tid, ap_no){
	
	var pop_url = "${getContextPath}/popup/lowPath";
	var winWidth = 1142;
	var winHeight = 365;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	//var pop = window.open(pop_url,"lowPath",popupOption);
	var pop = window.open(pop_url,id,popupOption);
	/* popList.push(pop);
	sessionUpdate() */;
	
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
	
	var input_tid = document.createElement('input');
	input_tid.setAttribute('type','hidden');
	input_tid.setAttribute('name','tid');
	input_tid.setAttribute('value',tid);
	
	var input_ap = document.createElement('input');
	input_ap.setAttribute('type','hidden');
	input_ap.setAttribute('name','ap_no');
	input_ap.setAttribute('value',ap_no);
	
	newForm.appendChild(input_id);
	newForm.appendChild(input_tid);
	newForm.appendChild(input_ap);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
	
}

var formatColor = function(cellvalue, options, rowObject) {
	var status = cellvalue;
	
	if(resetFomatter == "downloadClick"){
		status = cellvalue;
	}else{
		if(status == "대기"){
			status = '<label style="color:green">'+status+'</label>'
		}else if(status == "반려"){
			status = '<label style="color:red">'+status+'</label>'
		}
	}
	
	
	return status; 
};

var macName = function(cellvalue, options, rowObject) {
	var name = rowObject.NAME;
	var mac_name = rowObject.MAC_NAME;
	var platform = rowObject.PLATFORM;

	if(platform != null){
		if(platform.indexOf("Apple") == -1){
			return name;
		}else {
			return mac_name;
		}
	}else{
		return name;
	}
	
	
	
}
</script>
</body>
</html>