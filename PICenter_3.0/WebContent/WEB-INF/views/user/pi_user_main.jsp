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
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.popup_tbl td input[type="date"]{
		width: 160px !important;
	}
}
</style>
		<!-- 업무타이틀(location)
		<div class="banner">
			<div class="container">
				<h2 class="ir">업무명 및 현재위치</h2>
				<div class="title_area">
					<h3>타겟 관리</h3>
					<p class="location">사용자 관리 > 사용자 관리</p>
				</div>
			</div>
		</div>
		<!-- 업무타이틀(location)-->

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container">
			<h3>사용자 관리</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<div class="grid_top">
						<!-- user info -->
						<table class="user_info narrowTable" style="width: 625px; display: inline-block;">
		                    <caption>사용자정보</caption>
		                    <tbody>
		                        <tr>
		                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px; border-radius: 0.25rem;">권한</th>
		                            <td style="padding: 5px 5px 0 5px;">
		                            	<select id="sch_aut" name="sch_aut" style="width:186px; font-size: 12px; padding-left: 5px;">
		                                	<option value="" selected>전체</option>
		                                    <option value="0" >일반사용자</option>
		                                    <option value="1" >구성원</option>
		                                    <option value="2" >중간관리자(검색)</option>
		                                    <option value="3" >중간관리자(조회)</option>
		                                    <option value="4" >인프라담당자</option>
		                                    <option value="5" >서비스담당자</option>
		                                    <option value="6" >서비스관리자</option>
		                                    <option value="7" >직책자</option>
		                                    <option value="9" >보안관리자</option>
										</select>
		                            </td>
		                            
		                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">사용자 ID</th>
		                            <td style="padding: 5px 5px 0 5px;">
		                                <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_id" placeholder="사용자ID를 입력하세요.">
		                            </td>
		                           	<td rowspan="3">
		                           		<input type="button" name="button" class="btn_look_approval" id="sch_search">
		                           	</td>
		                        </tr>
		                        <tr>
		                        	<th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">사용자명</th>
		                            <td style="padding: 5px 5px 0 5px;;">
		                            	<input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_userName" placeholder="사용자명을 입력하세요.">
		                            </td>
		                            <th style="text-align: center; width: 100px; padding: 5px 5px 0 5px;">팀명</th>
		                            <td style="padding: 5px 5px 0 5px;">
		                            	<input type="text" style="width: 186px; padding-left: 5px;" size="20" id="sch_teamName" placeholder="팀명을 입력하세요.">
		                            </td>
		                        </tr>
		                        <tr>
		                        	<th style="text-align: center; width: 100px; border-radius: 0.25rem;">재직여부</th>
		                            <td>
		                            	<select id="sch_userLeave" name="sch_userLeave" style="width:186px; font-size: 12px; padding-left: 5px;">
		                                	<option value="" selected>전체</option>
		                                    <option value="0" >재직자</option>
		                                    <option value="1" >퇴직자</option>
										</select>
		                            	<!-- <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_userLeave" placeholder="퇴사자명을 입력하세요."> -->
		                            </td>
		                            <th style="text-align: center; width: 100px; border-radius: 0.25rem;">잠김상태</th>
		                            <td>
		                            	<select id="sch_lockStatus" name="sch_lockStatus" style="width:186px; font-size: 12px; padding-left: 5px;">
		                                	<option value="" selected>전체</option>
		                                    <option value="2" >신청</option>
		                                    <option value="1" >미신청</option>
										</select>
		                            	<!-- <input type="text" style="width: 186px; padding-left: 5px;" size="10" id="sch_userLeave" placeholder="퇴사자명을 입력하세요."> -->
		                            </td>
		                        </tr>
		                    </tbody>
	                	</table>
						<table class="user_info" style="width: 45% !important;  height: 106px; float: right;">
							<caption>사용자정보</caption>
							<tbody>
								<tr style="height: 52px;">
									<td rowspan="3" class="ta_c">
									<p class="user_name" style="width: 120px;">
											${memberInfo.USER_NAME}
												<c:if test="${memberInfo.SOSOK != null}">
													<em>(${memberInfo.SOSOK})</em>
												</c:if>
										</p>
									</td>
									<th>사용자 번호</th>
									<td>${memberInfo.USER_NO}</td>
									<th style="padding: 5px 5px 0 5px;">비밀번호
										<button class="margin_reset btn_down" type="button" id="btnChangePwd" style="margin-left: 3px; margin-bottom: 3px; width: 115px; font-size: 12px;">비밀번호변경</button>
									</th>
									<td><input type="password" id="passwd" value="${memberInfo.USER_NO}" class="edt_read" style="width: 100px;" disabled></td>
								</tr>
								<tr style="height: 52px;">
									<th>접근가능IP
									<c:if test="${memberInfo.USER_GRADE == '9'}">
										<button class="margin_reset btn_down"  type="button" id="btnAccessIPChange" style="margin-left: 3px; margin-bottom: 3px; width: 115px; font-size: 12px;">접근정보변경</button>
									</c:if>									
									</th>
									<td id="accessIPtd" colspan="3" style="padding-bottom: 11px;">
									<c:choose>
									<c:when test="${memberInfo.USER_GRADE == '9'}">${accessIP}</c:when>
								    <c:otherwise>*.*.*.*</c:otherwise>
									</c:choose>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- list -->
						<div class="grid_top" style="margin-top: 10px;">
							<table style="width: 100%;">
								<caption>검출 리스트</caption>
								<colgroup>
									<col width="*"/>
									<col width="500px"/>
								</colgroup>
								<tr>
									<td><h3 style="padding: 0;">사용자 현황</h3></td>
									<%-- <td style="text-align: right; padding: 0px;">
									<c:if test="${memberInfo.USER_GRADE == '9'}">
										<!-- <button class="btn_new" type="button" id="btnDateTime" style="padding: 0 10px; margin: 0px;">계정기간 설정</button> -->
										<button class="btn_down" type="button" id="btnTeamCreate" style="padding: 0 10px; margin: 0px;"> 팀 추가 </button>
										<!-- <button class="btn_new" type="button" id="btnManagerRegist" style="padding: 0 10px; margin: 0px;"> 결재자 등록 </button> -->
										<button class="btn_down" type="button" id="btnAccountCreate" style="padding: 0 10px; margin: 0px;"> 사용자 등록 </button>
									</c:if>
									</td> --%>
								</tr>
							</table>

							<div class="left_box2" style="overflow: hidden; max-height: 555px; height: 555px;">
			   					<table id="userGrid"></table>
			   					<div id="userGridPager"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->
	<%@ include file="../../include/footer.jsp"%>

<!-- 팝업창 - 비밀번호 시작 -->
<div id="passwordChangePopup" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCanclePasswordChangePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">비밀번호 변경</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 155px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>현재비밀번호</th>
							<td><input style="width: 238px;" type="password" id="oldPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경비밀번호</th>
							<td><input style="width: 238px;" type="password" id="newPasswd" value="" class="edt_sch"></td>
						</tr>
						<tr>
							<th>변경비밀번호확인</th>
							<td><input style="width: 238px;" type="password" id="newPasswd2" value="" class="edt_sch"></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnPasswordChangeSave">저장</button>
				<button type="button" id="btnPasswordChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 비밀번호 종료 -->


