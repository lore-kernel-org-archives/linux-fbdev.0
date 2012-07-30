From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 30 Jul 2012 15:47:06 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120730154706.GL4468@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <5016ABDD.5010809@gmail.com>
In-Reply-To: <5016ABDD.5010809-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org

On Mon, Jul 30, 2012 at 10:44:29AM -0500, Rob Herring wrote:
> On 07/27/2012 07:05 AM, Alexandre Courbot wrote:

> > +		power-on-sequence {
> > +			regulator@0 {
> > +				id = "power";
> > +				enable;

> What do this mean? Isn't this implied for a regulator?

I assume you might have some sequences which need some things to be
turned off for some reason; it at least seems to be something you'd want
to design for.

> This looks like you designed the platform_data structs first and then
> came up with device nodes to mirror the struct.

Judging by most of the DT I review this seems idiomatic :)
