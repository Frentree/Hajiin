<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../../include/header.jsp"%>
 
<style>
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.mxWindowPane .user_info td, .user_info th{
		width: 26% !important;
	}
}
 </style>
		<!-- section -->
		<section>
			<!-- container -->
			<div class="container" >
			<h3>대상 그룹 관리</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<div class="left_area2" style="width: 557px;">
						<h3 style="top: 5px; padding: 0; display: inline;" id="name_toms">자산 현황</h3>
						<table class="user_info narrowTable" style="width: 250px; min-width: 0; float: right;">	
							<caption>타겟정보</caption>
                   			<tbody>
                   				<tr>
                   					 <th style="text-align: center; width: 0px; border-radius: 0.25rem;">호스트명</th>
	                   			     <td style="width:0%">
                       				 <input type="text" style="width: 147px; padding-left: 5px;" size="10" id="assetHostsSeach" placeholder="호스트명을 입력하세요.">
	                      			 </td>
	                      			 <td style="width:0%;">
                           			 <input type="button" name="button" class="btn_look_approval" id="assetHostsBtn" style="margin-top: 5px;">
                           			</td>
                   				</tr>
                   			</tbody>
						</table> 
						<div class="left_box2" id="grid_h1" style="overflow: hidden; max-height: 666px; height: 666px; margin-top: 20px;">
							<!-- <div class="search_area bold">
								<input type="text" id="txt_host" value="" style="width: 320px" placeholder="호스트 이름을 입력하세요." onKeypress="javascript:if(event.keyCode==13) fn_search()">
								<button type="button" id="btn_search" style="right: -12px;">검색</button>
							</div> -->
		   					 <div class="select_location" style="overflow-y: auto; overflow-x: auto; height: 100%; background: #ffffff;">
		   					 	<div id="group_tree"></div>
		   					 </div> 
						</div>
					</div>
					<div class="left_area2" style="width: 539px; margin-left:67px">
						<h3 style="top: 5px; padding: 0; display: inline;" id="name_target">타겟 리스트</h3>
						<table class="user_info narrowTable" style="width: 140px; min-width: 0; margin-top: 5px; border: none; float: right;">	
							<caption>타겟정보</caption>
                   			<tbody>
                   				<tr>
                                   <td style="width: 100%; padding: 0 !important;"><input type="button" class="btn_target_group" id="selTargetReset" value="초기화" style="margin-left: 20px;"></td>
                                   <td style="width: 100%; padding: 0 !important;"><input type="button" class="btn_target_group" id="movTargetGrp" value="그룹이동" style="margin-left: 20px;"></td>
                                   <td style="width: 100%; padding: 0 !important;"><input type="button" class="btn_target_group" id="addTarget" value="저장" style="margin-left: 20px;"></td>
                   				</tr>
                   			</tbody>
						</table>
						<input type="hidden" id="group_id" value=""/>
						<input type="hidden" id="group_name" value=""/>
						<div class="left_box2" id="grid_h1" style="overflow: hidden; max-height: 666px; height: 666px; margin-top: 20px;">
		   					<div id="div_target" class="select_location" style="overflow-y: auto; overflow-x: auto; height: 100%;background: #ffffff; padding: 0 0 0 0">
								 
                                 <!-- <table class="tbl_input" id="tbl_target"> -->
                                 <table> 
                                   <colgroup>
                                     <col width="*">
                                     <col width="100px">
                                    </colgroup>
									<tbody id="add_target">
                                    </tbody>
								</table> 
							</div>
						</div>
					</div>
					<!-- <div style="position: absolute; right: 611px; ">
						<div style="display:inline-block; margin-left: 17px; vertical-align: middle; height:700px;">
							<p class="btn_right" style="margin-top: 250px;"></p>
							<p class="btn_left" style="margin: 19px 0px 0px 5px"></p>
						</div>
					</div> -->
					<div class="grid_top" style="width: 539px; float: right; display: inline-block;">
							<h3 style="top: 5px; padding: 0; display: inline;">사용자 그룹</h3>
							
							<table class="user_info narrowTable" style="width: 250px; min-width: 0; float: right;">	
							<caption>타겟정보</caption>
                   			<tbody>
                   				<tr>
                   					 <th style="text-align: center; width: 0px; border-radius: 0.25rem;">호스트명</th>
	                   			     <td style="width:0%">
                       				 <input type="text" style="width: 147px; padding-left: 5px;" size="10" id="userGroupSearch" placeholder="호스트명을 입력하세요.">
	                      			 </td>
	                      			 <td style="width:0%;">
                           			 <input type="button" name="button" class="btn_look_approval" id="userGroupBtn" style="margin-top: 5px;">
                           	</td>
                   				</tr>
                   			</tbody>
						</table> 
						<div id="div_noGroup" class="select_location" style="overflow-y: auto; height: 666px; margin-top: 20px; background: #ffffff; padding: 0 0 0 0">
							<!-- <table id="tbl_noGroup" class="tbl_input" id="location_table">
								<tbody>
								</tbody>
							</table> -->
							<div id="add_group_tree"></div>
						</div>
	   				</div>
				</div>
			</div>
			<!-- container -->
		</section>
		<!-- section -->
		
		<div id="sendMalDetail" class="popup_layer" style="display:none">
		<div class="popup_box" style="height: 200px; width: 900px; padding: 10px; background: #f9f9f9; left: 43%; top:54%;">
		<img class="CancleImg" id="btnCancleSendMailDetail" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png" style="z-index: 999;">
			<div class="popup_top" style="background: #f9f9f9;">
				<h1 style="color: #222; padding: 0; box-shadow: none;" id="mailPopTitle">메일 발송</h1>
			</div>
			<div class="popup_content">
				<div class="content-box" id="div_update_user" style="height: auto; background: #fff; border: 1px solid #c8ced3;">
					<table class="popup_tbl">
						<colgroup>
	                        <col width="100">
	                        <col width="*">
	                    </colgroup>
						<tbody id="popup_details">
							<tr>
								<th style="border-bottom: 1px solid #cdcdcd;">수신자</th>
								<td style="padding-left: 10px; border-bottom: 1px solid #cdcdcd;">
									 <input type="checkbox" name="receiveUser" checked="checked" value="I"><span style="padding: 0px 8px 0px 2px;">인프라 담당자</span>
									 <input type="checkbox" name="receiveUser" checked="checked" value="S"><span style="padding: 0px 8px 0px 2px;">서비스 담당자</span>
									 <input type="checkbox" name="receiveUser" checked="checked" value="M"><span style="padding: 0px 8px 0px 2px;">서비스 관리자</span>
								</td>
							</tr>
							<tr>
								<th style="border-bottom: 1px solid #cdcdcd;">제목</th>
								<td style="padding-left: 10px; border-bottom: 1px solid #cdcdcd;"><input type="text" id="mailTitle" style="width: 749px; padding-left: 10px;"></td>
							</tr>
							<tr>
								<th>내용</th>
								<td style="padding-left: 10px;">
									<div id="mailType" style="width: 749px; display: none;"></div>
									<div id="mailContentHidden" style="width: 749px; display: none;"></div>
 									<textarea rows="8" cols="114" id="mailContent" style="margin-top: 10px; padding-left: 10px; width: 749px; height: 315px; resize: none;"></textarea>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="popup_btn">
				<div class="btn_area" style="padding: 10px 0; margin: 0;">
					<button type="button" id="btnModify">저장</button>
					<button type="button" id="btnSave">발송</button>
					<button type="button" id="btnClose">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../../include/footer.jsp"%>
	
