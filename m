From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 08:53:43 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017085342.GB2502@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1381947912-11741-3-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
In-Reply-To: <1695169.rzbDl9PeRX@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adding the dri-devel mailing list on Cc, since this discussion is
outgrowing its original intent.

On Thu, Oct 17, 2013 at 02:47:52AM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> Thank you for the patch.
>=20
> On Wednesday 16 October 2013 20:25:12 Thierry Reding wrote:
> > Add a driver for simple panels. Such panels can have a regulator that
> > provides the supply voltage and a separate GPIO to enable the panel.
> > Optionally the panels can have a backlight associated with them so it
> > can be enabled or disabled according to the panel's power management
> > mode.
> >=20
> > Support is added for three panels: An AU Optronics 10.1" WSVGA, a
> > Chunghwa Picture Tubes 10.1" WXGA and a Panasonic 10.1 WUXGA TFT LCD
> > panel.
> >=20
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  .../devicetree/bindings/panel/auo,b101aw03.txt     |   7 +
> >  .../bindings/panel/chunghwa,claa101wb03.txt        |   7 +
> >  .../bindings/panel/panasonic,vvx10f004b00.txt      |   7 +
> >  .../devicetree/bindings/panel/simple-panel.txt     |  21 ++
> >  drivers/gpu/drm/Makefile                           |   1 +
> >  drivers/gpu/drm/panel/Kconfig                      |  13 +
> >  drivers/gpu/drm/panel/Makefile                     |   1 +
> >  drivers/gpu/drm/panel/panel-simple.c               | 335 +++++++++++++=
+++++
> >  8 files changed, 392 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/panel/auo,b101aw0=
3.txt
> > create mode 100644
> > Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt create
> > mode 100644
> > Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt crea=
te
> > mode 100644 Documentation/devicetree/bindings/panel/simple-panel.txt cr=
eate
> > mode 100644 drivers/gpu/drm/panel/Makefile
> >  create mode 100644 drivers/gpu/drm/panel/panel-simple.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/panel/auo,b101aw03.txt
> > b/Documentation/devicetree/bindings/panel/auo,b101aw03.txt new file mode
> > 100644
> > index 0000000..72e088a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/panel/auo,b101aw03.txt
> > @@ -0,0 +1,7 @@
> > +AU Optronics Corporation 10.1" WSVGA TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "auo,b101aw03"
> > +
> > +This binding is compatible with the simple-panel binding, which is
> > specified +in simple-panel.txt in this directory.
> > diff --git
> > a/Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt
> > b/Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt new =
file
> > mode 100644
> > index 0000000..0ab2c05
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt
> > @@ -0,0 +1,7 @@
> > +Chunghwa Picture Tubes Ltd. 10.1" WXGA TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "chunghwa,claa101wb03"
> > +
> > +This binding is compatible with the simple-panel binding, which is
> > specified +in simple-panel.txt in this directory.
> > diff --git
> > a/Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt
> > b/Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt new
> > file mode 100644
> > index 0000000..d328b03
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt
> > @@ -0,0 +1,7 @@
> > +Panasonic Corporation 10.1" WUXGA TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "panasonic,vvx10f004b00"
> > +
> > +This binding is compatible with the simple-panel binding, which is
> > specified +in simple-panel.txt in this directory.
> > diff --git a/Documentation/devicetree/bindings/panel/simple-panel.txt
> > b/Documentation/devicetree/bindings/panel/simple-panel.txt new file mode
> > 100644
> > index 0000000..1341bbf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/panel/simple-panel.txt
> > @@ -0,0 +1,21 @@
> > +Simple display panel
> > +
> > +Required properties:
> > +- power-supply: regulator to provide the supply voltage
> > +
> > +Optional properties:
> > +- ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
> > +- enable-gpios: GPIO pin to enable or disable the panel
> > +- backlight: phandle of the backlight device attached to the panel
> > +
> > +Example:
> > +
> > +	panel: panel {
> > +		compatible =3D "cptt,claa101wb01";
> > +		ddc-i2c-bus =3D <&panelddc>;
> > +
> > +		power-supply =3D <&vdd_pnl_reg>;
> > +		enable-gpios =3D <&gpio 90 0>;
> > +
> > +		backlight =3D <&backlight>;
> > +	};
>=20
> My biggest concern here is that this will not be compatible with the CDF =
DT=20
> bindings. They're not complete yet, but they will require connections bet=
ween=20
> entities to be described in DT, in a way very similar (or actually identi=
cal)=20
> to the V4L2 DT bindings, documented in=20
> Documentation/devicetree/bindings/media/video-interfaces.txt. Could you h=
ave a=20
> look at that ? Please ignore all optional properties beside remote-endpoi=
nt,=20
> as they're V4L2 specific.

