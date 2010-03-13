<cfoutput>
<div id="headerNav">
	<ul>
		<li>#linkTo(text="Home", controller="main", action="home")# | </li>
		<li>#linkTo(text="About", controller="main", action="about")# | </li>
		<li>#linkTo(text="Contact", controller="main", action="contact")# | </li>
		<li>
		<cfif NOT structKeyExists(session, "user")>
			#linkTo(text="Login", controller="main", action="login")#
		<cfelse>
			#linkTo(text="Password", controller="users", action="password", key="#session.user.id#")# | </li>
			<li>#linkTo(text="Logout", controller="main", action="logout")#
		</cfif>
		</li>
	</ul>
</div>
</cfoutput>