<c:if test="${memberInfo.USER_GRADE == '9'}">
<!-- 팝업창 - 팀 추가 시작 -->
<div id="teamPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">팀 추가</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 130px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>팀 코드</th>
							<td><input type="text" id="teamCode" value="" class="edt_sch" style="width: 220px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>팀 이름</th>
							<td><input type="text" id="teamName" value="" class="edt_sch" style="width: 220px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnTeamCreateSave">저장</button>
				<button type="button" id="btnTeamCreateCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 팀 추가 종료 -->


<!-- 팝업창 - 사용자 정보 수정 팝업 시작 -->
<div id="userDatePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; top: 55%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleUserDatePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">사용자 정보 수정</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" id="div_update_user" style="height: 365px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						 <tr>
							<th>사용자 ID</th>
							<td>
								<input type="text" id="dateUserID" style="width: 224px; text-align: left; border: none;" readonly="readonly" value="" >
								<input type="hidden" id="dateUserGrade" style="padding-left:10px; text-align: left;" value="" >
							</td>
						</tr>
						<tr>
							<th>사용자명</th>
							<td><input type="text" id="dateUserNM" style="width: 224px; padding-left:10px; text-align: left;" value="" >
							</td>
						</tr>
						<tr>
							<th>전화번호변경</th>
							<td colspan="2">	
								<input type="text" id="changePhoneNM" style="width: 224px; padding-left:10px; text-align: left;" value="" >
								<p style="font-size: 11px; display: inline; position: absolute; bottom: 50px; right: 15px;" id="smsTime">03:00</p>
								<input type="hidden" id="changePhoneStatus" style="padding-left:10px; text-align: left;" value="" >
								<button id="resetPwd" style="color: #555;">비밀번호 초기화</button>
							</td>
						</tr>
						<tr>
							<th>
								<input type="checkbox" id="lock_email">
								이메일변경금지
							</th>
							<td><input type="text" id="changeEmail" style="width: 224px; padding-left:10px; text-align: left;" value="" >
							</td>
						</tr>
						<tr id="userDatePopupIP">
                            <th>접근가능IP</th>
                            <td>
                                <input type="text" id="popupChangeAccessIP" style="width: 224px; padding-left:10px; text-align: left;" value="" >
                            </td>
                        </tr>
						<tr>
							<th>계정시작일</th>
							<td><input type="date" id="accountfromDate" style="text-align: center; width: 168px;" readonly="readonly" value="${fromDate}" style="width : 196px;">
							</td>
						</tr>
						<tr>
							<th>계정만료일</th>
							<td><input type="date" id="accounttoDate" style="text-align: center; width: 168px;" readonly="readonly" value="${toDate}" >
							</td>
						</tr> 
						<tr id="tr_lock_account">
							<th>계정 잠김 해제</th>
							<td><button type="button" id="btn_unlock_account">잠김 해제</button>
							</td>
						</tr> 
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnUserDateDelete">계정삭제</button>
				<button type="button" id="btnUserDateSave">저장</button>
				<button type="button" id="btnUserDateCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 계정 사용일 팝업 종료 -->

<!-- 팝업창 - 접근가능IP 시작 -->
<div id="accessIPPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleAccessIPPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">접근가능 IP 등록</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 180px; background: #fff; border: 1px solid #c8ced3; padding: 0 0 0 10px;">
				<!-- <h2>세부사항</h2>  -->
				<textarea id="accessIP" class="edt_sch" style="width: 100%; height: 100%; border: none; resize: none;"></textarea>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnAccessIPChangeSave">저장</button>
				<button type="button" id="btnAccessIPChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
</c:if>
<!-- 팝업창 - 접근가능IP 종료 -->

<!-- 팝업창 - 계정생성 시작 -->
<div id="accountCreatePopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 522px; width: 400px; left:55%; top:50%; padding: 10px; background: #f9f9f9;">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">사용자 등록</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 507px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="30%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>사용자번호</th>
							<td><input type="text" id="userNo" value="" class="edt_sch" style="width: 196px; margin-top:7px; background: #f5f1ee; font-weight: bold; padding-left: 10px;">
								<button type="button" id="btnChkDuplicateUserNo" data-valid="N" data-UserNo="">중복확인</button>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" id="password" value="" class="edt_sch" style="width: 196px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>비밀번호확인</th>
							<td><input type="password" id="password2" value="" class="edt_sch" style="width: 196px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>사용자명</th>
							<td><input type="text" id="userName" value="" class="edt_sch" style="width: 196px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" id="userPhone" value="" class="edt_sch" style="width: 196px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" id="userEmail" value="" class="edt_sch" style="width: 196px; background: #f5f1ee; font-weight: bold; padding-left: 10px;"></td>
						</tr>
						<tr>
							<th>직급</th>
							<td>
								<select id="jikweeSelect" name="jikweeSelect">
				   					<option value="" selected>선택</option>
				   					<!-- <option value="L0">계장</option>
				   					<option value="L1">과장</option>
				   					<option value="L2">차장</option>
				   					<option value="L3">팀장</option>
				   					<option value="L4">단장</option>
				   					<option value="L5">부장</option>
				   					<option value="L6">반장</option>
				   					<option value="L7">기획역</option>
				   					<option value="L8">계장보</option>
				   					<option value="L9">과장보</option>
				   					<option value="L10">과장대리</option> -->
				   					<!-- <option value="L0">유닛</option>
				   					<option value="L1">선임</option>
				   					<option value="L2">수석</option>
				   					<option value="L3">행원</option>
				   					<option value="L4">대리</option>
				   					<option value="L5">과장</option>
				   					<option value="L6">차장</option>
				   					<option value="L7">부부장</option>
				   					<option value="L8">팀장</option>
				   					<option value="L9">부장</option>
				   					<option value="L10">상무</option>
				   					<option value="L11">기타</option> -->
				   					<option value="L0">4급사원</option>
				   					<option value="L1">5급사원</option>
				   					<option value="L2">PT</option>
				   					<option value="L3">대리</option>
				   					<option value="L4">차장</option>
				   					<option value="L5">과장</option>
				   					<option value="L7">부장</option>
				   					<option value="L8">팀장</option>
				   					<option value="L10">상무</option>
				   					<!-- <option value="L11">기타</option> -->
								</select>
							</td>
						</tr>
						<tr>
							<th>팀명</th>
							<td>
								<select id="teamSelect" name="teamSelect">
									 <option value="" id="teamList" selected>선택</option>
									<%--<c:forEach items="${teamMap}" var="teamMap">
				   					<option value="${teamMap.INSA_CODE}">${teamMap.TEAM_NAME}</option>
									</c:forEach> --%>
								</select>	
							</td>
						</tr>
						 <tr>
							<th>계정시작일</th>
							<td><input type="date" id="fromDate" style="text-align: center; width: 196px;" readonly="readonly" value="${fromDate}" >
							</td>
						</tr>
						<tr>
							<th>계정만료일</th>
							<td><input type="date" id="toDate" style="text-align: center; width: 196px;" readonly="readonly" value="${toDate}" >
							</td>
						</tr> 
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnAccountSave">저장</button>
				<button type="button" id="btnAccountCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 계정생성 종료 -->
