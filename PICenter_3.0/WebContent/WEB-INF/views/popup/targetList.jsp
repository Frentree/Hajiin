<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../../include/session.jsp"%>

<style>
	body{
		width: auto;
	}
	@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
		html{
			overflow: auto !important;
		}
		body{
			width: auto !important;
		}
	}
</style>
<body>
	<div id="stepContents1" class="step_content" style="border-top: 1px solid #aca49c; background: #f9f9f9; width: 100%;">
		<div class="step_content_cell fl_l padd_r" style="width: 95%; height: 100%; margin-left: 25px;">
		
			<div class="select_location sch_left" style="height: 60px; min-height: 60px;background: #fff; border-bottom: 0px; border-radius: 0;">
				<div style="position: absolute; right: 10px; top: 10px; padding-top: 0px; font-size: 18px; font-weight: bold;">
				 Host : <input type="text" id="searchHost" value="" class="edt_sch" style="width: 263px;">
				<button id="btnSearch" class="btn_sch" style="margin-top: 5px;">검색</button>
				</div>
			</div>
			<div id="jstree" class="select_location" style=" width:100%; height: 85%; min-height: 460px; background: #ffffff; border-radius: 0;">
				
			</div>
		</div>
	</div>
</body>
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
	    	//$('#jstree').jstree(true).refresh();
	    	
	    	console.log(data);
	    	
	    	if(type == 1){
	    		console.log(ap + ", " + id);

	    		var id = id;
	    		var name =  data.node.text;
	    		var ap_no = ap;
	    		
	    		if(data.node.parent == "onedirve"){
	    			$(opener.document).find("#onedriveChk").val(1);
	    		} else {
	    			$(opener.document).find("#onedriveChk").val(0);
	    		}
	    		
	    		$(opener.document).find("#searchHost").val(name);
	    		$(opener.document).find("#searchHost").text(name);
	    		$(opener.document).find("#hostSelect").val(id);
	    		$(opener.document).find("#ap_no").val(ap_no);
	    		opener.findByPop();
	    		
	    		// window.close();
	    		
	    	}
	    });
});

var aut = "${aut}"
var to = true;
$("#btnSearch").click( function(e) {
	var searchHost = $('#searchHost').val();
	console.log(searchHost);
	
	if(to) { clearTimeout(to); }
    to = setTimeout(function () {
      $('#jstree').jstree(true).search(searchHost);
    }, 250);
});	

$('#searchHost').keyup(function (e) {
	var searchHost = $('#searchHost').val();
	if (e.keyCode == 13) {
    	
    	if(to) { clearTimeout(to); }
        to = setTimeout(function () {
          $('#jstree').jstree(true).search(searchHost);
        }, 250);
    }
});
$(document).ready(function () {
	var ntime = performance.timing;
    var request = ntime.responseStart - ntime.requestStart; // 요청 소요 시간
    
	Loading();	
    
	setTimeout("closeLoading()", request);
});

$(document).on('click', function(event){
	var target = event.target;
	var tr = target.parentElement.parentElement;
	var data_flag = tr.getAttribute('data-flag')
	if(data_flag == 'target'){
		var id = target.getAttribute('id')
		if($('tr[name='+id+']').is(':visible')){	// 보여지고 있을 때
			$('tr[name='+id+']').hide()
		} else {
			$('tr[name='+id+']').show()
		}
	}
	
});

/*
function getSearchData(host){

	$.ajax({
		type: "POST",
		url: "/popup/getTargetList",
		async : false,
		data : {
			host: host,
			aut: aut
		},
		dataType: "text",
	    success: function (resultMap) {
	    	var data = JSON.parse(resultMap);
	    	console.log('resultMap :: ' + resultMap)
	    	if(data.resultCode == '0'){
	    		console.log('data :: ' + data)
	    		var resultList = data.resultData
	    		if(resultList.length > 0){
	    			var html = setLocationList(resultList, '', '', '', "search");
	    			//console.llg
	    			$("#Tbl_search").html(html)
	    		} else {
	    			$("#div_all").show()
	    			$("#div_search").hide();
	    			alert('검색 결과가 없습니다.')
	    		}
	    	}
	    },
	    error: function (request, status, error) {
	    	alert("Recon Server에 접속할 수 없습니다.");
	        console.log("ERROR : ", error)
	    }
	});
}
*/

function setTargetId(event){
	
	var id = $(event.target).attr('id')
	var name = $(event.target).text()
	var ap_no = $(event.target).data('apno')
	
	$(opener.document).find("#searchHost").val(name);
	$(opener.document).find("#searchHost").text(name);
	$(opener.document).find("#hostSelect").val(id);
	$(opener.document).find("#ap_no").val(ap_no);
	opener.findByPop();
	
	window.close();

}

function Loading() {
    var maskHeight = $(document).height();
    var maskWidth  = window.document.body.clientWidth;
     
    var mask       = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    var loadingImg ='';
     
    loadingImg +=" <div id='loadingImg'>";
    loadingImg +=" <img src='${pageContext.request.contextPath}/resources/assets/images/spinner.gif' style='position:absolute; z-index:9500; text-align:center; display:block; top:32%; left:35%;'/>";
    loadingImg += "</div>";  
 
    $('body')
        .append(mask)
 
    $('#mask').css({
            'width' : maskWidth,
            'height': maskHeight,
            'opacity' :'0.3'
    });
    
    $('#mask').show();
  
    $('#stepContents1').append(loadingImg);
    $('#loadingImg').show();
}

function closeLoading() {
    $('#mask, #loadingImg').hide();
    $('#mask, #loadingImg').remove(); 
}

</script>
</html>
