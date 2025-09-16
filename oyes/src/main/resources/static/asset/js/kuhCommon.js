$(document).ready(function() {
	//吏꾨즺�쒓컙��(蹂몄썝)
	$('.scheduleBtn').click(function() {
		callScheduleLayer();
	});

	//濡쒓렇��(蹂몄썝)
	$('#loginBtn').click(function() {
		callLoginLayer();
	});

	//�뚯썝媛���(蹂몄썝)
	$('#joinBtn').click(function() {
		callJoinLayer();
	});

	//濡쒓렇��(�ъ뒪耳��댁꽱��)
	$('#hLoginBtn').click(function () {
		callHloginLayer();
	});

	//�뚯썝媛���(�ъ뒪耳��댁꽱��)
	$('#hJoinBtn').click(function() {
		callHjoinLayer();
	});

	//濡쒓렇��(梨꾩슜)
	$('#rLoginBtn').click(function() {
		callRloginLayer();
	});

	//�뚯썝媛���(梨꾩슜)
	$('#rJoinBtn').click(function() {
		callRjoinLayer();
	});

	//濡쒓렇��(�꾩긽�쒗뿕�쇳꽣)
	$('#cLoginBtn').click(function() {
		callCloginLayer();
	});

	//�뚯썝媛���(�꾩긽�쒗뿕�쇳꽣)
	$('#cJoinBtn').click(function() {
		callCjoinLayer();
	});
	
	//sso 愿��� 荑좏궎 �앹꽦
	/*if(getCookie("ssoToken")){
		setSsoCookie("access_token", getCookie("ssoToken"), getCookie("ssoExpires"));
		delCookie("ssoToken");
		delCookie("ssoExpires");
	}*/
	
	//sso 愿��� 荑좏궎 �앹꽦
	if(getCookie("ssoToken")){
		setSsoCookie("access_token", getCookie("ssoToken"), getCookie("ssoExpires"));
		delCookie("ssoToken");
		delCookie("ssoExpires");
		
		if(getCookie("logOut")){
			delCookie("logOut");
			delSsoCookie("logOut");
		}
	}else{
		if(getCookie("logOut")){
			setSsoCookie("logOut", "Y", 3600);
			delSsoCookie("access_token");
		}
	}
});

function treatSchedule() {
	callScheduleLayer();
}

/**
 * [怨듯넻] alert layer.
 * mode => success / question / warning
 * type => alert 臾멸뎄
 * yn => reload �щ�
 * @param mode
 * @param type
 */
function callAlertLayer(mode, type, yn, method) {
	var url = '/common/alertLayer.do';
	var data = 'alertMode='+mode+'&alertType='+type+'&reloadYn='+yn;
	if(typeof method != "undefined") {
		data += '&method='+method
	}

	$.ajax({
		type: "GET",
		url: url,
		data: data,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-alert');
			$("#alertMsgLayer").html(data);
		}
	});
}

/**
 * [蹂몄썝] 硫붿씤 吏꾨즺�쒓컙�� layer.
 */
function callScheduleLayer() {
	var url = '/treatSchedule.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-schedule');
			$("#modalSchedule").html(data);
		}
	});
}

/**
 * [怨듯넻] login layer.
 */
function callLoginLayer() {
	var url = '/login.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-login');
			$("#modalLogin").html(data);
		}
	});
}

/**
 * [怨듯넻] join layer.
 */
function callJoinLayer() {
	var url = '/join.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-join');
			$("#modalJoin").html(data);
		}
	});
}

/**
 * [�ъ뒪耳��댁꽱��] login layer
 */
function callHloginLayer() {
	var url = '/wellness/login.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-login');
			$("#modalLogin").html(data);
		}
	});
}

/**
 * [�ъ뒪耳��댁꽱��] join layer
 */
function callHjoinLayer() {
	var url = '/hcenter/join.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-join');
			$("#modalJoin").html(data);
		}
	});
}

/**
 * [梨꾩슜�ъ씠��] login layer
 */
function callRloginLayer() {
	var url = '/recruit/login.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-login');
			$("#modalLogin").html(data);
		}
	});
}

/**
 * [梨꾩슜�ъ씠��] join layer
 */
function callRjoinLayer() {
	var url = '/recruit/join.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-join');
			$("#modalJoin").html(data);
		}
	});
}

/**
 * [�꾩긽�쒗뿕�쇳꽣] login layer
 */
function callCloginLayer() {
	var url = '/ctc/login.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-login');
			$("#modalLogin").html(data);
		}
	});
}

/**
 * [�꾩긽�쒗뿕�쇳꽣] join layer
 */
function callCjoinLayer() {
	var url = '/clinical/join.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-join');
			$("#modalJoin").html(data);
		}
	});
}

/**
 * [怨듯넻] �몄쬆�앹뾽 layer.
 */
