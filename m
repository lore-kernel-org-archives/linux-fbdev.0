From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 11:02:38 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <12566222.aRYc4MDoOm@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart40649803.OsYv5HB4Pu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <1695169.rzbDl9PeRX@avalon> <20131017085342.GB2502@ulmo.nvidia.com>
In-Reply-To: <20131017085342.GB2502-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--nextPart40649803.OsYv5HB4Pu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Thursday 17 October 2013 10:53:43 Thierry Reding wrote:
> Adding the dri-devel mailing list on Cc, since this discussion is
> outgrowing its original intent.
> 
> On Thu, Oct 17, 2013 at 02:47:52AM +0200, Laurent Pinchart wrote:
> > Hi Thierry,
> > 
> > Thank you for the patch.
> > 
> > On Wednesday 16 October 2013 20:25:12 Thierry Reding wrote:
> > > Add a driver for simple panels. Such panels can have a regulator that
> > > provides the supply voltage and a separate GPIO to enable the panel.
> > > Optionally the panels can have a backlight associated with them so it
> > > can be enabled or disabled according to the panel's power management
> > > mode.
> > > 
> > > Support is added for three panels: An AU Optronics 10.1" WSVGA, a
> > > Chunghwa Picture Tubes 10.1" WXGA and a Panasonic 10.1 WUXGA TFT LCD
> > > panel.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > > 
> > >  .../devicetree/bindings/panel/auo,b101aw03.txt     |   7 +
> > >  .../bindings/panel/chunghwa,claa101wb03.txt        |   7 +
> > >  .../bindings/panel/panasonic,vvx10f004b00.txt      |   7 +
> > >  .../devicetree/bindings/panel/simple-panel.txt     |  21 ++
> > >  drivers/gpu/drm/Makefile                           |   1 +
> > >  drivers/gpu/drm/panel/Kconfig                      |  13 +
> > >  drivers/gpu/drm/panel/Makefile                     |   1 +
> > >  drivers/gpu/drm/panel/panel-simple.c               | 335 ++++++++++++++
> > >  8 files changed, 392 insertions(+)
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/panel/auo,b101aw03.txt
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/panel/chunghwa,claa101wb03.txt
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/panel/panasonic,vvx10f004b00.txt
> > >  create mode 100644
> > >  Documentation/devicetree/bindings/panel/simple-panel.txt
> > >  create mode 100644 drivers/gpu/drm/panel/Makefile
> > >  create mode 100644 drivers/gpu/drm/panel/panel-simple.c

[snip]

> > > diff --git a/Documentation/devicetree/bindings/panel/simple-panel.txt
> > > b/Documentation/devicetree/bindings/panel/simple-panel.txt new file mode
> > > 100644
> > > index 0000000..1341bbf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/panel/simple-panel.txt
> > > @@ -0,0 +1,21 @@
> > > +Simple display panel
> > > +
> > > +Required properties:
> > > +- power-supply: regulator to provide the supply voltage
> > > +
> > > +Optional properties:
> > > +- ddc-i2c-bus: phandle of an I2C controller used for DDC EDID probing
> > > +- enable-gpios: GPIO pin to enable or disable the panel
> > > +- backlight: phandle of the backlight device attached to the panel
> > > +
> > > +Example:
> > > +
> > > +	panel: panel {
> > > +		compatible = "cptt,claa101wb01";
> > > +		ddc-i2c-bus = <&panelddc>;
> > > +
> > > +		power-supply = <&vdd_pnl_reg>;
> > > +		enable-gpios = <&gpio 90 0>;
> > > +
> > > +		backlight = <&backlight>;
> > > +	};
> > 
> > My biggest concern here is that this will not be compatible with the CDF
> > DT bindings. They're not complete yet, but they will require connections
> > between entities to be described in DT, in a way very similar (or
> > actually identical) to the V4L2 DT bindings, documented in
> > Documentation/devicetree/bindings/media/video-interfaces.txt. Could you
> > have a look at that ? Please ignore all optional properties beside
> > remote-endpoint, as they're V4L2 specific.
> 
> Okay, so if I understand correctly, translating those bindings to panel
> nodes would look somewhat like this:
> 
> 	dc: display-controller {
> 		ports {
> 			port@0 {
> 				remote-endpoint = <&panel>;
> 			};
> 		};
> 	};
> 
> 	panel: panel {
> 		ports {
> 			port@0 {
> 				remote-endpoint = <&dc>;
> 			};
> 		};
> 	};
> 
> The above leaves out any of the other, non-relevant properties. Does
> that sound about right?

