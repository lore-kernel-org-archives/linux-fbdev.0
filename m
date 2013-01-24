From: Alex Courbot <acourbot@nvidia.com>
Date: Thu, 24 Jan 2013 06:10:08 +0000
Subject: Re: [PATCH 2/3] tegra: pwm-backlight: add tegra pwm-bl driver
Message-Id: <3533873.vHaQr9T5V0@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <20130122070630.GA14728@avionic-0098.adnet.avionic-design.de> <2178053.V0UsGT5PW9@percival>
In-Reply-To: <2178053.V0UsGT5PW9@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On Wednesday 23 January 2013 17:45:39 Alex Courbot wrote:
> > I'm confused. Why would you want to call into pwm_bl directly? If we're
> > going to split this up into separate platform devices, why not look up a
> > given backlight device and use the backlight API on that? The pieces of
> > the puzzle are all there: you can use of_find_backlight_by_node() to
> > obtain a backlight device from a device tree node, so I'd expect the DT
> > to look something like this:
> > 	backlight: backlight {
> > 	
> > 		compatible = "pwm-backlight";
> > 		...
> > 	
> > 	};
> 
> This would still prevent any power control from the backlight driver. I.e.
> if someone sets the brightness to 0 through sysfs, we cannot power the
> backlight off as pwm-backlight cannot control more than the PWM without
> platform callbacks. Backlight could only be powered off as a result of a fb
> blank event.

In order to solve this, how about adding a backlight notifier call chain to 
broadcast backlight events in a fashion similar to what is done in 
fbmem/fbcon? Then backlight_update_status() could send events like 
BACKLIGHT_EARLY_EVENT_UPDATE and BACKLIGHT_EVENT_UPDATE to which panel drivers 
could subscribe in order to power the backlight up and down as needed.

Then as the backlight is mentioned in the panel's DT node,

>       panel: panel {
>               compatible = "...";
>               ...
>               backlight = <&backlight>;
>               ...
>       };

the panel's driver could listen to backlight-related events and do its stuff 
transparently, without changing anything to the backlight drivers. This would 
be a good way to replace pwm-backlight's callbacks for platforms that use the 
DT, and would also be applicable to any backlight class device.

Generally speaking, having a mean to monitor backlights state in the kernel 
does not seem too crazy, especially since we already have a way to notify user 
space through backlight_generate_event().

Richard, does that sound ok to you?

Alex.

