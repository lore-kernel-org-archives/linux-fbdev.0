From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 08:23:01 +0000
Subject: Re: [RFC 0/4] Use the Common Display Framework in tegra-drm
Message-Id: <5108D865.3070301@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <20130130074020.GA17547@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130130074020.GA17547-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/30/2013 04:40 PM, Thierry Reding wrote:
> Thanks *a lot* for taking care of this Alexandre! From a quick look at
> the patches they seem generally fine. I'll go over them in a bit more
> detail though.

Glad you like it better than my previous attempts at controlling Tegra's 
panels and backlights. ;)

>> 1) The CDF has a get_modes() hook, but this is already implemented by
>> tegra_connector_get_modes(). Ideally everything should be moved to the CDF hook,
>> but Tegra's implementation uses DRM functions to retrieve the EDID and CDF
>> should, AFAIK, remain DRM-agnostic.
>
> Maybe a good option would be to just not implement get_modes() if the
> same information can be retrieved via EDID. That is, the DRM driver
> could just go and fetch EDID when the nvidia,ddc-i2c-bus is available
> (or parse the nvidia,edid blob) and only rely on CDF otherwise.

Since EDID information is per-panel I'd intuitively say it should be 
provided by the panel driver.

> So for Ventana the only reason why we need CDF is basically the power
> sequencing, right?

As of now, yes.

> I definitely think that we should aim for correct panel and backlight
> interaction. Perhaps this could work by looking up the real backlight
> via it's phandle and have the CDF driver use the backlight API to
> disable or enable the backlight as part of the power sequencing.

I have just written a bit of code that does that. It works well and 
seems like a natural way to operate the backlight. However...

> I'm not sure what you mean by "cannot ignore FB events"? Can you provide
> a concrete problematic use-case?

... that's where thing stop looking nice. The backlight framework 
forcibly registers a framebuffer notifier callback and switches the 
backlight on and off on blank/unblank events, effectively duplicating 
what the panel driver does. There is no way to disable this behavior at 
the moment.

This could be solved by introducing a new function for controlling the 
"ownership" of the backlight that would unregister the notifier when the 
panel driver takes its reference to the backlight.

> Hijacking .update_status() sounds a bit risky. But perhaps you could
> wrap the real backlight in a CDF backlight to receive notifications.
> Obviously you'd get two backlight devices in sysfs, but that turn out
> not to be a problem.

For cosmetic reasons I'd prefer to avoid having two backlight devices 
(which ended up in that terrible PWM backlight subdriver thing). Maybe 
we can engineer the backlight framework to make such customizations easier?

Alex.

