<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!--- Template Source: https://bootsnipp.com/snippets/AXEM5 --->
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-9" />
	<title>Messenger Project</title>
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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
	</style>
    <script>
		var interval = 5000;
		var divName, params, url;
		refreshDiv();
		refreshchatbody();
		function refreshContacts(){
			url = "contactList.cfm";
			div = "contactList";
			params = "";
			AJAXReqSend();			
			setTimeout(refreshContacts, interval);
		}
		function refreshchatbody(){
			url = "chatbody.cfm";
			div = "chatbody";
			params = "";
			AJAXReqSend();			
			setTimeout(refreshchatbody, interval);
		}
		
		function AJAXReqSend(){
			$.ajax({
				type		: "POST",
				url			: url,
				data		: params,
				error		: function() {alert('Hata.. islem sayfasina erisilemedi\n Lütfen tekrar deneyiniz...');},
				success 	: function(Sonuc) {
												$("div#"+divName).html(Sonuc).show();													
											  }
			});/**/
		}
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
			AJAXReqSend();
			refreshContacts();
			refreshchatbody();
		}
		function logout(nickID){
			url = "islemler.cfm";			
			divName = "application";//the div is changed.
			params = "islem=logout&nickID="+nickID;//the Params for querying.
			AJAXReqSend();
		}
	</script>
</head>
<body>
	<h3>Yazilim Laboratuvari-II</h3>
	<h4>Proje-II<br>Samet Diri, Furkan Selcuk Dag<br>170202128, 170202129</h4>
	<div id="application">
		<div class="row">
			<div class="col-lg-4"></div>
			<div class="col-lg-4">
				<input type="text" id="nick" class="input input-lg" placeholder="Nick" onKeyup="nickSendEnter(event);">
				<button class="btn btn-info btn-lg" id="nickSend" onClick="nickSend();"><span class="glyphicon glyphicon-send"></span></button>
			</div>
			<div class="col-lg-4"></div>
		</div>
	</div>
</body>
</html>