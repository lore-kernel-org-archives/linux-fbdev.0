From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 02 Aug 2012 19:35:40 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <501AD68C.1000904@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1341388595-30672-1-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

On 07/04/2012 01:56 AM, Sascha Hauer wrote:
> This patch adds a helper function for parsing videomodes from the devicetree.
> The videomode can be either converted to a struct drm_display_mode or a
> struct fb_videomode.

> diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode

> +Required properties:
> + - xres, yres: Display resolution
> + - left-margin, right-margin, hsync-len: Horizontal Display timing parameters
> +   in pixels
> +   upper-margin, lower-margin, vsync-len: Vertical display timing parameters in
> +   lines

Perhaps bike-shedding, but...

For the margin property names, wouldn't it be better to use terminology
more commonly used for video timings rather than Linux FB naming. In
other words naming like:

hactive, hsync-len, hfront-porch, hback-porch?

> + - clock: displayclock in Hz
> +
> +Optional properties:
> + - width-mm, height-mm: Display dimensions in mm
> + - hsync-active-high (bool): Hsync pulse is active high
> + - vsync-active-high (bool): Vsync pulse is active high
> + - interlaced (bool): This is an interlaced mode
> + - doublescan (bool): This is a doublescan mode
> +
> +There are different ways of describing a display mode. The devicetree representation
> +corresponds to the one used by the Linux Framebuffer framework described here in
> +Documentation/fb/framebuffer.txt. This representation has been chosen because it's
> +the only format which does not allow for inconsistent parameters.Unlike the Framebuffer
> +framework the devicetree has the clock in Hz instead of ps.

As Rob mentioned, I think there shouldn't be any mention of Linux FB here.

> +
> +Example:
> +
> +	display@0 {

This node appears to describe a video mode, not a display, hence the
node name seems wrong.

Many displays can support multiple different video modes. As mentioned
elsewhere, properties like display width/height are properties of the
display not the mode.

So, I might expect something more like the following (various overhead
properties like reg/#address-cells etc. elided for simplicity):

disp: display {
    width-mm = <...>;
    height-mm = <...>;
    modes {
        mode@0 {
		/* 1920x1080p24 */
		clock = <52000000>;
		xres = <1920>;
		yres = <1080>;
		left-margin = <25>;
		right-margin = <25>;
		hsync-len = <25>;
		lower-margin = <2>;
		upper-margin = <2>;
		vsync-len = <2>;
		hsync-active-high;
        };
        mode@1 {
        };
    };
};

display-connector {
    display = <&disp>;
    // interface-specific properties such as pixel format here
};

Finally, have you considered just using an EDID instead of creating
something custom? I know that creating an EDID is harder than writing a
few simple properties into a DT, but EDIDs have the following advantages:

a) They're already standardized and very common.

b) They allow other information such as a display's HDMI audio
capabilities to be represented, which can then feed into an ALSA driver.

c) The few LCD panel datasheets I've seen actually quote their
specification as an EDID already, so deriving the EDID may actually be easy.

d) People familiar with displays are almost certainly familiar with
EDID's mode representation. There are many ways of representing display
modes (sync position vs. porch widths, htotal specified rather than
specifying all the components and hence htotal being calculated etc.).
Not everyone will be familiar with all representations. Conversion
errors are less likely if the target is EDID's familiar format.

e) You'll end up with exactly the same data as if you have a DDC-based
external monitor rather than an internal panel, so you end up getting to
a common path in display handling code much more quickly.

