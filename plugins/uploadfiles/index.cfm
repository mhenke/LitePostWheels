<cfoutput>
<h1>Upload Files</h1>

<h2>About:</h2>
<p>This plugin tries to make uploading files to your CFWheels application easy and secure (...well hopefully anyways).</p>
<p>This plugin is heavily based on <a href="http://github.com/rip747/cffileupload" target="_blank">CFFileUpload</a> project and has built in security to prevent the CFFILE MIME/FILE upload security vulnerability in coldfusion.</p>
<p>The way this plugin helps prevent this attack is by:</p>
<ul>
	<li>Intercepting the desired destination directory of the upload and uploading to the ColdFusion Temp directory</li>
	<li>Makes sure that the mimetype of the file uploaded matches the proper extension for that mimtype (so you can't upload a file mimetype of <em>image/jpeg</em> and an extension of <em>cfm</em>)</li>
	<li>Makes sure that the extension of the uploaded file is allowed and not blacklisted</li>
	<li>Only after all security checks are passed is the file then moved to the original destination directory</li>
</ul>
<p><em>Also as a convience, the plugin returns the mimetype associated with the file within the cffile return struct.</em></p>

<h2>Security Vulnerability Information</h2>
<p>The following blog provide more information on spoofing mimetypes and getting around CFFILE's security checks.</p>
<p><a href="http://www.cfexecute.com/post.cfm/spoofing-mime-types-with-coldfusion-and-cfhttp" target="_blank">Spoofing MIME Types with ColdFusion and CFHTTP</a></p>
<p><a href="http://www.coldfusionjedi.com/index.cfm/2009/6/30/Are-you-aware-of-the-MIMEFile-Upload-Security-Issue" target="_blank">Are you aware of the MIME/File Upload Security Issue?</a></p>

<h2>Methods Added:</h2>
<ul>
	<li>upload() - controller</li>
</ul>

<h2>Note</h2>

<p>For your convinence the default destination directory for all uploads is your application's <em>"files"</em> directory. You can change this by using the <em>"destination"</em> argument.</p>

<h2>Returns</h2>

<p>If successfull, the normal cffile structure of information with the mimetype of the file also included as a convinence. An empty string if a failure occurs</p>

<h2>Arguments:</h2>

<p><em>Besides all the normal arguments that the <a href="http://livedocs.adobe.com/coldfusion/8/htmldocs/help.html?content=Tags_f_10.html##3540091" target="_blank">[cffile action="upload"]</a> tag takes, you have the following addtional options.</em></p>

<h3>deleteBadFile</h3>
<ul>
	<li>type: boolean</li>
	<li>required: false</li>
	<li>default: true</li>
</ul>
<p>
	Should we delete an invalid files that are uploaded?
</p>

<h3>badExtensions</h3>
<ul>
	<li>type: string</li>
	<li>required: false</li>
	<li>default: blank</li>
</ul>
<p>
	A list of extensions that shouldn't be allowed to be uploaded.
	<br/><strong>NOTE:</strong> This plugin has an internal list that can only be appeneded.
	<br/>The internal list of bad extensions includes:
	<br/><em>cfm,cfml,cfc,dbm,jsp,asp,aspx,exe,php,cgi,shtml</em>
</p>

<h3>mimeTypes</h3>
<ul>
	<li>type: struct</li>
	<li>required: false</li>
	<li>default: empty structure</li>
</ul>
<p>
	Appends or overload the internal list of mimetypes with your own custom list.
	<br/>Below are all the internal mimetypes that are registered for you.
<p>
	
<ul>
	<li>pdf = "application/pdf,application/x-pdf,app/pdf"</li>
	<li>ppt = "application/vnd.ms-powerpoint"</li>
	<li>xls = "application/vnd.ms-excel"</li>
	<li>doc = "application/msword"</li>
	<li>pub = "application/x-mspublisher,application/vnd.ms-publisher"</li>
	<li>docm = "application/vnd.ms-word.document.macroEnabled.12"</li>
	<li>docx = "application/vnd.openxmlformats-officedocument.wordprocessingml.document"</li>
	<li>dotm = "application/vnd.ms-word.template.macroEnabled.12"</li>
	<li>dotx = "application/vnd.openxmlformats-officedocument.wordprocessingml.template"</li>
	<li>potm = "application/vnd.ms-powerpoint.template.macroEnabled.12"</li>
	<li>potx = "application/vnd.openxmlformats-officedocument.presentationml.template"</li>
	<li>ppam = "application/vnd.ms-powerpoint.addin.macroEnabled.12"</li>
	<li>ppsm = "application/vnd.ms-powerpoint.slideshow.macroEnabled.12"</li>
	<li>ppsx = "application/vnd.openxmlformats-officedocument.presentationml.slideshow"</li>
	<li>pptm = "application/vnd.ms-powerpoint.presentation.macroEnabled.12"</li>
	<li>ptx = "application/vnd.openxmlformats-officedocument.presentationml.presentation"</li>
	<li>xlam = "application/vnd.ms-excel.addin.macroEnabled.12"</li>
	<li>xlsb = "application/vnd.ms-excel.sheet.binary.macroEnabled.12"</li>
	<li>xlsm = "application/vnd.ms-excel.sheet.macroEnabled.12"</li>
	<li>xlsx = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"</li>
	<li>xltm = "application/vnd.ms-excel.template.macroEnabled.12"</li>
	<li>xltx = "application/vnd.openxmlformats-officedocument.spreadsheetml.template"</li>
	<li>jpg = "image/jpg,image/pjpg,image/jpeg,image/pjpeg"</li>
	<li>jpeg = "image/jpg,image/pjpg,image/jpeg,image/pjpeg"</li>
	<li>gif = "image/gif"</li>
	<li>png = "image/png"</li>
</ul>

<h2>Usage Example:</h2>

<h3>Upload a jpg file and resolve name conflicts</h3>
<pre>
&lt;cfset loc.ret = upload(
	fileField="company[logo]"
	,accept="image/jpeg,image/jpg,image/pjpg,image/pjpeg,image/gif"
	,nameconflict="MAKEUNIQUE"
)&gt;
&lt;cfif isstruct(loc.ret)&gt;
	&lt;cfset Company.logo = loc.ret.serverfile&gt;
	&lt;cfset Company.mimetype = loc.ret.mimetype&gt;
&lt;/cfif&gt;
</pre>

<h3>Allow a custom file extension of EXP and make sure it's of mimetype "text/plain"</h3>
<pre>
&lt;cfset loc.mimetypes = {}&gt;
&lt;cfset loc.mimetypes.exp = "text/plain"&gt;

&lt;cfset loc.ret = upload(
	fileField="company[logo]"
	,accept="text/plain"
	,mimeTypes=loc.mimetypes
	,nameconflict="MAKEUNIQUE"
)&gt;
&lt;cfif isstruct(loc.ret)&gt;
	&lt;cfset Company.logo = loc.ret.serverfile&gt;
	&lt;cfset Company.mimetype = loc.ret.mimetype&gt;
&lt;/cfif&gt;
</pre>

<h2>Disclaimer</h2>
<p>Remember that you use this at your own risk and I'm not responsible for anything. Please don't sue me :)</p>
</cfoutput>