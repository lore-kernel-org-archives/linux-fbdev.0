From: rami jiossy <sramij@yahoo.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Tue, 2 Jan 2007 03:31:57 -0800 (PST)
Message-ID: <20070102113157.53221.qmail@web90401.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1391975535=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1hsL-0007O6-84 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:32:13 -0800
Received: from web90401.mail.mud.yahoo.com ([216.252.100.153])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H1hsI-0005dF-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:32:13 -0800
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

--===============1391975535==
Content-Type: multipart/alternative; boundary="0-1750555607-1167737517=:53184"

--0-1750555607-1167737517=:53184
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

----- Original Message ----=0AFrom: Sergey Vlasov <vsu@altlinux.ru>=0ATo: D=
ave Airlie <airlied@gmail.com>=0ACc: linux-fbdev-devel@lists.sourceforge.ne=
t=0ASent: Tuesday, January 2, 2007 1:11:10 PM=0ASubject: Re: [Linux-fbdev-d=
evel] intelfb driver on 945GM chipset=0A=0A=0AOn Tue, Jan 02, 2007 at 01:27=
:57PM +1100, Dave Airlie wrote:=0A> On 12/29/06, rami jiossy <sramij@yahoo.=
com> wrote:=0A> > here is my dmesg output.=0A> > as you can see below intel=
fb claims no video mode configured at boot time=0A> > inspit is does.=0A> =
=0A> Intelfb doesn't support mode switching on non-CRT devices, I've=0A> co=
ntemplated doing the work, but I really don't have a requirement for=0A> it=
 and it is a lot of work..=0A=0AI have seen a board (Kontron CP306 3U Compa=
ctPCI) with which intelfb=0Aalways claims that there is a non-CRT device co=
nnected - but the board=0Ahas only a VGA output.  Probably this is just ano=
ther broken BIOS...=0A=0A> I'm not sure how you can get the mode set to 102=
4x768 before intelfb runs..=0A=0ABuilding intelfb into the kernel and using=
 the vga=3D... parameter like=0Awith vesafb used to work in this case.=0A=
=0A>>> vga=3DXXX causes the vesafb to be loaded prior to the intelfb and re=
serve the fb memory region so the intelfb will fail on initialization phase=
. =0A=0AThanks=0A----------------------------------------------------------=
---------------=0ATake Surveys. Earn Cash. Influence the Future of IT=0AJoi=
n SourceForge.net's Techsay panel and you'll get the chance to share your=
=0Aopinions on IT & business topics through brief surveys - and earn cash=
=0Ahttp://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=
=3DDEVDEV=0A_______________________________________________=0ALinux-fbdev-d=
evel mailing list=0ALinux-fbdev-devel@lists.sourceforge.net=0Ahttps://lists=
.sourceforge.net/lists/listinfo/linux-fbdev-devel=0A=0A____________________=
______________________________=0ADo You Yahoo!?=0ATired of spam?  Yahoo! Ma=
il has the best spam protection around =0Ahttp://mail.yahoo.com 
--0-1750555607-1167737517=:53184
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif"><BR><BR>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FA=
MILY: times new roman, new york, times, serif">----- Original Message ----<=
BR>From: Sergey Vlasov &lt;vsu@altlinux.ru&gt;<BR>To: Dave Airlie &lt;airli=
ed@gmail.com&gt;<BR>Cc: linux-fbdev-devel@lists.sourceforge.net<BR>Sent: Tu=
esday, January 2, 2007 1:11:10 PM<BR>Subject: Re: [Linux-fbdev-devel] intel=
fb driver on 945GM chipset<BR><BR>=0A<DIV>On Tue, Jan 02, 2007 at 01:27:57P=
M +1100, Dave Airlie wrote:<BR>&gt; On 12/29/06, rami jiossy &lt;sramij@yah=
oo.com&gt; wrote:<BR>&gt; &gt; here is my dmesg output.<BR>&gt; &gt; as you=
 can see below intelfb claims no video mode configured at boot time<BR>&gt;=
 &gt; inspit is does.<BR>&gt; <BR>&gt; Intelfb doesn't support mode switchi=
ng on non-CRT devices, I've<BR>&gt; contemplated doing the work, but I real=
ly don't have a requirement for<BR>&gt; it and it is a lot of work..<BR><BR=
>I have seen a board (Kontron CP306 3U CompactPCI) with which intelfb<BR>al=
ways claims that there is a non-CRT device connected - but the board<BR>has=
 only a VGA output.&nbsp;&nbsp;Probably this is just another broken BIOS...=
<BR><BR>&gt; I'm not sure how you can get the mode set to 1024x768 before i=
ntelfb runs..<BR><BR>Building intelfb into the kernel and using the vga=3D.=
.. parameter like<BR>with vesafb used to work in this case.</DIV>=0A<DIV>&n=
bsp;</DIV>=0A<DIV>&gt;&gt;&gt; vga=3DXXX causes the vesafb to be loaded pri=
or to the intelfb and reserve the fb memory region so the intelfb will fail=
 on initialization phase. </DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Thanks</DIV>=0A=
<DIV>----------------------------------------------------------------------=
---<BR>Take Surveys. Earn Cash. Influence the Future of IT<BR>Join SourceFo=
rge.net's Techsay panel and you'll get the chance to share your<BR>opinions=
 on IT &amp; business topics through brief surveys - and earn cash<BR><A hr=
ef=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsourceforg=
e&amp;CID=3DDEVDEV" target=3D_blank>http://www.techsay.com/default.php?page=
=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV</A></DIV>=0A<DIV>_________=
______________________________________<BR>Linux-fbdev-devel mailing list<BR=
>Linux-fbdev-devel@lists.sourceforge.net<BR><A href=3D"https://lists.source=
forge.net/lists/listinfo/linux-fbdev-devel" target=3D_blank>https://lists.s=
ourceforge.net/lists/listinfo/linux-fbdev-devel</A></DIV></DIV><BR></DIV></=
div><br>__________________________________________________<br>Do You Yahoo!=
?<br>Tired of spam?  Yahoo! Mail has the best spam protection around <br>ht=
tp://mail.yahoo.com </body></html>
--0-1750555607-1167737517=:53184--


--===============1391975535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1391975535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1391975535==--
