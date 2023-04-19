<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지-혜택상세페이지</title>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.min.js"></script>
<style type="text/css">
/* 혜택 상세페이지 css */
*{
	 border: 1px solid red; 
}
#statusY{
	color: green;
}
#statusN{
	color: red;
}
.modal-body{
	max-height: 600px;
    overflow-y: auto;
    text-align: center;
}
table{
	text-align: center;
}

/* 혜택 상세페이지 css */
</style>
<script type="text/javascript">

function benefitApply(benefitNo,productNo){
	
	$.ajax({
		url : '${path}/admin/benefitApplyCheck',
		type : 'get',
		data : {benefitNo,productNo},
		dataType : 'json',
		success : function(result){
			if (result != 0) {
				alert('이 상품은 현재 해당 기획전할인이 등록되어 있습니다!')
				$('#applyBtn'+productNo).css('display', 'none');
				$('#notApply'+productNo).text('적용불가').css('color','red');
				$('#notApply'+productNo).css('display','block');
				$('#resetBtn'+productNo).css('display','block');
			}else {
				
				if (confirm('이 상품은 해당 기획전할인에 등록할 수 있습니다.\n 상품을 등록하시겠습니까?')) {
					
					let adminPwd = prompt('\n\n관리자님의 비밀번호 인증이 필요한 서비스입니다.\n\n비밀번호를 입력해주세요.');
					
					if (adminPwd !== null) {
						
						$.ajax({
							url : '${path}/admin/adminPwdCheck',
							type : 'post',
							data : {adminPwd},
							dataType : 'json',
							success : function(result){
								if (result === true) {
									alert('관리자님 인증을 확인했습니다.')
									$.ajax({
										url : '${path}/admin/benefitProductInsert',
										type : 'post',
										data : {benefitNo,productNo},
										dataType : 'json',
										success : function(result){
											if (result > 0) {
												alert('상품을 기획전 등록에 성공했습니다.')
												$('#applyBtn'+productNo).css('display', 'none');
												$('#notApply'+productNo).text('적용중').css('color','green');
												$('#notApply'+productNo).css('display','block');
												$('#resetBtn'+productNo).css('display','block');
											}else {
												alert('상품을 기획전 등록에 실패했습니다.')
												return false;
											}
										},
										error : function(error){
											alert('에러 발생')
										}
									})
								}else if (result === false) {
									alert('입력하신 비밀번호와 관리자님의 비밀번호가 일치하지 않습니다.')
									return false;
								}
							},
							error : function(error){
								alert('에러')
							}
						})
						
					}else {
						return false;
					}
				}
				
			}
		},
		error : function(error){
			console.log('에러 발생')
		}
	})
}

function resetApply(benefitNo,productNo){
	
	if (confirm(productNo+'번 상품에 등록된 기획전을 취소하시겠습니까?')) {
		
		let adminPwd = prompt('\n\n관리자님의 비밀번호 인증이 필요한 서비스입니다.\n\n비밀번호를 입력해주세요.');
		
		if (adminPwd !== null){
			
			$.ajax({
				url : '${path}/admin/adminPwdCheck',
				type : 'post',
				data : {adminPwd},
				dataType : 'json',
				success : function(result){
					if (result === true) {
						alert('관리자님 인증을 확인했습니다.')
						$.ajax({
							url : '${path}/admin/benefitProductDelete',
							type : 'post',
							data : {benefitNo,productNo},
							dataType : 'json',
							success : function(result){
								if (result > 0) {
									alert('상품을 기획전 취소에 성공했습니다.')
									$('#resetBtn'+productNo).css('display','none');
									$('#notApply'+productNo).text('').css('color','white');
									$('#notApply'+productNo).css('display','none');
									$('#applyBtn'+productNo).css('display', 'block');
								}else {
									alert('상품을 기획전 취소에 실패했습니다.')
									return false;
								}
							},
							error : function(error){
								alert('에러 발생')
							}
						})
					}else if (result === false) {
						alert('입력하신 비밀번호와 관리자님의 비밀번호가 일치하지 않습니다.')
						return false;
					}
				},
				error : function(error){
					alert('에러')
				}
			})
		}
	}else {
		return false;
	}
}