Yes it does.

> That seems like an overly complex amount of data to describe just a simple
> panel where the only connection between it and the display hardware is the
> data bus and I was sort of expecting the CDF to provide some sort of
> shortcut for setups where the connection is 1:1 with no means to perform any
> configuration of the bus.

CDF needs to model video pipelines that can be more complex than just a 
display controller with a single output connected to a panel with a single 
input. For that reason the DT bindings need to describe connections in a 
generic enough way. The above DT fragment might be slightly more complex than 
one would expect when thinking about the really simple case only, but it's 
nowhere near overly complex in my opinion.

Please note that, when a device has as single port, the ports node can be 
omitted, and the port doesn't need to be numbered. You would then end up with

 	dc: display-controller {
		port {
			remote-endpoint = <&panel>;
 		};
 	};
 
 	panel: panel {
 		port {
 			remote-endpoint = <&dc>;
 		};
 	};

I don't think there's a way to simplify it further.

> > I also plan to specify video bus parameters in DT for CDF, but this hasn't
> > been finalized yet.
> 
> That effectively blocks any of the code that I've been working on until
> CDF has been merged. It's been discussed for over a year now, and there
> has even been significant pushback on using CDF in DRM, so even if CDF
> is eventually merged, that will still leave DRM with no way to turn on
> a simple panel.

I'm probably even more concerned about the long time all this took and will 
still take than you are, sincerely. I'm obviously to blame for not being able 
to explain the problems and solutions correctly, as I see no way why people 
would push back if they realized that the other solutions that have been 
proposed, far from being future-proof, won't even be present-proof. We would 
be shooting ourselves in the foot, but what can I do when too many people want 
to do so ? I'll still keep trying of course, but not for years.I have yet to 
see someone proposing a viable solution to share drivers between DRM and V4L2, 
which is a real pressing requirement, partly due to DT.

Regarding the use of CDF in DRM, please note that it will be optional for 
drivers to switch to the new framework. Nothing should hopefully require 
existing drivers to be converted, drivers that want to make use of CDF to 
support panels will be welcome to do so, but they big DRM drivers for desktop 
GPUs won't be affected.

> I keep wondering why we absolutely must have compatibility between CDF
> and this simple panel binding. DT content is supposed to concern itself
> with the description of hardware only. What about the following isn't an
> accurate description of the panel hardware?
> 
> 	panel: panel {
> 		compatible = "cptt,claa101wb01";
> 
> 		power-supply = <&vdd_pnl_reg>;
> 		enable-gpios = <&gpio 90 0>;
> 
> 		backlight = <&backlight>;
> 	};
> 
> 	dsi-controller {
> 		panel = <&panel>;
> 	};
> 
> Note how the above is also not incompatible with anything that the CDF
> (to be) mandates, so it could easily be extended with any nodes or
> properties that CDF needs to work properly without breaking backwards-
> compatibility.

As mentioned above, CDF needs to describe more complex pipelines. To make the 
driver life as simple as possible the core code will handle the pipeline 
description in the DT bindings, and it does require it to be generic enough. 
You can of course describe connections in various ways depending on the 
hardware, which would make the DT-related code needlessly overcomplex. One of 
the issue with the above description is that there's no way to go from the 
panel to the display controller, which might be a show stopper in the future 
when code requires that. A workaround would be to look through the whole DT 
for the reverse link, which would be pretty inefficient.

