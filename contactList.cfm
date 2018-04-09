<cfoutput>
<cfquery datasource="iMsg" name="contactList">
    SELECT	DISTINCT TOP (200) contacts.contactID, nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks INNER JOIN
            contacts ON nicks.nickID = contacts.nickID2
    WHERE	(contacts.nickID1 = #Session.nickID#)

    UNION

    SELECT	DISTINCT TOP (200) contacts.contactID, nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks INNER JOIN
            contacts ON nicks.nickID = contacts.nickID1
    WHERE	(contacts.nickID2 = #Session.nickID#)
    ORDER BY nicks.loginState DESC
</cfquery>
<cfif contactList.recordCount>
    <cfloop query="contactList">
        <a href="##" id="#nickID#" class="chatperson">
            <span class="chatimg">
                <img src="http://via.placeholder.com/50x50?text=A" alt="" />
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
<cfelse>
    <div class="alert alert-danger">
        <h5>:( Üzgünüz</h5><h6>Hiç arkadaşınız yok!</h6>
    </div>
</cfif>

<cfquery datasource="imsg" name="nonContactList">
    SELECT nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
    FROM	nicks
    WHERE (nicks.nickID <> #Session.nickID#)
    EXCEPT (
        SELECT	DISTINCT TOP (200) nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
        FROM	nicks INNER JOIN
                contacts ON nicks.nickID = contacts.nickID2
        WHERE	(contacts.nickID1 = #Session.nickID#)

        UNION

        SELECT	DISTINCT TOP (200) nicks.nickID, nicks.nick, nicks.ip, nicks.loginTime, nicks.loginState
        FROM	nicks INNER JOIN
                contacts ON nicks.nickID = contacts.nickID1
        WHERE	(contacts.nickID2 = #Session.nickID#)
    )
    ORDER BY nicks.loginState DESC
</cfquery>
<cfif nonContactList.recordCount>
    <hr/>
    Arkadaş Ekle
    <cfloop query="noncontactList">
        <a href="##" class="chatperson" onClick="contactRequest(#nickID#);">
            <span class="chatimg">
                <button class="btn glyphicon glyphicon-plus">
                <!---<span class="glyphicon glyphicon-plus"></span>--->
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
    </cfloop>
</cfif>
</cfoutput>