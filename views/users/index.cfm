<cfoutput>

<cfif users.recordcount>
	<table class="dataGrid">
	    <thead>
	        <tr>
	            <th>Name</th>
	            <th>Username</th>
	            <th>Email</th>
	            <th>Actions</th>
	        </tr>
	    </thead>
	    <tbody>
	        <cfloop query="users">
	            <tr>
	                <td>#users.firstName# #users.lastName#</td>
	                <td>#users.accountName#</td>
	                <td>#users.email#</td>
	                <td>
	                    #linkTo(
	                        text="Edit", action="edit", key=users.id,
	                        title="Edit #users.firstName#"
	                    )# | 
	                    #linkTo(
	                        text="Delete", action="delete", key=users.id,
	                        title="Delete #users.firstName#",
	                        confirm="Are you sure that you want to delete #users.firstName#?"
	                    )#
	                </td>
	            </tr>
	        </cfloop>
	    </tbody>
	</table>
<cfelse>
	<div class="messages">There are currently no users to display.</div>
</cfif>

</cfoutput>