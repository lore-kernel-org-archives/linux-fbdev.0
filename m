From: =?windows-1252?Q?Fredrik_S=F6derqvist?= <freso326@student.liu.se>
Subject: Re: Problem with BitBLT
Date: Wed, 09 Jul 2003 21:29:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <5d5995f750.5f7505d599@student.liu.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="--10e2438520251df0"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail.liu.se ([130.236.1.35])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19aKdU-0005gY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Jul 2003 12:29:52 -0700
Content-Language: sv
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Nitin Mahajan <Nitin@soc-soft.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

----10e2438520251df0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I=27m a bit concerned about the tenth bit in the BR04 register=2E Datashe=
et (page 325) says=3A

=2210 Source select
      0=3A Configures the BitBLT engine to read the source data from the =
frame buffer =2E=2E=2E
      1=3A Configures the BitBLT engine to accept the source data from th=
e host CPU via the BitBLT data port =2E=2E=2E=22

So if we want copy VRAM-=3EVRAM bit 10 should be 0 - no=3F

Regarding BR04 (bits 0-7)=3A

Since 0xFF is the =22write all 1=3As=22 and you see a small block=2C I be=
lieve you are correct when you think the problem is with the transfer fro=
m System RAM -=3E VRAM=2E The 0xCC should though be what we need=2E=2E=2E=
 (source copy)=2E

Maybe you could try moving the source data to a different offset than 0=3F=
 If there are any issues with overlapping=2E=2E=2E

Filling the entire VRAM with a pattern could perhaps also help in find th=
e problem=2E

Regards=2C
F=2E S=F6derquist
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01C3463F.4D99F2A8"


------_=_NextPart_002_01C3463F.4D99F2A8
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI!
=20
Iam trying to program the Bit BLT engine of 69030 with the attached =
code, but nothing is visible on the screen.
When I select the bitwise operation as 0xFF(write to BR04) ,the white =
block is coming at desired location and of desired size.
But whwn I choose it as 0xCC nothing comes on screen...
Can any one please help me out of this......
THANKING U IN ADAVANCE
regards,
=20
Nitin Mahajan
mail:nitin@soc-soft.com
Ph:51101667. Mobile : 9886099925
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The Lord gave us two ends -- one to sit on and the other to think with. =
Success depends on which one we use the most.
=20

------_=_NextPart_002_01C3463F.4D99F2A8
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D863152217-09072003>HI!</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D863152217-09072003></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D863152217-09072003>Iam =
trying to=20
program the Bit BLT engine of 69030 with the attached code, but nothing =
is=20
visible on the screen.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D863152217-09072003>When I =
select the=20
bitwise operation as 0xFF(write to BR04)&nbsp;,the white block is coming =
at=20
desired location and of desired size.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D863152217-09072003>But =
whwn I choose it=20
as 0xCC nothing comes on screen...</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D863152217-09072003>Can =
any one please=20
help me out of this......</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D863152217-09072003>THANKING U IN=20
ADAVANCE</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D863152217-09072003>regards,</SPAN></FONT></DIV>
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
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_002_01C3463F.4D99F2A8--

----10e2438520251df0--


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
