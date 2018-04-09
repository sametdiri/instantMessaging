<cfset session.reciever = 2>
<cfoutput>
<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <div class="contactList" id="contactList">
                <cfinclude  template="contactList.cfm"><!------>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="row">
                <button class="btn btn-info btn-sm pull-right" title="Çıkış" onClick="logout(#Session.nickID#);"><span class="glyphicon glyphicon-remove"></span></button>
                <div class="chatbody" id="chatbody">
                <cfinclude  template="chatbody.cfm"><!------>
                </div>
                <div class="row">
                    <div class="col-xs-9">
                        <input type="text" id="messageBody" placeholder="Mesajınızı buraya yazın..." class="form-control" onKeyUp="messageSendEnter(event);" />
                        <input type="hidden" id="sender" value="#session.nickID#">
                        <input type="hidden" id="reciever" value="#session.reciever#">
                    </div>
                    <div class="col-xs-3">
                        <button class="btn btn-info btn-block" onClick="messageSend();"><span class="glyphicon glyphicon-send"></span></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</cfoutput>