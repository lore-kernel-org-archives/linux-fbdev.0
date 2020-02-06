From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 06 Feb 2020 23:00:41 +0000
Subject: Re: [PATCH 1/3] fbdev/g364fb: Fix build failure
Message-Id: <CAAdtpL5Cz5YGKZVfbA=X8qMtP7jDc0G7igSj3EB=PfazM5JoDg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1580610812.git.fthain@telegraphics.com.au>
 <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
 <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
 <alpine.LNX.2.22.394.2002060829410.8@nippy.intranet>
In-Reply-To: <alpine.LNX.2.22.394.2002060829410.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, open list <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Bogendoerfer <tbogendoerfer@suse.de>, dri-devel@lists.freedesktop.org, Laurent Vivier <laurent@vivier.eu>

On Wed, Feb 5, 2020 at 11:18 PM Finn Thain <fthain@telegraphics.com.au> wro=
te:
> On Wed, 5 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> > On Sun, Feb 2, 2020 at 3:41 AM Finn Thain <fthain@telegraphics.com.au> =
wrote:
> > >
> > > This patch resolves these compiler errors and warnings --
> > >
> > >   CC      drivers/video/fbdev/g364fb.o
> > > drivers/video/fbdev/g364fb.c: In function 'g364fb_cursor':
> > > drivers/video/fbdev/g364fb.c:137:9: error: 'x' undeclared (first use =
in this function)
> > > drivers/video/fbdev/g364fb.c:137:9: note: each undeclared identifier =
is reported only once for each function it appears in
> > > drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of fu=
nction 'fontwidth' [-Werror=3Dimplicit-function-declaration]
> > > drivers/video/fbdev/g364fb.c:137:23: error: 'p' undeclared (first use=
 in this function)
> > > drivers/video/fbdev/g364fb.c:137:38: error: 'y' undeclared (first use=
 in this function)
> > > drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of fu=
nction 'fontheight' [-Werror=3Dimplicit-function-declaration]
> > > drivers/video/fbdev/g364fb.c: In function 'g364fb_init':
> > > drivers/video/fbdev/g364fb.c:233:24: error: 'fbvar' undeclared (first=
 use in this function)
> > > drivers/video/fbdev/g364fb.c:234:24: error: 'xres' undeclared (first =
use in this function)
> >
> > 18 years unnoticed...
> >
>
> More likely, it was noticed by those without the skills or time to get it
> fixed upstream.
>
> Those with the hardware skills and platform knowledge to be affected by an
> obscure bug aren't necessarily also capable of fixing a kernel bug,
> sending a patch upstream and getting it past code review.
>
> Getting a patch into the Linux kernel is itself a lot of work, unless
> you've had years of experience with that constantly changing process
> (which varies significantly between subsystems).

I see, I'm not custom to kernel workflow.

