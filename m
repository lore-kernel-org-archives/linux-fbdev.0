From: krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org
Subject: =?UTF-8?q?Re:_Re:_[PATCH]_tdfxfb:_move_I2C_functionality_into_the_tdfxfb?=
Date: 23 Mar 2009 12:01:33 +0100
Message-ID: <20090323110133.7CB7186118D@f35.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>, Linux-fbdev-devel <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jean Delvare napisa=B3(a):
> Hi Krzysztof,
>=20
> On Sat, 21 Mar 2009 20:29:54 +0100, Krzysztof Helt wrote:
> > From: Krzysztof Helt >krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> >=20
> > The I2C functionality provided by the
> > i2c-voodoo3 driver is moved into the
> > tdfxfb (frame buffer driver for Voodoo3
> > cards). This way there is no conflict
> > between i2c driver and the fb driver.
> >=20
> > The tdfxfb does not make use from the
> > DDC functionality yet. It just provides=20
> > two I2C buses like the i2c-voodoo3 driver
> > (DDC and I2C).
>=20
> This change has my full support. In fact it was on my to-do list for
> this year, so I am very happy to see someone else beat me at it :)
>=20
> (BTW: can you please trim lines at ~70 characters rather than 42? Too
> frequent new lines make the text harder to read IMHO.)
>=20

I will make lines longer

> >=20
> > Signed-off-by: Krzysztof Helt >krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> > ---
> >=20
> > This open way to remove the i2c-voodoo3 driver.
> >=20
> >=20
> >  drivers/video/Kconfig  |    9 ++
> >  drivers/video/tdfxfb.c |  191
> +++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/video/tdfx.h   |   24 ++++++
> >  3 files changed, 223 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 6ff3364..837479b 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -1550,6 +1550,7 @@ config FB_3DFX
> >  	select FB_CFB_IMAGEBLIT
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> > +	select FB_MODE_HELPERS
> >  	help
> >  	  This driver supports graphics boards with the 3Dfx Banshee,
> >  	  Voodoo3 or VSA-100 (aka Voodoo4/5) chips. Say Y if you have
> > @@ -1565,6 +1566,14 @@ config FB_3DFX_ACCEL
> >  	This will compile the 3Dfx Banshee/Voodoo3/VSA-100 frame buffer
> >  	device driver with acceleration functions.
> > =20
> > +config FB_3DFX_I2C
> > +	bool "DDC/I2C for 3dfx Voodoo3 support"
>=20
> I see that some other drivers have a similarly unfortunate wording, b=
ut
> I&#039;d prefer something clearer and less redundant such as "Enable =
DDC/I2C
> Support" (as the nvidiafb, rivafb and i810fb drivers do.)
>=20

Ok. The word "Enable" is a good hint. I'll change this.

> > +	depends on FB_3DFX >> EXPERIMENTAL
> > +	select FB_DDC
> > +	default y
> > +	help
> > +	  Say Y here if you want DDC/I2C support for your 3dfx Voodoo3.
>=20
> It might be worth adding a note that the driver itself doesn&#039;t y=
et take
> benefit of the DDC channel.
>=20

IHMO, it does not matter. A separate patch which make use of it is alre=
ady
ready to post. If this patch is accepted, the second one will be posted=
=2E It=20
is not worth to add a comment then remove it in the next patch.

> > +
> >  config FB_VOODOO1
> >  	tristate "3Dfx Voodoo Graphics (sst1) support"
> >  	depends on FB >> PCI
> > diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> > index 14bd3f3..c4152a5 100644
> > --- a/drivers/video/tdfxfb.c
> > +++ b/drivers/video/tdfxfb.c
> > @@ -1167,6 +1167,190 @@ static struct fb_ops tdfxfb_ops =3D {
> >  #endif
> >  };
> > =20
> > +#ifdef CONFIG_FB_3DFX_I2C
> > +/* The voo GPIO registers don&#039;t have individual masks for eac=
h bit
> > +   so we always have to read before writing. */
>=20
> As far as I can see, some of the code and comments is taken directly
> from the i2c-voodoo3 driver, so it would seem fair to acknowledge the
> work of its author (Philip Edelbrock >phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>) in the
> header comment of the file.
>=20

Ok

