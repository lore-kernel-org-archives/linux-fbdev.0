From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 24 Oct 2013 11:48:24 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131024114823.GC11296@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KN5l+BnMqAQyZLvT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <1673630.A5yYaNBe3X@avalon>
 <20131017124619.GG10993@ulmo.nvidia.com>
 <2692478.1sYB6OvYJ1@avalon>
In-Reply-To: <2692478.1sYB6OvYJ1@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2013 at 01:05:49PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> On Thursday 17 October 2013 14:46:20 Thierry Reding wrote:
> > On Thu, Oct 17, 2013 at 02:14:45PM +0200, Laurent Pinchart wrote:
> > > On Thursday 17 October 2013 13:41:40 Thierry Reding wrote:
> > > > On Thu, Oct 17, 2013 at 01:02:38PM +0200, Laurent Pinchart wrote:
> > > > > On Thursday 17 October 2013 10:53:43 Thierry Reding wrote:
>=20
> [snip]
>=20
> > > The point is that the video pipeline must be described in DT. Having a
> > > per-device way to represent connections would be a nightmare to suppo=
rt
> > > from an implementation point of view, hence the need for a generic wa=
y to
> > > describe them.
> >=20
> > Okay, so we're back to the need to describe pipelines in DT. At the risk
> > of sounding selfish: I don't care about pipelines. I just want us to
> > settle on a way to represent a dumb panel in DT so that it can be
> > enabled when it needs to. Furthermore I don't have any hardware that
> > exhibits any of these "advanced" features, so I'm totally unqualified to
> > work on any of this.
> >=20
> > Can we please try to be a little pragmatic here and solve one problem at
> > a time? I am aware that solving this for panels may require some amount
> > of foresight, but let's not try to solve everything at once at the risk
> > of not getting anything done at all.
>=20
> I won't force you to care about pipelines, and I don't think this is self=
ish=20
> at all :-)
>=20
> What I would like to ensure is that whatever bindings we come up with, th=
ey=20
> will not preclude us from adding pipeline support when needed (as I'm pre=
tty=20
> sure it will be needed at some point).

Sure. I think I've explained elsewhere that I consider this easily
possible. Other people have said the same thing. If all we do is add
properties to a binding, then drivers written for an old binding will
have no problem continuing to work.

I also think that we're mostly being too scared. If ever the next device
comes around that requires explicit pipeline support to work, how likely
is it to have the exact same display as prior devices?

> > > > I'm not at all opposed to the idea of CDF or the problems it tries =
to
> > > > address. I don't think it necessarily should be a separate framewor=
k for
> > > > reasons explained earlier. But even if it were to end up in a separ=
ate
> > > > framework there's absolutely nothing preventing us from adding a DRM
> > > > panel driver that hooks into CDF as a "backend" of sorts for panels=
 that
> > > > require something more complex than the simple-panel binding.
> > >=20
> > > Once again it's not about panel having complex needs, but more about =
using
> > > simple panels in complex pipelines. I'm fine with the drm_panel
> > > infrastructure, what I would like is DT bindings that describe connec=
tions
> > > in a more future-proof way. The rest is fine.
> >=20
> > And I've already said elsewhere that the bindings in their current form
> > are easily extensible to cater for the needs of CDF.
>=20
> The simple panel bindings do not include any connection information, so w=
e=20
> could add that later when needed without having to deprecate, remove or=
=20
> repurpose existing properties.

Yes, I agree.

