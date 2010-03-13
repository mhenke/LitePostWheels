<cfoutput>

<cfif comments.recordcount>
	<table class="dataGrid">
	    <thead>
	        <tr>
	            <th>Added</th>
	            <th>Attached To</th>
	            <th>Author</th>
	            <th>Comment</th>
	            <th>Actions</th>
	        </tr>
	    </thead>
	    <tbody>
	        <cfloop query="comments">
	            <tr>
	                <td>#DateFormat(comments.createdAt, "mm/dd/yyyy")#</td>
	                <td>#truncate(text=comments.title, length=20)#</td>
	                <td>#comments.name#</td>
	                <td>#truncate(text=comments.comment, length=30)#</td>
	                <td>
	                    #linkTo(
	                        text="Edit", action="edit", key=comments.id,
	                        title="Edit #comments.title#"
	                    )# | 
	                    #linkTo(
	                        text="Delete", action="delete", key=comments.id,
	                        title="Delete comment",
	                        confirm="Are you sure that you want to delete this comment?"
	                    )#
	                </td>
	            </tr>
	        </cfloop>
	    </tbody>
	</table>
<cfelse>
	<div class="messages">There are currently no blog comments to display.</div>
</cfif>

</cfoutput>