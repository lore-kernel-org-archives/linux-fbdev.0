From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Date: Wed, 20 Aug 2014 08:27:11 +0000
Subject: Re: [PATCH] video: ARM CLCD: Ensure bits-per-pixel is a power of 2 and <= 32
Message-Id: <1408523231.3858.5.camel@linaro1.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1408453651.3746.41.camel@linaro1.home>
 <20140819144032.GD30401@n2100.arm.linux.org.uk>
In-Reply-To: <20140819144032.GD30401@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2014-08-19 at 15:40 +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 19, 2014 at 02:07:31PM +0100, Jon Medhurst (Tixy) wrote:
> > If the device-tree specifies a max-memory-bandwidth property then
> > the CLCD driver uses that to calculate the bits-per-pixel supported,
> > however, it doesn't ensure that the result is a sane value, i.e. a
> > power of 2 and <=3D 32 as the rest of the code assumes.
> >=20
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >=20
> > This fixes code which is new in 3.17 (commit d10715be03) and so I assume
> > is a candidate for adding to a coming -rc ? Without the fix, people can
> > be left (as I was) with a blank non-functioning screen even if they
> > create a valid device-tree for the new driver functionality.
> >=20
> >  drivers/video/fbdev/amba-clcd.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> > index beadd3e..98b66b7 100644
> > --- a/drivers/video/fbdev/amba-clcd.c
> > +++ b/drivers/video/fbdev/amba-clcd.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/list.h>
> >  #include <linux/amba/bus.h>
> >  #include <linux/amba/clcd.h>
> > +#include <linux/bitops.h>
> >  #include <linux/clk.h>
> >  #include <linux/hardirq.h>
> >  #include <linux/dma-mapping.h>
> > @@ -650,6 +651,7 @@ static int clcdfb_of_init_display(struct clcd_fb *f=
b)
> >  {
> >  	struct device_node *endpoint;
> >  	int err;
> > +	int bpp;
> >  	u32 max_bandwidth;
> >  	u32 tft_r0b0g0[3];
> > =20
> > @@ -667,11 +669,15 @@ static int clcdfb_of_init_display(struct clcd_fb =
*fb)
> > =20
> >  	err =3D of_property_read_u32(fb->dev->dev.of_node, "max-memory-bandwi=
dth",
> >  			&max_bandwidth);
> > -	if (!err)
> > -		fb->panel->bpp =3D 8 * max_bandwidth / (fb->panel->mode.xres *
> > +	if (!err) {
> > +		bpp =3D 8 * max_bandwidth / (fb->panel->mode.xres *
> >  				fb->panel->mode.yres * fb->panel->mode.refresh);
>=20
> This calculation is wrong in any case - this is the na=C3=AFeve calculati=
on
> which assumes that the bandwidth is:
>=20
> 	x * y * (bpp / 8) * refresh
>=20
> That isn't the maximum bandwidth, it's the average bandwidth across a
> full frame.
>=20
> If we're interested in limiting the maximum bandwidth, because the
> hardware can't cope with fetching the data above a certain rate, then
> we need a different method.
>=20
> We know the pixel rate.  We know how many memory bits are fetched for
> each pixel.  So:
>=20
> 	peak_bandwidth =3D pixel_clock * bpp / 8

That all sounds logical and reasonable to me, especially as the binding
doc describes the property as "maximum bandwidth in bytes per second
that the cell's memory interface can handle".

I'll update the patch to also correct the calculation as you suggest.

--=20
Tixy

