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
</cfquery>
<cfloop query="contactList">
    <a href="?msg=15" class="chatperson">
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
</cfoutput>