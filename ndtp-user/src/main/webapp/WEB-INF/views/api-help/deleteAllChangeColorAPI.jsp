<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="api12" class="apihelptoggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#;" onclick="tab_menu(0);">Run</a></li>
			<li><a href="#;" onclick="tab_menu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
	<h2>deleteAllChangeColorAPI</h2>
	
	<p>변경한 색상 이력을 전체 삭제합니다.</p>
		<h4>파라미터</h4>
		<table>
		<tr><th>name</th><th>type</th><th>description</th></tr>
		<tr><td>managerFactoryInstance</td><td>ManagerFactory</td><td>mago3D 시작 부분</td></tr>
		</table></br>
		<h4>실행</h4>
	<div class="paramContainer"></div>
		<input type="button" value="Run" class="popupBtn" onclick="deleteAllChangeColor()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;">
		</div>
</div>
<script>
	var deleteAllChangeColor = function() {

		deleteAllChangeColorAPI(MAGO3D_INSTANCE2);
	}
</script>