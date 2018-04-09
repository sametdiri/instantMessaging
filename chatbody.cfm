<cfoutput>
<cfquery datasource="imsg" name="getMessages">
    SELECT  msgID, senderID, recieverID, message, sendDate
    FROM    messages
    WHERE   (senderID = #session.nickID# AND recieverID = #session.reciever#) OR
            (senderID = #session.reciever# AND recieverID = #session.nickID#)
    ORDER BY sendDate
</cfquery>
<cfif getMessages.recordCount>
    <table class="table">
        <cfloop query="getMessages">
            <tr>
                <td class="avatar"><img src="http://via.placeholder.com/50x50?text=A" /></td>
                <td class="msg">#message#</td>
                <td class="dtime">#dateFormat(sendDate, "dd/mm/yyyy")# #timeFormat(sendDate, "HH:mm:ss")#</td>
            </tr>
        </cfloop>
    </table>
<cfelse>
    <div class="alert alert-info">
        Henüz mesaj gönderilmemiş. Yeni bir konuşma başlatmak için bir şeyler yazın.
    </div>
</cfif>
</cfoutput>