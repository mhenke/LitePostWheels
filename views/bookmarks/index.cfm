<cfparam name="bookmarks" default="#queryNew("id,name,url")#"/>

<cfoutput>

<cfif bookmarks.recordcount>
	<table class="dataGrid">
	    <thead>
	        <tr>
	            <th>Name</th>
	            <th>URL</th>
	            <th>Actions</th>
	        </tr>
	    </thead>
	    <tbody>
	        <cfloop query="bookmarks">
	            <tr>
	                <td>#bookmarks.name#</td>
	                <td>#bookmarks.url#</td>
	                <td>
	                    #linkTo(
	                        text="Edit", action="edit", key=bookmarks.id,
	                        title="Edit #bookmarks.name#"
	                    )# | 
	                    #linkTo(
	                        text="Delete", action="delete", key=bookmarks.id,
	                        title="Delete #bookmarks.name#",
	                        confirm="Are you sure that you want to delete #bookmarks.name#?"
	                    )#
	                </td>
	            </tr>
	        </cfloop>
	    </tbody>
	</table>
<cfelse>
	<div class="messages">There are currently no bookmarks to display.</div>
</cfif>

</cfoutput>