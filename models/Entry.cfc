<cfcomponent extends="Model">
     <cffunction name="init">
     	<!--- Associations --->
     	<cfset belongsTo("user") />
     	<cfset belongsTo("category") />
     	<cfset hasMany("comments") />
     	
     	<!--- Property Validations --->
        <cfset
            validatesPresenceOf(
                properties="title,body,userid,categoryid"
            )
        />
        <cfset validatesLengthOf(properties="title", minimum=2, maximum=255) />
        <cfset validatesLengthOf(properties="body", minimum=1) />
        <cfset validatesLengthOf(properties="userid", minimum=1, maximum=11) />
        <cfset validatesLengthOf(properties="categoryid", minimum=1, maximum=11) />
    </cffunction>
</cfcomponent>