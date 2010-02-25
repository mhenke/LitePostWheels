<!--- Main Controller - Logins, Logouts, Home Page --->
<cfcomponent extends="Controller">

	<cffunction name="home">
		<!--- Set page view variables --->
		<cfset page.title = "" />
		
		<cfparam name="params.pg" default="1" />
		
		<!--- Grab the most recent blog entries to display. --->
		<cfset entries = model('entry').findAll(maxRows=5, order="createdAt DESC", include="user", returnAs="objects", page=params.pg, perPage=5) />
		
		<!--- Create a new Comment object --->
		<cfset comment = model("comment").new() />
		
		<!--- Render View --->
		<cfset renderPage(controller="entries", action="list") />
		
	</cffunction>



	<cffunction name="login">
		<!--- Create new user object --->
		<cfset user = model('user').new() />
		
		<!--- Set page view variables --->
		<cfset page.title = "Login" />
		
		<!--- Check for existing user session (logged in) --->
		<cfif structKeyExists(session, 'user')>
			<!--- Redirect --->
			<cfset redirectTo(controller="main", action="home") />
		</cfif>
		
	</cffunction>
	
	
	
	<cffunction name="logout">
		<!--- Destroy the session user struct --->
		<cfset structDelete(session, "user") />
		
		<!--- Success Message --->
		<cfset flashInsert(success="You have been logged out successfully.") />
		
		<!--- Redirect --->
		<cfset redirectTo(controller="main", action="home") />
		
	</cffunction>
	
	
	
	<cffunction name="rss">
		<!--- Grab the most recent blog entries to display. --->
		<cfset entries = model('entry').findAll(maxRows=5, order="createdAt DESC", include="user,category") />
	
		<cfsavecontent variable="tempHTML">
			<cfoutput>
				<?xml version="1.0" encoding="utf-8"?>
				<rss version="2.0">
				<channel>
				<title>LitePost RSS 2.0 Feed</title>
				<link>http://blog/</link>
				<description>Latest Blog Entries</description>
				<lastBuildDate>#dateFormat(now(), "ddd, dd mmm yyyy HH:mm:00")#</lastBuildDate>
				<language>en-us</language>
				
				<cfloop query="entries">
					<item>
					<title>#entries.title#</title>
					<link>http://#CGI.server_name#/categories/list/#categoryid#</link>
					<guid>http://#CGI.server_name#/categories/list/#categoryid#</guid>
					<pubDate>#dateFormat(entries.createdAt, "ddd, dd mmm yyyy HH:mm:00")#</pubDate>
					<description>#entries.body#</description>
					</item>
				</cfloop>
				</channel>
				</rss>
			</cfoutput>
		</cfsavecontent>
		
		<!--- Redirect --->
		<cfset renderText(tempHTML) />
		
	</cffunction>
	
	
	
	<cffunction name="signin">
		<!--- Check for existing user session (logged in) --->
		<cfif (NOT structKeyExists(session, 'user')) AND (structKeyExists(params, 'user'))>
			<!--- Authenticate the user --->
			<cfset user = model("user").findOne(where="accountname='#params.user.accountname#' AND password=SHA1('#params.user.password#')") />
			
			<!--- Set page view variables --->
			<cfset page.title = "Login" />
			
			<!--- User authenticated --->
			<cfif isObject(user)>
				<!--- Set session values --->
				<cfset session.user.id = user.id />
				<cfset session.user.accountname = user.accountname />
				<cfset session.user.firstName = user.firstName />
				<cfset session.user.role = user.role />
				
				<!--- Success/Welcome Message --->
				<cfset flashInsert(success="Welcome back #user.firstName#!") />
				
				<!--- Redirect --->
				<cfset redirectTo(controller="main", action="home") />
				
			<!--- Failed Authentication --->
			<cfelse>
				<!--- Set the user accountname for display back in the form --->
				<cfset user = model("user").new(accountname=params.user.accountname) />
				
				<!--- Error Message --->
				<cfset flashInsert(error="The username and/or password was not valid.") />
				
				<!--- Render View --->
				<cfset renderPage(action="login") />
			</cfif>
		<cfelse>
			<!--- Redirect --->
			<cfset redirectTo(controller="main", action="home") />
		</cfif>
		
	</cffunction>
</cfcomponent>