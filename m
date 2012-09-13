From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Sep 2012 07:29:44 +0000
Subject: Re: [PATCH v6 0/4] Runtime Interpreted Power Sequences
Message-Id: <20120913072943.GB20959@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <4473898.CeAQBgUhKL@percival>
 <20120913071928.GA20959@opensource.wolfsonmicro.com>
 <1378218.yLeQheNFT0@percival>
In-Reply-To: <1378218.yLeQheNFT0@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leela Krishna Amudala <l.krishna-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Thu, Sep 13, 2012 at 04:26:34PM +0900, Alex Courbot wrote:
> On Thursday 13 September 2012 15:19:30 Mark Brown wrote:
> > > On Thursday 13 September 2012 14:25:53 Mark Brown wrote:
> > > > It would be sensible to make sure that the framework is done in such a
> > > > way that drivers can use it - there will be drivers (perhaps not display
> > > > ones) that have a known power sequence and which could benefit from the
> > > > ability to use library code to implement it based on the user simply
> > > > supplying named resources.

> > > Not sure I understand what you mean, but things should be working this way
> > > already - regulators and PWMs are acquired by name using the standard
> > > regulator_get() and pwm_get() functions. GPIOs do not, AFAIK, have a way
> > > to be referenced by name so their number is used instead.

> > Right, but the sequencing for enabling them is currently open coded in
> > each driver.

> Mmm then I'm afraid I don't see what you wanted to say initially - could you 
> elaborate?

The driver knows the power sequence.  Having to type the same sequence
into the DT or platform data for each board using the device wouuld be
retarded so we need the drivers to be able to give the sequence to the
library if they're going to be able to reuse it (which is a lot of what
Tomi is talking about).
