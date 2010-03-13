<cfcomponent extends="Model">
     <cffunction name="init">
     	<!--- Associations --->
     	<cfset hasMany("entries") />
     	
     	<!--- Property Validations --->
        <cfset
            validatesPresenceOf(
                properties="category"
            )
        />
        <cfset validatesLengthOf(properties="category", minimum=1, maximum=255) />
    </cffunction>
</cfcomponent>