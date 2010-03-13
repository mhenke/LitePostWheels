<cfparam name="params.key" default="" />
<cfparam name="params.comments" default=false />
<cfparam name="params.pg" default="1" />
<cfparam name="params.pageKey" default="" />

<cfoutput>

<cfif arrayLen(entries)>
	<cfloop array="#entries#" index="entry">
		<div id="entry#entry.id#" class="blogEntry">
			<h1>#entry.title#</h1>
			<div class="entrySubHeader">
				<span class="grey">posted in </span>#linkTo(text=entry.category().category, controller="categories", action="list", key=entry.category().id)#
				<span class="grey"> on </span>#DateFormat(entry.createdAt, "mmmm")# #dateOrd(entry.createdAt)#
				<span class="grey"> by </span>#entry.user.firstName# #entry.user.lastName#
				
				<div class="float-right align-left">
					<cfif structKeyExists(session, 'user') AND session.user.role EQ 'admin'>
						[#linkTo(text="edit", controller="entries", action="edit", key=entry.id, params="pg=#params.pg#&pcontroller=#params.controller#&paction=#params.action#")#]
					</cfif>
				</div>
				<div class="clear"><!-- --></div>
			</div>
			<div class="entryBody">
				#entry.body#
			</div>
			#includePartial("/comments/comments")#
		</div>
	</cfloop>
<cfelse>
	<div class="messages">There are currently no blog entries to display.</div>
</cfif>
<div class="pagination align-center">#paginationLinksModified(name="pg", key=params.pageKey)#</div>
</cfoutput>