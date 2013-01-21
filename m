From: Alex Courbot <acourbot@nvidia.com>
Date: Mon, 21 Jan 2013 08:18:11 +0000
Subject: Re: [PATCH 0/3] pwm-backlight: add subdrivers & Tegra support
Message-Id: <6871054.sK10m5bePf@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358591420-7790-1-git-send-email-acourbot@nvidia.com> <20130121074928.GE15508@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20130121074928.GE15508-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Zhang <markz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Thierry,

On Monday 21 January 2013 15:49:28 Thierry Reding wrote:
> Eventually this should all be covered by the CDF, but since that's not
> ready yet we want something ad-hoc to get the hardware supported. As
> such I would like to see this go into some sort of minimalistic, Tegra-
> specific display/panel framework. I'd prefer to keep the pwm-backlight
> driver as simple and generic as possible, that is, a driver for a PWM-
> controlled backlight.
> 
> Another advantage of moving this into a sort of display framework is
> that it may help in defining the requirements for a CDF and that moving
> the code to the CDF should be easier once it is done.
> 
> Last but not least, abstracting away the panel allows other things such
> as physical dimensions and display modes to be properly encapsulated. I
> think that power-on/off timing requirements for panels also belong to
> this set since they are usually specific to a given panel.
> 
> Maybe adding these drivers to tegra-drm for now would be a good option.
> That way the corresponding glue can be added without a need for inter-
> tree dependencies.

IIRC (because that was a while ago already) having a Tegra-only display 
framework is exactly what we wanted to avoid in the first place. This series 
does nothing but leverage the callbacks mechanism that already exists in pwm-
backlight and make it available to DT systems. If we start making a Tegra-
specific solution, then other architectures will have to reinvent the wheel 
again. I really don't think we want to go that way.

These patches only makes slight changes to pwm_bl.c and do not extend its 
capabilities. I agree that a suitable solution will require the CDF, but by 
the meantime, let's go for the practical route instead of repeating the same 
mistakes (i.e. architecture-specific frameworks) again.

There are certainly better ways to do this, but I'm not convinced at all that 
a Tegra-only solution is one of them.

Alex.

