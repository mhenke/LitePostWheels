<cfoutput>
	<div class="commentBar">
		<div class="commentActions">
			<span class="grey">posted in </span>#linkTo(text=entry.category().category, controller="categories", action="list", key=entry.category().id)# | 
			<span class="viewComments">#linkTo(text="Comments", anchor="entry#entry.id#", key=entry.category().id, params="comments=show&entry=#entry.id#&pg=#params.pg#")# [#entry.comments().recordCount#]</span> 
			<span class="addComment">[#linkTo(text="add", anchor="entry#entry.id#", key=entry.category().id, params="comments=add&entry=#entry.id#&pg=#params.pg#")#]</span> 
		</div>
	</div>
	<div class="commentForm <cfif (params.comments EQ 'add' AND params.entry EQ entry.id)>show<cfelse>hide</cfif>">
		#errorMessagesFor("comment")#

		#startFormTag(controller="comments", action="savecomment", key=entry.id, params="pcontroller=#params.controller#&paction=#params.action#&category=#entry.category().id#&pg=#params.pg#")#
		
		    #textField(objectName="comment", property="name", label="Name")#
			
		    #textField(objectName="comment", property="email", label="Email")#
			
		    #textField(objectName="comment", property="url", label="URL")#
			
			#hiddenField(objectName="comment", property="entryid" )#
		
		    <!---#textArea(objectName="comment", property="comment", label="Comment")#--->
			#richTextField(objectName="comment", property="comment", class="rteditor", rows="5", editor="markitup", includeJSLibrary="false", label="Comment")#
			
		    #submitTag(value="Submit Comment")#
		
		#endFormTag()#
		<div class="clear"><!-- --></div>
	</div>
	<cfset comments = entry.comments(order="createdAt ASC") />
	<div class="commentBlock <cfif (params.comments EQ 'show' AND params.entry EQ entry.id) OR params.comments EQ 'all'>show<cfelse>hide</cfif>">
		<cfloop query="comments">
			<div class="comment #cycle('even,odd')#">
				<div class="commentBodyWrapper">
					<div class="commentInfo">
						<span class="grey">submitted on </span>#dateFormat(comments.createdAt, "mmmm")# #dateOrd(comments.createdAt)# 
						<span class="grey">at </span>#timeFormat(comments.createdAt, "h:mm tt")#  
						<span class="grey">by </span> <cfif entry.comments().url NEQ ""><a href="#entry.comments().url#">#entry.comments().name#</a><cfelse>#entry.comments().name#</cfif>
						<cfif structKeyExists(session, 'user') AND session.user.role EQ 'admin'>
							<div class="float-right align-right">
								[#linkTo(text="edit", controller="comments", action="edit", key=comments.id, params="pg=#params.pg#&pcontroller=#params.controller#&paction=#params.action#")#] 
								[#linkTo(text="delete", controller="comments", action="delete", key=comments.id, confirm="Are you sure that you want to delete this comment?", params="pg=#params.pg#&pcontroller=#params.controller#&paction=#params.action#")#]
							</div>
							<div class="clear"><!-- --></div>
						</cfif>
					</div>
					<div class="commentBody">#comments.comment#</div>
				</div>
			</div>
		</cfloop>
	</div>
</cfoutput>