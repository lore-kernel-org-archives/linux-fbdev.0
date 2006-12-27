From: rami jiossy <sramij@yahoo.com>
Subject: intelfb driver on 945GM chipset
Date: Wed, 27 Dec 2006 06:23:13 -0800 (PST)
Message-ID: <20061227142314.77170.qmail@web90406.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685551037=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GzZgo-0000sy-K9 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 06:23:30 -0800
Received: from web90406.mail.mud.yahoo.com ([216.252.100.158])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GzZgo-0002hH-5z
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 06:23:30 -0800
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

--===============0685551037==
Content-Type: multipart/alternative; boundary="0-490393174-1167229393=:76580"

--0-490393174-1167229393=:76580
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hi;=0A=0AOS: Linux-2.6.19=0A=0AI am trying to boot to console with intelfb =
driver.=0A=0Amy problem is that i don't get the video mode 1024x768 when bo=
oting.=0Aaccording to intelfb documentation in this case i need to add the =
vga=3D[791,...] in ther kernel boot option. and it indeed get me the right =
resolution but it is vesafb and not intelfb :(=0Avesafb is being loaded pri=
or to to intelfb and it causes intelfb to fail on reseving fb region as i s=
ee in dmesg.=0A=0Aon the other hand, when i compile the kernel without vesa=
fb, then i don't get the required resolution at all.=0A=0Awhat should i do =
to fix it?=0Aany help would be appreciated.=0A=0Athanks=0ARami=0A=0A_______=
___________________________________________=0ADo You Yahoo!?=0ATired of spa=
m?  Yahoo! Mail has the best spam protection around =0Ahttp://mail.yahoo.co=
m 
--0-490393174-1167229393=:76580
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV>Hi;</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>OS: Linux-2.6.19<=
/DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I am trying to boot to console with intelf=
b driver.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>my problem is that i don't get t=
he video mode 1024x768 when booting.</DIV>=0A<DIV>according to intelfb docu=
mentation in this case i need to add the vga=3D[791,...] in ther kernel boo=
t option. and it indeed get me the right resolution but it is vesafb and no=
t intelfb :(</DIV>=0A<DIV>vesafb is being loaded prior to to intelfb and it=
 causes intelfb to fail on reseving fb region as i see in dmesg.</DIV>=0A<D=
IV>&nbsp;</DIV>=0A<DIV>on the other hand, when i compile the kernel without=
 vesafb, then i don't get the required resolution at all.</DIV>=0A<DIV>&nbs=
p;</DIV>=0A<DIV>what should i do to fix it?</DIV>=0A<DIV>any help would be =
appreciated.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>thanks</DIV>=0A<DIV>Rami</DIV=
>=0A<DIV>&nbsp;</DIV></div><br>____________________________________________=
______<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam p=
rotection around <br>http://mail.yahoo.com </body></html>
--0-490393174-1167229393=:76580--


--===============0685551037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0685551037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0685551037==--
