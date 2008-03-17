From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: Re: [PATCH] i810fb: Fix console switch
	regression
Date: Mon, 17 Mar 2008 09:20:32 +0100
Message-ID: <200803170920.33626.stefan.bauer@cs.tu-chemnitz.de>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
	<Pine.LNX.4.64.0803162042460.7207@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbAaZ-00047e-Lv for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 01:20:59 -0700
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbAaX-0008W5-Vq
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 17 Mar 2008 01:20:59 -0700
In-Reply-To: <Pine.LNX.4.64.0803162042460.7207@anakin>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@pol.net>

Am Sonntag, 16. M=E4rz 2008 20:48 schrieb Geert Uytterhoeven:
> On Sun, 16 Mar 2008, Stefan Bauer wrote:
> > --- linux-2.6/drivers/video/i810/i810_main.c.orig
> > +++ linux-2.6/drivers/video/i810/i810_main.c
> > @@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info
> > 	struct i810fb_par *par =3D info->par;
> > 	u8 __iomem *mmio =3D par->mmio_start_virtual;
> >
> > -	if (!(par->dev_flags & LOCKUP))
> > +	if (!par->dev_flags & LOCKUP)
> > 		return -ENXIO;
>
> However, the original expression didn't make sense, as LOCKUP is 8 and
> !par->dev_flags is either 0 or 1, so `!par->dev_flags & LOCKUP' is
> always 0.
>
> I took a quick look at the usage of the LOCKUP flag. Apparently when a
> lock-up is detected, this flag is set, and the driver will fall back to
> software operations instead of hardware accelerated operations.
>
> Is it possible the intended code was
>
> 	if (par->dev_flags & LOCKUP)
> 		return -ENXIO;
>
> ?

Yes, IMO you are right. 4c7ffe0 ("fbdev: prevent drivers that have hardware =

cursors from calling software cursor code") introduced the senseless code.

I'm going on testing today, but I think that's it.

Again, please CC me, thanks.

---
From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>

Since 4c7ffe0b9f7f40bd818fe3af51342f64c483908e ("fbdev: prevent drivers tha=
t =

have hardware cursors from calling software cursor code") every call of =

i810fb_cursor fails with -ENXIO because of a incorrect "!".

This hasn't striked until eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix ! =

versus & precedence in various places") surrounded the expression with =

braces, so that the intended behavior was inverted. That caused 'pixel =

waste' - the same line of multi-colored pixels repeated over the whole =

screen - during console switch.

This switches back to the original pre-4c7ffe0 behavior.

Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Antonino Daplas <adaplas@pol.net>

---
--- linux-2.6/drivers/video/i810/i810_main.c.orig
+++ linux-2.6/drivers/video/i810/i810_main.c
@@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info
        struct i810fb_par *par =3D info->par;
        u8 __iomem *mmio =3D par->mmio_start_virtual;

-       if (!(par->dev_flags & LOCKUP))
+       if (par->dev_flags & LOCKUP)
                return -ENXIO;

        if (cursor->image.width > 64 || cursor->image.height > 64)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