<div id="memberLockPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 333px; width: 485px; left: 52%; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleMemberLockPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">사용자 잠김 해제</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 248px; background: #fff; border: 1px solid #c8ced3;">
				<table class="popup_tbl">
					<colgroup>
						<col width="25%">
						<col width="*">
					</colgroup>
					<tbody>
						<tr>
							<th>사용자 ID</th>
							<td><p id="lockMemberNo">  </p></td>
						</tr>
						<tr>
						<th>사용자명</th>
							<td><p id="lockMemberNm">  </p></td>
						</tr>
						<tr>
							<th>마지막 로그인</th>
							<td><p id="lockMemberLoginDt">  </p></td>
						</tr>
						<tr style="height: 90px;">
							<th>사유</th>
							<td>
								<p id="unlock_reason"></p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnMemberLock">해제</button>
				<button type="button" id="btnAccountPopClose">취소</button>
			</div>
		</div>
	</div>
</div>


<!-- <div id="taskGroupWindow" class="ui-widget-content" style="position:absolute; left: 10px; top: 10px; touch-action: none; width: 150px; z-index: 999; 
	border-top: 2px solid #2f353a; box-shadow: 0 2px 5px #ddd; display:none">
	<ul>
		<li class="status" id="btnMemberLock" style="display: none">
			<button >잠금 해제</button></li>
		<li class="status" id="btnAccountPopClose" >
			<button >닫기</button></li>
	</ul>
</div> -->

<script type="text/javascript">

console.log("${memberInfo}");

var USER_PHONE = null;
var USER_NAME = null;

