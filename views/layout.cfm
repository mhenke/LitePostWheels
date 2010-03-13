<cfparam name="head" default="#structNew()#" />
<cfparam name="head.title" default="LitePost - Simple Blog Software" />
<cfparam name="page" default="#structNew()#" />
<cfparam name="page.title" default="" />
<cfparam name="page.actionNav" default="" />

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>#head.title#</title>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
	<meta name='author' content='LitePost' />
	<meta name='description' content='' />
	<meta name='keywords' content='' />
	<meta name='language' content='en' />
	<meta name='robots' content='follow, all' />
	<meta name='revisit-after' content='2 days' />
	#styleSheetLinkTag("base")#
	#javaScriptIncludeTag("jquery")#
	#javaScriptIncludeTag("jquery.dataTables")#
	<script type="text/javascript" charset="utf-8"> 
		$(document).ready(function() {
			$('.dataGrid').dataTable( {
				"bPaginate": true,
				"sPaginationType": "full_numbers",
				"bLengthChange": true,
				"bFilter": true,
				"bSort": true,
				"bInfo": true,
				"bAutoWidth": true 
			} );
			
			$(".commentActions span.viewComments a").click(function(){
				$(this).closest(".blogEntry").find(".commentBlock").slideToggle('fast');
				return false;
			});
			
			$(".commentActions span.addComment a").click(function(){
				$(this).closest(".blogEntry").find(".commentForm").slideToggle('fast');
				return false;
			});
		} );
	</script>
</head>
	<body>
		<div id="mainWrapper"><!-- Begin mainWrapper -->
			<div id="pageWrapper"><!-- Begin pageWrapper -->
				<div id="pageHeaderWrapper"><!-- Begin pageHeaderWrapper -->
					<div id="pageHeaderBlock"><!-- Begin pageHeaderBlock -->
						<div id="pageHeaderContent"><!-- Begin pageHeaderContent -->
							#includePartial("/shared/headernav")#
						</div><!-- End pageHeaderContent -->				
					</div><!-- End pageHeaderBlock -->				
				</div><!-- End pageHeaderWrapper -->
				<div id="pageBodyWrapper"><!-- Begin pageBodyWrapper -->
					<div id="pageBodyBlock"><!-- Begin pageBodyBlock -->
						<div id="pageBodyContent"><!-- Begin pageBodyContent -->
							<div id="contentLeft" class="float-left">
								#includePartial("/shared/contentheader")#
								#contentForLayout()#
							</div>
							<div id="contentRight" class="float-right">
								<cfif structKeyExists(session, 'user') AND session.user.role EQ 'admin'>
									#includePartial("/shared/adminnav")#
								</cfif>
								<h2>Subscribe</h2>
								<ul>
									<li>#linkTo(text="RSS", controller="main", action="rss")#</li>
									<li>Email</li>
								</ul>
								
								#includePartial("/shared/categorynav")#
								#includePartial("/shared/bookmarknav")#
							</div>
							<div class="clear"><!-- --></div>
						</div><!-- End pageBodyContent -->				
					</div><!-- End pageBodyBlock -->
				</div><!-- End pageBodyWrapper -->
				<div id="pageFooterWrapper"><!-- Begin pageFooterWrapper -->
					<div id="pageFooterBlock"><!-- Begin pageFooterBlock -->
						<div id="pageFooterContent"><!-- Begin pageFooterContent -->
							#includePartial("/shared/footertext")#
						</div><!-- End pageFooterContent -->
					</div><!-- End pageFooterBlock -->
				</div><!-- End pageFooterWrapper -->
			</div><!-- End pageWrapper -->
		</div><!-- End mainWrapper -->
	</body>
</html>
</cfoutput>