<cfcomponent extends="Model">
     <cffunction name="init">
     	<!--- Hash the passwords after validating that they match --->
     	<cfset afterValidation("passwordHash")>
     	
     	<!--- Associations --->
     	<cfset hasMany("entries") />
     	
     	<!--- Property Validations --->
        <cfset
            validatesPresenceOf(
                properties="firstName,lastName,email,accountname,role"
            )
        />
        <cfset validatesLengthOf(properties="firstName", minimum=2, maximum=30) />
        <cfset validatesLengthOf(properties="lastName", minimum=2, maximum=30) />
        <cfset validatesLengthOf(properties="email", minimum=5, maximum=100) />
        <cfset validatesLengthOf(properties="accountname", minimum=4, maximum=20) />
        <cfset validatesLengthOf(properties="accountname", minimum=4, maximum=20) />
        <cfset validatesLengthOf(properties="role", minimum=1, maximum=50) />
        <cfset validatesFormatOf(property="email", type="email") />
        <cfset validatesUniquenessOf(property="accountName") />
        <cfset validatesLengthOf(properties="password", minimum=8, maximum=255) />
        <cfset validatesConfirmationOf(property="password") />
    </cffunction>
	
	<!--- Function for hashing passwords --->
	<cffunction name="passwordHash">
		<cfif structKeyExists(user, "password")>
	        <cfset this.password = lcase(hash(trim(user.password), "SHA")) />
			<cfset this.save() />
		</cfif>
        <cfreturn true>
    </cffunction>
</cfcomponent>