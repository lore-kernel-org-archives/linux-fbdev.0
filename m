From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Portrait display mode
Date: Wed, 11 Sep 2002 08:38:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0209110837090.27524-100000@vervain.sonytel.be>
References: <1031696622.548.13.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17p18o-000218-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Sep 2002 23:38:22 -0700
In-Reply-To: <1031696622.548.13.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Antonino Daplas <adaplas@pol.net>
Cc: otto.wyss@bluewin.ch, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On 11 Sep 2002, Antonino Daplas wrote:
> On Wed, 2002-09-11 at 04:44, Otto Wyss wrote:
> > I guess the framebuffer drivers so far don't support turning the disp=
lay 90=B0 as
> > the Pivot software does for Windows/MacOS. Since I'm considering buyi=
ng a
> I posted a patch under the thread titled "Console Rotation" 2 days ago.=
=20
> It should support rotation in 3 additional directions (90, 180 and 270
> degrees).  As far as fb-based apps, they have to do the rotation on
> their own.  XFbdev in 4.2.0 already does that.
>=20
> > turnable display I rather see this feature implemented. I even may he=
lp but can
> > spend much time. How difficult would it be?
> >=20
> It should not be too difficult to add per-driver support once the

Can't this be moved up to generic code, so we don't have to modify all dr=
ivers?

> rotation wrappers are implemented.  The main requirement is that the
> driver must support the drawing primitives (xxxfillrect, xxxcopyarea,
> xxximageblit -- main reason I like the primitives is because you can do
> a lot of fancy things with minimal code change).  I already did this
> with VESA fb, and it required less than 100 lines of code.

Since in the end all drivers will, this is not a real issue.

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



-------------------------------------------------------
In remembrance
www.osdn.com/911/
