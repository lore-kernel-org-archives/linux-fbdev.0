From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 10 Sep 2012 04:31:17 +0000
Subject: Re: [PATCH] fbdev: Add Renesas vdc4 framebuffer driver
Message-Id: <001701cd8f0d$1ef56d40$5ce047c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344428095-12203-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1344428095-12203-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, August 08, 2012 9:15 PM Phil Edworthy wrote

Hi Phil Edworthy,

I reviewed your patch.
Please refer to my comments.
Good luck.

Best regards,
Jingoo Han

> 
> The vdc4 display hardware is found on the sh7269 device.
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Please insert one line between the commit message and Signed-off-by.

> ---
>  drivers/video/Kconfig      |   10 +
>  drivers/video/Makefile     |    1 +
>  drivers/video/ren_vdc4fb.c |  653 ++++++++++++++++++++++++++++++++++++++++++++
>  include/video/ren_vdc4fb.h |   19 ++
>  4 files changed, 683 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/ren_vdc4fb.c
>  create mode 100644 include/video/ren_vdc4fb.h
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 0217f74..89c9250 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1990,6 +1990,16 @@ config FB_W100
> 
>  	  If unsure, say N.
> 
> +config FB_REN_VDC4FB
> +	tristate "Renesas VDC4 framebuffer support"
> +	depends on FB && CPU_SUBTYPE_SH7269
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +	---help---
> +	  Frame buffer driver for the Renesas VDC4.
> +
>  config FB_SH_MOBILE_LCDC
>  	tristate "SuperH Mobile LCDC framebuffer support"
>  	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index ee8dafb..ba69fcb 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -140,6 +140,7 @@ obj-$(CONFIG_SH_MIPI_DSI)	  += sh_mipi_dsi.o
>  obj-$(CONFIG_FB_SH_MOBILE_HDMI)	  += sh_mobile_hdmi.o
>  obj-$(CONFIG_FB_SH_MOBILE_MERAM)  += sh_mobile_meram.o
>  obj-$(CONFIG_FB_SH_MOBILE_LCDC)	  += sh_mobile_lcdcfb.o
> +obj-$(CONFIG_FB_REN_VDC4FB)	  += ren_vdc4fb.o
>  obj-$(CONFIG_FB_OMAP)             += omap/
>  obj-y                             += omap2/
>  obj-$(CONFIG_XEN_FBDEV_FRONTEND)  += xen-fbfront.o
> diff --git a/drivers/video/ren_vdc4fb.c b/drivers/video/ren_vdc4fb.c
> new file mode 100644
> index 0000000..1a31e85
> --- /dev/null
> +++ b/drivers/video/ren_vdc4fb.c
> @@ -0,0 +1,653 @@
> +/*
> + * Renesas VDC4 Framebuffer
> + *
> + * Based on sh_mobile_lcdcfb.c
> + * Copyright (c) 2012 Renesas Electronics Europe Ltd
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/clk.h>
> +#include <linux/sh_clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/interrupt.h>
> +#include <linux/vmalloc.h>
> +#include <linux/module.h>
> +#include <video/ren_vdc4fb.h>
> +
> +#define PALETTE_NR 16
> +
> +struct ren_vdc4_priv {
> +	void __iomem *base;
> +	int irq;
> +	struct clk *dot_clk;
> +	struct clk *clk;
> +	struct fb_info *info;
> +	dma_addr_t dma_handle;
> +	struct ren_vdc4_info *cfg;
> +	u32 pseudo_palette[PALETTE_NR];
> +};
> +
> +/* Register offsets/reading and writing functions */
> +enum {
> +	SCL0_UPDATE, SCL0_FRC1, SCL0_FRC2, SCL0_FRC3,
> +	SCL0_FRC4, SCL0_FRC5, SCL0_FRC6, SCL0_FRC7,
> +	SCL0_DS1, SCL0_US1,
> +
> +	GR1_UPDATE, GR1_AB1,
> +
> +	GR2_UPDATE, GR2_AB1,
> +
> +	GR3_UPDATE, GR3_FLM_RD, GR3_FLM1, GR3_FLM2,
> +	GR3_FLM3, GR3_FLM4, GR3_FLM5, GR3_FLM6, GR3_AB1,
> +	GR3_AB2, GR3_AB3, GR3_AB4, GR3_AB5, GR3_AB6,
> +	GR3_AB7, GR3_AB8, GR3_AB9, GR3_AB10, GR3_AB11,
> +	GR3_BASE, GR3_CLUT_INT, GR3_MON,
> +
> +	TCON_UPDATE, TCON_TIM, TCON_TIM_STVA1, TCON_TIM_STVA2,
> +	TCON_TIM_STVB1, TCON_TIM_STVB2, TCON_TIM_STH1,
> +	TCON_TIM_STH2, TCON_TIM_STB1, TCON_TIM_STB2,
> +	TCON_TIM_CPV1, TCON_TIM_CPV2, TCON_TIM_POLA1,
> +	TCON_TIM_POLA2, TCON_TIM_POLB1, TCON_TIM_POLB2,
> +	TCON_TIM_DE,
> +
> +	OUT_UPDATE, OUT_SET, OUT_BRIGHT1,
> +	OUT_BRIGHT2, OUT_CONTRAST, OUT_PDTHA, OUT_CLK_PHASE,
> +
> +	SYSCNT_INT1, SYSCNT_INT2, SYSCNT_INT3, SYSCNT_INT4,
> +	SYSCNT_PANEL_CLK, SYSCNT_CLUT
> +};
> +
> +static unsigned long vdc4_offsets[] = {
> +	[SCL0_UPDATE]		= 0x0100,
> +	[SCL0_FRC1]		= 0x0104,
> +	[SCL0_FRC2]		= 0x0108,
> +	[SCL0_FRC3]		= 0x010C,
> +	[SCL0_FRC4]		= 0x0110,
> +	[SCL0_FRC5]		= 0x0114,
> +	[SCL0_FRC6]		= 0x0118,
> +	[SCL0_FRC7]		= 0x011C,
> +	[SCL0_DS1]		= 0x012C,
> +	[SCL0_US1]		= 0x0148,
> +	[GR1_UPDATE]		= 0x0200,
> +	[GR1_AB1]		= 0x0220,
> +	[GR2_UPDATE]		= 0x0300,
> +	[GR2_AB1]		= 0x0320,
> +	[GR3_UPDATE]		= 0x0380,
> +	[GR3_FLM_RD]		= 0x0384,
> +	[GR3_FLM1]		= 0x0388,
> +	[GR3_FLM2]		= 0x038C,
> +	[GR3_FLM3]		= 0x0390,
> +	[GR3_FLM4]		= 0x0394,
> +	[GR3_FLM5]		= 0x0398,
> +	[GR3_FLM6]		= 0x039C,
> +	[GR3_AB1]		= 0x03A0,
> +	[GR3_AB2]		= 0x03A4,
> +	[GR3_AB3]		= 0x03A8,
> +	[GR3_AB4]		= 0x03AC,
> +	[GR3_AB5]		= 0x03B0,
> +	[GR3_AB6]		= 0x03B4,
> +	[GR3_AB7]		= 0x03B8,
> +	[GR3_AB8]		= 0x03BC,
> +	[GR3_AB9]		= 0x03C0,
> +	[GR3_AB10]		= 0x03C4,
> +	[GR3_AB11]		= 0x03C8,
> +	[GR3_BASE]		= 0x03CC,
> +	[GR3_CLUT_INT]		= 0x03D0,
> +	[GR3_MON]		= 0x03D4,
> +	[TCON_UPDATE]		= 0x0580,
> +	[TCON_TIM]		= 0x0584,
> +	[TCON_TIM_STVA1]	= 0x0588,
> +	[TCON_TIM_STVA2]	= 0x058C,
> +	[TCON_TIM_STVB1]	= 0x0590,
> +	[TCON_TIM_STVB2]	= 0x0594,
> +	[TCON_TIM_STH1]		= 0x0598,
> +	[TCON_TIM_STH2]		= 0x059C,
> +	[TCON_TIM_STB1]		= 0x05A0,
> +	[TCON_TIM_STB2]		= 0x05A4,
> +	[TCON_TIM_CPV1]		= 0x05A8,
> +	[TCON_TIM_CPV2]		= 0x05AC,
> +	[TCON_TIM_POLA1]	= 0x05B0,
> +	[TCON_TIM_POLA2]	= 0x05B4,
> +	[TCON_TIM_POLB1]	= 0x05B8,
> +	[TCON_TIM_POLB2]	= 0x05BC,
> +	[TCON_TIM_DE]		= 0x05C0,
> +	[OUT_UPDATE]		= 0x0600,
> +	[OUT_SET]		= 0x0604,
> +	[OUT_BRIGHT1]		= 0x0608,
> +	[OUT_BRIGHT2]		= 0x060C,
> +	[OUT_CONTRAST]		= 0x0610,
> +	[OUT_PDTHA]		= 0x0614,
> +	[OUT_CLK_PHASE]		= 0x0624,
> +	[SYSCNT_INT1]		= 0x0680,
> +	[SYSCNT_INT2]		= 0x0684,
> +	[SYSCNT_INT3]		= 0x0688,
> +	[SYSCNT_INT4]		= 0x068C,
> +	[SYSCNT_PANEL_CLK]	= 0x0690, /* 16-bit */
> +	[SYSCNT_CLUT]		= 0x0692, /* 16-bit */
> +};
> +
> +/* SYSCNT */
> +#define ICKEN			(1 << 8)
> +
> +/* SCL Syncs */
> +#define FREE_RUN_VSYNC		0x0001
> +
> +/* OUTPUT */
> +#define OUT_FMT_RGB666		(1 << 12)
> +
> +/* TCON Timings */
> +#define STVB_SEL_BITS		0x0007
> +#define STVB_HS_SEL		2
> +
> +#define STH2_SEL_BITS		0x0007
> +#define STH2_DE_SEL		7
> +
> +/* OUTCLK */
> +#define LCD_DATA_EDGE		0x0100
> +#define STVB_EDGE		0x0020
> +#define STH_EDGE		0x0010
> +
> +/* SCL_UPDATE */
> +#define SCL0_UPDATE_BIT		0x0100
> +#define SCL0_VEN_BIT		0x0010
> +
> +/* TCON_UPDATE */
> +#define TCON_VEN_BIT		0x0001
> +
> +/* OUT_UPDATE */
> +#define OUTCNT_VEN_BIT		0x0001
> +
> +/* GR_UPDATE */
> +#define P_VEN_UPDATE		0x0010
> +#define IBUS_VEN_UPDATE		0x0001
> +
> +/* GR_AB1 */
> +#define DISPSEL_BCKGND		0x0000
> +#define DISPSEL_LOWER		0x0001
> +#define DISPSEL_CUR		0x0002
> +
> +/* GR_FLM_RD */
> +#define FB_R_ENB		0x01
> +
> +

