From: Anatolij Gustschin <agust@denx.de>
Date: Fri, 30 Apr 2010 10:19:47 +0000
Subject: Re: [PATCH 3/5] powerpc/mpc5121: shared DIU framebuffer support
Message-Id: <20100430121947.1d265ca6@wker>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
	<1272584978-19063-4-git-send-email-agust@denx.de>
	<s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
In-Reply-To: <s2ted82fe3e1004291905mf562f0cbi24054bb973aa2dbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Timur Tabi <timur.tabi@gmail.com>
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de, John Rigby <jrigby@gmail.com>, devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org, yorksun@freescale.com

On Thu, 29 Apr 2010 21:05:26 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> 
> 
> > +void __init mpc5121_ads_init_early(void)
> > +{
> > +       mpc512x_init_diu();
> > +}
> > +
> >  define_machine(mpc5121_ads) {
> >        .name                   = "MPC5121 ADS",
> >        .probe                  = mpc5121_ads_probe,
> >        .setup_arch             = mpc5121_ads_setup_arch,
> >        .init                   = mpc512x_init,
> > +       .init_early             = mpc5121_ads_init_early,
> 
> How about just doing this?
> 
> .init_early             = mpc512x_init_diu,

I thought it should be prepared for adding other code here.
mpc5121_ads_init_early() is generic and could contain other
things as well. I would vote for current version.

> > +void __init mpc512x_generic_init_early(void)
> > +{
> > +       mpc512x_init_diu();
> > +}
> > +
> > +void __init mpc512x_generic_setup_arch(void)
> > +{
> > +       mpc512x_setup_diu();
> > +}
> > +
> >  define_machine(mpc5121_generic) {
> >        .name                   = "MPC5121 generic",
> >        .probe                  = mpc5121_generic_probe,
> >        .init                   = mpc512x_init,
> > +       .init_early             = mpc512x_generic_init_early,
> > +       .setup_arch             = mpc512x_generic_setup_arch,
> 
> And a similar change here.

Same here.

...
> > diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > index b7f518a..8e297fa 100644
> > --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> > +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> > @@ -16,7 +16,11 @@
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/fsl-diu-fb.h>
> > +#include <linux/bootmem.h>
> > +#include <sysdev/fsl_soc.h>
> >
> > +#include <asm/cacheflush.h>
> >  #include <asm/machdep.h>
> >  #include <asm/ipic.h>
> >  #include <asm/prom.h>
> > @@ -53,6 +57,286 @@ void mpc512x_restart(char *cmd)
> >                ;
> >  }
> >
> > +struct fsl_diu_shared_fb {
> > +       char            gamma[0x300];   /* 32-bit aligned! */
> 
> char or u8?

Will use u8.

> > +       struct diu_ad   ad0;            /* 32-bit aligned! */
> > +       phys_addr_t     fb_phys;
> > +       size_t          fb_len;
> > +       bool            in_use;
> > +};
> 
> Where did "bool" come from?  Use "int" instead.

It is common practise to use "bool" type, grep in drivers dir.

> > +unsigned int mpc512x_get_pixel_format(unsigned int bits_per_pixel,
> > +                                     int monitor_port)
> > +{
> > +       unsigned int pix_fmt;
> > +
> > +       switch (bits_per_pixel) {
> > +       case 32:
> > +               pix_fmt = 0x88883316;
> > +               break;
> > +       case 24:
> > +               pix_fmt = 0x88082219;
> > +               break;
> > +       case 16:
> > +               pix_fmt = 0x65053118;
> > +               break;
> > +       default:
> > +               pix_fmt = 0x00000400;
> > +       }
> > +       return pix_fmt;
> > +}
> 
> This is simpler:
> 
>        switch (bits_per_pixel) {
>        case 32:
>                return 0x88883316;
>        case 24:
>                return 0x88082219;
>        case 16:
>                return = 0x65053118;
>       }
> 
>       return 0x00000400;
> }

