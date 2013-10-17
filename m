From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 12:14:45 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <1673630.A5yYaNBe3X@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1569423.FAQblVSIAT"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <12566222.aRYc4MDoOm@avalon> <20131017114139.GD10993@ulmo.nvidia.com>
In-Reply-To: <20131017114139.GD10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--nextPart1569423.FAQblVSIAT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 17 October 2013 13:41:40 Thierry Reding wrote:
> On Thu, Oct 17, 2013 at 01:02:38PM +0200, Laurent Pinchart wrote:
> > On Thursday 17 October 2013 10:53:43 Thierry Reding wrote:
> [...]
> 
> > CDF needs to model video pipelines that can be more complex than just a
> > display controller with a single output connected to a panel with a single
> > input. For that reason the DT bindings need to describe connections in a
> > generic enough way. The above DT fragment might be slightly more complex
> > than one would expect when thinking about the really simple case only,
> > but it's nowhere near overly complex in my opinion.
> > 
> > Please note that, when a device has as single port, the ports node can be
> > omitted, and the port doesn't need to be numbered. You would then end up
> > with> 
> >  	dc: display-controller {
> > 		port {
> > 			remote-endpoint = <&panel>;
> >  		};
> >  	};
> >  	
> >  	panel: panel {
> >  		port {
> >  			remote-endpoint = <&dc>;
> >  		};
> >  	};
> > 
> > I don't think there's a way to simplify it further.
> 
> That binding looks completely inconsistent to me. If we can write it either
> using a ports node with port@X subnodes, in my opinion we can equally well
> just use a unidirectional link for the case where we don't need the link
> back from the panel to the output. Where's the difference?
> 
> Consider for example the case where an LVDS panel is connected to a simple
> LVDS output. For what possible reason would the panel need to access the
> output?

The point is that the video pipeline must be described in DT. Having a per-
device way to represent connections would be a nightmare to support from an 
implementation point of view, hence the need for a generic way to describe 
them.

> > > > I also plan to specify video bus parameters in DT for CDF, but this
> > > > hasn't been finalized yet.
> > > 
> > > That effectively blocks any of the code that I've been working on until
> > > CDF has been merged. It's been discussed for over a year now, and there
> > > has even been significant pushback on using CDF in DRM, so even if CDF
> > > is eventually merged, that will still leave DRM with no way to turn on
> > > a simple panel.
> > 
> > I'm probably even more concerned about the long time all this took and
> > will still take than you are, sincerely. I'm obviously to blame for not
> > being able to explain the problems and solutions correctly, as I see no
> > way why people would push back if they realized that the other solutions
> > that have been proposed, far from being future-proof, won't even be
> > present-proof. We would be shooting ourselves in the foot, but what can I
> > do when too many people want to do so ?
> 
> I'm curious why you think this current proposal isn't present-proof. All
> three panels that I've tested with work with this proposal currently and
> I'm convinced that many more setups can be covered using something as
> simple as this.

My apologies for not being clear enough. I wasn't implying that your proposal 
isn't present-proof, I was talking about the counter-proposals that have been 
made in reaction to CDF.

> > I'll still keep trying of course, but not for years.I have yet to
> > see someone proposing a viable solution to share drivers between DRM and
> > V4L2, which is a real pressing requirement, partly due to DT.
> 
> Yeah... I still don't get that side of the argument. Why exactly do we need
> to share the drivers again?

Think about a scaler IP in a SoC or FPGA, with one instance used in a camera 
capture pipeline, supported by a V4L2 driver, and one instance used in a video 
output pipeline, supported by a DRM driver. We want a single driver for that 
IP core. Same story for video encoders.

> If we really need to support display output within V4L2, shouldn't we
> instead improve interoperability between the two and use DRM/KMS exclusively
> for the output part? Then the problem of having to share drivers between
> subsystems goes away and we'll actually be using the right subsystem for the
> right job at hand.

In the long term we definitely should improve interoperability between the 
two. I'd go further than that, having one API for video capture and one API 
for video output doesn't make much sense, except for historical reasons.

> Of course none of that is relevant to the topic of DT bindings, which is
> what we should probably be concentrating on.

It actually is. Given that DT bindings must describe hardware, the scaler (or 
encoder, or other entity) would use the same bindings regardless of the Linux 
subsystem that will be involved. We thus need to make sure the bindings will 
be usable on both sides.

