From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 05 Jun 2018 10:48:58 +0000
Subject: Re: [PATCH 08/21] udl-kms: avoid prefetch
Message-Id: <20180605104858.GA22237@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180603144053.875668929@twibright.com>
 <20180603144221.959741603@twibright.com>
 <d07eb94b8b20a7b9f57f341a51cdcdbb91a60175.camel@synopsys.com>
In-Reply-To: <d07eb94b8b20a7b9f57f341a51cdcdbb91a60175.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, "bernie@plugable.com" <bernie@plugable.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "mpatocka@redhat.com" <mpatocka@redhat.com>, "airlied@redhat.com" <airlied@redhat.com>

On Tue, Jun 05, 2018 at 10:08:02AM +0000, Alexey Brodkin wrote:
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
> 
> >  	for (j = 0; j < width; j++) {
> >  		if (back[j] != front[j]) {
> >  			start = j;
> > @@ -140,8 +136,6 @@ static void udl_compress_hline16(
> >  		const u8 *cmd_pixel_start, *cmd_pixel_end = NULL;
> >  		uint16_t pixel_val16;
> >  
> > -		prefetchw((void *) cmd); /* pull in one cache line at least */
> > -
> 
> Pretty much the same is here. Obviously on the first iteration prefetcher dosn't
> know where to get "cmd". On the next iterations it might be better but given amount
> of operation happens further in the cycle (and in inner cycles) I won't be completely
> sure that each and every prefetcher will still keep track of "cmd".
> 
> >  		*cmd++ = 0xaf;
> >  		*cmd++ = 0x6b;
> >  		*cmd++ = (uint8_t) ((dev_addr >> 16) & 0xFF);
> > @@ -158,7 +152,6 @@ static void udl_compress_hline16(
> >  					(unsigned long)(pixel_end - pixel) >> log_bpp,
> >  					(unsigned long)(cmd_buffer_end - 1 - cmd) / 2) << log_bpp);
> >  
> > -		prefetch_range((void *) pixel, cmd_pixel_end - pixel);
> 
> Again I'm not sure what we gain removing that code in comparison of possible
> performance degradation on simpler CPUs.
> 
> And essentially all the same is applicable to UDLFB patch.

Tested this one on AT91SAM9G20 SoC, but couldn't get any measurable difference.
Part of problem is probably that full speed USB is the bottleneck here.
However, the same applies on OMAP3630 based board with high speed USB.

As a side note, I didn't experience any problem those paches are fixing, so
perhaps testcases could be described briefly, preferably with some numbers
(I'm not running console on udlfb, but try to give it a try next week).

Thank you,
	ladis

> -Alexey