> The simple panel driver would need to be extended, which isn't much of a
> problem (except that extending it with CDF support might require changes
> to the users of the simple panel driver, which I believe won't be happily
> accepted, but that's a different issue).

That might be true. But that's just the way kernel development works. We
sometimes require major rework of APIs and we're actually pretty good at
pulling that off, so I don't worry too much about it.

Also, being the original author of the driver makes me the maintainer,
and if it should prove to be necessary I'm absolutely willing to add CDF
support.

> My concern is also on the other side. In the patches you've sent the tegr=
a=20
> driver uses a custom nvidia,panel property to reference the panel. That w=
ould=20
> of course not be CDF-compatible, but there's no way around that at the mo=
ment=20
> if we don't want to keep development of all ARM KMS drivers stalled for t=
he=20
> next 6 months.

Well, the nvidia,panel property is part of the display output and it is
an optional property. So the driver already needs to cope with it being
absent. If the display output driver is ever extended with CDF support
then we can just go and use CDF if CDF-specific properties exist, or we
fall back to nvidia,panel if that doesn't exist.

> It boils down to the question of whether DT should be a stable ABI, and
> I'm increasingly tempted to say that I don't care. I want to solve
> issues we have on the display side, the firmware interface isn't my main
> concern.

I wholeheartedly agree. In my opinion it is much more useful to come up
with a solution that works now, rather than discussing and arguing
things to death and not get anything done. If that means that I'll have
to maintain additional code, then so be it.

> > > > But that's precisely the point. Why would we need to go back from t=
he
> > > > panel to the display controller? Especially for dumb panels that ca=
n't
> > > > or don't have to be configured in any way. Even if they needed some=
 sort
> > > > of setup, why can't that be done from the display controller/output.
> > > >=20
> > > > Even given a setup where a DSI controller needs to write some regis=
ters
> > > > in a panel upon initialization, I don't see why the reverse connect=
ion
> > > > needs to be described. The fact alone that an output dereferences a
> > > > panel's phandle should be enough to connect both of them and have a=
ny
> > > > panel driver use the DSI controller that it's been attached to for =
the
> > > > programming.
> > > >=20
> > > > That's very much analogous to how I2C works. There are no connectio=
ns
> > > > back to the I2C master from the slaves. Yet each I2C client driver
> > > > manages to use the services provided by the I2C master to perform
> > > > transactions on the I2C bus. In a similar way the DSI controller is=
 the
> > > > bus master that talks to DSI panels. DSI panels don't actively talk=
 to
> > > > the DSI controller.
> > >=20
> > > It's all about modeling video pipeline graphs in DT. To be able to wa=
lk
> > > the graph we need to describe connections. Not having bidirectional
> > > information means that we restrict the points at which we can start
> > > walking the graph, potentially making our life much more difficult in=
 the
> > > future.
> > >=20
> > > What's so wrong about adding a port node and link information to the =
panel
> > > DT node ? It describe what's there: the panel has one input, why not =
make
> > > that explicit ?
> >=20
> > What's wrong with it is that there's no way to verify the soundness of
> > the design by means of a full implementation because we're missing the
> > majority of the pieces. Just putting the nodes into DT to provide some
> > imaginary future-proofness isn't helpful either. Without any code that
> > actually uses them they are useless.
> >=20
> > And again, why should we add them right away (while not needed) when
> > they can easily be added in a backwards-compatible manner at some later
> > point when there's actually any use for them and they can actually be
> > tested in some larger framework?
>=20
> It's the "easily" part I'm not sure about. I doubt we'll ever have any ea=
sy to=20
> solve DT backward compatibility issue. However, as mentioned above, this=
=20
> shouldn't be a show stopper. I'm thus fine with the way the proposed bind=
ings=20
> describe (or rather don't describe) the connection. However, I will then=
=20
> expect your support in the future to implement the "easy" extension of th=
e=20
> bindings to support CDF.

Again, I don't expect that to ever happen. But if it ever happens
anyway, then...

> Do we have a deal ? ;-)

Yes, we do.

> > > > > > > > +static void panel_simple_enable(struct drm_panel *panel)
> > > > > > > > +{
> > > > > > > > +	struct panel_simple *p =3D to_panel_simple(panel);
> > > > > > > > +	int err;
> > > > > > > > +
> > > > > > > > +	if (p->enabled)
> > > > > > > > +		return;
> > > > > > > > +
> > > > > > > > +	err =3D regulator_enable(p->supply);
> > > > > > > > +	if (err < 0)
> > > > > > > > +		dev_err(panel->dev, "failed to enable supply: %d\n",=20
> err);
> > > > > > >=20
> > > > > > > Is that really a non-fatal error ? Shouldn't the enable opera=
tion
> > > > > > > return an int ?
> > > > > >=20
> > > > > > There's no way to propagate this in DRM, so why go through the
> > > > > > trouble of returning the error? Furthermore, there's nothing th=
at
> > > > > > the caller could do to remedy the situation anyway.
> > > > >=20
> > > > > That's a DRM issue, which could be fixed. While the caller can't
> > > > > remedy the situation, it should at least report the error to the
> > > > > application instead of silently ignoring it.
> > > >=20
> > > > Perhaps. It's not really relevant to the discussion and can always =
be
> > > > fixed in a subsequent patch.
> > >=20
> > > Most things can be fixed by a subsequent patch, that's not a good eno=
ugh
> > > reason not to address the known problems before pushing the code to
> > > mainline (to clarify my point of view, there's no need to fix DRM to =
use
> > > the return value before pushing this patch set to mainline, but I'd l=
ike
> > > a v2 with an int return value).
> >=20
> > Why? What's the use of returning an error if you know up front that it
> > can't be used? This should be changed if or when we "fix" DRM to propag=
ate
> > errors.
>=20
> Because not doing so now will require us to change (potentially) lots of =
panel=20
> drivers at that time. It's much easier to have each panel driver develope=
r=20
> implement the required code in his/her driver than having a single develo=
per=20
> refactoring the code later and have to touch all drivers. If your concern=
 is=20
> that the error paths won't be testable at the moment, you could easily al=
ready=20
> add a WARN_ON() to the caller to catch problems.

I don't mind fixing potentially many drivers. The conversion is pretty
mechanical and therefore easy. We even have tools such as coccinelle to
help with it. But we've probably spent more time arguing the point than
it would take to make this simple change, so I'll just go and change the
return value to an int and return an error.

Perhaps if I'm in the mood I'll even write up a patch to propagate the
error further.

> > > > > > > Instead of hardcoding the modes in the driver, which would th=
en
> > > > > > > require to be updated for every new simple panel model (and we
> > > > > > > know there are lots of them), why don't you specify the modes=
 in
> > > > > > > the panel DT node ? The simple panel driver would then become=
 much
> > > > > > > more generic. It would also allow board designers to tweak h/v
> > > > > > > sync timings depending on the system requirements.
> > > > > >=20
> > > > > > Sigh... we keep second-guessing ourselves. Back at the time when
> > > > > > power sequences were designed (and NAKed at the last minute), w=
e all
> > > > > > decided that the right thing to do would be to use specific
> > > > > > compatible values for individual panels, because that would all=
ow us
> > > > > > to encode the power sequencing within the driver. And when we
> > > > > > already have the panel model encoded in the compatible value, we
> > > > > > might just as well encode the mode within the driver for that p=
anel.
> > > > > > Otherwise we'll have to keep adding the same mode timings for e=
very
> > > > > > board that uses the same panel.
> > > > > >=20
> > > > > > I do agree though that it might be useful to tweak the mode in =
case
> > > > > > the default one doesn't work. How about we provide a means to
> > > > > > override the mode encoded in the driver using one specified in =
the
> > > > > > DT? That's obviously a backwards-compatible change, so it could=
 be
> > > > > > added if or when it becomes necessary.
> > > > >=20
> > > > > I share Tomi's point of view here. Your three panels use the same
> > > > > power sequence, so I believe we should have a generic panel compa=
tible
> > > > > string that would use modes described in DT for the common case. =
Only
> > > > > if a panel required something more complex which can't (or which
> > > > > could, but won't for any reason) accurately be described in DT wo=
uld
> > > > > you need to extend the driver.
> > > >=20
> > > > I don't see the point quite frankly. You seem to be assuming that e=
very
> > > > panel will only be used in a single board.
> > >=20
> > > No, but in practice that's often the case, at least for boards with .=
dts
> > > files in the mainline kernel.
> > >=20
> > > > However what you're proposing will require the mode timings to be
> > > > repeated in every board's DT file, if the same panel is ever used on
> > > > more than a single board.
> > >=20
> > > Is that a problem ? You could #include a .dtsi for the panel that wou=
ld
> > > specify the video mode if you want to avoid multiple copies.
> >=20
> > Yes, I don't think it's desirable to duplicate data needlessly in DT. It
> > also makes the binding more difficult to use. If I know that the panel
> > is one supported by the simple-panel binding, I can just go and add the
> > right compatible value without having to bother looking up the mode
> > timings and duplicating them. That way DT writers get to concern
> > themselves only with the variable data.
>=20
> I've had a quick chat with Dave Airlie and Hans de Goede yesterday about =
this.=20
> As most panels will use standard timings, Hans proposed adding a timings=
=20
> property that would reference the standard timings the panel uses (this c=
ould=20
> be a string or integer defined in include/dt-bindings/...). In most case =
DT=20
> would just have a single property to select the timings, and only in more=
=20
> complex cases where the system designer wants to use custom timings would=
 the=20
> timings need to be manually defined.

We can do the same thing within the kernel. We already have a list of
standard EDID/HDMI/CEA display modes, so we could similarly add a new
list of common display panel modes and make each driver reference that
instead of defining a custom one.

And that still enables us to add a property that would allow DT writers
to override the display mode if they need to.

Thierry

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaQkHAAoJEN0jrNd/PrOh+/sQAJZX+ZuZU8zz7h7e7GGCBw9k
d2d1b1+M+bWq7I1MGWhBEnc5etamiYWpnjGwX1Qm1Y4fHGRYPVpy9pQhQmUTb6x/
IM4VWKeu3katp0LpBeryn6EjZYLD0HyChMFOglrXG9fh7GTiRNI5I4lEdrpD649d
9doVxPKGQHo8KMYiWx2m89dZ7CXGBNFGmb1PBMnbtoaN7Xm9+uKt96uTMZbiuMRu
WGOJkMUB/nJZ7x62hrDAabIVvr9owwSt/HFLBDB+7uic+1iJsk5+QGsP9ao8mmpI
k7tJbi6dG6i7EGeAhiQqqh5ISdOiwGhp8JvcMA67pipTPJl87GnMVOqyk9AS1kW0
uwhYRJkvj18EY+6X8TmBH5qe4KNgbCdGSdlEi5B+Gh60HC9zAPAmAe7xGGd3xJuZ
ISpM9srzcFY38o6Ywf1wM/aio6hKjYdm4mi0vWoy9aNyIfgZxoZtuyN9/y63hi3v
Zk2u8R0+873oSujGFjsqPmlrXH8zLE9vY5dCaxt0RF2jAV39ruJJcKPpMZcnJQ11
x3nrfbKwHl2AMw+smJL/k/4tTp4wiTZAL5OxwKCg5kN2I+2fvL4WyJIgzWi9Y1mI
VyBt5qdjNEiFw8PR0fn3S9yq9apZO+dynK9Nq9hegIdHc/66QlK2xVPX6EJOYZ5K
iK+sZxp0IXsBI/Zccy9z
=x1SG
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
