<!--- Entry Controller --->
<cfcomponent extends="Controller">


	<cffunction name="index">
		<!--- Find all the Entries for listing --->
    	<cfset entries = model("entry").findAll(order="createdAt DESC", include="category,user") />
		
		<!--- Set some page view variables --->
		<cfset page.title = "Blog Entries" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="Add Entry", action="add")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="add">
		<!--- Create a new Entry object --->
		<cfset entry = model("entry").new() />
		<cfset categories = model("category").findAll(order="category") />
		
		<!--- Set some page view variables --->
		<cfset page.title = 'Create New Entry' />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Entries", action="index")#
			</cfoutput>
		</cfsavecontent>
		<cfset submitTo = 'create' />
		
		<!--- Render View --->
		<cfset renderPage(action="edit") />
		
	</cffunction>
	
	
	
	<cffunction name="edit">
		<!--- Grab the Entry object by key --->
	    <cfset entry = model("entry").findByKey(params.key) />
		<cfset categories = model("category").findAll(order="category") />
		
		<!--- Set some page view variables --->
	    <cfset page.title = "Update entry '#entry.title#'" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Entries", action="index", title="Entry List")# | 
				#linkTo(text="Add Entry", action="add")# | 
				#linkTo(text="Delete Entry", action="delete", key=params.key, title="Delete #entry.title#", confirm="Are you sure that you want to delete #entry.title#?")#
			</cfoutput>
		</cfsavecontent>
	    <cfset submitTo = 'update' />
		
	</cffunction>
	
	
	
	<cffunction name="save">
		<!--- Set params.pg default --->
		<cfparam name="params.pg" default="1" />
		
		<!--- Updating an Entry object --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the Entry object by key --->
		    <cfset entry = model("entry").findByKey(params.key) />
		    <cfset params.entry.id = params.key />
			
			<!--- Set some page view variables --->
		    <cfset page.title = "Update entry '#entry.title#'" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Entries", action="index", title="Entry List")# | 
					#linkTo(text="Add Entry", action="add")# | 
					#linkTo(text="Delete Entry", action="delete", key=params.key, title="Delete #entry.title#", confirm="Are you sure that you want to delete #entry.title#?")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Update the Entry --->
	        <cfif entry.update(params.entry)>
	        
	        	<!--- Success Message --->
			    <cfset flashInsert(success="Entry '#entry.title#' updated successfully.") />
				
				<!--- Redirect --->
				<cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
					<cfset redirectTo(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#&entry=#entry.id#", anchor="entry#entry.id#") />
				<cfelse>				
	            	<cfset redirectTo(action="index") />
				</cfif>
				
	        <!--- Handle errors --->
	        <cfelse>
				
				<!--- Render View --->
	            <cfset renderPage(action="edit", key=entry.id) />
	        </cfif>
			
		<!--- Creating an Entry object --->
		<cfelse>
		
			<!--- Set the userID to the user logged in --->
			<cfset params.entry.userid = session.user.id />
			
			<!--- Create the Entry object --->
		    <cfset entry = model("entry").new(params.entry) />
			
			<!--- Set some page view variables --->
			<cfset page.title = "Create New Entry" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Entries", action="index")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Save the Entry --->
			<cfif entry.save()>
			
				<!--- Success Message --->
			    <cfset flashInsert(success="Entry '#entry.title#' created successfully.") />
				
				<!--- Redirect --->
	            <cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
					<cfset redirectTo(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#&entry=#entry.id#", anchor="entry#entry.id#") />
				<cfelse>				
	            	<cfset redirectTo(action="index") />
				</cfif>
				
			<!--- Handle errors --->
	        <cfelse>
				
				<!--- Render View --->
	            <cfset renderPage(action="edit") />
	        </cfif>
		</cfif>
		
	</cffunction>

	
	
	<cffunction name="delete">
	
		<!--- Grab the Entry object by key --->
	    <cfset entry = model("entry").findByKey(params.key) />
		
		<!--- Delete the Entry --->
	    <cfset entry.delete() />
		
		<!--- Success Message --->
	    <cfset flashInsert(success="Entry '#entry.title#' was successfully deleted.") />
		
		<!--- Redirect --->
	    <cfset redirectTo(action="index") />
		
	</cffunction>
</cfcomponent>