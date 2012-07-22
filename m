From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 22 Jul 2012 11:50:28 +0000
Subject: Re: [PATCH] video: da8xx-fb: allow frame to complete before disabling LCDC
Message-Id: <500BE904.4020200@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342799516-10842-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342799516-10842-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On 07/20/2012 03:51 PM, Manjunathappa, Prakash wrote:
> Wait for active frame transfer to complete before disabling LCDC.
> At the same this wait is not be required when there are sync and
> underflow errors.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
>  drivers/video/da8xx-fb.c |   58 ++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 46 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 4440292..c178592 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -31,6 +31,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/console.h>
>  #include <linux/slab.h>
> +#include <linux/delay.h>
>  #include <video/da8xx-fb.h>
>  #include <asm/div64.h>
>  
> @@ -45,6 +46,7 @@
>  #define LCD_PL_LOAD_DONE		BIT(6)
>  #define LCD_FIFO_UNDERFLOW		BIT(5)
>  #define LCD_SYNC_LOST			BIT(2)
> +#define LCD_FRAME_DONE			BIT(0)
>  
>  /* LCD DMA Control Register */
>  #define LCD_DMA_BURST_SIZE(x)		((x) << 4)
> @@ -129,6 +131,8 @@
>  #define RIGHT_MARGIN	64
>  #define UPPER_MARGIN	32
>  #define LOWER_MARGIN	32
> +#define WAIT_FOR_FRAME_DONE	true
> +#define NO_WAIT_FOR_FRAME_DONE	false

These defines look a bit strange. While I consider it acceptable, one
really should know the arguments of a function and hence it doesn't make
sense to add an extra abstraction to bool (in contrast to flags where
such defines are really helpful).

>  
>  static resource_size_t da8xx_fb_reg_base;
>  static struct resource *lcdc_regs;
> @@ -280,13 +284,39 @@ static inline void lcd_enable_raster(void)
>  }
>  
>  /* Disable the Raster Engine of the LCD Controller */
> -static inline void lcd_disable_raster(void)
> +static inline void lcd_disable_raster(bool wait_for_frame_done)
>  {
>  	u32 reg;
> +	u32 loop_cnt = 0;
> +	u32 stat;
> +	u32 i = 0;
> +
> +	/* 50 milli seconds should be sufficient for a frame to complete */
> +	if (wait_for_frame_done)
> +		loop_cnt = 50;
>  
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG);
>  	if (reg & LCD_RASTER_ENABLE)
>  		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +
> +	/* Wait for the current frame to complete */
> +	do {
> +		if (lcd_revision = LCD_VERSION_1)
> +			stat = lcdc_read(LCD_STAT_REG);
> +		else
> +			stat = lcdc_read(LCD_RAW_STAT_REG);
> +		mdelay(1);
> +	} while (!(stat & LCD_FRAME_DONE) && (i++ < loop_cnt));

I don't know the documentation of your hardware but this really looks
like you are waiting after you disabled it.

