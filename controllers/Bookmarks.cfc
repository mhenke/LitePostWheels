<!--- Bookmark Controller --->
<cfcomponent extends="Controller">


	<cffunction name="index">
		<!--- Find all the Bookmarks for listing --->
    	<cfset bookmarks = model("bookmark").findAll(order="name") />
		
		<!--- Set some page view variables --->
		<cfset page.title = "Bookmarks" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="Add Bookmark", action="add")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="add">
		<!--- Create a new Category object --->
		<cfset bookmark = model("bookmark").new() />
		
		<!--- Set some page view variables --->
		<cfset page.title = 'Create New Bookmark' />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Bookmarks", action="index")#
			</cfoutput>
		</cfsavecontent>
		
		<!--- Render View --->
		<cfset renderPage(action="edit") />
		
	</cffunction>

	
	
	<cffunction name="edit">
		<!--- Grab the Category object by key --->
	    <cfset bookmark = model("bookmark").findByKey(params.key) />
		
		<!--- Set some page view variables --->
	    <cfset page.title = "Update '#bookmark.name#'" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Bookmarks", action="index", title="Bookmark List")# | 
				#linkTo(text="Add Bookmark", action="add")# | 
				#linkTo(text="Delete Bookmark", action="delete", key=params.key, title="Delete #bookmark.name#", confirm="Are you sure that you want to delete #bookmark.name#?")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>

	
	
	<cffunction name="save">
		<!--- Updating an Bookmark object --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the Bookmark object by key --->
			<cfset bookmark = model("bookmark").findByKey(params.key) />
		    <cfset params.bookmark.id = params.key />
			
			<!--- Set some page view variables --->
		    <cfset page.title = "Update bookmark '#bookmark.name#'" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Bookmarks", action="index", title="Bookmark List")# | 
					#linkTo(text="Add Bookmark", action="add")# | 
					#linkTo(text="Delete Bookmark", action="delete", key=params.key, title="Delete #bookmark.name#", confirm="Are you sure that you want to delete #bookmark.name#?")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Update the Bookmark --->
	        <cfif bookmark.update(params.bookmark)>
	        
	        	<!--- Success Message --->
			    <cfset flashInsert(success="Bookmark '#bookmark.name#' updated successfully.") />
				
				<!--- Redirect --->
	            <cfset redirectTo(action="index") />
				
				
	        <!--- Handle errors --->
	        <cfelse>
	        
	        	<!--- Render View --->
	            <cfset renderPage(action="edit", key=bookmark.id) />
	        </cfif>
					
		<!--- Creating an Bookmark object --->
		<cfelse>
		
			<!--- Create the Bookmark object --->
		    <cfset bookmark = model("bookmark").new(params.bookmark) />
			
			<!--- Set some page view variables --->
			<cfset page.title = "Create New bookmark" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Bookmarks", action="index")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Save the Bookmark --->
			<cfif bookmark.save()>
			
				<!--- Success Message --->
			    <cfset flashInsert(success="Bookmark '#bookmark.name#' created successfully.") />
	            
				<!--- Redirect --->
				<cfset redirectTo(action="index") />
				
	        <!--- Handle errors --->
	        <cfelse>
	        
				<!--- Render View --->
	            <cfset renderPage(action="edit") />
	        </cfif>
				
		</cfif>
		
	</cffunction>

	
	
	<cffunction name="delete">
		<!--- Grab the Bookmark object by key --->
	    <cfset bookmark = model("bookmark").findByKey(params.key) />
		
		<!--- Delete the Bookmark --->
	    <cfset bookmark.delete() />
		
		<!--- Success Message --->
	    <cfset flashInsert(success="Bookmark '#bookmark.name#' was successfully deleted.") />
		
		<!--- Redirect --->
	    <cfset redirectTo(action="index") />
		
	</cffunction>
</cfcomponent>