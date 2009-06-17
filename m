From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Resend] [PATCH] Frame Buffer driver for
 DA8XX
Date: Wed, 17 Jun 2009 23:38:54 +0200
Message-ID: <20090617233854.b25753cf.krzysztof.h1@poczta.fm>
References: <1245247270-5392-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MH2ir-0008Ir-7S
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:31:09 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH2io-0005yP-Jc for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Jun 2009 21:31:09 +0000
In-Reply-To: <1245247270-5392-1-git-send-email-sudhakar.raj@ti.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>

On Wed, 17 Jun 2009 10:01:10 -0400
"Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:

> Reseding the same patch with additional Signed-off information.
> 
> Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> 
> LCDC on DA8xx consists of two independent controllers, the Raster Controller
> and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> character and graphic displays.
> 
> This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> the DA830 based EVM. The EVM details can be found at:
> http://support.spectrumdigital.com/boards/dskda830/revc/.
> 
> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> Signed-off-by: Steve Chen <schen@mvista.com>
> ---
>  drivers/video/Kconfig    |   11 +
>  drivers/video/Makefile   |    1 +
>  drivers/video/da8xx-fb.c |  964 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/da8xx-fb.h |  106 +++++
>  4 files changed, 1082 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/da8xx-fb.c
>  create mode 100644 include/linux/da8xx-fb.h
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 693fb4e..fc0c191 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1984,6 +1984,17 @@ config FB_DAVINCI
>  	  hardware found on the TI DaVinci EVM.	 If
>  	  unsure, say N.
>  
> +config FB_DA8XX
> +        tristate "DA8xx/OMAP-L1xx Framebuffer support"
> +        depends on FB && ARCH_DAVINCI_DA830
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	---help---
> +          This is the frame buffer device driver for the TI LCD controller
> +	  found on DA8xx/OMAP-L1xx SoCs.
> +          If unsure, say N.
> +
>  config FB_VIRTUAL
>  	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
>  	depends on FB
> diff --git a/drivers/video/Makefile b/drivers/video/Makefile
> index 902d199..e7a3e7d 100644
> --- a/drivers/video/Makefile
> +++ b/drivers/video/Makefile
> @@ -136,6 +136,7 @@ obj-$(CONFIG_FB_BF54X_LQ043)	  += bf54x-lq043fb.o
>  obj-$(CONFIG_FB_BFIN_T350MCQB)	  += bfin-t350mcqb-fb.o
>  obj-$(CONFIG_FB_MX3)		  += mx3fb.o
>  obj-$(CONFIG_FB_DAVINCI)	  += davincifb.o
> +obj-$(CONFIG_FB_DA8XX)		  += da8xx-fb.o
>  
>  # the test framebuffer is last
>  obj-$(CONFIG_FB_VIRTUAL)          += vfb.o
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> new file mode 100644
> index 0000000..5e3b861
> --- /dev/null
> +++ b/drivers/video/da8xx-fb.c
> @@ -0,0 +1,964 @@
> +/*
> + * Copyright (C) 2008-2009 MontaVista Software Inc.
> + * Copyright (C) 2008-2009 Texas Instruments Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option)any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/fb.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <mach/cputype.h>
> +#include <mach/io.h>
> +#include <mach/hardware.h>
> +#include <linux/uaccess.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/clk.h>
> +#include <linux/da8xx-fb.h>
> +
> +#define DRIVER_NAME "da8xx_lcdc"
> +
> +/* LCD Status Register */
> +#define LCD_END_OF_FRAME0		BIT(8)
> +#define LCD_FIFO_UNDERFLOW		BIT(5)
> +#define LCD_SYNC_LOST			BIT(2)
> +
> +/* LCD DMA Control Register */
> +#define LCD_DMA_BURST_SIZE(x)		((x) << 4)
> +#define LCD_DMA_BURST_1			0x0
> +#define LCD_DMA_BURST_2			0x1
> +#define LCD_DMA_BURST_4			0x2
> +#define LCD_DMA_BURST_8			0x3
> +#define LCD_DMA_BURST_16		0x4
> +#define LCD_END_OF_FRAME_INT_ENA	BIT(2)
> +#define LCD_DUAL_FRAME_BUFFER_ENABLE	BIT(0)
> +
> +/* LCD Control Register */
> +#define LCD_CLK_DIVISOR(x)		((x) << 8)
> +#define LCD_RASTER_MODE			0x01
> +
> +/* LCD Raster Control Register */
> +#define LCD_PALETTE_LOAD_MODE(x)	((x) << 20)
> +#define PALETTE_AND_DATA		0x00
> +#define PALETTE_ONLY			0x01
> +
> +#define LCD_MONO_8BIT_MODE		BIT(9)
> +#define LCD_RASTER_ORDER		BIT(8)
> +#define LCD_TFT_MODE			BIT(7)
> +#define LCD_UNDERFLOW_INT_ENA		BIT(6)
> +#define LCD_MONOCHROME_MODE		BIT(1)
> +#define LCD_RASTER_ENABLE		BIT(0)
> +#define LCD_TFT_ALT_ENABLE		BIT(23)
> +#define LCD_STN_565_ENABLE		BIT(24)
> +
> +/* LCD Raster Timing 2 Register */
> +#define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
> +#define LCD_AC_BIAS_FREQUENCY(x)		((x) << 8)
> +#define LCD_SYNC_CTRL				BIT(25)
> +#define LCD_SYNC_EDGE				BIT(24)
> +#define LCD_INVERT_PIXEL_CLOCK			BIT(22)
> +#define LCD_INVERT_LINE_CLOCK			BIT(21)
> +#define LCD_INVERT_FRAME_CLOCK			BIT(20)
> +
> +/* LCD Block */
> +#define  LCD_CTRL_REG				0x4
> +#define  LCD_STAT_REG				0x8
> +#define  LCD_RASTER_CTRL_REG			0x28
> +#define  LCD_RASTER_TIMING_0_REG		0x2C
> +#define  LCD_RASTER_TIMING_1_REG		0x30
> +#define  LCD_RASTER_TIMING_2_REG		0x34
> +#define  LCD_DMA_CTRL_REG			0x40
> +#define  LCD_DMA_FRM_BUF_BASE_ADDR_0_REG	0x44
> +#define  LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG	0x48
> +
> +#define lcdc_read(addr)		__raw_readl(da8xx_fb_reg_base + (addr))
> +#define lcdc_write(val, addr)	__raw_writel(val, da8xx_fb_reg_base + (addr))
> +

