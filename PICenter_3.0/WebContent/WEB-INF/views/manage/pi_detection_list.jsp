<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="nowDate" class="java.util.Date" />
<%@ include file="../../include/header.jsp"%>
<style>
	.DeletionRegistT tr td{
		height: 20px;
		color: #9E9E9E;
		padding: 0 0 0 2px;
	}
	input {
		height: 27px;
	}
	#addProcessing *{
		margin-top: 4px;
	}
	#title_process_true span, #title_process_false span{
		font-size: 12px;
		color: #9E9E9E;
		padding-left: 5px;
	}
	.true_processing_comment span, .false_processing_comment span{
		font-size: 12px;
		color: #9E9E9E;
	}
	.true_processing_hint, .false_processing_hint{
		display: inline-block;
		position: relative;
		top: 2px;
	}
	.ui-jqgrid tr.ui-row-ltr td{
		cursor: pointer;
	}
	#approvalStatusNm{
		text-decoration: underline;
	}
	#approvalStatusNm:hover{
		font-weight: bold;
		cursor: pointer;
	}
	#path_detail_true::placeholder, #path_detail_false::placeholder{
		color: #9E9E9E;
	}
	#userHelpImg{
		background-size: auto;
	}
    @media screen and (-ms-high-contrast: active) , ( -ms-high-contrast : none) {
		/* .host_comment{
			position: absolute !important;
			top: 92px !important;
			left: auto !important;
		} */
		.path_comment_div{
			position: relative;
			display: inline-block;
			bottom: 12px !important;
		}
		.path_comment{
			top: 0 !important;
		}
	}
</style>
<!-- 검출관리 -->

<!-- section -->
<section>
    <!-- container -->
    <div class="container">
        <!-- content -->
        <h3 class="detection_list_title" style="display: inline; top: 25px;">결과조회/조치계획</h3>
        <p class="detection_list_txt" style="position: absolute; top: 33px; left: 222px; font-size: 12px; color: #9E9E9E;">
       		개인정보 검출 결과를 확인 하실수 있습니다. 대상을 선택 후 검출 내역을 확인하여 정탐,오탐을 선택 하시기 바랍니다.
       	</p>
        
        <div class="content magin_t35">
            <div class="grid_top" style="padding-left: 335px;">
                <table class="user_info" id="sch_detail" style="display: inline-table; width: 700px;">
                    <caption>검색 결과 조회</caption>
                    <tbody>
                        <tr>
                            <th style="text-align: center; width:100px; border-radius: 0.25rem;">상세조회</th>
                            <td>
                                <input type="text" id="searchLocation" value="" class="edt_sch" style="width: 300px; height: 26.5px; padding-left:5px;" placeholder="대상을 지정 후 경로 또는 파일명을 입력하세요.">
                                <input type="hidden" id="hostSelect" value="">
                            	<input type="hidden" id="ap_no" value="">
                            	<input type="hidden" id="onedriveChk" value="">
                            </td>
                            <th class="sch_flag grade_hidden" style="text-align: center; width:100px; border-radius: 0.25rem;">처리상태</th>
                            <td class="sch_flag grade_hidden">
                            	<select id="sch_processingFlag" name="sch_processingFlag" style="width: 186px; font-size: 12px; padding-left: 5px;">
                            		<option value="" selected>전체</option>
                                    <option value="0" >처리</option>
                                    <option value="1" >미처리</option>
                            	</select>
                            </td>
                           	<td>
                           		<input type="button" name="button" class="btn_route" id="btnSearch">
                           	</td>
                        </tr>
                    </tbody>
                </table>
                <div class="path_comment_div" style="display: inline-block;">
					<p class="path_comment" style="position: relative; bottom: 7px; left: 5px; font-size: 12px; color: #9E9E9E;">경로에 검색할 경로 입력 시 해당 경로를 포함하여 개인정보 검출 이력을 확인 하실수 있습니다.</p>
                </div>
                <div class="list_sch">
                    <div class="sch_area" id="sch_area" style="margin-top: 7px;">
         	            <label class="answerLabel DeletionRegistBtn"><input type="radio" class="answerRadio" name="trueFalseChk" id="btnReasonTrue" value="" class="edt_sch" style="position:relative; border: 0px solid #cdcdcd; cursor: pointer; height:20px; margin-right:20px;"></label>
                        <label class="wrongLabel DeletionRegistBtn"><input type="radio" class="wrongRadio" name="trueFalseChk" id="btnReasonFalse" value="" class="edt_sch" style="position:relative; border: 0px solid #cdcdcd; cursor: pointer; height:20px;"></label>
                        <input type="hidden" id="selectedDate" class="DeletionRegistBtn" value="">
                        <input type="hidden" id="group_id" class="DeletionRegistBtn" value="">
						<button type="button" name="button" class="btn_down" id="btnDownloadExcel" style="margin-top: 6px;">다운로드</button>
						<button type="button" name="button" class="btn_down" id="btnDownloadPCExcel" style="margin-top: 6px; display: none">다운로드</button>
                    </div>
                </div>
            </div>
            <div class="left_area2" style="position: absolute; top: 75px; height: 90%;">
            <table class="user_info narrowTable" style="width: 320px;">
				<tbody>
					<tr>
						<th style="text-align: center; border-radius: 0.25rem;">대상조회</th>
             			     <td>
                				 <input type="text" style="width: 205px; padding-left: 5px;" size="10" id="targetSearch" placeholder="호스트명을 입력하세요.">
                			 </td>
                		<td>
                    		 <input type="button" name="button" class="btn_look_approval" id="btn_sch_target" style="margin-top: 5px;">
                    	</td>
					</tr>
				</tbody>
			</table>
				<div class="left_box2" style="max-height: 680px;">
   					<div id="jstree" class="select_location" style="overflow-y: auto; overflow-x: auto; height: 659px; margin-top: 11px; background: #ffffff; border: 1px solid #c8ced3; white-space:nowrap;">
						
					</div>
				</div>
			</div>
            <div class="grid_top_Server" style="overflow: hidden; margin-left: 335px; height: 660px; max-height: 660px; margin-top: 10px;">
               <table id="targetGrid"></table>
               <div id="targetGridPager"></div>
            </div>
            <div class="grid_top_PC" style="overflow: hidden; display: none; margin-left: 335px; height: 660px; max-height: 660px; margin-top: 10px;">
               <table id="targetPCGrid"></table>
               <div id="targetPCGridPager"></div>
            </div>
        </div>
    </div>
    <!-- container -->
</section>
<!-- section -->

<!-- 팝업창 시작 : 정탐 처리 -->
<div id="trueDeletionRegistPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="width: 1415px; height: 600px; left: 30%; top: 40%; background: #f9f9f9; padding: 10px;">
    <img class="CancleImg" id="btnCancleTrueDeletionRegistPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
        <div class="popup_top" style="background: #f9f9f9;">  
            <h1 id="title_process_true" style="color: #222; box-shadow: none; padding: 0;"></h1>
        </div>
        <div class="popup_content"> 
            <div class="content-box" style="height: 685px; background: #fff; border: 1px solid #c8ced3;">
                <!-- <h2>세부사항</h2>  -->
                <table class="popup_tbl">
                    <colgroup>
                        <col width="130">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th style="text-align: center; border-bottom: 1px solid #cdcdcd;">검출경로</th>
                            <td style="padding:5px; border-bottom: 1px solid #cdcdcd;">
                                <div id="path_exception_div_true" style="width:100%; height:330px; overflow:auto;">
                                <table id="path_exception_true" style="text-align:center; width:100%;">
                                    <tbody>
                                    </tbody>
                                </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<th style="text-align: center; border-bottom: 1px solid #cdcdcd;" rowspan="2">
                        		판단근거
                        	</th>
                            <td style="padding:10px 0;">
                            	<textarea rows="5" id="path_detail_true" style="width: 100%; padding-left: 5px; font-size: 12px; resize: none;" placeholder="개인정보로 판단한 명확한 근거에 대해서 상세하게 작성 하시기 바랍니다."></textarea>
							</td>
                        </tr>
                        <tr>
                            <td style="padding:0 0 10px 0; border-bottom: 1px solid #cdcdcd; color: #9E9E9E;">
                            	<table class="DeletionRegistT">
                            		<tr> <td>예)</td> <td>- 고객센터 콜 처리 시스템으로 고객콜 인입번호 정보로 서비스를 제공함, 10일 보관 후 자동 삭제</td> </tr>
                            		<tr> <td></td><td>- 타시스템 IF 연동 로그로 3년간 보관 필요 (과금, 망쪽 장비와 연동 자료)</td> </tr>
                            		<tr> <td></td><td>- 증빙파일은 증적으로 남기는 내용이기에 삭제 불가능함</td> </tr>
                            		<tr> <td></td><td>- 해지분리된 고객에 대한 계약담당자 파일로 향후 5년간 보관(향후 원복에 필요)</td> </tr>
                            		<tr> <td></td><td>- 사용자 로그 추적 파일로 6개월 보관 필요</td> </tr>
                            		<tr> <td></td><td>- 포탈 내 각 지역별 커뮤니티에서 업무 관련 내용에 관한 첨부파일로 이력 관리 등 목적으로 3년간 보관</td> </tr>
                            	</table>
							</td>
                        </tr>
                        <tr>
                        	<th style="text-align: center;">조치계획</th>
                        	<td style="padding:5px 0;">
	                        	<div class="content-box" style="height: 90px; background: #fff; margin: 0;">
	                        	
									<select name="popup_content" id="trueDeletionAction">
										<option value="1" selected="selected">수동삭제</option>
										<option value="2">자동삭제</option>
										<option value="3">암호화저장</option>
										<option value="4">평문유지</option>
									</select>
									<input type="date" name="processing_flag" id="selectDateTrue" value="" style="text-align: center; margin-right: 10px;" readonly="readonly">
									<div id="addTrueProcessing" style="display: inline-block;"></div>
									<div class="true_processing_comment">
										<span>담당자에 의한 수동삭제 항목입니다. 삭제 예정일자를 선택해 주시기 바랍니다.</span>
									</div>
					            </div>
				            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area" style="padding-right: 0;">
                <button type="button" id="btnTrueDeletionSave">저장</button>
                <button type="button" id="btnTrueDeletionCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 : 오탐 처리 -->
