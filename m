From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 7 Aug 2005 22:34:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508072232190.31010@gorilla.sonytel.be>
References: <9e473391050805184756f055ea@mail.gmail.com> 
 <Pine.LNX.4.62.0508071145100.31010@gorilla.sonytel.be> 
 <9e473391050807083327b190f9@mail.gmail.com>  <1123430435.3848.332.camel@localhost>
  <1123431300.30257.116.camel@gaston>  <1123432349.3978.335.camel@localhost>
 <9e47339105080709537a8064bb@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584328900-1158030984-1123446853=:31010"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1rve-00079o-8m
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 13:39:30 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1rvd-0002B7-L4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 13:39:30 -0700
Received: from gorilla.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j77KdPva019886
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 7 Aug 2005 22:39:26 +0200 (MEST)
In-Reply-To: <9e47339105080709537a8064bb@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584328900-1158030984-1123446853=:31010
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id j77KdPva019886

On Sun, 7 Aug 2005, Jon Smirl wrote:
> On 8/7/05, Michel D=E4nzer <michel@daenzer.net> wrote:
> > On Sun, 2005-08-07 at 18:14 +0200, Benjamin Herrenschmidt wrote:
> > > > > The problem is that the radeonfb driver sees bpp =3D 32 and the=
n sets
> > > > > rgbt =3D 8/8/8/8. It stomps rgbt without looking at it.
> > > >
> > > > Looks like a radeonfb bug.
> > >
> > > It's not a bug :) radeonfb doesn't support anything but that format=
 for
> > > now.
> >=20
> > According to Geert's rules, it should fail instead of rounding down
> > r/g/b.

They are not really `my' rules, just the original fbdev rules from 1994.

> One problem with these rules is that it makes it hard to determine
> what is the best config available. I can't just set in 255BPP and then
> let it tell me the best available config.

Indeed. But you can more-or-less scan for modes.

> What config should I get if everything is zero, BPP and rgbt?
> According to the rules this is an error, should it instead return the
> best config?

It's not an error, since you can round up from 0.

It depends on your hardware.

Monochrome or pseudocolor 1 bpp, if the hardware supports it.
Or 32 bpp ARGB8888, if that's all the hardware does.

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
---584328900-1158030984-1123446853=:31010--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
