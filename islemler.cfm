<cfdump  var="#form#"><!---  --->
<cfif form.islem eq "nickSend">
    <cfquery datasource="iMsg" name="nickCheck">
        DECLARE @@nickID int = 0

        SELECT  @@nickID = nickID
        FROM    nicks
        WHERE   (nick = '#form.nick#')
        IF(@@ROWCOUNT = 0)
        BEGIN
            INSERT INTO nicks(nick, ip) VALUES ('#form.nick#', '#CGI.REMOTE_ADDR#')
            SELECT @@nickID = @@identity
        END
        ELSE
        BEGIN
            UPDATE  nicks 
            SET     ip = '#CGI.REMOTE_ADDR#', loginState = '1', loginTime = GETDATE()
            WHERE   nickID = @@nickID
        END
        SELECT @@nickID AS nickID
    </cfquery>
    <cfset Session.nickID = nickCheck.nickID>
    <cfinclude  template="mainWindow.cfm">
<cfelseif form.islem eq "messageSend">
    <cfquery datasource="imsg" name="insertMsg">
        INSERT INTO messages(senderID, recieverID, message)
        VALUES (#form.sender#, #form.reciever#, '#form.message#')
    </cfquery>
<cfelseif form.islem eq "contactAdd">
    <cfquery datasource="imsg" name="checkContactReq">
        SELECT  contactID, status 
        FROM    contacts 
        WHERE   nickID1 = #session.nickID# AND 
                nickID2 = #form.reciever#
    </cfquery>
    <cfif not checkContactReq.recordCount>
        <cfquery datasource="imsg" name="contactReq">
            INSERT INTO contacts(nickID1, nickID2)
            VALUES (#session.nickID#, #form.reciever#)
        </cfquery>
    <cfelse>
        <cfquery datasource="imsg" name="contactReqUpdate">
            UPDATE  contacts
            SET     status = 2
            WHERE   contactID = #checkContactReq.contactID#
        </cfquery>
    </cfif>
<cfelseif form.islem eq "contactRequests">
<script>
    alert("Çalıştı!");
</script>
    <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
<cfelseif form.islem eq "logout">
    <cfquery datasource="imsg" name="logoutUpdate">
        UPDATE  nicks 
        SET     loginState = '0', loginTime = GETDATE()
        WHERE   nickID = #Session.nickID#
    </cfquery>
    <cfset structClear(Session)>
    <meta http-equiv="refresh" content="0">
</cfif>