<!---
	This is the parent controller file that all your controllers should extend.
	You can add functions to this file to make them globally available in all your controllers.
	Do not delete this file.
--->
<cfcomponent extends="Wheels">


	<cffunction name="init">
		<!--- Functions to populate variables for layout --->
		<cfset filters(through="categoryNav,bookmarkNav") />
		
		<!--- Authentication Permissions --->
		<cfset filters(through="checkLogin", except="login,home,signin,savecomment,list,about,contact,rss") />
		
	</cffunction>
	
	
	
	<cffunction name="checkLogin">
		<!--- Check Login Status for pages --->
		<cfif NOT structKeyExists(session, "user")>
			<cfset redirectTo(controller="main", action="login") />
		</cfif>
		
	</cffunction>
	
	
	
	<cffunction name="categoryNav">
		<!--- Setup categories query object for use in the layout --->
		<cfset categories = model("category").findAll(order="category") />
		
	</cffunction>
	
	
	
	<cffunction name="bookmarkNav">
		<!--- Setup bookmarks query object for use in the layout --->
		<cfset bookmarks = model("bookmark").findAll(order="name") />
		
	</cffunction>
	
</cfcomponent>