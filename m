From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Nov 2013 18:59:59 +0000
Subject: Re: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <20131118185959.GE19318@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
In-Reply-To: <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Geert,

On Mon, Nov 18, 2013 at 12:59:40PM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 18, 2013 at 11:57 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > This patch makes mmapping the simple-framebuffer device work on a no-MMU
> > ARM target. The code is mostly taken from
> > arch/blackfin/kernel/sys_bfin.c.
> >
> > Note this is only tested on this no-MMU machine and I don't know enough
> > about framebuffers and mm to decide if this patch is sane. Also I'm
> > unsure about the size check because it triggers if userspace page aligns
> > the len parameter. (I don't know how usual it is to do, I'd say it's
> > wrong, but my test program (fbtest by Geert Uytterhoeven) does it.)
>=20
> It's quite common: the granularity of mmap() is PAGE_SIZE, i.e. if you
> try to map a partial page, you'll get access to the full page anyway
> (with MMU; without MMU, you can access everything anyway).
> Fbtest always mmap()s the full (page aligned) smem_len.
>=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/video/fbmem.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> > index dacaf74..70b328c 100644
> > --- a/drivers/video/fbmem.c
> > +++ b/drivers/video/fbmem.c
> > @@ -1483,6 +1483,24 @@ __releases(&info->lock)
> >         return 0;
> >  }
> >
> > +#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
> > +#define fb_get_unmapped_area get_fb_unmapped_area
> > +#else
> > +unsigned long fb_get_unmapped_area(struct file *filp, unsigned long or=
ig_addr,
> > +               unsigned long len, unsigned long pgoff, unsigned long f=
lags)
> > +{
> > +       struct fb_info * const info =3D filp->private_data;
> > +       unsigned long screen_size =3D info->screen_size ?: info->fix.sm=
em_len;
>=20
> Why restrict this to screen_size? Fbtest will map the whole frame buffer =
memory.
For me screen_size is zero. The logic to determine the size is copied
from fb_read. In the meantine I'm using

	if (len > PAGE_ALIGN(screen_size))

because even if userspace passes an unaligned size it gets aligned
somewhere on the path to fb_get_unmapped_area.

> Typically screen_size is not a multiple of PAGE_SIZE, so this is another
> reason why your size check fails.
>=20
> > +       if (len > screen_size) {
> > +               pr_info("%lu > %lu (%lu, %lu)\n", len, screen_size, inf=
o->screen_size, info->fix.smem_len);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return (unsigned long)info->screen_base;
>=20
> Shouldn't you take into account pgoff?
Sounds sensible. Then the same applies to blackfin's
get_fb_unmapped_area.

So is it:

	unsigned long screen_size =3D info->screen_size ?: info->fix.smem_len;

	screen_size =3D PAGE_ALIGN(screen_size);

	if (pgoff > screen_size || pgoff + len > screen_size)
		return -EINVAL;

	return (unsigned long)info->screen_base + pgoff;

? Or should I drop the size check?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
