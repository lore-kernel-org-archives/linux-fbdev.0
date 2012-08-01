From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Wed, 01 Aug 2012 00:51:17 +0000
Subject: Re: Gethering power management/policy hw drivers under drivers/power/? (Re: [RFC][PATCH v3 1/3] runt
Message-Id: <20120801005117.GA1798@lizard>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <5015E8AE.8060404@nvidia.com>
 <20120730024049.GA10442@lizard>
 <201207302259.39396.rjw@sisk.pl>
In-Reply-To: <201207302259.39396.rjw-KKrjLPT3xs0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean Pihet <j-pihet-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jul 30, 2012 at 10:59:39PM +0200, Rafael J. Wysocki wrote:
[...]
> > Well, currently drivers/power/ is indeed just for power supply class
> > subsystem and drivers. But if the trend is to gather power management
> > ("policy") stuff under one directory, i.e.
> > 
> > drivers/
> >   power/
> >     supplies/    <- former "power supply class and drivers"
> >     regulators/
> >     idle/
> >     cpuidle/
> >     cpufreq/
> >     devfreq/
> >     avs/
> >     ...
> > 
> > That would probably make sense, we could easily see the big picture.
> > But if we're not going to do this long-term,
> 
> Yes, we may do this eventually, but surely not right now.

OK, great! Then I'll probably start thinking about moving power supply
drivers into its own directory, maybe in 3.7.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
