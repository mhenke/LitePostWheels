<cfparam name="params.key" default="" />
<cfparam name="params.pg" default="1" />
<cfparam name="callbackInfo" default="" />

<cfoutput>
<cfif structKeyExists(params, 'pcontroller') AND structKeyExists(params, 'paction')>
	<cfset callbackInfo = "pg=#params.pg#&pcontroller=#params.pcontroller#&paction=#params.paction#" />
</cfif>
#errorMessagesFor("entry")#

#startFormTag(action="save", key="#params.key#", params="#callbackInfo#")#

    #textField(objectName="entry", property="title", label="Title")#
	
	#select(label="Category", objectName="entry", property="categoryid", options=categories)#

    <!---#textArea(objectName="entry", property="body", label="Body")#--->
	#richTextField(objectName='entry', property='body', class="rteditor", rows="5", editor="markitup", includeJSLibrary="false", label="Body")#
	
    #hiddenField(objectName="entry", property="userid")#
	
    #submitTag(value="#titleize(params.action)# Entry")#

#endFormTag()#
</cfoutput>