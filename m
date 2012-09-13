From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Sep 2012 07:19:30 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <20120913071928.GA20959@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1749811.4qrG1GZfBf@percival>
 <20120913062552.GB17869@opensource.wolfsonmicro.com>
 <4473898.CeAQBgUhKL@percival>
In-Reply-To: <4473898.CeAQBgUhKL@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Thu, Sep 13, 2012 at 03:42:11PM +0900, Alex Courbot wrote:
> On Thursday 13 September 2012 14:25:53 Mark Brown wrote:

> > It would be sensible to make sure that the framework is done in such a
> > way that drivers can use it - there will be drivers (perhaps not display
> > ones) that have a known power sequence and which could benefit from the
> > ability to use library code to implement it based on the user simply
> > supplying named resources.

> Not sure I understand what you mean, but things should be working this way 
> already - regulators and PWMs are acquired by name using the standard 
> regulator_get() and pwm_get() functions. GPIOs do not, AFAIK, have a way to be 
> referenced by name so their number is used instead.

Right, but the sequencing for enabling them is currently open coded in
each driver.
