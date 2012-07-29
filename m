From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Jul 2012 21:05:38 +0000
Subject: Re: [PATCH RESEND] video: da8xx-fb rev2: fix disabling of palette completion interrupt
Message-Id: <5015A5A2.7050304@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342624871-5947-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342624871-5947-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 07/18/2012 03:21 PM, Manjunathappa, Prakash wrote:
> Writing '1' to particular bit of IRQENABLE_CLEAR register disables the
> corresponding interrupt on revision 2 LCDC. This register was wrongly
> configured to disable all previous enabled interrupts instead of
> disabling only palette completion interrupt. Patch fixes it by clearing
> only palette completion interrupt bit.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> Resending as my earlier patch seems like not reached fbdev mailing list.
> 
>  drivers/video/da8xx-fb.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 47118c7..88e98ea 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -715,7 +715,6 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
>  {
>  	struct da8xx_fb_par *par = arg;
>  	u32 stat = lcdc_read(LCD_MASKED_STAT_REG);
> -	u32 reg_int;
>  
>  	if ((stat & LCD_SYNC_LOST) && (stat & LCD_FIFO_UNDERFLOW)) {
>  		lcd_disable_raster();
> @@ -732,10 +731,8 @@ static irqreturn_t lcdc_irq_handler_rev02(int irq, void *arg)
>  
>  		lcdc_write(stat, LCD_MASKED_STAT_REG);
>  
> -		/* Disable PL completion inerrupt */
> -		reg_int = lcdc_read(LCD_INT_ENABLE_CLR_REG) |
> -		       (LCD_V2_PL_INT_ENA);
> -		lcdc_write(reg_int, LCD_INT_ENABLE_CLR_REG);
> +		/* Disable PL completion interrupt */
> +		lcdc_write(LCD_V2_PL_INT_ENA, LCD_INT_ENABLE_CLR_REG);
>  
>  		/* Setup and start data loading mode */
>  		lcd_blit(LOAD_DATA, par);