<div id="modGroupPopup" class="popup_layer" style="display:none">
	<div class="popup_box" style="height: 200px; width: 400px;">
		<div class="popup_top">
			<h1>그룹 정보 변경</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 200px;">
				<!-- <h2>세부사항</h2>  -->
				<!-- <textarea id="accessIP" class="edt_sch" style="border: 1px solid #cdcdcd; width: 380px; height: 130px; margin-top: 5px; margin-bottom: 5px; padding: 10px; resize: none;"></textarea> -->
				<table id="modify_tbl" class="tbl_input">
					<tbody>
						<tr>
							<th>그룹명</th>
						</tr>
						<tr>
							<td style="height:20px; vertical-align: baseline;">
								<input type="text" id="groupName_pop" class="edt_sch" style="border: 1px solid #cdcdcd; width: 340px; margin-top: 5px; margin-bottom: 5px; padding: 10px; resize: none; height: 10px;"/>
							</td>
						</tr>
						<tr>
							<th>
								<p style="text-align:center;">
									<input type="checkbox" name="remediation" value="X" />없음<input type="checkbox" style="margin-left: 20px;" name="remediation" value="0" />삭제<input type="checkbox" style="margin-left: 20px;" name="remediation" value="1" />암호화<input type="checkbox" style="margin-left: 20px;" name="remediation" value="2" />마스킹
								</p>
							</th>
						</tr>
					</tbody>	
				</table>
				<input type="hidden" id="groupIdx_ori" value=""/>
				<input type="hidden" id="groupName_ori" value=""/>
				<input type="hidden" id="remediation_ori" value=""/>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area">
				<button type="button" id="btnModGroupSave">저장</button>
				<button type="button" id="btnModGroupCancel">취소</button>
			</div>
		</div>
	</div>
