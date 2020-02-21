<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="api37" class="api-help-toggle" style="display: none;">
	<div class="menu_tab">
		<ul>
			<li class="fst active"><a href="#" onclick="tabMenu(0);">Run</a></li>
			<li><a href="#" onclick="tabMenu(1);">Code</a></li>
		</ul>
	</div>
	<div class="menu_tab00 mTs" id="panels">
		<h2>instantiateStaticModelAPI</h2>
		<p>정적 모델 인스턴스를 생성하는 API입니다.</p>
		<table>
		<caption>파라미터</caption>
			<tr>
				<th scope="col">name</th>
				<th scope="col">type</th>
				<th scope="col">description</th>
			</tr>
			<tr>
				<td>managerFactoryInstance</td>
				<td>ManagerFactory</td>
				<td>mago3D 시작 부분</td>
			</tr>
			<tr>
				<td>attribute</td>
				<td>Object</td>
				<td>정적 모델 인스턴스화를 위한 환경 설정 변수</td>
			</tr>
		</table>
		<br>
		<h4>실행</h4>
		<div class="paramContainer">
			<label for="api37-p1">projectId :</label>
			<input type="text" id="api37-p1" value="static_sample"><br>
			<label for="api37-p2">instanceId :</label>
			<input type="text" id="api37-p2" value="building"><br>
			<label for="api37-p3">longitude :</label>
			<input type="text" id="api37-p3" value="127.000"><br>
			<label for="api37-p4">latitude :</label>
			<input type="text" id="api37-p4" value="37.000"><br>
			<label for="api37-p5">height :</label>
			<input type="text" id="api37-p5" value="100"><br>
			<label for="api37-p6">heading :</label>
			<input type="text" id="api37-p6" value="93.03254"><br>
			<label for="api37-p7">pitch :</label>
			<input type="text" id="api37-p7" value="223.84163"><br>
			<label for="api37-p8">roll :</label>
			<input type="text" id="api37-p8" value="123.74897">
		</div>
		<br> 
		<input type="button" value="Run" class="popupBtn" onclick="instantiateStaticModel()">
	</div>
	<div class="menu_tab01 mTs" id="panels" style="display: none;"></div>
</div>
<script>
	var instantiateStaticModel = function() {

		var projId = $('#api37-p1').val();
		var instId = $('#api37-p2').val();
		var lon = $('#api37-p3').val();
		var lat = $('#api37-p4').val();
		var ht = $('#api37-p5').val();
		var hd = $('#api37-p6').val();
		var pc = $('#api37-p7').val();
		var rl = $('#api37-p8').val();

		var attrObject = {
			projectId : projId,
			instanceId : instId,
			longitude : lon,
			latitude : lat,
			height : ht,
			heading : hd,
			pitch : pc,
			roll : rl
		}

		instantiateStaticModelAPI(MAGO3D_INSTANCE2, attrObject);
	}
</script>