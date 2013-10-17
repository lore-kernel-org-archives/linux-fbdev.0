From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 11:41:40 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017114139.GD10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="llIrKcgUOe3dCx0c"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1695169.rzbDl9PeRX@avalon>
 <20131017085342.GB2502@ulmo.nvidia.com>
 <12566222.aRYc4MDoOm@avalon>
In-Reply-To: <12566222.aRYc4MDoOm@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 01:02:38PM +0200, Laurent Pinchart wrote:
> On Thursday 17 October 2013 10:53:43 Thierry Reding wrote:
[...]
> CDF needs to model video pipelines that can be more complex than just a=
=20
> display controller with a single output connected to a panel with a singl=
e=20
> input. For that reason the DT bindings need to describe connections in a=
=20
> generic enough way. The above DT fragment might be slightly more complex =
than=20
> one would expect when thinking about the really simple case only, but it'=
s=20
> nowhere near overly complex in my opinion.
>=20
> Please note that, when a device has as single port, the ports node can be=
=20
> omitted, and the port doesn't need to be numbered. You would then end up =
with
>=20
>  	dc: display-controller {
> 		port {
> 			remote-endpoint =3D <&panel>;
>  		};
>  	};
> =20
>  	panel: panel {
>  		port {
>  			remote-endpoint =3D <&dc>;
>  		};
>  	};
>=20
> I don't think there's a way to simplify it further.

That binding looks completely inconsistent to me. If we can write it
either using a ports node with port@X subnodes, in my opinion we can
equally well just use a unidirectional link for the case where we
don't need the link back from the panel to the output. Where's the
difference?

Consider for example the case where an LVDS panel is connected to a
simple LVDS output. For what possible reason would the panel need to
access the output?

> > > I also plan to specify video bus parameters in DT for CDF, but this h=
asn't
> > > been finalized yet.
> >=20
> > That effectively blocks any of the code that I've been working on until
> > CDF has been merged. It's been discussed for over a year now, and there
> > has even been significant pushback on using CDF in DRM, so even if CDF
> > is eventually merged, that will still leave DRM with no way to turn on
> > a simple panel.
>=20
> I'm probably even more concerned about the long time all this took and wi=
ll=20
> still take than you are, sincerely. I'm obviously to blame for not being =
able=20
> to explain the problems and solutions correctly, as I see no way why peop=
le=20
> would push back if they realized that the other solutions that have been=
=20
> proposed, far from being future-proof, won't even be present-proof. We wo=
uld=20
> be shooting ourselves in the foot, but what can I do when too many people=
 want=20
> to do so ?

I'm curious why you think this current proposal isn't present-proof. All
three panels that I've tested with work with this proposal currently and
I'm convinced that many more setups can be covered using something as
simple as this.

> I'll still keep trying of course, but not for years.I have yet to=20
> see someone proposing a viable solution to share drivers between DRM and =
V4L2,=20
> which is a real pressing requirement, partly due to DT.

Yeah... I still don't get that side of the argument. Why exactly do we
need to share the drivers again? If we really need to support display
output within V4L2, shouldn't we instead improve interoperability
between the two and use DRM/KMS exclusively for the output part? Then
the problem of having to share drivers between subsystems goes away and
we'll actually be using the right subsystem for the right job at hand.

Of course none of that is relevant to the topic of DT bindings, which is
what we should probably be concentrating on. Nobody's been able to come
up with a valid reason why the proposed binding is broken. It works for
the tested devices (likely many more as well) and I don't forsee why it
can't be future-proof. Why would it suddenly need to change? And even if
it needed to change, why would the changes be backwards-incompatible
rather than simply additional features that don't impact existing users?

> Regarding the use of CDF in DRM, please note that it will be optional for=
=20
> drivers to switch to the new framework. Nothing should hopefully require=
=20
> existing drivers to be converted, drivers that want to make use of CDF to=
=20
> support panels will be welcome to do so, but they big DRM drivers for des=
ktop=20
> GPUs won't be affected.

I'm not at all opposed to the idea of CDF or the problems it tries to
address. I don't think it necessarily should be a separate framework for
reasons explained earlier. But even if it were to end up in a separate
framework there's absolutely nothing preventing us from adding a DRM
panel driver that hooks into CDF as a "backend" of sorts for panels that
require something more complex than the simple-panel binding.

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
> >=20
> > Note how the above is also not incompatible with anything that the CDF
> > (to be) mandates, so it could easily be extended with any nodes or
> > properties that CDF needs to work properly without breaking backwards-
> > compatibility.
>=20
> As mentioned above, CDF needs to describe more complex pipelines. To make=
 the=20
> driver life as simple as possible the core code will handle the pipeline=
=20
> description in the DT bindings, and it does require it to be generic enou=
gh.=20
> You can of course describe connections in various ways depending on the=
=20
> hardware, which would make the DT-related code needlessly overcomplex. On=
e of=20
> the issue with the above description is that there's no way to go from th=
e=20
> panel to the display controller, which might be a show stopper in the fut=
ure=20
> when code requires that. A workaround would be to look through the whole =
DT=20
> for the reverse link, which would be pretty inefficient.

But that's precisely the point. Why would we need to go back from the
panel to the display controller? Especially for dumb panels that can't
or don't have to be configured in any way. Even if they needed some sort
of setup, why can't that be done from the display controller/output.

Even given a setup where a DSI controller needs to write some registers
in a panel upon initialization, I don't see why the reverse connection
needs to be described. The fact alone that an output dereferences a
panel's phandle should be enough to connect both of them and have any
panel driver use the DSI controller that it's been attached to for the
programming.

