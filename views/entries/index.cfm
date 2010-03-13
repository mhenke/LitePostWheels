<cfoutput>

<cfif entries.recordcount>
	<table class="dataGrid">
	    <thead>
	        <tr>
	            <th>Added</th>
	            <th>Category</th>
	            <th>Author</th>
	            <th>Title</th>
	            <th>Actions</th>
	        </tr>
	    </thead>
	    <tbody>
		        <cfloop query="entries">
		            <tr>
		                <td>#DateFormat(entries.createdAt, "mm/dd/yyyy")#</td>
		                <td>#entries.category#</td>
		                <td>#entries.firstName# #entries.lastName#</td>
		                <td>#truncate(text=entries.title, length=20)#</td>
		                <td>
		                    #linkTo(
		                        text="Edit", action="edit", key=entries.id,
		                        title="Edit #entries.title#"
		                    )# | 
		                    #linkTo(
		                        text="Delete", action="delete", key=entries.id,
		                        title="Delete #entries.title#",
		                        confirm="Are you sure that you want to delete '#entries.title#'?"
		                    )#
		                </td>
		            </tr>
		        </cfloop>
	    </tbody>
	</table>
<cfelse>
	<div class="messages">There are currently no blog entries to display.</div>
</cfif>

</cfoutput>