$(document).ready(function () {
	
	$(document).click(function(e){
		//$("#taskGroupWindow").hide();
		$("#taskGroupWindow").hide();
	});	

	$(document).on("keyup", "#changePhoneNM", function() { 
		$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); 
	});
	
	$("#jikweeSelect").select2({
		width: 196
	});
	$("#teamSelect").select2({
		width: 196
	});
	// 계정 시작일, 만료일 추가
	$("#fromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		minDate : 0,
		dateFormat: 'yy-mm-dd'
	});
	$("#toDate").datepicker({
		changeYear : true,
		changeMonth : true,
		dateFormat: 'yy-mm-dd'
	});
	
	// 계정 시작일, 만료일 추가
	$("#accountfromDate").datepicker({
		changeYear : true,
		changeMonth : true,
		minDate : -2,
		dateFormat: 'yy-mm-dd'
	});
	$("#accounttoDate").datepicker({
		changeYear : true,
		changeMonth : true,
		minDate : -1,
		dateFormat: 'yy-mm-dd'
	});
	
	/* $("#jikweeSelect").selectmenu({
		width: 280
	});

	$("#teamSelect").selectmenu({
		width: 280
	}); */
	
	$("#btnAccountCreate").on("click", function(e) {
		
    	$("#btnChkDuplicateUserNo").data("valid", "N");
    	$("#btnChkDuplicateUserNo").data("UserNo", "");

		$("#userNo").val("");
		$("#password").val("");
		$("#password2").val("");
		$("#jikweeSelect").val("");
		$("#teamSelect").val("");
		$("#userName").val("");
		
		$.ajax({
			type: "POST",
			url: "/user/selectMemberTeam",
			async : false,
			//data : postData,
		    success: function (resultMap) {
		    	
		    	var TeamList = "";
		    	/* TeamList = '<option value="" selected>선택</option>'; */
		    	
		    	$.each(resultMap, function(key, value){
		    		TeamList += '<option value="'+ value.INSA_CODE  +'">'+value.TEAM_NAME+'</option>';
				});
		    	
		    /* 	for(var i=0 ; i < resultMap.length ; i++ ){
		    		 TeamList += '<option value="'+ resultMap[i].INSA_CODE  +'">'+resultMap[i].TEAM_NAME+'</option>';
		    	} */
		    	
			    $("#teamList").after(TeamList);
		    },
		    error: function (request, status, error) {
				alert("사용자 확인 실패 : " + error);
		        console.log("사용자 확인 실패 : ", error);
		    }
		});
		
		$("#accountCreatePopup").show();
	});

	$("#btnAccountCancel").on("click", function(e) {
		$("#accountCreatePopup").hide();
	});
	
	$("#btnAccountPopClose").on("click", function(e) {
		$("#memberLockPopup").hide();
	});
	
	$("#btnCancleMemberLockPopup").on("click", function(e) {
		$("#memberLockPopup").hide();
	});

	$("#btnChkDuplicateUserNo").on("click", function(e) {

		var userNo 		= $("#userNo").val().trim();
		if (isNull(userNo)) {
			$("#userNo").focus();
			alert("사용자번호를 입력하십시요.");
			return;
		}

		var postData = {
			userNo : userNo
		};
		$.ajax({
			type: "POST",
			url: "/user/chkDuplicateUserNo",
			async : false,
			data : postData,
		    success: function (resultMap) {
			    console.log(resultMap);
		        if (resultMap.resultCode != 0) {
			        alert("사용자 확인 실패 : " + resultMap.resultMessage);
		        	return;
			    }
		        if (resultMap.UserMap.EXISTUSERCNT == "0") {
		        	$("#btnChkDuplicateUserNo").data("valid", "Y");
		        	$("#btnChkDuplicateUserNo").data("UserNo", userNo);

		        	alert("사용할 수 있는 사용자번호 입니다.");
				}
		        else {
		        	$("#btnChkDuplicateUserNo").data("valid", "N");
		        	alert("사용할 수 없는 사용자번호 입니다.");
				}
		    },
		    error: function (request, status, error) {
				alert("사용자 확인 실패 : " + error);
		        console.log("사용자 확인 실패 : ", error);
		    }
		});
	});

	$("#btnAccountSave").on("click", function(e) {
	
		var userNo 		= $("#userNo").val().trim();
		var password 	= $("#password").val().trim();
		var password2 	= $("#password2").val().trim();
		var jikwee	 	= $("#jikweeSelect").val().trim();
		var team	 	= $("#teamSelect").val().trim();
		var userName	= $("#userName").val().trim();
		var jikguk		= $("#jikweeSelect option:selected").text().trim();
		var userPhone 	= $("#userPhone").val().trim();
		var userEmail 	= $("#userEmail").val().trim();

		if (isNull(userNo)) {
			$("#userNo").focus();
			alert("사용자번호를 입력하십시요.");
			return;
		}

		if (isNull(password)) {
			$("#password").focus();
			alert("비밀번호를 입력하십시요");
			return;
		}

		if (isNull(password2)) {
			$("#password2").focus();
			alert("비밀번호확인을 입력하십시요");
			return;
		}
		
		if (password != password2) {
			$("#password2").focus();
			alert("비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return;
		}

		if (!passwordRules.test(password)) {
			$("#password").focus();
			alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요. : " + password);
			return;
		}
		
		if (isNull(userName)) {
			$("#userName").focus();
			alert("사용자명을 입력하십시요");
			return;
		}
		
		if (isNull(userPhone)) {
			$("#userPhone").focus();
			alert("전화번호를 입력하십시요.");
			return;
		}
		
		if (!phoneRules.test(userPhone)) {
			$("#userPhone").focus();
			alert("올바른 전화번호를 입력하십시오.");
			return;
		}
		
		if (isNull(userEmail)) {
			$("#userEmail").focus();
			alert("이메일을 입력하십시요.");
			return;
		}
		
		if (!emailRules.test(userEmail)) {
			$("#userEmail").focus();
			alert("올바른 이메일 형식으로 입력하십시오.");
			return;
		}
		
		if (isNull(jikwee)) {
			$("#jikweeSelect").focus();
			alert("직급을 선택하십시요.");
			return;
		}
		
		if (isNull(team)) {
			$("#teamSelect").focus();
			alert("부서를 선택하십시요.");
			return;
		}
		
		var chkUserNoYN = $("#btnChkDuplicateUserNo").data("valid");
		if (chkUserNoYN != "Y") {
			alert("사용자번호의 중복확인을 하십시요.");
			return;
		}
		
		var confirmUserNo = $("#btnChkDuplicateUserNo").data("UserNo");
		if (userNo != confirmUserNo) {
			alert("변경입력 하신 사용자번호의 중복확인을 하십시요.");
			return;
		}
		
		var startDate = $("#fromDate").val();
		
		var endDate = $("#toDate").val();
		
		if(startDate > endDate ){
			alert("시작일이 만료일보다 큽니다.시작일과 만료일을 다시 확인 하십시오.");
			return;
		}
		
		var postData = {
			userNo 		: userNo,
			password 	: password,
			userName	: userName,
			jikwee	 	: jikwee,
			jikguk		: jikguk,
			team	 	: team,
			startDate   : startDate,
			endDate     : endDate,
			
			userEmail 	: userEmail,
			userPhone 	: userPhone
		};

		$.ajax({
			type: "POST",
			url: "/user/createUser",
			async : false,
			data : postData,
		    success: function (resultMap) {
			    console.log(resultMap);
		        if (resultMap.resultCode != 0) {$("#accountCreatePopup").hide();
			        alert("사용자 생성 실패 : " + resultMap.resultMessage);
		        	return;
			    }
	        	alert("새로운 사용자가 생성되었습니다.");
	        	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
	        	$("#accountCreatePopup").hide();
		    },
		    error: function (request, status, error) {
				alert("사용자 생성 실패 : " + error);
		        console.log("사용자 생성 실패 : ", error);
		    }
		});
		
	});
	
	var gridWidth = $("#userGrid").parent().width();
	var gridHeight = 480;
	$("#userGrid").jqGrid({
		//url: 'data.json',
		datatype: "local",
	   	mtype : "POST",
	   	ajaxGridOptions : {
			type    : "POST",
			async   : true
		},
		<c:choose>
		<c:when test="${memberInfo.USER_GRADE == '9'}">
			colNames:['권한','사용자 ID', '사용자명', '이메일', '전화번호', '직급', '팀명', '등록일자', '계정시작일', '계정만료일', '재직상태','재직여부','관리자', '관리자', '계정잠김', '전화번호 변경 상태', '해제', '계정 잠금 신청', '계정 잠긴 날짜', '마지막 로그인', '계정 해제 사유', '접근가능IP', '이메일 잠금'],
			colModel: [         
				/* { index: 'CHKBOX', 		name: 'CHKBOX',		width: 80,  align: 'center', editable: true, edittype: 'checkbox', 
					editoptions: { value: '1:0' }, formatoptions: { disabled: false }, formatter: createCheckbox, stype: 'select',
					searchoptions: { sopt: ['eq'], value: ':전체;1:선택;0:미선택' } */
				{ index: 'CHKBOX', 		name: 'CHKBOX',		width:200, align: 'center', editable: true, edittype:'select',
						editoption: { value: '1:0' }, formatter: createSelectbox, stype: 'select',
					searchoptions: { sopt: ['eq'], value: ':전체;0:일반 사용자;1:구성원;2:중간관리자(검색);3:중간관리자(조회);4:서비스담당자;5:서비스관리자;6:인프라담당자;' }
				},
		</c:when>
	    <c:otherwise>
			colNames:['사용자 ID', '사용자명', '이메일', '전화번호', '직급', '팀명', '등록일자', '계정시작일', '계정만료일','재직상태','재직여부','관리자', '관리자', '계정잠김', '전화번호 변경 상태', '해제','계정 잠금 신청', '계정 잠긴 날짜', '마지막 로그인', '계정 해제 사유', '접근가능IP', '이메일 잠금'],
			colModel:[ 
	    </c:otherwise>
		</c:choose>
		
			{ index: 'USER_NO', 			name: 'USER_NO', 			width: 120,	align: 'center'},
			{ index: 'USER_NAME',			name: 'USER_NAME',			width: 180, align: 'center'},
			{ index: 'USER_EMAIL',			name: 'USER_EMAIL', 		width: 200, align: 'center'},
			{ index: 'USER_PHONE',			name: 'USER_PHONE', 		width: 200, align: 'center'},
			{ index: 'JIKGUK',				name: 'JIKGUK',				width: 120, align: 'center'},
			{ index: 'TEAM_NAME',			name: 'TEAM_NAME',			width: 200, align: 'center'},
			{ index: 'REGDATE',				name: 'REGDATE', 			width: 200, align: 'center'},
			{ index: 'STARTDATE',			name: 'STARTDATE', 			width: 180, align: 'center'},
			{ index: 'ENDDATE',				name: 'ENDDATE', 			width: 180, align: 'center'},
			{ index: 'ACC_YN',				name: 'ACC_YN', 			width: 200, align: 'center', hidden: true},
			{ index: 'ACC_YN_NM',			name: 'ACC_YN_NM', 			width: 120, align: 'center'},
			{ index: 'USER_GRADE',			name: 'USER_GRADE', 		width: 200, align: 'center', hidden: true},
			{ index: 'OLD_USER_GRADE',		name: 'OLD_USER_GRADE', 	width: 200, align: 'center', hidden: true},
			{ index: 'LOCK_ACCOUNT',		name: 'LOCK_ACCOUNT', 		width: 200, align: 'center', hidden: true},
			{ index: 'USER_PHONE_STATUS',	name: 'USER_PHONE_STATUS', 	width: 200, align: 'center', hidden: true},
			{ index: 'MEMBER_STATUS',		name: 'MEMBER_STATUS', 		width: 100, align: 'center', formatter:createView, exportcol : false},
			{ index: 'LOCK_STATUS',			name: 'LOCK_STATUS', 		width: 200, align: 'center', hidden: true},
			{ index: 'LOGINDATE',			name: 'LOGINDATE', 			width: 200, align: 'center', hidden: true},
			{ index: 'LOGINDATE2',			name: 'LOGINDATE2', 		width: 200, align: 'center', hidden: true},
			{ index: 'UNLOCK_REASON',		name: 'UNLOCK_REASON', 		width: 200, align: 'center', hidden: true},
            { index: 'ACCESS_IP',           name: 'ACCESS_IP',     		width: 200, align: 'center', hidden: true},
            { index: 'LOCK_EMAIL',        	name: 'LOCK_EMAIL',     	width: 200, align: 'center', hidden: true}
		],
		width: gridWidth,
		height: gridHeight,
		loadonce: true, // this is just for the demo
		viewrecords: true, // show the current page, data rang and total records on the toolbar
	   	autowidth: true,
		shrinkToFit: true,
		rownumbers : false, // 행번호 표시여부
		rownumWidth : 50, // 행번호 열의 너비	
		rowNum:100,
	   	rowList:[10,50,100],
	    search: true,			
		pager: "#userGridPager",
		//jqgrid의 특성상 - rowpos의 이벤트는 onSelectCell, beforeEditCell 다 해주어야 함
	  	onSelectRow : function(rowid,celname,value,iRow,iCol) {	  		
	  	},
	  	afterEditCell: function(rowid, cellname, value, iRow, iCol){
            //I use cellname, but possibly you need to apply it for each checkbox       
			if (cellname == 'USER_GRADE'){
			    $("#userGrid").saveCell(iRow,iCol);
			}
		},
		onCellSelect: function(rowid,icol,cellcontent,e) {
			if (icol == 0) return;
			
			if(icol == 14){
	    		$("#taskGroupWindow").hide();
	    		return;
	    	}
			var USER_NO = $(this).getCell(rowid, 'USER_NO');
			var USER_GRADE = $(this).getCell(rowid, 'USER_GRADE');
			var accountfromDate = $(this).getCell(rowid, 'STARTDATE');
			var accounttoDate = $(this).getCell(rowid, 'ENDDATE');
			var LOCK_ACCOUNT = $(this).getCell(rowid, 'LOCK_ACCOUNT');
			USER_PHONE = $(this).getCell(rowid, 'USER_PHONE');
			USER_NAME = $(this).getCell(rowid, 'USER_NAME');
			var USER_PHONE_STATUS = $(this).getCell(rowid, 'USER_PHONE_STATUS');
			var USER_EMAIL = $(this).getCell(rowid, 'USER_EMAIL');
			var LOCK_STATUS = $(this).getCell(rowid, 'LOCK_STATUS');
			var ACCOUNT_STATS = $(this).getCell(rowid, 'ACCOUNT_STATS');
			var ACCESS_IP = $(this).getCell(rowid, 'ACCESS_IP');
			var LOCK_EMAIL = $(this).getCell(rowid, 'LOCK_EMAIL');
			
			if(LOCK_EMAIL == "Y"){
				$('#lock_email').prop('checked', true);
			}else{
				$('#lock_email').prop('checked', false);
			}
			$("#dateUserID").val(USER_NO);
			$("#dateUserGrade").val(USER_GRADE);
			$("#dateUserNM").val(USER_NAME);
			$("#changePhoneNM").val(USER_PHONE);
			$("#changePhoneStatus").val(USER_PHONE_STATUS);
			$("#accounttoDate").val(accounttoDate);
			$("#accountfromDate").val(accountfromDate);
			$("#changeEmail").val(USER_EMAIL);
			$("#popupChangeAccessIP").val(ACCESS_IP);
			$("#userDatePopup").show();
			
			if(LOCK_ACCOUNT == 'Y'){
				$("#div_update_user").attr("style", "height: 310px; background: #fff; border: 1px solid #c8ced3;");
				$("#btn_unlock_account").attr('data-no', USER_NO);
				$("#tr_lock_account").show();
			} else {
				$("#div_update_user").attr("style", "height: 325px; background: #fff; border: 1px solid #c8ced3;");
				$("#tr_lock_account").hide();
			}
			
			if(USER_GRADE != 9){
				$("#userDatePopupIP").css('display', 'none');
			}else{
				$("#userDatePopupIP").css('display', '');
			}
			
		}, 
		loadComplete: function(data) {
			$(".gridSubSelBtn").on("click", function(e) {
				
		  		e.stopPropagation();
				
				$("#userGrid").setSelection(event.target.parentElement.parentElement.id);
		/* 		
				var row = $("#userGrid").getGridParam("selrow");
				var user_no = $("#userGrid").getCell(row, "USER_NO");
				var lock_status = $("#userGrid").getCell(row, "LOCK_STATUS");

				$(".manage-schedule").css("display", "block");

				var offset = $(this).parent().offset();
				$("#taskGroupWindow").css("left", (offset.left - $("#taskGroupWindow").width()) + 17 + "px");
				// $("#taskWindow").css("left", (offset.left - $("#taskWindow").width() + $(this).parent().width()) + "px");
				$("#taskGroupWindow").css("top", offset.top + $(this).height() + "px");

				var bottomLimit = $(".left_box2").offset().top + $(".left_box2").height();
				var taskBottom = Number($("#taskGroupWindow").css("top").replace("px","")) + $("#taskGroupWindow").height();

				if (taskBottom > bottomLimit) { 
					$("#taskGroupWindow").css("top", Number($("#taskGroupWindow").css("top").replace("px","")) - (taskBottom - bottomLimit) + "px");
				}
				
				if(lock_status != 0){
					$("#btnMemberLock").show();
				}else{
					$("#btnMemberLock").hide();
				}
				$("#taskGroupWindow").show(); */

				var row = $("#userGrid").getGridParam("selrow");
				var user_no = $("#userGrid").getCell(row, "USER_NO");
				var user_name = $("#userGrid").getCell(row, "USER_NAME");
				var unlock_reason = $("#userGrid").getCell(row, "UNLOCK_REASON");
				var loginDate2 = $("#userGrid").getCell(row, "LOGINDATE2");
				
				$("#lockMemberNo").html(user_no);
				$("#lockMemberNm").html(user_name);
				$("#unlock_reason").html(unlock_reason);
				$("#lockMemberLoginDt").html(loginDate2);
				
				$("#memberLockPopup").show();
				
				
			});
	    },
	    gridComplete : function() {
	    }
	}).filterToolbar({
		  autosearch: true,
		  stringResult: true,
		  searchOnEnter: true,
		  defaultSearch: "cn"
	});
	<%-- 
	var postData = {
		userNo : $("#userNo").val(),
		userName : $("#userName").val(),
		fromDate : $("#date1").val(),
		toDate : $("#date2").val() 
	};
	$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid"); --%>

	$("#btnChangePwd").on("click", function(e) {
		$("#oldPasswd").val("");
		$("#newPasswd").val("");
		$("#newPasswd2").val("");
		
		$("#passwordChangePopup").show();
	});

	$("#btnPasswordChangeSave").on("click", function(e) {
		var oldPassword = $("#oldPasswd").val();
		var newPasswd = $("#newPasswd").val();
		var newPasswd2 =  $("#newPasswd2").val();

		if (oldPassword == "") {
			$("#oldPasswd").focus();
			alert("현재 비밀번호를 입력하십시요");
			return;
		}
		
		if (newPasswd == "") {
			$("#newPasswd").focus();
			alert("변경 비밀번호를 입력하십시요");
			return;
		}
		
		if (newPasswd2 == "") {
			$("#newPasswd2").focus();
			alert("변경 비밀번호확인을 입력하십시요");
			return;
		}
		
		if (oldPassword == newPasswd) {
			$("#newPasswd").focus();
			alert("현재 비밀번호와 변경 비밀번호를 다르게 입력하십시요.");
			return;
		}
		
		if (newPasswd != newPasswd2) {
			$("#newPasswd").focus();
			alert("변경 비밀번호와 비밀번호확인이 일치하지 않습니다.");
			return;
		}
		
		if (!passwordRules.test(newPasswd)) {
			$("#newPasswd").focus();
			alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요.");
			return;
		}

		var postData = {oldPassword : oldPassword, newPasswd : newPasswd};		
		$.ajax({
			type: "POST",
			url: "/changeAuthCharacter",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        alert("비밀번호 변경실패 : " + resultMap.resultMessage);
		        	return;
			    }
				alert("비밀번호가 변경되었습니다.");
		      	$("#passwordChangePopup").hide();
		    },
		    error: function (request, status, error) {
				alert("비밀번호 변경실패 : " + error);
		        console.log("비밀번호 변경실패 : ", error);
		    }
		});
	});
	
	$("#btnPasswordChangeCancel").on("click", function(e) {
		$("#passwordChangePopup").hide();
	});
	
	$("#btnCanclePasswordChangePopup").on("click", function(e) {
		$("#passwordChangePopup").hide();
	});
