<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta charset="utf-8">
<title>개인정보검출 상세정보</title>

<link href="${pageContext.request.contextPath}/resources/assets/css/ui.fancytree.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/resources/assets/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

<!-- Publish JS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-3.3.1.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/jquery-ui-PIC.js" type="text/javascript"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.ui-deps.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/tree/jquery.fancytree.js"></script>

<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/jqgrid/i18n/grid.locale-kr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/assets/js/wickedpicker.js"></script>

<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/assets/css/wickedpicker.min.css" />

<!-- Application Common Functions  -->
<script type="text/ecmascript" src="${pageContext.request.contextPath}/resources/assets/js/common.js"></script>

<!-- Publish CSS -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/reset-PIC.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/assets/css/design-PIC.css" />

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
		#bodyContents{
			height: 315px !important;
		}
		#matchData{
			height: 265px !important;
		}
	}
</style>
<body>
	<div class="wrap" style="min-height: 364px !important;">
		<!-- 팝업창 시작 개인정보검출 상세정보 -->
		<%
		String browser = "";
		String userAgent = request.getHeader("User-Agent");
		
		%>
		
		<!-- 팝업창 시작 하위 로케이션 상세정보 -->
		<%
		if (userAgent.indexOf("Trident") > 0 || userAgent.indexOf("MSIE") > 0) {
		%>
			<div id="taskWindow" style="position:absolute; touch-action: none; width: 100%; height: 95%; z-index: 999; min-width: 30%; min-height: 200px; background: #f9f9f9;" class="ui-widget-content">
			<table class="mxWindow" style="position: absolute; left: 15px; width: 97%; height: 100%;">
			<tbody>
				<tr>
					<td class="mxWindowTitle" style="touch-action: none; background: #fff; padding: 0;">
						<table style="width: 100%; height: 36px;">
							<colgroup>
								<col width="*">
								<col width="30px">
							</colgroup>
							<tr>
								<td style="color: #000; text-align: left; background: #f9f9f9;">
									<h2 style="width: 1110px;">개인정보검출 상세정보</h2>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="mxWindowPane">
						<div class="mxWindowPane" style="width: 100%;height: 100%;">
							<table style="width: 100%;height: 100%;">
							<tbody>
								<tr>
									<td id="matchCount" style="background: #fff; width: 245px; min-width: 245px; max-width: 195px; height: 50px; padding: 5px; border: 1px solid #c8ced3;">&nbsp;</td>
									<td style="width: 100%; height: 100%; border: 1px solid #c8ced3; border-left: none;" rowspan="2">
										<div id="bodyContents" style="background: #fff; overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
									</td>
								</tr>
								<tr>
									<td style="border: 1px solid #c8ced3; border-top: none;">
										<div id="matchData" style="background: #fff; overflow-y:auto;height: 100%; padding: 5px;">&nbsp;</div>
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
		<div id="taskWindow" style="position:absolute; touch-action: none; width: 100%; height: 95%; z-index: 999; min-width: 30%; min-height: 200px; background: #f9f9f9;" class="ui-widget-content">
			<table class="mxWindow" style="position: absolute; left: 15px; width: 97%; height: 100%;">
			<tbody>
				<tr>
					<td class="mxWindowTitle" style="touch-action: none; background: #fff; padding: 0;">
						<table style="width: 100%; height: 100%;">
							<colgroup>
								<col width="*">
								<col width="30px">
							</colgroup>
							<tr>
								<td style="color: #000; text-align: left; background: #f9f9f9;">
									<h2 style="width: 1110px;">개인정보검출 상세정보</h2>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="mxWindowPane">
						<div class="mxWindowPane" style="width: 100%;height: 100%;">
							<table style="width: 100%;height: 100%;">
							<tbody>
								<tr>
									<td id="matchCount" style="background: #fff; width: 245px; min-width: 245px; max-width: 195px; height: 50px; padding: 5px; border: 1px solid #c8ced3;">&nbsp;</td>
									<td style="width: 100%; height: 100%; border: 1px solid #c8ced3; border-left: none;" rowspan="2">
										<div id="bodyContents" style="background: #fff; overflow-y:auto;height: 100%; padding: 5px 5px;">&nbsp;</div>
									</td>
								</tr>
								<tr>
									<td style="border: 1px solid #c8ced3; border-top: none;">
										<div id="matchData" style="background: #fff; overflow-y:auto;height: 100%; padding: 5px;">&nbsp;</div>
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
	</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	if('${id}' != null && '${ap_no}' != null && '${id}' != '' && '${ap_no}' != ''){
		setContent('${id}','${tid}', '${ap_no}');
	}
});