function callCertifyLayer() {
	var url = '/certiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] �몄쬆�앹뾽 layer.(�덉빟)
 */
function callSelfCertifyLayer(gb) {
	var url = '/common/selfCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		data: { 'gubun':gb },
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] 14�몃�留� 遺�紐⑥씤利앺뙘�� layer.(�덉빟)
 */
function callParentCertifyLayer() {
	var url = '/common/parentCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] 14�몃�留� �몄쬆�앹뾽 layer.(�덉빟)
 */
function callChildCertifyLayer(gb) {
	var url = '/common/childCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] 留덉씠�섏씠吏��몄쬆�앹뾽 layer.(�섏옄踰덊샇議고쉶)
 */
function callMySelfCertifyLayer() {
	var url = '/mypage/selfCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] 14�몃�留� 遺�紐⑥씤利앺뙘�� layer.(�섏옄踰덊샇議고쉶)
 */
function callMyParentCertifyLayer() {
	var url = '/mypage/parentCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] 14�몃�留� �몄쬆�앹뾽 layer.(�섏옄踰덊샇 議고쉶)
 */
function callMyChildCertifyLayer(gb) {
	var url = '/mypage/childCertiPopup.do';

	$.ajax({
		type: "GET",
		url: url,
		success: function(data)
		{
			feUI.modalMethod.viewLayer('modal-certify');
			$("#modalCertify").html(data);
		}
	});
}

/**
 * [怨듯넻] �レ옄留� �낅젰媛���
 */
function onlyNum(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	});
}

/**
 * [怨듯넻] 荑좏궎 �앹꽦
 */
function setCookie(cName, cValue, cDay){
    var expire = new Date();
    expire.setDate(expire.getDate() + cDay);
    var cookies = cName + '=' + escape(cValue) + '; path=/ ';
    if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
    document.cookie = cookies;
}

/**
 * [怨듯넻] 荑좏궎 媛��몄삤湲�
 */
function getCookie(cName) {
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if(start != -1){
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
}

/**
 * [怨듯넻] 荑좏궎 ��젣
 */
function delCookie(cName){
	var expire = new Date();
	expire.setDate( expire.getDate() - 1 );
	var cookies = cName + "=" + ";expires=" + expire.toGMTString() + ";path=/";
    document.cookie = cookies;
}

/**
 * GNB 媛꾪렪�덉빟�곷떞�좎껌
 */
function gnbSimpleRsvRegProc() {
	var pattern1 = /^[0-9]+$/;
	var pattern2 = /^[가-힣a-zA-Z]+$/;

	var gnbSmpValidCheck = true;

	if ($('input[name=gnbSmpNm]').val() == '' || !pattern2.test($('input[name=gnbSmpNm]').val()) ) {
		gnbSmpValidCheck = false;
		$(this).focus();
	}
	if ($('input[name=gnbSmpTel]').val() == '' || !pattern1.test($('input[name=gnbSmpTel]').val()) ) {
		gnbSmpValidCheck = false;
		$(this).focus();
	}

	if (!gnbSmpValidCheck) {
		callAlertLayer('warning', 'simpleRsvVaild', 'N');
	} else {
		var gnbData = 'type=A&status=I&name='+$('input[name=gnbSmpNm]').val()+'&tel='+$('input[name=gnbSmpTel]').val();

		$.ajax({
			type : "POST",
			url : '/simpleRsvRegProcAjax.do',
			data : gnbData,
			success : function(data) {
				callAlertLayer('success', 'simpleRsvRegSuccess', 'Y');
			},
			error : function() {
				callAlertLayer('warning', 'regFail', 'N');
			}
		});
	}
}

function fileDown(fileNm){
	var url = '/common/download.do?fileNm='+encodeURI(fileNm);
	location.href = url;
}

/**
 * SSO 荑좏궎 �앹꽦
 */
function setSsoCookie(cName, cValue, cMin){
	var cDomain = ".eumc.ac.kr";
    var expire = new Date();
    expire.setMinutes(expire.getMinutes() + (cMin / 60));
    
    var cookies = cName + "=" + escape(cValue) + ";path=/;domain=" + cDomain;
    if(typeof cMin != "undefined") cookies += ";expires=" + expire.toGMTString() + ";";
    document.cookie = cookies;
}

/**
 * SSO 荑좏궎 ��젣
 */
function delSsoCookie(cName){
	var cDomain = "eumc.ac.kr";
	var expire = new Date();
	expire.setDate( expire.getDate() - 1 );
	var cookies = cName + "=" + ";expires=" + expire.toGMTString() + ";path=/;" + "domain=" + cDomain;
    document.cookie = cookies;
}

/**
 * 痢듬퀎�덈궡 > 痢듬퀎 �몃옒踰덊샇 �덈궡
 */
function floorInfoView(modalCssNm, modalId){
	feUI.modalMethod.viewLayer(modalCssNm);

	var htmlData = '<div class="modal-body alignC" style="max-height: none;">';
	htmlData += '	<img src="/asset/img/preview/previewInfo.jpg" alt="痢듬퀎 �몃옒踰덊샇 �덈궡">';
	htmlData += '</div>';
	htmlData += '<button type="button" class="button btnClose">�リ린</button>';
		
	$("#"+modalId).html(htmlData);
}

/**
 * 寃곌낵吏� �ㅼ슫濡쒕뱶
 */
var reportRsvDt = "";
function reportAction(rsvDt, birth){
	reportRsvDt = rsvDt;
	
	var now = new Date();
	var pastYear = now.getFullYear()-14;
	var month = now.getMonth()+1;
	var date = now.getDate();
	var pastToday;
	var imsiMonth = month < 10 ? "0" + month : month;
	var imsiday = date < 10 ? "0" + date : date;
	pastToday = pastYear + "" + imsiMonth + "" + imsiday;

	if(birth > pastToday) {
		callMyParentCertifyLayer();
	} else {
		callMySelfCertifyLayer();
	}
}

/**
 * �ㅻ챸�몄쬆 �� Action
 */
function myCertifyAction(){
	if($(location).attr('pathname').indexOf("healthGjList.do") != -1){
		if(reportRsvDt != ""){
			$(location).attr("href","/mypage/reportDownload.do?rsvDt="+reportRsvDt);
		}
		return;
	}else{
		location.reload();
	}
}