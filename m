From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: problem setting up a rivafb driver for GUI Applcations
Date: Tue, 21 Sep 2004 15:23:56 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811107BAE@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C49FC0.E8CB5490"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9hJ5-00011f-4F
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Sep 2004 02:51:31 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1C9hJ3-0004X8-TF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Sep 2004 02:51:31 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i8L9knUE021613
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Sep 2004 09:46:52 GMT
Content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C49FC0.E8CB5490
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

Hai all ,

I think u can help me in regard to setting up fb driver for GUI
applications.

=20

I have a Nvidia Riva TNT card as a Graphical card on my system. I could
some how setup a Rivafb driver module on my system manually with debug
mode enabled. When I switch between consoles, I am able to find that my
driver ( rivafb) is invoved. It is also invoked when I switch from
console to GUI /GUI to console mode.

=20

Here comes my the question/doubt:-

=20

Why is my rivafb not invoked when ever I open any GUI Application( I
found no debug mesaages).

I performed some performance tests on Xserver with "x11perf" command

i.e

# X11perf  complex10

=20

This command does it job and my fb driver is not called even now.=20

I thought when we run an application on X server, X server will directly
interacts with the fb driver rather than hardware and so I thought the
rivafb driver should be called.

Is it like, there are different framebuffer drivers for console as well
as GUI( I don't thing so).

How do I activate framebuffer for my GUI Applications (X server).

=20

Also, I don't find commands like fbset and con2fb on my system. Is it
any way related to why fb doest work for GUI Applications (X server).

=20

I am working with the following configuration:-

*	Red Hat Linux 7.3
*	Kernel 2.4.18-3
*	Nvidia Riva TNT card
*	Rivafb driver
*	XFree86 4.2.0

=20


------_=_NextPart_001_01C49FC0.E8CB5490
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
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
	{font-family:Arial;
	color:windowtext;}
span.emailstyle18
	{font-family:Arial;
	color:navy;}
span.EmailStyle19
	{font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Hai all </span></font><font =
size=3D2
face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I think u can help me in regard to setting up fb =
driver for
GUI applications.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a Nvidia Riva TNT card as a Graphical card on =
my
system. I could some how setup a Rivafb driver module on my system =
manually
with debug mode enabled. When I switch between consoles, I am able to =
find that
my driver ( rivafb) is invoved. It is also invoked when I switch from =
console
to GUI /GUI to console mode.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial;font-weight:bold'>Here comes my the =
question/doubt:-</span></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Why is my rivafb not invoked when ever I open any GUI
Application( I found no debug mesaages).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I performed some performance tests on Xserver with
&#8220;x11perf&#8221; command</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>i.e</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'># X11perf &nbsp;complex10</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>This command does it job and my fb driver is not =
called even
now. </span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I thought when we run an application on X server, X =
server
will directly interacts with the fb driver rather than hardware and so I
thought the rivafb driver should be called.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Is it like, there are different framebuffer drivers =
for
console as well as GUI( I don&#8217;t thing so).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>How do I activate framebuffer for my GUI Applications =
(X
server).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Also, I don&#8217;t find commands like <b><span
style=3D'font-weight:bold'>fbset </span></b>and<b><span =
style=3D'font-weight:bold'>
con2fb </span></b>on my system. Is it any way related to why fb doest =
work for
GUI Applications (X server).</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>I am working with the following =
configuration:-</span></font></p>

<ul type=3Ddisc>
 <li class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span
     style=3D'font-size:12.0pt'>Red Hat Linux 7.3</span></font></li>
 <li class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span
     style=3D'font-size:12.0pt'>Kernel 2.4.18-3</span></font></li>
 <li class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>Nvidia Riva TNT card</span></font></li>
 <li class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>Rivafb driver</span></font></li>
 <li class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
     font-family:Arial'>XFree86 4.2.0</span></font></li>
</ul>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C49FC0.E8CB5490--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
