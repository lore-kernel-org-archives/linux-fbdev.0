From: "Nitin Mahajan" <Nitin@soc-soft.com>
Subject: Driver for 69030
Date: Tue, 22 Jul 2003 19:16:33 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E519BE9E8DAC6A4B89DA4AD1D2A155B723F75E@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C35057.A9D7B55B"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [202.138.125.47] (helo=vscrn4.securesynergyonline.com)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19exTp-0000Zo-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 22 Jul 2003 06:47:02 -0700
Received: from mail.soc-soft.com (202.56.254.199) by vscrn4.securesynergyonline.com (202.138.125.47), id <1058881053512.1161227.vscrn4.securesynergyonline.com>
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 22 Jul 2003 19:07:33 +0530
content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C35057.A9D7B55B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone!
=20
Iam writing a driver for 69030 card.
I have to support CIF and QCIF formats.
=20
1. The format says that a frame rate of 30fps is required for both.
=20
2.Each frame should have
   a. 144 lines and 176 pixels/line for QCIF.
   b. 288 lines and 352 pixels/line for CIF.
=20
Now my interpretation is that the second point above refers to the frame
size and the driver implementation (video modes)has nothing to do with
it.
Is this interpretation of mine is correct?
Second question is that ,how do I achive the frame rate of 30fps?I have
programmed the BitBLT engine for the card,but that also puts only 64Kb
data on screen in on shot,so always I need to divide the Image into 64KB
parts.
What else hardware need to be programmed to achive this???Can this be
achived without programming the multimedia engine?
How willl I test that what frame rate Iam getting????
=20
Thanking u in advance
regards,
=20
Nitin Mahajan
mail:nitin@soc-soft.com
Ph:51101667. Mobile : 9886099925
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Lord gave us two ends -- one to sit on and the other to think with.
Success depends on which one we use the most.
=20
=20
Nitin Mahajan
Socrates Software India Pvt Ltd...
mail:nitin@soc-soft.com
Ph:51101667. Mobile : 9886099925
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Lord gave us two ends -- one to sit on and the other to think with.
Success depends on which one we use the most.
=20

------_=_NextPart_001_01C35057.A9D7B55B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>Hello=20
Everyone!</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>Iam =
writing a driver=20
for 69030 card.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>I have =
to support=20
CIF and QCIF formats.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>1. The =
format says=20
that a frame rate of 30fps is required for both.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>2.Each =
frame should=20
have</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial =
size=3D2>&nbsp;&nbsp; a. 144=20
lines and 176 pixels/line for QCIF.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial =
size=3D2>&nbsp;&nbsp;=20
b.&nbsp;288 lines and 352 pixels/line for CIF.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>Now=20
my&nbsp;interpretation is that the second point above refers to the =
frame size=20
and the driver implementation (video modes)has nothing to do with=20
it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>Is =
this=20
interpretation of mine is correct?</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>Second =
question is=20
that ,how do I achive the frame rate of 30fps?I have programmed the =
BitBLT=20
engine for the card,but that also puts only 64Kb data on screen in on =
shot,so=20
always I need to divide the Image into 64KB parts.</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>What =
else hardware=20
need to be programmed to achive this???Can this be achived without =
programming=20
the multimedia engine?</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial size=3D2>How =
willl I test=20
that what frame rate Iam getting????</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial =
size=3D2>Thanking u in=20
advance</FONT></SPAN></DIV>
<DIV><SPAN class=3D691023104-22072003><FONT face=3DArial=20
size=3D2>regards,</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>Nitin =
Mahajan</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>
<DIV align=3Dleft><FONT face=3DVerdana=20
size=3D2>mail:nitin@soc-soft.com</FONT></DIV></FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>Ph:51101667. Mobile :=20
9886099925</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>The Lord gave us two =
ends -- one to=20
sit on and the other to think with. Success depends on which one we use =
the=20
most.</FONT></DIV>
<DIV>&nbsp;</DIV></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>Nitin =
Mahajan</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>Socrates Software India =
Pvt=20
Ltd...</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>
<DIV align=3Dleft><FONT face=3DVerdana=20
size=3D2>mail:nitin@soc-soft.com</FONT></DIV></FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>Ph:51101667. Mobile :=20
9886099925</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana=20
size=3D2>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</FONT></DIV>
<DIV align=3Dleft><FONT face=3DVerdana size=3D2>The Lord gave us two =
ends -- one to=20
sit on and the other to think with. Success depends on which one we use =
the=20
most.</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C35057.A9D7B55B--
Scanned by SecureSynergy VirusScreen Service. 
For more information log on to : http://www.securesynergyonline.com or http://www.securesynergy.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
