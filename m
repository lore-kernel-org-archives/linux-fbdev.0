From: "Rhee, C. Joon" <jrhee@qualcomm.com>
Subject: LCD backlight IOCTL
Date: Thu, 13 Mar 2008 09:38:51 -0700
Message-ID: <27AAC353AE72C840926448157F375E7201DD65E1@NAEX17.na.qualcomm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2006806849=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JZqSL-00075k-HJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 09:39:01 -0700
Received: from wolverine02.qualcomm.com ([199.106.114.251])
	by mail.sourceforge.net with esmtps (TLSv1:RC4-SHA:128) (Exim 4.44)
	id 1JZqSJ-0002s3-1S for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 09:39:01 -0700
Received: from hamtaro.qualcomm.com (hamtaro.qualcomm.com [129.46.61.157])
	by ithilien.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id
	m2DGcrOw021513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 09:38:53 -0700
Received: from SANEXCAS02.na.qualcomm.com (sanexcas02.qualcomm.com
	[172.30.36.176])
	by hamtaro.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id
	m2DGcqjj024011 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 09:38:53 -0700 (PDT)
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

--===============2006806849==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C88528.B890F1D5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C88528.B890F1D5
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, I'm searching for how we can specify the LCD backlight level through
/dev/fb.

And for this, should we introduce a new IOCTL?

=20

FBIOGET/SET_BACKLIGHT

=20

I looked through CONFIG_FB_BACKLIGHT and bl_dev registration but I found
this is more of internal usage when there is fb event and I don't really
see how user app can specify the level.

=20


------_=_NextPart_001_01C88528.B890F1D5
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
span.emailstyle17
	{font-family:"Palatino Linotype";
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
span.EmailStyle18
	{font-family:"Palatino Linotype";
	color:blue;
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

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>Hi, I&#8217;m searching for =
how we
can specify the LCD backlight level through /dev/fb.</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>And for this, should we =
introduce a
new IOCTL?</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>FBIOGET/SET_BACKLIGHT</span>=
</font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>I looked through =
CONFIG_FB_BACKLIGHT
and bl_dev registration but I found this is more of internal usage when =
there
is fb event and I don't really see how user app can specify the =
level.</span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C88528.B890F1D5--


--===============2006806849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============2006806849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2006806849==--
