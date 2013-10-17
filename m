From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Oct 2013 12:46:20 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <20131017124619.GG10993@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XRI2XbIfl/05pQwm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com>
 <12566222.aRYc4MDoOm@avalon>
 <20131017114139.GD10993@ulmo.nvidia.com>
 <1673630.A5yYaNBe3X@avalon>
In-Reply-To: <1673630.A5yYaNBe3X@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2013 at 02:14:45PM +0200, Laurent Pinchart wrote:
> On Thursday 17 October 2013 13:41:40 Thierry Reding wrote:
> > On Thu, Oct 17, 2013 at 01:02:38PM +0200, Laurent Pinchart wrote:
> > > On Thursday 17 October 2013 10:53:43 Thierry Reding wrote:
> > [...]
> >=20
> > > CDF needs to model video pipelines that can be more complex than just=
 a
> > > display controller with a single output connected to a panel with a s=
ingle
> > > input. For that reason the DT bindings need to describe connections i=
n a
> > > generic enough way. The above DT fragment might be slightly more comp=
lex
> > > than one would expect when thinking about the really simple case only,
> > > but it's nowhere near overly complex in my opinion.
> > >=20
> > > Please note that, when a device has as single port, the ports node ca=
n be
> > > omitted, and the port doesn't need to be numbered. You would then end=
 up
> > > with>=20
> > >  	dc: display-controller {
> > > 		port {
> > > 			remote-endpoint =3D <&panel>;
> > >  		};
> > >  	};
> > >  =09
> > >  	panel: panel {
> > >  		port {
> > >  			remote-endpoint =3D <&dc>;
> > >  		};
> > >  	};
> > >=20
> > > I don't think there's a way to simplify it further.
> >=20
> > That binding looks completely inconsistent to me. If we can write it ei=
ther
> > using a ports node with port@X subnodes, in my opinion we can equally w=
ell
> > just use a unidirectional link for the case where we don't need the link
> > back from the panel to the output. Where's the difference?
> >=20
> > Consider for example the case where an LVDS panel is connected to a sim=
ple
> > LVDS output. For what possible reason would the panel need to access the
> > output?
>=20
> The point is that the video pipeline must be described in DT. Having a pe=
r-
> device way to represent connections would be a nightmare to support from =
an=20
> implementation point of view, hence the need for a generic way to describ=
e=20
> them.

Okay, so we're back to the need to describe pipelines in DT. At the risk
of sounding selfish: I don't care about pipelines. I just want us to
settle on a way to represent a dumb panel in DT so that it can be
enabled when it needs to. Furthermore I don't have any hardware that
exhibits any of these "advanced" features, so I'm totally unqualified to
work on any of this.

Can we please try to be a little pragmatic here and solve one problem at
a time? I am aware that solving this for panels may require some amount
of foresight, but let's not try to solve everything at once at the risk
of not getting anything done at all.

> > > I'll still keep trying of course, but not for years.I have yet to
> > > see someone proposing a viable solution to share drivers between DRM =
and
> > > V4L2, which is a real pressing requirement, partly due to DT.
> >=20
> > Yeah... I still don't get that side of the argument. Why exactly do we =
need
> > to share the drivers again?
>=20
> Think about a scaler IP in a SoC or FPGA, with one instance used in a cam=
era=20
> capture pipeline, supported by a V4L2 driver, and one instance used in a =
video=20
> output pipeline, supported by a DRM driver. We want a single driver for t=
hat=20
> IP core. Same story for video encoders.

Yes, I see. This doesn't immediately concern the simple panel problem
that I'm trying to solve, so perhaps we can have a separate discussion
about it. Perhaps this would more easily be solved by providing some
sort of helper library for the lower level control of the device and
wrapping that with V4L2 or DRM APIs.

> > If we really need to support display output within V4L2, shouldn't we
> > instead improve interoperability between the two and use DRM/KMS exclus=
ively
> > for the output part? Then the problem of having to share drivers between
> > subsystems goes away and we'll actually be using the right subsystem fo=
r the
> > right job at hand.
>=20
> In the long term we definitely should improve interoperability between th=
e=20
> two. I'd go further than that, having one API for video capture and one A=
PI=20
> for video output doesn't make much sense, except for historical reasons.

Having two separate subsystems has worked out pretty well so far. In my
opinion having strong boundaries between subsystems helps with design.

