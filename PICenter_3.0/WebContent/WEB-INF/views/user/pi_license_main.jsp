<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ include file="../../include/header.jsp"%>

		<!-- section -->
		<section>
			<!-- container -->
			<div class="container" >
			<h3>라이센스</h3>
			<%-- <%@ include file="../../include/menu.jsp"%> --%>
				<!-- content -->
				<div class="content magin_t25">
					<div class="location_area">
						<p class="location">설정 > 라이센스</p>
					</div>
					<!-- user info -->
					<div class="grid_top">
						<table style="width: 100%;">
							<tr>
								<td style="padding-top: 20px;"><Strong>라이센스 : </Strong>SK POC
							</tr>
							<tr>
								<%-- <td style="padding-top: 20px; padding-bottom: 20px;"><Strong>만료일 : </Strong>${expire}</td> --%>
								<td style="padding-top: 20px; padding-bottom: 20px;"><Strong>만료일 : </Strong>영구</td>
							</tr>
						</table>
					</div>
					</br></br></br>
					<%-- <table class="user_info approvalTh" style="border: 1px solid #006EB6; width: 700px !important;">
						<caption>사용자정보</caption>
						<tbody>
						<tr>
							<th style="text-align: center; background-color: #d6e4ed; width:10px">서버명</th>
							<th style="text-align: center; background-color: #d6e4ed; width:30px">사용 타입</th>
						</tr>
						<c:forEach items="${targetList}" var="targetList">
							<tr>
								<td style="border: 1px solid #006EB6; ">
									${targetList.name}
								</td">
								<td style="text-align: center; border: 1px solid #006EB6; ">
									${targetList.type}
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table> --%>
					<div class="chart_area" style="height: 70%; margin-top: 120px; margin-left: 10px;">
						<ul>
							<li class="width25" id="ap0_list">
								<h3 style="padding: 0;">IT&TiDC 영역</h3>
								<!-- Master Server : 1/1<br/>
								Server : 1/600 -->
								<div class="chart_box" style="height: 335px; overflow:auto; background: #fff;">
						    	<table id="ap0_tbl" class="squareBox"></table>
								</div>
							</li>
							<li class="width25" id="ap1_list">
								<h3 style="padding: 0;">유통망</h3>
								<!-- Master Server : 1/1<br/>
								Server : 1/600 -->
								<div class="chart_box" style="height: 335px; overflow:auto; background: #fff;">
						    	<table id="ap1_tbl" class="squareBox"></table>
								</div>
							</li>
							<li class="width25" id="ap2_list">
								<h3 style="padding: 0;">OA망</h3>
								<!-- Master Server : 1/1<br/>
								Server : 1/600 -->
								<div class="chart_box" style="height: 335px; overflow:auto; background: #fff;">
						    	<table id="ap2_tbl" class="squareBox"></table>
								</div> 
							</li>
							<li class="width25" id="ap3_list">
								<h3 style="padding: 0;">VDI</h3>
								<!-- Master Server : 1/1<br/>
								Server : 1/600 -->
								<div class="chart_box" style="height: 335px; overflow:auto; background: #fff;">
						    	<table id="ap3_tbl" class="squareBox"></table>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- container -->
		</section>
		
	<%@ include file="../../include/footer.jsp"%>
	
<script type="text/javascript">
$(document).ready(function(){
	if('${resultCode}' == '99'){
		alert('License 조회 중에 오류가 발생했습니다.');
		window.history.back();
	}
	getLicenseDetail('ap0',0);
	getLicenseDetail('ap1',1);
	getLicenseDetail('ap2',2);
	getLicenseDetail('ap3',3);
});

function getLicenseDetail(id, ap_num){
	
	var postData = {
		ap_num : ap_num
	}
	
	console.log(ap_num)
	$.ajax({
		type: "POST",
		url: "/user/getLicenseDetail",
		async : false,
		data : postData,
	    success: function (resultMap) {
	    	var html = '';
	    	var targetList = resultMap.dbTargetList
	    	targetList.forEach(function(item, index){
	    		html += '<tr><td>'+item.NAME+'</td></tr>'
	    	});
	    	$('#'+id+'_tbl').append(html);
	    },
	    error: function (request, status, error) {
	    }
	});
	
}
</script>

</body>
</html>