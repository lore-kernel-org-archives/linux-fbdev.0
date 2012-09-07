From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 07 Sep 2012 08:29:03 +0000
Subject: Re: [PATCH v5 2/4] pwm_backlight: use power sequences
Message-Id: <20120907082835.GC17749@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346412846-17102-1-git-send-email-acourbot@nvidia.com>
 <1346412846-17102-3-git-send-email-acourbot@nvidia.com>
 <50478B07.4080708@wwwdotorg.org> <2360396.YKI4EihrfI@percival>
In-Reply-To: <2360396.YKI4EihrfI@percival>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Fri, Sep 07, 2012 at 05:28:17PM +0900, Alex Courbot wrote:

> We could make power sequences an option of its own and add #ifdefs to drivers 
> that use it to lift this ambiguity, but I like the transparency of the current 
> way. It also seems hard (illegal?) to get rid of the legacy DT interface.

If you're doing this I'd suggest using stubs rather than ifdefs in the
users, otherwise it's just going to cause lots of annoyance from
randconfig build.  Is the code likely to big enough to worry about,
though?
