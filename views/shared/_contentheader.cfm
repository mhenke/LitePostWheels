<cfparam name="page.title" default="test" />
<cfparam name="page.actionnNav" default="" />

<cfoutput>

<cfif page.title NEQ "">
	<h1>#page.title#</h1>
</cfif>
<cfif page.actionNav NEQ "">
	<div class="actionNav">
		#page.actionNav#
	</div>
</cfif>

#includePartial("/shared/messages")#

</cfoutput>