</div>	


<!-- 팝업창 - 그룹이동 시작 -->
<div id="groupChangePopup" class="popup_layer" style="display:none;">
	<div class="popup_box" style="height: 200px; width: 400px; padding: 10px; background: #f9f9f9;">
	<img class="CancleImg" id="btnCancleGroupChangePopup" src="${pageContext.request.contextPath}/resources/assets/images/cancel.png">
		<div class="popup_top" style="background: #f9f9f9;">
			<h1 style="color: #222; padding: 0; box-shadow: none;">그룹 이동</h1>
		</div>
		<div class="popup_content">
			<div class="content-box" style="height: 80px; background: #fff; border: 1px solid #c8ced3;">
				<!-- <h2>세부사항</h2>  -->
				<table class="popup_tbl">
					<colgroup>
						<col width="100%">
						<%-- <col width="*"> --%>
					</colgroup>
					<tbody>
						<tr>
							<td>
							<select name="selGroup" id="selGroup" style="width: 95%;">
						 		<option value="">미분류</option>
						 		<c:forEach items="${targetGroups}" var="item">
						 			<option value="${item.IDX}">${item.NAME}</option>
						 		</c:forEach>
						 	</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="popup_btn">
			<div class="btn_area" style="padding: 10px 0; margin: 0;">
				<button type="button" id="btnGroupChangeSave">저장</button>
				<button type="button" id="btnGroupChangeCancel">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- 팝업창 - 그룹이동 종료 -->
	
<script type="text/javascript">

var oGrid = $("#userGrid");

