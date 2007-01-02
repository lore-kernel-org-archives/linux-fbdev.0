From: rami jiossy <sramij@yahoo.com>
Subject: Re: intelfb driver on 945GM chipset
Date: Tue, 2 Jan 2007 03:33:19 -0800 (PST)
Message-ID: <20070102113319.45663.qmail@web90404.mail.mud.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742986696=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1htV-0007Tk-NV for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:33:25 -0800
Received: from web90404.mail.mud.yahoo.com ([216.252.100.156])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H1htV-0003OU-2Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Jan 2007 03:33:25 -0800
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

--===============1742986696==
Content-Type: multipart/alternative; boundary="0-201252087-1167737599=:45507"

--0-201252087-1167737599=:45507
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

i connected my machine to CRT monitor for check but it also failed on the s=
ame "non-CRT ..." error.=0A=0AThanks=0A=0A=0A----- Original Message ----=0A=
From: Sergey Vlasov <vsu@altlinux.ru>=0ATo: Dave Airlie <airlied@gmail.com>=
=0ACc: linux-fbdev-devel@lists.sourceforge.net=0ASent: Tuesday, January 2, =
2007 1:11:10 PM=0ASubject: Re: [Linux-fbdev-devel] intelfb driver on 945GM =
chipset=0A=0A=0AOn Tue, Jan 02, 2007 at 01:27:57PM +1100, Dave Airlie wrote=
:=0A> On 12/29/06, rami jiossy <sramij@yahoo.com> wrote:=0A> > here is my d=
mesg output.=0A> > as you can see below intelfb claims no video mode config=
ured at boot time=0A> > inspit is does.=0A> =0A> Intelfb doesn't support mo=
de switching on non-CRT devices, I've=0A> contemplated doing the work, but =
I really don't have a requirement for=0A> it and it is a lot of work..=0A=
=0AI have seen a board (Kontron CP306 3U CompactPCI) with which intelfb=0Aa=
lways claims that there is a non-CRT device connected - but the board=0Ahas=
 only a VGA output.  Probably this is just another broken BIOS...=0A=0A> I'=
m not sure how you can get the mode set to 1024x768 before intelfb runs..=
=0A=0ABuilding intelfb into the kernel and using the vga=3D... parameter li=
ke=0Awith vesafb used to work in this case.=0A-----------------------------=
--------------------------------------------=0ATake Surveys. Earn Cash. Inf=
luence the Future of IT=0AJoin SourceForge.net's Techsay panel and you'll g=
et the chance to share your=0Aopinions on IT & business topics through brie=
f surveys - and earn cash=0Ahttp://www.techsay.com/default.php?page=3Djoin.=
php&p=3Dsourceforge&CID=3DDEVDEV=0A________________________________________=
_______=0ALinux-fbdev-devel mailing list=0ALinux-fbdev-devel@lists.sourcefo=
rge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel=0A=
=0A__________________________________________________=0ADo You Yahoo!?=0ATi=
red of spam?  Yahoo! Mail has the best spam protection around =0Ahttp://mai=
l.yahoo.com 
--0-201252087-1167737599=:45507
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">i connected my machine&nbsp;to CRT monitor for ch=
eck but it also failed on the same "non-CRT ..." error.</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman,=
 new york, times, serif">Thanks<BR><BR></DIV>=0A<DIV style=3D"FONT-SIZE: 12=
pt; FONT-FAMILY: times new roman, new york, times, serif">----- Original Me=
ssage ----<BR>From: Sergey Vlasov &lt;vsu@altlinux.ru&gt;<BR>To: Dave Airli=
e &lt;airlied@gmail.com&gt;<BR>Cc: linux-fbdev-devel@lists.sourceforge.net<=
BR>Sent: Tuesday, January 2, 2007 1:11:10 PM<BR>Subject: Re: [Linux-fbdev-d=
evel] intelfb driver on 945GM chipset<BR><BR>=0A<DIV>On Tue, Jan 02, 2007 a=
t 01:27:57PM +1100, Dave Airlie wrote:<BR>&gt; On 12/29/06, rami jiossy &lt=
;sramij@yahoo.com&gt; wrote:<BR>&gt; &gt; here is my dmesg output.<BR>&gt; =
&gt; as you can see below intelfb claims no video mode configured at boot t=
ime<BR>&gt; &gt; inspit is does.<BR>&gt; <BR>&gt; Intelfb doesn't support m=
ode switching on non-CRT devices, I've<BR>&gt; contemplated doing the work,=
 but I really don't have a requirement for<BR>&gt; it and it is a lot of wo=
rk..<BR><BR>I have seen a board (Kontron CP306 3U CompactPCI) with which in=
telfb<BR>always claims that there is a non-CRT device connected - but the b=
oard<BR>has only a VGA output.&nbsp;&nbsp;Probably this is just another bro=
ken BIOS...<BR><BR>&gt; I'm not sure how you can get the mode set to 1024x7=
68 before intelfb runs..<BR><BR>Building intelfb into the kernel and using =
the vga=3D... parameter like<BR>with vesafb used to work in this case.</DIV=
>=0A<DIV>------------------------------------------------------------------=
-------<BR>Take Surveys. Earn Cash. Influence the Future of IT<BR>Join Sour=
ceForge.net's Techsay panel and you'll get the chance to share your<BR>opin=
ions on IT &amp; business topics through brief surveys - and earn cash<BR><=
A href=3D"http://www.techsay.com/default.php?page=3Djoin.php&amp;p=3Dsource=
forge&amp;CID=3DDEVDEV" target=3D_blank>http://www.techsay.com/default.php?=
page=3Djoin.php&amp;p=3Dsourceforge&amp;CID=3DDEVDEV</A></DIV>=0A<DIV>_____=
__________________________________________<BR>Linux-fbdev-devel mailing lis=
t<BR>Linux-fbdev-devel@lists.sourceforge.net<BR><A href=3D"https://lists.so=
urceforge.net/lists/listinfo/linux-fbdev-devel" target=3D_blank>https://lis=
ts.sourceforge.net/lists/listinfo/linux-fbdev-devel</A></DIV></DIV>=0A<DIV =
style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, se=
rif"><BR></DIV></div><br>__________________________________________________=
<br>Do You Yahoo!?<br>Tired of spam?  Yahoo! Mail has the best spam protect=
ion around <br>http://mail.yahoo.com </body></html>
--0-201252087-1167737599=:45507--


--===============1742986696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1742986696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1742986696==--
