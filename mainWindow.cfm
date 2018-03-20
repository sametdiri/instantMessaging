<cfoutput>
<div class="container">
    <div class="row">
        <div class="col-sm-4" class="contactList" id="contactList">
            <!---<cfinclude  template="contactList.cfm">--->
        </div>
        <div class="col-sm-8">
            <button class="btn btn-info btn-sm pull-right" title="Çıkış" onClick="logout(#Session.nickID#);"><span class="glyphicon glyphicon-remove"></span></button>
            <div class="chatbody" id="chatbody">
            <!---<cfinclude  template="chatbody.cfm">--->
            </div>
            <div class="row">
                <div class="col-xs-9">
                    <input type="text" placeholder="Mesajınızı buraya yazın..." class="form-control" />
                </div>
                <div class="col-xs-3">
                    <button class="btn btn-info btn-block"><span class="glyphicon glyphicon-send"></span></button>
                </div>
            </div>

        </div>
    </div>
</div>
</cfoutput>