<div id="falseDeletionRegistPopup" class="popup_layer" style="display:none">
    <div class="popup_box" style="width: 1415px; height: 600px; left: 30%; top: 40%; background: #f9f9f9; padding: 10px;">
    <img class="CancleImg" id="btnCancleFalseDeletionRegistPopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
        <div class="popup_top" style="background: #f9f9f9;">  
            <h1 id="title_process_false" style="color: #222; box-shadow: none; padding: 0;"></h1>
        </div>
        <div class="popup_content"> 
            <div class="content-box" style="height: 710px; background: #fff; border: 1px solid #c8ced3;">
                <!-- <h2>세부사항</h2>  -->
                <table class="popup_tbl">
                    <colgroup>
                        <col width="130">
                        <col width="*">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th style="text-align: center; border-bottom: 1px solid #cdcdcd;">검출경로</th>
                            <td style="padding:5px; border-bottom: 1px solid #cdcdcd;">
                                <div id="path_exception_div_false" style="width:100%; height:330px; overflow:auto;">
                                <table id="path_exception_false" style="text-align:center; width:100%;">
                                    <tbody>
                                    </tbody>
                                </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                        	<th style="text-align: center; border-bottom: 1px solid #cdcdcd;" rowspan="2">
                        		판단근거
                        	</th>
                            <td style="padding:10px 0; ">
                            	<textarea rows="5" id="path_detail_false" style="width: 100%; padding-left: 5px; font-size: 12px; resize: none;" placeholder="오탐으로 판단한 명확한 근거에 대해서 상세하게 작성해 주세요."></textarea>
							</td>
                        </tr>
                        <tr>
                            <td style="padding:0 0 10px 0; border-bottom: 1px solid #cdcdcd; color: #9E9E9E;">
                            	<table class="DeletionRegistT">
                            		<tr> <td>예)</td> <td>- 솔루션 색인 파일이며 숫자 나열로 오탐</td> </tr>
                            		<tr> <td></td><td>- 휴대폰번호가 아닌 단말기에 할당되는 별도의 고유번호로 오탐</td> </tr>
                            		<tr> <td></td><td>- 권한ID/개발자ID를 운전면허번호로 오탐</td> </tr>
                            		<tr> <td></td><td>- 개발기 연동 내역으로 실제 고객정보가 아닌 변조 데이터임</td> </tr>
                            		<tr> <td></td><td>- 프로그램 실행로그 날짜데이터 숫자로만 들어가있음</td> </tr>
                            		<tr> <td></td><td>- 솔루션 설치 매뉴얼에 포함된 공인된 메일 주소임(예: support@oralce.com, support@redhat.org)</td> </tr>
                            		<tr> <td></td><td>- 솔루션 및 소스 관련 파일로 미조치 보관</td> </tr>
                            	</table>
							</td>
                        </tr>
                        <tr>
                        	<th style="text-align: center;">조치계획</th>
                        	<td style="padding:5px;">
	                        	<div class="content-box" style="height: 90px; background: #fff; margin: 0;">
	                        	
									<select name="popup_content" id="falseDeletionAction" style="width: 87px;">
										<option value="5" selected="selected">수동삭제</option>
										<option value="6">평문유지</option>
									</select>
									<input type="date" name="processing_flag" id="selectDateFalse" value="" style="text-align: center; margin-right: 10px;" readonly="readonly">
									<div id="addFalseProcessing" style="display: inline-block;"></div>
									<div class="false_processing_comment">
										<span>수동 삭제 완료 예정 일자를 선택해 주세요</span>
									</div>
					            </div>
				            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area" style="padding-right: 0;">
                <button type="button" id="btnFalseDeletionSave">저장</button>
                <button type="button" id="btnFalseDeletionCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->

<!-- 팝업창 시작 정탐-->
<div id="resultTrue" class="popup_layer" style="display:none;">
    <div class="popup_box" style=" width: 350px; margin-left: -180px; height: 340px; top: 60%; padding: 10px; background: #f9f9f9;">
        <div class="popup_top" style="background: #f9f9f9;">
            <h1 style="color: #222; box-shadow: none; padding: 0;">정탐조치</h1>
        </div>
        <div class="popup_content" style="height: 200px;">
            <div class="content-box" style="height: 190px; background: #fff; border: 1px solid #c8ced3;">
                <input type="radio" name="processing_flag" value=1 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;삭제<br/>
                
                <input type="radio" name="processing_flag" value=2 id="processingCheck2" class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;법제도 
                <input type="text"  class="edt_sch" id="legalSystem" style="margin-left: 21px;"><br/>
                
                <input type="radio" name="processing_flag" value=3 id="processingCheck3" class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;삭제 주기 &nbsp;
                <input type="text"  class="edt_sch" id="deleteCycle"><br/>
                             삭제예정일 : <input type="date" id="selectDateTrue" value="${befDate}" style="text-align: center; margin-left: 12px;" readonly="readonly"> 
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area" style="padding-right: 0;">
                <button type="button" id="btnResultTrueSave">확인</button>
                <button type="button" id="btnResultTrueCancel">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 팝업창 종료 -->
	
<!-- 팝업창 시작 오탐-->
<div id="resultFalse" class="popup_layer" style="display:none;">
    <div class="popup_box" style=" width: 350px; margin-left: -180px; height: 340px; top: 60%; padding: 10px; background: #f9f9f9;">
        <div class="popup_top" style="background: #f9f9f9;">
            <h1 style="color: #222; box-shadow: none; padding: 0;">오탐조치</h1>
        </div>
        <div class="popup_content" style="height: 200px;">
            <div class="content-box" style="height: 190px; background: #fff; border: 1px solid #c8ced3;">
                <input type="radio" name="processing_flag" value=4 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;시스템 파일<br/>
                <input type="radio" name="processing_flag" value=5 class="edt_sch" style="border: 0px solid #cdcdcd;">&nbsp;기타<br/>
            </div>
        </div>
        <div class="popup_btn">
            <div class="btn_area" style="padding-right: 0;">
                <button type="button" id="btnResultFalseSave">확인</button>
                <button type="button" id="btnResultFalseCancel">취소</button>
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
									<table style="border: 0px solid #cdcdcd; width: 430px; height: 266px; margin-top: 5px; margin-bottom: 5px; resize: none; " >
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

<%@ include file="../../include/footer.jsp"%>
<script type="text/javascript"> 
$(function() {
	
	var grade = ${memberInfo.USER_GRADE};
	
		$('#jstree').jstree({
			// List of active plugins
			"core" : {
			    "animation" : 0,
			    "check_callback" : true,
				"themes" : { "stripes" : false },
				"data" : ${userGroupList}
			},
			"types" : {
				    "#" : {
				      "max_children" : 1,
				      "max_depth" : 4,
				      "valid_children" : ["root"]
				    },
				    "default" : {
				      "valid_children" : ["default","file"]
				    },
				    "file" : {
				      "icon" : "glyphicon glyphicon-file",
				      "valid_children" : []
				    }
			},
			'search': {
		        'case_insensitive': false,
		        'show_only_matches' : true,
		        "show_only_matches_children" : true
		    },
			'plugins' : ["search"],
		})
	    .bind('select_node.jstree', function(evt, data, x) {
	    	var id = data.node.id;
	    	var type = data.node.data.type;
	    	var ap = data.node.data.ap;
	    	var name = data.node.data.name;
	    	var parents = data.node.parents;
	    	var checkPc = false;
	    	
	    	$(".DeletionRegistBtn").show();
    		$("#targetGrid").clearGridData();
    		$(".grid_top_PC").css("display", "none");
    		$(".grid_top_Server").css("display", "");
    		$("#btnDownloadExcel").css("display", "");
    		$("#btnDownloadPCExcel").css("display", "none");
    		$("#userHelpIcon").css("display", "");
    		$("#userHelpPCIcon").css("display", "none");
    		$(".sch_flag").css("display", "");
    		$("#sch_detail").css("width", "700px");
	    	
	    	if(type == 1){
	    		console.log(ap + ", " + id);

	    		var id = id;
	    		var name =  data.node.text;
	    		var ap_no = ap;
	    		
	    		if(data.node.parent == "onedirve"){
	    			$("#onedriveChk").val(1);
	    		} else {
	    			$("#onedriveChk").val(0);
	    		}
	    		
	    		$("#targetSearch").val(name);
	    		$("#targetSearch").text(name);
	    		$("#hostSelect").val(id);
	    		$("#ap_no").val(ap_no);
	    		
	    		
	    		findByPop();
	    		
	    	}
	    });
});

var resetFomatter = null;
var SEQ = null;
var approval_status = null;

//검출 리스트 하위경로 표시
function createPathbox(cellvalue, options, rowObject) {
	var rowID = options['rowId'];
	var checkboxID = "gridChk" + rowID;
	
	if (rowObject['CHK'] == "1")
		return ' > ';
	else 
		return '';
}
//검출 리스트 그리드 CheckBox 생성
function createCheckbox(cellvalue, options, rowObject) 
{
    var value = rowObject['ID'];
    var str = '';
    var rowId = options['rowId'];

    if (rowObject['LEVEL'] == "0") 
    	return "<input id=\"gridChk_"+rowId+"\" type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + " onchange=\"gridClick(event, "+value+")\" checked>";
    else 
    	return "<input id=\"gridChk_"+rowId+"\" type=\"checkbox\" name=\"gridChk\" value="+ rowObject['ID'] +" data-rowid=" + options['rowId'] + " onchange=\"gridClick(event, "+value+")\">";
}
//경로 명 체크
function checkFileName(cellvalue, options, rowObject) {
	//var rowID = options['rowId'];
	var path = cellvalue;
	
	if(cellvalue.indexOf("_decrypted") == -1){
		return path;
	} else {
		return path.replaceAll("_decrypted","");
	}
}

function createCheckDecrypted(cellvalue, options, rowObject) {
	var rowId = options['rowId'];
	var path = rowObject['SHORTNAME'];
	var html = null;
	
	if(resetFomatter == "downloadClick"){
		
		if(path.indexOf("_decrypted") == -1){
			return "N";
		} else{
			return "Y";
		}
		
	}else {
		if(path.indexOf("_decrypted") == -1){
			html = "<p style='display: none'>체크된 파일은 문서보안으로 암호화 안된 파일입니다. </p>";
			html += "<input id=\"decryptedChk_"+rowId+"\" type=\"checkbox\" name=\"decryptedChk\" onclick=\"return false\" >";
			return html;
		} else {
			html = "<p style='display: none'>체크된 파일은 문서보안으로 암호화 된 파일입니다. </p>";
			html += "<input id=\"decryptedChk_"+rowId+"\" type=\"checkbox\" name=\"decryptedChk\" onclick=\"return false\" checked>";
			return html;
		}
		
	}
	
}

String.prototype.replaceAll = function(org, dest){
	return this.split(org).join(dest);
}


function fnSearchFindSubpath() 
{
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val();
    oPostDt["ap_no"]	 = $("#ap_no").val();
    oPostDt["onedriveChk"]	 = $("#onedriveChk").val();
    oPostDt["name"]  = $("#targetSearch").val();
    oPostDt["text"]  = $("#targetSearch").text();
    oPostDt["processingFlag"]	 = $("select[name='sch_processingFlag']").val();
    
    $('#allChkTargetGrid').prop('checked', false);

    $("#targetGrid").setGridParam({
        url: "${getContextPath}/manage/selectFindSubpath", 
        postData: oPostDt, 
        datatype: "json",
        treedatatype: 'json'
    }).trigger("reloadGrid");
}

function fnSearchFindSubpathPC() 
{
    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val();
    oPostDt["ap_no"]	 = $("#ap_no").val();
    oPostDt["name"]  = $("#targetSearch").val();
    oPostDt["text"]  = $("#targetSearch").text();
    oPostDt["onedriveChk"]	 = $("#onedriveChk").val();
    oPostDt["processingFlag"]	 = $("select[name='sch_processingFlag']").val();
    
    $('#allChkTargetGrid').prop('checked', false);

    $("#targetPCGrid").setGridParam({
        url: "${getContextPath}/manage/selectFindSubpath", 
        postData: oPostDt, 
        datatype: "json",
        treedatatype: 'json'
    }).trigger("reloadGrid");
}

