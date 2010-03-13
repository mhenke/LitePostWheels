<cfoutput>

#startFormTag(action="signin")#

#textField(label = "Username", objectName="user", property="accountName")#
#passwordField(label="password", objectName="user", property="password")#
<div>#submitTag(value="Sign in")#</div>

#endFormTag()#

</cfoutput>