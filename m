From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 18:27:15 +0000
Subject: Re: [PATCH 0/6] Support for LEGO MINDSTORMS EV3 LCD display
Message-Id: <CAHp75Ve=f_vpktMMGNx1PdhaqRkigdCUNArg==XWxkU3ykTw0A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
> working. But, most of the content here is building up the infrastructure to do
> that.
>
> The controller used in the EV3 uses MIPI commands, but it uses a different
> memory layout. The current tinydrm stuff is hard-coded for RGB565, so most
> of the patches are adding support for other memory layouts.
>
> I've also made the one existing tinydrm driver generic so that it can work for
> any MIPI display rather than copying a bunch of boiler-plate code for each
> panel and/or controller.
>
> Once all of this is done, it is really easy to add a new panel. :-)

Perhaps pathes are good, but logically completely incorrect.

-- 
With Best Regards,
Andy Shevchenko
