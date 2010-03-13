<cfoutput>
<p>Hi #recipientName#,</p>
<p>We wanted to take a moment to thank you for joining us!</p>
<p>
    Our records indicate that your user account was created on: 
    <strong>#DateFormat(startDate, "dddd, mmmm, d, yyyy")#</strong>.
</p>
<p>#linkTo(text="Click here to get started", onlyPath="false", action="index")#</p>
<p>Happy Blogging!</p>
</cfoutput>