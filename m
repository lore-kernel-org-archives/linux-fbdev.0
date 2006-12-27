From: rami jiossy <sramij@yahoo.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Wed, 27 Dec 2006 12:41:45 -0800 (PST)
Message-ID: <20061227204145.74204.qmail@web90411.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0458067796=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gzfb0-0006Xq-L5 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 12:41:54 -0800
Received: from web90411.mail.mud.yahoo.com ([216.252.100.163])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gzfax-00012Q-Bo
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 Dec 2006 12:41:54 -0800
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

--===============0458067796==
Content-Type: multipart/alternative; boundary="0-823724099-1167252105=:74180"

--0-823724099-1167252105=:74180
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

actually i tried video=3Dintelfb:mode=3D1024x768-16@75 instead and it didn'=
t work for me.=0AThanks=0A=0A=0A----- Original Message ----=0AFrom: Dennis =
Munsie <dmunsie@cecropia.com>=0ATo: linux-fbdev-devel@lists.sourceforge.net=
=0ASent: Wednesday, December 27, 2006 5:47:16 PM=0ASubject: Re: [Linux-fbde=
v-devel] intelfb driver on 945GM chipset=0A=0A=0Atry putting this in instea=
d:=0A=0Avideo=3Dintelfb:1024x768@60=0A=0Athat should force it to use the in=
telfb driver at your desired  =0Aresolution.=0A=0Adennis=0A=0AOn Dec 27, 20=
06, at 9:23 AM, rami jiossy wrote:=0A=0A> Hi;=0A>=0A> OS: Linux-2.6.19=0A>=
=0A> I am trying to boot to console with intelfb driver.=0A>=0A> my problem=
 is that i don't get the video mode 1024x768 when booting.=0A> according to=
 intelfb documentation in this case i need to add the  =0A> vga=3D[791,...]=
 in ther kernel boot option. and it indeed get me the  =0A> right resolutio=
n but it is vesafb and not intelfb :(=0A> vesafb is being loaded prior to t=
o intelfb and it causes intelfb to  =0A> fail on reseving fb region as i se=
e in dmesg.=0A>=0A> on the other hand, when i compile the kernel without ve=
safb, then i  =0A> don't get the required resolution at all.=0A>=0A> what s=
hould i do to fix it?=0A> any help would be appreciated.=0A>=0A> thanks=0A>=
 Rami=0A=0A=0A-------------------------------------------------------------=
------------=0ATake Surveys. Earn Cash. Influence the Future of IT=0AJoin S=
ourceForge.net's Techsay panel and you'll get the chance to share your=0Aop=
inions on IT & business topics through brief surveys - and earn cash=0Ahttp=
://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDEVDEV=
=0A_______________________________________________=0ALinux-fbdev-devel mail=
ing list=0ALinux-fbdev-devel@lists.sourceforge.net=0Ahttps://lists.sourcefo=
rge.net/lists/listinfo/linux-fbdev-devel=0A=0A_____________________________=
_____________________=0ADo You Yahoo!?=0ATired of spam?  Yahoo! Mail has th=
e best spam protection around =0Ahttp://mail.yahoo.com 
--0-823724099-1167252105=:74180
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">actually i tried video=3Dintelfb:mode=3D1024x768-=
16@75 instead and it didn't work for me.</DIV>=0A<DIV style=3D"FONT-SIZE: 1=
2pt; FONT-FAMILY: times new roman, new york, times, serif">Thanks<BR><BR></=
DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new yor=
k, times, serif">----- Original Message ----<BR>From: Dennis Munsie &lt;dmu=
nsie@cecropia.com&gt;<BR>To: linux-fbdev-devel@lists.sourceforge.net<BR>Sen=
t: Wednesday, December 27, 2006 5:47:16 PM<BR>Subject: Re: [Linux-fbdev-dev=
el] intelfb driver on 945GM chipset<BR><BR>=0A<DIV>try putting this in inst=
ead:<BR><BR>video=3Dintelfb:1024x768@60<BR><BR>that should force it to use =
the intelfb driver at your desired&nbsp;&nbsp;<BR>resolution.<BR><BR>dennis=
<BR><BR>On Dec 27, 2006, at 9:23 AM, rami jiossy wrote:<BR><BR>&gt; Hi;<BR>=
&gt;<BR>&gt; OS: Linux-2.6.19<BR>&gt;<BR>&gt; I am trying to boot to consol=
e with intelfb driver.<BR>&gt;<BR>&gt; my problem is that i don't get the v=
ideo mode 1024x768 when booting.<BR>&gt; according to intelfb documentation=
 in this case i need to add the&nbsp;&nbsp;<BR>&gt; vga=3D[791,...] in ther=
 kernel boot option. and it indeed get me the&nbsp;&nbsp;<BR>&gt; right res=
olution but it is vesafb and not intelfb :(<BR>&gt; vesafb is being loaded =
prior to to intelfb and it causes intelfb to&nbsp;&nbsp;<BR>&gt; fail on re=
seving fb region as i see in dmesg.<BR>&gt;<BR>&gt; on the other hand, when=
 i compile the kernel without vesafb, then i&nbsp;&nbsp;<BR>&gt; don't get =
the required resolution at all.<BR>&gt;<BR>&gt; what should i
 do to fix it?<BR>&gt; any help would be appreciated.<BR>&gt;<BR>&gt; thank=
s<BR>&gt; Rami<BR><BR><BR>-------------------------------------------------=
------------------------<BR>Take Surveys. Earn Cash. Influence the Future o=
f IT<BR>Join SourceForge.net's Techsay panel and you'll get the chance to s=
hare your<BR>opinions on IT &amp; business topics through brief surveys - a=
nd earn cash<BR><A href=3D"http://www.techsay.com/default.php?page=3Djoin.p=
hp&amp;p=3Dsourceforge&amp;CID=3DDEVDEV" target=3D_blank>http://www.techsay=
.com/default.php?page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV</A><B=
R>_______________________________________________<BR>Linux-fbdev-devel mail=
ing list<BR>Linux-fbdev-devel@lists.sourceforge.net<BR><A href=3D"https://l=
ists.sourceforge.net/lists/listinfo/linux-fbdev-devel" target=3D_blank>http=
s://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel</A></DIV></DIV>=
=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, t=
imes, serif"><BR></DIV></div><br>__________________________________________=
________<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam=
 protection around <br>http://mail.yahoo.com </body></html>
--0-823724099-1167252105=:74180--


--===============0458067796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0458067796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0458067796==--