Will simplify as suggested, thanks!

> > +       ccm = of_iomap(np, 0);
> > +       if (!ccm) {
> > +               pr_err("Can't map clock control module reg.\n");
> > +               of_node_put(np);
> > +               return;
> > +       }
> > +       of_node_put(np);
> 
> This is simpler:
> 
>        ccm = of_iomap(np, 0);
>        of_node_put(np);
>        if (!ccm) {
>                pr_err("Can't map clock control module reg.\n");
>                return;
>        }

OK, will fix, thanks.

> 
> > +       np = of_find_node_by_type(NULL, "cpu");
> > +       if (np) {
> > +               unsigned int size;
> > +               const unsigned int *prop > > +                       of_get_property(np, "bus-frequency", &size);
> 
> Since you don't use 'size', you can skip it:
> 
>               const unsigned int *prop >                       of_get_property(np, "bus-frequency", NULL);
> 
> > +       } else {
> > +               pr_err("Can't find \"cpu\" node.\n");
> 
> 'cpu' is simpler than \"cpu\"

Will simplify, too.

> > +       /* Calculate the pixel clock with the smallest error */
> > +       /* calculate the following in steps to avoid overflow */
> > +       pr_debug("DIU pixclock in ps - %d\n", pixclock);
> > +       temp = (1000000000 / pixclock) * 1000;
> 
> I'm pretty sure the compiler will optimize this to:
> 
>     temp = (1000000000000UL / pixclock);
> 
> so you may as well do it that way.

??
1000000000000 is _not_ UL, but UUL.

> 
> > +       pixclock = temp;
> > +       pr_debug("DIU pixclock freq - %u\n", pixclock);
> > +
> > +       temp = (temp * 5) / 100; /* pixclock * 0.05 */
> 
> The compiler will optimize this to:
> 
>     temp /= 20;

Can do it, too. Thanks.

> > +       pr_debug("deviation = %d\n", temp);
> > +       minpixclock = pixclock - temp;
> > +       maxpixclock = pixclock + temp;
> > +       pr_debug("DIU minpixclock - %lu\n", minpixclock);
> > +       pr_debug("DIU maxpixclock - %lu\n", maxpixclock);
> > +       pixval = speed_ccb/pixclock;
> > +       pr_debug("DIU pixval = %lu\n", pixval);
> > +
> > +       err = 100000000;
> 
> Why do you assign err to this arbitrary value?

Dunno. It is Freescale's code and I do not have time to check
and understand each bit of it and to explain it.

> > +       bestval = pixval;
> > +       pr_debug("DIU bestval = %lu\n", bestval);
> > +
> > +       bestfreq = 0;
> > +       for (i = -1; i <= 1; i++) {
> > +               temp = speed_ccb / (pixval+i);
> > +               pr_debug("DIU test pixval i=%d, pixval=%lu, temp freq. = %u\n",
> > +                       i, pixval, temp);
> > +               if ((temp < minpixclock) || (temp > maxpixclock))
> > +                       pr_debug("DIU exceeds monitor range (%lu to %lu)\n",
> > +                               minpixclock, maxpixclock);
> > +               else if (abs(temp - pixclock) < err) {
> > +                       pr_debug("Entered the else if block %d\n", i);
> > +                       err = abs(temp - pixclock);
> > +                       bestval = pixval + i;
> > +                       bestfreq = temp;
> > +               }
> > +       }
> > +
> > +       pr_debug("DIU chose = %lx\n", bestval);
> > +       pr_debug("DIU error = %ld\n NomPixClk ", err);
> > +       pr_debug("DIU: Best Freq = %lx\n", bestfreq);
> > +       /* Modify DIU_DIV in CCM SCFR1 */
> > +       temp = in_be32(ccm + CCM_SCFR1);
> 
> Don't use offsets like + CCM_SCFR1.  Create a structure and use that instead.

Done in next patch version.

> > +       pr_debug("DIU: Current value of SCFR1: 0x%08x\n", temp);
> > +       temp &= ~DIU_DIV_MASK;
> > +       temp |= (bestval & DIU_DIV_MASK);
> > +       out_be32(ccm + CCM_SCFR1, temp);
> > +       pr_debug("DIU: Modified value of SCFR1: 0x%08x\n", temp);
> > +       iounmap(ccm);
> > +}
> > +
> > +ssize_t mpc512x_show_monitor_port(int monitor_port, char *buf)
> > +{
> > +       return snprintf(buf, PAGE_SIZE, "0 - 5121 LCD\n");
> 
> There's no point in using snprintf since you're printing a string
> literal.  You can use sprintf.

Will do, thanks.

> > +}
> > +
> > +int mpc512x_set_sysfs_monitor_port(int val)
> > +{
> > +       return 0;
> > +}
> > +
> > +static struct fsl_diu_shared_fb __attribute__ ((__aligned__(8))) diu_shared_fb;
> > +
> > +#if defined(CONFIG_FB_FSL_DIU) || \
> > +    defined(CONFIG_FB_FSL_DIU_MODULE)
> > +static inline void mpc512x_free_bootmem(struct page *page)
> > +{
> > +       __ClearPageReserved(page);
> > +       BUG_ON(PageTail(page));
> > +       BUG_ON(atomic_read(&page->_count) > 1);
> > +       atomic_set(&page->_count, 1);
> > +       __free_page(page);
> > +       totalram_pages++;
> > +}
> > +
> > +void mpc512x_release_bootmem(void)
> > +{
> > +       unsigned long addr = diu_shared_fb.fb_phys & PAGE_MASK;
> > +       unsigned long size = diu_shared_fb.fb_len;
> > +       unsigned long start, end;
> > +
> > +       if (diu_shared_fb.in_use) {
> > +               start = PFN_UP(addr);
> > +               end = PFN_DOWN(addr + size);
> > +
> > +               for (; start < end; start++)
> > +                       mpc512x_free_bootmem(pfn_to_page(start));
> > +
> > +               diu_shared_fb.in_use = false;
> > +       }
> > +       diu_ops.release_bootmem = NULL;
> > +}
> > +#endif
> 
> Do you really need to use reserve_bootmem?  Have you tried kmalloc or
> alloc_pages_exact()?