<c:if test="${memberInfo.USER_GRADE == '9'}">
	// 팀 추가
	$("#btnTeamCreate").click(function() {
		$("#teamName").val("");
		$("#teamCode").val("");
		
		$("#teamPopup").show();
	});
	
	$("#btnTeamCreateSave").click(function() {
		var teamName = $("#teamName").val();
		var teamCode = $("#teamCode").val();
		if(teamCode == ""){
			alert("팀코드를 입력해주세요");
			$("#teamCode").focus();
			return;
		}
		
		if(teamName == ""){
			alert("팀명을 입력해주세요");
			$("#teamName").focus();
			return;
		}
		
		var message = "입력한 팀명,팀코드를 추가사히겠습니까?\n팀명 : " + teamName + "\n팀 코드 : " + teamCode;
		
		var postData = {
				teamName : teamName,
				teamCode : teamCode
		};
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/user/createTeam",
				async : false,
				data : postData,
			    success: function (resultMap) {				    
					$("#teamPopup").hide();
			        alert("팀이 추가 되었습니다.");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
		
	});
	
	$("#btnTeamCreateCancel").click(function() {
		$("#teamPopup").hide();
	});

	// 관리자 등록
	$("#btnManagerRegist").click(function() {

		// 선택된 사용자 저장
		var idx = 0;		
		var userList = [];
		var userData = $("#userGrid").jqGrid('getGridParam', 'data');

		for (var i = 0; i < userData.length; i++) {
			var chk = userData[i].USER_GRADE;
			var chkold = userData[i].OLD_USER_GRADE;
			// 담당자로 선택되거나 해제 확인
			if (chk != chkold) {
				var userAssign = {};
				userAssign.userNo 		= userData[i].USER_NO;
				userAssign.userGrade	= userData[i].USER_GRADE;
				userList[idx++] = userAssign;	
			}
		}

		if (isNull(userList)) {
			alert("변경된 정보가 없습니다.");
			return;
		}
		var postData = {
				userList : JSON.stringify(userList)
		};

		var message = "선택한 사용자를 담당자로 지정하시겠습니까?";
		if (confirm(message)) {
			$.ajax({
				type: "POST",
				url: "/user/changeManagerList",
				async : false,
				data : postData,
			    success: function (resultMap) {
			        if (resultMap.resultCode != 0) {
				        alert("FAIL : " + resultMap.resultMessage);
			        	console.log(resultMap);
			        	return;
				    }
				    // chk와 chkold 바까 줌.				    
					var userData = $("#userGrid").jqGrid('getGridParam', 'data');
			
					for (var i = 0; i < userData.length; i++) {
						$("#userGrid").jqGrid('setCell', userData[i]._id_, 'OLD_USER_GRADE', userData[i].USER_GRADE);
					}
					
			        alert("관리자가 지정되었습니다.");
			    },
			    error: function (request, status, error) {
					alert("Server Error : " + error);
			        console.log("ERROR : ", error);
			    }
			});
		}
    });

	//접근 허용IP 관련 - textarea에 넣어주기
	$("#accessIP").val(("${accessIP}").replace(/ /gi, "").replace(/,/gi, "\n"));
	 
	$("#btnAccessIPChange").on("click", function(e) {
		// accessIPPopup
		$("#accessIPPopup").show();
	});

	$("#btnAccessIPChangeCancel").on("click", function(e) {
		$("#accessIP").val("");
		$("#accessIP").val(("${accessIP}").replace(/ /gi, "").replace(/,/gi, "\n"));
		$("#accessIPPopup").hide();
	});
	
	$("#btnCancleAccessIPPopup").on("click", function(e) {
		$("#accessIP").val("");
		$("#accessIP").val(("${accessIP}").replace(/ /gi, "").replace(/,/gi, "\n"));
		$("#accessIPPopup").hide();
	});

	$("#btnAccessIPChangeSave").on("click", function(e) {

		var accessIP = $("#accessIP").val();
		if(!isNull(accessIP)) accessIP = accessIP.split("\n");

		//IP 정합성 확인
		var accessIPs = new Array();
		var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
		for (var i = 0; i < accessIP.length; i++) {
			if (isNull(accessIP[i])) continue;
			
			if (!expUrl.test(accessIP[i])) {
				alert((i + 1) + "번째 IP 주소가 오류입니다.");
				return;
			}
			accessIPs.push(accessIP[i]);
		}
		
		var postData = {accessIP : accessIPs.join(", ")};
		$.ajax({
			type: "POST",
			url: "/user/changeAccessIP",
			async : false,
			data : postData,
		    success: function (resultMap) {
		        if (resultMap.resultCode != 0) {
			        alert("접근가능 IP 변경실패 : " + resultMap.resultMessage);
		        	return;
			    }
		        $("#accessIPtd").html(accessIPs.join(", "));
				$("#accessIP").val(accessIPs.join("\n"));


				alert("접근가능 IP가 변경되었습니다.");
		      	$("#accessIPPopup").hide();
		    },
		    error: function (request, status, error) {
				alert("접근가능 IP 변경실패 : " + error);
		        console.log("접근가능 IP 변경실패 : ", error);
		    }
		});
	});
	
	</c:if>
});