> Nobody's been able to come up with a valid reason why the proposed binding
> is broken. It works for the tested devices (likely many more as well) and I
> don't forsee why it can't be future-proof. Why would it suddenly need to
> change? And even if it needed to change, why would the changes be backwards-
> incompatible rather than simply additional features that don't impact
> existing users?
> 
> > Regarding the use of CDF in DRM, please note that it will be optional for
> > drivers to switch to the new framework. Nothing should hopefully require
> > existing drivers to be converted, drivers that want to make use of CDF to
> > support panels will be welcome to do so, but they big DRM drivers for
> > desktop GPUs won't be affected.
> 
> I'm not at all opposed to the idea of CDF or the problems it tries to
> address. I don't think it necessarily should be a separate framework for
> reasons explained earlier. But even if it were to end up in a separate
> framework there's absolutely nothing preventing us from adding a DRM panel
> driver that hooks into CDF as a "backend" of sorts for panels that require
> something more complex than the simple-panel binding.

Once again it's not about panel having complex needs, but more about using 
simple panels in complex pipelines. I'm fine with the drm_panel 
infrastructure, what I would like is DT bindings that describe connections in 
a more future-proof way. The rest is fine.

> > > I keep wondering why we absolutely must have compatibility between CDF
> > > and this simple panel binding. DT content is supposed to concern itself
> > > with the description of hardware only. What about the following isn't an
> > > accurate description of the panel hardware?
> > > 
> > > 	panel: panel {
> > > 		compatible = "cptt,claa101wb01";
> > > 		
> > > 		power-supply = <&vdd_pnl_reg>;
> > > 		enable-gpios = <&gpio 90 0>;
> > > 		
> > > 		backlight = <&backlight>;
> > > 	};
> > > 	
> > > 	dsi-controller {
> > > 		panel = <&panel>;
> > > 	};
> > > 
> > > Note how the above is also not incompatible with anything that the CDF
> > > (to be) mandates, so it could easily be extended with any nodes or
> > > properties that CDF needs to work properly without breaking backwards-
> > > compatibility.
> > 
> > As mentioned above, CDF needs to describe more complex pipelines. To make
> > the driver life as simple as possible the core code will handle the
> > pipeline description in the DT bindings, and it does require it to be
> > generic enough. You can of course describe connections in various ways
> > depending on the hardware, which would make the DT-related code
> > needlessly overcomplex. One of the issue with the above description is
> > that there's no way to go from the panel to the display controller, which
> > might be a show stopper in the future when code requires that. A
> > workaround would be to look through the whole DT for the reverse link,
> > which would be pretty inefficient.
> 
> But that's precisely the point. Why would we need to go back from the panel
> to the display controller? Especially for dumb panels that can't or don't
> have to be configured in any way. Even if they needed some sort of setup,
> why can't that be done from the display controller/output.
> 
> Even given a setup where a DSI controller needs to write some registers in a
> panel upon initialization, I don't see why the reverse connection needs to
> be described. The fact alone that an output dereferences a panel's phandle
> should be enough to connect both of them and have any panel driver use the
> DSI controller that it's been attached to for the programming.
> 
> That's very much analogous to how I2C works. There are no connections back
> to the I2C master from the slaves. Yet each I2C client driver manages to use
> the services provided by the I2C master to perform transactions on the I2C
> bus. In a similar way the DSI controller is the bus master that talks to DSI
> panels. DSI panels don't actively talk to the DSI controller.

It's all about modeling video pipeline graphs in DT. To be able to walk the 
graph we need to describe connections. Not having bidirectional information 
means that we restrict the points at which we can start walking the graph, 
potentially making our life much more difficult in the future.

What's so wrong about adding a port node and link information to the panel DT 
node ? It describe what's there: the panel has one input, why not make that 
explicit ?

