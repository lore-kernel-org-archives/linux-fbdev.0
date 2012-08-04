From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 04 Aug 2012 14:12:01 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120804141155.GJ10523@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org> <501A338D.7080105@nvidia.com>
 <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de>
 <20120802181111.GM4537@opensource.wolfsonmicro.com>
 <501B2642.4080805@nvidia.com>
In-Reply-To: <501B2642.4080805-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Fri, Aug 03, 2012 at 10:15:46AM +0900, Alex Courbot wrote:
> On Fri 03 Aug 2012 03:11:12 AM JST, Mark Brown wrote:

> >I missed some of the earlier bits of the thread here but why can't we do
> >device based lookups?

> That is because the phandles would not be properties of the device
> node but rather of its sub-nodes:

> backlight {
>     compatible = "pwm-backlight";
>     ...
>     power-on-sequence {
>         step@0 {
>             regulator = <&backlight_reg>;
>             enable;
>         };
> 

> So here simply using regulator_get on the backlight device would not work.

Ah, right.  DT isn't being terribly helpful here...  I think the thing
I'd expect to work here is that you have a reference back to the supply
property of the backlight device rather than direct to the regulator so
you end up writing "enable supply X" rather than "enable regulator X".

Not quite sure how exactly you'd accomplish that - I guess if
regulator_get() would recursively follow phandles until it hits a node
that'd do the trick?
