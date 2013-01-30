From: Alex Courbot <acourbot@nvidia.com>
Date: Wed, 30 Jan 2013 08:28:42 +0000
Subject: Re: [RFC 1/4] video: panel: add CLAA101WA01A panel support
Message-Id: <5108D9BA.9040305@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359514939-15653-1-git-send-email-acourbot@nvidia.com> <1359514939-15653-2-git-send-email-acourbot@nvidia.com> <5108C9C1.1090707@gmail.com> <5108CB4F.7000103@nvidia.com> <20130130074852.GB17547@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130130074852.GB17547-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Mark Zhang <nvmarkzhang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

On 01/30/2013 04:48 PM, Thierry Reding wrote:
> I already said this in another thread. I think we should only be using
> the CDF .get_modes() for static modes that cannot be obtained from EDID.
> Thinking about it, I'm not quite sure why EDID would be needed for this
> kind of panel anyway. Ventana probably has it because it keeps us from
> having to hardcode things, but if we provide drivers for the panel
> anyway, we can just as well hard-code the supported mode(s) in those
> drivers.
>
> What I'm trying to say is that the existence of EDID is board-specific,
> so boards other than Ventana may not have an EDID EEPROM. Or perhaps
> this particular display has the EEPROM integrated? Even in that case,
> some boards may use this panel and simply not connect the EEPROM to an
> I2C controller.

Actually this display has its own EEPROM and pins for the I2C bus. 
That's why it would seems out-of-place to have EDID taking place outside 
its driver.

But you are right that we should also handle the case where the I2C bus 
is not connected and provide a static list of videomodes (that could be 
an "offline" dump of the EDID data). However, the driver could take the 
decision to use it if the EDID bus is not specified in the DT or if 
transfer failed for some reason.

But then as you mention we might as well save time and directly serve 
that offline version, since we know the content of the EEPROM anyway.

Alex.

