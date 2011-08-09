From: Robert Morell <rmorell@nvidia.com>
Date: Tue, 09 Aug 2011 02:34:11 +0000
Subject: Re: [PATCH] video: Add a callback 'notify_after' for backlight
Message-Id: <20110809023411.GO27748@morell.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312856996-22452-1-git-send-email-dilee@nvidia.com>
In-Reply-To: <1312856996-22452-1-git-send-email-dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dilan Lee <dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org" <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <arun.murthy-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org" <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Jordan Nien <JNien-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, Aug 08, 2011 at 07:29:56PM -0700, Dilan Lee wrote:
> From: Dilan Lee <dilee@nvidia.com>
> 
> We need a callback to do some things after pwm_enable, pwm_disable
> and pwm_config.
> 
> Signed-off-by: Dilan Lee <dilee@nvidia.com>

Reviewed-by: Robert Morell <rmorell@nvidia.com>

Thanks,
Robert
