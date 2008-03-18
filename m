From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
Subject: Re: [PATCH] i810fb: Fix console switch
	regression
Date: Tue, 18 Mar 2008 08:09:09 +0100
Message-ID: <200803180809.10020.stefan.bauer@cs.tu-chemnitz.de>
References: <200803161942.24555.stefan.bauer@cs.tu-chemnitz.de>
	<200803171641.10750.stefan.bauer@cs.tu-chemnitz.de>
	<20080317204812.2c3e3754.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JbVxA-0008Nc-4i for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 00:09:44 -0700
Received: from john.hrz.tu-chemnitz.de ([134.109.132.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JbVx8-0007dO-3w
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 18 Mar 2008 00:09:43 -0700
In-Reply-To: <20080317204812.2c3e3754.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel Development <linux-kernel@vger.kernel.org>

Am Dienstag, 18. M=E4rz 2008 04:48 schrieb Andrew Morton:
> On Mon, 17 Mar 2008 16:41:10 +0100 Stefan Bauer =

<stefan.bauer@cs.tu-chemnitz.de> wrote:
> > From: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> >
> > Since 4c7ffe0b9f7f40bd818fe3af51342f64c483908e ("fbdev: prevent drivers
> > that have hardware cursors from calling software cursor code") every ca=
ll
> > of i810fb_cursor fails with -ENXIO because of a incorrect "!".
> >
> > This hasn't striked until eaa0ff15c30dc9799eb4d12660edb73aeb6d32c5 ("fix
> > ! versus & precedence in various places") surrounded the expression with
> > braces, so that the intended behavior was inverted. That caused 'pixel
> > waste' - the same line of multi-colored pixels repeated over the whole
> > screen - during console switch.
> >
> > This switches back to the original pre-4c7ffe0 behavior.
> >
> > Signed-off-by: Stefan Bauer <stefan.bauer@cs.tu-chemnitz.de>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Antonino Daplas <adaplas@pol.net>
> >
> > --- linux-2.6/drivers/video/i810/i810_main.c.orig
> > +++ linux-2.6/drivers/video/i810/i810_main.c
> > @@ -1476,7 +1476,7 @@ static int i810fb_cursor(struct fb_info
> >  	struct i810fb_par *par =3D info->par;
> >  	u8 __iomem *mmio =3D par->mmio_start_virtual;
> >
> > -	if (!(par->dev_flags & LOCKUP))
> > +	if (par->dev_flags & LOCKUP)
> >  		return -ENXIO;
> >
> >  	if (cursor->image.width > 64 || cursor->image.height > 64)
>
> Can you please confirm that this actually fixes the bug?  That wasn't
> clear.
>
> Thanks.

Yes, yesterday I worked the whole day with that machine running -rc6 + my =

patch. The regression definitely is fixed, fbi and fbset work w/o problems =
or =

new regressions.

	Regards
		Stefan

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