/* $("#sch_aut").change(function(e){
    $("#userGrid").clearGridData();
    $("#sch_id").val("");
	$("#sch_userName").val("");
	$("#sch_teamName").val("");
	if($(this).val() != 'all'){
		fnc_search();
	} 
});
$("#sch_userLeave").change(function(e){
    $("#userGrid").clearGridData();
    $("#sch_id").val();
	$("#sch_userName").val();
	$("#sch_teamName").val();
	if($(this).val() != 'all'){
		fnc_search();
	} 
}); */

$("#sch_id").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});

$("#sch_userName").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});

$("#sch_teamName").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
});
/* $("#sch_userLeave").keyup(function(e){
    if (e.keyCode == 13) {
    	fnc_search();
    }
}); */
$('#sch_search').on('click', function(){
	fnc_search();
});

function fnc_search(){
	var postData = {
		sch_aut: $("select[name='sch_aut']").val(),
		sch_id: $('#sch_id').val(),
		sch_userName: $('#sch_userName').val(),
		sch_teamName: $('#sch_teamName').val(),
		sch_userLeave: $("select[name='sch_userLeave']").val(),
		sch_lockStatus: $("select[name='sch_lockStatus']").val()
	}
	
	console.log(postData);
	
	$("#taskGroupWindow").hide();
	$("#userGrid").setGridParam({url:"/search/getUserList", postData : postData, datatype:"json" }).trigger("reloadGrid");
}

