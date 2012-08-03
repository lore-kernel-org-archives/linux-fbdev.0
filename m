From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 03 Aug 2012 07:38:44 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <20120803073844.GK1451@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <501AD68C.1000904@wwwdotorg.org>
In-Reply-To: <501AD68C.1000904-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Hi Stephen,

On Thu, Aug 02, 2012 at 01:35:40PM -0600, Stephen Warren wrote:
> On 07/04/2012 01:56 AM, Sascha Hauer wrote:
> > This patch adds a helper function for parsing videomodes from the devicetree.
> > The videomode can be either converted to a struct drm_display_mode or a
> > struct fb_videomode.
> 
> > diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode
> 
> > +Required properties:
> > + - xres, yres: Display resolution
> > + - left-margin, right-margin, hsync-len: Horizontal Display timing parameters
> > +   in pixels
> > +   upper-margin, lower-margin, vsync-len: Vertical display timing parameters in
> > +   lines
> 
> Perhaps bike-shedding, but...
> 
> For the margin property names, wouldn't it be better to use terminology
> more commonly used for video timings rather than Linux FB naming. In
> other words naming like:
> 
> hactive, hsync-len, hfront-porch, hback-porch?

Can do. Just to make sure:

hactive = xres
hsync-len = hsync-len
hfront-porch = right-margin
hback-porch = left-margin

?

> 
> This node appears to describe a video mode, not a display, hence the
> node name seems wrong.
> 
> Many displays can support multiple different video modes. As mentioned
> elsewhere, properties like display width/height are properties of the
> display not the mode.
> 
> So, I might expect something more like the following (various overhead
> properties like reg/#address-cells etc. elided for simplicity):
> 
> disp: display {
>     width-mm = <...>;
>     height-mm = <...>;
>     modes {
>         mode@0 {
> 		/* 1920x1080p24 */
> 		clock = <52000000>;
> 		xres = <1920>;
> 		yres = <1080>;
> 		left-margin = <25>;
> 		right-margin = <25>;
> 		hsync-len = <25>;
> 		lower-margin = <2>;
> 		upper-margin = <2>;
> 		vsync-len = <2>;
> 		hsync-active-high;
>         };
>         mode@1 {
>         };
>     };
> };

Ok, we can do this.

> 
> display-connector {
>     display = <&disp>;
>     // interface-specific properties such as pixel format here
> };
> 
> Finally, have you considered just using an EDID instead of creating
> something custom? I know that creating an EDID is harder than writing a
> few simple properties into a DT, but EDIDs have the following advantages:

I have considered using EDID and I also tried it. It's painful. There
are no (open) tools available for creating EDID. That's something we
could change of course. Then when generating a devicetree there is
always an extra step involved creating the EDID blob. Once the EDID
blob is in devicetree it is not parsable anymore by mere humans, so
to see what we've got there is another tool involved to generate a
readable form again.

> 
> a) They're already standardized and very common.

Indeed, that's a big plus for EDID. I have no intention of removing EDID
data from the devicetree. There are situations where EDID is handy, for
example when you get EDID data provided by your vendor.

> 
> b) They allow other information such as a display's HDMI audio
> capabilities to be represented, which can then feed into an ALSA driver.
> 
> c) The few LCD panel datasheets I've seen actually quote their
> specification as an EDID already, so deriving the EDID may actually be easy.
> 
> d) People familiar with displays are almost certainly familiar with
> EDID's mode representation. There are many ways of representing display
> modes (sync position vs. porch widths, htotal specified rather than
> specifying all the components and hence htotal being calculated etc.).
> Not everyone will be familiar with all representations. Conversion
> errors are less likely if the target is EDID's familiar format.

You seem to think about a different class of displays for which EDID
indeed is a better way to handle. What I have to deal with here mostly
are dumb displays which:

- can only handle their native resolution
- Have no audio capabilities at all
- come with a datasheet which specify a min/typ/max triplet for
  xres,hsync,..., often enough they are scanned to pdf from some previously
  printed paper.

These displays are very common on embedded devices, probably that's the
reason I did not even think about the possibility that a single display
might have different modes.

> 
> e) You'll end up with exactly the same data as if you have a DDC-based
> external monitor rather than an internal panel, so you end up getting to
> a common path in display handling code much more quickly.

All we have in our display driver currently is:

	edidp = of_get_property(np, "edid", &imxpd->edid_len);
	if (edidp) {
		imxpd->edid = kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
	} else {
		ret = of_get_video_mode(np, &imxpd->mode, NULL);
		if (!ret)
			imxpd->mode_valid = 1;
	}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
