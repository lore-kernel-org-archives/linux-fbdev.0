From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 11:15:22 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <3610893.n6xJ6DUJ0E@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5257301.klqVcaqZYS"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <525FBA5D.9000001@ti.com> <20131017110517.GC10993@ulmo.nvidia.com>
In-Reply-To: <20131017110517.GC10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--nextPart5257301.klqVcaqZYS
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Thursday 17 October 2013 13:05:18 Thierry Reding wrote:
> On Thu, Oct 17, 2013 at 01:22:21PM +0300, Tomi Valkeinen wrote:
> > On 17/10/13 11:53, Thierry Reding wrote:
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
> > 
> > That's quite similar to how my current out-of-mainline OMAP DSS DT
> > bindings work. The difference is that I have a reference from the panel
> > node to the video source (dsi-controller), instead of the other way
> > around. I just find it more natural. It works the same way as, say,
> > regulators, gpios, etc.
> 
> I suppose that depends on the way you look at it. In the above proposal
> I consider the output (DSI controller) to use the panel as a resource
> that provides a certain set of services (query mode timings, provide a
> way to enable or disable the panel). Similarly the panel uses the
> backlight as a resource that provides a certain set of services (such as
> changing the brightness).
> 
> The above also follows the natural order of control. The panel has no
> way to control the DSI output. However, it is the output that controls
> when a panel is required and turn it on as appropriate.

I'm no DSI expert, but I know enough about it to be sure that Tomi will 
disagree. DSI panels can have complex power sequences that require the input 
stream to be finely controlled (for instance it might require a clock without 
video frames for some time, switch a GPIO or regulator, send a command to the 
panel, and then only get video frames). For that reason all developers I've 
talked to who have an in-depth knowledge of DSI and DSI panels told me that 
the panel needs to control the video bus, and request the video source to 
start/stop the video stream.

> > However, one thing unclear is where the panel node should be. You seem
> > to have a DSI panel here. If the panel is truly not controlled in any
> > way, maybe having the panel as a normal platform device is ok. But if
> > the DSI panel is controlled with DSI messages, should it be a child of
> > the dsi-controller node, the same way i2c peripherals are children of
> > i2c master?
> 
> That's one possibility. In this particular case it's not even necessary
> to use any of DSIs control methods to talk to the panel. The panel only
> receives the data stream and "just works".
> 
> Even if the panel were to be controlled via DSI, I think keeping it as
> a separate device node is equally valid. It's really boils down to what
> I already said above. The output uses the panel as a resource, similar
> to how other devices might use a GPIO controller to use a GPIO pin, or
> an interrupt controller to request an IRQ.

Except that the display controller can also provides resources to the panel. 
For DSI panels that support DSI commands, the control bus is provided by the 
display controller. Much like an I2C device must be a child of its I2C 
controller node, the DSI panel device should then be a child of the display 
controller node.

> > >>> +static const struct drm_display_mode auo_b101aw03_mode = {
> > >>> +	.clock = 51450,
> > >>> +	.hdisplay = 1024,
> > >>> +	.hsync_start = 1024 + 156,
> > >>> +	.hsync_end = 1024 + 156 + 8,
> > >>> +	.htotal = 1024 + 156 + 8 + 156,
> > >>> +	.vdisplay = 600,
> > >>> +	.vsync_start = 600 + 16,
> > >>> +	.vsync_end = 600 + 16 + 6,
> > >>> +	.vtotal = 600 + 16 + 6 + 16,
> > >>> +	.vrefresh = 60,
> > >>> +};
> > >> 
> > >> Instead of hardcoding the modes in the driver, which would then require
> > >> to be updated for every new simple panel model (and we know there are
> > >> lots of them), why don't you specify the modes in the panel DT node ?
> > >> The simple panel driver would then become much more generic. It would
> > >> also allow board designers to tweak h/v sync timings depending on the
> > >> system requirements.
> > > 
> > > Sigh... we keep second-guessing ourselves. Back at the time when power
> > > sequences were designed (and NAKed at the last minute), we all decided
> > > that the right thing to do would be to use specific compatible values
> > > for individual panels, because that would allow us to encode the power
> > > sequencing within the driver. And when we already have the panel model
> > > encoded in the compatible value, we might just as well encode the mode
> > > within the driver for that panel. Otherwise we'll have to keep adding
> > > the same mode timings for every board that uses the same panel.
> > 
> > Oh, I didn't feel "we all decided that the right thing..." =).
> > 
> > > I do agree though that it might be useful to tweak the mode in case the
> > > default one doesn't work. How about we provide a means to override the
> > > mode encoded in the driver using one specified in the DT? That's
> > > obviously a backwards-compatible change, so it could be added if or when
> > > it becomes necessary.
> > 
> > This sounds good to me.
> > 
> > Although maybe it'd be good to have the driver compatible with something
> > like "generic-panel", so that you could have:
> > 
> > compatible = "foo,specific-panel", "generic-panel";
> > 
> > and if there's no need for any power/gpio setup for your board, you may
> > skip adding "foo,specific-panel" support to the panel driver. Later,
> > somebody else may need to implement fine grained power/gpio support for
> > "foo,specific-panel", and it would just work.
> > 
> > Maybe that would help us with the problem of adding support in the
> > driver for a hundred different simple panels each used only once on a
> > specific board.
> 
> Sure, that all sounds like reasonable additions. All of the suggestions
> are even backwards-compatible and hence can be added when needed without
> breaking compatibility with existing users of the binding.

What's wrong with moving the three hardcoded modes we already have in the 
driver to DT before pushing this to mainline ?

-- 
Regards,

Laurent Pinchart

--nextPart5257301.klqVcaqZYS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX8bKAAoJEIkPb2GL7hl1s+AH/2cY0Vvx+flndPCunCIqRrK3
iuyJDpT8BFn82XL0HLUYUONG3oNI5bE254dRNDYSZMGHjmseWFSvBZ6Z/iD80DMU
hQXvFF6P/oPAnhcDhxeO/ntL2PNEAaQYCJewxKhTua7a7Wxbx0lwXx2WkpSF3Lq6
OggXAFyzGLHvwRQK3d9j7tU/obSFA8A6bAIh+jqbAMfZwG9AH2TVAs5K36fWJonc
gRC5yxUkTPCXBz4A7L8T7ry4xUKsEPdLEbbrhZ3AlAs8apRQG3KzeAn5FKj1tWGw
p5u++wNSSxMbq+RMUy+QkvC4dgATapRakp4sT+RXwQRem5rfPEEPP9rYkTHDg4o=
=T9/q
-----END PGP SIGNATURE-----

--nextPart5257301.klqVcaqZYS--