Inline functions are preferred over macros.

> +#define WSI_TIMEOUT	50
> +#define PALETTE_SIZE	256
> +#define LEFT_MARGIN	64
> +#define RIGHT_MARGIN	64
> +#define UPPER_MARGIN	32
> +#define LOWER_MARGIN	32
> +
> +static resource_size_t da8xx_fb_reg_base;
> +static wait_queue_head_t da8xx_wq;

These two variables should not exist. You should store them
in your da8xx_fb_par structure and use them from there
(the reg_base seems already there).

> +
> +struct da8xx_fb_par {
> +	resource_size_t p_regs_base;
> +	resource_size_t p_frame_buffer_mem_base;
> +	resource_size_t p_screen_base;
> +	resource_size_t p_palette_base;
> +	unsigned char *v_frame_buffer_mem_base;
> +	unsigned char *v_screen_base;
> +	unsigned char *v_palette_base;
> +	unsigned long screen_size;

These address and length fields duplicate standard fields from 
the fb_info and fb_info->fix structures (except regs_base).
Please use standard fields.

> +	unsigned int palette_size;
> +	unsigned int bpp;

These fields are also duplicated by the fb_info->var->bits_per_pixel 
and the fb_info->cmap.len.

> +	struct clk *lcdc_clk;
> +	unsigned int irq;
> +	u16 pseudo_palette[16];
> +};
> +
> +/* Variable Screen Information */
> +static struct fb_var_screeninfo da8xx_fb_var __devinitdata = {
> +	.xoffset = 0,
> +	.yoffset = 0,
> +	.transp = {0, 0, 0},
> +	.nonstd = 0,
> +	.activate = 0,
> +	.height = -1,
> +	.width = -1,
> +	.pixclock = 46666,	/* 46us - AUO display */
> +	.accel_flags = 0,
> +	.left_margin = LEFT_MARGIN,
> +	.right_margin = RIGHT_MARGIN,
> +	.upper_margin = UPPER_MARGIN,
> +	.lower_margin = LOWER_MARGIN,
> +	.sync = 0,
> +	.vmode = FB_VMODE_NONINTERLACED
> +};
> +
> +static struct fb_fix_screeninfo da8xx_fb_fix __devinitdata = {
> +	.id = "DA8xx FB Drv",
> +	.type = FB_TYPE_PACKED_PIXELS,
> +	.type_aux = 0,
> +	.visual = FB_VISUAL_PSEUDOCOLOR,
> +	.xpanstep = 1,
> +	.ypanstep = 1,
> +	.ywrapstep = 1,
> +	.accel = FB_ACCEL_NONE
> +};
> +
> +struct da8xx_panel {
> +	const char	name[25];	/* Full name <vendor>_<model> */
> +	unsigned short	width;
> +	unsigned short	height;
> +	int		hfp;		/* Horizontal front porch */
> +	int		hbp;		/* Horizontal back porch */
> +	int		hsw;		/* Horizontal Sync Pulse Width */
> +	int		vfp;		/* Vertical front porch */
> +	int		vbp;		/* Vertical back porch */
> +	int		vsw;		/* Vertical Sync Pulse Width */
> +	int		pxl_clk;	/* Pixel clock */
> +};
> +
> +static struct da8xx_panel known_lcd_panels[] = {
> +	/* Sharp LCD035Q3DG01 */
> +	[0] = {
> +		.name = "Sharp_LCD035Q3DG01",
> +		.width = 320,
> +		.height = 240,
> +		.hfp = 8,
> +		.hbp = 6,
> +		.hsw = 0,
> +		.vfp = 2,
> +		.vbp = 2,
> +		.vsw = 0,
> +		.pxl_clk = 0x10,
> +	},
> +	/* Sharp LK043T1DG01 */
> +	[1] = {
> +		.name = "Sharp_LK043T1DG01",
> +		.width = 480,
> +		.height = 272,
> +		.hfp = 2,
> +		.hbp = 2,
> +		.hsw = 41,
> +		.vfp = 2,
> +		.vbp = 2,
> +		.vsw = 10,
> +		.pxl_clk = 0x12,
> +	},
> +};
> +
> +static u32 databuf_sz;
> +static u32 palette_sz;

Again, these should be part of your da8xx_fb_par structure.

> +static struct fb_ops da8xx_fb_ops;

Just move definition of the da8xx_fb_ops before probe function
and this forward declaration is not needed.
You can give a pointer to the fb_info structure as the second 
parameter here. It will be available inside the irq handler as 
the argument.



