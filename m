From: krzysztof.h1@poczta.fm
Subject: Re: [Linux-fbdev-devel] [PATCH 1/4] video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver part 1/3
Date: 25 Jun 2008 10:29:14 +0200
Message-ID: <20080625082914.E208721C824@f28.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="us-ascii"
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>, "Linux-fbdev-devel@lists.sourceforge.net" <Linux-fbdev-devel@lists.sourceforge.net>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

> Main source code of Driver for the LCDC interface on the SH7760 and SH7763
> SoCs.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> ---
>  drivers/video/sh7760fb.c |  717
> ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 717 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/sh7760fb.c
> 
> diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
> new file mode 100644
> index 0000000..57b1dfb
> --- /dev/null
> +++ b/drivers/video/sh7760fb.c
> @@ -0,0 +1,717 @@
> +/* palette */
> +#define LDPR(x)		(((x) << 2))
> +
> +/* registers and bits */
> +#define LDICKR		0x400
> +#define LDMTR		0x402
> +/* see sh7760fb.h for LDMTR bits */
> +#define LDDFR		0x404
> +#define LDDFR_PABD	(1 << 8)
> +#define LDDFR_COLOR_MASK	0x7F
> +#define LDSMR		0x406
> +#define LDSMR_ROT	(1 << 13)
> +#define LDSARU		0x408
> +#define LDSARL		0x40c
> +#define LDLAOR		0x410
> +#define LDPALCR		0x412
> +#define LDHCNR		0x414
> +#define LDHSYNR		0x416
> +#define LDVDLNR		0x418
> +#define LDVTLNR		0x41a
> +#define LDVSYNR		0x41c
> +#define LDACLNR		0x41e
> +#define LDINTR		0x420
> +#define LDPMMR		0x424
> +#define LDPSPR		0x426
> +#define LDCNTR		0x428
> +#define LDCNTR_DON	(1 << 0)
> +#define LDCNTR_DON2	(1 << 4)
> +#ifdef CONFIG_CPU_SUBTYPE_SH7763
> +# define LDLIRNR	0x440
> +#endif
> +

These definitions should be moved to the header file. Part of bits definitions are there and I suppose these bits are related to registers.

> +/*
> + * some bits of the colormap registers should be written as zero.
> + * create a mask for that.
> + */
> +#define SH7760FB_PALETTE_MASK    0x00f8fcf8
> +
> +/* The LCDC dma engine always sets bits 27-26 to 1: this is Area3 */
> +#define SH7760FB_DMA_MASK      0x0C000000
> +
> +struct sh7760fb_par {
> +	void __iomem *base;
> +	struct sh7760fb_platdata *pd;	/* display information */
> +
> +	/* framebuffer memory information */
> +	void *fbmem;		/* alloced framebuffer */
> +	dma_addr_t fbdma;	/* physical address */
> +	unsigned long vram;	/* size, in bytes */

The fields fbmem and vram are redundant as you can use smem_start/smem_len or or screen_base/screen_size to store the same information (and you do it anyway).

> +	unsigned long stride;
> +

The line_length field is the same (redundant).

> +	int rot;		/* rotation enabled? */
> +	int disp_set;	/* parameters already set? */
> +	u32 pseudo_palette[16];
> +	struct platform_device *dev;
> +	struct resource *ioarea;
> +};
> +

(...)


> +/* en/disable the LCDC */
> +static int sh7760fb_blank(int blank, struct fb_info *info)
> +{
> +	struct sh7760fb_par *par = info->par;
> +	struct sh7760fb_platdata *pd = par->pd;
> +	unsigned short cntr = IN16(par, LDCNTR);
> +	int lps;
> +
> +	if (blank == FB_BLANK_UNBLANK) {
> +		cntr = LDCNTR_DON2 | LDCNTR_DON;
> +		lps = 3;
> +		if (pd->blank)
> +			pd->blank(blank);

Probably pd->blank can be moved outside the if-else stantement.

> +	} else {
> +		if (pd->blank)
> +			pd->blank(blank);
> +		cntr = LDCNTR_DON2;
> +		lps = 0;
> +	}
> +
> +	OUT16(par, LDCNTR, cntr);
> +
> +	wait_for_lps(par, lps);
> +
> +	return 0;
> +}
> +

