From: "Rhee, C. Joon" <jrhee@qualcomm.com>
Subject: YUV Framebuffer
Date: Tue, 16 Oct 2007 17:00:51 -0700
Message-ID: <27AAC353AE72C840926448157F375E72012B59B1@NAEX17.na.qualcomm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0005782193=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IhwLM-0000iL-KN for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 17:01:00 -0700
Received: from ithilien.qualcomm.com ([129.46.51.59])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IhwLM-00066e-BK
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Oct 2007 17:01:00 -0700
Received: from hamtaro.qualcomm.com (hamtaro.qualcomm.com [129.46.61.157])
	by ithilien.qualcomm.com (8.13.6/8.12.5/1.0) with ESMTP id
	l9H00rKK020307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 16 Oct 2007 17:00:54 -0700
Received: from sanexcas01.na.qualcomm.com (sanexcas01.qualcomm.com
	[172.30.36.175])
	by hamtaro.qualcomm.com (8.13.6/8.13.6/1.0) with ESMTP id
	l9H00m6I013142 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 16 Oct 2007 17:00:53 -0700 (PDT)
Content-class: urn:content-classes:message
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0005782193==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C81050.C84115D4"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C81050.C84115D4
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is it possible to create framebuffer color format in YUV (eg. YUV422
interleaved) and expose it through /dev/fb?

What would be fb_info type? =20

And how about about fb_var_screeninfo.green/blue/red offset?=20

=20

Joon


------_=_NextPart_001_01C81050.C84115D4
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
@font-face
	{font-family:"Palatino Linotype";
	panose-1:2 4 5 2 5 5 5 3 3 4;}
@font-face
	{font-family:Batang;
	panose-1:2 3 6 0 0 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{font-family:"Palatino Linotype";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3D"Palatino Linotype"><span
style=3D'font-size:10.0pt;font-family:"Palatino Linotype"'>Is it =
possible to
create framebuffer color format in YUV (eg. YUV422 interleaved) and =
expose it through
/dev/fb?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Palatino Linotype"><span
style=3D'font-size:10.0pt;font-family:"Palatino Linotype"'>What would be =
fb_info type?
&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Palatino Linotype"><span
style=3D'font-size:10.0pt;font-family:"Palatino Linotype"'>And how about =
about fb_var_screeninfo.green/blue/red
offset? </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Palatino Linotype"><span
style=3D'font-size:10.0pt;font-family:"Palatino =
Linotype"'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3D"Palatino Linotype"><span
style=3D'font-size:10.0pt;font-family:"Palatino =
Linotype"'>Joon</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C81050.C84115D4--


--===============0005782193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0005782193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0005782193==--