> > Of course none of that is relevant to the topic of DT bindings, which is
> > what we should probably be concentrating on.
>=20
> It actually is. Given that DT bindings must describe hardware, the scaler=
 (or=20
> encoder, or other entity) would use the same bindings regardless of the L=
inux=20
> subsystem that will be involved. We thus need to make sure the bindings w=
ill=20
> be usable on both sides.

Perhaps a single driver could expose both interfaces?

> > I'm not at all opposed to the idea of CDF or the problems it tries to
> > address. I don't think it necessarily should be a separate framework for
> > reasons explained earlier. But even if it were to end up in a separate
> > framework there's absolutely nothing preventing us from adding a DRM pa=
nel
> > driver that hooks into CDF as a "backend" of sorts for panels that requ=
ire
> > something more complex than the simple-panel binding.
>=20
> Once again it's not about panel having complex needs, but more about usin=
g=20
> simple panels in complex pipelines. I'm fine with the drm_panel=20
> infrastructure, what I would like is DT bindings that describe connection=
s in=20
> a more future-proof way. The rest is fine.

And I've already said elsewhere that the bindings in their current form
are easily extensible to cater for the needs of CDF.

> > But that's precisely the point. Why would we need to go back from the p=
anel
> > to the display controller? Especially for dumb panels that can't or don=
't
> > have to be configured in any way. Even if they needed some sort of setu=
p,
> > why can't that be done from the display controller/output.
> >=20
> > Even given a setup where a DSI controller needs to write some registers=
 in a
> > panel upon initialization, I don't see why the reverse connection needs=
 to
> > be described. The fact alone that an output dereferences a panel's phan=
dle
> > should be enough to connect both of them and have any panel driver use =
the
> > DSI controller that it's been attached to for the programming.
> >=20
> > That's very much analogous to how I2C works. There are no connections b=
ack
> > to the I2C master from the slaves. Yet each I2C client driver manages t=
o use
> > the services provided by the I2C master to perform transactions on the =
I2C
> > bus. In a similar way the DSI controller is the bus master that talks t=
o DSI
> > panels. DSI panels don't actively talk to the DSI controller.
>=20
> It's all about modeling video pipeline graphs in DT. To be able to walk t=
he=20
> graph we need to describe connections. Not having bidirectional informati=
on=20
> means that we restrict the points at which we can start walking the graph=
,=20
> potentially making our life much more difficult in the future.
>=20
> What's so wrong about adding a port node and link information to the pane=
l DT=20
> node ? It describe what's there: the panel has one input, why not make th=
at=20
> explicit ?

What's wrong with it is that there's no way to verify the soundness of
the design by means of a full implementation because we're missing the
majority of the pieces. Just putting the nodes into DT to provide some
imaginary future-proofness isn't helpful either. Without any code that
actually uses them they are useless.

And again, why should we add them right away (while not needed) when
they can easily be added in a backwards-compatible manner at some later
point when there's actually any use for them and they can actually be
tested in some larger framework?

