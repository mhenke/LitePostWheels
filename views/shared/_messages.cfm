<cfif NOT flashIsEmpty()>
	<cfoutput>
		<div class="messages">
			<cfloop collection="#session.flash#" item="flashKey">
				<cfset icon = "images/icons/#flashKey#24x24.gif" />
				
				<div class='#flashKey#'>
					<cfif fileExists(expandPath(icon))>
						<img src='/#icon#' alt='#flashKey#' />
					</cfif>
					<p class='#flashKey#'>#structFind(session.flash, flashKey)#</p><br class="clear" />
				</div>
			</cfloop>
		</div>
	</cfoutput>
</cfif>