> > > diff --git a/drivers/gpu/drm/panel/panel-simple.c

[...]

> > > +static void panel_simple_enable(struct drm_panel *panel)
> > > +{
> > > +	struct panel_simple *p = to_panel_simple(panel);
> > > +	int err;
> > > +
> > > +	if (p->enabled)
> > > +		return;
> > > +
> > > +	err = regulator_enable(p->supply);
> > > +	if (err < 0)
> > > +		dev_err(panel->dev, "failed to enable supply: %d\n", err);
> > 
> > Is that really a non-fatal error ? Shouldn't the enable operation return
> > an int ?
> 
> There's no way to propagate this in DRM, so why go through the trouble
> of returning the error? Furthermore, there's nothing that the caller
> could do to remedy the situation anyway.

That's a DRM issue, which could be fixed. While the caller can't remedy the 
situation, it should at least report the error to the application instead of 
silently ignoring it.

> > > +static const struct drm_display_mode auo_b101aw03_mode = {
> > > +	.clock = 51450,
> > > +	.hdisplay = 1024,
> > > +	.hsync_start = 1024 + 156,
> > > +	.hsync_end = 1024 + 156 + 8,
> > > +	.htotal = 1024 + 156 + 8 + 156,
> > > +	.vdisplay = 600,
> > > +	.vsync_start = 600 + 16,
> > > +	.vsync_end = 600 + 16 + 6,
> > > +	.vtotal = 600 + 16 + 6 + 16,
> > > +	.vrefresh = 60,
> > > +};
> > 
> > Instead of hardcoding the modes in the driver, which would then require to
> > be updated for every new simple panel model (and we know there are lots
> > of them), why don't you specify the modes in the panel DT node ? The
> > simple panel driver would then become much more generic. It would also
> > allow board designers to tweak h/v sync timings depending on the system
> > requirements.
> 
> Sigh... we keep second-guessing ourselves. Back at the time when power
> sequences were designed (and NAKed at the last minute), we all decided
> that the right thing to do would be to use specific compatible values
> for individual panels, because that would allow us to encode the power
> sequencing within the driver. And when we already have the panel model
> encoded in the compatible value, we might just as well encode the mode
> within the driver for that panel. Otherwise we'll have to keep adding
> the same mode timings for every board that uses the same panel.
> 
> I do agree though that it might be useful to tweak the mode in case the
> default one doesn't work. How about we provide a means to override the
> mode encoded in the driver using one specified in the DT? That's
> obviously a backwards-compatible change, so it could be added if or when
> it becomes necessary.

I share Tomi's point of view here. Your three panels use the same power 
sequence, so I believe we should have a generic panel compatible string that 
would use modes described in DT for the common case. Only if a panel required 
something more complex which can't (or which could, but won't for any reason) 
accurately be described in DT would you need to extend the driver.

-- 
Regards,

Laurent Pinchart

--nextPart40649803.OsYv5HB4Pu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX8PXAAoJEIkPb2GL7hl1WAAH/0TT3DhaxK0mxkONpTA1KUhq
26H4+pmwuSpYk+TlrzUPr+fyw7gnQ2Au8XD+h1HbowWjX4XAKamN7f/2OL2BHB/b
v1LUqk4G+Vlzz0aSbOHSFpJ4/Y+8TEV5NlCmIVWU2Cx/14IUVkxJz5qN6lzNATP1
GECTuxUT1IUcRO/cV48CmZXXKFJYVEQffWaYfBhAln3yREwWL7lmSoerXCidEWPq
VM/LV4+SVv+EHX0pHgdv+XKCMZLqd3loQwg0V0CjdOfi4UcHpzCafagSK+gxUFVT
V+GAJ6hUCmVwlbTKk0kXZ+b7KyY2ymS1G0inFrYHLnE4iaiqI8D48U8KnSn9OlE=
=wKd5
-----END PGP SIGNATURE-----

--nextPart40649803.OsYv5HB4Pu--

