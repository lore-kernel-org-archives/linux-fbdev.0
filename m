From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Subject: [PATCH v2 1/4] video: sh7760fb: SH7760/SH7763
 LCDC framebuffer driver part 1/3
Date: Thu, 26 Jun 2008 14:44:15 +0900
Message-ID: <48632CAF.3090703@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KBkHQ-0003hv-68 for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 22:44:24 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail01.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KBkHP-0003ya-7x
	for Linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jun 2008 22:44:24 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>

Main source code of Driver for the LCDC interface on the SH7760 and SH7763 SoCs.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/video/sh7760fb.c |  671 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 671 insertions(+), 0 deletions(-)
 create mode 100644 drivers/video/sh7760fb.c

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
new file mode 100644
index 0000000..53b1fde
--- /dev/null
+++ b/drivers/video/sh7760fb.c
@@ -0,0 +1,671 @@
+/*
+ * SH7760/63 LCDC Framebuffer driver.
+ *
+ * (c) 2006-2008 MSC Vertriebsges.m.b.H., Manuel Lauss.
+ * (c) 2008 Nobuhiro Iwamatsu
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ * PLEASE HAVE A LOOK AT Documentation/fb/sh7760fb.txt!
+ *
+ * Thanks to Siegfried Schaefer <s.schaefer schaefer-edv.de>
+ *     for his original source and testing!
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/fb.h>
+#include <linux/gfp.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <linux/io.h>
+#include <asm/sh7760fb.h>
+
+#define fb_msg(args...)        \
+       do { printk(KERN_ALERT "sh7760fb: " args); } while (0)
+#if 0
+#define dbg(args...) fb_msg(args)
+#else
+#define dbg(fmt, args...) do { } while (0)
+#endif
+
+/*
+ * some bits of the colormap registers should be written as zero.
+ * create a mask for that.
+ */
+#define SH7760FB_PALETTE_MASK    0x00f8fcf8
+
+/* The LCDC dma engine always sets bits 27-26 to 1: this is Area3 */
+#define SH7760FB_DMA_MASK      0x0C000000
+
+struct sh7760fb_par {
+	void __iomem *base;
+	struct sh7760fb_platdata *pd;	/* display information */
+
+	/* framebuffer memory information */
+	dma_addr_t fbdma;	/* physical address */
+
+	int rot;		/* rotation enabled? */
+	int disp_set;	/* parameters already set? */
+	u32 pseudo_palette[16];
+	struct platform_device *dev;
+	struct resource *ioarea;
+};
+
+static inline void OUT16(struct sh7760fb_par *par, int reg, unsigned short v)
+{
+	iowrite16(v, par->base + reg);
+}
+
+static inline unsigned short IN16(struct sh7760fb_par *par, int reg)
+{
+	return ioread16(par->base + reg);
+}
+
+static inline void OUT32(struct sh7760fb_par *par, int reg, unsigned long v)
+{
+	iowrite32(v, par->base + reg);
+}
+
+static inline unsigned long IN32(struct sh7760fb_par *par, int reg)
+{
+	return ioread32(par->base + reg);
+}
+
+static void sh7760fb_wait_vsync(struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+
+	if (par->pd->novsync)
+		return;
+/*
+	while (IN16(par, LDINTR) & 1)
+		OUT16(par, LDINTR, 0x1100);
+*/
+}
+
+
+/*
+ * wait_for_lps - wait until power supply has reached a certain state.
+ * @val:       bitmask to wait for.
+ */
+static void wait_for_lps(struct sh7760fb_par *par, int val)
+{
+	int i = 100;
+	while (--i && ((IN16(par, LDPMMR) & 3) != val))
+		msleep(1);
+}
+
+/* en/disable the LCDC */
+static int sh7760fb_blank(int blank, struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+	struct sh7760fb_platdata *pd = par->pd;
+	unsigned short cntr = IN16(par, LDCNTR);
+	int lps;
+
+	if (blank == FB_BLANK_UNBLANK) {
+		cntr = LDCNTR_DON2 | LDCNTR_DON;
+		lps = 3;
+	} else {
+		cntr = LDCNTR_DON2;
+		lps = 0;
+	}
+
+	if (pd->blank)
+		pd->blank(blank);
+
+	OUT16(par, LDCNTR, cntr);
+
+	wait_for_lps(par, lps);
+
+	return 0;
+}
+
+/* set color registers */
+static int sh7760fb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+	u32 s = cmap->start;
+	u32 l = cmap->len;
+	u16 *r = cmap->red;
+	u16 *g = cmap->green;
+	u16 *b = cmap->blue;
+	u32 col, tmo;
+	int ret;
+
+	ret = 0;
+
+	/* wait for vsync */
+	sh7760fb_wait_vsync(info);
+
+	/* request palette access */
+	OUT16(par, LDPALCR, 1);
+
+	/* poll for access grant */
+	tmo = 100;
+	while (!(IN16(par, LDPALCR) & (1 << 4)) && (--tmo))
+		msleep(0);
+
+	if (!tmo) {
+		ret = 1;
+		pr_debug("sh7760fb: no palette access!\n");
+		goto out;
+	}
+
+	while (l && (s < 256)) {
+		col = ((*r) & 0xff) << 16;
+		col |= ((*g) & 0xff) << 8;
+		col |= ((*b) & 0xff);
+		col &= SH7760FB_PALETTE_MASK;
+		OUT32(par, LDPR(s), col);
+		if (s < 16)
+			((u32 *) (info->pseudo_palette))[s] = s;
+
+		s++;
+		l--;
+		r++;
+		g++;
+		b++;
+	}
+out:
+	OUT16(par, LDPALCR, 0);
+	return ret;
+}
+
+static void encode_fix(struct fb_fix_screeninfo *fix, struct fb_info *info,
+		unsigned long stride)
+{
+	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+	strcpy(fix->id, "sh7760fb");
+
+	fix->smem_start = (unsigned long)info->screen_base;
+	fix->smem_len = info->screen_size;
+
+	fix->line_length = stride;
+}
+
+static int sh7760fb_get_color_info(u16 lddfr, int *bpp, int *gray)
+{
+	int lbpp, lgray;
+
+	switch (lddfr & LDDFR_COLOR_MASK) {
+	case LDDFR_1BPP_MONO:
+		lgray = 1;
+		lbpp = 1;
+		break;
+	case LDDFR_2BPP_MONO:
+		lgray = 1;
+		lbpp = 2;
+		break;
+	case LDDFR_4BPP_MONO:
+		lgray = 1;
+	case LDDFR_4BPP:
+		lbpp = 4;
+		break;
+	case LDDFR_6BPP_MONO:
+		lgray = 1;
+	case LDDFR_8BPP:
+		lbpp = 8;
+		break;
+	case LDDFR_16BPP_RGB555:
+	case LDDFR_16BPP_RGB565:
+		lbpp = 16;
+		lgray = 0;
+		break;
+	default:
+		fb_msg("unsupported LDDFR bit depth.\n");
+		return -EINVAL;
+	}
+
+	if (bpp)
+		*bpp = lbpp;
+	if (gray)
+		*gray = lgray;
+
+	return 0;
+}
+
+static int sh7760fb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *info)
+{
+	struct fb_fix_screeninfo *fix = &info->fix;
+	struct sh7760fb_par *par = info->par;
+	int ret, bpp;
+
+	/* get color info from register value */
+	ret = sh7760fb_get_color_info(par->pd->lddfr, &bpp, NULL);
+	if (ret)
+		return ret;
+
+	var->bits_per_pixel = bpp;
+
+	if ((var->grayscale) && (var->bits_per_pixel == 1))
+		fix->visual = FB_VISUAL_MONO10;
+	else if (var->bits_per_pixel >= 15)
+		fix->visual = FB_VISUAL_TRUECOLOR;
+	else
+		fix->visual = FB_VISUAL_PSEUDOCOLOR;
+
+	/* TODO: add some more validation here */
+	return 0;
+}
+
+/*
+ * sh7760fb_set_par - set videomode.
+ * @info:      ptr to fb_info structure with mode info.
+ * @return:    success.
+ *
+ * Set up video mode as described in info->var.
+ * NOTE: The rotation, grayscale and DSTN codepaths are
+ *     totally untested!
+ */
+static int sh7760fb_set_par(struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+	struct fb_videomode *vm = par->pd->def_mode;
+	unsigned long sbase, dstn_off, ldsarl, stride;
+	unsigned short hsynp, hsynw, htcn, hdcn;
+	unsigned short vsynp, vsynw, vtln, vdln;
+	unsigned short lddfr, ldmtr;
+	int ret, bpp, gray;
+
+	par->rot = par->pd->rotate;
+
+	/* rotate only works with xres <= 320 */
+	if (par->rot && (vm->xres > 320)) {
+		fb_msg("rotation disabled due to display size\n");
+		par->rot = 0;
+	}
+
+	/* calculate LCDC reg vals from display parameters */
+	hsynp = vm->right_margin + vm->xres;
+	hsynw = vm->hsync_len;
+	htcn = vm->left_margin + hsynp + hsynw;
+	hdcn = vm->xres;
+	vsynp = vm->lower_margin + vm->yres;
+	vsynw = vm->vsync_len;
+	vtln = vm->upper_margin + vsynp + vsynw;
+	vdln = vm->yres;
+
+	/* get color info from register value */
+	ret = sh7760fb_get_color_info(par->pd->lddfr, &bpp, &gray);
+	if (ret)
+		return ret;
+
+	fb_msg("%dx%d %dbpp %s (orientation %s)\n", hdcn, vdln, bpp,
+	       gray ? "grayscale" : "color", par->rot ? "rotated" : "normal");
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	lddfr = par->pd->lddfr | (1 << 8);
+#else
+	lddfr = par->pd->lddfr & ~(1 << 8);
+#endif
+
+	ldmtr = par->pd->ldmtr;
+
+	if (!(vm->sync & FB_SYNC_HOR_HIGH_ACT))
+		ldmtr |= LDMTR_CL1POL;
+	if (!(vm->sync & FB_SYNC_VERT_HIGH_ACT))
+		ldmtr |= LDMTR_FLMPOL;
+
+	/* shut down LCDC before changing display parameters */
+	sh7760fb_blank(FB_BLANK_POWERDOWN, info);
+
+	OUT16(par, LDICKR, par->pd->ldickr); /* pixclock */
+	OUT16(par, LDMTR, ldmtr); /* polarities */
+	OUT16(par, LDDFR, lddfr); /* color/depth */
+	OUT16(par, LDSMR, (par->rot ? 1 << 13 : 0)); /* rotate */
+	OUT16(par, LDPMMR, par->pd->ldpmmr); /* Power Management */
+	OUT16(par, LDPSPR, par->pd->ldpspr); /* Power Supply Ctrl */
+
+	/* display resolution */
+	OUT16(par, LDHCNR, ((htcn >> 3) - 1) | (((hdcn >> 3) - 1) << 8));
+	OUT16(par, LDVDLNR, vdln - 1);
+	OUT16(par, LDVTLNR, vtln - 1);
+	/* h/v sync signals */
+	OUT16(par, LDVSYNR, (vsynp - 1) | ((vsynw - 1) << 12));
+	OUT16(par, LDHSYNR, ((hsynp >> 3) - 1) | (((hsynw >> 3) - 1) << 12));
+	OUT16(par, LDACLNR, par->pd->ldaclnr);	/* AC modulation sig */
+
+	stride = (par->rot) ? vtln : hdcn;
+	if (!gray)
+		stride *= (bpp + 7) >> 3;
+	else {
+		if (bpp == 1)
+			stride >>= 3;
+		else if (bpp == 2)
+			stride >>= 2;
+		else if (bpp == 4)
+			stride >>= 1;
+		/* 6 bpp == 8 bpp */
+	}
+
+	/* if rotated, stride must be power of 2 */
+	if (par->rot) {
+		unsigned long bit = 1 << 31;
+		while (bit) {
+			if (stride & bit)
+				break;
+			bit >>= 1;
+		}
+		if (stride & ~bit)
+			stride = bit << 1;	/* not P-o-2, round up */
+	}
+	OUT16(par, LDLAOR, stride);
+	/* set display mem start address */
+	sbase = (unsigned long)par->fbdma;
+	if (par->rot)
+		sbase += (hdcn - 1) * stride;
+
+	OUT32(par, LDSARU, sbase);
+
+	/*
+	 * for DSTN need to set address for lower half.
+	 * I (mlau) don't know which address to set it to,
+	 * so I guessed at (stride * yres/2).
+	 */
+	if (((ldmtr & 0x003f) >= LDMTR_DSTN_MONO_8) &&
+	    ((ldmtr & 0x003f) <= LDMTR_DSTN_COLOR_16)) {
+
+		pr_debug(" ***** DSTN untested! *****\n");
+
+		dstn_off = stride;
+		if (par->rot)
+			dstn_off *= hdcn >> 1;
+		else
+			dstn_off *= vdln >> 1;
+
+		ldsarl = sbase + dstn_off;
+	} else
+		ldsarl = 0;
+
+	OUT32(par, LDSARL, ldsarl);	/* mem for lower half of DSTN */
+
+	encode_fix(&info->fix, info, stride);
+	sh7760fb_check_var(&info->var, info);
+
+	sh7760fb_blank(FB_BLANK_UNBLANK, info);	/* panel on! */
+
+	par->disp_set = 1;
+
+	dbg("hdcn  : %6d htcn  : %6d\n", hdcn, htcn);
+	dbg("hsynw : %6d hsynp : %6d\n", hsynw, hsynp);
+	dbg("vdln  : %6d vtln  : %6d\n", vdln, vtln);
+	dbg("vsynw : %6d vsynp : %6d\n", vsynw, vsynp);
+	dbg("clksrc: %6d clkdiv: %6d\n", (par->pd->ldickr >> 12) & 3,
+	    par->pd->ldickr & 0x1f);
+	dbg("ldpmmr: 0x%04x ldpspr: 0x%04x\n", par->pd->ldpmmr,
+	    par->pd->ldpspr);
+	dbg("ldmtr : 0x%04x lddfr : 0x%04x\n", ldmtr, lddfr);
+	dbg("ldlaor: %6d\n", stride);
+	dbg("ldsaru: 0x%08lx ldsarl: 0x%08lx\n", sbase, ldsarl);
+
+	return 0;
+}
+
+static struct fb_ops sh7760fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_blank = sh7760fb_blank,
+	.fb_check_var = sh7760fb_check_var,
+	.fb_setcmap = sh7760fb_setcmap,
+	.fb_set_par = sh7760fb_set_par,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+};
+
+/* free framebuffer memory */
+static void sh7760fb_free_mem(struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+
+	if (!info->screen_base)
+		return;
+
+	dma_free_coherent(info->dev, info->screen_size,
+			info->screen_base, par->fbdma);
+
+	par->fbdma = 0;
+	info->screen_base = NULL;
+	info->screen_size = 0;
+}
+
+/* allocate the framebuffer memory. This memory must be in Area3,
+ * (dictated by the DMA engine) and contiguous, at a 512 byte boundary.
+ */
+static int sh7760fb_alloc_mem(struct fb_info *info)
+{
+	struct sh7760fb_par *par = info->par;
+	void *fbmem;
+	unsigned long vram;
+	int ret, bpp;
+
+	if (info->screen_base)
+		return 0;
+
+	/* get color info from register value */
+	ret = sh7760fb_get_color_info(par->pd->lddfr, &bpp, NULL);
+	if (ret)
+		return ret;
+
+	/* min VRAM: xres_min = 16, yres_min = 1, bpp = 1: 2byte -> 1 page
+	   max VRAM: xres_max = 1024, yres_max = 1024, bpp = 16: 2MB */
+
+	vram = info->var.xres * info->var.yres;
+	if (info->var.grayscale) {
+		if (bpp == 1)
+			vram >>= 3;
+		else if (bpp == 2)
+			vram >>= 2;
+		else if (bpp == 4)
+			vram >>= 1;
+	} else if (bpp > 8)
+		vram *= 2;
+	if ((vram < 1) || (vram > 1024 * 2048)) {
+		fb_msg("too much VRAM required. Check settings\n");
+		return -ENODEV;
+	}
+
+	if (vram < PAGE_SIZE)
+		vram = PAGE_SIZE;
+
+	fbmem =
+	    dma_alloc_coherent(info->dev, vram, &par->fbdma, GFP_KERNEL);
+
+	if (!fbmem)
+		return -ENOMEM;
+
+	if ((par->fbdma & SH7760FB_DMA_MASK) != SH7760FB_DMA_MASK) {
+		sh7760fb_free_mem(info);
+		fb_msg("kernel gave me memory at 0x%08lx, which is"
+		       "unusable for the LCDC\n", (unsigned long)par->fbdma);
+		return -ENOMEM;
+	}
+
+	info->screen_base = fbmem;
+	info->screen_size = vram;
+
+	return 0;
+}
+
+/* register the framebuffer device */
+static int __devinit sh7760fb_probe(struct platform_device *pdev)
+{
+	struct fb_info *info;
+	struct resource *res;
+	struct sh7760fb_par *par;
+	int ret;
+
+	/* Get base addr */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(res == NULL)) {
+		dev_err(&pdev->dev, "invalid resource\n");
+		return -EINVAL;
+	}
+
+	info = framebuffer_alloc(sizeof(struct sh7760fb_par), &pdev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	par = info->par;
+	par->dev = pdev;
+
+	info->pseudo_palette = par->pseudo_palette;
+	par->pd = pdev->dev.platform_data;
+	if (!par->pd) {
+		fb_msg("no display setup data!\n");
+		ret = -ENODEV;
+		goto out_fb;
+	}
+
+	fb_videomode_to_var(&info->var, par->pd->def_mode);
+
+	/* fixup color register bitpositions. These are fixed by hardware */
+	info->var.red.offset = 11;
+	info->var.red.length = 5;
+	info->var.red.msb_right = 0;
+
+	info->var.green.offset = 5;
+	info->var.green.length = 6;
+	info->var.green.msb_right = 0;
+
+	info->var.blue.offset = 0;
+	info->var.blue.length = 5;
+	info->var.blue.msb_right = 0;
+
+	info->var.transp.offset = 0;
+	info->var.transp.length = 0;
+	info->var.transp.msb_right = 0;
+
+	par->ioarea = request_mem_region(res->start,
+			(res->end - res->start), pdev->name);
+	if (!par->ioarea) {
+		dev_err(&pdev->dev, "mmio area busy\n");
+		ret = -EBUSY;
+		goto out_fb;
+	}
+
+	par->base = ioremap_nocache(res->start, (res->end - res->start));
+	if (!par->base) {
+		dev_err(&pdev->dev, "cannot remap\n");
+		ret = -ENODEV;
+		goto out_res;
+	}
+
+	ret = sh7760fb_alloc_mem(info);
+	if (ret) {
+		fb_msg("framebuffer memory allocation failed!\n");
+		goto out_unmap;
+	}
+
+	/* set the DON2 bit now; this will randomize palette memory.
+	 * do it now so the palette does not get destroyed when blanking
+	 */
+	OUT16(par, LDCNTR_DON2, LDCNTR);
+	info->fbops = &sh7760fb_ops;
+
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
+	if (ret) {
+		fb_msg("Unable to allocate cmap memory\n");
+		goto out_mem;
+	}
+
+	ret = register_framebuffer(info);
+	if (ret < 0) {
+		/* stop LCDC before freeing ram */
+		sh7760fb_blank(FB_BLANK_POWERDOWN, info);
+		fb_msg("cannot register fb!\n");
+		goto out_cmap;
+	}
+	platform_set_drvdata(pdev, info);
+
+	fb_msg("memory at phys 0x%08lx-0x%08lx, size %ld KiB\n",
+	       (unsigned long)par->fbdma,
+	       (unsigned long)(par->fbdma + info->screen_size - 1),
+		   info->screen_size >> 10);
+
+	return 0;
+
+out_cmap:
+	fb_dealloc_cmap(&info->cmap);
+out_mem:
+	sh7760fb_free_mem(info);
+out_unmap:
+	iounmap(par->base);
+out_res:
+	release_resource(par->ioarea);
+	kfree(par->ioarea);
+out_fb:
+	framebuffer_release(info);
+	return ret;
+}
+
+static int __devexit sh7760fb_remove(struct platform_device *dev)
+{
+	struct fb_info *info = platform_get_drvdata(dev);
+	struct sh7760fb_par *par = info->par;
+
+	sh7760fb_blank(FB_BLANK_POWERDOWN, info);
+	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
+	sh7760fb_free_mem(info);
+	iounmap(par->base);
+	release_resource(par->ioarea);
+	kfree(par->ioarea);
+	framebuffer_release(info);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int sh7760fb_suspend(struct platform_device *dev, u32 level)
+{
+	dbg("sh7760fb_suspend()\n");
+	return 0;
+}
+
+static int sh7760fb_resume(struct platform_device *dev, u32 level)
+{
+	dbg("sh7760fb_resume()\n");
+	return 0;
+}
+#else
+#define sh7760fb_suspend	NULL
+#define sh7760fb_resume		NULL
+#endif
+
+static struct platform_driver sh7760_lcdc_driver = {
+	.driver	= {
+		.name	= "sh7760-lcdc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sh7760fb_probe,
+	.remove		= __devexit_p(sh7760fb_remove),
+	.suspend	= sh7760fb_suspend,
+	.resume		= sh7760fb_resume,
+};
+
+static int __init sh7760fb_init(void)
+{
+	return platform_driver_register(&sh7760_lcdc_driver);
+}
+
+static void __exit sh7760fb_exit(void)
+{
+	platform_driver_unregister(&sh7760_lcdc_driver);
+}
+
+module_init(sh7760fb_init);
+module_exit(sh7760fb_exit);
+
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
+MODULE_DESCRIPTION("FBdev for SH7760/63 integrated LCD Controller");
+MODULE_LICENSE("GPL");
-- 
1.5.5.1


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
