From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 02 Aug 2012 19:43:55 +0000
Subject: Re: [PATCH v2] of: Add videomode helper
Message-Id: <501AD87B.8000408@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341388595-30672-1-git-send-email-s.hauer@pengutronix.de>
 <4FF5A9FB.7010004@gmail.com>
In-Reply-To: <4FF5A9FB.7010004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On 07/05/2012 08:51 AM, Rob Herring wrote:
> On 07/04/2012 02:56 AM, Sascha Hauer wrote:
>> This patch adds a helper function for parsing videomodes from the devicetree.
>> The videomode can be either converted to a struct drm_display_mode or a
>> struct fb_videomode.

>> diff --git a/Documentation/devicetree/bindings/video/displaymode b/Documentation/devicetree/bindings/video/displaymode

>> +Example:
>> +
>> +     display@0 {
>> +             /* 1920x1080p24 */
>> +             clock = <52000000>;
> 
> Should this use the clock binding? You probably need both constraints
> and clock binding though.

I don't think the clock binding is appropriate here. This binding
specifies a desired video mode, and should specify just the expected
clock frequency for that mode. Perhaps any tolerance imposed by the
specification used to calculate the mode timing could be specified too,
but the allowed tolerance (for a mode to be recognized by the dispaly)
is more driven by the receiving device than the transmitting device.

The clock bindings should come into play in the display controller that
sends a signal in that display mode. Something like:

mode: hd1080p {
    clock = <52000000>;
    xres = <1920>;
    yres = <1080>;
    ....
};

display-controller {
    pixel-clock-source = <&clk ...>; // common clock bindings here
    default-mode = <&mode>;

> Often you don't know the frequency up front and/or have limited control
> of the frequency (i.e. integer dividers). Then you have to adjust the
> margins to get the desired refresh rate. To do that, you need to know
> the ranges of values a panel can support. Perhaps you just assume you
> can increase the right-margin and lower-margins as I think you will hit
> pixel clock frequency max before any limit on margins.

I think this is more usually dealt with in HW design and matching
components.

The PLL/... feeding the display controller is going to have some known
specifications that imply which pixel clocks it can generate. HW
designers will pick a panel that accepts a clock the display controller
can generate. The driver for the display controller will just generate
as near of a pixel clock as it can to the rate specified in the mode
definition. I believe it'd be unusual for a display driver to start
fiddling with front-back porch (or margin) widths to munge the timing;
that kind of thing probably worked OK with analog displays, but with
digital displays where each pixel is clocked even in the margins, I
think that would cause more problems than it solved.

Similarly for external displays, the display controller will just pick
the nearest clock it can. If it can't generate a close enough clock, it
will just refuse to set the mode. In fact, a display controller driver
would typically validate this when the set of legal modes was enumerated
when initially detecting the display, so user-space typically wouldn't
even request invalid modes.