$(document).ready(function () {
	//$('#tbl_target').html(setGroupTarget([], 1, 1, ''));
	
	$('#group_tree').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${targetGroup},
		},
		"types" : {
		    "#" : {
		      "max_children" : 1,
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
		'plugins' : [/* "contextmenu" */,"search",
			"types",
			"unique",
			"checkbox",
			"changed"],
	})
    .bind('select_node.jstree', function(evt, data, x) {
    	var id = data.node.id;
    	//var type = data.node.data.type;
    	//var ap = data.node.data.ap;
    	var name =  data.node.text;
    	//$('#jstree').jstree(true).refresh();
    	
    }).on("changed.jstree", function (e, data) {
		//console.log(data);
	    //  console.log(data.changed.selected); // newly selected
	    //  console.log(data.changed.deselected); // newly deselected
	    
	    if(data.changed.selected.length != 0){
	    	var html = "";
	    	$.each($("#group_tree").jstree("get_checked",true),function(){
	    		var type = this.data.type;
	    		if(type == 1){
	    			console.log(this.data);
		    		$('#tr_'+this.id).remove();
	    			html += '<tr id="tr_'+this.id+'" data-treeid="'+this.id+'" data-targetname="'+this.data.name+'">';
	    			html += "<th style='text-align:left'> - " + this.data.name + "</th>";
	    			html += '<td>';
	    			html += "<button type='button' name='button' style='cursor:pointer; color:#1973ba; float:right;' onclick='fnCheckRemove(this);'>remove</button></td>";
	    			html += '</tr>';
	    		}
	    	});
	    	$('#add_target').append(html);
	    } else if(data.changed.deselected.length != 0) {
	    	$.each(data.changed.deselected, function(){
	    		var id = this.toString();
	    		$('#tr_'+id).remove();
	    	});
	    }
	});
	

	$('#add_group_tree').jstree({
		// List of active plugins
		"core" : {
		    "animation" : 0,
		    "check_callback" : true,
			"themes" : { "stripes" : false },
			"data" : ${creUserGroup},
		},
		'contextmenu' : { 
			"items" : { 
				"create" : {
					"separator_before" : false, 
					"separator_after" : true, 
					"label" : "하위 그룹추가", 
					"action" : function(obj){
						 
    					var idx = $('#add_group_tree').jstree('get_selected');
						var node = $('#add_group_tree').jstree(true).get_node(idx);
    					
    					var type = node.data.type;
    					
    					if(type != 0) {
    						alert("그룹에만 추가하실수 있습니다.");
    						return;
    					}
    					
    					$("#add_group_tree").jstree(true).create_node(idx, null, "last", function (node) {
					        this.edit(node, '', function(e, result){
					        	
					        	if(e.text.trim() == ''){
					        		$('#add_group_tree').jstree(true).delete_node(node.id);
					        		return;
					        	}
					        	
					        	var idx =node.parent;
					        	if(idx == 'group'){
					        		idx = 0;
					        	}
					        	var postData ={
					            	"idx": idx,
					            	"name": e.text,
					            }
					            	
					            $.ajax({
					        		type: "POST",
					        		url: "/group/insertUserCreateGroup",
					        		//async : false,
					        		data : postData,
					        		dataType: "json",
					        	    success: function (resultMap) {
					        	    	console.log(resultMap);
					        	    	
					        	    	if(resultMap.resultCode == -1){
					                		return;
					                	}
					        	    	
					                	var data = JSON.parse(resultMap.data);
					                	$('#add_group_tree').jstree(true).settings.core.data = data;
					                	$('#add_group_tree').jstree(true).refresh();
					        	    },
					        	    error: function (request, status, error) {
					        	    	alert("그룹 추가에 실패하였습니다.");
					        	        console.log("ERROR : ", error);
					        		    }
					        	});
					        });
					    });
    					/* 
				    	console.log(idx);
						$('#addUserCreateGroupPopup').show(); */
					}, 
				}, 
				"update" : { 
					"separator_before" : false, 
					"separator_after" : true, 
					"label" : "수정", 
					"action" : function(obj){
    					var idx = $('#add_group_tree').jstree('get_selected');
    					var node = $('#add_group_tree').jstree(true).get_node(idx);
    					var name = node.text;
    					
    					var type = node.data.type;
    					
    					if(node.id == 'group'){
    						alert("최상위 경로는 변경이 불가능 합니다.");
    						return;
    					}
    					
    					if(type != 0) {
    						alert("그룹만 변경하실수 있습니다.");
    						return;
    					}
    					
    					$('#add_group_tree').jstree(true).edit(idx, node.text, function(e, result){
    						if(result == false){
    							alert("같은 이름의 그룹이 존재합니다.");
    						}
    						var postData ={
    						   	"idx": e.id,
    						   	"name": e.text,
    						   }
    						$.ajax({
    							type: "POST",
    							url: "/group/updateUserCreateGroup",
   								//async : false,
   								data : postData,
   								dataType: "json",
   							    success: function (resultMap) {
   							    	console.log(resultMap);
   							    	
   							    	if(resultMap.resultCode == -1){
   							    		alert("업데이트 실패하였습니다.")
   					    	    		return;
   					    	    	}
   							    	
   							    },
   							    error: function (request, status, error) {
   							    	alert("그룹 업데이트 실패하였습니다.");
   							        console.log("ERROR : ", error);
   							    }
   							});
    					});
						//$("#modGroupPopup").show();
					},
				},
				"delete" : { 
					"separator_before" : false, 
					"separator_after" : true, 
					"label" : "삭제", 
					"action" : function(obj){
    					var idx = $('#add_group_tree').jstree('get_selected');
    					var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
    					var groupArr = [];
    					var serverArr = [];
    					
						if(idx.length < 1){
							alert("그룹을 선택해 주세요.");
							return;
						}
						
						if(node.id == 'group'){
    						alert("최상위 그룹은 삭제가 불가능 합니다.");
    						return;
    					}
						
						var msg = "";
						if(node.parent == 'group'){
							msg = confirm("그룹을 삭제하시겠습니까?");
    					}else{
							msg = confirm("선택한 대상을 삭제하시겠습니까?");
    						
    					}
    					if(msg){
    						
    						// 선택한 삭제될 그룹
    						$.each(idx, function(index, element) {
    							node = $('#add_group_tree').jstree(true).get_node(element);

    							var type = node.data.type;
    							var id = node.id;
    							
    							if(type == 0){	// 삭제 목록이 그룹일경우
									groupArr.push(id);
								} else {		// 삭제 목록이 타겟일 경우
									var position = id.indexOf("_", 0);

									serverArr.push({
										"groupID": id.substring(0, position),
										"serverID": id.substring(position+1)
									});
								}
    							
    							// 선택한 삭제될 그룹의 하위 그룹
    							$.each(node.children, function(index, data) {
    								var nodes = $('#add_group_tree').jstree(true).get_node(data);
    								var types = nodes.data.type;
    								var idxs = nodes.id;
    								
    								if(types == 0){		// 삭제 목록이 그룹일경우
    									groupArr.push(idxs);
    								} 
    							});
    							
    						});
    						
    						var postData = {
   								"groupArr": JSON.stringify(groupArr),
   								"serverArr": JSON.stringify(serverArr),
    						};
    							
							$.ajax({
    							type: "POST",
    							url: "/group/deleteUserCreateGroup",
   								//async : false,
   								data : postData,
   								//dataType: "json",
   							    success: function (resultMap) {
   							    	console.log(resultMap);
   							    	
   							    	if(resultMap.resultCode == -1){
   							    		alert("업데이트 실패하였습니다.")
   					    	    		return;
   					    	    	}

				                	var data = JSON.parse(resultMap.data);
				                	$('#add_group_tree').jstree(true).settings.core.data = data;
				                	$('#add_group_tree').jstree(true).refresh();
				                	
				                	alert("서버/그룹 삭제가 완료되었습니다.")
   							    	
   							    },
   							    error: function (request, status, error) {
   							    	alert("그룹 삭제에 실패하였습니다.");
   							        console.log("ERROR : ", error);
   							    }
   							});
    						
    						console.log(groupArr);
    						console.log(serverArr);
    						
        					//$('#add_group_tree').jstree(true).delete_node(idx);
    					}

						//$("#modGroupPopup").show();
					},
				},
				"mail" : { 
					"separator_before" : false, 
					"separator_after" : true, 
					"label" : "메일 발송", 
					"action" : false,
					"submenu" : {
						"mail1": {
							"separator_before" : false, 
							"separator_after" : true, 
							"label" : "검색요청 메일발송", 
							action : function(obj){
		    					var idx = $('#add_group_tree').jstree('get_selected');
		    					var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
		    					var groupArr = [];
		    					var serverArr = [];
		    					
		    					console.log(node);
		    					console.log("node");
		    					
								if(idx.length < 1){
									alert("그룹을 선택해 주세요.");
									return;
								}
								
								if(node.id == 'group'){
		    						alert("최상위 그룹은 메일 발송이 불가합니다.");
		    						return;
		    					}
								
								var postData = {
									"mailType" : 1
								};
								 	
							 	$.ajax({
									type: "POST",
									url: "/mail/serverGroupMailContent",
										//async : false,
									data : postData,
									//dataType: "json",
								    success: function (resultMap) {
								    	console.log(resultMap);
								    	
								    	
										$("#mailType").val("1");		   							    	
										$("#mailTitle").val(resultMap.title);		   							    	
										$("#mailContentHidden").html(resultMap.SK_title_con);		   							    	
										$("#mailContent").val($("#mailContentHidden").text());		   							    	
								    },
								    error: function (request, status, error) {
								    	/* alert("메일 발송에 실패하였습니다.");*/
								        console.log("ERROR : ", error); 
								    }
								});
							 	$("input:checkbox[name='receiveUser']").prop("checked", true); 
							 	
						 		$("#btnModify").click(function(){
						 			
						 			var postData = {
								 		template_con : $("#mailContent").val(),
							 	   		"mailType" : 1
							 	   	};
						 			
						 			$.ajax({
						 	  			type: "POST",
						 	   			url: "/mail/templateInsert",
						 	  			async : false,
						 	   			data : postData,
						 	   		    success: function (resultMap) {
						 	   		        if (resultMap.resultCode != 0) {
						 	   			        alert("수정 실패 : " + resultMap.resultMessage);
						 	   			    } else if (resultMap.resultCode == 0) {
						 	   			    	alert("수정 성공");
						 	   			    }
						 	   		    },
						 	   		    error: function (request, status, error) {
						 	   				alert("ERROR : " + error);
						 	   		    }
						 	   		});
						 		 		
						 		});
							 	
							 	$("#mailPopTitle").text("검색요청 메일 발송");
								$("#sendMalDetail").show();
							},
						}
						,"mail2": {
							"separator_before" : false, 
							"separator_after" : true, 
							"label" : "검색 시행안내 메일발송",
							"_disabled": function (obj) { 
								var idx = $('#add_group_tree').jstree('get_selected');
		    					var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
		    					
		    					if(node.parent == "group"){
		    						return false; 
		    					}else{
		    						return true;
		    					}
				            },
							action : function(obj){
								var idx = $('#add_group_tree').jstree('get_selected');
		    					var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
		    					var groupArr = [];
		    					var serverArr = [];
		    					
		    					console.log(node);
		    					console.log("node");
		    					
								if(idx.length < 1){
									alert("그룹을 선택해 주세요.");
									return;
								}
								
								if(node.id == 'group'){
		    						alert("최상위 그룹은 메일 발송이 불가합니다.");
		    						return;
		    					}
								
								var postData = {
									"mailType" : 2
								};
								 	
							 	$.ajax({
									type: "POST",
									url: "/mail/serverGroupMailContent",
										//async : false,
									data : postData,
									//dataType: "json",
								    success: function (resultMap) {
								    	console.log(resultMap);
								    	
								    	$("#mailType").val("2");
										$("#mailTitle").val(resultMap.title);		   							    	
										$("#mailContentHidden").html(resultMap.SK_title_con);		   							    	
										$("#mailContent").val($("#mailContentHidden").text());		   							    	
								    },
								    error: function (request, status, error) {
								    	/* alert("메일 발송에 실패하였습니다.");*/
								        console.log("ERROR : ", error); 
								    }
								});
							 	
							 	$("input:checkbox[name='receiveUser']").prop("checked", true);
							 	
								$("#btnModify").click(function(){
						 			
						 			var postData = {
								 		template_con : $("#mailContent").val(),
							 	   		"mailType" : 2
							 	   	};
						 			
						 			$.ajax({
						 	  			type: "POST",
						 	   			url: "/mail/templateInsert",
						 	  			async : false,
						 	   			data : postData,
						 	   		    success: function (resultMap) {
						 	   		        if (resultMap.resultCode != 0) {
						 	   			        alert("수정 실패 : " + resultMap.resultMessage);
						 	   			    } else if (resultMap.resultCode == 0) {
						 	   			    	alert("수정 성공");
						 	   			    }
						 	   		    },
						 	   		    error: function (request, status, error) {
						 	   				alert("ERROR : " + error);
						 	   		    }
						 	   		});
						 		 		
						 		});
							 	
							 	$("#mailPopTitle").text("검색 시행안내 발송");
								$("#sendMalDetail").show();
							},
						}
						
					}
				}
			} 
		},
		'search': {
	        'case_insensitive': false,
	        'show_only_matches' : true,
	        "show_only_matches_children" : true
	    },
		'plugins' : [ 
			"contextmenu",
			"search",
			"types",
			"unique",],
	})
    .bind('select_node.jstree', function(evt, data, x) {
    	var id = data.node.id;
    	//var type = data.node.data.type;
    	var ap = data.node.data.ap;
    	var name =  data.node.text;
    	//$('#jstree').jstree(true).refresh();
    	
    });
	
	
	$('#btnSave').click(function(){
		var idx = $('#add_group_tree').jstree('get_selected');
		var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
		var assetnosch = [];
		var groupArr = [];
		var serverArr = [];
		
		var obj = $("[name=receiveUser]");        
		var chkArray = new Array(); 
		$('input:checkbox[name=receiveUser]:checked').each(function() {
			chkArray.push(this.value); 
		});  

		var detailCon  = $("#mailContent").val().trim().replace(/\n\r?/g,"\n<br>")  ;
	 	
	 	$.each(idx, function(index, element) {
			node = $('#add_group_tree').jstree(true).get_node(element);
			// 그룹 선택 시
			if(node.parent == "group"){
				$.each(node.children, function(index, data) {
					id = node.children[index].split("_");
					if(id[1] != null){
						assetnosch.push(id[1]);
					}
					
				});
				
			}else{ // 타겟 선택 시
				id = node.id.split("_");
				assetnosch.push(id[1]);
			}
		});
	 	
	 	if(chkArray.length == 0){
			alert("수신자가 지정되지 않았습니다.");
			return;
		}
		
		if($("#mailTitle").val() == null || $("#mailTitle").val() == ""){
			alert("제목을 입력해주세요.");
			return;
		}
		if($("#mailContent").val() == null || $("#mailContent").val() == ""){
			alert("내용을 입력해주세요.");
			return;
		}
	 	
	 	var postData = {
			"assetnosch": JSON.stringify(assetnosch),
			"detailCon" : detailCon,
			"mailTitle" : $("#mailTitle").val(),
			"mailType" : $("#mailType").val(),
			"receiveUser" : JSON.stringify(chkArray),
		};
	 		
		 var send_msg = confirm("메일 발송 하시겠습니까?");
		 	
		if(send_msg){
			
		 	$.ajax({
				type: "POST",
				url: "/mail/serverGroupMail",
					//async : false,
					data : postData,
					//dataType: "json",
				    success: function (resultMap) {
				    	console.log(resultMap);
					    	
				        if (resultMap.resultCode != 0) {
					        alert(resultMap.resultMessage);
					        return;
					    } 
					        
						if (resultMap.resultCode == 0) {
					    	alert(resultMap.resultMessage);
					    }
						
						$("#mailContent").val("");
	                	$("#mailTitle").val("");
	                	$("#mailContentHidden").val("")
	                	$("#sendMalDetail").hide();
	               	
				    },
				    error: function (request, status, error) {
				    	alert("메일 발송에 실패하였습니다.");
				        console.log("ERROR : ", error);
				    }
			}); 
		}
	 		
	});
	
	/* $('#btnSave').click(function(){
		var sdfds  = "</p><p>"+ $("#mailContent").val().trim().replace(/\n\r?/g,"</p><p>") +"</p>";
		
		console.log($("#mailContent").val());
		console.log(sdfds);
		
		
		
	}); */
	
	//선택 그룹 초기화
	$('#selTargetReset').click(function(){
		$('#group_tree').jstree().uncheck_all(true);
	});
	
	var treeArr = [];
	
	// 그룹이동
    $('#movTargetGrp').click(function(){
    	treeArr = [];
    	var selectTarget = $("#add_target").children("tr");
    	
    	if(selectTarget.length == 0){
    		alert("그룹 이동을 할 서버를 선택해주세요.");
    		return;
    	}
    	
		
		$.each(selectTarget, function(idx, element) {
			var id = $(element).data("treeid");
			treeArr.push(id);
		});
		
		$('#group_id').val(treeArr);
    	
    	$('#groupChangePopup').show();
    	
    });

	//그룹 이동 저장
	$('#btnGroupChangeSave').click(function(){
		var selectTarget = $("#add_target").children("tr");	
		console.log(treeArr);
		// 그룹이동 아이디
		var group_id = $("#selGroup option:selected").val();
		
		$('#groupChangePopup').hide();
		
		$.ajax({
			type: "POST",
			url: "/group/moveTargetGroup",
			//async : false,
			data : {
				group_id: group_id,
				treeArr: JSON.stringify(treeArr)
			},
		    success: function (resultMap) {
		    	console.log(resultMap);
		    	
		    	if(resultMap.resultCode == -1){
    	    		return;
    	    	}
		    	
    	    	var data = JSON.parse(resultMap.data);
    	    	$('#group_tree').jstree(true).settings.core.data = data;

    			$('#group_tree').jstree().uncheck_all(true);
    	    	$('#group_tree').jstree(true).refresh();
    	    	
    	    	treeArr = [];
		    },
		    error: function (request, status, error) {
		    	alert("그룹 변경 실패하였습니다.");
		        console.log("ERROR : ", error);
		        treeArr = [];
		    }
		});
	});
	
	// 그룹이동
    $('#movNotTargetGrp').click(function(){
    	treeArr = [];
    	$.each($("#not_group_tree").jstree("get_checked",true),function(){
    		var type = this.data.type;
    		
    		if(type == 1){
    			treeArr.push(this.id);
    		}
    	});
    	
    	if(treeArr.length == 0){
    		alert("그룹 이동을 할 서버를 선택해주세요.");
    		return;
    	}
    	

		$('#group_id').val(treeArr);
    	$('#groupChangePopup').show();
    	
    });
	
	
	// 그룹 이동 취소
	$('#btnGroupChangeCancel').click(function(){
		$('#groupChangePopup').hide();
	});
	
	$('#btnCancleGroupChangePopup').click(function(){
		$('#groupChangePopup').hide();
	});
    
    $('#addTarget').click(function(){
    	treeArr = [];
    	var groupArr = [];
    	var selectTarget = $("#add_target").children("tr");
    	
    	if(selectTarget.length == 0){
    		alert("그룹 이동을 할 서버를 선택해주세요.");
    		return;
    	}
    	
		// 서버 선택 아이디 추가
		$.each(selectTarget, function(idx, element) {
			var id = $(element).data("treeid");
			treeArr.push(id);
		});
    	
		var idx = $('#add_group_tree').jstree('get_selected');
		var node = $('#add_group_tree').jstree(true).get_node(idx[0]);
    	
    	if(node.id == 'group'){
			alert("최상위 그룹에 추가는 불가능 합니다.");
			return;
		}
		if(idx.length < 1){
			alert("그룹을 선택해 주세요.");
			return;
		}
		
		// 서버가 추가될 선택한 그룹
		$.each(idx, function(index, element) {
			node = $('#add_group_tree').jstree(true).get_node(element);
			var name = node.text;
			var type = node.data.type;
			
			if(type == 0){
				groupArr.push(node.id);
			}
		});
		
		console.log(groupArr);
		
		var msg = confirm(groupArr.length + "개의 그룹에 저장하시겠습니까?");
		
		if(msg){
			$.ajax({
				type: "POST",
				url: "/group/insertUserTargets",
				//async : false,
				data : {
					"groupArr": JSON.stringify(groupArr),
					"treeArr": JSON.stringify(treeArr)
				},
			    success: function (resultMap) {
			    	console.log(resultMap);
			    	
			    	if(resultMap.resultCode == -1){
	    	    		return;
	    	    	}
			    	
	    	    	var data = JSON.parse(resultMap.data);
	    	    	$('#add_group_tree').jstree(true).settings.core.data = data;
	    	    	$('#add_group_tree').jstree(true).refresh();
	    	    	
	    	    	treeArr = [];
	    	    	groupArr = [];
			    },
			    error: function (request, status, error) {
			    	alert("서버 저장이 실패하였습니다.");
			        console.log("ERROR : ", error);
			        treeArr = [];
	    	    	groupArr = [];
			    }
			});
		}
		
    });
    
});

