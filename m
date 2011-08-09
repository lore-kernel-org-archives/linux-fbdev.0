From: Arun MURTHY <arun.murthy@stericsson.com>
Date: Tue, 09 Aug 2011 03:43:25 +0000
Subject: RE: [PATCH] video: Add a callback 'notify_after' for backlight
Message-Id: <F45880696056844FA6A73F415B568C6953FF062B94@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1312856996-22452-1-git-send-email-dilee@nvidia.com>
In-Reply-To: <1312856996-22452-1-git-send-email-dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <dilee-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org" <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, "lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org" <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "jnien-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <jnien-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

> -----Original Message-----
> From: dilee@nvidia.com [mailto:dilee@nvidia.com]
> Sent: Tuesday, August 09, 2011 8:00 AM
> To: rpurdie@rpsys.net; lethal@linux-sh.org; akpm@linux-foundation.org;
> Arun MURTHY; rmorell@nvidia.com; Linus WALLEIJ
> Cc: jnien@nvidia.com; swarren@nvidia.com; linux-fbdev@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-tegra@vger.kernel.org; Dilan Lee
> Subject: [PATCH] video: Add a callback 'notify_after' for backlight
> control
> 
> From: Dilan Lee <dilee@nvidia.com>
> 
> We need a callback to do some things after pwm_enable, pwm_disable
> and pwm_config.
> 
> Signed-off-by: Dilan Lee <dilee@nvidia.com>

Reviewed-by: Arun Murthy <arun.murthy@stericsson.com>