> +
> +/* Disable the Raster Engine of the LCD Controller */
> +static int lcd_disable_raster(struct device *dev)
> +{

You give the device structure's pointer as the argument to many 
functions. You should use fb_info pointer here and use &fb_info->device
if needed. Eventually, you can pass only da8xx_fb_par pointer as it is
enough to get all needed data to most functions (no dev_xxx() messages
then).

> +	int ret = 0;
> +	u32 reg;
> +
> +	reg = lcdc_read(LCD_RASTER_CTRL_REG);
> +	if (reg & LCD_RASTER_ENABLE) {
> +		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +		ret = wait_event_interruptible_timeout(da8xx_wq,
> +						!lcdc_read(LCD_STAT_REG) &
> +						LCD_END_OF_FRAME0, WSI_TIMEOUT);
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void lcd_blit(int load_mode, u32 p_buf)
> +{
> +	u32 tmp = p_buf + databuf_sz - 4;
> +	u32 reg;
> +
> +	/* Update the databuf in the hw. */
> +	lcdc_write(p_buf, LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
> +	lcdc_write(tmp, LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
> +
> +	/* Start the DMA. */
> +	reg = lcdc_read(LCD_RASTER_CTRL_REG);
> +	reg &= ~(3 << 20);
> +	if (load_mode == LOAD_DATA)
> +		reg |= LCD_PALETTE_LOAD_MODE(PALETTE_AND_DATA);
> +	else if (load_mode == LOAD_PALETTE)
> +		reg |= LCD_PALETTE_LOAD_MODE(PALETTE_ONLY);
> +
> +	lcdc_write(reg, LCD_RASTER_CTRL_REG);
> +}
> +
> +/* Configure the Burst Size of DMA */
> +static int lcd_cfg_dma(struct device *dev, int burst_size)
> +{
> +	u32 reg;
> +
> +	reg = lcdc_read(LCD_DMA_CTRL_REG) & 0x00000001;
> +	switch (burst_size) {
> +	case 1:
> +		reg |= LCD_DMA_BURST_SIZE(LCD_DMA_BURST_1);
> +		break;
> +	case 2:
> +		reg |= LCD_DMA_BURST_SIZE(LCD_DMA_BURST_2);
> +		break;
> +	case 4:
> +		reg |= LCD_DMA_BURST_SIZE(LCD_DMA_BURST_4);
> +		break;
> +	case 8:
> +		reg |= LCD_DMA_BURST_SIZE(LCD_DMA_BURST_8);
> +		break;
> +	case 16:
> +		reg |= LCD_DMA_BURST_SIZE(LCD_DMA_BURST_16);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	lcdc_write(reg | LCD_END_OF_FRAME_INT_ENA, LCD_DMA_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static void lcd_cfg_ac_bias(struct device *dev, int period,
> +				int transitions_per_int)
> +{
> +	u32 reg;
> +
> +	/* Set the AC Bias Period and Number of Transisitons per Interrupt */
> +	reg = lcdc_read(LCD_RASTER_TIMING_2_REG) & 0xFFF00000;
> +	reg |= LCD_AC_BIAS_FREQUENCY(period) |
> +		LCD_AC_BIAS_TRANSITIONS_PER_INT(transitions_per_int);
> +	lcdc_write(reg, LCD_RASTER_TIMING_2_REG);
> +}
> +
> +static void lcd_cfg_horizontal_sync(struct device *dev, int back_porch,
> +					int pulse_width, int front_porch)
> +{
> +	u32 reg;
> +
> +	reg = lcdc_read(LCD_RASTER_TIMING_0_REG) & 0xf;
> +	reg |= ((back_porch & 0xff) << 24)
> +	    | ((front_porch & 0xff) << 16)
> +	    | ((pulse_width & 0x3f) << 10);
> +	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
> +}
> +
> +static void lcd_cfg_vertical_sync(struct device *dev, int back_porch,
> +					int pulse_width, int front_porch)
> +{
> +	u32 reg;
> +
> +	reg = lcdc_read(LCD_RASTER_TIMING_1_REG) & 0x3ff;
> +	reg |= ((back_porch & 0xff) << 24)
> +	    | ((front_porch & 0xff) << 16)
> +	    | ((pulse_width & 0x3f) << 10);
> +	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
> +}
> +
> +static int lcd_cfg_display(struct device *dev,
> +				const struct lcd_ctrl_config *cfg)
> +{
> +	u32 reg;
> +
> +	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(LCD_TFT_MODE |
> +						LCD_MONO_8BIT_MODE |
> +						LCD_MONOCHROME_MODE);
> +
> +	switch (cfg->p_disp_panel->panel_shade) {
> +	case MONOCHROME:
> +		reg |= LCD_MONOCHROME_MODE;
> +		if (cfg->mono_8bit_mode)
> +			reg |= LCD_MONO_8BIT_MODE;
> +		break;
> +	case COLOR_ACTIVE:
> +		reg |= LCD_TFT_MODE;
> +		if (cfg->tft_alt_mode)
> +			reg |= LCD_TFT_ALT_ENABLE;
> +		break;
> +
> +	case COLOR_PASSIVE:
> +		if (cfg->stn_565_mode)
> +			reg |= LCD_STN_565_ENABLE;
> +		break;
> +
> +	default:
> +		dev_err(dev, "Undefined LCD type\n");
> +		return -EINVAL;
> +	}
> +
> +	/* enable additional interrupts here */
> +	reg |= LCD_UNDERFLOW_INT_ENA;
> +
> +	lcdc_write(reg, LCD_RASTER_CTRL_REG);
> +
> +	reg = lcdc_read(LCD_RASTER_TIMING_2_REG);
> +
> +	if (cfg->sync_ctrl)
> +		reg |= LCD_SYNC_CTRL;
> +	else
> +		reg &= ~LCD_SYNC_CTRL;
> +
> +	if (cfg->sync_edge)
> +		reg |= LCD_SYNC_EDGE;
> +	else
> +		reg &= ~LCD_SYNC_EDGE;
> +
> +	if (cfg->invert_pxl_clock)
> +		reg |= LCD_INVERT_PIXEL_CLOCK;
> +	else
> +		reg &= ~LCD_INVERT_PIXEL_CLOCK;
> +
> +	if (cfg->invert_line_clock)
> +		reg |= LCD_INVERT_LINE_CLOCK;
> +	else
> +		reg &= ~LCD_INVERT_LINE_CLOCK;
> +
> +	if (cfg->invert_frm_clock)
> +		reg |= LCD_INVERT_FRAME_CLOCK;
> +	else
> +		reg &= ~LCD_INVERT_FRAME_CLOCK;
> +
> +	lcdc_write(reg, LCD_RASTER_TIMING_2_REG);
> +
> +	return 0;
> +}
> +
> +static int lcd_cfg_frame_buffer(struct device *dev, u32 width, u32 height,
> +					u32 bpp, u32 raster_order)
> +{
> +	u32 bpl, reg;
> +
> +	/* Disable Dual Frame Buffer. */
> +	reg = lcdc_read(LCD_DMA_CTRL_REG);
> +	lcdc_write(reg & ~LCD_DUAL_FRAME_BUFFER_ENABLE,
> +						LCD_DMA_CTRL_REG);
> +	/* Set the Panel Width */
> +	/* Pixels per line = (PPL + 1)*16 */
> +	/*0x3F in bits 4..9 gives max horisontal resolution = 1024 pixels*/
> +	width &= 0x3f0;
> +	reg = lcdc_read(LCD_RASTER_TIMING_0_REG);
> +	reg = (((width >> 4) - 1) << 4) | (reg & 0xfffffc00);

You can easily break lines like this into two to reduce bracket's depth:

reg &= 0xfffffc00;
reg |= ((width >> 4) - 1) << 4;

> +	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
> +
> +	/* Set the Panel Height */
> +	reg = lcdc_read(LCD_RASTER_TIMING_1_REG);
> +	reg = ((height - 1) & 0x3ff) | (reg & 0xfffffc00);
> +	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
> +
> +	/* Set the Raster Order of the Frame Buffer */
> +	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
> +	if (raster_order)
> +		reg |= LCD_RASTER_ORDER;
> +	lcdc_write(reg, LCD_RASTER_CTRL_REG);
> +
> +	switch (bpp) {
> +	case 1:
> +	case 2:
> +	case 4:
> +	case 16:
> +		palette_sz = 16 * 2;
> +		break;
> +
> +	case 8:
> +		palette_sz = 256 * 2;

The global palette_sz seems like a way to return this value
to a calling function. Just pas the fb_info or da8xx_fb_par pointer 
here and set their values directly.

> +		break;
> +
> +	default:
> +		dev_dbg(dev, "GLCD: Unsupported BPP!\n");
> +		return -EINVAL;
> +	}
> +
> +	bpl = width * bpp / 8;
> +	databuf_sz = height * bpl + palette_sz;
> +
> +	return 0;
> +}
> +
> +/* Palette Initialization */
> +static int init_palette(struct device *dev, struct fb_info *info)

There is no need to pass the device pointer if you can do &info->device here.

> +{
> +	struct da8xx_fb_par *par = info->par;
> +	unsigned short *palette = (unsigned short *)par->p_palette_base;
> +	unsigned short i, size;
> +
> +	/* Palette Size */
> +	size = (par->palette_size / sizeof(*palette));
> +
> +	/* Clear the Palette */
> +	memset(palette, 0, par->palette_size);
> +
> +	/* Initialization of Palette for Default values */
> +	for (i = 0; i < size; i++)
> +		*(unsigned short *)(palette + i) = i;
> +
> +	/* Setup the BPP */
> +	switch (par->bpp) {
> +	case 1:
> +		palette[0] |= BIT(11);
> +		break;
> +	case 2:
> +		palette[0] |= BIT(12);
> +		break;
> +	case 4:
> +		palette[0] |= (2 << 12);
> +		break;
> +	case 8:
> +		palette[0] |= (3 << 12);
> +		break;
> +	case 16:
> +		palette[0] |= (4 << 12);
> +		break;
> +	default:
> +		dev_dbg(dev, "GLCD: Unsupported Video BPP %d!\n", par->bpp);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < size; i++)
> +		par->pseudo_palette[i] = i;
> +
> +	return 0;
> +}
> +
> +static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
> +			      unsigned blue, unsigned transp,
> +			      struct fb_info *info)
> +{
> +	struct da8xx_fb_par *par = info->par;
> +	unsigned short *palette = (unsigned short *)par->v_palette_base;
> +	u_short pal;
> +
> +	if (regno > 255)
> +		return 1;
> +
> +	if (info->fix.visual == FB_VISUAL_DIRECTCOLOR ||
> +	    info->fix.visual == FB_VISUAL_TRUECOLOR)
> +		return 1;
> +

Setting pallete won't work for truecolor mode (16-bit). 
Look at other framebuffers (e.g. tdfxfb) how to set palette
for truecolor modes.

> +	if (par->bpp == 8) {
> +		red >>= 8;
> +		green >>= 8;
> +		blue >>= 8;
> +	}
> +
> +	pal = (red & 0x0f00);
> +	pal |= (green & 0x00f0);
> +	pal |= (blue & 0x000f);
> +
> +	palette[regno] = pal;
> +
> +	return 0;
> +}
> +
> +static int lcd_reset(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	/* Disable the Raster if previously Enabled */
> +	if (lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE)
> +		ret = lcd_disable_raster(dev);
> +
> +	/* DMA has to be disabled */
> +	lcdc_write(0, LCD_DMA_CTRL_REG);
> +	lcdc_write(0, LCD_RASTER_CTRL_REG);
> +
> +	return ret;
> +}
> +
> +static int lcd_init(struct device *dev, const struct lcd_ctrl_config *cfg,
> +			struct da8xx_panel *info)
> +{
> +	u32 bpp, ret = 0;
> +
> +	ret = lcd_reset(dev);
> +	if (ret != 0)
> +		return ret;
> +
> +	/* Configure the LCD clock divisor. */
> +	lcdc_write(LCD_CLK_DIVISOR(info->pxl_clk) |
> +			(LCD_RASTER_MODE & 0x1), LCD_CTRL_REG);
> +
> +	/* Configure the DMA burst size. */
> +	ret = lcd_cfg_dma(dev, cfg->dma_burst_sz);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the AC bias properties. */
> +	lcd_cfg_ac_bias(dev, cfg->ac_bias, cfg->ac_bias_intrpt);
> +
> +	/* Configure the vertical and horizontal sync properties. */
> +	lcd_cfg_vertical_sync(dev, info->vbp, info->vsw, info->vfp);
> +	lcd_cfg_horizontal_sync(dev, info->hbp, info->hsw, info->hfp);
> +
> +	/* Configure for disply */
> +	ret = lcd_cfg_display(dev, cfg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (QVGA != cfg->p_disp_panel->panel_type) {
> +		dev_err(dev, "GLCD: Only QVGA panel is currently supported !");
> +		return -EINVAL;
> +	}
> +	if (cfg->bpp <= cfg->p_disp_panel->max_bpp &&
> +	    cfg->bpp >= cfg->p_disp_panel->min_bpp)
> +		bpp = cfg->bpp;
> +	else
> +		bpp = cfg->p_disp_panel->max_bpp;
> +	if (bpp == 12)
> +		bpp = 16;
> +	ret = lcd_cfg_frame_buffer(dev, (unsigned int)info->width,
> +				(unsigned int)info->height, bpp,
> +				cfg->raster_order);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure FDD */
> +	lcdc_write((lcdc_read(LCD_RASTER_CTRL_REG) & 0xfff00fff) |
> +		       (cfg->fdd << 12), LCD_RASTER_CTRL_REG);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t lcdc_irq_handler(int irq, void *arg)
> +{
> +	u32 stat = lcdc_read(LCD_STAT_REG);
> +	u32 reg;
> +
> +	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> +		reg = lcdc_read(LCD_RASTER_CTRL_REG);
> +		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +		lcdc_write(stat, LCD_STAT_REG);
> +		lcdc_write(reg | LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +	} else
> +		lcdc_write(stat, LCD_STAT_REG);
> +
> +	wake_up_interruptible(&da8xx_wq);
> +	return IRQ_HANDLED;
> +}
> +
> +static int fb_check_var(struct fb_var_screeninfo *var,
> +			      struct fb_info *info)
> +{
> +	int err = 0;
> +	switch (var->bits_per_pixel) {
> +	case 1:
> +	case 8:
> +		var->red.offset = 0;
> +		var->red.length = 8;
> +		var->green.offset = 0;
> +		var->green.length = 8;
> +		var->blue.offset = 0;
> +		var->blue.length = 8;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	case 4:
> +		var->red.offset = 0;
> +		var->red.length = 4;
> +		var->green.offset = 0;
> +		var->green.length = 4;
> +		var->blue.offset = 0;
> +		var->blue.length = 4;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	case 16:		/* RGB 565 */
> +		var->red.offset = 0;
> +		var->red.length = 5;
> +		var->green.offset = 5;
> +		var->green.length = 6;
> +		var->blue.offset = 11;
> +		var->blue.length = 5;
> +		var->transp.offset = 0;
> +		var->transp.length = 0;
> +		break;
> +	default:
> +		err = -EINVAL;
> +	}
> +
> +	var->red.msb_right = 0;
> +	var->green.msb_right = 0;
> +	var->blue.msb_right = 0;
> +	var->transp.msb_right = 0;
> +	return err;
> +}
> +
> +static int fb_set_par(struct fb_info *info)
> +{
> +	struct fb_fix_screeninfo *fix = &info->fix;
> +	struct fb_var_screeninfo *var = &info->var;
> +
> +	switch (var->bits_per_pixel) {
> +	case 1:
> +		fix->visual = FB_VISUAL_MONO01;
> +		break;
> +
> +	case 2:
> +	case 4:
> +	case 8:
> +		fix->visual = FB_VISUAL_PSEUDOCOLOR;
> +		break;
> +
> +	case 16:
> +		fix->visual = FB_VISUAL_TRUECOLOR;
> +		break;
> +	}
> +
> +	fix->line_length = (var->xres_virtual * var->bits_per_pixel) / 8;
> +	return 0;
> +}
> +

This function obviously does not change framebuffer mode as
LCD controller's registers are not changed. This call can only mess
up your display because fix->line_length is changed. If you do not
intend to add mode changing to your driver remove completely
the fb_check_var() and fb_set_par() functions.

> +static int __devexit fb_remove(struct platform_device *dev)
> +{
> +	struct fb_info *info = dev_get_drvdata(&dev->dev);
> +	int ret = 0;
> +
> +	if (info) {
> +		struct da8xx_fb_par *par = info->par;
> +
> +		if (lcdc_read(LCD_RASTER_CTRL_REG) & LCD_RASTER_ENABLE)
> +			ret = lcd_disable_raster(&dev->dev);
> +		lcdc_write(0, LCD_RASTER_CTRL_REG);
> +
> +		/* disable DMA  */
> +		lcdc_write(0, LCD_DMA_CTRL_REG);
> +
> +		unregister_framebuffer(info);
> +		fb_dealloc_cmap(&info->cmap);
> +		dma_free_coherent(NULL, databuf_sz + PAGE_SIZE,
> +					par->v_frame_buffer_mem_base,
> +					par->p_frame_buffer_mem_base);
> +		free_irq(par->irq, NULL);
> +		clk_disable(par->lcdc_clk);
> +		clk_put(par->lcdc_clk);
> +		framebuffer_release(info);
> +
> +	}
> +	return ret;
> +}
> +static int __init fb_probe(struct platform_device *device)
> +{
> +	struct da8xx_lcdc_platform_data *fb_pdata =
> +						device->dev.platform_data;
> +	struct lcd_ctrl_config *lcd_cfg;
> +	struct da8xx_panel *lcdc_info;
> +	struct fb_info *da8xx_fb_info;
> +	struct resource *lcdc_regs;
> +	struct clk *fb_clk = NULL;
> +	struct da8xx_fb_par *par;
> +	resource_size_t len;
> +	int ret, i;
> +
> +	if (fb_pdata == NULL) {
> +		dev_err(&device->dev, "Can not get platform data\n");
> +		return -ENOENT;
> +	}
> +
> +	lcdc_regs = platform_get_resource(device, IORESOURCE_MEM, 0);
> +	if (!lcdc_regs) {
> +		dev_err(&device->dev,
> +			"Can not get memory resource for LCD controller\n");
> +		return -ENOENT;
> +	}
> +
> +	len = lcdc_regs->end - lcdc_regs->start + 1;
> +
> +	lcdc_regs = request_mem_region(lcdc_regs->start, len, lcdc_regs->name);
> +	if (!lcdc_regs)
> +		return -EBUSY;
> +
> +	da8xx_fb_reg_base = (resource_size_t) ioremap(lcdc_regs->start, len);
> +
> +	fb_clk = clk_get(&device->dev, NULL);
> +	if (IS_ERR(fb_clk)) {
> +		dev_err(&device->dev, "Can not get device clock\n");
> +		return -ENODEV;
> +	}
> +	ret = clk_enable(fb_clk);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	for (i = 0, lcdc_info = known_lcd_panels;
> +		i < ARRAY_SIZE(known_lcd_panels);
> +		i++, lcdc_info++) {
> +		if (strcmp(fb_pdata->type, lcdc_info->name) == 0)
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(known_lcd_panels)) {
> +		dev_err(&device->dev, "GLCD: No valid panel found\n");
> +		return -ENODEV;
> +	} else
> +		dev_info(&device->dev, "GLCD: Found %s panel\n",
> +					fb_pdata->type);
> +
> +	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
> +
> +	if (lcd_init(&device->dev, lcd_cfg, lcdc_info) < 0) {
> +		dev_err(&device->dev, "lcd_init failed\n");
> +		ret = -EFAULT;
> +		goto err_clk_disable;
> +	}
> +	da8xx_fb_info = framebuffer_alloc(sizeof(struct fb_info),
> +							&device->dev);

The first argument to the framebuffer_alloc is amount of additional 
space allocated after the fb_info structure. You are supposed to put
the size of the structure pointed by the fb->info_par parameter here.
You have allocated space for two fb_info structure. Your code suggest
you wanted space for one fb_info and one da8xx_fb_par structure.

> +	if (!da8xx_fb_info) {
> +		dev_dbg(&device->dev, "Memory allocation failed for fb_info\n");
> +		ret = -ENOMEM;
> +		goto err_clk_disable;
> +	}
> +
> +	par = da8xx_fb_info->par;

This is already done inside the framebuffer_alloc().

> +	/* allocate frame buffer */
> +	par->v_frame_buffer_mem_base = dma_alloc_coherent(NULL,
> +						databuf_sz + PAGE_SIZE,
> +						&par->p_frame_buffer_mem_base,
> +						GFP_KERNEL | GFP_DMA);
> +
> +	if (!par->v_frame_buffer_mem_base) {
> +		dev_err(&device->dev,
> +			"GLCD: kmalloc for frame buffer failed\n");
> +		ret = -EINVAL;
> +		goto err_release_fb;
> +	}
> +
> +	/* move palette base pointer by (PAGE_SIZE - palette_sz) bytes */
> +	par->v_palette_base = par->v_frame_buffer_mem_base +
> +				(PAGE_SIZE - palette_sz);
> +	par->p_palette_base = par->p_frame_buffer_mem_base +
> +				(PAGE_SIZE - palette_sz);
> +
> +	/* First palette_sz byte of the frame buffer is the palette */
> +	par->palette_size = palette_sz;
> +
> +	/* the rest of the frame buffer is pixel data */
> +	par->v_screen_base = par->v_palette_base + palette_sz;
> +	par->p_screen_base = par->p_palette_base + palette_sz;
> +	par->screen_size = databuf_sz - palette_sz;
> +
> +	par->lcdc_clk = fb_clk;
> +
> +	da8xx_fb_fix.smem_start = (unsigned long)par->p_screen_base;
> +	da8xx_fb_fix.smem_len = par->screen_size;

It shows that your da8xx_fb_par fields duplicates the standard ones.

> +
> +	init_waitqueue_head(&da8xx_wq);
> +
> +	par->irq = platform_get_irq(device, 0);
> +	if (par->irq < 0) {
> +		ret = -ENOENT;
> +		goto err_release_fb_mem;
> +	}
> +
> +	ret = request_irq(par->irq, lcdc_irq_handler, 0,
> +			  DRIVER_NAME, NULL);

You can give a pointer to the fb_info structure as the last
parameter here. It will be available inside the irq handler as 
the argument.

> +	if (ret)
> +		goto err_free_irq;
> +
> +	/* Initialize par */
> +	par->bpp = lcd_cfg->bpp;
> +
> +	da8xx_fb_var.xres = lcdc_info->width;
> +	da8xx_fb_var.xres_virtual = lcdc_info->width;
> +
> +	da8xx_fb_var.yres = lcdc_info->height;
> +	da8xx_fb_var.yres_virtual = lcdc_info->height;
> +
> +	da8xx_fb_var.grayscale =
> +	    lcd_cfg->p_disp_panel->panel_shade == MONOCHROME ? 1 : 0;
> +	da8xx_fb_var.bits_per_pixel = lcd_cfg->bpp;
> +
> +	da8xx_fb_var.hsync_len = lcdc_info->hsw;
> +	da8xx_fb_var.vsync_len = lcdc_info->vsw;
> +
> +	/* Initialize fbinfo */
> +	da8xx_fb_info->flags = FBINFO_FLAG_DEFAULT;
> +	da8xx_fb_info->screen_base = par->v_screen_base;
> +	da8xx_fb_info->device = &device->dev;

This line does the same as there is already done inside the framebuffer_alloc().

> +	da8xx_fb_info->fix = da8xx_fb_fix;
> +	da8xx_fb_info->var = da8xx_fb_var;
> +	da8xx_fb_info->fbops = &da8xx_fb_ops;
> +	da8xx_fb_info->pseudo_palette = par->pseudo_palette;
> +
> +	/* Initialize the Palette */
> +	ret = init_palette(&device->dev, da8xx_fb_info);

I suppose you want to initialize the fb_info->cmap here (the 8 bit palette)
which is not allocated yet (next lines).

> +	if (ret < 0)
> +		goto err_free_irq;
> +
> +	ret = fb_alloc_cmap(&da8xx_fb_info->cmap, PALETTE_SIZE, 0);
> +	if (ret)
> +		goto err_free_irq;
> +
> +	/* Flush the buffer to the screen. */
> +	lcd_blit(LOAD_DATA, (u32) par->p_palette_base);
> +
> +	/* initialize var_screeninfo */
> +	da8xx_fb_var.activate = FB_ACTIVATE_FORCE;
> +	fb_set_var(da8xx_fb_info, &da8xx_fb_var);
> +
> +	dev_set_drvdata(&device->dev, da8xx_fb_info);
> +	/* Register the Frame Buffer  */
> +	if (register_framebuffer(da8xx_fb_info) < 0) {
> +		dev_err(&device->dev,
> +			"GLCD: Frame Buffer Registration Failed!\n");
> +		ret = -EINVAL;
> +		goto err_dealloc_cmap;
> +	}
> +
> +	/* enable raster engine */
> +	lcdc_write(lcdc_read(LCD_RASTER_CTRL_REG) |
> +			LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +
> +	return 0;
> +
> +err_dealloc_cmap:
> +	fb_dealloc_cmap(&da8xx_fb_info->cmap);
> +
> +err_free_irq:
> +	free_irq(par->irq, NULL);
> +
> +err_release_fb_mem:
> +	dma_free_coherent(NULL, databuf_sz + PAGE_SIZE,
> +				par->v_frame_buffer_mem_base,
> +				par->p_frame_buffer_mem_base);
> +
> +err_release_fb:
> +	framebuffer_release(da8xx_fb_info);
> +
> +err_clk_disable:
> +	clk_disable(fb_clk);
> +
> +err_clk_put:
> +	clk_put(fb_clk);
> +
> +	return ret;
> +}
> +
> +static int fb_ioctl(struct fb_info *info, unsigned int cmd,
> +			  unsigned long arg)
> +{
> +	struct lcd_sync_arg sync_arg;
> +
> +	switch (cmd) {
> +	case FBIOGET_CONTRAST:
> +	case FBIOPUT_CONTRAST:
> +	case FBIGET_BRIGHTNESS:
> +	case FBIPUT_BRIGHTNESS:
> +	case FBIGET_COLOR:
> +	case FBIPUT_COLOR:
> +		return -EINVAL;
> +	case FBIPUT_HSYNC:
> +		if (copy_from_user(&sync_arg, (char *)arg,
> +				sizeof(struct lcd_sync_arg)))
> +			return -EINVAL;
> +		lcd_cfg_horizontal_sync(info->dev, sync_arg.back_porch,
> +					sync_arg.pulse_width,
> +					sync_arg.front_porch);
> +		break;
> +	case FBIPUT_VSYNC:
> +		if (copy_from_user(&sync_arg, (char *)arg,
> +				sizeof(struct lcd_sync_arg)))
> +			return -EINVAL;
> +		lcd_cfg_vertical_sync(info->dev, sync_arg.back_porch,
> +					sync_arg.pulse_width,
> +					sync_arg.front_porch);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static struct fb_ops da8xx_fb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_check_var = fb_check_var,
> +	.fb_set_par = fb_set_par,
> +	.fb_setcolreg = fb_setcolreg,
> +	.fb_ioctl = fb_ioctl,
> +	.fb_fillrect = cfb_fillrect,
> +	.fb_copyarea = cfb_copyarea,
> +	.fb_imageblit = cfb_imageblit,
> +};
> +
> +#ifdef CONFIG_PM
> +static int fb_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	 return -EBUSY;
> +}
> +static int fb_resume(struct platform_device *dev)
> +{
> +	 return -EBUSY;
> +}
> +#else
> +#define fb_suspend NULL
> +#define fb_resume NULL
> +#endif
> +
> +static struct platform_driver da8xx_fb_driver = {
> +	.probe = fb_probe,
> +	.remove = fb_remove,
> +	.suspend = fb_suspend,
> +	.resume = fb_resume,
> +	.driver = {
> +		   .name = DRIVER_NAME,
> +		   .owner = THIS_MODULE,
> +		   },
> +};
> +
> +static int __init da8xx_fb_init(void)
> +{
> +	return platform_driver_register(&da8xx_fb_driver);
> +}
> +
> +static void __exit da8xx_fb_cleanup(void)
> +{
> +	platform_driver_unregister(&da8xx_fb_driver);
> +}
> +
> +module_init(da8xx_fb_init);
> +module_exit(da8xx_fb_cleanup);
> +
> +MODULE_DESCRIPTION("Framebuffer driver for TI da8xx/omap-l1xx");
> +MODULE_AUTHOR("MontaVista Software");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/da8xx-fb.h b/include/linux/da8xx-fb.h

It is probably better to put this header into the include/video 
or platform specific include directory. The include/linux is for
global stuff.

> new file mode 100644
> index 0000000..5f77675
> --- /dev/null
> +++ b/include/linux/da8xx-fb.h
> @@ -0,0 +1,106 @@
> +/*
> + * Header file for TI DA8XX LCD controller platform data.
> + *
> + * Copyright (C) 2008-2009 MontaVista Software Inc.
> + * Copyright (C) 2008-2009 Texas Instruments Inc
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#ifndef DA8XX_FB_H
> +#define DA8XX_FB_H
> +
> +enum panel_type {
> +	QVGA = 0
> +};
> +
> +enum panel_shade {
> +	MONOCHROME = 0,
> +	COLOR_ACTIVE,
> +	COLOR_PASSIVE,
> +};
> +
> +enum raster_load_mode {
> +	LOAD_DATA = 1,
> +	LOAD_PALETTE,
> +};
> +
> +struct display_panel {
> +	enum panel_type panel_type; /* QVGA */
> +	int max_bpp;
> +	int min_bpp;
> +	enum panel_shade panel_shade;
> +};
> +
> +struct da8xx_lcdc_platform_data {
> +	const char manu_name[10];
> +	void *controller_data;
> +	const char type[25];
> +};
> +
> +struct lcd_ctrl_config {
> +	const struct display_panel *p_disp_panel;
> +
> +	/* AC Bias Pin Frequency */
> +	int ac_bias;
> +
> +	/* AC Bias Pin Transitions per Interrupt */
> +	int ac_bias_intrpt;
> +
> +	/* DMA burst size */
> +	int dma_burst_sz;
> +
> +	/* Bits per pixel */
> +	int bpp;
> +
> +	/* FIFO DMA Request Delay */
> +	int fdd;
> +
> +	/* TFT Alternative Signal Mapping (Only for active) */
> +	unsigned char tft_alt_mode;
> +
> +	/* 12 Bit Per Pixel (5-6-5) Mode (Only for passive) */
> +	unsigned char stn_565_mode;
> +
> +	/* Mono 8-bit Mode: 1=D0-D7 or 0=D0-D3 */
> +	unsigned char mono_8bit_mode;
> +
> +	/* Invert pixel clock */
> +	unsigned char invert_pxl_clock;
> +
> +	/* Invert line clock */
> +	unsigned char invert_line_clock;
> +
> +	/* Invert frame clock  */
> +	unsigned char invert_frm_clock;
> +
> +	/* Horizontal and Vertical Sync Edge: 0=rising 1=falling */
> +	unsigned char sync_edge;
> +
> +	/* Horizontal and Vertical Sync: Control: 0=ignore */
> +	unsigned char sync_ctrl;
> +
> +	/* Raster Data Order Select: 1=Most-to-least 0=Least-to-most */
> +	unsigned char raster_order;
> +};
> +
> +struct lcd_sync_arg {
> +	int back_porch;
> +	int front_porch;
> +	int pulse_width;
> +};
> +
> +/* ioctls */
> +#define FBIOGET_CONTRAST	_IOR('F', 1, int)
> +#define FBIOPUT_CONTRAST	_IOW('F', 2, int)
> +#define FBIGET_BRIGHTNESS	_IOR('F', 3, int)
> +#define FBIPUT_BRIGHTNESS	_IOW('F', 3, int)
> +#define FBIGET_COLOR		_IOR('F', 5, int)
> +#define FBIPUT_COLOR		_IOW('F', 6, int)
> +#define FBIPUT_HSYNC		_IOW('F', 9, int)
> +#define FBIPUT_VSYNC		_IOW('F', 10, int)
> +
> +#endif  /* ifndef DA8XX_FB_H */
> +
> -- 
> 1.5.6
> 

I am looking forward to updated version of this patch.

Kind regards,
Krzysztof Helt

----------------------------------------------------------------------
Nowa akcja Pepsi - nagrody za kody spod nakretek. Zarejestruj sie!
http://link.interia.pl/f21cc 



------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
