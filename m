From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 12:06:47 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017120646.GE10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Uwl7UQhJk99r8jnw"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <525FBA5D.9000001@ti.com>
 <20131017110517.GC10993@ulmo.nvidia.com>
 <3610893.n6xJ6DUJ0E@avalon>
In-Reply-To: <3610893.n6xJ6DUJ0E@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 01:15:22PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Thursday 17 October 2013 13:05:18 Thierry Reding wrote:
> > On Thu, Oct 17, 2013 at 01:22:21PM +0300, Tomi Valkeinen wrote:
> > > On 17/10/13 11:53, Thierry Reding wrote:
> > > > I keep wondering why we absolutely must have compatibility between =
CDF
> > > > and this simple panel binding. DT content is supposed to concern it=
self
> > > > with the description of hardware only. What about the following isn=
't an
> > > > accurate description of the panel hardware?
> > > >=20
> > > > 	panel: panel {
> > > > 		compatible =3D "cptt,claa101wb01";
> > > > 	=09
> > > > 		power-supply =3D <&vdd_pnl_reg>;
> > > > 		enable-gpios =3D <&gpio 90 0>;
> > > > 	=09
> > > > 		backlight =3D <&backlight>;
> > > > 	};
> > > > =09
> > > > 	dsi-controller {
> > > > 		panel =3D <&panel>;
> > > > 	};
> > >=20
> > > That's quite similar to how my current out-of-mainline OMAP DSS DT
> > > bindings work. The difference is that I have a reference from the pan=
el
> > > node to the video source (dsi-controller), instead of the other way
> > > around. I just find it more natural. It works the same way as, say,
> > > regulators, gpios, etc.
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
> I'm no DSI expert, but I know enough about it to be sure that Tomi will=
=20
> disagree. DSI panels can have complex power sequences that require the in=
put=20
> stream to be finely controlled (for instance it might require a clock wit=
hout=20
> video frames for some time, switch a GPIO or regulator, send a command to=
 the=20
> panel, and then only get video frames). For that reason all developers I'=
ve=20
> talked to who have an in-depth knowledge of DSI and DSI panels told me th=
at=20
> the panel needs to control the video bus, and request the video source to=
=20
> start/stop the video stream.

Oh, I'm very well aware of the various flavours of funkiness that DSI
panels come in. But it's wrong to say that the panel needs to control
the video bus. There's simply no way that a panel can actually do that.
It is true, however, that in order to make this work in a maintainable
fashion, the DSI panel *driver* may need to control the DSI bus. That's
an entirely different story.

Again, that's exactly how I2C works as well. I2C slaves, by definition,
do not control the I2C bus. However, I2C client drivers can do so by
using the (master) services provided by the I2C controller.

So for DSI what we could easily do is provide a DSI "adapter" to the
panel when it is attached to the DSI controller. If the DSI adapter
implements all of the required services, then the DSI panel driver is
easily capable of handling all the required special quirks.

I'm Cc'ing Rob and Daniel, both of whom have been working on this
lately. Actually I'm not sure if Daniel was directly involved, but at
least somebody from Intel's team was working on it.

> > > However, one thing unclear is where the panel node should be. You seem
> > > to have a DSI panel here. If the panel is truly not controlled in any
> > > way, maybe having the panel as a normal platform device is ok. But if
> > > the DSI panel is controlled with DSI messages, should it be a child of
> > > the dsi-controller node, the same way i2c peripherals are children of
> > > i2c master?
> >=20
> > That's one possibility. In this particular case it's not even necessary
> > to use any of DSIs control methods to talk to the panel. The panel only
> > receives the data stream and "just works".
> >=20
> > Even if the panel were to be controlled via DSI, I think keeping it as
> > a separate device node is equally valid. It's really boils down to what
> > I already said above. The output uses the panel as a resource, similar
> > to how other devices might use a GPIO controller to use a GPIO pin, or
> > an interrupt controller to request an IRQ.
>=20
> Except that the display controller can also provides resources to the pan=
el.=20
> For DSI panels that support DSI commands, the control bus is provided by =
the=20
> display controller. Much like an I2C device must be a child of its I2C=20
> controller node, the DSI panel device should then be a child of the displ=
ay=20
> controller node.

I don't think resources is the right term here. The DSI controller
provides services. That's traditionally been handled in DT by handing
out phandles to the service providers.

That said I see why it would make sense to make a DSI panel the child of
the DSI controller node, so we agree at least partially. I don't like it
all that much because it makes handling of panels inconsistent across
various types of output and therefore makes it more complicated to
support it drivers, but I'm sure I can live with it if somebody wants to
enforce that.

> > > > I do agree though that it might be useful to tweak the mode in case=
 the
> > > > default one doesn't work. How about we provide a means to override =
the
> > > > mode encoded in the driver using one specified in the DT? That's
> > > > obviously a backwards-compatible change, so it could be added if or=
 when
> > > > it becomes necessary.
> > >=20
> > > This sounds good to me.
> > >=20
> > > Although maybe it'd be good to have the driver compatible with someth=
ing
> > > like "generic-panel", so that you could have:
> > >=20
> > > compatible =3D "foo,specific-panel", "generic-panel";
> > >=20
> > > and if there's no need for any power/gpio setup for your board, you m=
ay
> > > skip adding "foo,specific-panel" support to the panel driver. Later,
> > > somebody else may need to implement fine grained power/gpio support f=
or
> > > "foo,specific-panel", and it would just work.
> > >=20
> > > Maybe that would help us with the problem of adding support in the
> > > driver for a hundred different simple panels each used only once on a
> > > specific board.
> >=20
> > Sure, that all sounds like reasonable additions. All of the suggestions
> > are even backwards-compatible and hence can be added when needed without
> > breaking compatibility with existing users of the binding.
>=20
> What's wrong with moving the three hardcoded modes we already have in the=
=20
> driver to DT before pushing this to mainline ?

I think I've answered that in a different subthread.

Thierry

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX9LWAAoJEN0jrNd/PrOh6LgQALG96aqpH3+41J963saOtYNU
VVmSlcGdd/3+TIp3y7UrOuO+v5wy0ufCnHtHfskyEttr4ReVmYYbtcpauQK/J6id
bV9rdGohXCHe9s94iNrirz2whHAXUQOcxPYiaExgCTQ6eFPQxl/IKXooXFouueiu
QKC3++Ed3LUJyH0TXXBwsUq8zpF6vbgjCSwFmIPDbUNCBtXPHiIJVlTZAumwZ2VI
RCG0GWd8q17EkmULDnFfkL+2ePe3LNR1x/lC/M6iTJoiP+tvn6pYql0cR7M2eqrc
K0o5pjSRUUvi+KoaXuXUe+nK8QYgHkrbhCttqTufoXTfMIy6MekxlhJ7O9XGD3uY
SUnOvytcNqsUOjCzvxOB0eE5bYJJ4arDRdXlGxUD9YP+VMA3xSpbB2KLtVodZaaS
NU2InAHFnzZ/Kli7GafNzC7GhEQkhM4S1A4/DtWmJkIzE1WUujFLnlw/WEjf0jPn
zSfFEhRSslpiSo6Ri6+TAhX+vTKsFCAeIJW4NRNfWduu2psLLc54t/k0E+1WlDUt
z3vh1dLe/LgITpYv4GltpgmlZctHzcVaoXP7RLo1rAwNGkxULWYHbcNT4YyEupRl
wXd0i8WCU1ImcAeRL0yb8hnWOCW/UfB5lEqomJP/GsRPftLMtw9hDWtyJh2mEUQK
/OgrCX8z91pn/cjRAcbP
=YsAo
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--
