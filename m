From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 05 Jun 2018 15:30:22 +0000
Subject: Re: [PATCH 08/21] udl-kms: avoid prefetch
Message-Id: <alpine.LRH.2.02.1806051123300.7248@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
 <20180603144221.959741603@twibright.com>
 <d07eb94b8b20a7b9f57f341a51cdcdbb91a60175.camel@synopsys.com>
In-Reply-To: <d07eb94b8b20a7b9f57f341a51cdcdbb91a60175.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "ladis@linux-mips.org" <ladis@linux-mips.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "bernie@plugable.com" <bernie@plugable.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@redhat.com" <airlied@redhat.com>



On Tue, 5 Jun 2018, Alexey Brodkin wrote:

> Hi Mikulas,
> 
> On Sun, 2018-06-03 at 16:41 +0200, Mikulas Patocka wrote:
> > Modern processors can detect linear memory accesses and prefetch data
> > automatically, so there's no need to use prefetch.
> 
> Not each and every CPU that's capable of running Linux has prefetch
> functionality :)
> 
> Still read-on...
> 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > ---
> >  drivers/gpu/drm/udl/udl_transfer.c |    7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > Index: linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c
> > =================================> > --- linux-4.16.12.orig/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:48:12.000000000 +0200
> > +++ linux-4.16.12/drivers/gpu/drm/udl/udl_transfer.c	2018-05-31 14:48:12.000000000 +0200
> > @@ -13,7 +13,6 @@
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/fb.h>
> > -#include <linux/prefetch.h>
> >  #include <asm/unaligned.h>
> >  
> >  #include <drm/drmP.h>
> > @@ -51,9 +50,6 @@ static int udl_trim_hline(const u8 *bbac
> >  	int start = width;
> >  	int end = width;
> >  
> > -	prefetch((void *) front);
> > -	prefetch((void *) back);
> 
> AFAIK prefetcher fetches new data according to a known history... i.e. based on previously
> used pattern we'll trying to get the next batch of data.
> 
> But the code above is in the very beginning of the data processing routine where
> prefetcher doesn't yet have any history to know what and where to prefetch.
> 
> So I'd say this particular usage is good.
> At least those prefetches shouldn't hurt because typically it
> would be just 1 instruction if those exist or nothing if CPU/compiler doesn't
> support it.

See this post https://lwn.net/Articles/444336/ where they measured that 
prefetch hurts performance. Prefetch shouldn't be used unless you have a 
proof that it improves performance.

The problem is that the prefetch instruction causes stalls in the pipeline 
when it encounters TLB miss and the automatic prefetcher doesn't.

Mikulas
