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
		<!-- content -->
		<div class="content magin_t25">
			<div class="location_area">
				<p class="location">검색 관리 > 검색 현황</p>
			</div>
				<div class="left_box" style="height:23.4vw; ">
						<div class="left_list">
						   <div id="div_all" class="select_location" style="overflow-y: auto; overflow-x: auto; height: 100%;background: #ffffff; white-space:nowrap;">
								<table class="tbl_input" id="location_table">
									<tbody>
										<c:set var="motherIdx" value =""></c:set>
										<c:forEach items="${groupList}" var="item" varStatus="status">
											<c:if test="${item.LEVEL == 1}">
												<c:set var="motherIdx" value ="${item.IDX}"></c:set>
												<%-- <tr data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}">
											</c:if>
											<c:if test="${item.LEVEL != 1}"> --%>
											</c:if>
											<tr style="display:none;" data-uptidx="${item.UP_IDX}" data-level="${item.LEVEL}" data-mother="${motherIdx}" data-targetcnt="${item.CNT}">
												<th><p id="${item.IDX}" class="sta_tit" style="cursor:pointer; margin-left:${item.LEVEL*10}px; width:auto; float:left; " >${item.NAME}</p></th>
											</tr>
										</c:forEach>
										<script type="text/javascript">
											console.log($('tr[data-level=1]').length)
											$('tr[data-level=1]').each(function(i, val){
												var id = $(val).children('th').children('p').attr('id')
												$('tr[data-mother='+id+']').each(function(bel_i, bel_val){
													var targetcnt = $(bel_val).data('targetcnt')
													
													if(targetcnt > 0){
														var mother = $(bel_val).data('mother')
														$('p#'+id).parent('th').parent('tr').show()
														return false;
													}
												})
											});
										</script>
										<c:if test="${noGroupSize > 0}">
											<tr>
												<th style="padding-top: 10px;"><p id="noGroup" class="sta_tit" style="cursor:pointer; margin-left:10px; " >그룹없음</p></th>
											</tr>
										</c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
			</div>
		</div>
	<!-- container -->
</section>
<!-- section -->
<!-- section -->
<%@ include file="../../include/footer.jsp"%>
<script>

</script>

</body>
</html>