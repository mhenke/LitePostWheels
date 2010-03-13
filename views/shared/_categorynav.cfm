<cfparam name="categories" default="#queryNew("id,category")#" />
<cfoutput>
<h2>Categories</h2>
<ul>
<cfif categories.recordcount>
	<cfloop query="categories">
		<li>#linkTo(text=categories.category, controller="categories", action="list", key=categories.id)#</li>
	</cfloop>
<cfelse>
	<li class="messages">No Categories to list</li>
</cfif>
</ul>
</cfoutput>