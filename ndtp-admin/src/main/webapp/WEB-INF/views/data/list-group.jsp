<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>데이터 그룹 | NDTP</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css" />
	<link rel="stylesheet" href="/css/fontawesome-free-5.2.0-web/css/all.min.css">
    <link rel="stylesheet" href="/css/${lang}/style.css" />
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<!-- <div class="filters">
						</div> -->
						<div style="height: 30px;"></div>
						<div class="list">
							<div class="list-header row">
								<div class="list-desc u-pull-left">
									<div class="button-group">
										<a href="#" onclick="openAll(); return false;" class="button">펼치기</a>
										<a href="#" onclick="closeAll(); return false;" class="button">접기</a>
										<!-- <a href="/layer/tree" class="button">그룹 수정/등록</a> -->
									</div>
								</div>
							</div>
							<table class="list-table scope-col">
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-name" />
								<col class="col-toggle" />
								<col class="col-toggle" />
								<col class="col-functions" />
								<col class="col-functions" />
								<col class="col-date" />
								<thead>
									<tr>
										<th scope="col">그룹명</th>
					                    <th scope="col">그룹 Key</th>
					                    <th scope="col">공유 유형</th>
					                    <th scope="col">기본 여부</th>
					                    <th scope="col">사용 여부</th>
					                    <th scope="col">위도/경도</th>
					                    <th scope="col">이동시간</th>
					                    <th scope="col">등록일</th>
									</tr>
								</thead>
								<tbody>
<c:if test="${empty dataGroupList }">
									<tr>
										<td colspan="8" class="col-none">데이터 그룹이 존재하지 않습니다.</td>
									</tr>
