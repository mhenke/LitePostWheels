<cfparam name="params.key" default="" />

<cfoutput>

#errorMessagesFor("user")#

#startFormTag(action="updatePassword", key="#params.key#")#
	
	#passwordField(objectName="user", property="password", label="Password")#
	
	#passwordField(objectName="user", property="passwordConfirmation", label="Confirm Password")#

    #submitTag(value="Update #titleize(params.action)#")#

#endFormTag()#
</cfoutput>