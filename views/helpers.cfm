<!--- Place helper functions here that should be available for use in all view pages of your application --->
<cffunction name="dateOrd" returntype="string" access="public" output="false"
	hint="Takes a date and gets the day digit and returns the appropriate english ordinal (1st, 2nd, 3rd etc.)"
	examples=
	'
		##dateOrd("entries.createdAt")##
		-> 1st
	'
	categories="view-helper" functions="excerpt,highlight,simpleFormat,stripLinks,stripTags,truncate,titleize">
	<cfargument name="date" type="string"  required="true" hint="">
	<cfargument name="suffixOnly" type="boolean" required="false" default="false" hint="">
	
	<cfset var loc = {} />
	<cfset var loc.returnValue = '' />
	<cfset var loc.currentValue = datePart("d", arguments.date) />
	<cfset var loc.suffix = '' />
	
	<cfif loc.currentValue EQ 1 OR loc.currentValue EQ 21 OR loc.currentValue EQ 31 >
		<cfset loc.suffix = 'st' />
	<cfelseif loc.currentValue EQ 2 OR loc.currentValue EQ 22>
		<cfset loc.suffix = 'nd' />
	<cfelseif loc.currentValue EQ 3 OR loc.currentValue EQ 23>
		<cfset loc.suffix = 'rd' />
	<cfelseif (loc.currentValue GT 3 OR loc.currentValue LT 21) OR (loc.currentValue GT 23 OR loc.currentValue LT 31)>
		<cfset loc.suffix = 'th' />
	</cfif>
	
	<cfif arguments.suffixOnly>
		<cfset loc.returnValue = loc.suffix />
	<cfelse>
		<cfset loc.returnValue = loc.currentValue & loc.suffix />
	</cfif>
	
	<cfreturn loc.returnValue>
	
</cffunction>



<cffunction name="numOrd" returntype="string" access="public" output="false"
	hint="Takes a number and returns the number with the appropriate english ordinal (1st, 2nd, 3rd etc.)"
	examples=
	'
		##numOrd("105948")##
		-> 105948th
	'
	categories="view-helper" functions="excerpt,highlight,simpleFormat,stripLinks,stripTags,truncate,titleize">
	<cfargument name="number" type="numeric" required="true" hint="">
	<cfargument name="suffixOnly" type="boolean" required="false" default="false" hint="">
	
	<cfset var loc = {} />
	<cfset var loc.returnValue = '' />
	<cfset var loc.initialValue = round(arguments.number) />
	<cfset var loc.currentValue = right(loc.initialValue, 2) />
	<cfset var loc.length = len(loc.currentValue) />
	<cfset var loc.firstDigit = left(loc.currentValue, 1) />
	<cfset var loc.suffix = "" />
	
	
	<!--- check for the number of digits --->
	<cfif loc.length EQ 2>
		<!--- make exception for 11, 12 and 13 --->
		<cfif loc.currentValue GTE 11 AND loc.currentValue LTE 13>
			<cfset loc.currentValue = 4 />
		</cfif>
		<cfset loc.currentValue = loc.currentValue - (loc.firstDigit * 10) />
	</cfif>
	
	<cfif loc.currentValue EQ 1>
		<cfset loc.suffix = 'st' />
	<cfelseif loc.currentValue EQ 2>
		<cfset loc.suffix = 'nd' />
	<cfelseif loc.currentValue EQ 3>
		<cfset loc.suffix = 'rd' />
	<cfelse>
		<cfset loc.suffix = 'th' />
	</cfif> 
	
	<cfif arguments.suffixOnly>
		<cfset loc.returnValue = loc.suffix />
	<cfelse>
		<cfset loc.returnValue = loc.initialValue & loc.suffix />
	</cfif>
	
	<cfreturn loc.returnValue />
	
</cffunction>

