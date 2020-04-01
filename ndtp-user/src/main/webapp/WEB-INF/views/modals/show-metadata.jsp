<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js"></script>

<!-- 건축인허가 신청 Modal -->
<div id="metadataDialog" title="건축물 정보" class="basicTable" style="display: none;">
    <h4 class="category" style="margin-top: 5px; margin-bottom: 6px; font-size: 15px;">🔸 건축물 상세 정보</h4>
    <ul class="layerDiv">
        <li>
            <label >ID: </label>
            <span id="materialID"></span>
        </li>
        <li>
            <label >분류: </label>
            <span id="detailNo"></span>
        </li>
        <li>
            <label style="margin-bottom: 5px;" >건축물 마감 자재: </label>
            <div id="material"></div>
        </li>
        <li>
            <label >내화구조 조례 적합 여부: </label>
            <div id="innerStructureIsGood" style="font-weight: bold; display: inline-block; margin-left: 10px;"></div>
        </li>
    </ul>
</div>
<style>
    .layerDiv2 label {
        display: inline-block;
        width: 40%;
    }
    .layerDiv2 li {
        margin-top: 5px;
        margin-bottom: 5px;
    }
    .layerDiv2 {
        color: '#565656;
    }
</style>
<!-- 건축인허가 신청 Modal -->
<div id="remoteControlObjDialog" title="연동 정보" class="basicTable" style="display: none;">
    <h4 class="category" style="margin-top: 5px; margin-bottom: 6px; font-size: 15px;">🔸상세 정보</h4>
    <ul class="layerDiv2">
        <li>
            <div style="display: flex;">
                <label >식별 코드 : </label>
                <div id="drondId">cbaa8384-73d1-11ea-022ac1303</div>
            </div>
        </li>
        <li>
            <div>
                <label>설명 : </label><span id="droneDiscription">2020년 4월 1일에 다음소프트에서 구입한 드론</span>
            </div>
        </li>
        <li>
            <div>
                <label>무게 : </label><span id="">20kg</span>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>우측 모터 상태 : </label>
                <div id="droneLeftMotState">수신 대기중</div>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>좌측 모터 상태 : </label>
                <div id="droneRightMotState">수신 대기중</div>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>바람 정보 : </label>
                <div id="windInfo">수신 대기중</div>
            </div>
        </li>
        <li>
            <div>
                <label>배터리 잔량 : </label><span id="droneBattery">수신 대기중</span>
            </div>
        </li>
        <li>
            <div>
                <label>작동시간 : </label><span id="droneWorkTime">수신 대기중</span>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>좌표 정보 : </label>
                <span>
                    <div>
                        <span id="dronePositionLon">위도 : 수신 대기중</span>
                    </div>
                    <div>
                        <span id="dronePositionLat">경도 : 수신 대기중</span>
                    </div>
                    <div>
                        <span id="dronePositionAlt">고도 : 수신 대기중</span>
                    </div>
                </span>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>자세 정보 : </label>
                <span>
                    <div>
                        <label>헤딩 : </label><span id="droneHeading">0°</span>
                    </div>
                    <div style="font-size: 11px; color: #777">← to left/→ to right</div>
                    <div>
                        <label>피치 : </label>
                        <span id="dronePitch">0°</span>
                    </div>
                    <div style="font-size: 11px; color: #777">↑ to up/↓ to down</div>
                    <div>
                        <label>롤 : </label>
                        <span id="droneRoll">0°</span>
                    </div>
                    <div style="font-size: 11px; color: #777">← + ⇧ left/→ + ⇧ right</div>
                </span>
            </div>
        </li>
        <li>
            <div style="display: flex;">
                <label>속도 : </label>
                <div>
                    <span id="droneSpeed">수신 대기중</span>
                    <div style="font-size: 11px; color: #777">↑ + ⇧ to speed up/↓ + ⇧ to speed down</div>
                </div>
            </div>
        </li>
    </ul>
</div>


<script>
    // $("#agenda_save").click(() => {
    //     agendaConsultationDialog.dialog("close");
    // });
    // $("#agenda_cancel").click(() => {
    //     console.log("cancel");
    //     agendaConsultationDialog.dialog("close");
    // });

</script>

<style>
    #metadataDialog .layerDiv label {
        width: 150px;
        font-size: 15px;
    }

    #metadataDialog .layerDiv li {
        margin-bottom: 6px;
    }

   /* #agendaConsultationDialog td {
        cursor: default;
    }
    #agendaConsultationDialog td.col-name {
        text-align: center;
    }
    #agendaConsultationDialog td.col-checkbox {
        text-align: center;
        width: 60px;
    }
    #agendaConsultationDialog .col-checkbox input {
        margin-top: 5px;
        cursor: pointer;
    }*/
    /*table.type02 {
        border-collapse: separate;
        border-spacing: 0;
        text-align: left;
        line-height: 1.5;
        border-top: 1px solid #ccc;
        border-left: 1px solid #ccc;
        margin : 20px 10px;
    }
    table.type02 th {
        width: 150px;
        padding: 10px;
        font-weight: bold;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
        border-top: 1px solid #fff;
        border-left: 1px solid #fff;
        background: #eee;
    }
    table.type02 td {
        width: 350px;
        padding: 10px;
        vertical-align: top;
        border-right: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }*/
</style>