</c:if>								
<c:if test="${!empty dataGroupList }">
	<c:set var="paddingLeftValue" value="0" />
    <!-- depth 별 css 제어를 위한 변수 -->
    <c:set var="depthClass" value="" />
    <c:set var="depthStyleDisplay" value="" />
    <!-- 클릭 이벤트 발생시 자손 css 를 제어하기 위한 변수 -->
    <c:set var="ancestorClass" value="" />
    <!-- 클릭 이벤트 발생시 자식 css 를 제어하기 위한 변수 -->
    <c:set var="depthParentClass" value="" />
    <c:set var="ancestorArrowClass" value="" />
    <c:set var="ancestorFolderClass" value="" />
    <c:forEach var="dataGroup" items="${dataGroupList}" varStatus="status">
        <c:if test="${dataGroup.depth eq '1' }">
            <c:set var="depthClass" value="oneDepthClass" />
            <c:set var="paddingLeftValue" value="0px" />
            <c:set var="depthStyleDisplay" value="" />
            <c:set var="ancestorClass" value="" />
            <c:set var="depthParentClass" value="" />
        </c:if>
        <c:if test="${dataGroup.depth eq '2' }">
            <c:set var="depthClass" value="twoDepthClass" />
            <c:set var="paddingLeftValue" value="40px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="oneDepthParent-${dataGroup.parent }" />
            <c:set var="ancestorClass" value="" />
            <c:set var="ancestorArrowClass" value="ancestorArrow-${dataGroup.ancestor }" />
            <c:set var="ancestorFolderClass" value="ancestorFolder-${dataGroup.ancestor }" />
        </c:if>
        <c:if test="${dataGroup.depth eq '3' }">
            <c:set var="depthClass" value="threeDepthClass" />
            <c:set var="paddingLeftValue" value="80px" />
            <c:set var="depthStyleDisplay" value="display: none;" />
            <c:set var="depthParentClass" value="twoDepthParent-${dataGroup.parent }" />
            <c:set var="ancestorClass" value="ancestor-${dataGroup.ancestor }" />
        </c:if>
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }" style="${depthStyleDisplay}">
										<td class="col-key" style="text-align: left;" nowrap="nowrap">
        <c:if test="${dataGroup.depth eq '1' }">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;" 
					                        	onclick="childrenDisplayToggle('${dataGroup.depth}', '${dataGroup.dataGroupId}', '${dataGroup.ancestor}');">
					                            <i id="oneDepthArrow-${dataGroup.dataGroupId }" class="fa fa-caret-right oneArrow" aria-hidden="true"></i>
					                        </span>&nbsp;
					                        <span style="font-size: 1.5em; color: Dodgerblue;">
					                            <i id="oneDepthFolder-${dataGroup.dataGroupId }" class="fa fa-folder oneFolder" aria-hidden="true"></i>
					                        </span>
        </c:if>
        <c:if test="${dataGroup.depth eq '2' }">
            <c:if test="${dataGroup.children == 0}">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
            </c:if>
            <c:if test="${dataGroup.children > 0}">
					                        <span style="padding-left: ${paddingLeftValue}; font-size: 1.6em;" 
					                        	onclick="childrenDisplayToggle('${dataGroup.depth}', '${dataGroup.dataGroupId}', '${dataGroup.ancestor}');">
					                            <i id="twoDepthArrow-${dataGroup.dataGroupId }" class="fa fa-caret-right twoArrow ${ancestorArrowClass }" aria-hidden="true"></i></span>&nbsp;
					                        <span style="font-size: 1.5em; color: Mediumslateblue;">
					                            <i id="twoDepthFolder-${dataGroup.dataGroupId }" class="fa fa-folder twoFolder ${ancestorFolderClass }" aria-hidden="true"></i>
					                        </span>
            </c:if>
        </c:if>
        <c:if test="${dataGroup.depth eq '3' }">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
        </c:if>

                        					${dataGroup.dataGroupName }
										</td>
										<td class="col-key">${dataGroup.dataGroupKey }</td>
										<td class="col-key">${dataGroup.sharedType }</td>
					                    <td class="col-type">
        <c:if test="${dataGroup.basic eq 'true' }">
                        					기본
        </c:if>
        <c:if test="${dataGroup.basic eq 'false' }">
                        					선택
        </c:if>
					                    </td>
					                    <td class="col-type">
        <c:if test="${dataGroup.available eq 'true' }">
                        					사용
        </c:if>
        <c:if test="${dataGroup.available eq 'false' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-key">${dataGroup.userId }</td>
					                    <td class="col-key">${dataGroup.description }</td>
					                    <td class="col-type"><a href="/layer/modify/${dataGroup.dataGroupId }" class="linkButton">보기</a>
					                    </td>
					                    <td class="col-type"><a href="/layer/modify/${dataGroup.dataGroupId }" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-type">
					                    	<button>위로</button>
					                    	<button>아래로</button>
					                    </td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${dataGroup.insertDate}" var="viewInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
					                    </td>
					                </tr>
		<c:if test="${!empty dataGroup.layerList }">
			<c:forEach var="layer" items="${dataGroup.layerList}" varStatus="status">
									<tr class="${depthClass } ${depthParentClass} ${ancestorClass }">
										<td class="col-key" style="text-align: left;" nowrap="nowrap">
                        					<span style="padding-left: ${paddingLeftValue}; font-size: 1.5em; color: Tomato;"><i class="fa fa-file-alt" aria-hidden="true"></i></span>
                        					${layer.layerName }
										</td>
					                    <td class="col-type">
        <c:if test="${layer.available eq 'true' }">
                        					사용
        </c:if>
        <c:if test="${layer.available eq 'false' }">
                        					미사용
        </c:if>
					                    </td>
					                    <td class="col-key">${layer.userId }</td>
					                    <td class="col-key">${layer.description }</td>
					                    <td class="col-type"><a href="/layer/modify/${layer.layerId }" class="linkButton">지도 보기</a>
					                    </td>
					                    <td class="col-type"><a href="/layer/modify/${layer.layerId }" class="linkButton">수정</a>
					                    </td>
					                    <td class="col-type">
					                    	<button>위로</button>
					                    	<button>아래로</button>
					                    </td>
					                    <td class="col-date">
					                    	<fmt:parseDate value="${layer.insertDate}" var="viewLayerInsertDate" pattern="yyyy-MM-dd HH:mm:ss"/>
											<fmt:formatDate value="${viewLayerInsertDate}" pattern="yyyy-MM-dd HH:mm"/>
					                    </td>
					                </tr>	
			</c:forEach>
		</c:if>
    </c:forEach>
</c:if>
								</tbody>
							</table>
						</div>
						<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/${lang}/common.js"></script>
