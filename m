From: Robert Morell <rmorell@nvidia.com>
Date: Mon, 08 Aug 2011 16:13:44 +0000
Subject: Re: [PATCH] video: Added a callback 'notify_after' for backlight
Message-Id: <20110808161344.GC27106@morell.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312799875-18629-1-git-send-email-dilee@nvidia.com>
In-Reply-To: <1312799875-18629-1-git-send-email-dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dilan Lee <dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org" <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Jordan Nien <JNien-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Looks fine to me in principle, but a few nitpicks.
First, the short commit message should be in imperative form, i.e., "Add
a callback..."

On Mon, Aug 08, 2011 at 03:37:55AM -0700, Dilan Lee wrote:
> From: Dilan Lee <dilee@nvidia.com>
> 
> We need a callback to do some things after pwm_enable,pwm_disable
> and pwm_config.

Add a space between "pwm_enable,pwm_disable"

> For example, GPIO backlight_en has to be rised after pwm has been enabled
> to meet panel power on sequence defined in panel specification.

There's a typo in "raised" above, but really, this paragraph should be
omitted entirely.  Without context, it doesn't make any sense.  If
more motivation that the previous paragraph is necessary, maybe add
something like "This may be necessary to properly sequence timing on
certain devices."

>  	unsigned int		lth_brightness;
>  	int			(*notify)(struct device *,
>  					  int brightness);
> +	void		(*notify_after)(struct device *,
> +					  int brightness);

The indentation here looks a bit off; notify_after should be lined up
with notify and check_fb, and int brightness doesn't need the extra
spaces since the notify_after argument list starts on a tab boundary.

Otherwise,

Reviewed-by: Robert Morell <rmorell@nvidia.com>

Thanks,
Robert
