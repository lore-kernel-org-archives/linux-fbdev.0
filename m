From: rami jiossy <sramij@yahoo.com>
Subject: Re: direct frame buffer application
Date: Sat, 17 Mar 2007 13:35:36 -0700 (PDT)
Message-ID: <890464.98573.qm@web90410.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1008583072=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HSfd5-0004qi-B9 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Mar 2007 13:35:55 -0700
Received: from web90410.mail.mud.yahoo.com ([216.252.100.162])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HSfd3-0002Vz-0x
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 17 Mar 2007 13:35:55 -0700
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
Cc: priyark1@gmail.com

--===============1008583072==
Content-Type: multipart/alternative; boundary="0-71472832-1174163736=:98573"

--0-71472832-1174163736=:98573
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

It depends what are the errors you get!=0A=0ADo you have the device file /d=
ev/fb0?=0Ahave you tried using the kernel commad parameter   vga=3D{video_m=
ode}  on boot?=0Acan you try other application using directfb and see if it=
s working? maybe vlc with --vout=3Ddirectfb commmand line.=0A=0AThanks=0ARa=
mi=0A=0A----- Original Message ----=0AFrom: krishna priya <priyark1@gmail.c=
om>=0ATo: linux-fbdev-devel@lists.sourceforge.net=0ASent: Thursday, March 1=
5, 2007 12:20:27 PM=0ASubject: [Linux-fbdev-devel] direct frame buffer appl=
ication=0A=0AHi everybody=0A=0AThis is priya working on linux-2.6.12 kernel=
 on omapldk5912 board.I am trying load direct librraies on ldk board using =
2.6.12 kernel.I am able to load the libraries successfully  but i am not ab=
le to run the Direct Frame buffer application with the libraries.that appli=
cation is direclty entering in to Error messages that the driver is not ope=
ning for this application.That means the frame buffer driver itself is not =
initializing for this application.=0A=0A=0AVersion of DirectFB-0.9.20=0A=0A=
=0AAny one can suggest me how to use the frame buffer driver to run the dir=
ectFB application using  /dev/fb0 device.=0A=0A-- =0AThanks =0AKrishna Priy=
a=0A-----------------------------------------------------------------------=
--=0ATake Surveys. Earn Cash. Influence the Future of IT=0AJoin SourceForge=
.net's Techsay panel and you'll get the chance to share your=0Aopinions on =
IT & business topics through brief surveys-and earn cash=0Ahttp://www.techs=
ay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDEVDEV=0A_________=
______________________________________=0ALinux-fbdev-devel mailing list=0AL=
inux-fbdev-devel@lists.sourceforge.net=0Ahttps://lists.sourceforge.net/list=
s/listinfo/linux-fbdev-devel=0A=0A=0A =0A__________________________________=
__________________________________________________=0ATV dinner still coolin=
g? =0ACheck out "Tonight's Picks" on Yahoo! TV.=0Ahttp://tv.yahoo.com/
--0-71472832-1174163736=:98573
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">It depends what are the errors you get!</DIV>=0A<=
DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times=
, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times n=
ew roman, new york, times, serif">Do you have the device file /dev/fb0?</DI=
V>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york,=
 times, serif">have you tried using the kernel commad parameter&nbsp;&nbsp;=
 vga=3D{video_mode}&nbsp; on boot?</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; F=
ONT-FAMILY: times new roman, new york, times, serif">can you try other appl=
ication using directfb and see if its working? maybe vlc with --vout=3Ddire=
ctfb commmand line.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: tim=
es new roman, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZ=
E: 12pt; FONT-FAMILY: times new roman, new york, times, serif">Thanks<BR>Ra=
mi<BR></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman,=
 new york, times, serif">----- Original Message ----<BR>From: krishna priya=
 &lt;priyark1@gmail.com&gt;<BR>To: linux-fbdev-devel@lists.sourceforge.net<=
BR>Sent: Thursday, March 15, 2007 12:20:27 PM<BR>Subject: [Linux-fbdev-deve=
l] direct frame buffer application<BR><BR>Hi everybody<BR><BR>This is priya=
 working on linux-2.6.12 kernel on omapldk5912 board.I am trying load direc=
t librraies on ldk board using 2.6.12 kernel.I am able to load the librarie=
s successfully&nbsp; but i am not able to run the Direct Frame buffer appli=
cation with the libraries.that application is direclty entering in to Error=
 messages that the driver is not opening for this application.That means th=
e frame buffer driver itself is not initializing for this application.<BR><=
BR><BR>Version of DirectFB-0.9.20<BR><BR><BR>Any one can suggest me how to =
use the frame buffer driver to run the directFB application using&nbsp; /de=
v/fb0 device.<BR><BR>--
 <BR>Thanks <BR>Krishna Priya=0A<DIV>--------------------------------------=
-----------------------------------<BR>Take Surveys. Earn Cash. Influence t=
he Future of IT<BR>Join SourceForge.net's Techsay panel and you'll get the =
chance to share your<BR>opinions on IT &amp; business topics through brief =
surveys-and earn cash<BR><A href=3D"http://www.techsay.com/default.php?page=
=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV" target=3D_blank>http://ww=
w.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEV=
DEV</A></DIV>=0A<DIV>_______________________________________________<BR>Lin=
ux-fbdev-devel mailing list<BR>Linux-fbdev-devel@lists.sourceforge.net<BR><=
A href=3D"https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel" t=
arget=3D_blank>https://lists.sourceforge.net/lists/listinfo/linux-fbdev-dev=
el</A></DIV></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new =
roman, new york, times, serif"><BR></DIV></div><br>=0A=0A<hr size=3D1>=0ADo=
n't get soaked.  Take a<a href=3D"=0Ahttp://tools.search.yahoo.com/shortcut=
s/?fr=3Doni_on_mail&#news"> quick peek at the forecast </a><br> with the<a =
href=3D"=0Ahttp://tools.search.yahoo.com/shortcuts/?fr=3Doni_on_mail&#news"=
>Yahoo! Search weather shortcut.</a></body></html>
--0-71472832-1174163736=:98573--


--===============1008583072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1008583072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1008583072==--
