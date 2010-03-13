<cfparam name="bookmarks" default="#queryNew("id,name,url")#" />
<cfoutput>
<h2>Bookmarks</h2>
<ul>
<cfif bookmarks.recordcount>
	<cfloop query="bookmarks">
		<li><a href="#bookmarks.url#">#bookmarks.name#</a></li>
	</cfloop>
<cfelse>
	<li class="messages">No Bookmarks to list</li>
</cfif>
</ul>
</cfoutput>