From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Wed, 06 May 2015 20:32:28 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <alpine.LFD.2.11.1505061630300.7750@knanqh.ubzr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd> <552660C7.4020805@ti.com> <552663C2.70308@ti.com> <55277650.8070607@codeaurora.org> <20150424132923.GA11729@amd> <553A47D3.2070107@ti.com>
 <CAMuHMdV+-VcZD5TMswUjwW0fk=-76oYimeKJ_P9QC5Md4De-JA@mail.gmail.com> <20150428134848.GC12732@n2100.arm.linux.org.uk> <alpine.LFD.2.11.1504281127200.1582@knanqh.ubzr> <20150506104504.GM2067@n2100.arm.linux.org.uk>
In-Reply-To: <20150506104504.GM2067@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>, Archit Taneja <architt@codeaurora.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, H Hartley Sweeten <hsweeten@visionengravers.com>

On Wed, 6 May 2015, Russell King - ARM Linux wrote:

> On Tue, Apr 28, 2015 at 11:28:53AM -0400, Nicolas Pitre wrote:
> > On Tue, 28 Apr 2015, Russell King - ARM Linux wrote:
> > 
> > > On Fri, Apr 24, 2015 at 03:46:56PM +0200, Geert Uytterhoeven wrote:
> > > > So please optimize ARM's _memcpy_fromio(), _memcpy_toio(), and _memset_io().
> > > > That will benefit other drivers on ARM, too.
> > > 
> > > That's not going to happen.
> > > 
> > > I've had a patch which does that, but people are concerned that it changes
> > > the behaviour of the functions by changing the access size, which could
> > > cause regressions.  It seems people are far too worried about that to even
> > > consider trying. :(
> > 
> > What about making the optimized implementation available via kconfig?
> 
> I'd prefer not to.  My personal feeling is to put the patch in and just be
> done with it - these functions are supposed to be used on IO areas which
> don't care about access size (in other words, are memory-like rather than
> being register-like.)  Here's the rather old patch:
> 
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] ARM: optimize memset_io()/memcpy_fromio()/memcpy_toio()
> 
> If we are building for a LE platform, and we haven't overriden the
> MMIO ops, then we can optimize the mem*io operations using the
> standard string functions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/include/asm/io.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index d070741b2b37..358c8206419b 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -23,6 +23,7 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/string.h>
>  #include <linux/types.h>
>  #include <asm/byteorder.h>
>  #include <asm/memory.h>
> @@ -312,9 +313,33 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>  #define writesw(p,d,l)		__raw_writesw(p,d,l)
>  #define writesl(p,d,l)		__raw_writesl(p,d,l)
>  
> +#ifndef __ARMBE__
> +static inline void memset_io(volatile void __iomem *dst, unsigned c,
> +	size_t count)
> +{
> +	memset((void __force *)dst, c, count);
> +}
> +#define memset_io(dst,c,count) memset_io(dst,c,count)
> +
> +static inline void memcpy_fromio(void *to, const volatile void __iomem *from,
> +	size_t count)
> +{
> +	memcpy(to, (const void __force *)from, count);
> +}
> +#define memcpy_fromio(to,from,count) memcpy_fromio(to,from,count)
> +
> +static inline void memcpy_toio(volatile void __iomem *to, const void *from,
> +	size_t count)
> +{
> +	memcpy((void __force *)to, from, count);
> +}
> +#define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
> +
> +#else
>  #define memset_io(c,v,l)	_memset_io(c,(v),(l))
>  #define memcpy_fromio(a,c,l)	_memcpy_fromio((a),c,(l))
>  #define memcpy_toio(c,a,l)	_memcpy_toio(c,(a),(l))
> +#endif
>  
>  #endif	/* readl */
>  
> -- 
> 1.8.3.1
> 
> 
> 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
> 
> 