Okay, so if I understand correctly, translating those bindings to panel
nodes would look somewhat like this:

	dc: display-controller {
		ports {
			port@0 {
				remote-endpoint =3D <&panel>;
			};
		};
	};

	panel: panel {
		ports {
			port@0 {
				remote-endpoint =3D <&dc>;
			};
		};
	};

The above leaves out any of the other, non-relevant properties. Does
that sound about right? That seems like an overly complex amount of data
to describe just a simple panel where the only connection between it and
the display hardware is the data bus and I was sort of expecting the CDF
to provide some sort of shortcut for setups where the connection is 1:1
with no means to perform any configuration of the bus.

> I also plan to specify video bus parameters in DT for CDF, but this hasn'=
t=20
> been finalized yet.

That effectively blocks any of the code that I've been working on until
CDF has been merged. It's been discussed for over a year now, and there
has even been significant pushback on using CDF in DRM, so even if CDF
is eventually merged, that will still leave DRM with no way to turn on
a simple panel.

I keep wondering why we absolutely must have compatibility between CDF
and this simple panel binding. DT content is supposed to concern itself
with the description of hardware only. What about the following isn't an
accurate description of the panel hardware?

	panel: panel {
		compatible =3D "cptt,claa101wb01";

		power-supply =3D <&vdd_pnl_reg>;
		enable-gpios =3D <&gpio 90 0>;

		backlight =3D <&backlight>;
	};

	dsi-controller {
		panel =3D <&panel>;
	};

Note how the above is also not incompatible with anything that the CDF
(to be) mandates, so it could easily be extended with any nodes or
properties that CDF needs to work properly without breaking backwards-
compatibility.

> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
[...]
> > +/*
> > + * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the
> > "Software"),
> > + * to deal in the Software without restriction, including without
> > limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sub
> > license,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice (including the
> > + * next paragraph) shall be included in all copies or substantial port=
ions
> > + * of the Software.
>=20
> This contradicts MODULE_LICENSE("GPL v2") below.

True, I'll fix that up.

> > +/* TODO: convert to gpiod_*() API once it's been merged */
> > +#define GPIO_ACTIVE_LOW	(1 << 0)
>=20
> Why can't you just #include <dt-bindings/gpio/gpio.h> ?

This is supposed to be something completely driver internal. Keeping it
here make that more explicit. It shouldn't matter much anyway, since by
now these patches have about 0 chance of making it into 3.13, so I'll
just convert them to gpiod.