function loadTargetGrid()
{
	var patternCnt = ${patternCnt};
	var colNames = [];
	var colModel = [];

	var pattern = '${pattern}'.split('[{').join('').split('}]').join('');
	pattern = pattern.split('}, {');
	
	/* grid 이름 */
	colNames.push("<input type='checkbox' id='allChkTargetGrid' name='allChkTargetGrid' style='margin:-5px 0 0 4px;' onclick='fn_allChkTargetGrid(this, event)' /> ",
    		"", "","","경 로","처리상태","검출일","기안일","합계");
	for(var i=0; i < patternCnt ; i++){
		var row = pattern[i].split(', ');
		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
		var data_id = PATTERN_NAME.split('=')[1];
		
		colNames.push(ID.split('=')[1]);
	}
	colNames.push('처리상태코드','처리분류코드','처리분류코드명','(하위포함)결재상태','(하위포함)결재분류','LEVEL','ID','PID','ID','소속','성명','HOST','FILENAME','NOTEPAD','IDX','POLICY_ID','ENABLE','POLICY_NM','DATATYPE_ID');

	/* gird 데이터*/
	colModel.push({ index: 'CHK', name: 'CHK', width: 35, align: 'center', editable: true, edittype: 'checkbox', classes: 'pointer', editoptions: { value: "1:0" }, formatoptions: { disabled: false }, sortable: false, formatter: createCheckbox, exportcol:false});
	colModel.push({ index: 'CHK_C',           name: 'CHK_C',          width: 35,  align: 'center', sortable: false, hidden:true});
    colModel.push({ index: 'CHKOLD',          name: 'CHKOLD',          width: 35,  align: 'center', sortable: false, hidden:true});
    colModel.push({ index: 'SUBFILE',       	name: 'SUBFILE',      	width: 20, align: 'left',    sortable: true, formatter: createPathbox, exportcol:false});
    colModel.push({ index: 'SHORTNAME',       name: 'SHORTNAME',      width: 420, align: 'left',   sortable: true, formatter: checkFileName});
    colModel.push({ index: 'OWNER',            name: 'OWNER',           width: 150, align: 'center', sortable: true});
    colModel.push({ index: 'APPROVAL_STATUS_PRINT_NAME',  name: 'APPROVAL_STATUS_PRINT_NAME', width: 140, align: 'center', sortable: true, formatter:approvalNm});
    colModel.push({ index: 'CREATE_DT',       name: 'CREATE_DT',      width: 100,  align: 'center', sortable: true, formatter: createTime});
    colModel.push({ index: 'APPROVAL_DT',     name: 'APPROVAL_DT',    width: 100,  align: 'center', sortable: false, hidden:true});
    
	for(var i = 0; pattern.length > i; i++){ // str 배열만큼 for돌림
		
		var row = pattern[i].split(', ');
		var ID = row[0].split('ID=').join(''); //변수 TABLE_NAME은 TB_NAME1, 다음 반복문에서는 TB_NAME2
		var PATTERN_NAME = row[1].split('PATTERN_NAME=').join(''); // 변수 CHK Y, 다음 반복문에서는 N
		var data_id = PATTERN_NAME.split('=')[1];
		
		colModel.push({index: data_id,           name: data_id,          width: 110,  align: 'center',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'});
	}
	colModel.push({ index: 'APPROVAL_STATUS',             name: 'APPROVAL_STATUS',            width: 1, hidden:true});
    colModel.push({ index: 'PROCESSING_FLAG',             name: 'PROCESSING_FLAG',            width: 1, hidden:true});
    colModel.push({ index: 'PROCESSING_FLAG_NAME',        name: 'PROCESSING_FLAG_NAME',       width: 1, hidden:true});
    colModel.push({ index: 'LINK_APPROVAL_STATUS',        name: 'LINK_APPROVAL_STATUS',       width: 1, hidden:true});
    colModel.push({ index: 'LINK_PROCESSING_FLAG',        name: 'LINK_PROCESSING_FLAG',       width: 1, hidden:true});
    colModel.push({ index: 'ID',              name: 'ID',             width: 1, hidden:true, key:true});
    colModel.push({ index: 'PID',             name: 'PID',            width: 1, hidden:true});
    colModel.push({ index: 'LEVEL',           name: 'LEVEL',          width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'USER_NO',       	name: 'USER_NO',      width: 100, align: 'center', sortable: false, hidden:true});
    colModel.push({ index: 'TEAM',            name: 'TEAM',           width: 100, align: 'center', sortable: false, hidden:true});
    colModel.push({ index: 'USER_NAME',       name: 'USER_NAME',          width: 100, align: 'center', sortable: false, hidden:true});
    colModel.push({ index: 'HOST',     		name: 'HOST',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'FILENAME',     	name: 'FILENAME',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'NOTEPAD',     	name: 'NOTEPAD',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'IDX',     		name: 'IDX',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'POLICY_ID',     	name: 'POLICY_ID',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'ENABLE',     		name: 'ENABLE',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'POLICY_NM',     	name: 'POLICY_NM',    width: 1, align: 'center', hidden:true});
    colModel.push({ index: 'DATATYPE_ID',   	name: 'DATATYPE_ID',    width: 1, align: 'center', hidden:true});	
    
    $("#targetGrid").jqGrid({
        datatype: "local",
        mtype : "POST",
        ajaxGridOptions : {
            type    : "POST",
            async   : true
        },
        colNames : colNames,
        colModel : colModel,
        loadonce : true,
	   	autowidth: true,
        viewrecords: true,
        width: $("#targetGrid").parent().width(),
        height: 585,
        shrinkToFit: false,
        pager: "#targetGridPager",
        rownumbers : false,
        rownumWidth : 75,
        jsonReader : {
            id : "ID"
        },
        rowNum:1000,
		rowList:[1000,2000,2500,5000],
		mutipageSelection: true,
        onCellSelect: function(rowid,icol,cellcontent,e) {
        	$("#pathWindow").hide();
            $("#taskWindow").hide();
            if (icol == 0) return;
            e.stopPropagation();
            var isChk = $(this).getCell(rowid, 'CHK_C');
            var isLeaf = $(this).getCell(rowid, 'LEAF');
            var id = $(this).getCell(rowid, 'ID');
            var tid = $(this).getCell(rowid, 'PID');
            var processing = $(this).getCell(rowid, 'PROCESSING_FLAG');
            var ap_no = $('#ap_no').val();
            
            if (isChk == "0") {
            	if(icol != 6 || processing == '') {
	                var pop_url = "${getContextPath}/popup/detectionDetail";
	            	var winWidth = 1142;
	            	var winHeight = 365;
	            	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=yes, resizable=no, location=no"; 	
	            	var pop = window.open(pop_url,id,popupOption); 
	            	
	            	var newForm = document.createElement('form');
	            	newForm.method='POST';
	            	newForm.action=pop_url;
	            	newForm.name='newForm';
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
            	}
            	else if(icol == 6 && processing != '') {
                	$("#excepPath tr[name=excepPathAddTr]").remove();
                	$("#reason").val("");
                	
                    // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
                    var postDt = {};
                    postDt["data_processing_group_idx"] = $(this).getCell(rowid, 'IDX');
                    $.ajax({
                        type: "POST",
                        url: "${getContextPath}/approval/selectProcessPath",
                        async: true,
                        data: JSON.stringify(postDt),
                        contentType: 'application/json; charset=UTF-8',
                        success: function (searchList) {
                            var arr = [];
                            var getPathex = [];

                            /* if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG

                                    $("#excepPath").append("<tr name='excepPathAddTr' style='border:none;'>" + "<th style='padding:0px; background: transparent; text-align: left;'>" + getPathex[i] + "</th>" + "</tr>");
                                    $("#reason").val(reason);
                                });
                            } */
                            if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG
                                    
                                    $("#excepPath").append(
                                    		"<tr name='excepPathAddTr' style='border:none;'>"+
                                    			"<th style='padding:0px; background: transparent; text-align: left;'>"+
                                    				"<a style=\"color: blue; cursor: pointer;\" onclick=\"showDetail("+s.FID+", "+s.hash_id+","+s.AP_NO+","+rowid+");\">"+getPathex[i]+"</a>"+
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

                    var detailName = $(this).getCell(rowid, 'FILENAME');
                    var serverName = $(this).getCell(rowid, 'HOST');  
                    var BasisName  = $(this).getCell(rowid, 'NOTEPAD');

                    $("#BasisName").html(BasisName);
                    $("#groupName").html(detailName);
                    $("#regisServer").val(serverName);
                    $("#insertPathExcepPopup").show();
            	}
            }
            else {
            	if(icol == 6 && processing != '') {
            		//팝업 호출 전 data clear
                	$("#excepPath tr[name=excepPathAddTr]").remove();
                	$("#reason").val("");
                	
                    // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
                    var postDt = {};
                    postDt["data_processing_group_idx"] = $(this).getCell(rowid, 'IDX');
                    $.ajax({
                        type: "POST",
                        url: "${getContextPath}/approval/selectProcessPath",
                        async: true,
                        data: JSON.stringify(postDt),
                        contentType: 'application/json; charset=UTF-8',
                        success: function (searchList) {
                            var arr = [];
                            var getPathex = [];

                            /* if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG

                                    $("#excepPath").append("<tr name='excepPathAddTr' style='border:none;'>" + "<th style='padding:0px; background: transparent; text-align: left;'>" + getPathex[i] + "</th>" + "</tr>");
                                    $("#reason").val(reason);
                                });
                            } */
                            if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG
                                    
                                    $("#excepPath").append(
                                    		"<tr name='excepPathAddTr' style='border:none;'>"+
                                    			"<th style='padding:0px; background: transparent; text-align: left;'>"+
                                    				"<a style=\"color: blue; cursor: pointer;\" onclick=\"showDetail("+s.FID+", "+s.hash_id+","+s.AP_NO+","+rowid+");\">"+getPathex[i]+"</a>"+
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

                    var detailName = $(this).getCell(rowid, 'FILENAME');
                    var serverName = $(this).getCell(rowid, 'HOST');  
                    var BasisName  = $(this).getCell(rowid, 'NOTEPAD');

                    $("#BasisName").html(BasisName);
                    $("#groupName").html(detailName);
                    $("#regisServer").val(serverName);
                    $("#insertPathExcepPopup").show();
            	}
            	else {
	            	getLowPath(id, tid, ap_no);
            	}
            }
        },
        loadComplete: function(rowid,icol,cellcontent,e) {
        	var ids = $("#targetGrid").getDataIDs();
        	
        	$.each(
       	 		ids,function(idx,rowid)
       	 		{
       	 			rowData = $("#targetGrid").getRowData(rowid);
	       	 		var decrypted = '_decrypted';
	       	 		var shortName = rowData['SHORTNAME'];
       	 		}
       	 	); 
        	
        }
    });
}

function loadTargetPCGrid()
{
 /*    var oPostDt = {};
    oPostDt["target_id"] = $("#hostSelect").val();
    oPostDt["location"]  = $("#searchLocation").val(); */

    $("#targetPCGrid").jqGrid({
        //url: "${getContextPath}/manage/selectFindSubpath",
        //postData : oPostDt,
        datatype: "local",
        mtype : "POST",
        ajaxGridOptions : {
            type    : "POST",
            async   : true
        },
        //colNames:['','','경 로','호스트','소유자','주민번호','외국인번호','여권번호','운전번호','계좌번호','카드번호','합계','처리상태','처리상태코드','처리분류코드','처리분류코드명','(하위포함)결재상태','(하위포함)결재분류','LEVEL','ID','PID'],
        colNames:["<input type='checkbox' id='allChkTargetGrid' name='allChkTargetGrid' style='margin:-5px 0 0 4px;' onclick='fn_allChkTargetGrid(this, event)' /> ",
        		'', '','','경 로','소유주','처리상태','암호화 여부','검출일','기안일','합계','주민번호','외국인번호','여권번호','운전번호','계좌번호','카드번호','이메일','휴대폰번호','처리상태코드','처리분류코드','처리분류코드명','(하위포함)결재상태','(하위포함)결재분류','LEVEL','ID','PID','ID','소속','성명','HOST','FILENAME','NOTEPAD','IDX'
        		,'POLICY_ID','ENABLE','POLICY_NM','DATATYPE_ID','RRN','RRN_CNT','RRN_DUP','FOREIGNER','FOREIGNER_CNT','FOREIGNER_DUP','DRIVER','DRIVER_CNT','DRIVER_DUP','PASSPORT','PASSPORT_CNT','PASSPORT_DUP',
        		'ACCOUNT','ACCOUNT_CNT','ACCOUNT_DUP','CARD','CARD_CNT','CARD_DUP','PHONE','PHONE_CNT','PHONE_DUP','MOBILE_PHONE','MOBILE_PHONE_CNT','MOBILE_PHONE_DUP','LOCAL_PHONE','LOCAL_PHONE_CNT','LOCAL_PHONE_DUP','EMAIL','EMAIL_CNT','EMAIL_DUP','RECENT'],
        		//'','','경 로','호스트','소유자','주민번호','외국인번호','여권번호','운전번호','계좌번호','카드번호','합계','처리상태','처리상태코드','처리분류코드','처리분류코드명','(하위포함)결재상태','(하위포함)결재분류','LEVEL','ID','PID'],
        colModel: [
            //{ index: 'CHK',             name: 'CHK',            width: 35,  align: 'center', sortable: false, formatter: createCheckbox},
            { index: 'CHK',             name: 'CHK',            width: 35,  align: 'center', editable: true, edittype: 'checkbox', classes: 'pointer',
                editoptions: { value: "1:0" }, formatoptions: { disabled: false }, 			 sortable: false, formatter: createCheckbox,  exportcol:false },
            { index: 'CHK_C',           name: 'CHK_C',          width: 35,  align: 'center', sortable: false, hidden:true},
            { index: 'CHKOLD',          name: 'CHKOLD',          width: 35,  align: 'center', sortable: false, hidden:true},
            { index: 'SUBFILE',       	name: 'SUBFILE',      	width: 20, align: 'left',    sortable: true, formatter: createPathbox, exportcol:false},
            { index: 'SHORTNAME',       name: 'SHORTNAME',      width: 415, align: 'left',   sortable: true, formatter: checkFileName},
            { index: 'OWNER',            name: 'OWNER',           width: 150, align: 'center', sortable: true, hidden:true},
            //{ index: 'OWNER',           name: 'OWNER',          width: 170, align: 'center', sortable: false},
            /* { index: 'PROCESSING_FLAG_NAME',  name: 'PROCESSING_FLAG_NAME', width: 100, align: 'left', sortable: false}, */
            { index: 'APPROVAL_STATUS_PRINT_NAME',  name: 'APPROVAL_STATUS_PRINT_NAME', width: 140, align: 'center', sortable: true, formatter:approvalNm, hidden:true},
            { index: 'DECRYPTED',       	name: 'DECRYPTED',  width: 70, align: 'center', formatter: createCheckDecrypted, sortable: false},
            { index: 'CREATE_DT',       name: 'CREATE_DT',      width: 100,  align: 'center', sortable: true, formatter: createTime},
            { index: 'APPROVAL_DT',     name: 'APPROVAL_DT',    width: 100,  align: 'center', sortable: false, hidden:true},
            { index: 'TYPE',            name: 'TYPE',           width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE1',           name: 'TYPE1',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE2',           name: 'TYPE2',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE3',           name: 'TYPE3',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE4',           name: 'TYPE4',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE5',           name: 'TYPE5',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE6',           name: 'TYPE6',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE7',           name: 'TYPE7',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'TYPE8',           name: 'TYPE8',          width: 110,  align: 'right',  formatter:'integer', formatoptions:{thousandsSeparator: ",", defaultValue: '0'}, sortable: true, sorttype: 'number'},
            { index: 'APPROVAL_STATUS',             name: 'APPROVAL_STATUS',            width: 1, hidden:true},
            { index: 'PROCESSING_FLAG',             name: 'PROCESSING_FLAG',            width: 1, hidden:true},
            { index: 'PROCESSING_FLAG_NAME',        name: 'PROCESSING_FLAG_NAME',       width: 1, hidden:true},
            { index: 'LINK_APPROVAL_STATUS',        name: 'LINK_APPROVAL_STATUS',       width: 1, hidden:true},
            { index: 'LINK_PROCESSING_FLAG',        name: 'LINK_PROCESSING_FLAG',       width: 1, hidden:true},
            { index: 'ID',              name: 'ID',             width: 1, hidden:true, key:true},
            { index: 'PID',             name: 'PID',            width: 1, hidden:true},
            { index: 'LEVEL',           name: 'LEVEL',          width: 1, align: 'center', hidden:true},
            { index: 'USER_NO',       	name: 'USER_NO',      width: 100, align: 'center', sortable: false, hidden:true},
            { index: 'TEAM',            name: 'TEAM',           width: 100, align: 'center', sortable: false, hidden:true},
            { index: 'USER_NAME',       name: 'USER_NAME',          width: 100, align: 'center', sortable: false, hidden:true},
            { index: 'HOST',     		name: 'HOST',    width: 1, align: 'center', hidden:true},
            { index: 'FILENAME',     	name: 'FILENAME',    width: 1, align: 'center', hidden:true},
            { index: 'NOTEPAD',     	name: 'NOTEPAD',    width: 1, align: 'center', hidden:true},
            { index: 'IDX',     		name: 'IDX',    width: 1, align: 'center', hidden:true},
            { index: 'POLICY_ID',     	name: 'POLICY_ID',    width: 1, align: 'center', hidden:true},
            { index: 'ENABLE',     		name: 'ENABLE',    width: 1, align: 'center', hidden:true},
            { index: 'POLICY_NM',     	name: 'POLICY_NM',    width: 1, align: 'center', hidden:true},
            { index: 'DATATYPE_ID',   	name: 'DATATYPE_ID',    width: 1, align: 'center', hidden:true},
            { index: 'RRN',     		name: 'RRN',    width: 1, align: 'center', hidden:true},
            { index: 'RRN_CNT',     	name: 'RRN_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'RRN_DUP',     	name: 'RRN_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'FOREIGNER',     	name: 'FOREIGNER',    width: 1, align: 'center', hidden:true},
            { index: 'FOREIGNER_CNT', 	name: 'FOREIGNER_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'FOREIGNER_DUP', 	name: 'FOREIGNER_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'DRIVER',     		name: 'DRIVER',    width: 1, align: 'center', hidden:true},
            { index: 'DRIVER_CNT',    	name: 'DRIVER_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'DRIVER_DUP',    	name: 'DRIVER_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'PASSPORT',     	name: 'PASSPORT',    width: 1, align: 'center', hidden:true},
            { index: 'PASSPORT_CNT',   	name: 'PASSPORT_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'PASSPORT_DUP',   	name: 'PASSPORT_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'ACCOUNT',     	name: 'ACCOUNT',    width: 1, align: 'center', hidden:true},
            { index: 'ACCOUNT_CNT',    	name: 'ACCOUNT_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'ACCOUNT_DUP',    	name: 'ACCOUNT_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'CARD',     		name: 'CARD',    width: 1, align: 'center', hidden:true},
            { index: 'CARD_CNT',     	name: 'CARD_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'CARD_DUP',     	name: 'CARD_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'PHONE',     		name: 'PHONE',    width: 1, align: 'center', hidden:true},
            { index: 'PHONE_CNT',     	name: 'PHONE_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'PHONE_DUP',     	name: 'PHONE_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'MOBILE_PHONE',    name: 'MOBILE_PHONE',    width: 1, align: 'center', hidden:true},
            { index: 'MOBILE_PHONE_CNT',name: 'MOBILE_PHONE_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'MOBILE_PHONE_DUP',name: 'MOBILE_PHONE_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'LOCAL_PHONE',     name: 'LOCAL_PHONE',    width: 1, align: 'center', hidden:true},
            { index: 'LOCAL_PHONE_CNT', name: 'LOCAL_PHONE_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'LOCAL_PHONE_DUP', name: 'LOCAL_PHONE_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'EMAIL',     		name: 'EMAIL',    width: 1, align: 'center', hidden:true},
            { index: 'EMAIL_CNT',     	name: 'EMAIL_CNT',    width: 1, align: 'center', hidden:true},
            { index: 'EMAIL_DUP',     	name: 'EMAIL_DUP',    width: 1, align: 'center', hidden:true},
            { index: 'RECENT',     		name: 'RECENT',    width: 1, align: 'center', hidden:true}
        ],
        loadonce : true,
	   	autowidth: true,
        viewrecords: true,
        width: $("#targetPCGrid").parent().width(),
        height: 585,
        shrinkToFit: false,
        pager: "#targetPCGridPager",
        rownumbers : false,
        rownumWidth : 75,
        jsonReader : {
            id : "ID"
        },
        rowNum:1000,
		rowList:[1000,2000,2500,5000],
		mutipageSelection: true,
        onCellSelect: function(rowid,icol,cellcontent,e) {
        	$("#pathWindow").hide();
            $("#taskWindow").hide();
            if (icol == 0) return;
            e.stopPropagation();
            var isChk = $(this).getCell(rowid, 'CHK_C');
            var isLeaf = $(this).getCell(rowid, 'LEAF');
            var id = $(this).getCell(rowid, 'ID');
            var tid = $(this).getCell(rowid, 'PID');
            var processing = $(this).getCell(rowid, 'PROCESSING_FLAG');
            var ap_no = $('#ap_no').val();
            
            if (isChk == "0") {
            	if(icol != 6 || processing == '') {
	                var pop_url = "${getContextPath}/popup/detectionDetail";
	            	var winWidth = 1142;
	            	var winHeight = 365;
	            	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=yes, resizable=no, location=no"; 	
	            	//var pop = window.open(pop_url,"detail",popupOption);
	            	var pop = window.open(pop_url,id,popupOption); 
	            	/* popList.push(pop);
	            	sessionUpdate(); */
	            	
	            	//var w = window.open("about:blank","_blank");
	            	/* var winWidth = 1142;
	            	var winHeight = 365;
	            	var popupOption= "width="+winWidth+", height="+winHeight + ", scrollbars=no, resizable=no, location=no"; 	
	            	var pop = window.open("about:blank","_blank",popupOption);
	            	pop.location.href = "${getContextPath}/popup/detectionDetail"; */
	            	
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
            	}
            	else if(icol == 6 && processing != '') {
            		//팝업 호출 전 data clear
                	$("#excepPath tr[name=excepPathAddTr]").remove();
                	$("#reason").val("");
                	
                    // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
                    var postDt = {};
                    postDt["data_processing_group_idx"] = $(this).getCell(rowid, 'IDX');
                    $.ajax({
                        type: "POST",
                        url: "${getContextPath}/approval/selectProcessPath",
                        async: true,
                        data: JSON.stringify(postDt),
                        contentType: 'application/json; charset=UTF-8',
                        success: function (searchList) {
                            var arr = [];
                            var getPathex = [];

                            /* if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG

                                    $("#excepPath").append("<tr name='excepPathAddTr' style='border:none;'>" + "<th style='padding:0px; background: transparent; text-align: left;'>" + getPathex[i] + "</th>" + "</tr>");
                                    $("#reason").val(reason);
                                });
                            } */
                            if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG
                                    
                                    $("#excepPath").append(
                                    		"<tr name='excepPathAddTr' style='border:none;'>"+
                                    			"<th style='padding:0px; background: transparent; text-align: left;'>"+
                                    				"<a style=\"color: blue; cursor: pointer;\" onclick=\"showDetail("+s.FID+", "+s.hash_id+","+s.AP_NO+","+rowid+");\">"+getPathex[i]+"</a>"+
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

                    var detailName = $(this).getCell(rowid, 'FILENAME');
                    var serverName = $(this).getCell(rowid, 'HOST');  
                    var BasisName  = $(this).getCell(rowid, 'NOTEPAD');

                    $("#BasisName").html(BasisName);
                    $("#groupName").html(detailName);
                    $("#regisServer").val(serverName);
                    $("#insertPathExcepPopup").show();
            	}
            }
            else {
            	if(icol == 6 && processing != '') {
            		//팝업 호출 전 data clear
                	$("#excepPath tr[name=excepPathAddTr]").remove();
                	$("#reason").val("");
                	
                    // 테이블에서 path_ex_group_name 가져와서 넣어줘야함
                    var postDt = {};
                    postDt["data_processing_group_idx"] = $(this).getCell(rowid, 'IDX');
                    $.ajax({
                        type: "POST",
                        url: "${getContextPath}/approval/selectProcessPath",
                        async: true,
                        data: JSON.stringify(postDt),
                        contentType: 'application/json; charset=UTF-8',
                        success: function (searchList) {
                            var arr = [];
                            var getPathex = [];

                            /* if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG

                                    $("#excepPath").append("<tr name='excepPathAddTr' style='border:none;'>" + "<th style='padding:0px; background: transparent; text-align: left;'>" + getPathex[i] + "</th>" + "</tr>");
                                    $("#reason").val(reason);
                                });
                            } */
                            if (searchList.length > 0) {
                                $.each(searchList, function (i, s) {

                                    arr.push(s);
                                    getPathex.push(arr[i].PATH);
                                    var reason = arr[0].FLAG
                                    
                                    $("#excepPath").append(
                                    		"<tr name='excepPathAddTr' style='border:none;'>"+
                                    			"<th style='padding:0px; background: transparent; text-align: left;'>"+
                                    				"<a style=\"color: blue; cursor: pointer;\" onclick=\"showDetail("+s.FID+", "+s.hash_id+","+s.AP_NO+","+rowid+");\">"+getPathex[i]+"</a>"+
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

                    var detailName = $(this).getCell(rowid, 'FILENAME');
                    var serverName = $(this).getCell(rowid, 'HOST');  
                    var BasisName  = $(this).getCell(rowid, 'NOTEPAD');

                    $("#BasisName").html(BasisName);
                    $("#groupName").html(detailName);
                    $("#regisServer").val(serverName);
                    $("#insertPathExcepPopup").show();
            	}
            	else {
	            	getLowPath(id, tid, ap_no);
            	}
            }
        },
        loadComplete: function(rowid,icol,cellcontent,e) {
        	var ids = $("#targetGrid").getDataIDs();
        	
        	$.each(
       	 		ids,function(idx,rowid)
       	 		{
       	 			rowData = $("#targetGrid").getRowData(rowid);
	       	 		var decrypted = '_decrypted';
	       	 		var shortName = rowData['SHORTNAME'];
	       	 		
	       	 		/* 
	       	 		if(shortName.indexOf(decrypted) != -1){
       	 				$("#targetGrid").setRowData(rowid, false, {display: 'none'}
       	 			);
       	 			} 
	       	 		*/
       	 		}
       	 	); 
        	
        }
    });
}

function downLoadExcel()
{
	resetFomatter = "downloadClick";
	
	$("#targetGrid").jqGrid("hideCol",["CHK"]);
	/* \ / : * ? " < > } */
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
	var hostname = $("#targetSearch").val().split("(");
	
	var nameList = hostname[0].split(":");
	var name = "";
	
	
	for(i=0; i<nameList.length ; i++){
		if(i == nameList.length-1 ){
			name += nameList[i]
		}else{
			name += nameList[i] + "-"
		}		
		
	}

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy + "" + mm + dd;
	console.log(today);
	
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
        fileName : "검출_리스트_"+name+ "_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        event : resetFomatter,
        returnAsString : false
    });
	
	resetFomatter = null;
	$("#targetGrid").jqGrid("showCol",["CHK"]);
} 

function downLoadPCExcel()
{
	resetFomatter = "downloadClick";
	
	$("#targetPCGrid").jqGrid("hideCol",["CHK"]);
	/* \ / : * ? " < > } */
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
	var hostname = $("#targetSearch").val().split("(");
	
	var nameList = hostname[0].split(":");
	var name = "";
	
	
	for(i=0; i<nameList.length ; i++){
		if(i == nameList.length-1 ){
			name += nameList[i]
		}else{
			name += nameList[i] + "-"
		}		
		
	}

	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 

	if(mm<10) {
	    mm='0'+mm
	} 

	today = yyyy + "" + mm + dd;
	console.log(today);
	
	$("#targetPCGrid").jqGrid("exportToCsv",{
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
        fileName : "검출_리스트_"+name+ "_" + today + ".csv",
        mimetype : "text/csv; charset=utf-8",
        event : resetFomatter,
        returnAsString : false
    });
	
	resetFomatter = null;
	$("#targetPCGrid").jqGrid("showCol",["CHK"]);
} 

/* function downLoadExcel()
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
    
} */



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
	var ap = "${apno}";
	var grade = ${memberInfo.USER_GRADE};
	var gradeChk = [0, 1, 2, 3, 7];
	if(gradeChk.indexOf(grade) != -1){
		
		var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 365px; cursor: pointer;" id="userHelpPCIcon">';
		$("#targetGrid").clearGridData();
		$(".grid_top_Server").css("display", "none");
		$(".grid_top_PC").css("display", "");
		$(".detection_list_txt").html("개인정보 검출 결과를 확인 하실수 있습니다.");
		$(".detection_list_txt").css("font-size", "13px;");
		$(".detection_list_txt").after(helpPCIcon);
		
		$(".detection_list_title").html("결과조회")
		$(".detection_list_txt").css("left", "144px");
		$(".answerLabel").css("display", "none");
		$(".wrongLabel").css("display", "none");
		$("#btnDownloadExcel").css("display", "none");
		$("#btnDownloadPCExcel").css("display", "");
		$("#btnDownloadPCExcel").css("margin-top", "10px");
		$(".grade_hidden").css("display", "none");
		$("#sch_detail").css("width", "440px");
		
	}else{
		var helpIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 805px; cursor: pointer;" id="userHelpIcon">';
		var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 805px; cursor: pointer; display: none;" id="userHelpPCIcon">';
		
		$("#targetGrid").clearGridData();
		$(".grid_top_PC").css("display", "none");
		$(".grid_top_Server").css("display", "");
		$(".detection_list_txt").after(helpIcon);
		$(".detection_list_txt").after(helpPCIcon);
	}
	
 	/* if(ap != 0){
		var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 365px; cursor: pointer;" id="userHelpPCIcon">';
		
		$(".grid_top_Server").css("display", "none");
		$(".grid_top_PC").css("display", "");
		$(".detection_list_txt").after(helpPCIcon);
		$("#userHelpIcon").css("display", "none");
		$("#userHelpPCIcon").css("left", "805px");
		
		$(".answerLabel").css("display", "none");
		$(".wrongLabel").css("display", "none");
		$("#btnDownloadExcel").css("display", "none");
		$("#btnDownloadPCExcel").css("display", "");
		$("#btnDownloadPCExcel").css("margin-top", "10px");
		$(".grade_hidden").css("display", "none");
		$("#sch_detail").css("width", "440px");
	}  */
	
	$("#btnSearchHost").click();
	
	//$("#hostSelect").select2();
	$("#btnDownloadExcel").click(function(){
		downLoadExcel();
	});
	
	$("#btnDownloadPCExcel").click(function(){
		downLoadPCExcel();
	});

    $("#taskWindowClose").click(function(e){
        $("#taskWindow").hide();
    });
    
    $("#pathWindowClose").click(function(e){
        $("#pathWindow").hide();
    });

    $("#btnSearch").click(function(e){
        fnSearchFindSubpath();
        fnSearchFindSubpathPC();
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

    $("#searchLocation").keyup(function(e){
        if (e.keyCode == 13) {
            fnSearchFindSubpath();
            fnSearchFindSubpathPC();
        }
    });
    
    loadTargetPCGrid();
    loadTargetGrid(); 
    
    $("#hostSelect").change(function(e){
    	$("#taskWindow").hide();
    	$("#pathWindow").hide();
	    $("#targetGrid").clearGridData();
	    $("#searchLocation").val("");
    	if($(this).val() != 'all'){
	        fnSearchFindSubpath();
    	} 
    });
    
    if("${target_id}" != null){
    	$("#targetSearch").val("${host}");
    	$("#targetSearch").text("${host}");
    	$("#hostSelect").val("${target_id}");
	    $("#searchLocation").val("");
	    $("#targetGrid").clearGridData();
    	$("#ap_no").val("${apno}");

    	if("${apno}" != 0){
    		// var helpPCIcon = '<img alt="" src="${pageContext.request.contextPath}/resources/assets/images/help_icon_1.png" style="width: 24px; position: absolute; top: 30px; left: 365px; cursor: pointer;" id="userHelpPCIcon">';
    		
    		$(".grid_top_Server").css("display", "none");
    		$(".grid_top_PC").css("display", "");
    		// $(".detection_list_txt").after(helpPCIcon);
    		// $("#userHelpIcon").css("display", "none");
    		// $("#userHelpPCIcon").css("left", "805px");
    		
    		$(".answerLabel").css("display", "none");
    		$(".wrongLabel").css("display", "none");
    		$("#btnDownloadExcel").css("display", "none");
    		$("#btnDownloadPCExcel").css("display", "");
    		$("#btnDownloadPCExcel").css("margin-top", "10px");
    		$(".grade_hidden").css("display", "none");
    		$("#sch_detail").css("width", "440px");
    		fnSearchFindSubpathPC();
    	}else{
    		
	        fnSearchFindSubpath();
    	}
    	
    	
    } 
    
    
    // 검출 리스트 - 처리 버튼
    $("#btnDeletionRegist").on("click", function(e) {
        fnOpenDeletionRegist();
    });
    
    $("#btnReasonTrue").on("click", function(e) {
    	fnOpenTrueDeletionRegist();
    });
    
    $("#btnReasonFalse").on("click", function(e) {
    	fnOpenFalseDeletionRegist();
    });
    
    // 검출리스트 - 처리 - 정탐/오탐 팝업
    $("#selectReasonTrue").click(function(){
        $("#resultTrue").show();
    
    });

    $("#selectReasonFalse").click(function(){
        $("#resultFalse").show();
    });
    
    // 검출리스트 - 처리 - 정탐 팝업 - 확인버튼
    $("#btnResultTrueSave").on("click", function(e) {
        var checkedradio = $("input:radio[name=processing_flag]:checked").val();
        var selectedDate = $("#selectedDate").val();

        if ( ! checkedradio ) {
            alert("사유를 선택하세요.");
            jQuery('input[name="processing_flag"]').focus();
            return false;
        }

        $("input:radio[name=trueFalseChk]").val(checkedradio);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultTrue").hide();
        return;
    });

    // 검출리스트 - 처리 - 오탐 팝업 - 확인버튼
    $("#btnResultFalseSave").on("click", function(e) {
        var checkedradio = $("input:radio[name=processing_flag]:checked").val();
        
        if ( ! checkedradio ) {
            alert("사유를 선택하세요.");
            jQuery('input[name="processing_flag"]').focus();
            return false;
        }
        
        $("input:radio[name=trueFalseChk]").val(checkedradio);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultFalse").hide();
        return;
    });
    
    
    // 검출리스트 - 처리 - 오탐 팝업 - 취소 버튼
    $("#btnResultFalseCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#resultFalse").hide();
    });
    
    // 검출리스트 - 처리 - 정탐 팝업 - 취소 버튼
    $("#btnResultTrueCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);

        $("#legalSystem").val("");
        $("#deleteCycle").val("");
        
        $("#resultTrue").hide();
    });

    // 검출 리스트 - 처리 - 저장
    $("#btnDeletionSave").on("click", function(e) {
        fnSaveDeletion();
    });

    // 검출리스트 - 처리 - 취소 버튼
    $("#btnDeletionCancel").on("click", function(e) {
        $("input:radio[name=trueFalseChk]").prop("checked",false);
        $("input:radio[name=processing_flag]").prop("checked",false);
        $("#deletionRegistPopup").hide();
    });
    
    $("#btnTrueDeletionCancel").on("click", function(e) {
    	$("#path_detail_true").val("");
    	$("#trueDeletionAction option:eq(0)").prop("selected", true);
    	$(".true_processing_comment span").html("담당자에 의한 수동삭제 항목입니다. 삭제 예정일자를 선택해 주시기 바랍니다.");
    	$("#addTrueProcessing").html("");
        $("#trueDeletionRegistPopup").hide();
    });
    
    $("#btnCancleTrueDeletionRegistPopup").on("click", function(e) {
    	$("#path_detail_true").val("");
    	$("#trueDeletionAction option:eq(0)").prop("selected", true);
    	$(".true_processing_comment span").html("담당자에 의한 수동삭제 항목입니다. 삭제 예정일자를 선택해 주시기 바랍니다.");
    	$("#addTrueProcessing").html("");
        $("#trueDeletionRegistPopup").hide();
    });
    
    $("#btnFalseDeletionCancel").on("click", function(e) {
    	$("#path_detail_false").val("");
    	$("#falseDeletionAction option:eq(0)").prop("selected", true);
    	$("#selectDateFalse").css("display", "inline");
    	$(".false_processing_comment span").html("수동 삭제 완료 예정 일자를 선택 하시기 바랍니다.");
    	$("#addFalseProcessing").html("");
        $("#falseDeletionRegistPopup").hide();
    });
    
    $("#btnCancleFalseDeletionRegistPopup").on("click", function(e) {
    	$("#path_detail_false").val("");
    	$("#falseDeletionAction option:eq(0)").prop("selected", true);
    	$("#selectDateFalse").css("display", "inline");
    	$(".false_processing_comment span").html("수동 삭제 완료 예정 일자를 선택 하시기 바랍니다.");
    	$("#addFalseProcessing").html("");
        $("#falseDeletionRegistPopup").hide();
    });
    
    // 해당 input 태그 클릭시 라이도 버튼 클릭 이벤트
    $("#legalSystem").focus(function(){
    	$("#processingCheck2").prop("checked",true);
    });
    
    $("#deleteCycle").focus(function(){
    	$("#processingCheck3").prop("checked",true);
    });
    
    $("#userHelpIcon").on("click", function(e) {
		/* $("#userHelpPopup").show(); */
    	var id = "detection_list";
		var pop_url = "${getContextPath}/popup/helpDetail";
    	var winWidth = 1200;
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
    
    $("#userHelpPCIcon").on("click", function(e) {
		/* $("#userHelpPopup").show(); */
    	var id = "detection_list_pc";
		var pop_url = "${getContextPath}/popup/helpDetail";
    	var winWidth = 1200;
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
    
    setselectDateTrue();
    setselectDateFalse();
    
/* <c:if test="${memberInfo.USER_GRADE == '0' || memberInfo.USER_GRADE == '1' || memberInfo.USER_GRADE == '2' || memberInfo.USER_GRADE == '3' || memberInfo.USER_GRADE == '7'}">
	$(".detection_list_title").html("결과조회")
	$(".detection_list_txt").css("left", "144px");
	$(".answerLabel").css("display", "none");
	$(".wrongLabel").css("display", "none");
	$("#btnDownloadExcel").css("margin-top", "10px");
</c:if> */

var to = true;
$('#btn_sch_target').on('click', function(){
	
	if($("#fromDate").val() > $("#toDate").val()){
		alert("입력한 끝 날짜가 시작 날짜 보다 빠릅니다.");
		return;
	}

    var v = $('#targetSearch').val();
	console.log(v);
	
	if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#jstree').jstree(true).search(v);
    }, 250);
});

$('#targetSearch').keyup(function (e) {
	var v = $('#targetSearch').val();
	if (e.keyCode == 13) {
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#jstree').jstree(true).search(v);
        }, 250);
    }
});

//확인
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

}); 

$(document).mouseup(function (e){
	  var LayerPopup = $("#userHelpPopup");
	  if(LayerPopup.has(e.target).length === 0){
		  $("#userHelpPopup").hide();
	  }
});


function getFormatDate(oDate)
{
    var nYear = oDate.getFullYear();           // yyyy 
    var nMonth = (1 + oDate.getMonth());       // M 
    nMonth = ('0' + nMonth).slice(-2);         // month 두자리로 저장 

    var nDay = oDate.getDate();                // d 
    nDay = ('0' + nDay).slice(-2);             // day 두자리로 저장

    return nYear + '-' + nMonth + '-' + nDay;
}

// 정탐 처리 저장 
$("#btnTrueDeletionSave").click(function(e){
	
	var oToday = new Date();
	var date = getFormatDate(oToday);
	var idx = 0;
	var aDeletionList = [];
	var aDeletionData = $("#targetGrid").jqGrid('getGridParam', 'data');
	
	for (var i = 0; i < aDeletionData.length; i++) {
		var level = aDeletionData[i].LEVEL;
		var chkold = aDeletionData[i].CHKOLD;
		var id = aDeletionData[i].ID;
		if (level != chkold) {
			aDeletionList.push(id);
		}
	}
	
	/* $('[name=gridChk]').each(function(i, item){
	     if (item.checked) {
	         aDeletionList.push(item.value);
	     }
	 }); */

	var tid = $("#hostSelect").val();
	var path_detail_true = $("#path_detail_true").val().trim();
	var next_date_remedi = $("#selectDateTrue").val();
	var sFlag = $("#trueDeletionAction").val();
	var add_content = "";
	var sProcessFlag;
	
	 if($("#selectDateTrue").val() < date){
		alert("지정 일 현재 날짜보다 이전입니다.");
		return;
	};
	if(path_detail_true == ""){
		alert("판단근거는 반드시 작성해야 합니다. 상세하게 작성해 주세요.");
		return;
	}
	
	if(sFlag == 2 && $("#activeCycle").val().trim() == ""){
		alert("조치계획에 미입력 항목이 있습니다. 다시 확인해주세요.");
		return;		
	}
	
	if((sFlag == 3 || sFlag == 4)&& $("#keepReason").val().trim() == ""){
		alert("조치계획에 미입력 항목이 있습니다. 다시 확인해주세요.");
		return;		
	}
	switch(sFlag) {
	    case "1": sProcessFlag = '정탐(수동삭제)'; break;
	    case "2": 	sProcessFlag = '정탐(자동삭제)'; 
	    			add_content = $("#activeCycle").val(); break;
	    case "3": 	sProcessFlag = '정탐(암호화저장)'; break;
	    			add_content = $("#keepReason").val(); break;
	    case "4": 	sProcessFlag = '정탐(평문유지)';
	    			add_content = $("#keepReason").val(); break;
	}
	
	/* $('#title_process_true').html("정탐처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_"+SEQ); */
	 var sChargeNm = sProcessFlag + "처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_";
	 
	 var oPostDt = {};
	 oPostDt["deletionList"]             = aDeletionList;
	 oPostDt["processing_flag"]          = sFlag;
	 oPostDt["data_processing_name"]     = sChargeNm;
	 oPostDt["next_date_remedi"]         = next_date_remedi;
	 oPostDt["ap_no"]	 				 = $("#ap_no").val();
	 oPostDt["selectDateTrue"]	 		 = $("#selectDateTrue").val();
	 oPostDt["notePad"]	 			 	 = path_detail_true;
	 oPostDt["add_content"]				 = add_content;
	 oPostDt["tid"]						 = tid;
	 
	 var oJson = JSON.stringify(oPostDt);
	 
	 var confirmCheck = confirm('해당 내용으로 등록하시겠습니까?');
	 
	 if(confirmCheck == true){
		$.ajax({
		     type: "POST",
		     url: "${getContextPath}/detection/regist_process",
		     async : false,
		     data : oJson,
		     contentType: 'application/json; charset=UTF-8',
		     success: function (result) {
	
		         if (result.resultCode != "0") {
		             alert("처리 등록을 실패 하였습니다.");
		             return;
		         }
	
		        $("#targetGrid").setGridParam({
		             url: "${getContextPath}/manage/selectFindSubpath",
		             postData: $("#targetGrid").getGridParam('postData'),
		             datatype: "json",
		             treedatatype: 'json'
		         }).trigger("reloadGrid"); 
	
				alert("처리를 등록 하였습니다.");
				$("#activeCycle").val("");
				$("#keepReason").val("");
				$("#path_detail_true").val("");
	
				$("#trueDeletionAction option:eq(0)").prop("selected", true);
				$(".true_processing_comment span").html("수동 삭제 완료 예정 일자를 선택해 주세요.");
				$("#addTrueProcessing").html("");
				$("#trueDeletionRegistPopup").hide();
		         return;
		     },
		     error: function (request, status, error) {
		         alert("처리 등록을 실패 하였습니다.");
	
				$("#activeCycle").val("");
				$("#keepReason").val("");
				$("#path_detail_true").val("");
				
				$("#trueDeletionAction option:eq(0)").prop("selected", true);
				$(".true_processing_comment span").html("수동 삭제 완료 예정 일자를 선택해 주세요.");
				$("#addTrueProcessing").html("");
				$("#trueDeletionRegistPopup").hide();
		         return;
		     }
		 });
	 }else{
			return;
		}
	 
});

// 오탐 처리 저장
$("#btnFalseDeletionSave").click(function(e){
	
	var oToday = new Date();
	var date = getFormatDate(oToday);
	var idx = 0;
	var aDeletionList = [];
	var aDeletionData = $("#targetGrid").jqGrid('getGridParam', 'data');
	
	for (var i = 0; i < aDeletionData.length; i++) {
		var level = aDeletionData[i].LEVEL;
		var chkold = aDeletionData[i].CHKOLD;
		var id = aDeletionData[i].ID;
		if (level != chkold) {
			aDeletionList.push(id);
		}
	}
	
	/* $('[name=gridChk]').each(function(i, item){
	     if (item.checked) {
	         aDeletionList.push(item.value);
	     }
	 }); */

	var tid = $("#hostSelect").val();
	var path_detail_false = $("#path_detail_false").val().trim();
	var next_date_remedi = $("#selectDateTrue").val();
/* 	var sFlag = $("#falseDeletionRegistPopup input:radio[name=popup_content]:checked").val(); */
	var sFlag = $("#falseDeletionAction").val();
	var add_content = "";
	var sProcessFlag;
	
	 if($("#selectDateFalse").val() < date){
		alert("지정 일 현재 날짜보다 이전입니다.");
		return;
	};

	if(path_detail_false == ""){
		alert("판단근거는 반드시 작성해야 합니다. 상세하게 작성해 주세요.");
		return;
	}
	
	if(sFlag == 6 && $("#keepReason").val().trim() == ""){
		alert("조치계획에 미입력 항목이 있습니다. 다시 확인해주세요.");
		return;		
	}
	
	switch(sFlag) {
	    case "5": sProcessFlag = '오탐(수동삭제)'; break;
	    case "6": sProcessFlag = '오탐(평문유지)';
	    		  add_content = $("#keepReason").val(); break;
	}
	
	var sChargeNm = sProcessFlag + "처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_";
	
	var oPostDt = {};
	oPostDt["deletionList"]             = aDeletionList;
	oPostDt["processing_flag"]          = sFlag;
	oPostDt["data_processing_name"]     = sChargeNm;
	oPostDt["next_date_remedi"]         = next_date_remedi;
	oPostDt["ap_no"]	 				 = $("#ap_no").val();
	oPostDt["selectDateTrue"]	 		 = $("#selectDateFalse").val();
	oPostDt["notePad"]	 			 	 = path_detail_false;
	oPostDt["add_content"]				 = add_content;
	oPostDt["tid"]						 = tid;
	
	var oJson = JSON.stringify(oPostDt);
	
	var confirmCheck = confirm('선택하신 내용을 예외 처리 하시겠습니까?');
	
	if(confirmCheck == true){
		$.ajax({
		     type: "POST",
		     url: "${getContextPath}/detection/regist_process",
		     async : false,
		     data : oJson,
		     contentType: 'application/json; charset=UTF-8',
		     success: function (result) {
	
		         if (result.resultCode != "0") {
		             alert("처리 등록을 실패 하였습니다.");
		             return;
		         }
	
		        $("#targetGrid").setGridParam({
		             url: "${getContextPath}/manage/selectFindSubpath",
		             postData: $("#targetGrid").getGridParam('postData'),
		             datatype: "json",
		             treedatatype: 'json'
		         }).trigger("reloadGrid"); 
	
				alert("처리를 등록 하였습니다.");
				$("#keepReason").val("");
				$("#path_detail_false").val("");
	
				$("#falseDeletionAction option:eq(0)").prop("selected", true);
		    	$("#selectDateFalse").css("display", "inline");
		    	$(".false_processing_comment span").html("수동 삭제 완료 예정 일자를 선택해 주세요.");
		    	$("#addFalseProcessing").html("");
		        $("#falseDeletionRegistPopup").hide();
		         return;
		     },
		     error: function (request, status, error) {
		         alert("처리 등록을 실패 하였습니다.");
	
				$("#activeCycle").val("");
				$("#keepReason").val("");
				$("#path_detail_true").val("");
				
				$("#trueDeletionAction option:eq(0)").prop("selected", true);
				$(".true_processing_comment span").html("수동 삭제 완료 예정 일자를 선택해 주세요.");
				$("#addTrueProcessing").html("");
				$("#trueDeletionRegistPopup").hide();
		         return;
		     }
		 });
	}else{
		return;
	}
	
});

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
					$("#"+rowid).find(':checkbox').attr('checked', true);
					$("#targetGrid").jqGrid('setCell', rowid, 'LEVEL', "0");
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
					$("#"+rowid).find(':checkbox').attr('checked', false);
					$("#targetGrid").jqGrid('setCell', rowid, 'LEVEL', "1");
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

/* 
$("#btnSearchHost").on("click", function(){
	
	var pop_url = "${getContextPath}/popup/targetList";
	var id = "targetList"
	var winWidth = 700;
	var winHeight = 570;
	var popupOption= "width="+winWidth+", height="+winHeight + ", left=0, top=0, scrollbars=no, resizable=no, location=no"; 	
	//var pop = window.open(pop_url,"lowPath",popupOption);
	var pop = window.open(pop_url,id,popupOption);
	popList.push(pop);
	sessionUpdate();
	
	//pop.check();
	
	var newForm = document.createElement('form');
	newForm.method='POST';
	newForm.action=pop_url;
	newForm.name='newForm';
	//newForm.target='lowPath';
	newForm.target=id;
	
	var data = document.createElement('input');
	data.setAttribute('type','hidden');
	data.setAttribute('name','hash_id');
	data.setAttribute('value',id);
	
	newForm.appendChild(data);
	document.body.appendChild(newForm);
	newForm.submit();
	
	document.body.removeChild(newForm);
	
});
*/

function findByPop(){
	$("#taskWindow").hide();
	$("#pathWindow").hide();
	$("#targetGrid").clearGridData();
	$("#searchLocation").val("");
    fnSearchFindSubpath();
}

function findByPopPC(){
	$("#taskWindow").hide();
	$("#pathWindow").hide();
	$("#targetGrid").clearGridData();
	$("#searchLocation").val("");
    fnSearchFindSubpathPC();
}


function getLowPath(id, tid, ap_no){
	
	var pop_url = "${getContextPath}/popup/lowPath";
	var winWidth = 1142;
	var winHeight = 365;
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


//검출 리스트 - 처리 팝업 오픈
function fnOpenDeletionRegist()
{
 $.ajax({
     type: "POST",
     url: "${getContextPath}/detection/selectProcessDocuNum",
     async: false,
     datatype: "json",
     success: function (result) {
         $('#title_process').html("처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_" + result.SEQ);
         SEQ = result.SEQ;
     }
 });

 var aDeletionList = [];
 var aNameList = [];
 var sRowID;

 $('[name=gridChk]').each(function(i, item){
 	if (item.checked) {
         var sRowID = $(item).data("rowid");
         aDeletionList.push(item.value);

         aNameList.push($("#targetGrid").getCell(sRowID, 'SHORTNAME'));
     }
 });

 if (aDeletionList.length == 0) {
     alert("처리 항목을 선택하세요.");
     return;
 }

 //$("#deletionRegistPopup #path_exception").val(aNameList);
 var tr = $("#path_exception").children();
 tr.remove();

 for (var i = 0; i < aNameList.length; i += 1) 
 {
     sTag  = "<tr style='border:none;'>";
     sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + aNameList[i] + "</th>";
     sTag += "</tr>";

     $("#deletionRegistPopup #path_exception").append(sTag);
 }

 $("#deletionRegistPopup").show();
}

//검출 리스트 - 정탐 처리 팝업 오픈
function fnOpenTrueDeletionRegist()
{
 $.ajax({
     type: "POST",
     url: "${getContextPath}/detection/selectProcessDocuNum",
     async: false,
     datatype: "json",
     success: function (result) {
         $('#title_process_true').html("정탐처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_" + result.SEQ + "<span>" + "검출된 개인정보의 정탐 판단 근거에 대해 상세하게 작성해 주시고 조치계획을 선택해 주시기 바랍니다." + "</span>");
         SEQ = result.SEQ;
     }
 });

 var idx = 0;
 var aDeletionList = [];
 var aNameList = [];
 var sRowID;
 var hiddenList = [];
 var stausCheck = "";
 var aDeletionData = $("#targetGrid").jqGrid('getGridParam', 'data');
 
 for (var i = 0; i < aDeletionData.length; i++) {
		var level = aDeletionData[i].LEVEL;
		var chkold = aDeletionData[i].CHKOLD;
		if (level != chkold) {
			var aDeletionAssign = {};
			aDeletionAssign.ID = aDeletionData[i].ID;
			aDeletionAssign.SHORTNAME = aDeletionData[i].SHORTNAME;
			aDeletionAssign.APPROVAL_STATUS_PRINT_NAME = aDeletionData[i].APPROVAL_STATUS_PRINT_NAME;
			aDeletionList[idx++] = aDeletionAssign;
		}
	}
 
 /* $('[name=gridChk]').each(function(i, item){
 	if (row[i].LEVEL == 0) {
         var sRowID = $(item).data("rowid");
         aDeletionList.push(item.value);
         aNameList.push($("#targetGrid").getCell(sRowID, 'SHORTNAME'));
         hiddenList.push($("#targetGrid").getCell(sRowID, 'APPROVAL_STATUS_PRINT_NAME'));
     }
 }); */

 if (aDeletionList.length == 0) {
     alert("처리 항목을 선택하세요.");
     return;
 }

 for (var j = 0; j < aDeletionList.length; j++ ) {
	if(aDeletionList[j].APPROVAL_STATUS_PRINT_NAME != "" || aDeletionList[j].APPROVAL_STATUS_PRINT_NAME != null){
		stausCheck = aDeletionList[j].APPROVAL_STATUS_PRINT_NAME.substr(0,2);
	}else{
		stausCheck = aDeletionList[j].APPROVAL_STATUS_PRINT_NAME;
	}
	 
	if(stausCheck == "대기" || stausCheck == "완료"){
		 alert("처리 할수 없는 항목이 포함되어 있습니다.\n확인 후 다시 선택하세요.");
	     return;
	}
 }
 
 //$("#deletionRegistPopup #path_exception").val(aNameList);
 var tr = $("#path_exception_true").children();
 tr.remove();

 for (var i = 0; i < aDeletionList.length; i += 1) 
 {
	
     sTag  = "<tr style='border:none;'>";
     sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + aDeletionList[i].SHORTNAME + "</th>";
     sTag += "</tr>";

     $("#trueDeletionRegistPopup #path_exception_true").append(sTag);
 }
 
 $("#trueDeletionRegistPopup").show();
}

//검출 리스트 - 오탐 처리 팝업 오픈
function fnOpenFalseDeletionRegist()
{
 $.ajax({
     type: "POST",
     url: "${getContextPath}/detection/selectProcessDocuNum",
     async: false,
     datatype: "json",
     success: function (result) {
         $('#title_process_false').html("오탐처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_" + result.SEQ + "<span>" + "검출된 개인정보의 오탐 판단 근거에 대해 상세하게 작성해 주시고 조치계획을 선택해 주시기 바랍니다." + "</span>");
     }
 });

 var idx = 0;
 var aDeletionList = [];
 var aNameList = [];
 var sRowID;
 var hiddenList = [];
 var stausCheck ="";
 var aDeletionData = $("#targetGrid").jqGrid('getGridParam', 'data');

 for (var i = 0; i < aDeletionData.length; i++) {
		var level = aDeletionData[i].LEVEL;
		var chkold = aDeletionData[i].CHKOLD;
		if (level != chkold) {
			var aDeletionAssign = {};
			aDeletionAssign.ID = aDeletionData[i].ID;
			aDeletionAssign.SHORTNAME = aDeletionData[i].SHORTNAME;
			aDeletionAssign.APPROVAL_STATUS_PRINT_NAME = aDeletionData[i].APPROVAL_STATUS_PRINT_NAME;
			aDeletionList[idx++] = aDeletionAssign;
		}
	}
 
 /* $('[name=gridChk]').each(function(i, item){
 	if (item.checked) {
         var sRowID = $(item).data("rowid");
         aDeletionList.push(item.value);

         aNameList.push($("#targetGrid").getCell(sRowID, 'SHORTNAME'));
         hiddenList.push($("#targetGrid").getCell(sRowID, 'APPROVAL_STATUS_PRINT_NAME'));
     }
 }); */

 if (aDeletionList.length == 0) {
     alert("처리 항목을 선택하세요.");
     return;
 }
 
 for (var j = 0; j < aDeletionList.length; j++ ) {
 
    if(aDeletionList[j].APPROVAL_STATUS_PRINT_NAME != "" || aDeletionList[j].APPROVAL_STATUS_PRINT_NAME != null){
		stausCheck = aDeletionList[j].APPROVAL_STATUS_PRINT_NAME.substr(0,2);
	}else{
		stausCheck = aDeletionList[j].APPROVAL_STATUS_PRINT_NAME;
	}
	 
	if(stausCheck == "대기" || stausCheck == "완료"){
		 alert("처리 할수 없는 항목이 포함되어 있습니다.\n확인 후 다시 선택하세요.");
	     return;
	}
 }

 //$("#deletionRegistPopup #path_exception").val(aNameList);
 var tr = $("#path_exception_false").children();
 tr.remove();

 for (var i = 0; i < aDeletionList.length; i += 1) 
 {
     sTag  = "<tr style='border:none;'>";
     sTag += "    <th style='padding:2px; background: transparent; overflow:hidden; text-align:left;'>" + aDeletionList[i].SHORTNAME + "</th>";
     sTag += "</tr>";

     $("#falseDeletionRegistPopup #path_exception_false").append(sTag);
 }

 $("#falseDeletionRegistPopup").show();
}

//검출리스트 - 처리 저장
function fnSaveDeletion()
{
 var aDeletionList = [];

 $('[name=gridChk]').each(function(i, item){
     if (item.checked) {
         aDeletionList.push(item.value);
     }
 });

 if (aDeletionList.length == 0) {
     alert("처리 항목을 선택하세요.");
     return;
 }

 var next_date_remedi = $("#selectedDate").val();
 //var sFlag = $("input:radio[name=trueFalseChk]").val();
 var sFlag = $("#deletionRegistPopup input:radio[name=trueFalseChk]:checked").val();
 //alert(sFlag + "\n\n" + $("#deletionRegistPopup input:radio[name=trueFalseChk]").is(":checked"));

 if(!sFlag || !$("#deletionRegistPopup input:radio[name=trueFalseChk]").is(":checked")) {
 	alert("사유를 선택하십시오");
 	return false;
 }
 var sProcessFlag;

 switch(sFlag) {
     case "1": sProcessFlag = '정탐(삭제)'; break;
     case "2": sProcessFlag = '정탐(법제도)'; break;
     case "3": sProcessFlag = '정탐(삭제주기)'; break;
     case "4": sProcessFlag = '오탐(시스템 파일)'; break;
     case "5": sProcessFlag = '오탐(기타)'; break;
 }
 
 var notePad = "";
 if(sFlag == 2){
	 notePad = $("#legalSystem").val();
 }else if(sFlag == 3){
	 notePad = $("#deleteCycle").val();
 }
 
/*  switch(sFlag) {
     case "1": sProcessFlag = '정탐(삭제)'; break;
     case "2": sProcessFlag = '정탐(암호화)'; break;
     case "3": sProcessFlag = '정탐(마스킹)'; break;
     case "4": sProcessFlag = '정탐(기타)'; break;
     case "5": sProcessFlag = '오탐(예외처리)'; break;
     case "6": sProcessFlag = '오탐(오탐수용)'; break;
     case "7": sProcessFlag = '오탐(기타)'; break;
     case "8": sProcessFlag = '정탐(임시보관)'; break;
 } */

 var sChargeId;

 $('#title_process').html("처리_" + <fmt:formatDate value="${nowDate}" pattern="yyyyMMdd" /> + "_" + "${memberInfo.USER_NO}" + "_");
 var sChargeNm = sProcessFlag + document.getElementById('title_process').innerHTML;
 
 var oPostDt = {};
 oPostDt["deletionList"]             = aDeletionList;
 oPostDt["processing_flag"]          = sFlag;
 oPostDt["data_processing_name"]     = sChargeNm;
 oPostDt["next_date_remedi"]         = next_date_remedi;
 oPostDt["ap_no"]	 				 = $("#ap_no").val();
 oPostDt["selectDateTrue"]	 			 = $("#selectDateTrue").val();
 oPostDt["notePad"]	 			 	 = notePad;
 

 var oJson = JSON.stringify(oPostDt);

 /* $.ajax({
     type: "POST",
     url: "${getContextPath}/detection/registProcess",
     async : false,
     data : oJson,
     contentType: 'application/json; charset=UTF-8',
     success: function (result) {

         if (result.resultCode != "0") {
             alert(result.resultCode + "처리 등록을 실패 하였습니다.");
             return;
         }

       $("#targetGrid").setGridParam({
             url: "${getContextPath}/manage/selectFindSubpath",
             postData: $("#targetGrid").getGridParam('postData'),
             datatype: "json",
             treedatatype: 'json'
         }).trigger("reloadGrid");  

         alert("처리를 등록 하였습니다.");
         $("#legalSystem").val("");
         $("#deleteCycle").val("");

         $("#deletionRegistPopup").hide();
         $("input:radio[name=trueFalseChk]").prop("checked",false);
         $("input:radio[name=processing_flag]").prop("checked",false);
         return;
     },
     error: function (request, status, error) {
         alert("처리 등록을 실패 하였습니다.");

         $("#legalSystem").val("");
         $("#deleteCycle").val("");
         $("input:radio[name=trueFalseChk]").prop("checked",false);
         $("input:radio[name=processing_flag]").prop("checked",false);
         return;
     }
 }); */

 $("input:radio[name=trueFalseChk]").prop("checked",false);
 $("input:radio[name=processing_flag]").prop("checked",false);
 $("#deletionRegistPopup").hide();
}

//날짜
function setselectDateTrue() 
{
    $("#selectDateTrue").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    var oToday = new Date();
    $("#selectDateTrue").val(getFormatDate(oToday));

};
//날짜
function setselectDateFalse() 
{
    $("#selectDateFalse").datepicker({
        changeYear : true,
        changeMonth : true,
        dateFormat: 'yy-mm-dd'
    });

    var oToday = new Date();
    $("#selectDateFalse").val(getFormatDate(oToday));

};
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

$("#trueDeletionAction").on("change", function (){
    var optionSelected = $("#trueDeletionAction option:selected", this);
    var valueSelected = this.value;

	$("#addTrueProcessing").html("");
	if(valueSelected == '1'){
		$(".true_processing_comment span").html("담당자에 의한 수동삭제 항목입니다. 삭제 예정일자를 선택해 주시기 바랍니다.");
	}
	else if(valueSelected == '2'){
   		$("#addTrueProcessing").html("<p class='true_processing_hint'>삭제주기</p>" + "<input type='text' class='edt_sch' id='activeCycle' placeholder='자동 삭제되는 기간(일자)를 기입하시기 바랍니다.' style='width: 270px; margin-left: 5px; padding-left: 5px'>");
   		$(".true_processing_comment span").html("자동 삭제 주기에 대해 기입(ex: 3일, 5일, 7일 등)");
    }
    else if(valueSelected == '3'){
    	$("#addTrueProcessing").html("<input type='text' class='edt_sch' id='keepReason' placeholder='암호화 솔루션을 입력하시기 바랍니다.' style='width: 250px; margin-left: 5px; padding-left: 5px'>");
    	$(".true_processing_comment span").html("검출된 개인정보를 Swing문서보안, 자체암호화 기술등으로 보관할 경우 암호화 완료 예정 일자를 선택 하시기 바랍니다.");
    }
    else if(valueSelected == '4'){
    	$("#addTrueProcessing").html("<p class='true_processing_hint'>사유</p>" + "<input type='text' class='edt_sch' id='keepReason' placeholder='사규 또는 법적 근거를 기입하시기 바랍니다.' style='width: 250px; margin-left: 5px; padding-left: 5px'>");
    	$(".true_processing_comment span").html("개인정보에 대한 평문 보관이 필요한 경우 사규 또는 법적 근거를 바탕으로 사유를 작성 하시기 바랍니다." + "<br />" + "(ex: 고객정보 취급업무 지침에 의거 증빙서류에 대해 5년간 보관)");
    }
});

$("#falseDeletionAction").on("change", function (){
    var optionSelected = $("#falseDeletionAction option:selected", this);
    var valueSelected = this.value;

	$("#addFalseProcessing").html("");
	if(valueSelected == '5'){
		$(".false_processing_comment span").html("수동 삭제 완료 예정 일자를 선택 하시기 바랍니다.");
		$("#selectDateFalse").css("display", "inline");
	}
	else if(valueSelected == '6'){
    	$("#addFalseProcessing").html("<p class='false_processing_hint'>사유</p>" + "<input type='text' class='edt_sch' id='keepReason' placeholder='사유를 기입하시기 바랍니다.(시스템 파일)' style='width: 250px; margin-left: 5px; padding-left: 5px'>");
    	$(".false_processing_comment span").html("오탐 파일을 계속 보관해야 하는 사유에 대해서 작성 하시기 바랍니다. (ex: 서비스 운영 파일로 보관 필요)" + "<br />" + "(업무상 불필요한 파일은 영향도 확인 후 삭제 권고)");
    	$("#selectDateFalse").css("display", "none");
    }
});

//검출일 툴팁
function createTime(cellvalue, options, rowObject) {
	
	var html = null;
	if(resetFomatter == "downloadClick"){
		return cellvalue;
	}else{
	    html = "<p title='"+cellvalue+"'> " + cellvalue.substr(0,10) + "</p>";
	    return html;
	}
	
}

var approvalNm = function(cellvalue, options, rowObject) {
	var approvalStatusNm = rowObject.APPROVAL_STATUS_PRINT_NAME;
	if(approvalStatusNm != "" && approvalStatusNm != null){
		if (resetFomatter != "downloadClick") {
			return "<span id='approvalStatusNm'>"+approvalStatusNm+"</span>";	
		}else{
			return approvalStatusNm;	
		}
		
	}else {
		return "";
	}
	
}

function showDetail(fid, id, ap_no, rowid){
	
	$("#pathWindow").hide();
	$("#taskWindow").hide();
	var tid = $('#targetGrid').getCell(rowid, 'PID');
	
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

function gridClick(e, id){
	var e = e || window.event;
	var target = e.target || e.srcElement;
	
	if($("#gridChk_" + id).is(":checked")){
		$("#targetGrid").jqGrid('setCell', target.value, 'LEVEL', "0");
	}else{
		$("#targetGrid").jqGrid('setCell', target.value, 'LEVEL', "1");
	}
	
}
</script>

</body>
</html>