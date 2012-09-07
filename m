From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 07 Sep 2012 08:34:34 +0000
Subject: Re: [PATCH v5 2/4] pwm_backlight: use power sequences
Message-Id: <1584217.aCLniK0dpS@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346412846-17102-1-git-send-email-acourbot@nvidia.com> <2360396.YKI4EihrfI@percival> <20120907082835.GC17749@opensource.wolfsonmicro.com>
In-Reply-To: <20120907082835.GC17749-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Anton Vorontsov <cbou-JGs/UdohzUI@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Friday 07 September 2012 16:29:03 Mark Brown wrote:
> On Fri, Sep 07, 2012 at 05:28:17PM +0900, Alex Courbot wrote:
> > We could make power sequences an option of its own and add #ifdefs to
> > drivers that use it to lift this ambiguity, but I like the transparency
> > of the current way. It also seems hard (illegal?) to get rid of the
> > legacy DT interface.
> If you're doing this I'd suggest using stubs rather than ifdefs in the
> users, otherwise it's just going to cause lots of annoyance from
> randconfig build.  Is the code likely to big enough to worry about,
> though?

I don't think is will ever become big enough to bother. Moreover if the power 
seqs way meets acceptance, new drivers/frameworks are likely to use them as 
the only option, making it really mandatory.

Alex.

