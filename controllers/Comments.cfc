<!--- Comment Controller --->
<cfcomponent extends="Controller">


	<cffunction name="index">
		<!--- Find all the Comments for listing --->
    	<cfset comments = model("comment").findAll(order="createdAt", include="entry") />
		
		<!--- Set some page view variables --->
		<cfset page.title = "Blog Comments" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="Add Comment", action="add")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="add">
		<!--- Create a new Comment object --->
		<cfset comment = model("comment").new() />
		
		<!--- Find all the entries --->
		<cfset entries = model("entry").findAll(order="createdAt DESC") />
		
		<!--- Set some page view variables --->
		<cfset page.title = 'Create New Comment' />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Comments", action="index")#
			</cfoutput>
		</cfsavecontent>
		
		<!--- Render View --->
		<cfset renderPage(action="edit") />
		
	</cffunction>
	
	
	
	<cffunction name="edit">
		<!--- Grab the Comment object by key --->
	    <cfset comment = model("comment").findByKey(params.key) />
		
		<!--- Find all the entries --->
		<cfset entries = model("entry").findAll(order="createdAt DESC") />
		
		<!--- Set some page view variables --->
	    <cfset page.title = "Update Comment" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Comments", action="index", title="Comment List")# | 
				#linkTo(text="Add Comment", action="add")# | 
				#linkTo(text="Delete Comment", action="delete", key=params.key, title="Delete Comment", confirm="Are you sure that you want to delete this comment?")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="save">
		<!--- Set params.pg default --->
		<cfparam name="params.pg" default="1" />
	
		<!--- Updating a Comment object --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the Comment object by key --->
			<cfset comment = model("comment").findByKey(params.key) />
		    <cfset params.comment.id = params.key />
			
			<!--- Set some page view variables --->
		    <cfset page.title = "Update Comment" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Comments", action="index", title="Comment List")# | 
					#linkTo(text="Add Comment", action="add")# | 
					#linkTo(text="Delete Comment", action="delete", key=params.key, title="Delete Comment", confirm="Are you sure that you want to delete this comment?")#
				</cfoutput>
			</cfsavecontent>
			
	       <!--- Update the Comment --->
		    <cfif comment.update(params.comment)>
		    
				<!--- Success Message --->
			    <cfset flashInsert(success="Comment updated successfully.") />
				
				<!--- Redirect --->
				<cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
					<cfset redirectTo(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#&comments=show&entry=#comment.entryid#", anchor="entry#comment.entryid#") />
				<cfelse>
	            	<cfset redirectTo(controller="comments", action="index") />
				</cfif>
				
	        <!--- Handle errors --->
	        <cfelse>
	        
	        	<!--- Find all the entries --->
				<cfset entries = model("entry").findAll(order="createdAt DESC") />
	        
				<!--- Render View --->
	            <cfset renderPage(controller="comments", action="edit", key=comment.id) />
	        </cfif>
					
		<!--- Creating a Comment object --->
		<cfelse>
		
			<!--- Create the comment object --->
		    <cfset comment = model("comment").new(params.comment) />
			
			<!--- Set some page view variables --->
			<cfset page.title = "Create New Comment" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Comments", action="index")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Save the comment --->
			<cfif comment.save()>
			
				<!--- Success Message --->
			    <cfset flashInsert(success="Comment created successfully.") />
				
				<!--- Redirect --->
	            <cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
					<cfset redirectTo(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#&comments=show&entry=#comment.entryid#", anchor="entry#comment.entryid#") />
				<cfelse>
	            	<cfset redirectTo(controller="comments", action="index") />
				</cfif>

				
	        <!--- Handle errors --->
	        <cfelse>
	        
	        	<!--- Find all the entries --->
				<cfset entries = model("entry").findAll(order="createdAt DESC") />
				
				<!--- Render View --->
				<cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
					<cfset renderPage(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#") />
				<cfelse>
	            	<cfset renderPage(controller="comments", action="edit") />
				</cfif>
	        </cfif>
			
		</cfif>
		
	</cffunction>
	
	
	
	<cffunction name="savecomment">
	
		<!--- Create the comment object --->
	    <cfset comment = model("comment").new(params.comment) />
		
		<!--- Set the entryid for the object --->
		<cfset comment.entryid = params.key />
		
		<cfparam name="params.pg" default="1" />
		
		<!--- Save the comment --->
		<cfif comment.save()>
		
			<!--- Success Message --->
		    <cfset flashInsert(success="Comment created successfully.") />
			
			<!--- Redirect --->
            <cfset redirectTo(controller="#params.pcontroller#", action="#params.paction#", key=params.category, params="comments=show&entry=#params.key#&pg=#params.pg#", anchor="entry#params.key#") />
			
        <!--- Handle errors --->
        <cfelse>
			
			<!--- Error Message --->
		    <cfset flashInsert(error="There was an problem creating your comment. Please try again.") />
			
			<!--- Redirect --->
            <cfset redirectTo(controller="#params.pcontroller#", action="#params.paction#", key=params.category, params="comments=add&entry=#params.key#&pg=#params.pg#") />
        </cfif>
			
	</cffunction>
	
	
	
	<cffunction name="delete">
		<!--- Grab the Comment object by key --->
	    <cfset comment = model("comment").findByKey(params.key) />
		
		<!--- Delete Comment --->
	    <cfset comment.delete() />
		
		<!--- Success Message --->
	    <cfset flashInsert(success="Comment successfully deleted.") />
		
		<!--- Redirect --->
		<cfif structKeyExists(params, "pcontroller") AND structKeyExists(params, "paction")>
			<cfset redirectTo(controller=params.pcontroller, action=params.paction, params="pg=#params.pg#&comments=show&entry=#comment.entryid#", anchor="entry#comment.entryid#") />
		<cfelse>
        	<cfset redirectTo(controller="comments", action="index") />
		</cfif>
	</cffunction>
</cfcomponent>