> +
> +	if (lcd_revision = LCD_VERSION_1)
> +		lcdc_write(stat, LCD_STAT_REG);
> +	else
> +		lcdc_write(stat, LCD_MASKED_STAT_REG);
> +
> +	if ((loop_cnt != 0) && (i >= loop_cnt)) {
> +		pr_err("LCD Controller timed out\n");
> +		return;
> +	}
>  }
>  
>  static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
> @@ -663,7 +693,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
>  static void lcd_reset(struct da8xx_fb_par *par)
>  {
>  	/* Disable the Raster if previously Enabled */
> -	lcd_disable_raster();
> +	lcd_disable_raster(NO_WAIT_FOR_FRAME_DONE);
>  
>  	/* DMA has to be disabled */
>  	lcdc_write(0, LCD_DMA_CTRL_REG);
> @@ -760,7 +790,8 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
>  	u32 reg_int;
>  
>  	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> -		lcd_disable_raster();
> +		pr_err("LCDC sync lost or underflow error occured\n");
> +		lcd_disable_raster(NO_WAIT_FOR_FRAME_DONE);
>  		lcdc_write(stat, LCD_MASKED_STAT_REG);
>  		lcd_enable_raster();
>  	} else if (stat & LCD_PL_LOAD_DONE) {
> @@ -770,7 +801,7 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
>  		 * interrupt via the following write to the status register. If
>  		 * this is done after then one gets multiple PL done interrupts.
>  		 */
> -		lcd_disable_raster();
> +		lcd_disable_raster(NO_WAIT_FOR_FRAME_DONE);
>  
>  		lcdc_write(stat, LCD_MASKED_STAT_REG);
>  
> @@ -815,7 +846,8 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
>  	u32 reg_ras;
>  
>  	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
> -		lcd_disable_raster();
> +		pr_err("LCDC sync lost or underflow error occured\n");
> +		lcd_disable_raster(NO_WAIT_FOR_FRAME_DONE);
>  		lcdc_write(stat, LCD_STAT_REG);
>  		lcd_enable_raster();
>  	} else if (stat & LCD_PL_LOAD_DONE) {
> @@ -825,7 +857,7 @@ static irqreturn_t lcdc_irq_handler_rev01(int irq, void *arg)
>  		 * interrupt via the following write to the status register. If
>  		 * this is done after then one gets multiple PL done interrupts.
>  		 */
> -		lcd_disable_raster();
> +		lcd_disable_raster(NO_WAIT_FOR_FRAME_DONE);
>  
>  		lcdc_write(stat, LCD_STAT_REG);
>  
> @@ -945,7 +977,7 @@ static int lcd_da8xx_cpufreq_transition(struct notifier_block *nb,
>  	if (val = CPUFREQ_POSTCHANGE) {
>  		if (par->lcd_fck_rate != clk_get_rate(par->lcdc_clk)) {
>  			par->lcd_fck_rate = clk_get_rate(par->lcdc_clk);
> -			lcd_disable_raster();
> +			lcd_disable_raster(WAIT_FOR_FRAME_DONE);
>  			lcd_calc_clk_divider(par);
>  			lcd_enable_raster();
>  		}
> @@ -982,7 +1014,7 @@ static int __devexit fb_remove(struct platform_device *dev)
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);
>  
> -		lcd_disable_raster();
> +		lcd_disable_raster(WAIT_FOR_FRAME_DONE);
>  		lcdc_write(0, LCD_RASTER_CTRL_REG);
>  
>  		/* disable DMA  */
> @@ -1095,7 +1127,7 @@ static int cfb_blank(int blank, struct fb_info *info)
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);
>  
> -		lcd_disable_raster();
> +		lcd_disable_raster(WAIT_FOR_FRAME_DONE);
>  		break;
>  	default:
>  		ret = -EINVAL;
> @@ -1435,7 +1467,7 @@ static int fb_suspend(struct platform_device *dev, pm_message_t state)
>  		par->panel_power_ctrl(0);
>  
>  	fb_set_suspend(info, 1);
> -	lcd_disable_raster();
> +	lcd_disable_raster(WAIT_FOR_FRAME_DONE);
>  	clk_disable(par->lcdc_clk);
>  	console_unlock();
>  
> @@ -1447,11 +1479,13 @@ static int fb_resume(struct platform_device *dev)
>  	struct da8xx_fb_par *par = info->par;
>  
>  	console_lock();
> -	if (par->panel_power_ctrl)
> -		par->panel_power_ctrl(1);
>  
>  	clk_enable(par->lcdc_clk);
> +	usleep_range(1000, 2000);
>  	lcd_enable_raster();
> +	if (par->panel_power_ctrl)
> +		par->panel_power_ctrl(1);
> +

This change looks unrelated and should go in a separate patch?

>  	fb_set_suspend(info, 0);
>  	console_unlock();
>  


Best regards,

Florian Tobias Schandinat
