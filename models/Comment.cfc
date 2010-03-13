<cfcomponent extends="Model">
     <cffunction name="init">
     	<!--- Associations --->
     	<cfset belongsTo("entry") />
     	
     	<!--- Property Validations --->
        <cfset
            validatesPresenceOf(
                properties="comment,name,entryid"
            )
        />
        <cfset validatesLengthOf(properties="comment", minimum=1) />
        <cfset validatesLengthOf(properties="name", minimum=2, maximum=80) />
        <cfset validatesLengthOf(properties="entryid", minimum=1, maximum=11) />
        <cfset validatesLengthOf(properties="email", minimum=4, maximum=100, if="this.email NEQ ''") />
        <cfset validatesLengthOf(properties="url", minimum=4, maximum=150, if="this.url NEQ ''") />
        <cfset validatesFormatOf(property="url", type="url", if="this.url NEQ ''") />
        <cfset validatesFormatOf(property="email", type="email", if="this.email NEQ ''") />
    </cffunction>
</cfcomponent>