Yes. No, it is too early to use them here.

> > +
> > +/*
> > + * Check if DIU was pre-initialized. If so, perform steps
> > + * needed to continue displaying through the whole boot process.
> > + * Move area descriptor and gamma table elsewhere, they are
> > + * destroyed by bootmem allocator otherwise. The frame buffer
> > + * address range will be reserved in setup_arch() after bootmem
> > + * allocator is up.
> > + */
> > +void __init mpc512x_init_diu(void)
> > +{
> > +       struct device_node *np;
> > +       void __iomem *diu_reg;
> > +       phys_addr_t desc;
> > +       void __iomem *vaddr;
> > +       unsigned long mode, pix_fmt, res, bpp;
> > +       unsigned long dst;
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
> > +       if (!np) {
> > +               pr_err("No DIU node\n");
> > +               return;
> > +       }
> 
> Shouldn't you be probing as an OF driver instead of manually searching
> for the DIU node?

No, not here.

> > +
> > +       diu_reg = of_iomap(np, 0);
> > +       of_node_put(np);
> > +       if (!diu_reg) {
> > +               pr_err("Can't map DIU\n");
> > +               return;
> > +       }
> > +
> > +       mode = in_be32(diu_reg + 0x1c);
> > +       if (mode != 1) {
> 
> How can in_be32() return a -1?

It is a 1, not -1. I will use appropriate macro here and also
change to use a struct instead of adding offset to register base.

Thanks for your review and comments!
Anatolij
