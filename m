From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 17 Oct 2013 12:23:32 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <2414405.blLIekLlE8@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6199881.OepGi8V11t"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <3610893.n6xJ6DUJ0E@avalon> <20131017120646.GE10993@ulmo.nvidia.com>
In-Reply-To: <20131017120646.GE10993-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>


--nextPart6199881.OepGi8V11t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Thursday 17 October 2013 14:06:47 Thierry Reding wrote:
> On Thu, Oct 17, 2013 at 01:15:22PM +0200, Laurent Pinchart wrote:
> > On Thursday 17 October 2013 13:05:18 Thierry Reding wrote:
> > > On Thu, Oct 17, 2013 at 01:22:21PM +0300, Tomi Valkeinen wrote:
> > > > On 17/10/13 11:53, Thierry Reding wrote:
> > > > > I keep wondering why we absolutely must have compatibility between
> > > > > CDF and this simple panel binding. DT content is supposed to concern
> > > > > itself with the description of hardware only. What about the
> > > > > following isn't an accurate description of the panel hardware?
> > > > > 
> > > > > 	panel: panel {
> > > > > 		compatible = "cptt,claa101wb01";
> > > > > 		
> > > > > 		power-supply = <&vdd_pnl_reg>;
> > > > > 		enable-gpios = <&gpio 90 0>;
> > > > > 		
> > > > > 		backlight = <&backlight>;
> > > > > 	};
> > > > > 	
> > > > > 	dsi-controller {
> > > > > 		panel = <&panel>;
> > > > > 	};
> > > > 
> > > > That's quite similar to how my current out-of-mainline OMAP DSS DT
> > > > bindings work. The difference is that I have a reference from the
> > > > panel node to the video source (dsi-controller), instead of the other
> > > > way around. I just find it more natural. It works the same way as,
> > > > say, regulators, gpios, etc.
> > > 
> > > I suppose that depends on the way you look at it. In the above proposal
> > > I consider the output (DSI controller) to use the panel as a resource
> > > that provides a certain set of services (query mode timings, provide a
> > > way to enable or disable the panel). Similarly the panel uses the
> > > backlight as a resource that provides a certain set of services (such as
> > > changing the brightness).
> > > 
> > > The above also follows the natural order of control. The panel has no
> > > way to control the DSI output. However, it is the output that controls
> > > when a panel is required and turn it on as appropriate.
> > 
> > I'm no DSI expert, but I know enough about it to be sure that Tomi will
> > disagree. DSI panels can have complex power sequences that require the
> > input stream to be finely controlled (for instance it might require a
> > clock without video frames for some time, switch a GPIO or regulator,
> > send a command to the panel, and then only get video frames). For that
> > reason all developers I've talked to who have an in-depth knowledge of
> > DSI and DSI panels told me that the panel needs to control the video bus,
> > and request the video source to start/stop the video stream.
> 
> Oh, I'm very well aware of the various flavours of funkiness that DSI
> panels come in. But it's wrong to say that the panel needs to control
> the video bus. There's simply no way that a panel can actually do that.
> It is true, however, that in order to make this work in a maintainable
> fashion, the DSI panel *driver* may need to control the DSI bus. That's
> an entirely different story.

Sure, but I don't think that's really related to the DT bindings. We don't 
have to model every electrical signal in a detailed way that matches the 
direction of the electrons flow :-) What we need to model is a connection 
between a display controller and a panel (possibly with a direction). What I'd 
like to do is to express that link in a way that can also express more complex 
pipeline topologies. I don't want to make it overly complex, I had hoped that 
my DT bindings proposal would be a good approach as it's both generic and 
still pretty simple.