/* 자산현황 호스트 검색 시작 */
var to = true;
$('#assetHostsBtn').on('click', function(){
    var v = $('#assetHostsSeach').val();
	
	if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#group_tree').jstree(true).search(v);
    }, 250);
});

$('#assetHostsSeach').keyup(function (e) {
	var v = $('#assetHostsSeach').val();
	if (e.keyCode == 13) {
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#group_tree').jstree(true).search(v);
        }, 250);
    }
});
/* 자산현황 호스트 검색 종료 */

$('#btnClose').on('click', function(){
    $("#mailTitle").val("");
    $("#mailContentHidden").val("");
    $("#mailContent").val("");
    
    $("#sendMalDetail").hide();
    
});

$('#btnCancleSendMailDetail').on('click', function(){
    $("#mailTitle").val("");
    $("#mailContentHidden").val("");
    $("#mailContent").val("");
    
    $("#sendMalDetail").hide();
    
});
/* 사용자 그룹 검색 시작 */
var to = true;
$('#userGroupBtn').on('click', function(){
    var v = $('#userGroupSearch').val();
	
	if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#add_group_tree').jstree(true).search(v);
    }, 250);
});

$('#userGroupSearch').keyup(function (e) {
	var v = $('#userGroupSearch').val();
	if (e.keyCode == 13) {
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#add_group_tree').jstree(true).search(v);
        }, 250);
    }
});
/* 사용자 그룹 검색 종료 */

function fn_search() {
	var host = $("#txt_host").val();
	
	if(host != null && host != ''){
		getSearchData(host);
	} else {
		$("#div_all").show()
		$("#div_search").hide()
	}
}

 

function fnCheckRemove(element) {
	var locationTR = $(element).parent("td").parent("tr")[0];
	var id = locationTR.id.substring(3);
	
	// remove 클릭시 jstree 체크박스 해제
	$('#group_tree').jstree("uncheck_node", id);
	$(locationTR).remove();
}
</script>
<style>
.ui-icon-pencil, .ui-icon-plusthick, .ui-icon-minusthick{
	cursor:pointer;
}
</style>
</body>
</html>