<c:if test="${memberInfo.USER_GRADE == '9'}">
function createCheckbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['USER_GRADE'] == "1")
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )' checked>"; 
	else 
		return "<input type='checkbox' id='" + checkboxID + "' value='" + rowID + "' onchange='onGridChkboxChange( event )'>";
}

function createSelectbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	var result = "<select id='"+checkboxID+"' name='"+checkboxID+"' onchange='changeGrade()' style=\"text-align-last: center\">'";
	if (rowObject['USER_GRADE'] == "0"){
		result += "<option value='0' selected=true>일반 사용자</option>";
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "1"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' selected=true>구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "2"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' selected=true>중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "3"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' selected=true>중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "4"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' selected=true>인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "5"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' selected=true>서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "6"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' selected=true>서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "7"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' selected=true>직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	else if(rowObject['USER_GRADE'] == "9"){ 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' selected=true>보안관리자</option>"; 
	}
	else { 
		result += "<option value='0' >일반 사용자</option>"; 
		result += "<option value='1' >구성원</option>"; 
		result += "<option value='2' >중간관리자(검색)</option>"; 
		result += "<option value='3' >중간관리자(조회)</option>"; 
		result += "<option value='4' >인프라담당자</option>"; 
		result += "<option value='5' >서비스담당자</option>"; 
		result += "<option value='6' >서비스관리자</option>"; 
		result += "<option value='7' >직책자</option>"; 
		result += "<option value='9' >보안관리자</option>"; 
	}
	result += "</select>";
	return result;
}

function onGridChkboxChange(e) {
	var e = e || window.event;
	var target = e.target || e.srcElement;

	if (target.checked) {
		$("#userGrid").jqGrid('setCell', target.value, 'USER_GRADE', "1");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "1");
	}
	else { 
		$("#userGrid").jqGrid('setCell', target.value, 'USER_GRADE', "0");
		$("#userGrid").jqGrid('setCell', target.value, 'CHKBOX', "0");
	}
}
</c:if>
var isRunning = false;
//비밀번호 초기화
$("#resetPwd").click(function(){
		
	var changePhoneNM	= $("#changePhoneNM").val().trim();
	var trimmedPhoneNumber = changePhoneNM.replace(/-/g, '');
	
	if($("#changePhoneNM").val() == ""){
		alert("전화번호를 입력하십시오.");
		return;
	};
	var postData = {
		user_no : $("#dateUserID").val(),
		user_name : $("#dateUserNM").val(),
		user_phone : trimmedPhoneNumber
	};
	$.ajax({
		type: "POST",
		url: "/user/managerResetPwd",
		async : false,
		data : postData,
	    success: function (resultMap) {
	    	
	    	if(resultMap.resultCode == 0){
	    		alert("입력된 전화번호로 초기화 비밀번호가 전송되었습니다.");	 
	    	}else if(resultMap.resultCode == -10){
	    		alert(resultMap.resultMessage);
	    		return;
	    	}else{
				alert("문자를 전송할수 없습니다.\관리자에게 문의하십시오.");
				return;
	    	}
			
			var display = $('#smsTime');
        	var leftSec = 180;
        	startTimer(leftSec, display);
        	
        	$('#resetPwd').attr("disabled","disabled");
        	$('#resetPwd').css("background", "#D9D9D9");
        	$('#resetPwd').css("color", "#a6a6a6");
        	$('#resetPwd').css("cursor", "default");
        	
        	$("#sms_code").val("");
	    },
	    error: function (request, status, error) {
			alert("ERROR : " + error);
	    }
	});
});

function startTimer(count, display) {
    
	var minutes, seconds;
    timer = setInterval(function () {
	    minutes = parseInt(count / 60, 10);
	    seconds = parseInt(count % 60, 10);
	
	    minutes = minutes < 10 ? "0" + minutes : minutes;
	    seconds = seconds < 10 ? "0" + seconds : seconds;
	
	    display.html(minutes + ":" + seconds);
	
	    // 타이머 끝
	    if (--count < 0) {
	     clearInterval(timer);
	     $('#resetPwd').removeAttr("disabled");
	     $('#resetPwd').css("background", "#f9f9f9");
	     $('#resetPwd').css("color", "#555");
	     $('#resetPwd').css("cursor", "pointer");
	     $('#smsTime').html("03:00");
	    // $("#authSMSPopup").hide();
	     //display.html("시간초과");
	     
   		}
	}, 1000);
}



$("#btnUserDateSave").on("click", function(e) {

	var userNo 			= $("#dateUserID").val().trim();
	var userGrade		= $("#dateUserGrade").val().trim();
	var userNm			= $("#dateUserNM").val().trim();
	// var userPwd			= $("#changePasswd").val().trim();
	var changeEmail		= $("#changeEmail").val().trim();
	var accountToDate 	= $("#accounttoDate").val().trim();
	var accountFormDate	= $("#accountfromDate").val().trim();
	var changePhoneNM	= $("#changePhoneNM").val().trim();
	var changePhoneStatus	= $("#changePhoneStatus").val().trim();
	var popupChangeAccessIP = $("#popupChangeAccessIP").val().trim();
	
	var popupChangeAccessIPList = popupChangeAccessIP.split(", ");
	
	var trimmedPhoneNumber = changePhoneNM.replace(/-/g, '');
	//IP 정합성 확인
	var expUrl = /^(1|2)?\d?\d([.](1|2)?\d?\d){3}$/;
	
	if(accountFormDate == "") {
		alert("시작일이 지정되어 있지 않습니다.")
		return;
	}
	if(accountToDate == "") {
		alert("만료일이 지정되어 있지 않습니다.")
		return;
	}
	
	if(USER_NAME != userNm){
		if (!nameRules.test(userNm)) {
			$("#dateUserNM").focus();
			alert("이름은 한글,영어,숫자만 가능합니다.");
			return;
		}
	};
	
	if(USER_PHONE != changePhoneNM){
		if(changePhoneStatus != ""){
			if(changePhoneStatus == "1"){
				alert("전화번호는 한 번만 변경 가능합니다.");
				return;
			}
		}
	}
	
	if (!emailRules.test(changeEmail)) {
		$("#changeEmail").focus();
		alert("이메일 형식으로 입력해 주세요.");
		return;
	}
	
	if(accountToDate < accountFormDate) {
		alert("시작일이 만료일보다 큽니다. 시작일과 만료일을 다시 확인해 주세요.")
		return;
	}
	/* if(userPwd != ""){
		if (!passwordRules.test(userPwd)) {
			$("#password").focus();
			alert("비밀번호는 숫자/영문자/특수문자를 1개 이상, 8자 이상입력하십시요. : " + userPwd);
			return;
		}
	} */
	
	
	for (var i = 0; i < popupChangeAccessIPList.length; i++) {
		if(userGrade == 9){
			if (!expUrl.test(popupChangeAccessIPList[i])) {
				alert("입력하신 값은 IP형식이 아닙니다.");
				return;
			}
		}
	}
	
	
	var postData = {
		userNo : userNo,
		userNm : userNm,
		changePhoneNM : trimmedPhoneNumber,
		accountToDate : accountToDate,
		changeEmail : changeEmail,
		accountFormDate : accountFormDate,
		popupChangeAccessIP : popupChangeAccessIP,
		lock_email : $("#lock_email").is(":checked") ? "Y" : "N"
	}
	
	 $.ajax({
		type: "POST",
		url: "/user/changeUserData",
		async : false,
		data : postData,
	    success: function (resultMap) {
	       
			alert("사용자 정보가 변경되었습니다.");
			$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
			$("#changePhoneStatus").val("");
			$("#changePhoneNM").val("");
			$("#changeEmail").val("");
			$("#popupChangeAccessIP").val("");
			$("#userDatePopup").hide();
	    },
	    error: function (request, status, error) {
	    	$("#changePasswd").val("");
	    	$("#userDatePopup").hide();
			alert("사용자 정보 수정 실패 : " + error);
	    }
	}); 
	
});

