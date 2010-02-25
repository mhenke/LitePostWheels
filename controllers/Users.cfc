<!--- User Controller - Admin users of the blog software --->
<cfcomponent extends="Controller">


	<cffunction name="index">
		<!--- Find all the users for listing --->
    	<cfset users = model("user").findAll(order="firstName") />
		
		<!--- Set some page view variables --->
		<cfset page.title = "Admin Users" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="Add User", action="add")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="add">
		<!--- Create a new user object --->
		<cfset user = model("user").new() />
		
		<!--- Set some page view variables --->
		<cfset page.title = 'Create New User' />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Users", action="index", title="User List")#
			</cfoutput>
		</cfsavecontent>
		
		<cfset submitTo = 'create' />
		
		<!--- Render View --->
		<cfset renderPage(action="edit") />
		
	</cffunction>
	
	
	
	<cffunction name="edit">
		<!--- Grab the user object by key --->
	    <cfset user = model("user").findByKey(params.key) />
		
		<!--- Set some page view variables --->
	    <cfset page.title = 'Update ' & user.firstName />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Users", action="index", title="User List")# | 
				#linkTo(text="Add User", action="add")# | 
				#linkTo(text="Delete User", action="delete", key=params.key, title="Delete #user.firstName#", confirm="Are you sure that you want to delete #user.firstName#?")#
			</cfoutput>
		</cfsavecontent>
		
	    <cfset submitTo = 'update' />
		
	</cffunction>
	
	
	
	<cffunction name="save">
		<!--- Updating a user object --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the user object by key --->
		    <cfset user = model("user").findByKey(params.key) />
		   
			<!--- Set some page view variables --->
			<cfset page.title = 'Update ' & user.firstName />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Users", action="index", title="User List")# | 
					#linkTo(text="Add User", action="add")# | 
					#linkTo(text="Delete User", action="delete", key=params.key, title="Delete #user.firstName#", confirm="Are you sure that you want to delete #user.firstName#?")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Update the user --->
	        <cfif user.update(params.user)>
	        
	        	<!--- Success Message --->
			    <cfset flashInsert(success="#user.firstName# was updated successfully.") />
				
				<!--- Redirect --->
	            <cfset redirectTo(action="index") />
				
	        <!--- Handle errors --->
	        <cfelse>
				
				<!--- Render View --->
	            <cfset renderPage(action="edit", key=user.id) />
	        </cfif>
		
		<!--- Creating a user object --->
		<cfelse>
		
			<!--- If no User struct in the params, redirect --->
			<cfif NOT structKeyExists(params, 'user')>
				<cfset redirectTo(action="index") />
			</cfif>
			
			<!--- Set some page view variables --->
			<cfset page.title = "Create New User" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Users", action="index", title="User List")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Create the user object --->
			<cfset user = model("user").new(params.user) />
			
			<!--- Save the user --->
			<cfif user.save()>
				<!--- Send a confirmation email --->
				<cfset sendEmail(
			        from="Lite Post <aaron.wells@usu.edu>",
			        to=params.user.email,
			        template="newuseremail",
			        subject="Welcome to the Lite Post!",
					type="html",
			        recipientName=user.firstName,
			        startDate=now()
				    )
				/>
				
				<!--- Success Message --->
			    <cfset flashInsert(success="#user.firstName# was created successfully.") />
				
				<!--- Redirect --->
	            <cfset redirectTo(action="index") />
				
	        <!--- Handle errors --->
	        <cfelse>
	        	<!--- Clear the attempted password --->
				<cfset user.password ="" />
				
				<!--- Render View --->
	            <cfset renderPage(action="edit") />
	        </cfif>
			
		</cfif>
		
	</cffunction>	
	
	
	
	<cffunction name="delete">
		<!--- Grab the user object by key --->
	    <cfset user = model("user").findByKey(params.key) />
		
		<!--- Delete the user --->
	    <cfset user.delete() />
		
		<!--- Success Message --->
	    <cfset flashInsert(success="#user.firstName# was successfully deleted.") />
		
		<!--- Redirect --->
	    <cfset redirectTo(action="index") />
		
	</cffunction>
	
	
	
	<cffunction name="password">
		<!--- Grab the user object by key --->
	    <cfset user = model("user").findByKey(params.key) />
		
		<!--- set the password property to blank --->
		<cfset user.password = '' />
		
		<!--- Set some page view variables --->
	    <cfset page.title = 'Update Password' />
		
	</cffunction>
	
	
	
	<cffunction name="updatePassword">
		<!--- Grab the user object by key --->
	    <cfset user = model("user").findByKey(params.key) />
	 
	 	<!--- Set some page view variables --->
	    <cfset page.title = 'Update Password' />
		
		<!--- If the user struct exists in params, update the user --->
		<cfif structKeyExists(params, "user")>
			<!--- Update the user's password --->
	        <cfif user.update(params.user)>
	        	<!--- Success Message --->
			    <cfset flashInsert(success="Passsword for #user.firstName# was updated successfully.") />
	            
				<!--- Redirect --->
				<cfset redirectTo(action="index") />
	        <!--- Handle errors --->
	        <cfelse>
	        	<!--- Clear the attempted password --->
				<cfset user.password ="" />
				
				<!--- Render View --->
	            <cfset renderPage(action="password", key=user.id) />
	        </cfif>
		</cfif>
		
	</cffunction>
</cfcomponent>