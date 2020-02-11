<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- S: 시민참여 의견 -->
<div id="civilVoiceDetailContent" class="contents mar0 pad0 border-none" style="display:none;">
	<input type="hidden" id="civilVoiceId" value="">
	<div id="civilVoiceView" class="commentView"></div>

	<p class="agreeCount">동의 <span id="civilVoiceCommentTotalCount">0</span> 건</p>
	<form:form id="civilVoiceCommentForm" modelAttribute="civilVoiceComment" method="post" onsubmit="return false;">
		<div class="agreeNew">
			<input type="text" name="title" placeholder="동의합니다" value="">
			<button class="focusAgree" id="civilVoiceAgree" title="동의">동의</button>
		</div>
	</form:form>
	<ul id="civilVoiceComment" class="agreeWrap"></ul>
	<ul id="civilVoiceCommentPagination" class="pagination"></ul>

	<div class="form-group button-group-top-center">
		<button type="button" id="civilVoiceListButton" title="목록" class="btnTextF">목록</button>
	</div>
</div>
<!-- E: 시민참여 의견 -->

<script id="templateCivilVoiceView" type="text/x-handlebars-template">
	<div style="margin-bottom: 15px;">
		<span class="title"  id="civilVoiceTitle">
			{{civilVoice.title}}
		</span>
		{{#if civilVoice.editable}}
			<span class="modify" id="civilVoiceDeleteButton">삭제</span>
			<span class="modify" id="civilVoiceUpdateButton">수정</span>
		{{/if}}
	</div>
	<div class="con" id="civilVoiceContents">{{civilVoice.contents}}</div>
</script>

<script id="templateCivilVoiceComment" type="text/x-handlebars-template">
	{{#if civilVoiceCommentList}}
		{{#each civilVoiceCommentList}}
			<li>
				<p class="agree">
					<span class="likes-icon">icon</span>
					{{title}}
					<span class="id">{{userId}}</span>
				</p>
			</li>
		{{/each}}
	{{/if}}
</script>

<script id="templateCivilVoiceCommentPagination" type="text/x-handlebars-template">
	{{#if pagination.totalCount}}
    	<ul class="pagination">
    	{{#if pagination.existPrePage}}
       	 	<li class="ico first" onClick="getCivilVoiceCommentList({{pagination.firstPage}});"></li>
        	<li class="ico forward" onClick="getCivilVoiceCommentList({{pagination.prePageNo}});"></li>
    	{{/if}}

    	{{#forEachStep pagination.startPage pagination.endPage 1}}
        	{{#if (indexCompare this ../pagination.pageNo)}}
           		<li class="on"><a href='#'>{{this}}</a></li>
        	{{else}}
         		<li onClick="getCivilVoiceCommentList({{this}});"><a href='#'>{{this}}</a></li>
        	{{/if}}
    	{{/forEachStep}}

    	{{#if pagination.existNextPage}}
        	<li class="ico back" onClick="getCivilVoiceCommentList({{pagination.nextPageNo}});"></li>
        	<li class="ico end" onClick="getCivilVoiceCommentList({{pagination.lastPage}});"></li>
    	{{/if}}
    	</ul>
	{{/if}}
</script>