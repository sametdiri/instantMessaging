<cfoutput>
<div>
<!--- Arkadaşlık isteklerini gösteren kısım --->
<cfquery datasource="iMsg" name="contactRequestList">
    SELECT	DISTINCT contacts.contactID, nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks INNER JOIN
            contacts ON nicks.nickID = contacts.nickID1
    WHERE	(contacts.nickID2 = #Session.nickID#) AND
            (contacts.status = 2)
    ORDER BY nicks.loginState DESC
</cfquery>
<cfif contactRequestList.recordCount>
	<h5>Arkadaşlık İstekleri</h5>
    <cfloop query="contactRequestList">
        <a href="##" id="#nickID#" class="chatperson">
            <span class="chatimg">
                <button id="#nickID#" class="btn glyphicon glyphicon-plus" onclick="requestStatus(#contactID#, 1);" style="zoom:50%;"></button>
                <button id="#nickID#" class="btn glyphicon glyphicon-minus" onclick="requestStatus(#contactID#, 0);" style="zoom:50%;"></button>
            </span>
 
            <div class="namechat">
                <div class="pname">#nick#</div>
                <div class="lastmsg">
                    <cfif loginState>
                        <span class="alert-success">
                            Online
                        </span>
                    <cfelse>
                        <span class="alert-danger">
                            Offline (Son giriş zamanı: #DateFormat(loginTime, "dd/mm/yyyy")# #TimeFormat(loginTime, "hh:MM:ss")#)
                        </span>
                    </cfif>
                </div>
            </div>
    	</a>
    </cfloop>
</cfif>
<hr />

<!--- Arkadaşları gösteren kısım --->
<cfquery datasource="iMsg" name="contactList">
    SELECT	DISTINCT TOP (200) contacts.contactID, nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks INNER JOIN
            contacts ON nicks.nickID = contacts.nickID2
    WHERE	(contacts.nickID1 = #Session.nickID#) AND
            (contacts.status = 1)

    UNION

    SELECT	DISTINCT TOP (200) contacts.contactID, nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks INNER JOIN
            contacts ON nicks.nickID = contacts.nickID1
    WHERE	(contacts.nickID2 = #Session.nickID#) AND
            (contacts.status = 1)
    ORDER BY nicks.loginState DESC
</cfquery>
<cfif contactList.recordCount>
    <cfloop query="contactList">
    	<cfquery datasource="iMsg" name="messageCheck">
        	SELECT	COUNT(msgID) AS msgCount
            FROM	messages
            WHERE	(seen = 0) AND (recieverID = #Session.nickID#) AND (senderID = #nickID#)
        </cfquery>
        <a href="##" id="#nickID#" class="chatperson" onclick="changeReciever(#nickID#);">
            <span class="chatimg">
                <img src="http://via.placeholder.com/50x50?text=A" alt="" />
            </span>
            <div class="namechat">
                <div class="pname">#nick# #messageCheck.msgCount gt 0 ? "<span style='font-weight:bold; color:red;'>("&messageCheck.msgCount&")</span>" : ""#</div>
                <div class="lastmsg">
                    <cfif loginState>
                        <span class="alert-success">
                            Online
                        </span>
                    <cfelse>
                        <span class="alert-danger">
                            Offline (Son giriş zamanı: #DateFormat(loginTime, "dd/mm/yyyy")# #TimeFormat(loginTime, "hh:MM:ss")#)
                        </span>
                    </cfif>
                </div>
            </div>
        </a>
    </cfloop>
<cfelse>
    <div class="alert alert-danger">
        <h5>:( Üzgünüz</h5><h6>Hiç arkadaşınız yok!</h6>
    </div>
</cfif>

<!--- Arkadaş olmayan kullanıcıları gösteren kısım --->
<cfquery datasource="imsg" name="nonContactList">
	SELECT	DISTINCT dbo.nicks.nickID, dbo.nicks.nick, dbo.nicks.ip, dbo.nicks.loginTime, dbo.nicks.loginState
	FROM 	dbo.nicks
	WHERE	(dbo.nicks.nickID <> #Session.nickID#)
</cfquery>
<cfquery datasource="iMsg" name="contactReqs">
	SELECT	DISTINCT dbo.nicks.nickID
	FROM	dbo.nicks INNER JOIN
			dbo.contacts ON dbo.nicks.nickID = dbo.contacts.nickID1
	WHERE	(dbo.contacts.nickID2 = #Session.nickID#) AND
			(dbo.contacts.status IN (1,2))
	UNION
	SELECT	DISTINCT dbo.nicks.nickID
	FROM	dbo.nicks INNER JOIN
			dbo.contacts ON dbo.nicks.nickID = dbo.contacts.nickID2
	WHERE	(dbo.contacts.nickID1 = #Session.nickID#) AND
			(dbo.contacts.status IN (1,2))
</cfquery>
<cfset reqList = ValueList(contactReqs.nickID)>
<cfif nonContactList.recordCount>
    <hr/>
    Arkadaş Ekle
    <cfloop query="noncontactList">
    	<!---<cfif noncontactList.status eq "" or noncontactList.status eq 0>--->
		<cfif not listFind(reqList, noncontactList.nickID)>
            <a href="##" class="chatperson" id="#nickID#" onClick="contactRequest(#nickID#);">
                <span class="chatimg">
                    <button id="#nickID#" class="btn glyphicon glyphicon-plus">
                    </button>
                </span>
                <div class="namechat">
                    <div class="pname">#nick#</div>
                    <div class="lastmsg">
                        <cfif loginState>
                            <span class="alert-success">
                                Online
                            </span>
                        <cfelse>
                            <span class="alert-danger">
                                Offline (Son giriş zamanı: #DateFormat(loginTime, "dd/mm/yyyy")# #TimeFormat(loginTime, "hh:MM:ss")#)
                            </span>
                        </cfif>
                    </div>
                </div>
            </a>
    	</cfif>
    </cfloop>
</cfif>
</div>
</cfoutput>