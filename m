From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 24 Sep 2012 15:45:04 +0000
Subject: Re: [PATCH v4] of: Add videomode helper
Message-Id: <50608000.6050007@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348042843-24673-1-git-send-email-s.trumtrar@pengutronix.de>
 <50606334.7030902@gmail.com>
In-Reply-To: <50606334.7030902-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

On 09/24/2012 07:42 AM, Rob Herring wrote:
> On 09/19/2012 03:20 AM, Steffen Trumtrar wrote:
>> This patch adds a helper function for parsing videomodes from the devicetree.
>> The videomode can be either converted to a struct drm_display_mode or a
>> struct fb_videomode.

>> +++ b/Documentation/devicetree/bindings/video/displaymode
>> @@ -0,0 +1,74 @@
>> +videomode bindings
>> +=========
>> +
>> +Required properties:
>> + - hactive, vactive: Display resolution
>> + - hfront-porch, hback-porch, hsync-len: Horizontal Display timing parameters
>> +   in pixels
>> +   vfront-porch, vback-porch, vsync-len: Vertical display timing parameters in
>> +   lines
>> + - clock: displayclock in Hz
> 
> A major piece missing is the LCD controller to display interface width
> and component ordering.

I thought this binding was solely defining the timing of the video
signal (hence "video mode"). Any definition of the physical interface to
the LCD/display-connector is something entirely orthogonal, so it seems
entirely reasonable to represent that separately.

>> +Example:
>> +
>> +	display@0 {
> 
> It would be useful to have a compatible string here. We may not always
> know the panel type or have a fixed panel though. We could define
> "generic-lcd" or something for cases where the panel type is unknown.
> 
>> +		width-mm = <800>;
>> +		height-mm = <480>;

I would hope that everything in the example above this point is just
that - an example, and this binding only covers the display mode
definition - i.e. that part of the example below.

If that's not the intent, as Rob says, there's a /ton/ of stuff missing.

>> +		modes {
>> +			mode0: mode@0 {
>> +				/* 1920x1080p24 */
>> +				clock = <52000000>;
>> +				hactive = <1920>;
>> +				vactive = <1080>;
>> +				hfront-porch = <25>;
>> +				hback-porch = <25>;
>> +				hsync-len = <25>;
>> +				vback-porch = <2>;
>> +				vfront-porch = <2>;
>> +				vsync-len = <2>;
>> +				hsync-active-high;
>> +			};
>> +		};
>> +	};

