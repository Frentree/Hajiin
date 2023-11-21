<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>범위 조회</title>

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<%-- <script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js" type="text/javascript"></script> --%>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jstree.min.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/style.min.css" />

</head>
<%@ include file="../../include/session.jsp"%>
<style>
   body{
      width: auto;
   }
   @media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
      body{
         width: auto !important;
      }
   }
</style>
<body>
   <div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c;  background: #f9f9f9;  width: 100%;">
     <div class="step_content_cell fl_l padd_r" style="width: 95%; height: 523px; max-height: 80%; overflow-y: auto; margin-left: 25px;">
     
         <div class="select_location sch_left" style="height: 50px; min-height: 50px;background: #fff; border-bottom: 0px; border-radius: 0;">
             <div style="position: absolute; right: 10px; top: 10px; padding-top: 0px; font-size: 14px; font-weight: bold;">
             <span id="sch_txt">그룹명 : </span><input type="text" id="searchHost" value="" class="edt_sch" style="width: 263px; margin-bottom: 3px;">
             <button id="btnSearch" class="btn_sch">검색</button>
             </div>
         </div>
         <div id="div_all" class="select_location" style="overflow-y: auto; width: 100%; height: 440px;background: #ffffff; border-radius: 0;">
             <div id="groupJstree">
             </div>
         </div>
         <div id="div_search" class="select_location" style="overflow-y: auto; height: 460px;background: #ffffff; display: none;">
             <table id="Tbl_search" class="tbl_input" id="location_table">
                 <tbody>
                 </tbody>
             </table>
         </div>
     </div>
     <div class="popup_btn">
         <div id="netChkBtn" class="btn_area" style="display: inline-block; padding: 0; margin-top: 0; margin-right: 25px; float: right;">
             <button type="button" id="btnNewPopupSave" >저장</button>
             <button type="button" id="btnNewPopupCencel" >취소</button>
         </div>
     </div>
   </div>
</body>
<script type="text/javascript">
var netid = "${netid}";
var netType = "${netType}";

$(function(){
   var netcheck = [];
   if(netid==3){
      netcheck = ["checkbox","search"];
   }else{
      netcheck = ["search"];
   }
   
   $('#groupJstree').jstree({
      // List of active plugins
      "core" : {
          "animation" : 0,
          "check_callback" : true,
         "themes" : { "stripes" : false },
         "data" : ${policyNetList},
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
      'plugins' : netcheck,
   }).bind("loaded.jstree", function(evt, data, x) { 
	   $("#groupJstree").jstree("open_node", "pc");
   }).bind('select_node.jstree', function(evt, data, x) {
	   
   }).bind("dblclick.jstree", function (event) {
      
      if(netid != 3){
         var node = $(event.target).closest("li");
         var data = node.data("jstree"); 
         var js_node = $('#groupJstree').jstree(true).get_node(node[0].id);
   
         // Do some action
         var name = js_node.data.name;
         var id = node[0].id;
         var target = js_node.original.target;
         var type = js_node.data.type;
         
         if(type != 99){
            if(netType == "insert"){ // 신규 정책 생성
               $(opener.document).find("#rangeNm").val(name);
               $(opener.document).find("#rangeId").val(id);
               $(opener.document).find("#targetId").val(target);
               $(opener.document).find("#rangeType").val(type);
            }else if(netType == "update"){ // 정책 업데이트
               $(opener.document).find("#updateRangeNm").val(name);
               $(opener.document).find("#updateRangeId").val(id);
               $(opener.document).find("#updateRangeTargetId").val(target);
               $(opener.document).find("#updateRangeType").val(type);
            }else if(netType == "SKTManager"){ // 중간관리자 관리
               $(opener.document).find("#pcAdminTeam").val(name);
               $(opener.document).find("#pcAdminTeamCode").val(id);
            }
            window.close();
         }
      }
    });
});

$(document).ready(function () {
   
   if(netid == 0){
      $("#sch_txt").html("네트워크명 : ");
      $("#netChkBtn").hide();
   }else if(netid == 1){
      $("#sch_txt").html("그룹명 : ");
      $("#netChkBtn").hide();
   }else if(netid == 2){
      $("#sch_txt").html("PC명 : ");
      $("#netChkBtn").hide();
   }else if(netid == 3){
      $("#sch_txt").html("OneDrive명 : ");
   }
});

$("#btnNewPopupSave").click( function(e) {
   
   if($("#groupJstree").jstree("get_checked",true).length == 0 ){
       alert("정책 대상을 선택해주세요.");
       return;
    };
   

   var nameCNT = 0;
   var name = "";
   var name2 =""; 
   var id = "" ;
   var type = 1;
   var target_id = "";
   
   $.each($("#groupJstree").jstree("get_checked",true),function(){
      var js_node = this;
      
      target_id = js_node.original.target;
      
      var resultName = js_node.data.name;
      
      var getByteLengthOfString = function(s,b,i,c){
          for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
          return b;
      };
      
      var nameByte = getByteLengthOfString(resultName);
      
      if(nameByte > 50){
         var idx = resultName.indexOf("/");
         var resultNameSplit = resultName.substring(idx + 1, idx + 22);
         resultName = resultNameSplit +  "...";
      }else{
         resultName = resultName;
      }
      
      if(name == ""){
         name = js_node.data.name;
         name2 = resultName;
         id = js_node.id;
         nameCNT = 0;
      }else {
         name2 += "," + resultName;
         id  += "," + js_node.id;
         ++nameCNT;
      }
   });
   
   if(nameCNT > 0){
      name = name + "외 "+ nameCNT + "건";
   }
   
   if(netType == "insert"){ // 신규 정책 생성
      $(opener.document).find("#rangeNm").val(name);
      $(opener.document).find("#rangeOneDriveNm").val(name2);
         $(opener.document).find("#rangeId").val(id);
         $(opener.document).find("#targetId").val(target_id);
         $(opener.document).find("#rangeType").val(type);
      
   }else if(netType == "update"){ // 정책 업데이트
      $(opener.document).find("#updateRangeNm").val(name);
      $(opener.document).find("#updateOneDriveRangeNm").val(name2);
         $(opener.document).find("#updateRangeId").val(id);
         $(opener.document).find("#updateRangeTargetId").val(target_id);
         $(opener.document).find("#updateRangeType").val(type);
   }
   
   window.close();
   
});

$("#btnNewPopupCencel").click( function(e) {
   window.close();
});


// 검색
var to = true;
$("#btnSearch").click( function(e) {
   var searchHost = $('#searchHost').val();
   console.log(searchHost);
   
   if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#groupJstree').jstree(true).search(searchHost);
    }, 250);
});   

$('#searchHost').keyup(function (e) {
   var searchHost = $('#searchHost').val();
   if (e.keyCode == 13) {
      
      if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#groupJstree').jstree(true).search(searchHost);
        }, 250);
    }
});

</script>
</html>