<!--- Copied and slightly modified the "paginationLinks" view helper to support utilizing a "key" value.  (enabled me to re-use a view more efficiently) --->
<cffunction name="paginationLinksModified" returntype="string" access="public" output="false"
	hint="Builds and returns a string containing links to pages based on a paginated query. Uses `linkTo` internally to build the link, so you need to pass in a route name, controller/action/key combination. All other `linkTo` arguments can be supplied as well, in which case they are passed through directly to `linkTo`. If you have paginated more than one query in the controller, you can use the `handle` argument to reference them. (Don't forget to pass in a `handle` to the `findAll` function in your controller first)"
	examples=
	'
		<!--- controller code --->
		<cfparam name="params.page" default="1">
		<cfset allAuthors = model("author").findAll(page=params.page, perPage=25, order="lastName")>

		<!--- view code --->
		<ul>
		    <cfoutput query="allAuthors">
		        <li>##firstName## ##lastName##</li>
		    </cfoutput>
		</ul>
		<cfoutput>##paginationLinks(action="listAuthors")##</cfoutput>

		<!--- view code --->
		<cfoutput>##paginationLinks(action="listAuthors", windowSize=5)##</cfoutput>


		<!--- controller code --->
		<cfset allAuthors = model("author").findAll(handle="authQuery", page=5, order="id")>

		<!--- view code --->
		<ul>
		    <cfoutput>##paginationLinks(action="listAuthors", handle="authQuery", prependToLink="<li>", appendToLink="</li>")##</cfoutput>
		</ul>


		<!--- route setup in config/routes.cfm --->
		<cfset addRoute(name="paginatedCommentListing", pattern="blog/[year]/[month]/[day]/[page]", controller="theBlog", action="stats")>
		<cfset addRoute(name="commentListing", pattern="blog/[year]/[month]/[day]",  controller="theBlog", action="stats")>

		<!--- controller code --->
		<cfparam name="params.page" default="1">
		<cfset comments = model("comment").findAll(page=params.page, order="createdAt")>

		<!--- view code --->
		<ul>
		    <cfoutput>##paginationLinks(route="paginatedCommentListing", year=2009, month="feb", day=10)##</cfoutput>
		</ul>
	'
	categories="view-helper" chapters="getting-paginated-data,displaying-links-for-pagination" functions="linkTo,findAll,URLFor">
	<cfargument name="windowSize" type="numeric" required="false" default="#application.wheels.functions.paginationLinks.windowSize#" hint="The number of page links to show around the current page">
	<cfargument name="alwaysShowAnchors" type="boolean" required="false" default="#application.wheels.functions.paginationLinks.alwaysShowAnchors#" hint="Whether or not links to the first and last page should always be displayed">
	<cfargument name="anchorDivider" type="string" required="false" default="#application.wheels.functions.paginationLinks.anchorDivider#" hint="String to place next to the anchors on either side of the list">
	<cfargument name="linkToCurrentPage" type="boolean" required="false" default="#application.wheels.functions.paginationLinks.linkToCurrentPage#" hint="Whether or not the current page should be linked to">
	<cfargument name="prepend" type="string" required="false" default="#application.wheels.functions.paginationLinks.prepend#" hint="String or HTML to be prepended before result">
	<cfargument name="append" type="string" required="false" default="#application.wheels.functions.paginationLinks.append#" hint="String or HTML to be appended after result">
	<cfargument name="prependToPage" type="string" required="false" default="#application.wheels.functions.paginationLinks.prependToPage#" hint="String or HTML to be prepended before each page number">
	<cfargument name="prependOnFirst" type="boolean" required="false" default="#application.wheels.functions.paginationLinks.prependOnFirst#" hint="Whether or not to prepend the `prependToPage` string on the first page in the list">
	<cfargument name="appendToPage" type="string" required="false" default="#application.wheels.functions.paginationLinks.appendToPage#" hint="String or HTML to be appended after each page number">
	<cfargument name="appendOnLast" type="boolean" required="false" default="#application.wheels.functions.paginationLinks.appendOnLast#" hint="Whether or not to append the `appendToPage` string on the last page in the list">
	<cfargument name="classForCurrent" type="string" required="false" default="#application.wheels.functions.paginationLinks.classForCurrent#" hint="Class name for the current page number (if `linkToCurrentPage` is `true`, the class name will go on the `a` element. If not, a `span` element will be used)">
	<cfargument name="handle" type="string" required="false" default="query" hint="The handle given to the query that the pagination links should be displayed for">
	<cfargument name="name" type="string" required="false" default="#application.wheels.functions.paginationLinks.name#" hint="The name of the param that holds the current page number">
	<cfargument name="showSinglePage" type="boolean" required="false" default="#application.wheels.functions.paginationLinks.showSinglePage#" hint="Will show a single page when set to `true`. (The default behavior is to return an empty string when there is only one page in the pagination)">
	<cfargument name="key" type="string" required="false" default="" hint="key for use with the link">

	<cfscript>
		var loc = {};
		$insertDefaults(name="paginationLinks", input=arguments);
		loc.skipArgs = "windowSize,alwaysShowAnchors,anchorDivider,linkToCurrentPage,prepend,append,prependToPage,prependOnFirst,appendToPage,appendOnLast,classForCurrent,handle,name,showSinglePage";
		loc.linkToArguments = Duplicate(arguments);
		loc.iEnd = ListLen(loc.skipArgs);
		for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			StructDelete(loc.linkToArguments, ListGetAt(loc.skipArgs, loc.i));
		loc.currentPage = pagination(arguments.handle).currentPage;
		loc.totalPages = pagination(arguments.handle).totalPages;
		loc.start = "";
		loc.middle = "";
		loc.end = "";
		if (arguments.showSinglePage || loc.totalPages > 1)
		{
			if (Len(arguments.prepend))
				loc.start = loc.start & arguments.prepend;
			if (arguments.alwaysShowAnchors)
			{
				if ((loc.currentPage - arguments.windowSize) > 1)
				{
					loc.pageNumber = 1;
					if (StructKeyExists(arguments, "route"))
					{
						loc.linkToArguments[arguments.name] = loc.pageNumber;
					}
					else
					{
						loc.linkToArguments.params = arguments.name & "=" & loc.pageNumber;
						if (StructKeyExists(arguments, "params"))
							loc.linkToArguments.params = loc.linkToArguments.params & "&" & arguments.params;
					}
					loc.linkToArguments.text = loc.pageNumber;
					loc.start = loc.start & linkTo(argumentCollection=loc.linkToArguments) & arguments.anchorDivider;
				}
			}
			loc.middle = "";
			for (loc.i=1; loc.i <= loc.totalPages; loc.i++)
			{
				if ((loc.i >= (loc.currentPage - arguments.windowSize) && loc.i <= loc.currentPage) || (loc.i <= (loc.currentPage + arguments.windowSize) && loc.i >= loc.currentPage))
				{
					if (StructKeyExists(arguments, "route"))
					{
						loc.linkToArguments[arguments.name] = loc.i;
					}
					else
					{
						loc.linkToArguments.params = arguments.name & "=" & loc.i;
						if (StructKeyExists(arguments, "params"))
							loc.linkToArguments.params = loc.linkToArguments.params & "&" & arguments.params;
					}
					loc.linkToArguments.text = loc.i;
					if (Len(arguments.classForCurrent) && loc.currentPage == loc.i)
						loc.linkToArguments.class = arguments.classForCurrent;
					else
						StructDelete(loc.linkToArguments, "class");
					if (Len(arguments.prependToPage))
						loc.middle = loc.middle & arguments.prependToPage;
					if (loc.currentPage != loc.i || arguments.linkToCurrentPage)
					{
						loc.linkToArguments.key = arguments.key; 
						loc.middle = loc.middle & linkTo(argumentCollection=loc.linkToArguments);
					}
					else
					{
						if (Len(arguments.classForCurrent))
							loc.middle = loc.middle & $element(name="span", content=loc.i, class=arguments.classForCurrent);
						else
							loc.middle = loc.middle & loc.i;
					}
					if (Len(arguments.appendToPage))
						loc.middle = loc.middle & arguments.appendToPage;
				}
			}
			if (arguments.alwaysShowAnchors)
			{
				if (loc.totalPages > (loc.currentPage + arguments.windowSize))
				{
					if (StructKeyExists(arguments, "route"))
					{
						loc.linkToArguments[arguments.name] = loc.totalPages;
					}
					else
					{
						loc.linkToArguments.params = arguments.name & "=" & loc.totalPages;
						if (StructKeyExists(arguments, "params"))
							loc.linkToArguments.params = loc.linkToArguments.params & "&" & arguments.params;
					}
					loc.linkToArguments.text = loc.totalPages;
					loc.end = loc.end & arguments.anchorDivider & linkTo(argumentCollection=loc.linkToArguments);
				}
			}
			if (Len(arguments.append))
				loc.end = loc.end & arguments.append;
		}
		if (Len(arguments.prependToPage) && !arguments.prependOnFirst)
			loc.middle = Mid(loc.middle, Len(arguments.prependToPage)+1, Len(loc.middle)-Len(arguments.prependToPage)) ;
		if (Len(arguments.appendToPage) && !arguments.appendOnLast)
			loc.middle = Mid(loc.middle, 1, Len(loc.middle)-Len(arguments.appendToPage)) ;
		loc.returnValue = loc.start & loc.middle & loc.end;
	</cfscript>
	<cfreturn loc.returnValue>
</cffunction>