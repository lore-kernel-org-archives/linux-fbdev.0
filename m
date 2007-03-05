From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Matrox G550, dual head, 1680x1050
Date: Mon, 5 Mar 2007 07:33:37 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0703050732340.15476@pademelon.sonytel.be>
References: <200703021053.00955.hjk@linutronix.de>
	<200703021610.58188.hjk@linutronix.de>
	<20070302152414.GC907@code-monkey.de>
	<200703042247.21590.hjk@linutronix.de>
	<45EBA3B6.3060701@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1021660322-1173076416=:15476"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HO6la-0005y7-FR for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 22:33:50 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HO6la-00024O-3G
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 04 Mar 2007 22:33:50 -0800
In-Reply-To: <45EBA3B6.3060701@vc.cvut.cz>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Tilman Sauerbeck <tilman@code-monkey.de>, xorg@lists.freedesktop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1021660322-1173076416=:15476
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Mar 2007, Petr Vandrovec wrote:
> Hans-J=FCrgen Koch wrote:
> > Am Freitag, 2. M=E4rz 2007 16:24 schrieb Tilman Sauerbeck:
> > Meanwhile I doubt this explanation. Here's what fbset has to say:
> >=20
> > $ fbset -fb /dev/fb1 --show
> >=20
> > mode "1680x1050-60"
> >     # D: 135.501 MHz, H: 65.396 kHz, V: 59.997 Hz
> >     geometry 1680 1050 1680 1050 32
> >     timings 7380 32 224 32 4 136 4
> >     rgba 8/16,8/8,8/0,8/24
> > endmode
> >=20
> > So, even fbset thinks it's 1680x1050. But where does the distortion c=
ome=20
> > from???
>=20
> Can you try setting vxres for second head from 1680 to 1696, or 1728?=20
> Maybe X look at vxres and not at framebuffer line length (what fbset -i=
=20
> reports for line length?)

These days at least the X server in Debian looks correctly at the frame b=
uffer
line length, else it wouldn't work on PS3 with non-fullscreen modes.

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
---584337861-1021660322-1173076416=:15476
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
---584337861-1021660322-1173076416=:15476
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

---584337861-1021660322-1173076416=:15476--
