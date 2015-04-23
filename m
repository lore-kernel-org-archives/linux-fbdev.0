From: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 23 Apr 2015 08:20:10 +0000
Subject: Re: [PATCH v3 05/17] video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <alpine.DEB.2.10.1504231019190.3260@hadrien>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com> <1429647398-16983-6-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-6-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, luto@amacapital.net, cocci@systeme.lip6.fr, "Luis R. Rodriguez" <mcgrof@suse.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Geert Uytterhoeven <geert@linux-m68k.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Mikulas Patocka <mpatocka@redhat.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, linux-kernel@vger.kernel.org

> @ mtrr_found @
> expression index, base, size;
> @@
>
> -index = mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
> +index = arch_phys_wc_add(base, size);
>
> @ mtrr_rm depends on mtrr_found @
> expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
> @@
>
> -mtrr_del(index, base, size);
> +arch_phys_wc_del(index);
>
> @ mtrr_rm_zero_arg depends on mtrr_found @
> expression mtrr_found.index;
> @@
>
> -mtrr_del(index, 0, 0);
> +arch_phys_wc_del(index);
>
> @ mtrr_rm_fb_info depends on mtrr_found @
> struct fb_info *info;

Is this specific to the fb_info type?

julia


> expression mtrr_found.index;
> @@
>
> -mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
> +arch_phys_wc_del(index);
>
> @ ioremap_replace_nocache depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>
> -info->screen_base = ioremap_nocache(base, size);
> +info->screen_base = ioremap_wc(base, size);
>
> @ ioremap_replace_default depends on mtrr_found @
> struct fb_info *info;
> expression base, size;
> @@
>
> -info->screen_base = ioremap(base, size);
> +info->screen_base = ioremap_wc(base, size);
>
> Generated-by: Coccinelle SmPL
>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Suresh Siddha <sbsiddha@gmail.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Antonino Daplas <adaplas@gmail.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  drivers/video/fbdev/matrox/matroxfb_base.c | 36 +++++++++++-------------------
>  drivers/video/fbdev/matrox/matroxfb_base.h | 27 +---------------------
>  2 files changed, 14 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
> index 62539ca..2f70365 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.c
> @@ -370,12 +370,9 @@ static void matroxfb_remove(struct matrox_fb_info *minfo, int dummy)
>  	matroxfb_unregister_device(minfo);
>  	unregister_framebuffer(&minfo->fbcon);
>  	matroxfb_g450_shutdown(minfo);
> -#ifdef CONFIG_MTRR
> -	if (minfo->mtrr.vram_valid)
> -		mtrr_del(minfo->mtrr.vram, minfo->video.base, minfo->video.len);
> -#endif
> -	mga_iounmap(minfo->mmio.vbase);
> -	mga_iounmap(minfo->video.vbase);
> +	arch_phys_wc_del(minfo->wc_cookie);
> +	iounmap(minfo->mmio.vbase.vaddr);
> +	iounmap(minfo->video.vbase.vaddr);
>  	release_mem_region(minfo->video.base, minfo->video.len_maximum);
>  	release_mem_region(minfo->mmio.base, 16384);
>  	kfree(minfo);
> @@ -1256,9 +1253,7 @@ static int nobios;			/* "matroxfb:nobios" */
>  static int noinit = 1;			/* "matroxfb:init" */
>  static int inverse;			/* "matroxfb:inverse" */
>  static int sgram;			/* "matroxfb:sgram" */
> -#ifdef CONFIG_MTRR
>  static int mtrr = 1;			/* "matroxfb:nomtrr" */
> -#endif
>  static int grayscale;			/* "matroxfb:grayscale" */
>  static int dev = -1;			/* "matroxfb:dev:xxxxx" */
>  static unsigned int vesa = ~0;		/* "matroxfb:vesa:xxxxx" */
> @@ -1717,14 +1712,17 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
>  	if (mem && (mem < memsize))
>  		memsize = mem;
>  	err = -ENOMEM;
> -	if (mga_ioremap(ctrlptr_phys, 16384, MGA_IOREMAP_MMIO, &minfo->mmio.vbase)) {
> +
> +	minfo->mmio.vbase.vaddr = ioremap_nocache(ctrlptr_phys, 16384);
> +	if (!minfo->mmio.vbase.vaddr) {
>  		printk(KERN_ERR "matroxfb: cannot ioremap(%lX, 16384), matroxfb disabled\n", ctrlptr_phys);
>  		goto failVideoMR;
>  	}
>  	minfo->mmio.base = ctrlptr_phys;
>  	minfo->mmio.len = 16384;
>  	minfo->video.base = video_base_phys;
> -	if (mga_ioremap(video_base_phys, memsize, MGA_IOREMAP_FB, &minfo->video.vbase)) {
> +	minfo->video.vbase.vaddr = ioremap_wc(video_base_phys, memsize);
> +	if (!minfo->video.vbase.vaddr) {
>  		printk(KERN_ERR "matroxfb: cannot ioremap(%lX, %d), matroxfb disabled\n",
>  			video_base_phys, memsize);
>  		goto failCtrlIO;
> @@ -1772,13 +1770,9 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
>  	minfo->video.len_usable = minfo->video.len;
>  	if (minfo->video.len_usable > b->base->maxdisplayable)
>  		minfo->video.len_usable = b->base->maxdisplayable;
> -#ifdef CONFIG_MTRR
> -	if (mtrr) {
> -		minfo->mtrr.vram = mtrr_add(video_base_phys, minfo->video.len, MTRR_TYPE_WRCOMB, 1);
> -		minfo->mtrr.vram_valid = 1;
> -		printk(KERN_INFO "matroxfb: MTRR's turned on\n");
> -	}
> -#endif	/* CONFIG_MTRR */
> +	if (mtrr)
> +		minfo->wc_cookie = arch_phys_wc_add(video_base_phys,
> +						    minfo->video.len);
>
>  	if (!minfo->devflags.novga)
>  		request_region(0x3C0, 32, "matrox");
> @@ -1947,9 +1941,9 @@ static int initMatrox2(struct matrox_fb_info *minfo, struct board *b)
>  	return 0;
>  failVideoIO:;
>  	matroxfb_g450_shutdown(minfo);
> -	mga_iounmap(minfo->video.vbase);
> +	iounmap(minfo->video.vbase.vaddr);
>  failCtrlIO:;
> -	mga_iounmap(minfo->mmio.vbase);
> +	iounmap(minfo->mmio.vbase.vaddr);
>  failVideoMR:;
>  	release_mem_region(video_base_phys, minfo->video.len_maximum);
>  failCtrlMR:;
> @@ -2443,10 +2437,8 @@ static int __init matroxfb_setup(char *options) {
>  				nobios = !value;
>  			else if (!strcmp(this_opt, "init"))
>  				noinit = !value;
> -#ifdef CONFIG_MTRR
>  			else if (!strcmp(this_opt, "mtrr"))
>  				mtrr = value;
> -#endif
>  			else if (!strcmp(this_opt, "inv24"))
>  				inv24 = value;
>  			else if (!strcmp(this_opt, "cross4MB"))
> @@ -2515,10 +2507,8 @@ module_param(noinit, int, 0);
>  MODULE_PARM_DESC(noinit, "Disables W/SG/SD-RAM and bus interface initialization (0 or 1=do not initialize) (default=0)");
>  module_param(memtype, int, 0);
>  MODULE_PARM_DESC(memtype, "Memory type for G200/G400 (see Documentation/fb/matroxfb.txt for explanation) (default=3 for G200, 0 for G400)");
> -#ifdef CONFIG_MTRR
>  module_param(mtrr, int, 0);
>  MODULE_PARM_DESC(mtrr, "This speeds up video memory accesses (0=disabled or 1) (default=1)");
> -#endif
>  module_param(sgram, int, 0);
>  MODULE_PARM_DESC(sgram, "Indicates that G100/G200/G400 has SGRAM memory (0=SDRAM, 1=SGRAM) (default=0)");
>  module_param(inv24, int, 0);
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/fbdev/matrox/matroxfb_base.h
> index 89a8a89a..09b02cd 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.h
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.h
> @@ -44,9 +44,6 @@
>
>  #include <asm/io.h>
>  #include <asm/unaligned.h>
> -#ifdef CONFIG_MTRR
> -#include <asm/mtrr.h>
> -#endif
>
>  #if defined(CONFIG_PPC_PMAC)
>  #include <asm/prom.h>
> @@ -187,23 +184,6 @@ static inline void __iomem* vaddr_va(vaddr_t va) {
>  	return va.vaddr;
>  }
>
> -#define MGA_IOREMAP_NORMAL	0
> -#define MGA_IOREMAP_NOCACHE	1
> -
> -#define MGA_IOREMAP_FB		MGA_IOREMAP_NOCACHE
> -#define MGA_IOREMAP_MMIO	MGA_IOREMAP_NOCACHE
> -static inline int mga_ioremap(unsigned long phys, unsigned long size, int flags, vaddr_t* virt) {
> -	if (flags & MGA_IOREMAP_NOCACHE)
> -		virt->vaddr = ioremap_nocache(phys, size);
> -	else
> -		virt->vaddr = ioremap(phys, size);
> -	return (virt->vaddr = NULL); /* 0, !0... 0, error_code in future */
> -}
> -
> -static inline void mga_iounmap(vaddr_t va) {
> -	iounmap(va.vaddr);
> -}
> -
>  struct my_timming {
>  	unsigned int pixclock;
>  	int mnp;
> @@ -449,12 +429,7 @@ struct matrox_fb_info {
>  		int		plnwt;
>  		int		srcorg;
>  			      } capable;
> -#ifdef CONFIG_MTRR
> -	struct {
> -		int		vram;
> -		int		vram_valid;
> -			      } mtrr;
> -#endif
> +	int			wc_cookie;
>  	struct {
>  		int		precise_width;
>  		int		mga_24bpp_fix;
> --
> 2.3.2.209.gd67f9d5.dirty
>
>
