From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 31 Jul 2012 16:42:45 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120731164245.GA5762@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <50170EA0.1010408@wwwdotorg.org>
 <5017B434.2010706@nvidia.com>
 <20120731105640.GD16155@avionic-0098.adnet.avionic-design.de>
 <20120731141328.GS4468@opensource.wolfsonmicro.com>
 <20120731142216.GA19591@avionic-0098.adnet.avionic-design.de>
 <20120731142607.GV4468@opensource.wolfsonmicro.com>
 <20120731143235.GA21126@avionic-0098.adnet.avionic-design.de>
 <20120731153941.GF4468@opensource.wolfsonmicro.com>
 <20120731161954.GB4941@kroah.com>
 <20120731162230.GE11892@opensource.wolfsonmicro.com>
In-Reply-To: <20120731162230.GE11892-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>

On Tue, Jul 31, 2012 at 05:22:30PM +0100, Mark Brown wrote:
> On Tue, Jul 31, 2012 at 09:19:54AM -0700, Greg Kroah-Hartman wrote:
> > On Tue, Jul 31, 2012 at 04:39:41PM +0100, Mark Brown wrote:
> > > On Tue, Jul 31, 2012 at 04:32:35PM +0200, Thierry Reding wrote:
> 
> > > > can gracefully handle its platform data being discarded.
> 
> > > Sure there is - take a copy of the platform data in probe().
> 
> > Ick ick ick, devdata needs to die as it's pretty much pointless these
> > days.
> 
> Hrm?  I'm not sure I understand the direct relevance here - we're
> talking about platform data.

The platform data was marked __devdata, and you said it could be thrown
away after init so you should keep it around somehow.

Anyway, not really the main point here at all, sorry for the noise...

greg k-h