(...)
> > +static int __devinit tdfxfb_setup_ddc_bus(struct tdfxfb_i2c_chan
> *chan,
> > +					  const char *name, struct device *dev)
> > +{
> > +	int rc;
> > +
> > +	strcpy(chan->adapter.name, name);
>=20
> Please use strlcpy() instead.
>=20
> > +	chan->adapter.owner		=3D THIS_MODULE;
> > +	chan->adapter.class		=3D I2C_CLASS_DDC;
>=20
> You must include >linux/i2c.h> to use this. I know it is indirectly
> included but relying on indirect includes is a bad practice.
>=20

It is included by the tdfx.h which is vital to the tdfxfb.c.

> > +static void __devinit tdfxfb_create_i2c_busses(struct fb_info *inf=
o)
> > +{
> > +	struct tdfx_par *par =3D info->par;
> > +
> > +	tdfx_outl(par, VIDINFORMAT, 0x8160);
> > +	tdfx_outl(par, VIDSERPARPORT, 0xcffc0020);
> > +
> > +	par->chan[0].par =3D par;
> > +	par->chan[1].par =3D par;
> > +
> > +	tdfxfb_setup_ddc_bus(>par->chan[0], "VOODOO3-DDC", info->dev);
> > +	tdfxfb_setup_i2c_bus(>par->chan[1], "VOODOO3-I2C", info->dev);
>=20
> Why all-caps names? What about "Voodoo3 DDC" and "Voodoo3 I2C" instea=
d?
>=20

Just a choice. One other driver does it this way. I'll change to
the proposed names.

> > @@ -1284,7 +1468,9 @@ static int __devinit tdfxfb_probe(struct pci_=
dev
> *pdev,
> >  	if (hwcursor)
> >  		info->fix.smem_len =3D (info->fix.smem_len - 1024) >
> >  					(PAGE_MASK >> 1);
> > -
> > +#ifdef CONFIG_FB_3DFX_I2C
> > +	tdfxfb_create_i2c_busses(info);
> > +#endif
> >  	if (!mode_option)
> >  		mode_option =3D "640x480@60";
> > =20
>=20
> Later in this function, errors can occur which cause an error path to
> be taken. There you should call tdfxfb_delete_i2c_busses(par) otherwi=
se
> you&#039;re leaking resources.
>=20

ok.

> > diff --git a/include/video/tdfx.h b/include/video/tdfx.h
> > index 7431d96..bc37022 100644
> > --- a/include/video/tdfx.h
> > +++ b/include/video/tdfx.h
> > @@ -168,12 +183,21 @@ struct banshee_reg {
> >  	unsigned long miscinit0;
> >  };
> > =20
> > +struct tdfx_par;
> > +
> > +struct tdfxfb_i2c_chan {
> > +	struct tdfx_par *par;
> > +	struct i2c_adapter adapter;
> > +	struct i2c_algo_bit_data algo;
> > +};
> > +
> >  struct tdfx_par {
> >  	u32 max_pixclock;
> >  	u32 palette[16];
> >  	void __iomem *regbase_virt;
> >  	unsigned long iobase;
> >  	int mtrr_handle;
> > +	struct tdfxfb_i2c_chan chan[2];
>=20
> ... and this struct member if CONFIG_FB_3DFX_I2C is defined (same as
> intelfb and radeonfb are doing for example.)
>=20

ok.

>=20
> Other than these details, it looks OK to me. Please send an updated
> version addressing my comments and I&#039;ll be happy to ack it. I&#0=
39;ve also
> tested the new code on my Voodoo3 and it worked just fine.
>=20
> Was your code tested on a Voodoo5? The i2c-voodoo3 driver didn&#039;t=
 claim
> to support it, so I wonder if it is compatible DDC/I2C-wise.
>=20

It works on Voodoo5 at least.

> Next step is to deprecate i2c-voodoo3. This requires changes to
> drivers/i2c/busses/Kconfig and
> Documentation/feature-removal-schedule.txt. Are you going to do it or
> should I?
>=20

I don't care. First, this patch must be accepted.=20

Thank you,
Krzysztof

----------------------------------------------------------------------
Szukasz pieniedzy? Wez podwojny limit zadluzenia w koncie direct.
>> http://link.interia.pl/f20a3