$("#btnUserDateCancel").click(function() {
	/* $("#changePasswd").val(""); */
	$("#changePhoneNM").val("");
	$("#changePhoneStatus").val("");
	$("#changeEmail").val("");
	$("#userDatePopup").hide();
});

$("#btnCancleUserDatePopup").click(function() {
	/* $("#changePasswd").val(""); */
	$("#changePhoneNM").val("");
	$("#changePhoneStatus").val("");
	$("#changeEmail").val("");
	$("#userDatePopup").hide();
});

$("#btnUserDateDelete").click(function() {
	var userNo 			= $("#dateUserID").val().trim();
	
	var postData = {
			userNo : userNo
	}
	if(confirm("삭제 하시겠습니까?")){
	 	$.ajax({
			type: "POST",
			url: "/user/userDelete",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	if(resultMap.resultCode == 0){
					alert("사용자 계정을 삭제 하였습니다.");
		      	} else {
		      		alert("사용자 계정 삭제 실패하였습니다.");
		        }
				$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
				$("#changePasswd").val("");
				$("#userDatePopup").hide();
		    },
		    error: function (request, status, error) {
		    	$("#changePasswd").val("");
		    	$("#userDatePopup").hide();
		    	alert("사용자 계정 삭제 실패하였습니다.");
		    }
		}); 
	}
	
	
	$("#changePasswd").val("");
	$("#userDatePopup").hide();
});

$('#btn_unlock_account').on('click', function(){
	
	var userNo = $(this).data('no');
	var postData = {
			userNo : userNo
	}
	if(confirm(userNo + "계정의 잠금을 해제 하시겠습니까?")){
	 	$.ajax({
			type: "POST",
			url: "/user/unlockAccount",
			async : false,
			data : postData,
		    success: function (resultMap) {
		    	if(resultMap.resultCode == 0){
					alert("사용자 계정을 잠금 해제 하였습니다.");
		      	} else {
		      		alert("사용자 계정 잠금 해제에 실패하였습니다.");
		        }
				$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
				$("#userDatePopup").hide();
		    },
		    error: function (request, status, error) {
		    	$("#userDatePopup").hide();
		    	alert("사용자 계정 해제 실패하였습니다.");
		    }
		}); 
	}
});

function changeGrade(){
	var id = $(event.target).attr("id");
	var rowid = id.substring(7);
	var grade = $(event.target).val();
	var userno = $('#userGrid').getCell(rowid, 'USER_NO');
	var usernm = $('#userGrid').getCell(rowid, 'USER_NAME');
	var usergrade = $('#userGrid').getCell(rowid, 'USER_GRADE');
	
	var userList = [];
	var userAssign = {};
	userAssign.userNo 		= userno;
	userAssign.userNm 		= usernm;
	userAssign.userGrade	= grade;
	userList.push(userAssign);	

	var postData = {
			userList : JSON.stringify(userList)
	};

	// option select 변경
   	//$("#userGrid").jqGrid('setCell',rowid,'CHKBOX',grade);
	
	$.ajax({
		type: "POST",
		url: "/user/changeManagerList",
		async : false,
		data : postData,
	    success: function (resultMap) {
        	console.log(resultMap);
	        if (resultMap.resultCode != 0) {
		        alert("FAIL : " + resultMap.resultMessage);
		        $("#userGrid").trigger("reloadGrid");
	        	return;
		    }
	        if (resultMap.resultCode == 0) {
	        	//$(event.target).val(usergrade).prop("selected", true);
	        	$("#userGrid").jqGrid('setCell',rowid,'USER_GRADE',grade);
	        	//$("#userGrid").jqGrid('setCell',rowid,'OLD_USER_GRADE',grade);
	        }
	    },
	    error: function (request, status, error) {
			alert("Server Error : " + error);
			$("#userGrid").trigger("reloadGrid");
	        console.log("ERROR : ", error);
	    }
	});
	
}

var createView = function(cellvalue, options, rowObject) {

	var lock_status = rowObject.LOCK_STATUS;
	
	if(lock_status == 2 ){
			return "<button type='button' class='gridSubSelBtn' name='gridSubSelBtn'>선택</button>"; 
	}else{
		return  "";
	}
};

$("#btnMemberLock").click(function(){
	
	$("#taskGroupWindow").hide();
	var row = $("#userGrid").getGridParam("selrow");
	var user_no = $("#userGrid").getCell(row, "USER_NO");
	var user_name = $("#userGrid").getCell(row, "USER_NAME");
	var user_phone = $("#userGrid").getCell(row, "USER_PHONE");
	
	var delChk = confirm("'"+user_no + "' 사용자 잠금 해제 하시겠습니까?");
	
	var postData = {
			user_no : user_no,
			user_name : user_name,
			lock_staus : 0,
			user_phone : user_phone
		};
	
	if(delChk){
		$.ajax({
			type: "POST",
			url: "/unlockMemberRequest",
			async : false,
			data : postData,
		    success: function (resultMap) {
				if(resultMap.resultCode == 0){
					alert("'" + user_no + "'" +resultMap.resultMessage);
					$("#memberLockPopup").hide();
					$("#userGrid").setGridParam({url:"<%=request.getContextPath()%>/user/selectManagerList", postData : postData, datatype:"json" }).trigger("reloadGrid");
				}else if(resultMap.resultCode == -10){
					alert(resultMap.resultMessage);
					return;
				}else{
					alert("사용자 잠금 해제 실패 ");
				}
		    },
		    error: function (request, status, error) {
				alert("사용자 잠금 해제 실패 : " + error);
		        console.log("사용자 잠금 해제 실패 : ", error);
		    }
		});
	}
	
});
$("#btnAccountPopClose").click(function(){
	$("#taskGroupWindow").hide();
});

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

</script>
	
</body>
</html>