function Loading() {
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
     
    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg ='';
     
    loadingImg +=" <div id='loadingImg'>";
    loadingImg +=" <img src='${pageContext.request.contextPath}/resources/assets/images/spinner.gif' style='position:absolute; z-index:9500; text-align:center; display:block; top:20%; left:40%;'/>";
    loadingImg += "</div>";  
 
    $('body')
        .append(mask)
 
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' :'0.3'
    });
    
    $('#mask').show();
  
    $('#taskWindow').append(loadingImg);
    $('#loadingImg').show();
}

function closeLoading() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').remove(); 
}

function setContent(id, tid, ap_no){
	var oPostDt = {
			"id": id, 
			"tid": tid,
			"ap_no": ap_no};
   $.ajax({
       type: "POST",
       url: "/exception/getMatchObjects",
       async : true,
       data : oPostDt,
       success: function (resultMap) {
    	   var matchList = [];
    	   var metasCount = [0,0,0,0,0,0,0,0,0,0];
    	   
           if (resultMap.resultCode != "0") {
               alert(resultMap.resultMessage);
               window.close();
           }
           
           var totalCnt = 0;
           var bodyContents = "";
           var path = resultMap.resultData.path.split("#");
           
           if(path[path.length -1].indexOf("_decrypted") == -1){
        	   path[path.length -1] = path[path.length -1];
	       } else {
	    	   path[path.length -1] = path[path.length -1].replaceAll("_decrypted","");
	       }
           
           bodyContents += "<strong>" + path[path.length -1] + "</strong></br>";
           var metas = resultMap.resultData.metas;
           metas.sort(function(a, b) { // 오름차순
               return a.label < b.label ? -1 : a.label > b.label ? 1 : 0;
           });
           for (var i = 0; i < metas.length; i++) {
               var meta = metas[i];
               
               var metasIndex = -1;
               var metasContent = 0;
               
               if (meta.is_aggregate == true) {
                   var tmp = Number(meta.value);
                   totalCnt = totalCnt + tmp;
                   bodyContents += "<strong>" + meta.label + " : </strong>" + meta.value.format() + "</br>";
               }
               else {
                   bodyContents += "<strong>" + meta.label + " : </strong>" + meta.value + "</br>";
               }
              
               
               // 타입별 검출 건수 표기
               if(meta.label.toUpperCase().indexOf("South Korean RRN".toUpperCase()) > -1){
            	   metasIndex = 0;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("South Korean Foreigner Number".toUpperCase()) > -1){
            	   metasIndex = 1;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("South Korean Passport".toUpperCase()) > -1){
            	   metasIndex = 2;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("South Korean Driver License Number".toUpperCase()) > -1){
            	   metasIndex = 3;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("Phone Number".toUpperCase()) > -1){
            	   metasIndex = 4;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("South Korean Taxpayer Identification Number".toUpperCase()) > -1){
            	   metasIndex = 5;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("South Korean Corporation Registration Number".toUpperCase()) > -1){
            	   metasIndex = 6;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("Account Number".toUpperCase()) > -1){
            	   metasIndex = 7;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("Email".toUpperCase()) > -1){
            	   metasIndex = 8;
            	   metasContent = meta.value;
            	   
               }else if(meta.label.toUpperCase().indexOf("VISA") > -1 || 
                       meta.label.toUpperCase().indexOf("MAESTRO") > -1 || 
                       meta.label.toUpperCase().indexOf("PRIVATE LABEL CARD") > -1 || 
                       meta.label.toUpperCase().indexOf("DINERS CLUB") > -1 || 
                       meta.label.toUpperCase().indexOf("JCB") > -1 || 
                       meta.label.toUpperCase().indexOf("LASER") > -1 || 
                       meta.label.toUpperCase().indexOf("MASTERCARD") > -1 || 
                       meta.label.toUpperCase().indexOf("CHINA UNION PAY") > -1 || 
                       meta.label.toUpperCase().indexOf("DISCOVER") > -1 || 
                       meta.label.toUpperCase().indexOf("TROY") > -1 || 
                       meta.label.toUpperCase().indexOf("AMERICAN") > -1  ){
            	   
            	   metasIndex = 9;
            	   metasContent = meta.value;
               }
               
               if(metasIndex >= 0){
	               metasCount[metasIndex] = parseInt(metasContent); 
               }
               
           }
           
           bodyContents += "</br>";
           if (!isNull(resultMap.resultData.omitted)) {
               var omitted = resultMap.resultData.omitted[0];
               bodyContents += "<i style='color:red;'>" + omitted.length.format() + " bytes omitted</i></br></br>";
           }

           $("#bodyContents").html(bodyContents);
           
           var matchs = resultMap.resultData.matches;
           var chunks = resultMap.resultData.chunks;
           var chunk_check = "<b style='color:red;'>";
           var chunk_check2 = "</b>"
           var match_cnt = 0;
            /* var matchs_content = new Array();
           
           for(var i = 0; i < matchs.length; i++){
           	matchs_content[i] = matchs[i].content;
           }
            
           var matches_cnt = 0;
           
       	   var uniq = matchs_content.reduce(function(a,b){
           	if(a.indexOf(b) < 0) a.push(b);
           	return a;
           },[]);
       	
           for (var i = 0; i < chunks.length; i++) {
               var chunk = chunks[i].content;
           		   matchs_content[i] = matchs[i].content;
           		   
               var content = chunk.split("\n");
               
               for(var j=0; j<content.length; j++){
               	var text = content[j];
               	
               	for(var k=0; k<uniq.length; k++){
                 	//text = text.replaceAll(uniq[k], "" + chunk_check + uniq[k] + chunk_check2);
                	text = text.replace(new RegExp(String(uniq[k]).replace("+","\\+"),'gi'), "" + chunk_check + String(uniq[k]).replace("+","\+") + chunk_check2);
                	//text = chunk_check + matchs_content[i] + chunk_check2;
                }
               	///////////////////////////////////////////////////////
               	if(text.indexOf(chunk_check) > -1) {
               		
               		var flag = true;
               		while(flag){
                		$("#bodyContents").append( document.createTextNode( text.substr( 0, text.indexOf(chunk_check) ) ) );
                		text = text.substr( text.indexOf(chunk_checktext) );
                		$("#bodyContents").append( text.substr( 0, ( text.indexOf(chunk_check2)+chunk_check2.length ) ) );
                		text = text.substr( (text.indexOf(chunk_check2) + chunk_check2.length) );
               			
               			if(text.indexOf(chunk_check) < 0){
               				$("#bodyContents").append( document.createTextNode(text) );
               				flag = false;
               			}
               		}
                   	$("#bodyContents").append('</br>');
                   	
               	} else {
               	
               		$("#bodyContents").append(document.createTextNode(text));
                   	$("#bodyContents").append('</br>'); 
               	}
               	
               }
           }  */
           
           /*
               신용카드 : Type1 - like 아래 이외의 기타...
               주민등록번호 : Type2 - like South Korean RRN
               외국인등록번호 : Type3 - like South Korean Foreigner Number
               여권번호 : Type4 - like South Korean Passport
               운전면허 번호 : Type5 - like South Korean Driver License Number
               전화/휴대폰 : Type6 - like South Korean Phone Number
               사업자등록번호 : Type7 - like South Korean Taxpayer Identification Number
               법인등록번호 : Type8 - like South Korean Corporation Registration Number
               계좌번호 : Type9 - like Account Number
           */
           var matchData = "";
           if(resultMap.resultData.matches != null){
        	   matchData = "National ID (" + resultMap.resultData.matches.length + ")</br>";
           }
           var matchType = ["주민등록번호","외국인등록번호","여권번호","운전면허 번호","전화/휴대폰","사업자등록번호","법인등록번호","계좌번호","이메일","신용카드","기타"];
           var matchCount = [0,0,0,0,0,0,0,0,0,0,0];
           var matchContents = ["","","","","","","","","","",""];
          
           
           var content_cnt = 0;
           var mask_content = "";
           var result_content;
           
           if(chunks != null) {
        	   result_content = new Array(chunks.length);
        	   

               for(var i = 0; i < chunks.length; i++){
            	   var mask_chunks = chunks[i];
            	   var chunk_offset = chunks[i].offset;
            	   var chunk_length = chunks[i].length;
            	   
            	   result_content[i] = chunks[i].content;
            	   for(content_cnt; content_cnt < matchs.length; content_cnt++){
            		   var content_offset = matchs[content_cnt].offset;
            		   var check_offset = (parseInt(chunk_offset) <= parseInt(content_offset)) && (parseInt(content_offset) <= (parseInt(chunk_offset) + parseInt(chunk_length)));
            		   
                 		
            		   if(check_offset) {
            			   var con_length = matchs[content_cnt].length;
            			   var pi_detection = matchs[content_cnt].content;
            			   
            			   var matchIndex = -1;
                           var data_type = matchs[content_cnt].data_type;
                           var mask_content = "";
            			   
            			   
            			    if (data_type.toUpperCase().indexOf("South Korean RRN".toUpperCase()) > -1){
                         	    matchIndex = 0;
                         	    // mask_content = pi_detection.substring(0, con_length-6) + "######";
                         	   if(con_length == 14){
                        	     mask_content = pi_detection.substring(0, con_length-12) + "####-" + pi_detection.substring(con_length-6, con_length-7) + "######";
                        	   }else{
	                         	 mask_content = pi_detection.substring(0, con_length-11) + "####" + pi_detection.substring(con_length-6, con_length-7) + "######";
                        	   }
                         	   
                            }
                            else if (data_type.toUpperCase().indexOf("South Korean Foreigner Number".toUpperCase()) > -1){
                         	    matchIndex = 1;
                          	    // mask_content = pi_detection.substring(0, con_length-6) + "######";
                         	   if(con_length == 14){
                          	     mask_content = pi_detection.substring(0, con_length-12) + "####-" + pi_detection.substring(con_length-6, con_length-7) + "######";
                          	   }else{
  	                         	 mask_content = pi_detection.substring(0, con_length-11) + "####" + pi_detection.substring(con_length-6, con_length-7) + "######";
                          	   }
                            }
                            else if (data_type.toUpperCase().indexOf("South Korean Passport".toUpperCase()) > -1){
                         	    matchIndex = 2;
                           	    mask_content = pi_detection.substring(0, con_length-4) + "####";
                            }
                            else if (data_type.toUpperCase().indexOf("South Korean Driver License Number".toUpperCase()) > -1){
                         	    matchIndex = 3;
    						    mask_content = pi_detection.substring(0, con_length-6) + "######";
                            }
                            else if (data_type.toUpperCase().indexOf("Phone Number".toUpperCase()) > -1){
                         	   	matchIndex = 4;
    							// mask_content = pi_detection.substring(0, con_length-4) + "####";
                         	    mask_content = maskString(pi_detection, con_length);
                            }
                            else if (data_type.toUpperCase().indexOf("South Korean Taxpayer Identification Number".toUpperCase()) > -1){
                         	    matchIndex = 5;
                             	mask_content = pi_detection.substring(0, con_length-4) + "####";
                            }
                            else if (data_type.toUpperCase().indexOf("South Korean Corporation Registration Number".toUpperCase()) > -1){
                         	   	matchIndex = 6;
                            	mask_content = pi_detection.substring(0, con_length-4) + "####";
                            }
                            else if (data_type.toUpperCase().indexOf("Account Number".toUpperCase()) > -1){
                         	   	matchIndex = 7;
                            	// mask_content = pi_detection.substring(0, con_length-6) + "######";
                         	    mask_content = maskString(pi_detection, con_length);
                            }
                            else if (data_type.toUpperCase().indexOf("Email".toUpperCase()) > -1){
                         	   	matchIndex = 8;
                         	   	mask_content = maskString(pi_detection, con_length);
                         	   	/* var mail_chk = pi_detection.indexOf("@");
                         	   	
                         	   if (!String.prototype.repeat) {
                         		  String.prototype.repeat = function(count) {
                         		    'use strict';
                         		    if (this == null) {
                         		      throw new TypeError('can\'t convert ' + this + ' to object');
                         		    }
                         		    var str = '' + this;
                         		    count = +count;
                         		    if (count != count) {
                         		      count = 0;
                         		    }
                         		    if (count < 0) {
                         		      throw new RangeError('repeat count must be non-negative');
                         		    }
                         		    if (count == Infinity) {
                         		      throw new RangeError('repeat count must be less than infinity');
                         		    }
                         		    count = Math.floor(count);
                         		    if (str.length == 0 || count == 0) {
                         		      return '';
                         		    }
                         		    // Ensuring count is a 31-bit integer allows us to heavily optimize the
                         		    // main part. But anyway, most current (August 2014) browsers can't handle
                         		    // strings 1 << 28 chars or longer, so:
                         		    if (str.length * count >= 1 << 28) {
                         		      throw new RangeError('repeat count must not overflow maximum string size');
                         		    }
                         		    var maxCount = str.length * count;
                         		    count = Math.floor(Math.log(count) / Math.log(2));
                         		    while (count) {
                         		       str += str;
                         		       count--;
                         		    }
                         		    str += str.substring(0, maxCount - str.length);
                         		    return str;
                         		  }
                         		}
                         	   	
                         	   	if(mail_chk > 2){
                         	   //	if(mail_chk != -1){	
                               		mask_content = pi_detection.substring(0, 2) + "#".repeat(mail_chk-2) + pi_detection.substring(mail_chk, con_length);
                         	   	} else {
                         	   		mask_content = pi_detection;
                         	   	} */
                            }
                            else if (
                                  data_type.toUpperCase().indexOf("VISA") > -1 || 
                                  data_type.toUpperCase().indexOf("MAESTRO") > -1 || 
                                  data_type.toUpperCase().indexOf("PRIVATE LABEL CARD") > -1 || 
                                  data_type.toUpperCase().indexOf("DINERS CLUB") > -1 || 
                                  data_type.toUpperCase().indexOf("JCB") > -1 || 
                                  data_type.toUpperCase().indexOf("LASER") > -1 || 
                                  data_type.toUpperCase().indexOf("MASTERCARD") > -1 || 
                                  data_type.toUpperCase().indexOf("CHINA UNION PAY") > -1 || 
                                  data_type.toUpperCase().indexOf("DISCOVER") > -1 || 
                                  data_type.toUpperCase().indexOf("TROY") > -1 || 
                                  data_type.toUpperCase().indexOf("AMERICAN") > -1  
                               ){
                                matchIndex = 9;

                             	// mask_content = pi_detection.substring(0, con_length-6) + "######";
                                mask_content = maskString(pi_detection, con_length);
                            }
                            else  matchIndex = 10;
            			    
            			    //mask_content = chunk_check + mask_content + chunk_check2;
                            //result_content[i] = result_content[i].replaceAll(matchs[content_cnt].content, mask_content);
                            result_content[i] = result_content[i].replace(new RegExp(String(matchs[content_cnt].content).replace("+","\\+"),'gi'), "" + chunk_check + String(mask_content).replace("+","\+") + chunk_check2);

                            matchCount[matchIndex] = matchCount[matchIndex] + 1; 
                            
                           	matchContents[matchIndex] = matchContents[matchIndex] + mask_content + "</br>";

                            if (i > 999) break; 
            		   } else {
            			   break;
            		   }
            		   
            	   }
            	   
               } 
               
               for (var i = 0; i < result_content.length; i++) {
   				var content = result_content[i].split("\n");
      	   
   				 for(var j=0; j< content.length; j++){
   					
   					var text = content[j];
   					
      		   			if(text.indexOf(chunk_check) > -1) {
               			var flag = true;
               			while(flag){
   		             		$("#bodyContents").append( document.createTextNode( text.substr( 0, text.indexOf(chunk_check) ) ) );
   		             		text = text.substr( text.indexOf(chunk_check) );
   		             		$("#bodyContents").append( text.substr( 0, ( text.indexOf(chunk_check2)+chunk_check2.length ) ) );
   		             		text = text.substr( (text.indexOf(chunk_check2) + chunk_check2.length) );
               			
               				if(text.indexOf(chunk_check) < 0){
               					$("#bodyContents").append( document.createTextNode(text) );
               					flag = false;
               				}
               			}
                   		$("#bodyContents").append('</br>');
                   	
               		} else {
               			$("#bodyContents").append( document.createTextNode(text) );
               			$("#bodyContents").append('</br>');
               			 
               		}
    	   			} 
   			}
           } else {
        	   $("#bodyContents").append("<b style='color:blue;'>Remaining data truncated</b>");
           }
           

           if (totalCnt == 1) $("#matchCount").html(totalCnt.format() + " Match");
           else $("#matchCount").html(totalCnt.format() + " Matches");
           
           var matchData = "<ul>";
           

           for (var i = 0; i < matchType.length; i++) {
        	   if (metasCount[i] > 0) {
					matchData += "<li class='matchTypeList'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>";
					matchData += matchType[i] + "(" + metasCount[i].format() + ")" + "</a>";
					
					matchData += "<ul style='padding: 0px 3px 3px 3px; display:none'><li style='margin-left: 20px;'>" + matchContents[i] ;
					
					if(matchCount[i] < metasCount[i]){
						matchData += "<img style='vertical-align: middle; padding-left: 5px; padding-bottom: 4px;' src='${pageContext.request.contextPath}/resources/assets/images/alert.png'>";
						matchData += "<span style='padding-left: 2px !important; display: inline-block; margin-top: 5px;'>+" + (metasCount[i] - matchCount[i]).format() +" more</span></li>";
					}
					matchData += "</li></ul></li>";
        	   }
           }
           
			/* for (var i = 0; i < matchType.length; i++) {
			    if (matchCount[i] == 0) continue;
			    matchData += "<li class='matchTypeList'><a href='javascript:void(0)'><img style='margin-right: 3px; margin-bottom: 3px;' src='${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png'>";
			    if (matchs.length > 1000)
			        matchData += matchType[i] + "(" + matchCount[i].c() + "+)" + "</a>";
			    else 
			        matchData += matchType[i] + "(" + matchCount[i].format() + ")" + "</a>";
			        
			    matchData += "<ul style='padding: 0px 3px 3px 3px; display:none'><li style='margin-left: 20px;'>" + matchContents[i] + "</li></ul></li>";
			}  */

           /* if (totalCnt > 1000) {
               matchData += "<li style='padding-top: 3px;'><img style='vertical-align: middle;padding-left: 5px;' src='${pageContext.request.contextPath}/resources/assets/images/alert.png'>";
               matchData += "<span style='padding-left: 12px !important;'>+" + (totalCnt - 1000).format() +" more</span></li>";
           } */
           matchData += "</ul>"
               
           $("#matchData").html(matchData);
           $(".matchTypeList>a").click(function() {
               if ($(this).next('ul').is(':visible')) {
                   $(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_deactive.png');
                   $(this).next('ul').hide();
               } else {
                   $(this).children("img").attr("src", '${pageContext.request.contextPath}/resources/assets/images/arrow_active.png');
                   $(this).next('ul').show();
               }
           });

           $("#taskWindow").show();
       },
       beforeSend: function(){
    	   Loading();
       },
       complete: function () {
    	   closeLoading();
       },
       error: function (request, status, error) {
           alert("Recon Server에 접속할 수 없습니다.");
       }
   });
}

// 23.04.19 앞 4자리 제외 전체 마스킹
function maskString(str, end) {
  const prefix = str.substring(0, 4);
  const maskedLength = end - 4;
  const mask = '#'.repeat(maskedLength);
  return prefix + mask + str.substring(end);
}
</script>
</html>
