<!---<cfdump  var="#form#">  --->
<cfif form.islem eq "nickSend"><!--- Oturum açıldığında --->
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
    
<cfelseif form.islem eq "messageSend"><!--- Mesaj gönderildiğinde --->
    <cfquery datasource="imsg" name="insertMsg">
        INSERT INTO messages(senderID, recieverID, message)
        VALUES (#form.sender#, #form.reciever#, '#form.message#')
    </cfquery>
    
<cfelseif form.islem eq "contactAdd"><!--- Arkadaş eklendiğinde --->
    <cfquery datasource="imsg" name="checkContactReq">
        SELECT  contactID, status 
        FROM    contacts 
        WHERE   nickID1 = #session.nickID# AND 
                nickID2 = #form.reciever#
                
        UNION
        
        SELECT  contactID, status 
        FROM    contacts 
        WHERE   nickID1 = #form.reciever# AND 
                nickID2 = #session.nickID#
    </cfquery>
    <cfif not checkContactReq.recordCount><!--- Hiç istek gönderilmediyse --->
        <cfquery datasource="imsg" name="contactReq">
            INSERT INTO contacts(nickID1, nickID2)
            VALUES (#session.nickID#, #form.reciever#)
        </cfquery>
    <cfelse><!--- Daha önce istek gönderildiyse ve ret edildiyse --->
        <cfquery datasource="imsg" name="contactReqUpdate">
            UPDATE  contacts
            SET     nickID1 = #session.nickID#,
					nickID2 = #form.reciever#,
					status = 2
            WHERE   contactID = #checkContactReq.contactID#
        </cfquery>
    </cfif>
    
<cfelseif form.islem eq "requestStatus"><!--- Arkadaşlık isteği yanıtlama--->
	<cfquery datasource="imsg" name="contactReqUpdate">
        UPDATE  contacts
        SET     status = #form.status#
        WHERE   contactID = #form.contactID#
    </cfquery>
    
<cfelseif form.islem eq "changeReciever"><!--- Alıcı değiştirildiğinde --->
	<cfset session.Reciever = form.reciever>
    
<cfelseif form.islem eq "logout"><!--- Çıkış yapıldığında --->
    <cfquery datasource="imsg" name="logoutUpdate">
        UPDATE  nicks 
        SET     loginState = '0', loginTime = GETDATE()
        WHERE   nickID = #Session.nickID#
    </cfquery>
    <cfset structClear(Session)>
    <meta http-equiv="refresh" content="0">
</cfif>