> > +		backlight_update_status(p->backlight);
> > +	}
> > +
> > +	if (gpio_is_valid(p->enable_gpio)) {
> > +		if (p->enable_gpio_flags & GPIO_ACTIVE_LOW)
> > +			gpio_set_value(p->enable_gpio, 1);
> > +		else
> > +			gpio_set_value(p->enable_gpio, 0);
> > +	}
> > +
> > +	regulator_disable(p->supply);
> > +	p->enabled =3D false;
> > +}
> > +
> > +static void panel_simple_enable(struct drm_panel *panel)
> > +{
> > +	struct panel_simple *p =3D to_panel_simple(panel);
> > +	int err;
> > +
> > +	if (p->enabled)
> > +		return;
> > +
> > +	err =3D regulator_enable(p->supply);
> > +	if (err < 0)
> > +		dev_err(panel->dev, "failed to enable supply: %d\n", err);
>=20
> Is that really a non-fatal error ? Shouldn't the enable operation return =
an=20
> int ?

There's no way to propagate this in DRM, so why go through the trouble
of returning the error? Furthermore, there's nothing that the caller
could do to remedy the situation anyway.

> > +static const struct drm_display_mode auo_b101aw03_mode =3D {
> > +	.clock =3D 51450,
> > +	.hdisplay =3D 1024,
> > +	.hsync_start =3D 1024 + 156,
> > +	.hsync_end =3D 1024 + 156 + 8,
> > +	.htotal =3D 1024 + 156 + 8 + 156,
> > +	.vdisplay =3D 600,
> > +	.vsync_start =3D 600 + 16,
> > +	.vsync_end =3D 600 + 16 + 6,
> > +	.vtotal =3D 600 + 16 + 6 + 16,
> > +	.vrefresh =3D 60,
> > +};
>=20
> Instead of hardcoding the modes in the driver, which would then require t=
o be=20
> updated for every new simple panel model (and we know there are lots of t=
hem),=20
> why don't you specify the modes in the panel DT node ? The simple panel d=
river=20
> would then become much more generic. It would also allow board designers =
to=20
> tweak h/v sync timings depending on the system requirements.

Sigh... we keep second-guessing ourselves. Back at the time when power
sequences were designed (and NAKed at the last minute), we all decided
that the right thing to do would be to use specific compatible values
for individual panels, because that would allow us to encode the power
sequencing within the driver. And when we already have the panel model
encoded in the compatible value, we might just as well encode the mode
within the driver for that panel. Otherwise we'll have to keep adding
the same mode timings for every board that uses the same panel.

I do agree though that it might be useful to tweak the mode in case the
default one doesn't work. How about we provide a means to override the
mode encoded in the driver using one specified in the DT? That's
obviously a backwards-compatible change, so it could be added if or when
it becomes necessary.

Thierry

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX6WWAAoJEN0jrNd/PrOh3FcQAIfCCCeFkjIb3Jr1LHf7eM3o
XTN2kVuPltwORw/klgwj3qFox4yl09lWXrwMvzWxdrLgcm4zFQW/bn4wIEgKTMxq
0YMg49X6Le/v2T5c7/2HdK/eleBH134vLiXlaPDracvBIDtJQcRC+Pq2E0S+4bSV
agGEDWw++7Pgzvh6ThE+uAmoW/0ndM1/KMCymffef465DoQ74ffF3pCukOwfRxgF
eLSYZeOR+HRN9t8Rd1btccu6ZSJV60YbpawiVhs3C62/QbnzqbmoyDUnkyR+gW2a
dqOx9aIZ915jT1DuWvZSJvWaF9t4gQEchppx8dAfQyQO5U2WjZtkxWER9JuH/3Tw
8oPXIHRuRPrLx68eAiZRE9gSltXwFk4MdtQT0SCBGk+83/+Slzl6dowVrfefBfOa
bgel2Qa7g9jzXu5yGgYRq2prWD9L6bak+/rR2o373cs/K3CL/CasZJo/ken/Deqp
1vcN+GzbNp0kLdWiZQ8TpYT8Ltgps2MhZrJTkJ+zJaEWVY9DdTyajVGCEyP1JgZx
5bgxs81GE2Pzo8dux/xGkWJ6NBPRuT04NgLpwx8h3oEONIQ9csV+2nG/NhZt2uP1
wOnREGrE6rowyjtrOzb8eeY5obuqmgUKNP9yR9Gn22MIg3TA2l4Z9QGwwAJbtWWs
p4/yWOdnLA1Req/d0487
=erm6
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
