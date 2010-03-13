<cfparam name="params.key" default="" />
<cfparam name="submitTo" default="" />

<cfoutput>

#errorMessagesFor("bookmark")#

#startFormTag(action="#submitTo#", key="#params.key#")#

    #textField(objectName="bookmark", property="name", label="Bookmark Name")#
	
    #textField(objectName="bookmark", property="url", label="URL")#

    #submitTag(value="#titleize(params.action)# Bookmark")#

#endFormTag()#

</cfoutput>