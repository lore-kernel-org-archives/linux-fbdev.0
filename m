From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Tue, 6 Mar 2007 10:48:36 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0703061046190.4463@pademelon.sonytel.be>
References: <200703021053.00955.hjk@linutronix.de>
	<200703042247.21590.hjk@linutronix.de>
	<45EBA3B6.3060701@vc.cvut.cz> <200703052102.31786.hjk@linutronix.de>
	<45ED337B.6010209@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1690889777-1173174516=:4463"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOWHy-0006le-GY for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 01:48:58 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOWHx-0000Lo-1z
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 01:48:58 -0800
In-Reply-To: <45ED337B.6010209@vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Tilman Sauerbeck <tilman@code-monkey.de>, xorg@lists.freedesktop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1690889777-1173174516=:4463
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Mar 2007, Petr Vandrovec wrote:
> Hans-J=FCrgen Koch wrote:
> > This initializes the primary head correctly. The second head is proba=
bly=20
> > wrong, because the monitor's on screen message complains about a non-=
ideal=20
> > resolution.
>=20
> Second head always starts in 640x480/32bpp.  You have to use fbset to=20
> switch it to different mode, so matroxfb works fine as far as I can tel=
l.

> > $ fbset -fb /dev/fb1 -g 1680 1050 1696 1050 32 -t 7380 224 32 32 4 13=
6 4
                                      ^^^^
> >=20
> > With that, the image on the second monitor immediately becomes clear,=
 and I=20
> > have a fully working xinerama configuration then.
>=20
> Yes, and this corrects X programming mistake.
>=20
> > As far as I can see, fbset is the only way to initialize the second h=
ead=20
> > properly. Neither matroxfb nor mga do it correctly with 1680x1050.
>=20
> Well, fbset =3D=3D matroxfb, so I do not quite understand your complain=
t.

If I followed this discussion correctly, there's still an issue with matr=
oxfb,
as it doesn't seem to round up xres_virtual to 1696 automatically.
You have to do that yourself.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds
---584337861-1690889777-1173174516=:4463
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---584337861-1690889777-1173174516=:4463
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1690889777-1173174516=:4463--