<script type="text/javascript" src="/js/${lang}/message.js"></script>
<script type="text/javascript" src="/js/navigation.js"></script>
<script type="text/javascript">
	//펼치기
	function openAll() {
	    $(".threeDepthClass").show();
	    $(".twoDepthClass").show();
	
	    // fa-caret-right
	    // fa-caret-down
	    $(".oneArrow").removeClass("fa-caret-right");
	    $(".oneArrow").addClass("fa-caret-down");
	    $(".twoArrow").removeClass("fa-caret-right");
	    $(".twoArrow").addClass("fa-caret-down");
	
	    $(".oneFolder").removeClass("fa-folder");
	    $(".oneFolder").addClass("fa-folder-open");
	    $(".twoFolder").removeClass("fa-folder");
	    $(".twoFolder").addClass("fa-folder-open");
	}
	
	// 접기
	function closeAll() {
	    $(".threeDepthClass").hide();
	    $(".twoDepthClass").hide();
	
	    $(".oneArrow").removeClass("fa-caret-down");
	    $(".oneArrow").addClass("fa-caret-right");
	    $(".twoArrwo").removeClass("fa-caret-down");
	    $(".twoArrwo").addClass("fa-caret-right");
	
	    $(".oneFolder").removeClass("fa-folder-open");
	    $(".oneFolder").addClass("fa-folder");
	    $(".twoFolder").removeClass("fa-folder-open");
	    $(".twoFolder").addClass("fa-folder");
	}
	
	// 화살표 클릭시
	function childrenDisplayToggle(depth, dataGroupId, ancestor) {
	    if(depth === "1") {
	        console.log("--------- depth 1 = " + $(".oneDepthParent-" + dataGroupId).css("display"));
	        if( $(".oneDepthParent-" + dataGroupId).css("display") === "none" ) {
	            // 접힌 상태
	            $(".oneDepthParent-" + dataGroupId).show();
	
	            $("#oneDepthArrow-" + dataGroupId).removeClass("fa-caret-right");
	            $("#oneDepthArrow-" + dataGroupId).addClass("fa-caret-down");
	            $("#oneDepthFolder-" + dataGroupId).removeClass("fa-folder");
	            $("#oneDepthFolder-" + dataGroupId).addClass("fa-folder-open");
	
	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        } else {
	            // 펼친 상태
	            $(".ancestor-" + ancestor).hide();
	            $(".oneDepthParent-" + dataGroupId).hide();
	
	            $("#oneDepthArrow-" + dataGroupId).removeClass("fa-caret-down");
	            $("#oneDepthArrow-" + dataGroupId).addClass("fa-caret-right");
	            $("#oneDepthFolder-" + dataGroupId).removeClass("fa-folder-open");
	            $("#oneDepthFolder-" + dataGroupId).addClass("fa-folder");
	
	            $(".ancestorArrow-" + ancestor).removeClass("fa-caret-down");
	            $(".ancestorArrow-" + ancestor).addClass("fa-caret-right");
	            $(".ancestorFolder-" + ancestor).removeClass("fa-folder-open");
	            $(".ancestorFolder-" + ancestor).addClass("fa-folder");
	        }
	    } else if(depth === "2") {
	        if( $(".twoDepthParent-" + dataGroupId).css("display") === "none" ) {
	            // 접힌 상태
	            $(".twoDepthParent-" + dataGroupId).show();
	
	            $("#twoDepthArrow-" + dataGroupId).removeClass("fa-caret-right");
	            $("#twoDepthArrow-" + dataGroupId).addClass("fa-caret-down");
	            $("#twoDepthFolder-" + dataGroupId).removeClass("fa-folder");
	            $("#twoDepthFolder-" + dataGroupId).addClass("fa-folder-open");
	        } else {
	            // 펼친 상태
	            $(".twoDepthParent-" + dataGroupId).hide();
	
	            $("#twoDepthArrow-" + dataGroupId).removeClass("fa-caret-down");
	            $("#twoDepthArrow-" + dataGroupId).addClass("fa-caret-right");
	            $("#twoDepthFolder-" + dataGroupId).removeClass("fa-folder-open");
	            $("#twoDepthFolder-" + dataGroupId).addClass("fa-folder");
	        }
	    }
	}
	
	// 지도 보기
    function viewLayer(layerId, layerName) {
        var url = "/layer/" + layerId + "/map";
        //popupOpen(url, layerName, 1000, 700);
        var width = 800;
        var height = 700;

        var popWin = window.open(url, "","toolbar=no ,width=" + width + " ,height=" + height
                + ", directories=no,status=yes,scrollbars=no,menubar=no,location=no");
        popWin.document.title = layerName;
    }
</script>
</body>
</html>