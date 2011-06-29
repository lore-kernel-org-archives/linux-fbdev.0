From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Wed, 29 Jun 2011 12:31:55 +0000
Subject: RE: [PATCH] video: da8xx-fb: Interrupt configuration of revised
Message-Id: <B85A65D85D7EB246BE421B3FB0FBB593024D794140@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309150507-32512-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1309150507-32512-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi All,

I have found couple of below minor nits. Hence I am planning to submit version 2 of this patch. Please let me know if you have any other comments?

Thanks,
Prakash

On Mon, Jun 27, 2011 at 10:25:07, Manjunathappa, Prakash wrote:
> Interrupt configuration support for revised LCDC IP of DA850 in
> upcoming SOC from TI.
> The revised LCDC IP differs in interrupt configuration; registers
> for setting and clearing interrupts, raw and masked status registers
> to depict raw and enabled interrupts status.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  drivers/video/da8xx-fb.c |  153 +++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 144 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index fcdac87..0e02665 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -35,6 +35,9 @@
>  
>  #define DRIVER_NAME "da8xx_lcdc"
>  
> +#define LCD_VERSION_1	1
> +#define LCD_VERSION_2	2
> +
>  /* LCD Status Register */
>  #define LCD_END_OF_FRAME1		BIT(9)
>  #define LCD_END_OF_FRAME0		BIT(8)
> @@ -49,7 +52,9 @@
>  #define LCD_DMA_BURST_4			0x2
>  #define LCD_DMA_BURST_8			0x3
>  #define LCD_DMA_BURST_16		0x4
> -#define LCD_END_OF_FRAME_INT_ENA	BIT(2)
> +#define LCD_V1_END_OF_FRAME_INT_ENA	BIT(2)
> +#define LCD_V2_END_OF_FRAME0_INT_ENA	BIT(8)
> +#define LCD_V2_END_OF_FRAME1_INT_ENA	BIT(9)
>  #define LCD_DUAL_FRAME_BUFFER_ENABLE	BIT(0)
>  
>  /* LCD Control Register */
> @@ -65,12 +70,18 @@
>  #define LCD_MONO_8BIT_MODE		BIT(9)
>  #define LCD_RASTER_ORDER		BIT(8)
>  #define LCD_TFT_MODE			BIT(7)
> -#define LCD_UNDERFLOW_INT_ENA		BIT(6)
> -#define LCD_PL_ENABLE			BIT(4)
> +#define LCD_V1_UNDERFLOW_INT_ENA	BIT(6)
> +#define LCD_V2_UNDERFLOW_INT_ENA	BIT(5)
> +#define LCD_V1_PL_INT_ENA		BIT(4)
> +#define LCD_V2_PL_INT_ENA		BIT(6)
>  #define LCD_MONOCHROME_MODE		BIT(1)
>  #define LCD_RASTER_ENABLE		BIT(0)
>  #define LCD_TFT_ALT_ENABLE		BIT(23)
>  #define LCD_STN_565_ENABLE		BIT(24)
> +#define LCD_V2_DMA_CLK_EN		BIT(2)
> +#define LCD_V2_LIDD_CLK_EN		BIT(1)
> +#define LCD_V2_CORE_CLK_EN		BIT(0)
> +#define LCD_V2_LPP_B10			26
>  
>  /* LCD Raster Timing 2 Register */
>  #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
> @@ -82,6 +93,7 @@
>  #define LCD_INVERT_FRAME_CLOCK			BIT(20)
>  
>  /* LCD Block */
> +#define  LCD_PID_REG				0x0
>  #define  LCD_CTRL_REG				0x4
>  #define  LCD_STAT_REG				0x8
>  #define  LCD_RASTER_CTRL_REG			0x28
> @@ -94,6 +106,17 @@
>  #define  LCD_DMA_FRM_BUF_BASE_ADDR_1_REG	0x4C
>  #define  LCD_DMA_FRM_BUF_CEILING_ADDR_1_REG	0x50
>  
> +/* Interrupt Registers available only in Version 2 */
> +#define  LCD_RAW_STAT_REG			0x58
> +#define  LCD_MASKED_STAT_REG			0x5c
> +#define  LCD_INT_ENABLE_SET_REG			0x60
> +#define  LCD_INT_ENABLE_CLR_REG			0x64
> +#define  LCD_END_OF_INT_IND_REG			0x68
> +
> +/* Clock registers available only on Version 2 */
> +#define  LCD_CLK_ENABLE_REG			0x6c
> +#define  LCD_CLK_RESET_REG			0x70
> +
>  #define LCD_NUM_BUFFERS	2
>  
>  #define WSI_TIMEOUT	50
> @@ -105,6 +128,8 @@
>  
>  static resource_size_t da8xx_fb_reg_base;
>  static struct resource *lcdc_regs;
> +static unsigned int lcd_revision;
> +static irq_handler_t lcdc_irq_handler;
>  
>  static inline unsigned int lcdc_read(unsigned int addr)
>  {
> @@ -240,6 +265,7 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
>  	u32 end;
>  	u32 reg_ras;
>  	u32 reg_dma;
> +	u32 reg_int;
>  
>  	/* init reg to clear PLM (loading mode) fields */
>  	reg_ras = lcdc_read(LCD_RASTER_CTRL_REG);
> @@ -252,7 +278,14 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
>  		end      = par->dma_end;
>  
>  		reg_ras |= LCD_PALETTE_LOAD_MODE(DATA_ONLY);
> -		reg_dma |= LCD_END_OF_FRAME_INT_ENA;
> +		if (lcd_revision = LCD_VERSION_1) {
> +			reg_dma |= LCD_V1_END_OF_FRAME_INT_ENA;
> +		} else {
> +			reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
> +				LCD_V2_END_OF_FRAME0_INT_ENA |
> +				LCD_V2_END_OF_FRAME1_INT_ENA;
> +			lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
> +		}
>  		reg_dma |= LCD_DUAL_FRAME_BUFFER_ENABLE;
>  
>  		lcdc_write(start, LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
> @@ -264,7 +297,14 @@ static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
>  		end      = start + par->palette_sz - 1;
>  
>  		reg_ras |= LCD_PALETTE_LOAD_MODE(PALETTE_ONLY);
> -		reg_ras |= LCD_PL_ENABLE;
> +
> +		if (lcd_revision = LCD_VERSION_1) {
> +			reg_ras |= LCD_V1_PL_INT_ENA;
> +		} else {
> +			reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
> +				LCD_V2_PL_INT_ENA;
> +			lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
> +		}
>  
>  		lcdc_write(start, LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
>  		lcdc_write(end, LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
> @@ -348,6 +388,7 @@ static void lcd_cfg_vertical_sync(int back_porch, int pulse_width,
>  static int lcd_cfg_display(const struct lcd_ctrl_config *cfg)
>  {
>  	u32 reg;
> +	u32 reg_int;
>  
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(LCD_TFT_MODE |
>  						LCD_MONO_8BIT_MODE |
> @@ -375,7 +416,13 @@ static int lcd_cfg_display(const struct lcd_ctrl_config *cfg)
>  	}
>  
>  	/* enable additional interrupts here */
> -	reg |= LCD_UNDERFLOW_INT_ENA;
> +	if (lcd_revision = LCD_VERSION_1) {
> +		reg |= LCD_V1_UNDERFLOW_INT_ENA;
> +	} else {
> +		reg_int = lcdc_read(LCD_INT_ENABLE_SET_REG) |
> +		       (LCD_V2_UNDERFLOW_INT_ENA);
		 	 ^				  ^
[Prakash] I will remove above marked braces.

> +		lcdc_write(reg_int, LCD_INT_ENABLE_SET_REG);
> +	}
>  
>  	lcdc_write(reg, LCD_RASTER_CTRL_REG);
>  
> @@ -415,12 +462,14 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  	/* Pixels per line = (PPL + 1)*16 */
>  	/*0x3F in bits 4..9 gives max horisontal resolution = 1024 pixels*/
>  	width &= 0x3f0;
> +
[Prakash] Will remove random white space.
>  	reg = lcdc_read(LCD_RASTER_TIMING_0_REG);
>  	reg &= 0xfffffc00;
>  	reg |= ((width >> 4) - 1) << 4;
>  	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
>  
>  	/* Set the Panel Height */
> +
[Prakash] Will remove random white space.
>  	reg = lcdc_read(LCD_RASTER_TIMING_1_REG);
>  	reg = ((height - 1) & 0x3ff) | (reg & 0xfffffc00);
>  	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
> @@ -511,6 +560,9 @@ static void lcd_reset(struct da8xx_fb_par *par)
>  	/* DMA has to be disabled */
>  	lcdc_write(0, LCD_DMA_CTRL_REG);
>  	lcdc_write(0, LCD_RASTER_CTRL_REG);
> +
> +	if (lcd_revision = LCD_VERSION_2)
> +		lcdc_write(0, LCD_INT_ENABLE_SET_REG);
>  }
>  
>  static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
> @@ -523,6 +575,11 @@ static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
>  	/* Configure the LCD clock divisor. */
>  	lcdc_write(LCD_CLK_DIVISOR(div) |
>  			(LCD_RASTER_MODE & 0x1), LCD_CTRL_REG);
> +
> +	if (lcd_revision = LCD_VERSION_2)
> +		lcdc_write(LCD_V2_DMA_CLK_EN | LCD_V2_LIDD_CLK_EN |
> +				LCD_V2_CORE_CLK_EN, LCD_CLK_ENABLE_REG);
> +
>  }
>  
>  static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
> @@ -583,7 +640,63 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
>  	return 0;
>  }
>  
> -static irqreturn_t lcdc_irq_handler(int irq, void *arg)
> +/* IRQ handler for version 2 of LCDC */
> +static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
> +{
> +	struct da8xx_fb_par *par = arg;
> +	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
> +	u32 reg_int;
> +
> +	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> +		lcd_disable_raster();
> +		lcdc_write(stat, LCD_MASKED_STAT_REG);
> +		lcd_enable_raster();
> +	} else if (stat & LCD_PL_LOAD_DONE) {
> +		/*
> +		 * Must disable raster before changing state of any control bit.
> +		 * And also must be disabled before clearing the PL loading
> +		 * interrupt via the following write to the status register. If
> +		 * this is done after then one gets multiple PL done interrupts.
> +		 */
> +		lcd_disable_raster();
> +
> +		lcdc_write(stat, LCD_MASKED_STAT_REG);
> +
> +		/* Disable PL completion inerrupt */
> +		reg_int = lcdc_read(LCD_INT_ENABLE_CLR_REG) |
> +		       (LCD_V2_PL_INT_ENA);
> +		lcdc_write(reg_int, LCD_INT_ENABLE_CLR_REG);
> +
> +		/* Setup and start data loading mode */
> +		lcd_blit(LOAD_DATA, par);
> +	} else {
> +		lcdc_write(stat, LCD_MASKED_STAT_REG);
> +
> +		if (stat & LCD_END_OF_FRAME0) {
> +			lcdc_write(par->dma_start,
> +				   LCD_DMA_FRM_BUF_BASE_ADDR_0_REG);
> +			lcdc_write(par->dma_end,
> +				   LCD_DMA_FRM_BUF_CEILING_ADDR_0_REG);
> +			par->vsync_flag = 1;
> +			wake_up_interruptible(&par->vsync_wait);
> +		}
> +
> +		if (stat & LCD_END_OF_FRAME1) {
> +			lcdc_write(par->dma_start,
> +				   LCD_DMA_FRM_BUF_BASE_ADDR_1_REG);
> +			lcdc_write(par->dma_end,
> +				   LCD_DMA_FRM_BUF_CEILING_ADDR_1_REG);
> +			par->vsync_flag = 1;
> +			wake_up_interruptible(&par->vsync_wait);
> +		}
> +	}
> +
> +	lcdc_write(0, LCD_END_OF_INT_IND_REG);
> +	return IRQ_HANDLED;
> +}
> +
> +/* IRQ handler for version 1 LCDC */
> +static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
>  {
>  	struct da8xx_fb_par *par = arg;
>  	u32 stat = lcdc_read(LCD_STAT_REG);
> @@ -606,7 +719,7 @@ static irqreturn_t lcdc_irq_handler(int irq, void *arg)
>  
>  		/* Disable PL completion inerrupt */
>  		reg_ras  = lcdc_read(LCD_RASTER_CTRL_REG);
> -		reg_ras &= ~LCD_PL_ENABLE;
> +		reg_ras &= ~LCD_V1_PL_INT_ENA;
>  		lcdc_write(reg_ras, LCD_RASTER_CTRL_REG);
>  
>  		/* Setup and start data loading mode */
> @@ -945,6 +1058,22 @@ static int __devinit fb_probe(struct platform_device *device)
>  	if (ret)
>  		goto err_clk_put;
>  
> +	/* Determine LCD IP Version */
> +	switch (lcdc_read(LCD_PID_REG)) {
> +	case 0x4C100102:
> +		lcd_revision = LCD_VERSION_1;
> +		break;
> +	case 0x4F200800:
> +		lcd_revision = LCD_VERSION_2;
> +		break;
> +	default:
> +		dev_warn(&device->dev, "Unknown PID Reg value 0x%x, "
> +				"defaulting to LCD revision 1\n",
> +				lcdc_read(LCD_PID_REG));
> +		lcd_revision = LCD_VERSION_1;
> +		break;
> +	}
> +
>  	for (i = 0, lcdc_info = known_lcd_panels;
>  		i < ARRAY_SIZE(known_lcd_panels);
>  		i++, lcdc_info++) {
> @@ -1085,7 +1214,13 @@ static int __devinit fb_probe(struct platform_device *device)
>  	}
>  #endif
>  
> -	ret = request_irq(par->irq, lcdc_irq_handler, 0, DRIVER_NAME, par);
> +	if (lcd_revision = LCD_VERSION_1)
> +		lcdc_irq_handler = lcdc_irq_handler_rev01;
> +	else
> +		lcdc_irq_handler = lcdc_irq_handler_rev02;
> +
> +	ret = request_irq(par->irq, lcdc_irq_handler, 0,
> +			DRIVER_NAME, par);
>  	if (ret)
>  		goto irq_freq;
>  	return 0;
> -- 
> 1.7.1
> 
> 

