<!---<cfdump  var="#form#">  --->
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
    <cfquery datasource="imsg" name="contactReq">
        INSERT INTO contacts(nickID1, nickID2)
        VALUES (#session.nickID#, ##)
    </cfquery>
<cfelseif form.islem eq "logout">
    <cfquery datasource="imsg" name="logoutUpdate">
        UPDATE  nicks 
        SET     loginState = '0', loginTime = GETDATE()
        WHERE   nickID = #Session.nickID#
    </cfquery>
    <cfset structClear(Session)>
    <meta http-equiv="refresh" content="0">
</cfif>