function deleteBenefit(benefitNo){
	
	if (confirm(benefitNo+'번으로 등록된 혜택을 완전히 삭제하시겠습니까?\n확인을 누르실 경우 해당 정보를 모두 잃게 됩니다.')) {
		
		let adminPwd = prompt('\n\n관리자님의 비밀번호 인증이 필요한 서비스입니다.\n\n비밀번호를 입력해주세요.');
		
		if (adminPwd !== null){
			
			$.ajax({
				url : '${path}/admin/adminPwdCheck',
				type : 'post',
				data : {adminPwd},
				dataType : 'json',
				success : function(result){
					if (result === true) {
						alert('관리자님 인증을 확인했습니다.')
						$.ajax({
							url : '${path}/admin/benefitDelete',
							type : 'post',
							data : {benefitNo},
							dataType : 'json',
							success : function(result){
								if (result > 0) {
									alert('등록된 기획전 삭제에 성공했습니다.')
									window.location.href='${path}/admin/benefitList';
								}else {
									alert('등록된 기획전 삭제에 실패했습니다.')
									return false;
								}
							},
							error : function(error){
								alert('에러 발생')
							}
						})
					}else if (result === false) {
						alert('입력하신 비밀번호와 관리자님의 비밀번호가 일치하지 않습니다.')
						return false;
					}
				},
				error : function(error){
					alert('에러')
				}
			})
		}else {
			return false;
		}
	}else {
		return false;
	}
	
}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/cart/common/adminSidebar.jsp"/>

					<table class="table">
					<tbody>
               			<tr>
               				<th class="align-middle">
               					<span>상품이미지</span>
               				</th>
               				<c:if test="${empty benefit.benefitFileList}">
               					<th>등록된 사진이 없습니다.</th>
               				</c:if>
               				
               				<c:if test="${not empty benefit.benefitFileList}">
               					<c:forEach var="file" items="${benefit.benefitFileList}" varStatus="status">
		               				<th>
		               					<%-- <img src="${path}/upload/benefit/${file.renameFileName}" class="rounded img-fluid"> --%>
				        				<img src="https://cdn.pixabay.com/photo/2017/09/06/12/05/perfume-2721147__480.jpg" width="50%" class="rounded img-fluid"> 
		               				</th>
               					</c:forEach>
               				</c:if>
               			</tr>
               			<tr>
							<th>혜택번호</th>               			
							<th>${benefit.benefitNo}</th>               			
               			</tr>
               			<tr>
							<th>혜택구분</th>               			
							<th>${benefit.benefitName}</th>               			
               			</tr>
               			<tr>
							<th>혜택제목</th>               			
							<th>${benefit.benefitTitle}</th>         			
               			</tr>
               			<tr>
							<th>혜택내용</th>               			
							<th>${benefit.benefitContent}</th>         			
               			</tr>
               			<tr>
							<th>등록날짜</th>               			
							<th>
								<fmt:formatDate type="date" value="${benefit.benefitCreateDate}"/>
							</th>         			
               			</tr>
               			<tr>
							<th>종료날짜</th>               			
							<th>
								<fmt:formatDate type="date" value="${benefit.benefitEndDate}"/>
							</th>         			
               			</tr>
               			<tr>
							<th>혜택비율</th>               			
							<th>${benefit.benefitRatio}%</th>         			
               			</tr>
               			<tr>
							<th>혜택상태</th>               			
							<th>
								<c:if test="${benefit.benefitStatus == 'Y'}">
		                    		<span id="statusY">진행중인 혜택</span>
		                    	</c:if>
		                    	<c:if test="${benefit.benefitStatus == 'N'}">
		                    		<span id="statusN">종료된 혜택</span>
		                    	</c:if>
							</th>         			
               			</tr>
               			<tr>
							<th>조회수</th>               			
							<th>${benefit.benefitHit}</th>         			
               			</tr>
               		</tbody>
               		</table>
               		
               		<div>
	               		<button class="btn btn-warning" data-toggle="modal" data-target="#myModal">수정하기</button>
	               		<button class="btn btn-warning" onclick="location.href='${path}/admin/benefitList'">목록으로</button>
	               		<button class="btn btn-warning" onclick="deleteBenefit('${benefit.benefitNo}')">삭제하기</button>
	               		<c:if test="${benefit.benefitName == '기획전할인'}">
	               			<button class="btn btn-warning" data-toggle="modal" data-target="#myModal2">기획전상품적용하기</button>
	               		</c:if>
               		</div>
               		
               		<!-- The Modal -->
					  <div class="modal fade" id="myModal">
					    <div class="modal-dialog modal-xl">
					      <div class="modal-content">
					      
					        <!-- Modal Header -->
					        <div class="modal-header">
					          <h4 class="modal-title">혜택수정</h4>
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					        </div>
					        <!-- Modal Header -->
					        
					        <!-- Modal body -->
					        <div class="modal-body">
					        <form action="${path}/admin/benefitUpdate" method="POST" class="form-inline" enctype="multipart/form-data">
		                        <input type="hidden" name="benefitNo" value="${benefit.benefitNo}">
		                        <table class="table">
			               			<tr>
			               				<td>
			               					<span>기존상품이미지</span>
			               				</td>
			               				<c:if test="${empty benefit.benefitFileList}">
			               					<td>등록된 사진이 없습니다.</td>
			               				</c:if>
			               				
			               				<c:if test="${not empty benefit.benefitFileList}">
				               				<td style="width: 200px">
						        				<img src="https://cdn.pixabay.com/photo/2017/09/06/12/05/perfume-2721147__480.jpg" class="rounded img-fluid"> 
				               				</td>
			               				</c:if>
			               				<td>
			               					<span>변경상품이미지등록</span>
			               				</td>
			               				<td>
			               					<input id="" class="upFile" type="file" name="originalFileName" required style="color: orange;">
			               				</td>
			               			</tr>
			               			<tr>
										<td>혜택번호</td>               			
										<td colspan="3">${benefit.benefitNo}</td>               			
			               			</tr>
			               			<tr>
										<td>혜택구분</td>               			
										<td colspan="3">
											<select name="benefitName" id="benefitName" required>
	                                            <option selected>------선택------</option>
	                                            <option value="기획전할인">1.기획전할인</option>
	                                            <option value="쿠폰">2.쿠폰</option>
	                                            <option value="이벤트">3.이벤트</option>
                                        	</select>
										</td>               			
			               			</tr>
			               			<tr>
										<td>혜택제목</td>               			
										<td colspan="3">
											<input type="text" name="benefitTitle" placeholder="제목을 입력해주세요." required class="form-control form-control-sm">
										</td>         			
			               			</tr>
									<tr style="height: 250px;">
	                                    <th style="height: 250px;">혜택내용</th>
	                                    <td colspan="3" style="height: 250px;">
	                                        <textarea name="benefitContent" placeholder="혜택소개글 작성" required class="form-control" rows="5" style="height: 250px; width: 100%" ></textarea>
	                                    </td>
	                                </tr>         			
			               			<tr>
										<td>수정날짜</td>               			
										<td colspan="3">
											*수정날짜는 수정한날로 자동으로 입력됩니다.*
										</td>
									</tr>
									<tr> 
										<td>종료날짜</td>               			
										<td colspan="3">
											<input type="date" name="benefitEndDate" placeholder="형식 : 2023-04-18" required class="form-control form-control-sm">
										</td>         			
			               			</tr>
			               			<tr>
										        			
			               			</tr>
			               			<tr>
										<th>혜택비율 : </th>
	                                    <th colspan="3">
	                                    	*모든 혜택은 5%가 적용됩니다.*
	                                    	<input type="hidden" name="benefitRatio" value="5">	
	                                  	</th>
			               			</tr>
			               		</table>
	                       		 
                       		 	<!-- Modal footer -->
						        <div class="modal-footer">
						          <button type="submit" class="btn btn-secondary">수정하기</button>
						          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						        </div>
				        	 	<!-- Modal footer -->
                           	</form>
					        </div>
					        <!-- Modal body -->
					        
					      </div>
					    </div>
					  </div>
               		  <!-- The Modal -->
               		  
               		  <!-- The Modal2 -->
					  <div class="modal fade" id="myModal2">
					    <div class="modal-dialog modal-xl">
					      <div class="modal-content">
					      
					        <!-- Modal Header -->
					        <div class="modal-header">
					          <h4>기획전상품적용</h4>
					          <button type="button" class="close" data-dismiss="modal">&times;</button>
					        </div>
					        <!-- Modal Header -->
					        
					        <!-- Modal body -->
					        <div class="modal-body">
		                        <input type="hidden" name="benefitNo" value="${benefit.benefitNo}">
		                        
		                        <table class="table">
		                        	<thead>
		                        		<tr>
		                        			<th colspan="9">
		                        			*상품명을 클릭하면 상품의 상세페이지로 넘어갑니다.*<br>
		                        			*적용하기 버튼을 누르시면 상품이 현재 기획전 할인에 등록 되었는지를 확인 하실 수 있습니다.*
		                        			</th>
		                        		</tr>
		                        		<tr>
					        				<th>썸네일</th>
					        				<th>상품번호</th>
						                    <th>향구분</th>
						                    <th>상품구분</th>
						                    <th>브랜드</th>
						                    <th>상품명</th>
						                    <th>기준금액</th>
						                    <th>등록일자</th>
						                    <th>적용여부</th>
					                    </tr>
				                    </thead>
			        			
			        			<c:if test="${not empty benefit.productList}">
			        				<c:forEach var="product" items="${ benefit.productList }">
				        				<tbody>
				        					<tr>
				        						<th class="align-middle">
					        						<%-- <img src="${path}/upload/benefit/${file.renameFileName}" width="100px"> --%>
				        							<img src="https://cdn.pixabay.com/photo/2017/09/06/12/05/perfume-2721147__480.jpg" width="150px" class="rounded">
				        						</th>
						        				<th class="align-middle">${product.productNo}</th>
							                    <th class="align-middle">${product.topCategoryName}</th>
							                    <th class="align-middle">${product.midCategoryName}</th>
							                    <th class="align-middle">${product.productBrand}</th>
							                    <th class="align-middle"><a href="${path}/admin/productDetail?productNo=${product.productNo}">${product.productName}</a></th>
							                    <th class="align-middle">${product.productPrice}</th>
							                    <th class="align-middle"><fmt:formatDate type="date" value="${product.productDate}"/></th>
				        						<th class="align-middle">
													<button id="applyBtn${product.productNo}" type="button" class="btn btn-warning" onclick="benefitApply(${benefit.benefitNo},${product.productNo})">체크하기</button>
													<button id="resetBtn${product.productNo}" style="display: none;" type="button" class="btn btn-warning" onclick="resetApply(${benefit.benefitNo},${product.productNo})">취소하기</button>
													<span id="notApply${product.productNo}" style="display: none;"></span>
												</th>
				        					</tr>
				        				</tbody>	
			        				</c:forEach>
			        			</c:if>
			        			
			        			</table>
					        </div>
					        <!-- Modal body -->
				        	<!-- Modal footer -->
					        <div class="modal-footer">
					          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
					        </div>
			        	 	<!-- Modal footer -->
					        
					      </div>
					    </div>
					  </div>
               		  <!-- The Modal2 -->

<jsp:include page="/WEB-INF/views/cart/common/adminFootDiv.jsp"/>
</body>
</html>