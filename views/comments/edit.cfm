<cfparam name="params.key" default="" />
<cfparam name="submitTo" default="" />
<cfparam name="entries" default="" />
<cfparam name="params.pg" default="1" />
<cfparam name="callbackInfo" default="" />

<cfoutput>
<cfif structKeyExists(params, 'pcontroller') AND structKeyExists(params, 'paction')>
	<cfset callbackInfo = "pg=#params.pg#&pcontroller=#params.pcontroller#&paction=#params.paction#" />
</cfif>
#errorMessagesFor("comment")#

#startFormTag(action="save", key="#params.key#", params="#callbackInfo#")#

    #textField(objectName="comment", property="name", label="Name")#
	
    #textField(objectName="comment", property="email", label="Email")#
	
    #textField(objectName="comment", property="url", label="URL")#
	
	#select(label="Entry", objectName="comment", property="entryid", options=entries)#

    <!---#textArea(objectName="comment", property="comment", label="Comment")#--->
	#richTextField(objectName="comment", property="comment", class="rteditor", rows="5", editor="markitup", includeJSLibrary="false", label="Comment")#
	
    #submitTag(value="#titleize(params.action)# Comment")#

#endFormTag()#

</cfoutput>