That's very much analogous to how I2C works. There are no connections
back to the I2C master from the slaves. Yet each I2C client driver
manages to use the services provided by the I2C master to perform
transactions on the I2C bus. In a similar way the DSI controller is the
bus master that talks to DSI panels. DSI panels don't actively talk to
the DSI controller.

> > > > +static void panel_simple_enable(struct drm_panel *panel)
> > > > +{
> > > > +	struct panel_simple *p =3D to_panel_simple(panel);
> > > > +	int err;
> > > > +
> > > > +	if (p->enabled)
> > > > +		return;
> > > > +
> > > > +	err =3D regulator_enable(p->supply);
> > > > +	if (err < 0)
> > > > +		dev_err(panel->dev, "failed to enable supply: %d\n", err);
> > >=20
> > > Is that really a non-fatal error ? Shouldn't the enable operation ret=
urn
> > > an int ?
> >=20
> > There's no way to propagate this in DRM, so why go through the trouble
> > of returning the error? Furthermore, there's nothing that the caller
> > could do to remedy the situation anyway.
>=20
> That's a DRM issue, which could be fixed. While the caller can't remedy t=
he=20
> situation, it should at least report the error to the application instead=
 of=20
> silently ignoring it.

Perhaps. It's not really relevant to the discussion and can always be
fixed in a subsequent patch.

> > > > +static const struct drm_display_mode auo_b101aw03_mode =3D {
> > > > +	.clock =3D 51450,
> > > > +	.hdisplay =3D 1024,
> > > > +	.hsync_start =3D 1024 + 156,
> > > > +	.hsync_end =3D 1024 + 156 + 8,
> > > > +	.htotal =3D 1024 + 156 + 8 + 156,
> > > > +	.vdisplay =3D 600,
> > > > +	.vsync_start =3D 600 + 16,
> > > > +	.vsync_end =3D 600 + 16 + 6,
> > > > +	.vtotal =3D 600 + 16 + 6 + 16,
> > > > +	.vrefresh =3D 60,
> > > > +};
> > >=20
> > > Instead of hardcoding the modes in the driver, which would then requi=
re to
> > > be updated for every new simple panel model (and we know there are lo=
ts
> > > of them), why don't you specify the modes in the panel DT node ? The
> > > simple panel driver would then become much more generic. It would also
> > > allow board designers to tweak h/v sync timings depending on the syst=
em
> > > requirements.
> >=20
> > Sigh... we keep second-guessing ourselves. Back at the time when power
> > sequences were designed (and NAKed at the last minute), we all decided
> > that the right thing to do would be to use specific compatible values
> > for individual panels, because that would allow us to encode the power
> > sequencing within the driver. And when we already have the panel model
> > encoded in the compatible value, we might just as well encode the mode
> > within the driver for that panel. Otherwise we'll have to keep adding
> > the same mode timings for every board that uses the same panel.
> >=20
> > I do agree though that it might be useful to tweak the mode in case the
> > default one doesn't work. How about we provide a means to override the
> > mode encoded in the driver using one specified in the DT? That's
> > obviously a backwards-compatible change, so it could be added if or when
> > it becomes necessary.
>=20
> I share Tomi's point of view here. Your three panels use the same power=
=20
> sequence, so I believe we should have a generic panel compatible string t=
hat=20
> would use modes described in DT for the common case. Only if a panel requ=
ired=20
> something more complex which can't (or which could, but won't for any rea=
son)=20
> accurately be described in DT would you need to extend the driver.

I don't see the point quite frankly. You seem to be assuming that every
panel will only be used in a single board. However what you're proposing
will require the mode timings to be repeated in every board's DT file,
if the same panel is ever used on more than a single board.

Thierry

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX8zzAAoJEN0jrNd/PrOhR0wP/j4euZBw1Qocu9+9lOekGTnR
PFfxEPQpFeMmciv0KRAMem+wRrONSatW8VHFroKATkC8BUJE5PQJ5bXM0iF8eWkx
fXUM9CTGcfbQ7ndaN00U6XeKnBtMSWOZ6vJJeNg3EmNanWmdM6oVX7DWaa4n7lvH
Rql4Q3chjBWK5P8+GuTgG3pFYUJUxjAD6WAj/GuxmIf2r54HYK+mM9YAyaaoALkO
VgVrIjyQ1RVk4ZsBKLLDMdIPqw3Xpf1/SsDDMDwtCk80CVmKEW7L1CGA9T9JfXC3
2YR1JwqyptVezwjny6CrtGcIJSPZM5Y8l340pGMSF3iODkX4qZwGEGPmkACgoyn+
b75SVKWEXDU94LdW8vCUKGc2d6wzmwrSJOKxs2LRNssU8ojpx/gbdxRy32lHDXRD
rmisE9OkZxeikYv0wnrO90R7y9u1h582jppDmPoygSzSorzeNwAgmx7MbLfE1cqs
Dwe0ZjAyn1hFmx8o85PuxJA0fkg/1mHJN+OL4z5nB43Yj8bkHkHFWwI/j6S3AIds
YUaBjytS1kRAZn8mTmiSIBc3xn0cSqF9v1AE0l+7i209XE6M9VBqdpf08EWr7tlq
03FvYB9t1Yc9D3C+PU9ZvULbe2ZGVA9a+sGFk+d4D79mpJjJJqo1usIvCjuyH3/8
HmusfqhcOEmYodJi0cMp
=/NUL
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
