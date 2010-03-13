<cfparam name="categories" default="#queryNew("id,category")#"/>

<cfoutput>

<cfif categories.recordcount>
	<table class="dataGrid">
	    <thead>
	        <tr>
	            <th>Category</th>
	            <th>Actions</th>
	        </tr>
	    </thead>
	    <tbody>
	        <cfloop query="categories">
	            <tr>
	                <td>#categories.category#</td>
	                <td>
	                    #linkTo(
	                        text="Edit", action="edit", key=categories.id,
	                        title="Edit #categories.category#"
	                    )# | 
	                    #linkTo(
	                        text="Delete", action="delete", key=categories.id,
	                        title="Delete #categories.category#",
	                        confirm="Are you sure that you want to delete #categories.category#?"
	                    )#
	                </td>
	            </tr>
	        </cfloop>
	    </tbody>
	</table>
<cfelse>
	<div class="messages">There are currently no categories to display.</div>
</cfif>

</cfoutput>