<cfcomponent extends="Model">
     <cffunction name="init">
     	
     	<!--- Property Validations --->
        <cfset
            validatesPresenceOf(
                properties="name,url"
            )
        />
        <cfset validatesLengthOf(properties="name", minimum=2, maximum=80) />
        <cfset validatesLengthOf(properties="url", minimum=4, maximum=255) />
		<cfset validatesFormatOf(property="url", type="url") />
    </cffunction>
</cfcomponent>