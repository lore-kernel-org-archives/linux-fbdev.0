From: Sekhar Nori <nsekhar@ti.com>
Date: Fri, 17 Aug 2012 06:57:01 +0000
Subject: Re: [PATCH v3] da8xx-fb: allow frame to complete after disabling LCDC
Message-Id: <502DE86D.6060808@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344950605-18945-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1344950605-18945-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Prakash,

On 8/14/2012 6:53 PM, Manjunathappa, Prakash wrote:
> Wait for active frame transfer to complete after disabling LCDC.
> At the same this wait is not be required when there are sync and
> underflow errors.
> More information on disable and reset sequence can be found in
> section 13.4.6 of AM335x TRM @www.ti.com/am335x.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Applies on top of fbdev-next of Florian Tobias Schandinat's tree.
> Since v2:
> Optimized the lcd_disable_raster function.
> Since v1:
> Changed the commit message, also added link to hardware specification.
> 
>  drivers/video/da8xx-fb.c |   49 ++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 7ae9d53..cb696ff 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -48,6 +48,7 @@
>  #define LCD_PL_LOAD_DONE		BIT(6)
>  #define LCD_FIFO_UNDERFLOW		BIT(5)
>  #define LCD_SYNC_LOST			BIT(2)
> +#define LCD_FRAME_DONE			BIT(0)
>  
>  /* LCD DMA Control Register */
>  #define LCD_DMA_BURST_SIZE(x)		((x) << 4)
> @@ -288,13 +289,41 @@ static inline void lcd_enable_raster(void)
>  }
>  
>  /* Disable the Raster Engine of the LCD Controller */
> -static inline void lcd_disable_raster(void)
> +static inline void lcd_disable_raster(bool wait_for_frame_done)
>  {
>  	u32 reg;
> +	u32 stat_reg = LCD_STAT_REG;
> +	u32 loop_cnt = 0;
>  
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG);
>  	if (reg & LCD_RASTER_ENABLE)
>  		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> +
> +	if (lcd_revision = LCD_VERSION_2)
> +		stat_reg = LCD_RAW_STAT_REG;
> +
> +	if (wait_for_frame_done) {
> +		/*
> +		 * 50 milli seconds should be sufficient for a frame to
> +		 * complete
> +		 */
> +		loop_cnt = 50;
> +		while (!(lcdc_read(stat_reg) & LCD_FRAME_DONE)) {
> +			/* Handle timeout */
> +			if (unlikely(0 = --loop_cnt)) {
> +				pr_err("LCD Controller timed out\n");
> +				break;
> +			}
> +			mdelay(1);
> +		}
> +	}

The TRM you referenced in the patch description suggests waiting for
frame done interrupt. Can we actually wait for the interrupt here
instead of busy looping?

Thanks,
Sekhar
