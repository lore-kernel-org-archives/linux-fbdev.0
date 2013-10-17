From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 12:12:09 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017121208.GF10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XIiC+We3v3zHqZ6Z"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1381947912-11741-3-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
 <20131017085342.GB2502@ulmo.nvidia.com>
 <525FBA5D.9000001@ti.com>
 <20131017110517.GC10993@ulmo.nvidia.com>
 <525FCF07.6070006@ti.com>
In-Reply-To: <525FCF07.6070006-l0cyMroinI0@public.gmane.org>
To: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 02:50:31PM +0300, Tomi Valkeinen wrote:
> On 17/10/13 14:05, Thierry Reding wrote:
>=20
> >> That's quite similar to how my current out-of-mainline OMAP DSS DT
> >> bindings work. The difference is that I have a reference from the panel
> >> node to the video source (dsi-controller), instead of the other way
> >> around. I just find it more natural. It works the same way as, say,
> >> regulators, gpios, etc.
> >=20
> > I suppose that depends on the way you look at it. In the above proposal
> > I consider the output (DSI controller) to use the panel as a resource
> > that provides a certain set of services (query mode timings, provide a
> > way to enable or disable the panel). Similarly the panel uses the
> > backlight as a resource that provides a certain set of services (such as
> > changing the brightness).
> >=20
> > The above also follows the natural order of control. The panel has no
> > way to control the DSI output. However, it is the output that controls
> > when a panel is required and turn it on as appropriate.
>=20
> I've discussed this issue to death with other people, and for some
> reason I still see this the other way =3D).
>=20
> I see the panel using the DSI controller as a resource. The panel driver
> uses the DSI controller to send the video data to the panel device.
> Compare this to, say, i2c client driver, which uses i2c master to send
> data to the i2c device.
>=20
> In the OMAP DSS driver model, the panel driver is in control. The panel
> driver tells the DSI controller which kind of video timings to use, or
> which bus speed to use, or whether to use low-power or high-speed mode,
> when to enable the DSI clock or DSI video stream, etc.
>=20
> With a simple panel the model you describe works usually fine. The
> reason I went with the different model is that we had rather complex
> display peripherals, that needed more specific control of the bus.
>=20
> A simple example could be the enable sequence. I presume in your model
> the DSI controller's enable would be maybe something like:
>=20
> configure_dsi_timings(panel->get_timings());
> enable_dsi_output();
> panel->enable();
>=20
> What if the DSI peripheral requires an enable sequence of, say:
>=20
> - enable DSI clock
> - use LP mode
> - send some config messages
> - re-configure DSI clock to higher speed
> - send some more config messages
> - enable HS mode
> - send some more config messages
> - enable DSI video stream
>=20
> It gets a bit difficult to manage that kind of setup in a generic way in
> the DSI controller driver. As I see it, the DSI peripheral driver has to
> be in control of the nuances. The same goes for other video buses also,
> but DSI is perhaps one of the most complex ones to support.

I've briefly gone over this in another subthread, but here it is again
for the sake of completeness.

The difference in perception I think comes from the fact that the DSI
panel *driver* may need to control the DSI bus. However, DT describes
the hardware in terms of devices. And from that point of view it is
still the DSI _control_ler that _control_s the panel. There's no
electrical way that the panel can take possession of the bus. Well,
there's BTA, but even that happens under supervision of the DSI
controller.

Thierry

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX9QYAAoJEN0jrNd/PrOhhH8P/2AQ2wKaECJPZu6VIvVxkdrZ
9J3FgOMLVWSuuUZGqBbPf7fmtN0PGyL09bnmTq4yICeJtBMIXqnIayDlPA3XrI7t
SBfjY+PBxb1TacFlWhP7zIk8WL2IVAKURh2Jz7WLE58wtLBqCX1UC04tHuEtTyHT
OtqySmy3ArGLwj5JDmeS3Cv/Q0auNYEpDHcgYHshU2BmeKXhXj6fBoYxwVXSxGOL
GulhKsdRE2qsoGCXd3uEg82PMQhNggZLYpcqVwfFkiaEti+2NCR9VIlA8ccr0z1m
+i+JViRSZfRjTOUUXTUhekv3uVwiNAAuXC05uXzwSrvJkJAoEMfs8UpHmsarn0Ou
Z7yEOh7+ZJXeVZlE0fZG+rUvedmDsIEZluu54+b5lYBP4eZ4+deZo42a4TSoh/lf
EiH7fo5p74P4J4xHeKAYBIdmcc/4nxHVLDuX21VJi1gFohAMHvUrIuN+N/xClbl6
5z5t7mQ95ve1tKQRfWONXFc7fHdU/szvfzcrhEA84RA2YkkIbHFSTjXU1v+iM+NL
XQJhktwsMVLvyHsvuRbpbAMbdzxzse8pc0LMrZ5oztdw4rJYUOc+adky3D0VhTly
a6VmBMVet2ERmn8TvOLUzNpW/lD3WdZ/WB1AOJmFLfldeGap8I8xuYL2wpOiqX3G
dh77mhLQb6uRoeS6yrVf
=oaxp
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
