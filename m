From: "Steve Spano" <steve@flconsult.com>
Subject: ##3 Frame Buffer Questions?
Date: Fri, 18 Aug 2006 10:30:20 -0400
Message-ID: <010701c6c2d2$e04cd450$6400a8c0@fleballnchain>
Reply-To: steve@flconsult.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1121748470=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GE5O1-0002fH-Qm for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Aug 2006 07:31:49 -0700
Received: from mail.danica.com ([205.232.74.72] helo=danicacomputing.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GE5Nz-0002sC-3i
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 18 Aug 2006 07:31:49 -0700
Received: from fleballnchain (cpe-24-59-110-67.twcny.res.rr.com [24.59.110.67])
	by danicacomputing.com (mail2.danicacomputing.com)
	(MDaemon PRO v9.0.4) with ESMTP id md50001158051.msg
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 18 Aug 2006 10:30:54 -0400
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1121748470==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0108_01C6C2B1.593B3450"

This is a multi-part message in MIME format.

------=_NextPart_000_0108_01C6C2B1.593B3450
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Folks,

 

I have a question.


Working on a "semi-custom" frame buffer for a Xilinx FPGA with the
Microblaze.

 

The specific file we started with is already in the
uclinux/drivers/video and is called xilinxfb.c

 

We can register the driver and a debug trace in the driver shows that it
registers as FB0 29-0, so that should be right.

 

However, if I do a cat /dev/fb0  the linux responds by saying it can't
open the device. It appears that somehow the default file pointer in
dev/fb0 cannot connect to the actual driver?

 

MKNODing the driver also fails.

 

I do have other drivers that we have made that do install, so this isn't
the first attempt at a driver.

 

Any thoughts on where I may look for some ideas on this?

 

Thanks!

 

Steve Spano, President

Finger Lakes Engineering

119 South Cayuga #200

Ithaca, Ny 14850

(V) 607-277-1614 x223

(C) 607-342-1150

www.FL-ENG.com - FLE's Main Website

www.FLEDEVFORUM.com - FLE's Developer Forum

 

 


------=_NextPart_000_0108_01C6C2B1.593B3450
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
p.MsoAutoSig, li.MsoAutoSig, div.MsoAutoSig
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{font-family:Arial;
	color:windowtext;}
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

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi Folks,</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I have a question.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><br>
Working on a &#8220;semi-custom&#8221; frame buffer for a Xilinx FPGA =
with the Microblaze.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>The specific file we started with is already in the =
uclinux/drivers/video
and is called xilinxfb.c</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>We can register the driver and a debug trace in the =
driver
shows that it registers as FB0 29-0, so that should be =
right.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>However, if I do a cat /dev/fb0&nbsp; the linux =
responds by
saying it can&#8217;t open the device. It appears that somehow the =
default file
pointer in dev/fb0 cannot connect to the actual =
driver?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>MKNODing the driver also fails.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I do have other drivers that we have made that do =
install,
so this isn&#8217;t the first attempt at a driver.</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Any thoughts on where I may look for some ideas on =
this?</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thanks!</span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>Steve Spano, President</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
 10.0pt'>Finger Lakes</span></font><font size=3D2><span =
style=3D'font-size:10.0pt'>
Engineering</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>119 South Cayuga #200</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
  10.0pt'>Ithaca</span></font><font size=3D2><span =
style=3D'font-size:10.0pt'>, </span></font><font
  size=3D2><span style=3D'font-size:10.0pt'>Ny</span></font><font =
size=3D2><span
 style=3D'font-size:10.0pt'> </span></font><font size=3D2><span =
style=3D'font-size:
  10.0pt'>14850</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>(V) 607-277-1614 x223</span></font></p>

<p class=3DMsoAutoSig><font size=3D2 face=3D"Times New Roman"><span =
style=3D'font-size:
10.0pt'>(C) 607-342-1150</span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><a =
href=3D"http://www.FL-ENG.com">www.FL-ENG.com</a></span></font><font
face=3DArial><span style=3D'font-family:Arial'>&nbsp;- FLE's Main =
Website</span></font></p>

<p class=3DMsoAutoSig><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'><a =
href=3D"http://www.FLEDEVFORUM.com">www.FLEDEVFORUM.com</a>
- FLE's Developer Forum</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0108_01C6C2B1.593B3450--



--===============1121748470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1121748470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1121748470==--
