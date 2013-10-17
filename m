From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 11:05:18 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017110517.GC10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Fig2xvG2VGoz8o/s"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1381947912-11741-3-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
 <20131017085342.GB2502@ulmo.nvidia.com>
 <525FBA5D.9000001@ti.com>
In-Reply-To: <525FBA5D.9000001-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 01:22:21PM +0300, Tomi Valkeinen wrote:
> On 17/10/13 11:53, Thierry Reding wrote:
>=20
> > I keep wondering why we absolutely must have compatibility between CDF
> > and this simple panel binding. DT content is supposed to concern itself
> > with the description of hardware only. What about the following isn't an
> > accurate description of the panel hardware?
> >=20
> > 	panel: panel {
> > 		compatible =3D "cptt,claa101wb01";
> >=20
> > 		power-supply =3D <&vdd_pnl_reg>;
> > 		enable-gpios =3D <&gpio 90 0>;
> >=20
> > 		backlight =3D <&backlight>;
> > 	};
> >=20
> > 	dsi-controller {
> > 		panel =3D <&panel>;
> > 	};
>=20
> That's quite similar to how my current out-of-mainline OMAP DSS DT
> bindings work. The difference is that I have a reference from the panel
> node to the video source (dsi-controller), instead of the other way
> around. I just find it more natural. It works the same way as, say,
> regulators, gpios, etc.

I suppose that depends on the way you look at it. In the above proposal
I consider the output (DSI controller) to use the panel as a resource
that provides a certain set of services (query mode timings, provide a
way to enable or disable the panel). Similarly the panel uses the
backlight as a resource that provides a certain set of services (such as
changing the brightness).

The above also follows the natural order of control. The panel has no
way to control the DSI output. However, it is the output that controls
when a panel is required and turn it on as appropriate.

> However, one thing unclear is where the panel node should be. You seem
> to have a DSI panel here. If the panel is truly not controlled in any
> way, maybe having the panel as a normal platform device is ok. But if
> the DSI panel is controlled with DSI messages, should it be a child of
> the dsi-controller node, the same way i2c peripherals are children of
> i2c master?

That's one possibility. In this particular case it's not even necessary
to use any of DSIs control methods to talk to the panel. The panel only
receives the data stream and "just works".

Even if the panel were to be controlled via DSI, I think keeping it as
a separate device node is equally valid. It's really boils down to what
I already said above. The output uses the panel as a resource, similar
to how other devices might use a GPIO controller to use a GPIO pin, or
an interrupt controller to request an IRQ.

> >>> +static const struct drm_display_mode auo_b101aw03_mode =3D {
> >>> +	.clock =3D 51450,
> >>> +	.hdisplay =3D 1024,
> >>> +	.hsync_start =3D 1024 + 156,
> >>> +	.hsync_end =3D 1024 + 156 + 8,
> >>> +	.htotal =3D 1024 + 156 + 8 + 156,
> >>> +	.vdisplay =3D 600,
> >>> +	.vsync_start =3D 600 + 16,
> >>> +	.vsync_end =3D 600 + 16 + 6,
> >>> +	.vtotal =3D 600 + 16 + 6 + 16,
> >>> +	.vrefresh =3D 60,
> >>> +};
> >>
> >> Instead of hardcoding the modes in the driver, which would then requir=
e to be=20
> >> updated for every new simple panel model (and we know there are lots o=
f them),=20
> >> why don't you specify the modes in the panel DT node ? The simple pane=
l driver=20
> >> would then become much more generic. It would also allow board designe=
rs to=20
> >> tweak h/v sync timings depending on the system requirements.
> >=20
> > Sigh... we keep second-guessing ourselves. Back at the time when power
> > sequences were designed (and NAKed at the last minute), we all decided
> > that the right thing to do would be to use specific compatible values
> > for individual panels, because that would allow us to encode the power
> > sequencing within the driver. And when we already have the panel model
> > encoded in the compatible value, we might just as well encode the mode
> > within the driver for that panel. Otherwise we'll have to keep adding
> > the same mode timings for every board that uses the same panel.
>=20
> Oh, I didn't feel "we all decided that the right thing..." =3D).
>=20
> > I do agree though that it might be useful to tweak the mode in case the
> > default one doesn't work. How about we provide a means to override the
> > mode encoded in the driver using one specified in the DT? That's
> > obviously a backwards-compatible change, so it could be added if or when
> > it becomes necessary.
>=20
> This sounds good to me.
>=20
> Although maybe it'd be good to have the driver compatible with something
> like "generic-panel", so that you could have:
>=20
> compatible =3D "foo,specific-panel", "generic-panel";
>=20
> and if there's no need for any power/gpio setup for your board, you may
> skip adding "foo,specific-panel" support to the panel driver. Later,
> somebody else may need to implement fine grained power/gpio support for
> "foo,specific-panel", and it would just work.
>=20
> Maybe that would help us with the problem of adding support in the
> driver for a hundred different simple panels each used only once on a
> specific board.

Sure, that all sounds like reasonable additions. All of the suggestions
are even backwards-compatible and hence can be added when needed without
breaking compatibility with existing users of the binding.

Thierry

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX8RtAAoJEN0jrNd/PrOhITkP/R5gMgYvT1wCIRoM/8ZBWQav
8Usf4f6BeSLdedbQQKKYL6/6i1b4ZUSXsX5MWvq9m/2PODvuMCfYQQBnruXt68+v
YL4SVm1Kkhw+kdS/9JKTBuPn+/I0+j2XmNJ6HHKL2Ks6JnM/lMJAnR+JGSTj5Gsy
5wCaNyQED5wj2lu9sy8EICaOyae/kOrEPBlBfW0WViVjj3t9d4V8rfCIF4T3P4VD
TXiOxAcg/u2DnI/ckDTbU3HKf9UB6M7PKugY20yElqEMiwkWBra3TD6/+YsPOLE6
SLVHp1GSrAm8lh4v+AYfCgenKOS3KJ1DpqQruG+LnVDu7DNCYa35MD3hSa/ZL+Cx
GNcccBefVSuKu/4rCi62ep8EytfTgrhJ+1L17kZGMl4YbX2Xn2uctPaDQSkXGXUW
iYKH/BCieuBwibzPjWbUFgbM5j4GRYY48SweX+HdM/Yw7jiNObj9JRI57WZvwzbH
xQ96zFBeUhW2lslPBcRD7LE3Z5XNgJYedS4CgTi0X7+LKNGfrGDv0z0+Fhxc1DOv
WJjZZVIMnq7ZJaXghf2nRF31coXWVOiQslJFnQQZPo2HHeM7SNf9yVES2CECUQvb
vlErBhANzKWWH2e1aA2qnPGpsbEY8qd5/beyY9acq+rl5uCtSUQR1op7vdGXNV+L
e2zPSYvhlKeY3WWMpJB4
=h4Oq
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
