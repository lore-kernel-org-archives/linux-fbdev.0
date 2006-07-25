From: "Gareth Lester-Olivier" <gareth@calcom.co.za>
Subject: Cyblafb driver
Date: Tue, 25 Jul 2006 22:00:19 +0200
Message-ID: <20060725200032.BE69A2BEC@ctb-mesg5.saix.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0569683522=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6ERV-00035u-H1 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Jul 2006 15:34:57 -0700
Received: from ctb-mesg5.saix.net ([196.25.240.75])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G5T4r-000831-0m
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Jul 2006 13:00:27 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Knut_Petersen@t-online.de
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0569683522==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001C_01C6B035.B87553D0"

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C6B035.B87553D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi there

 

Firstly, let me thank you for taking the time to develop the driver for the
EPIA motherboard onboard Trident display. Without it, I would have had to
find another display device for my linux box.

 

It took me some time tearing my hair out with the tridentfb driver before I
finally stumbled upon this one, but I have noticed that when text scrolls on
the screen (like at bootup) there are glitches with the display, little
distortions that span across the display, but only when text is moving on
the display. Is this a known issue?

 

I am running Gentoo 2006.0 kernel 2.6.16-r13, on a EPIA (duh) with 128mb
PC100, P3 Celeron 1.1ghz. I haven enabled an IRQ for the VGA in the bios,
and turned on all caching and shadowing options. Spread spectrum is off. I
have compiled the driver directly into the kernel, I have also compiled the
vesafb-tng driver into the kernel but no other fb drivers.

 

The line I send to the kernel is video=cyblafb:1024x768,bpp=32,ref=85. I
only got it working this evening so I haven't tried much else, as this is
the mode I wish to run in, but I will fiddle with it a bit.

 

Any help / advice would be extremely welcome.

Many, many thanks,

 

Gareth

 

 

 

Gareth Lester-Olivier

Calcom cc.

 <mailto:gareth@calcom.co.za> gareth@calcom.co.za

+27 82 531 8075

 


------=_NextPart_000_001C_01C6B035.B87553D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-GB link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi there<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Firstly, let me thank you for taking the time to =
develop the
driver for the EPIA motherboard onboard Trident display. Without it, I =
would
have had to find another display device for my linux =
box.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>It took me some time tearing my hair out with the =
tridentfb
driver before I finally stumbled upon this one, but I have noticed that =
when
text scrolls on the screen (like at bootup) there are glitches with the
display, little distortions that span across the display, but only when =
text is
moving on the display. Is this a known =
issue?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am running Gentoo 2006.0 kernel 2.6.16-r13, on a =
EPIA
(duh) with 128mb PC100, P3 Celeron 1.1ghz. I haven enabled an IRQ for =
the VGA
in the bios, and turned on all caching and shadowing options. Spread =
spectrum
is off. I have compiled the driver directly into the kernel, I have also
compiled the vesafb-tng driver into the kernel but no other fb =
drivers.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The line I send to the kernel is =
video=3Dcyblafb:1024x768,bpp=3D32,ref=3D85.
I only got it working this evening so I haven&#8217;t tried much else, =
as this
is the mode I wish to run in, but I will fiddle with it a =
bit.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any help / advice would be extremely =
welcome.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Many, many thanks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Gareth<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<div>

<p class=3DMsoNormal><strong><b><font size=3D1 color=3Dnavy =
face=3DVerdana><span
lang=3DEN-ZA =
style=3D'font-size:8.0pt;font-family:Verdana;color:navy'>Gareth
Lester-Olivier</span></font></b></strong><font size=3D1><span =
style=3D'font-size:
8.0pt'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D1 color=3Dnavy =
face=3DVerdana><span
lang=3DEN-ZA =
style=3D'font-size:8.0pt;font-family:Verdana;color:navy'>Calcom =
cc.</span></font></b></strong><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D1 face=3DArial><span lang=3DEN-ZA =
style=3D'font-size:
8.0pt;font-family:Arial'><a href=3D"mailto:gareth@calcom.co.za"
title=3D"mailto:gareth@calcom.co.za"><font face=3DVerdana><span =
style=3D'font-family:
Verdana'><span =
title=3D"mailto:gareth@calcom.co.za">gareth@calcom.co.za</span></span></f=
ont></a></span></font><font
size=3D1><span style=3D'font-size:8.0pt'><o:p></o:p></span></font></p>

<p class=3DMsoNormal><strong><b><font size=3D1 color=3Dnavy =
face=3DVerdana><span
lang=3DEN-ZA =
style=3D'font-size:8.0pt;font-family:Verdana;color:navy'>+27 82 531
8075</span></font></b></strong><font size=3D1><span =
style=3D'font-size:8.0pt'><o:p></o:p></span></font></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_001C_01C6B035.B87553D0--



--===============0569683522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0569683522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0569683522==--
