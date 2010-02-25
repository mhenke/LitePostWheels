<!---
	If you leave these settings commented out, Wheels will set the data source name to the same name as the folder the application resides in.
	<cfset set(dataSourceName="")>
	<cfset set(dataSourceUserName="")>
	<cfset set(dataSourcePassword="")> 
--->

<!---
	If you leave this setting commented out, Wheels will try to determine the URL rewrite capabilities automatically.
	The URLRewriting setting can bet set to "On", "Partial" or "Off".
	To run with "Partial" rewriting, the "PATH_INFO" variable needs to be supported by the web server.
	To run with rewriting "On", you need to apply the necessary rewrite rules on the web server first.
--->
	<cfset set(URLRewriting="On")>
	
	<!--- Form Helpers --->
	<cfset set(functionName="textField", labelPlacement="before", prependToLabel="<div class='form-text'>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="passwordField", labelPlacement="before", prependToLabel="<div class='form-password'>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="select", labelPlacement="before", prependToLabel="<div class='form-select'>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="textArea", labelPlacement="before", prependToLabel="<div class='form-textarea'>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="richTextField", labelPlacement="before", prependToLabel="<div class='form-textarea'>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="radioButton", labelPlacement="after", prepend="<div class='form-radio'>", appendToLabel="</div>") />
	<cfset set(functionName="passwordFieldTag", labelPlacement="before", prependToLabel="<div>", append="</div>", appendToLabel="<br />") />
	<cfset set(functionName="submitTag") />