Please remove unnecessary line.

> +static void vdc4_write(struct ren_vdc4_priv *priv,
> +	unsigned long reg_offs, unsigned long data)
> +{
> +	if ((SYSCNT_PANEL_CLK = reg_offs) || (SYSCNT_CLUT = reg_offs))
> +		iowrite16(data, priv->base + vdc4_offsets[reg_offs]);
> +	else
> +		iowrite32(data, priv->base + vdc4_offsets[reg_offs]);
> +}
> +
> +static unsigned long vdc4_read(struct ren_vdc4_priv *priv,
> +	unsigned long reg_offs)
> +{
> +	if ((SYSCNT_PANEL_CLK = reg_offs) || (SYSCNT_CLUT = reg_offs))
> +		return ioread16(priv->base + vdc4_offsets[reg_offs]);
> +	else
> +		return ioread32(priv->base + vdc4_offsets[reg_offs]);
> +}
> +
> +static irqreturn_t ren_vdc4_irq(int irq, void *data)
> +{
> +	/* Not currently implemented/used */
> +	return IRQ_HANDLED;
> +}
> +
> +static void lcd_clear_display(struct ren_vdc4_priv *priv)
> +{
> +	unsigned char *pdest;
> +	unsigned long size;
> +
> +	pdest = (unsigned char *)priv->dma_handle;
> +	size = priv->cfg->lcd_cfg.xres * priv->cfg->lcd_cfg.yres * 2;
> +
> +	memset(pdest, 0, size);
> +}
> +
> +static void restart_tft_display(struct ren_vdc4_priv *priv,
> +	int clock_source)
> +{
> +	struct fb_videomode *lcd;
> +	unsigned long h;
> +	unsigned long v;
> +	unsigned long tmp;
> +
> +	/* FB setup */
> +	lcd = &priv->cfg->lcd_cfg;
> +	lcd_clear_display(priv);
> +
> +	/* VDC clock Setup */
> +	tmp = priv->cfg->clock_divider;
> +	tmp |= clock_source << 12;
> +	tmp |= ICKEN;
> +	vdc4_write(priv, SYSCNT_PANEL_CLK, tmp);
> +
> +	/* Clear and Disable all interrupts */
> +	vdc4_write(priv, SYSCNT_INT1, 0);
> +	vdc4_write(priv, SYSCNT_INT2, 0);
> +	vdc4_write(priv, SYSCNT_INT3, 0);
> +	vdc4_write(priv, SYSCNT_INT4, 0);
> +
> +	/* Setup free-running syncs */
> +	vdc4_write(priv, SCL0_FRC3, FREE_RUN_VSYNC);
> +
> +	/* Disable scale up/down */
> +	vdc4_write(priv, SCL0_DS1, 0);
> +	vdc4_write(priv, SCL0_US1, 0);
> +
> +	/* Timing registers */
> +	h = lcd->hsync_len + lcd->left_margin  + lcd->xres + lcd->right_margin;
> +	v = lcd->vsync_len + lcd->upper_margin + lcd->yres + lcd->lower_margin;
> +	tmp = (v - 1) << 16;
> +	tmp |= h - 1;
> +	vdc4_write(priv, SCL0_FRC4, tmp);
> +
> +	vdc4_write(priv, TCON_TIM, (((h - 1) / 2) << 16));
> +
> +	tmp = (lcd->vsync_len + lcd->upper_margin) << 16;
> +	tmp |= lcd->yres;
> +	vdc4_write(priv, SCL0_FRC6, tmp);
> +	vdc4_write(priv, TCON_TIM_STVB1, tmp);
> +	vdc4_write(priv, GR3_AB2, tmp);
> +
> +	tmp = lcd->left_margin << 16;
> +	tmp |= lcd->xres;
> +	vdc4_write(priv, SCL0_FRC7, tmp);
> +	vdc4_write(priv, TCON_TIM_STB1, tmp);
> +	vdc4_write(priv, GR3_AB3, tmp);
> +
> +	vdc4_write(priv, SCL0_FRC1, 0);
> +	vdc4_write(priv, SCL0_FRC2, 0);
> +	vdc4_write(priv, SCL0_FRC5, 0);
> +
> +	/* Set output format */
> +	vdc4_write(priv, OUT_SET, OUT_FMT_RGB666);
> +
> +	/* STH TCON Timing */
> +	tmp = priv->cfg->hs_pulse_width;
> +	tmp |= priv->cfg->hs_start_pos << 16;
> +	vdc4_write(priv, TCON_TIM_STH1, tmp);
> +
> +	/* Setup STVB as HSYNC */
> +	tmp = vdc4_read(priv, TCON_TIM_STVB2);
> +	tmp &= ~STVB_SEL_BITS;
> +	tmp |= STVB_HS_SEL;
> +	vdc4_write(priv, TCON_TIM_STVB2, tmp);
> +
> +	tmp = vdc4_read(priv, OUT_CLK_PHASE);
> +	tmp &= ~STVB_EDGE;
> +	vdc4_write(priv, OUT_CLK_PHASE, tmp);
> +
> +	/* Setup STH as DE */
> +	tmp = vdc4_read(priv, TCON_TIM_STH2);
> +	tmp &= ~STH2_SEL_BITS;
> +	tmp |= STH2_DE_SEL;
> +	vdc4_write(priv, TCON_TIM_STH2, tmp);
> +
> +	tmp = vdc4_read(priv, OUT_CLK_PHASE);
> +	tmp &= ~STH_EDGE;
> +	vdc4_write(priv, OUT_CLK_PHASE, tmp);
> +
> +	/* Output clock rising edge */
> +	tmp = vdc4_read(priv, OUT_CLK_PHASE);
> +	tmp &= ~LCD_DATA_EDGE;
> +	vdc4_write(priv, OUT_CLK_PHASE, tmp);
> +
> +	/* Setup graphics buffers and update all registers */
> +	vdc4_write(priv, GR1_AB1, DISPSEL_BCKGND);
> +	vdc4_write(priv, GR2_AB1, DISPSEL_LOWER);
> +	vdc4_write(priv, GR3_AB1, DISPSEL_CUR);
> +
> +	/* Setup framebuffer base/output */
> +	vdc4_write(priv, GR3_FLM_RD, FB_R_ENB);
> +
> +	vdc4_write(priv, GR3_FLM2, (unsigned long)priv->info->screen_base);
> +
> +	vdc4_write(priv, GR3_FLM3, (lcd->xres * 2) << 16);
> +
> +	tmp = vdc4_read(priv, GR3_FLM5);
> +	tmp |= lcd->yres << 16;
> +	vdc4_write(priv, GR3_FLM5, tmp);
> +
> +	tmp = lcd->xres << 16;
> +	vdc4_write(priv, GR3_FLM6, tmp);
> +
> +	/* Apply all register settings */
> +	vdc4_write(priv, SCL0_UPDATE, SCL0_VEN_BIT | SCL0_UPDATE_BIT);
> +	vdc4_write(priv, GR1_UPDATE, P_VEN_UPDATE);
> +	vdc4_write(priv, GR2_UPDATE, P_VEN_UPDATE);
> +	vdc4_write(priv, GR3_UPDATE, P_VEN_UPDATE | IBUS_VEN_UPDATE);
> +	vdc4_write(priv, OUT_UPDATE, OUTCNT_VEN_BIT);
> +	vdc4_write(priv, TCON_UPDATE, TCON_VEN_BIT);
> +}
> +
> +static int ren_vdc4_setup_clocks(struct platform_device *pdev,
> +	int clock_source,
> +	struct ren_vdc4_priv *priv)
> +{
> +	priv->clk = clk_get(&pdev->dev, "vdc4");

How about using devm_clk_get() instead of kzalloc()?
It makes the code simpler.

> +	if (IS_ERR(priv->clk)) {
> +		dev_err(&pdev->dev, "cannot get clock \"vdc4\"\n");
> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	if (clock_source = VDC4_PERI_CLK) {
> +		priv->dot_clk = clk_get(&pdev->dev, "peripheral_clk");

How about using devm_clk_get() instead of kzalloc()?
It makes the code simpler.


> +		if (IS_ERR(priv->dot_clk)) {
> +			dev_err(&pdev->dev, "cannot get peripheral clock\n");
> +			clk_put(priv->clk);
> +			return PTR_ERR(priv->dot_clk);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int ren_vdc4_setcolreg(u_int regno,
> +	u_int red, u_int green, u_int blue,
> +	u_int transp, struct fb_info *info)
> +{
> +	u32 *palette = info->pseudo_palette;
> +
> +	if (regno >= PALETTE_NR)
> +		return -EINVAL;
> +
> +	/* only FB_VISUAL_TRUECOLOR supported */
> +
> +	red    >>= 16 - info->var.red.length;
> +	green  >>= 16 - info->var.green.length;
> +	blue   >>= 16 - info->var.blue.length;
> +	transp >>= 16 - info->var.transp.length;
> +
> +	palette[regno] = (red << info->var.red.offset) |
> +		(green << info->var.green.offset) |
> +		(blue << info->var.blue.offset) |
> +		(transp << info->var.transp.offset);
> +
> +	return 0;
> +}
> +
> +static struct fb_fix_screeninfo ren_vdc4_fix = {
> +	.id		= "Renesas VDC4FB",
> +	.type		= FB_TYPE_PACKED_PIXELS,
> +	.visual		= FB_VISUAL_TRUECOLOR,
> +	.accel		= FB_ACCEL_NONE,
> +};
> +
> +static struct fb_ops ren_vdc4_ops = {
> +	.owner          = THIS_MODULE,
               ^^^^^^^^
Please use tab instead of spaces.

> +	.fb_setcolreg	= ren_vdc4_setcolreg,
> +	.fb_read        = fb_sys_read,
> +	.fb_write       = fb_sys_write,

Same as above.

> +	.fb_fillrect	= sys_fillrect,
> +	.fb_copyarea	= sys_copyarea,
> +	.fb_imageblit	= sys_imageblit,
> +};
> +
> +static int ren_vdc4_set_bpp(struct fb_var_screeninfo *var, int bpp)
> +{
> +	switch (bpp) {
> +	case 16: /* RGB 565 */
> +		var->red.offset = 11;
> +		var->red.length = 5;
> +		var->green.offset = 5;
> +		var->green.length = 6;
> +		var->blue.offset = 0;
> +		var->blue.length = 5;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	var->bits_per_pixel = bpp;
> +	var->red.msb_right = 0;
> +	var->green.msb_right = 0;
> +	var->blue.msb_right = 0;
> +	var->transp.msb_right = 0;
> +	return 0;
> +}
> +
> +/* PM Functions */
> +static int ren_vdc4_start(struct ren_vdc4_priv *priv,
> +	int clock_source)
> +{
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (priv->dot_clk) {
> +		ret = clk_enable(priv->dot_clk);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	restart_tft_display(priv, clock_source);
> +
> +	return ret;
> +}
> +
> +static void ren_vdc4_stop(struct ren_vdc4_priv *priv)
> +{
> +	if (priv->dot_clk)
> +		clk_disable(priv->dot_clk);
> +	clk_disable(priv->clk);
> +}
> +
> +static int ren_vdc4_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	ren_vdc4_stop(platform_get_drvdata(pdev));
> +	return 0;
> +}
> +
> +static int ren_vdc4_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct ren_vdc4_info *pdata = pdev->dev.platform_data;
> +
> +	return ren_vdc4_start(platform_get_drvdata(pdev), pdata->clock_source);
> +}
> +
> +static const struct dev_pm_ops ren_vdc4_dev_pm_ops = {
> +	.suspend = ren_vdc4_suspend,
> +	.resume = ren_vdc4_resume,
> +};
> +
> +static int ren_vdc4_remove(struct platform_device *pdev);
> +
> +static int __devinit ren_vdc4_probe(struct platform_device *pdev)
> +{
> +	struct fb_info *info;
> +	struct ren_vdc4_priv *priv;
> +	struct ren_vdc4_info *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	void *buf;
> +	int irq, error;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "no platform data defined\n");
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (!res || irq < 0) {
> +		dev_err(&pdev->dev, "cannot get platform resources\n");
> +		return -ENOENT;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);

How about using devm_kzalloc() instead of kzalloc()?
It makes the code simpler.

> +	if (!priv) {
> +		dev_err(&pdev->dev, "cannot allocate device data\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	error = request_irq(irq, ren_vdc4_irq, 0, dev_name(&pdev->dev), priv);

How about using devm_request_irq()instead of request_irq()?
It makes the code simpler.

> +	if (error) {
> +		dev_err(&pdev->dev, "unable to request irq\n");
> +		goto err1;
> +	}
> +
> +	priv->irq = irq;
> +	pdata = pdev->dev.platform_data;
> +
> +	priv->cfg = pdata;
> +
> +	error = ren_vdc4_setup_clocks(pdev, pdata->clock_source, priv);
> +	if (error) {
> +		dev_err(&pdev->dev, "unable to setup clocks\n");
> +		goto err1;
> +	}
> +
> +	priv->base = ioremap_nocache(res->start, resource_size(res));

How about using devm_ioremap_nocache() instead of ioremap_nocache()?
It makes the code simpler.

> +	if (!priv->base) {
> +		dev_err(&pdev->dev, "unable to ioremap\n");
> +		goto err1;
> +	}
> +
> +	priv->info = framebuffer_alloc(0, &pdev->dev);
> +	if (!priv->info) {
> +		dev_err(&pdev->dev, "unable to allocate fb_info\n");
> +		goto err1;
> +	}
> +
> +	info = priv->info;
> +	info->fbops = &ren_vdc4_ops;
> +	info->var.xres = info->var.xres_virtual = pdata->lcd_cfg.xres;
> +	info->var.yres = info->var.yres_virtual = pdata->lcd_cfg.yres;
> +	info->var.width = pdata->panel_width;
> +	info->var.height = pdata->panel_height;
> +	info->var.activate = FB_ACTIVATE_NOW;
> +	info->pseudo_palette = priv->pseudo_palette;
> +	error = ren_vdc4_set_bpp(&info->var, pdata->bpp);
> +	if (error)
> +		goto err1;
> +
> +	info->fix = ren_vdc4_fix;
> +	info->fix.line_length = pdata->lcd_cfg.xres * (pdata->bpp / 8);
> +	info->fix.smem_len = info->fix.line_length * pdata->lcd_cfg.yres;
> +
> +	buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
> +				 &priv->dma_handle, GFP_KERNEL);
> +	if (!buf) {
> +		dev_err(&pdev->dev, "unable to allocate buffer\n");
> +		goto err1;
> +	}
> +
> +	info->flags = FBINFO_FLAG_DEFAULT;
> +
> +	error = fb_alloc_cmap(&info->cmap, PALETTE_NR, 0);
> +	if (error < 0) {
> +		dev_err(&pdev->dev, "unable to allocate cmap\n");
> +		goto err1;
> +	}
> +
> +	memset(buf, 0, info->fix.smem_len);
> +	info->fix.smem_start = priv->dma_handle;
> +	info->screen_base = buf;
> +	info->device = &pdev->dev;
> +	info->par = priv;
> +
> +	if (error)
> +		goto err1;
> +
> +	ren_vdc4_start(priv, pdata->clock_source);

Return value should be checked as follow:
+	error = ren_vdc4_start(priv, pdata->clock_source);

> +	if (error) {
> +		dev_err(&pdev->dev, "unable to start hardware\n");
> +		goto err1;
> +	}
> +
> +	info = priv->info;
> +
> +	error = register_framebuffer(info);
> +	if (error < 0)
> +		goto err1;
> +
> +	dev_info(info->dev,
> +		"registered %s as %udx%ud %dbpp.\n",
> +		pdev->name,
> +		(int) pdata->lcd_cfg.xres,
> +		(int) pdata->lcd_cfg.yres,
> +		pdata->bpp);
> +
> +	return 0;
> +
> +err1:
> +	ren_vdc4_remove(pdev);
> +	return error;
> +}
> +
> +static int ren_vdc4_remove(struct platform_device *pdev)
> +{
> +	struct ren_vdc4_priv *priv = platform_get_drvdata(pdev);
> +	struct fb_info *info;
> +
> +	if (priv->info->dev)
> +		unregister_framebuffer(priv->info);
> +
> +	ren_vdc4_stop(priv);
> +
> +	info = priv->info;
> +
> +	if (!info || !info->device) {
> +		dev_err(&pdev->dev, "Failed to dealloc/release fb_info\n");
> +	} else {
> +		fb_dealloc_cmap(&info->cmap);
> +		framebuffer_release(info);
> +	}
> +
> +	if (priv->dot_clk)
> +		clk_put(priv->dot_clk);
> +	clk_put(priv->clk);

If devm_clk_get() is used in probe(), this clk_put() is not needed.

> +
> +	if (priv->base)
> +		iounmap(priv->base);

If devm_ioremap_nocache()is used in probe(), this iounmap() is not
needed.

> +
> +	if (priv->irq)
> +		free_irq(priv->irq, priv);

If devm_request_irq()is used in probe(), this free_irq() is not needed.

> +
> +	kfree(priv);

If devm_kzalloc() is used in probe(), this kfree() is not needed.

> +	return 0;
> +}
> +
> +static struct platform_driver ren_vdc4_driver = {
> +	.driver		= {
> +		.name		= "ren_vdc4fb",
> +		.owner		= THIS_MODULE,
> +		.pm		= &ren_vdc4_dev_pm_ops,
> +	},
> +	.probe		= ren_vdc4_probe,
> +	.remove		= ren_vdc4_remove,
> +};
> +
> +static int __init ren_vdc4_init(void)
> +{
> +	return platform_driver_register(&ren_vdc4_driver);
> +}
> +
> +static void __exit ren_vdc4_exit(void)
> +{
> +	platform_driver_unregister(&ren_vdc4_driver);
> +}
> +
> +module_init(ren_vdc4_init);
> +module_exit(ren_vdc4_exit);
> +
> +MODULE_DESCRIPTION("Renesas VDC4 Framebuffer driver");
> +MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/video/ren_vdc4fb.h b/include/video/ren_vdc4fb.h
> new file mode 100644
> index 0000000..e91a515
> --- /dev/null
> +++ b/include/video/ren_vdc4fb.h
> @@ -0,0 +1,19 @@
> +#ifndef __REN_VDC4_H__
> +#define __REN_VDC4_H__
> +
> +#include <linux/fb.h>
> +
> +enum { VDC4_EXTCLK = 1, VDC4_PERI_CLK };
> +
> +struct ren_vdc4_info {
> +	int bpp;
> +	int clock_source;
> +	int clock_divider;
> +	int hs_pulse_width;
> +	int hs_start_pos;
> +	struct fb_videomode lcd_cfg;
> +	unsigned long panel_width;
> +	unsigned long panel_height;
> +};
> +
> +#endif
> --
> 1.7.5.4
> 
> --