> Kernel developers are only human and do accidentally introduce breakage in
> their work (as contributors) while ironically (as reviewers) they raise
> the bar for random fixes from users not versed in the 10000+ lines of
> Documentation/process/*.rst
>
> Broken code does not mean zero potential users or zero frustrated users
> yet I often hear kernel developers disingenuously claim that it does.
> They have an incentive to make that claim and often there's no-one reading
> the mailing lists to push back.

But broken code is also bad example of code. The removed code is still
buried in the git tree.

> > > drivers/video/fbdev/g364fb.c:201:14: warning: unused variable 'j' [-W=
unused-variable]
> > > drivers/video/fbdev/g364fb.c:197:25: warning: unused variable 'pal_pt=
r' [-Wunused-variable]
> > >
> > > The MIPS Magnum framebuffer console now works when tested in QEMU.
> > >
> > > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >
> > This commit is the kernel 'git origin' import, not the proper reference.
> >
> > The actual change is between v2.5.17/2.5.19:
> > https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/diff/d=
rivers/video/g364fb.c?id=B30e6e183a728923267
> > Date: 2002-05-22 07:52:33...
> >
>
> I think the driver was broken before that point. I didn't compile it, but
> it seems that "xres" still has no declaration.
>
> BTW, is it wise to cite a sha-1 that doesn't exist in mainline?

I didn't want to suggest referencing an external sha1, but rather the full =
link.
Anyway I later figured out your reference isn't incorrect, this code
was really added in commit 1da177e4c3f4.

Maybe you can use:
Fixes: 1da177e4c3f4 (code modified earlier during v2.5.17-v2.5.19)

Anyway I'm bike-shedding, whichever reference you choose will be fine, even
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

>
> $ git show b30e6e183a728923267
> fatal: ambiguous argument 'b30e6e183a728923267': unknown revision or path
> not in the working tree.
>
> I'd prefer to use a tag like this,
> References: https://git.kernel.org/tglx/history/c/b30e6e183a728923267
>
> FWIW, if you search for "tglx.history" in git log, you can find other
> stuff, like "Histroy Tree:" [sic] and "History-tree:". I don't know what
> the canonical form is.
>
> > The same commit introduced the changes in g364fb_cursor(), which was
> > implemented previous to v2.4.0 so it is hard to follow from there.
> >
> > Nobody complains during 18 years so I doubt anyone care that
> > g364fb_cursor() is removed.
>
> Right. The .fb_cursor method is optional (not all framebuffers have a
> hardware cursor).
>
> > And by removing it, you improve the kernel quality, so:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > (Maybe remove the unhelpful 'Fixes' tag).
> >
>
> In the past I've seen other reviewers of other patches say the same thing
> ("Please remove Fixes: Linux 2.6.12-rc2"). I don't know why.
>
> I used that tag because it indicates that the patch can be backported at
> least as far as the stated commit. Certainly the bug exists in Linux
> 2.6.12-rc2, so the "Fixes" tag is meaningful in that sense.

Yes, agreed.

>
> > > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> > > ---
> > >  drivers/video/fbdev/g364fb.c | 29 +++--------------------------
> > >  1 file changed, 3 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/g364fb.c b/drivers/video/fbdev/g364f=
b.c
> > > index 223896cc5f7d..fb26230a3c7b 100644
> > > --- a/drivers/video/fbdev/g364fb.c
> > > +++ b/drivers/video/fbdev/g364fb.c
> > > @@ -108,7 +108,6 @@ static int g364fb_pan_display(struct fb_var_scree=
ninfo *var,
> > >  static int g364fb_setcolreg(u_int regno, u_int red, u_int green,
> > >                             u_int blue, u_int transp,
> > >                             struct fb_info *info);
> > > -static int g364fb_cursor(struct fb_info *info, struct fb_cursor *cur=
sor);
> > >  static int g364fb_blank(int blank, struct fb_info *info);
> > >
> > >  static struct fb_ops g364fb_ops =3D {
> > > @@ -119,28 +118,8 @@ static struct fb_ops g364fb_ops =3D {
> > >         .fb_fillrect    =3D cfb_fillrect,
> > >         .fb_copyarea    =3D cfb_copyarea,
> > >         .fb_imageblit   =3D cfb_imageblit,
> > > -       .fb_cursor      =3D g364fb_cursor,
> > >  };
> > >
> > > -int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
> > > -{
> > > -
> > > -       switch (cursor->enable) {
> > > -       case CM_ERASE:
> > > -               *(unsigned int *) CTLA_REG |=3D CURS_TOGGLE;
> > > -               break;
> > > -
> > > -       case CM_MOVE:
> > > -       case CM_DRAW:
> > > -               *(unsigned int *) CTLA_REG &=3D ~CURS_TOGGLE;
> > > -               *(unsigned int *) CURS_POS_REG > > > -               =
    ((x * fontwidth(p)) << 12) | ((y * fontheight(p)) -
> > > -                                                 info->var.yoffset);
> > > -               break;
> > > -       }
> > > -       return 0;
> > > -}
> > > -
> > >  /*
> > >   *  Pan or Wrap the Display
> > >   *
> > > @@ -194,11 +173,9 @@ static int g364fb_setcolreg(u_int regno, u_int r=
ed, u_int green,
> > >   */
> > >  int __init g364fb_init(void)
> > >  {
> > > -       volatile unsigned int *pal_ptr > > > -           (volatile un=
signed int *) CLR_PAL_REG;
> > >         volatile unsigned int *curs_pal_ptr > > >             (volati=
le unsigned int *) CURS_PAL_REG;
> > > -       int mem, i, j;
> > > +       int mem, i;
> > >
> > >         if (fb_get_options("g364fb", NULL))
> > >                 return -ENODEV;
> > > @@ -230,8 +207,8 @@ int __init g364fb_init(void)
> > >          */
> > >         *(unsigned short *) (CURS_PAT_REG + 14 * 64) =3D 0xffff;
> > >         *(unsigned short *) (CURS_PAT_REG + 15 * 64) =3D 0xffff;
> > > -       fb_var.xres_virtual =3D fbvar.xres;
> > > -       fb_fix.line_length =3D (xres / 8) * fb_var.bits_per_pixel;
> > > +       fb_var.xres_virtual =3D fb_var.xres;
> > > +       fb_fix.line_length =3D fb_var.xres_virtual * fb_var.bits_per_=
pixel / 8;
> > >         fb_fix.smem_start =3D 0x40000000; /* physical address */
> > >         /* get size of video memory; this is special for the JAZZ har=
dware */
> > >         mem =3D (r4030_read_reg32(JAZZ_R4030_CONFIG) >> 8) & 3;
> > > --
> > > 2.24.1
> > >
> >
