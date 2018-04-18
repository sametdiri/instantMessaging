<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!--- Template Source: https://bootsnipp.com/snippets/AXEM5 --->
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9" />
	<title>Messenger Project</title>
    <!---<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>--->

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!---<link href="/KOUBS/Samet/iMessage/resources/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="/KOUBS/Samet/iMessage/resources/js/bootstrap.min.js"></script>
	<script src="/KOUBS/Samet/iMessage/resources/js/jquery.min.js"></script>--->
	<style>
		.chatperson{
			display: block;
			border-bottom: 1px solid #eee;
			width: 100%;
			display: flex;
			align-items: center;
			white-space: nowrap;
			overflow: hidden;
			margin-bottom: 15px;
			padding: 4px;
		}
		.chatperson:hover{
			text-decoration: none;
			border-bottom: 1px solid orange;
		}
		.namechat {
			display: inline-block;
			vertical-align: middle;
		}
		.chatperson .chatimg img{
			width: 40px;
			height: 40px;
			background-image: url('http://i.imgur.com/JqEuJ6t.png');
		}
		.chatperson .pname{
			font-size: 18px;
			padding-left: 5px;
		}
		.chatperson .lastmsg{
			font-size: 12px;
			padding-left: 5px;
			color: #ccc;
		}
		.chatbody, contactList{
			width:fixed;
		}
		.avatar{
			width:55px;
			height:55px;
		}
		.msg{
			width:80%;
		}
		.dtime{
			width:10%;
			font-size:8pt;
			text-align:right;
		}
	</style>
    <script>
		var interval = 5000;
		var divName, params, url, sender, reciever;
		function nickSendEnter(e){
			var charCode = (typeof e.which === "number") ? e.which : e.keyCode;
			if(charCode == 13){
				nickSend();
			}
		}
		function nickSend(){
			nick = $("#nick").val();
			url = "islemler.cfm";
			divName = "application";//the div is changed.
			params = "islem=nickSend&nick="+nick;//the Params for querying.
			//params = new FormData("#giris"),
			//alert(params);
			AJAXReqSend();
			refreshContacts();
			refreshchatbody();
		}
		function changeReciever(){
			reciever = $("#reciever").val();
		}
		function changeSender(){
			sender = $("#sender").val();
		}
		function messageSendEnter(e){
			var charCode = (typeof e.which === "number") ? e.which : e.keyCode;
			if(charCode == 13){
				messageSend();
			}
		}
		
		function requestStatus(id, stat){
			url = "islemler.cfm";			
			divName = "";//the div is changed.
			params = "islem=requestStatus&contactID="+id+"&status="+stat;
			AJAXReqSend();
			if(stat){
				alert("Arkadaşlık isteğiniz kabul edildi!");
			else
				alert("Arkadaşlık isteğiniz ret edildi!");
		}
		function contactRequest(id){
			url = "islemler.cfm";			
			divName = "";//the div is changed.
			params = "islem=contactAdd&reciever="+id;
			AJAXReqSend();
			alert("Arkadaşlık isteğiniz gönderildi!");
			//$("#"+id).attr("class", "btn glyphicons glyphicons-pending-notifications");
		}
		function messageSend(){
			changeReciever();
			changeSender();

			message = $("#messageBody").val();
			url = "islemler.cfm";
			divName = "";//the div is changed.
			params = "islem=messageSend&sender=" + sender + "&reciever=" + reciever + "&message="+message;//the Params for querying.
			AJAXReqSend();
			$("#messageBody").val('');
		}
		function logout(nickID){
			url = "islemler.cfm";			
			divName = "application";//the div is changed.
			params = "islem=logout&nickID="+nickID;//the Params for querying.
			AJAXReqSend();
		}
		function refreshContacts(){	
			$("div#contactList").load("contactList.cfm?islem=contacts");
			setTimeout(refreshContacts, interval);
		}
		function refreshchatbody(){	
			$("div#chatbody").load("chatbody.cfm?islem=chat");
			setTimeout(refreshchatbody, interval);
		}<!--- --->
		
		function AJAXReqSend(){
			$.ajax({
				type		: "POST",
				url			: url,
				data		: params,
				error		: function() {alert('Hata.. islem sayfasina erisilemedi\n Lütfen tekrar deneyiniz...');},
				success 	: function(Sonuc) {
												$("div#"+divName).html(Sonuc);													
											  }
			});/**/
		}
		
	</script>
</head>
<body>
	<h3>Yazilim Laboratuvari-II</h3>
	<h4>Proje-II<br>Samet Diri, Furkan Selcuk Dag<br>170202128, 170202129</h4>
	<!---<div id="contactRequest"></div>--->
	<div id="application">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
			<!---<form id="giris" enctype="multipart/form-data">
				<input type="file" id="avatar" name="avatar">--->
				<input type="text" id="nick" name="nick" class="input input-lg" placeholder="Nick" onKeyup="nickSendEnter(event);">
				<button class="btn btn-info btn-lg" id="nickSend" onClick="nickSend();"><span class="glyphicon glyphicon-send"></span></button>
			<!---</form>--->
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
</body>
</html>