(...)

> +static int sh7760fb_set_par(struct fb_info *info)
> +{
> +	struct fb_var_screeninfo *var = &info->var;
> +	struct sh7760fb_par *par = info->par;
> +	struct fb_videomode *vm = par->pd->def_mode;
> +	unsigned long sbase, dstn_off, ldsarl, stride;
> +	unsigned short hsynp, hsynw, htcn, hdcn;
> +	unsigned short vsynp, vsynw, vtln, vdln;
> +	unsigned short lddfr, ldmtr;
> +	int bpp, gray;
> +
> +	if (par->disp_set)
> +		return 0;
> +

Is there any specific reason you cannot do disp_set twice? It means that the framebuffer is not able to change display depth at runtime. Probably you can drop the disp_set field completely. If the registers are programmed twice to the same values it should do no harm.

> +	par->rot = par->pd->rotate;
> +
> +	/* rotate only works with xres <= 320 */
> +	if (par->rot && (vm->xres > 320)) {
> +		fb_msg("rotation disabled due to display sizen");
> +		par->rot = 0;
> +	}
> +
> +	/* calculate LCDC reg vals from display parameters */
> +	hsynp = vm->right_margin + vm->xres;
> +	hsynw = vm->hsync_len;
> +	htcn = vm->left_margin + hsynp + hsynw;
> +	hdcn = vm->xres;
> +	vsynp = vm->lower_margin + vm->yres;
> +	vsynw = vm->vsync_len;
> +	vtln = vm->upper_margin + vsynp + vsynw;
> +	vdln = vm->yres;
> +
> +	bpp = gray = 0;

There is no reason to set the bpp (it is set in all cases).

> +	switch (par->pd->lddfr & LDDFR_COLOR_MASK) {
> +	case LDDFR_1BPP_MONO:
> +		gray = 1;
> +		bpp = 1;
> +		break;
> +	case LDDFR_2BPP_MONO:
> +		gray = 1;
> +		bpp = 2;
> +		break;
> +	case LDDFR_4BPP_MONO:
> +		gray = 1;
> +	case LDDFR_4BPP:
> +		bpp = 4;
> +		break;
> +	case LDDFR_6BPP_MONO:
> +		gray = 1;
> +	case LDDFR_8BPP:
> +		bpp = 8;
> +		break;
> +	case LDDFR_16BPP_RGB555:
> +	case LDDFR_16BPP_RGB565:
> +		bpp = 16;
> +		break;
> +	}
> +
> +	var->bits_per_pixel = bpp;
> +

The changes in fbinfo->var is allowed only in the check_var function (see skeletonfb.c foe explanations). You should move the code which changes the var structure into the check_var functions and get some code reduction.

> +	fb_msg("%dx%d %dbpp %s (orientation %s)n", hdcn, vdln, bpp,
> +	       gray ? "grayscale" : "color", par->rot ? "rotated" : "normal");
> +
> +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> +	lddfr = par->pd->lddfr | (1 << 8);
> +#else
> +	lddfr = par->pd->lddfr & ~(1 << 8);
> +#endif
> +
> +	ldmtr = par->pd->ldmtr;
> +


> +/* free framebuffer memory */
> +static void sh7760fb_free_mem(struct fb_info *info)
> +{
> +	struct sh7760fb_par *par = info->par;
> +
> +	if (!par->fbmem)
> +		return;
> +
> +	dma_free_coherent(info->dev, par->vram, par->fbmem, par->fbdma);
> +
> +	par->fbmem = NULL;
> +	par->fbdma = 0;
> +	info->screen_base = NULL;
> +	info->screen_size = 0;

Just use the screen_base/screen_size instead of the fbmem/vram fields.

> +/* register the framebuffer device */
> +static int __devinit sh7760fb_probe(struct platform_device *pdev)
> +{
> +	struct fb_info *info;
> +	struct resource *res;
> +	struct sh7760fb_par *par;
> +	int ret;
> +
> +	/* Get base addr */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (unlikely(res == NULL)) {
> +		dev_err(&pdev->dev, "invalid resourcen");
> +		return -EINVAL;
> +	}
> +
> +	info = framebuffer_alloc(sizeof(struct sh7760fb_par), &pdev->dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	par = info->par;
> +	par->dev = pdev;
> +
> +	info->pseudo_palette = par->pseudo_palette;
> +	par->pd = pdev->dev.platform_data;
> +	if (!par->pd) {
> +		fb_msg("no display setup data!n");
> +		ret = -ENODEV;
> +		goto out_fb;
> +	}
> +
> +	fb_videomode_to_var(&info->var, par->pd->def_mode);
> +
> +	/* fixup color register bitpositions. These are fixed by hardware */
> +	info->var.red.offset = 11;
> +	info->var.red.length = 5;
> +	info->var.red.msb_right = 0;
> +
> +	info->var.green.offset = 5;
> +	info->var.green.length = 6;
> +	info->var.green.msb_right = 0;
> +
> +	info->var.blue.offset = 0;
> +	info->var.blue.length = 5;
> +	info->var.blue.msb_right = 0;
> +
> +	info->var.transp.offset = 0;
> +	info->var.transp.length = 0;
> +	info->var.transp.msb_right = 0;

These could be done in the check_var call. It is ok if this must be the same for all color depths.

> +
> +	par->ioarea = request_mem_region(res->start,
> +			(res->end - res->start), pdev->name);
> +	if (!par->ioarea) {
> +		dev_err(&pdev->dev, "mmio area busyn");
> +		ret = -EBUSY;
> +		goto out_fb;
> +	}
> +
> +	par->base = ioremap_nocache(res->start, (res->end - res->start));
> +	if (!par->base) {
> +		dev_err(&pdev->dev, "cannot remapn");
> +		ret = -ENODEV;
> +		goto out_res;
> +	}
> +
> +	ret = sh7760fb_alloc_mem(info);
> +	if (ret) {
> +		fb_msg("framebuffer memory allocation failed!n");
> +		goto out_unmap;
> +	}
> +
> +	/* set the DON2 bit now; this will randomize palette memory.
> +	 * do it now so the palette does not get destroyed when blanking
> +	 */
> +	OUT16(par, LDCNTR_DON2, LDCNTR);
> +	info->fbops = &sh7760fb_ops;
> +	fb_alloc_cmap(&info->cmap, 256, 0);
> +

Check if the cmap was correctly allocated and release it on error below (if the framebuffer is not registered).

> +	/* activate, get info->fix */
> +	sh7760fb_set_par(info);
> +
> +	ret = register_framebuffer(info);
> +	if (ret < 0) {
> +		/* stop LCDC before freeing ram */
> +		sh7760fb_blank(FB_BLANK_POWERDOWN, info);
> +		fb_msg("cannot register fb!n");
> +		goto out_mem;
> +	}
> +	platform_set_drvdata(pdev, info);
> +
> +	fb_msg("memory at phys 0x%08lx-0x%08lx, size %ld KiBn",
> +	       (unsigned long)par->fbdma,
> +	       (unsigned long)(par->fbdma + par->vram - 1), par->vram >> 10);
> +
> +	return 0;
> +
> +out_mem:
> +	sh7760fb_free_mem(info);
> +out_unmap:
> +	iounmap(par->base);
> +out_res:
> +	release_resource(par->ioarea);
> +	kfree(par->ioarea);
> +out_fb:
> +	framebuffer_release(info);
> +	return ret;
> +}
> +



Regards,
Krzysztof


----------------------------------------------------------------------
Pogoda na dzis.
Sprawdz >>> http://link.interia.pl/f1e42