> > > > > +static void panel_simple_enable(struct drm_panel *panel)
> > > > > +{
> > > > > +	struct panel_simple *p = to_panel_simple(panel);
> > > > > +	int err;
> > > > > +
> > > > > +	if (p->enabled)
> > > > > +		return;
> > > > > +
> > > > > +	err = regulator_enable(p->supply);
> > > > > +	if (err < 0)
> > > > > +		dev_err(panel->dev, "failed to enable supply: %d\n", err);
> > > > 
> > > > Is that really a non-fatal error ? Shouldn't the enable operation
> > > > return an int ?
> > > 
> > > There's no way to propagate this in DRM, so why go through the trouble
> > > of returning the error? Furthermore, there's nothing that the caller
> > > could do to remedy the situation anyway.
> > 
> > That's a DRM issue, which could be fixed. While the caller can't remedy
> > the situation, it should at least report the error to the application
> > instead of silently ignoring it.
> 
> Perhaps. It's not really relevant to the discussion and can always be
> fixed in a subsequent patch.

Most things can be fixed by a subsequent patch, that's not a good enough 
reason not to address the known problems before pushing the code to mainline 
(to clarify my point of view, there's no need to fix DRM to use the return 
value before pushing this patch set to mainline, but I'd like a v2 with an int 
return value).

> > > > > +static const struct drm_display_mode auo_b101aw03_mode = {
> > > > > +	.clock = 51450,
> > > > > +	.hdisplay = 1024,
> > > > > +	.hsync_start = 1024 + 156,
> > > > > +	.hsync_end = 1024 + 156 + 8,
> > > > > +	.htotal = 1024 + 156 + 8 + 156,
> > > > > +	.vdisplay = 600,
> > > > > +	.vsync_start = 600 + 16,
> > > > > +	.vsync_end = 600 + 16 + 6,
> > > > > +	.vtotal = 600 + 16 + 6 + 16,
> > > > > +	.vrefresh = 60,
> > > > > +};
> > > > 
> > > > Instead of hardcoding the modes in the driver, which would then
> > > > require to be updated for every new simple panel model (and we know
> > > > there are lots of them), why don't you specify the modes in the panel
> > > > DT node ? The simple panel driver would then become much more generic.
> > > > It would also allow board designers to tweak h/v sync timings
> > > > depending on the system requirements.
> > > 
> > > Sigh... we keep second-guessing ourselves. Back at the time when power
> > > sequences were designed (and NAKed at the last minute), we all decided
> > > that the right thing to do would be to use specific compatible values
> > > for individual panels, because that would allow us to encode the power
> > > sequencing within the driver. And when we already have the panel model
> > > encoded in the compatible value, we might just as well encode the mode
> > > within the driver for that panel. Otherwise we'll have to keep adding
> > > the same mode timings for every board that uses the same panel.
> > > 
> > > I do agree though that it might be useful to tweak the mode in case the
> > > default one doesn't work. How about we provide a means to override the
> > > mode encoded in the driver using one specified in the DT? That's
> > > obviously a backwards-compatible change, so it could be added if or when
> > > it becomes necessary.
> > 
> > I share Tomi's point of view here. Your three panels use the same power
> > sequence, so I believe we should have a generic panel compatible string
> > that would use modes described in DT for the common case. Only if a panel
> > required something more complex which can't (or which could, but won't
> > for any reason) accurately be described in DT would you need to extend
> > the driver.
>
> I don't see the point quite frankly. You seem to be assuming that every
> panel will only be used in a single board.

No, but in practice that's often the case, at least for boards with .dts files 
in the mainline kernel.

> However what you're proposing will require the mode timings to be repeated
> in every board's DT file, if the same panel is ever used on more than a
> single board.

Is that a problem ? You could #include a .dtsi for the panel that would 
specify the video mode if you want to avoid multiple copies.

-- 
Regards,

Laurent Pinchart

--nextPart1569423.FAQblVSIAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX9S2AAoJEIkPb2GL7hl1WcoIAKp7D5gRYCMVqFrBP0AeN66G
KyuJW0qSwKskp0gdu1CQ6U/CHRSpN4hizfYsXu346Bluya9Pz+SsrkZcppBA7Y6I
vwcIKNDd5Y8ZwAyrXjmP1tjtw5eksekS8pg5rb2mtoIliIcmFVrunUZH7/yepisu
0E64yT6ByDXmHPwO5DAxBSmI4+fhQVmswNWmQQaHF//bR4Osw+RuJdaFNFsiO3nY
1olitrB6UBv/ZCTUyIl8EeGmFHeYaRq7AXihdEKJs6d/PM4QwGZE4ih0mNX0C+yd
8a4goMRbHJ9I7BQlUTEgHzEOZ/hksm3LOZcjI02+cwzj5sXQGQ+Na1mn3c7T0m8=
=17CP
-----END PGP SIGNATURE-----

--nextPart1569423.FAQblVSIAT--

