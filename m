From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 11 Sep 2013 16:02:22 +0000
Subject: Re: [PATCH v2 1/2] video: ARM CLCD: Add DT support
Message-Id: <1378915342.4082.140.camel@hornet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1378808726-32535-1-git-send-email-pawel.moll@arm.com>
 <20130910194324.GE12758@n2100.arm.linux.org.uk>
In-Reply-To: <20130910194324.GE12758@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tue, 2013-09-10 at 20:43 +0100, Russell King - ARM Linux wrote:
> On Tue, Sep 10, 2013 at 11:25:25AM +0100, Pawel Moll wrote:
> > +#ifdef CONFIG_OF
> > +static int clcdfb_of_get_tft_panel(struct device_node *node,
> > +		struct clcd_panel *panel)
> > +{
> > +	int err;
> > +	u32 rgb[3];
> > +
> > +	err =3D of_property_read_u32_array(node, "panel-tft-interface", rgb, =
3);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Bypass pixel clock divider, data output on the falling edge */
> > +	panel->tim2 =3D TIM2_BCD | TIM2_IPC;
> > +
> > +	/* TFT display, vert. comp. interrupt at the start of the back porch =
*/
> > +	panel->cntl |=3D CNTL_LCDTFT | CNTL_LCDVCOMP(1);
> > +
> > +	if (rgb[0] >=3D 4 && rgb[1] >=3D 4 && rgb[2] >=3D 4)
> > +		panel->caps |=3D CLCD_CAP_444;
> > +	if (rgb[0] >=3D 5 && rgb[1] >=3D 5 && rgb[2] >=3D 5)
> > +		panel->caps |=3D CLCD_CAP_5551;
> > +	if (rgb[0] >=3D 5 && rgb[1] >=3D 6 && rgb[2] >=3D 5)
> > +		panel->caps |=3D CLCD_CAP_565;
> > +	if (rgb[0] >=3D 8 && rgb[1] >=3D 8 && rgb[2] >=3D 8)
> > +		panel->caps |=3D CLCD_CAP_888;
>=20
> This definitely isn't right.  Why does a panel which has 8 bits of RGB
> get to indicate that it supports everything below it?
>=20
> This is not how this hardware works.  Look at table A-7 in the TRM.
> If you wire the CLCD controller directly to a panel which is 8-bit RGB
> only, it can't support any of the other formats.
>=20
> The CLCD controller itself can only support on the hardware 8-bits of
> RGB or 5 bits of RGB plus an intensity bit, so that's two formats.

I must admit I didn't checked the PL110 CLD multiplexing scheme, naively
expecting it to be the same as PL111. My bad, thanks for pointing this
out.

The code above works for PL111 - the signals are laid so with full 888
wiring and 444 mode the bottom bits are reserved (see table A.10). In
reality they're zeros, so the colour space is narrowed.

Seems that the code will have to behave differently for PL110 and PL111
here.

> However, things are complicated by ARMs addition of an external mux
> on the CLCD output, which gives us the other format possibilities
> by munging the signals to give appropriate formats in the framebuffer
> memory.  In other words, in RGB444 mode, the mux ends up taking
> red from CLD[4:1], green from CLD[9:7,5], blue from CLD[14:13,11:10].

It's the Versatile AB/PB hacked CLCD, PL110/111 hybrid, right? It
doesn't really fall into the "arm,pl110" and "arm,pl111" compatible
value, so would need to be something like "arm,versatile,clcdc" and
require custom code. I don't think I want to solve this problem right
now.

> This is one of the dangers of directly converting what's in the kernel
> to DT properties without getting the hardware documentation and fully
> understanding that first - remember, DT properties are supposed to be
> based on the hardware, not the Linux implementation.

I don't think I've directly converted what's in the kernel to DT
properties. There is no "caps" property in the binding. There is only
information how is the cell wired up to a panel, and this information is
valid for both PL110 and PL111 as it is. My fault I've believed when was
told that "the two are basically the same." and should have compared the
TRMs in details.

Will fix the code.

Pawe=C5=82