> > > > > > +static void panel_simple_enable(struct drm_panel *panel)
> > > > > > +{
> > > > > > +	struct panel_simple *p =3D to_panel_simple(panel);
> > > > > > +	int err;
> > > > > > +
> > > > > > +	if (p->enabled)
> > > > > > +		return;
> > > > > > +
> > > > > > +	err =3D regulator_enable(p->supply);
> > > > > > +	if (err < 0)
> > > > > > +		dev_err(panel->dev, "failed to enable supply: %d\n", err);
> > > > >=20
> > > > > Is that really a non-fatal error ? Shouldn't the enable operation
> > > > > return an int ?
> > > >=20
> > > > There's no way to propagate this in DRM, so why go through the trou=
ble
> > > > of returning the error? Furthermore, there's nothing that the caller
> > > > could do to remedy the situation anyway.
> > >=20
> > > That's a DRM issue, which could be fixed. While the caller can't reme=
dy
> > > the situation, it should at least report the error to the application
> > > instead of silently ignoring it.
> >=20
> > Perhaps. It's not really relevant to the discussion and can always be
> > fixed in a subsequent patch.
>=20
> Most things can be fixed by a subsequent patch, that's not a good enough=
=20
> reason not to address the known problems before pushing the code to mainl=
ine=20
> (to clarify my point of view, there's no need to fix DRM to use the retur=
n=20
> value before pushing this patch set to mainline, but I'd like a v2 with a=
n int=20
> return value).

Why? What's the use of returning an error if you know up front that it
can't be used? This should be changed if or when we "fix" DRM to
propagate errors.

> > > > > Instead of hardcoding the modes in the driver, which would then
> > > > > require to be updated for every new simple panel model (and we kn=
ow
> > > > > there are lots of them), why don't you specify the modes in the p=
anel
> > > > > DT node ? The simple panel driver would then become much more gen=
eric.
> > > > > It would also allow board designers to tweak h/v sync timings
> > > > > depending on the system requirements.
> > > >=20
> > > > Sigh... we keep second-guessing ourselves. Back at the time when po=
wer
> > > > sequences were designed (and NAKed at the last minute), we all deci=
ded
> > > > that the right thing to do would be to use specific compatible valu=
es
> > > > for individual panels, because that would allow us to encode the po=
wer
> > > > sequencing within the driver. And when we already have the panel mo=
del
> > > > encoded in the compatible value, we might just as well encode the m=
ode
> > > > within the driver for that panel. Otherwise we'll have to keep addi=
ng
> > > > the same mode timings for every board that uses the same panel.
> > > >=20
> > > > I do agree though that it might be useful to tweak the mode in case=
 the
> > > > default one doesn't work. How about we provide a means to override =
the
> > > > mode encoded in the driver using one specified in the DT? That's
> > > > obviously a backwards-compatible change, so it could be added if or=
 when
> > > > it becomes necessary.
> > >=20
> > > I share Tomi's point of view here. Your three panels use the same pow=
er
> > > sequence, so I believe we should have a generic panel compatible stri=
ng
> > > that would use modes described in DT for the common case. Only if a p=
anel
> > > required something more complex which can't (or which could, but won't
> > > for any reason) accurately be described in DT would you need to extend
> > > the driver.
> >
> > I don't see the point quite frankly. You seem to be assuming that every
> > panel will only be used in a single board.
>=20
> No, but in practice that's often the case, at least for boards with .dts =
files=20
> in the mainline kernel.
>=20
> > However what you're proposing will require the mode timings to be repea=
ted
> > in every board's DT file, if the same panel is ever used on more than a
> > single board.
>=20
> Is that a problem ? You could #include a .dtsi for the panel that would=
=20
> specify the video mode if you want to avoid multiple copies.

Yes, I don't think it's desirable to duplicate data needlessly in DT. It
also makes the binding more difficult to use. If I know that the panel
is one supported by the simple-panel binding, I can just go and add the
right compatible value without having to bother looking up the mode
timings and duplicating them. That way DT writers get to concern
themselves only with the variable data.

Thierry

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSX9wbAAoJEN0jrNd/PrOh3w8QAJ4F01hOr0yStgmNbrVDroYg
sX+XCHonAtIMUMRRlY0aWOcW5o5XTRC8WUgDBPQw3tS4nsSYREnvYbqE6oc9Ups7
4ccQ3m3kZ/xgwc3LvdDQgk2YaFyQhZ4U3ZE57BI+RIsdP7K0+o0RsnSr6swMtwmN
fOXV5gOYKajcwKV6qOtRCUcz9YdU84MRLzKjao8tbDQM5p18aphEyg0T5CCSnKE/
EMmXPv9wyT/CGBcJnAGlosms7RqfMJO974J0Z8gUWoEvXwIqXkwCkBKgrTg2592P
zjSSJ+dRZ1jH4VKtgTWxAKOj782Abz38AHR/9XSN2vhgfpSc3wI5h5A+cyAHFLxZ
Ub/06hUHX6iZlpTTXHHOpjURfNVbdJC6vk/bewt6CY/L2J5F+oOifrI/nlOYT1hf
s18bj34RwJD6jAh3+9uDgS96W6/CiKoQ7gZPGzXWKW8h1APQCxphXYOGttWYON0l
rHbBMhk/q+5MaSzKJM+GzQ3GYVc4q5zMjbDOsrvYLSHns93ZJIEku44dmPYciAUT
tY7wKKIuwbUT1rGqUczNSX78vh7boEphljM8TKlQFT1TDJnA3Wxx4D5P3XQCxTAe
CWae5lWYO21xh28C/VOymCAaTInz6siS8aQH7gnIV2EE+OdglzUp1/ljvSgW3MLA
GSXlnSw2jKJDthpIVBpc
=zUt8
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--
