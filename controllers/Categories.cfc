<!--- Category Controller --->
<cfcomponent extends="Controller">


	<cffunction name="index">
		<!--- Find all the Categories for listing --->
    	<cfset categories = model("category").findAll(order="category") />
		
		<!--- Set some page view variables --->
		<cfset page.title = "Categories" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="Add Category", action="add")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="add">
		<!--- Create a new Category object --->
		<cfset category = model("category").new() />
		
		<!--- Set some page view variables --->
		<cfset page.title = 'Create New Category' />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Categories", action="index")#
			</cfoutput>
		</cfsavecontent>
		
		<!--- Render View --->
		<cfset renderPage(action="edit") />
		
	</cffunction>



	<cffunction name="edit">
		<!--- Grab the Category object by key --->
	    <cfset category = model("category").findByKey(params.key) />
		
		<!--- Set some page view variables --->
	    <cfset page.title = "Update '#category.category#'" />
		<cfsavecontent variable="page.actionNav">
			<cfoutput>
				#linkTo(text="List Categories", action="index", title="Category List")# | 
				#linkTo(text="Add Category", action="add")# | 
				#linkTo(text="Delete Category", action="delete", key=params.key, title="Delete #category.category#", confirm="Are you sure that you want to delete #category.category#?")#
			</cfoutput>
		</cfsavecontent>
		
	</cffunction>



	<cffunction name="save">
		<!--- Updating an Category object --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the Category object by key --->
			<cfset category = model("category").findByKey(params.key) />
		    <cfset params.category.id = params.key />
			
			<!--- Set some page view variables --->
		    <cfset page.title = "Update category '#category.category#'" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Categories", action="index", title="Category List")# | 
					#linkTo(text="Add Category", action="add")# | 
					#linkTo(text="Delete Category", action="delete", key=params.key, title="Delete #category.category#", confirm="Are you sure that you want to delete #category.category#?")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Update the Category --->
	        <cfif category.update(params.category)>
	        
				<!--- Success Message --->
			    <cfset flashInsert(success="Category '#category.category#' updated successfully.") />
				
				<!--- Redirect --->
	            <cfset redirectTo(action="index") />
				
	        <!--- Handle errors --->
	        <cfelse>
	        
				<!--- Render View --->	        
	            <cfset renderPage(action="edit", key=category.id) />
	        </cfif>
		
		<!--- Creating an Category object --->
		<cfelse>
			
			<!--- Create the category object --->
		    <cfset category = model("category").new(params.category) />
			
			<!--- Set some page view variables --->
			<cfset page.title = "Create New category" />
			<cfsavecontent variable="page.actionNav">
				<cfoutput>
					#linkTo(text="List Categories", action="index")#
				</cfoutput>
			</cfsavecontent>
			
			<!--- Save the Category --->
			<cfif category.save()>
			
				<!--- Success Message --->
			    <cfset flashInsert(success="Category '#category.category#' created successfully.") />
				
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
		<!--- Grab the Category object by key --->
	    <cfset category = model("category").findByKey(params.key) />
		
		<!--- Delete the Category --->
	    <cfset category.delete() />
		
		<!--- Success Message --->
	    <cfset flashInsert(success="Category '#category.category#' was successfully deleted.") />
		
		<!--- Redirect --->
	    <cfset redirectTo(action="index") />
		
	</cffunction>
	
	
	
	<cffunction name="list">
		<!--- Check if we have a category id --->
		<cfif structKeyExists(params, "key")>
		
			<!--- Grab the Category object by key --->
			<cfset category = model("category").findByKey(params.key) />
			
			<cfparam name="params.pg" default="1" />
		
			<!--- Find all the Categories for listing --->
	    	<cfset entries = model("entry").findAll(maxrows=5, where="categoryid='#params.key#'", order="createdAt DESC", include="user", returnAs="objects", page=params.pg, perPage=5) />
			
			<!--- Create a new Comment object --->
			<cfset comment = model("comment").new() />
			
			<!--- Set some page view variables --->
			<cfset page.title = category.category />
			
			<!--- Set a params page key to use for pagination --->
			<cfset params.pageKey = params.key />
			
			<!--- Render View --->
			<cfset renderPage(controller="entries", action="list") />
			
		<cfelse>
			<!--- Notice Message --->
			<cfset flashInsert(notice="Please select a valid category.") />
			
			<!--- Redirect --->
			<cfset redirectTo(controller="main", action="home") />
		</cfif>
		
	</cffunction>
</cfcomponent>