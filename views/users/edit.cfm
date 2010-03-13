<cfparam name="params.key" default="" />

<cfoutput>

#errorMessagesFor("user")#

#startFormTag(action="save", key="#params.key#")#

    #textField(objectName="user", property="firstName", label="First Name")#
	
    #textField(objectName="user", property="lastName", label="Last Name")#

    #textField(objectName="user", property="email", label="Email")#
	
    #textField(objectName="user", property="accountName", label="AccountName")#
	
    #textField(objectName="user", property="role", label="Role")#

<cfif params.action EQ 'add' OR params.action EQ 'create'>
    #passwordField(objectName="user", property="password", label="Password")#
	
	#passwordField(objectName="user", property="passwordConfirmation", label="Confirm Password")#
</cfif>

    #submitTag(value="#titleize(params.action)# User")#

#endFormTag()#
</cfoutput>