> Again, that's exactly how I2C works as well. I2C slaves, by definition,
> do not control the I2C bus. However, I2C client drivers can do so by
> using the (master) services provided by the I2C controller.
> 
> So for DSI what we could easily do is provide a DSI "adapter" to the
> panel when it is attached to the DSI controller. If the DSI adapter
> implements all of the required services, then the DSI panel driver is
> easily capable of handling all the required special quirks.
> 
> I'm Cc'ing Rob and Daniel, both of whom have been working on this
> lately. Actually I'm not sure if Daniel was directly involved, but at
> least somebody from Intel's team was working on it.
> 
> > > > However, one thing unclear is where the panel node should be. You seem
> > > > to have a DSI panel here. If the panel is truly not controlled in any
> > > > way, maybe having the panel as a normal platform device is ok. But if
> > > > the DSI panel is controlled with DSI messages, should it be a child of
> > > > the dsi-controller node, the same way i2c peripherals are children of
> > > > i2c master?
> > > 
> > > That's one possibility. In this particular case it's not even necessary
> > > to use any of DSIs control methods to talk to the panel. The panel only
> > > receives the data stream and "just works".
> > > 
> > > Even if the panel were to be controlled via DSI, I think keeping it as
> > > a separate device node is equally valid. It's really boils down to what
> > > I already said above. The output uses the panel as a resource, similar
> > > to how other devices might use a GPIO controller to use a GPIO pin, or
> > > an interrupt controller to request an IRQ.
> > 
> > Except that the display controller can also provides resources to the
> > panel. For DSI panels that support DSI commands, the control bus is
> > provided by the display controller. Much like an I2C device must be a
> > child of its I2C controller node, the DSI panel device should then be a
> > child of the display controller node.
> 
> I don't think resources is the right term here. The DSI controller
> provides services. That's traditionally been handled in DT by handing
> out phandles to the service providers.
> 
> That said I see why it would make sense to make a DSI panel the child of
> the DSI controller node, so we agree at least partially. I don't like it
> all that much because it makes handling of panels inconsistent across
> various types of output and therefore makes it more complicated to
> support it drivers, but I'm sure I can live with it if somebody wants to
> enforce that.
> 
> > > > > I do agree though that it might be useful to tweak the mode in case
> > > > > the default one doesn't work. How about we provide a means to
> > > > > override the mode encoded in the driver using one specified in the
> > > > > DT? That's obviously a backwards-compatible change, so it could be
> > > > > added if or when it becomes necessary.
> > > > 
> > > > This sounds good to me.
> > > > 
> > > > Although maybe it'd be good to have the driver compatible with
> > > > something like "generic-panel", so that you could have:
> > > > 
> > > > compatible = "foo,specific-panel", "generic-panel";
> > > > 
> > > > and if there's no need for any power/gpio setup for your board, you
> > > > may skip adding "foo,specific-panel" support to the panel driver.
> > > > Later, somebody else may need to implement fine grained power/gpio
> > > > support for "foo,specific-panel", and it would just work.
> > > > 
> > > > Maybe that would help us with the problem of adding support in the
> > > > driver for a hundred different simple panels each used only once on a
> > > > specific board.
> > > 
> > > Sure, that all sounds like reasonable additions. All of the suggestions
> > > are even backwards-compatible and hence can be added when needed without
> > > breaking compatibility with existing users of the binding.
> > 
> > What's wrong with moving the three hardcoded modes we already have in the
> > driver to DT before pushing this to mainline ?
> 
> I think I've answered that in a different subthread.

Then I might not have understood your answer :-)

-- 
Regards,

Laurent Pinchart

--nextPart6199881.OepGi8V11t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSX9bEAAoJEIkPb2GL7hl1Ho0H/i2c0QxGz3W+u0Jb75BCTDiw
MfN7VaOLhfcZTNc1wRdOI0kcFWyOvWsxXHTbfIoCdxziaJ6YCyAAHZRS+kBEfM22
bZpT0buSLM7CX5mMzyanvntrgNmKz58wBgJMNrxP+H0v3UWuLVCoTAaNOU348Zp4
e/CPMxmSkpxPdjLRYUq3ImrAlZtzrihRUuJWAkLJ9hT72wJSlYdW0S4bcnNuCT8b
NpvR82SPqww+aQRcwgqBYQRCd4XFpNgY5zv1cX+4/tKPvfVSiMEsxQnRDEHty3ar
bVRCYfMaTnYK9TV1AXhsSqfcwjse8oazvS3kr2OcQi0JfASxyUSkoQJ7gqxUg8s=
=erGI
-----END PGP SIGNATURE-----

--nextPart6199881.OepGi8V11t--

