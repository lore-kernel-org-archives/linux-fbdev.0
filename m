From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 18:24:03 +0000
Subject: Re: [PATCH 4/6] drm/tinydrm: mipi-panel: refactor to use driver id
Message-Id: <CAHp75VcdGi=TkB_7fPHROYoKJFUPZPGi=HvUAHuAvgZy-1_Epw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com> <1501355870-13960-5-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-5-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> This refactors the mipi-panel module to use the driver id for panel-specific
> data. This is in preparation for adding additional panels.
>

Wouldn't be better to split glue driver from what looks like more
generic in the first place? Then you will not need to spread some
stuff
over generic files.

Are we going to disrupt genericy of the framework already with second driver?!

-- 
With Best Regards,
Andy Shevchenko
