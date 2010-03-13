<cfparam name="title" default="" />
<cfparam name="params.key" default="" />

<cfoutput>

#errorMessagesFor("category")#

#startFormTag(action="save", key="#params.key#")#

    #textField(objectName="category", property="category", label="Category Name")#

    #submitTag(value="#titleize(params.action)# Category")#

#endFormTag()#

</cfoutput>