From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Tue, 16 Apr 2013 12:38:44 +0000
Subject: Re: [PATCH 3/8] video: atmel_lcdfb: pass the pdata as params
Message-Id: <516D4654.3060109@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
 <1365692422-9565-3-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1365692422-9565-3-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/11/2013 05:00 PM, Jean-Christophe PLAGNIOL-VILLARD :
> so we can use have list gpio as example (probe via DT)

Please refine the commit message: I do not understand.

After reading the patch, it seems obvious that more explanations are
needed in the message.

> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arm/mach-at91/board-sam9261ek.c   |    4 ++--
>  arch/arm/mach-at91/board-sam9263ek.c   |    2 +-
>  arch/arm/mach-at91/board-sam9rlek.c    |    2 +-
>  arch/avr32/boards/atngw100/evklcd10x.c |    2 +-
>  drivers/video/atmel_lcdfb.c            |    2 +-
>  include/video/atmel_lcdc.h             |    4 +++-
>  6 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
> index c819e29..9a6618a 100644
> --- a/arch/arm/mach-at91/board-sam9261ek.c
> +++ b/arch/arm/mach-at91/board-sam9261ek.c
> @@ -393,7 +393,7 @@ static struct fb_monspecs at91fb_default_stn_monspecs = {
>  					| ATMEL_LCDC_IFWIDTH_4 \
>  					| ATMEL_LCDC_SCANMOD_SINGLE)
>  
> -static void at91_lcdc_stn_power_control(int on)
> +static void at91_lcdc_stn_power_control(struct atmel_lcdfb_pdata *pdata, int on)
>  {
>  	/* backlight */
>  	if (on) {	/* power up */
> @@ -452,7 +452,7 @@ static struct fb_monspecs at91fb_default_tft_monspecs = {
>  					| ATMEL_LCDC_DISTYPE_TFT    \
>  					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
>  
> -static void at91_lcdc_tft_power_control(int on)
> +static void at91_lcdc_tft_power_control(struct atmel_lcdfb_pdata *pdata, int on)
>  {
>  	if (on)
>  		at91_set_gpio_value(AT91_PIN_PA12, 0);	/* power up */
> diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
> index 0fdae3f..8b4942c 100644
> --- a/arch/arm/mach-at91/board-sam9263ek.c
> +++ b/arch/arm/mach-at91/board-sam9263ek.c
> @@ -275,7 +275,7 @@ static struct fb_monspecs at91fb_default_monspecs = {
>  					| ATMEL_LCDC_DISTYPE_TFT \
>  					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
>  
> -static void at91_lcdc_power_control(int on)
> +static void at91_lcdc_power_control(struct atmel_lcdfb_pdata *pdata, int on)
>  {
>  	at91_set_gpio_value(AT91_PIN_PA30, on);
>  }
> diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
> index b77d7a9..604eecf 100644
> --- a/arch/arm/mach-at91/board-sam9rlek.c
> +++ b/arch/arm/mach-at91/board-sam9rlek.c
> @@ -170,7 +170,7 @@ static struct fb_monspecs at91fb_default_monspecs = {
>  					| ATMEL_LCDC_DISTYPE_TFT \
>  					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
>  
> -static void at91_lcdc_power_control(int on)
> +static void at91_lcdc_power_control(struct atmel_lcdfb_pdata *pdata, int on)
>  {
>  	if (on)
>  		at91_set_gpio_value(AT91_PIN_PC1, 0);	/* power up */
> diff --git a/arch/avr32/boards/atngw100/evklcd10x.c b/arch/avr32/boards/atngw100/evklcd10x.c
> index dc42804..64919b0 100644
> --- a/arch/avr32/boards/atngw100/evklcd10x.c
> +++ b/arch/avr32/boards/atngw100/evklcd10x.c
> @@ -145,7 +145,7 @@ static struct atmel_lcdfb_pdata __initdata atevklcd10x_lcdc_data = {
>  };
>  #endif
>  
> -static void atevklcd10x_lcdc_power_control(int on)
> +static void atevklcd10x_lcdc_power_control(struct atmel_lcdfb_pdata *pdata, int on)
>  {
>  	gpio_set_value(GPIO_PIN_PB(15), on);
>  }
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 9574c47..f67e226 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -288,7 +288,7 @@ static inline void atmel_lcdfb_power_control(struct atmel_lcdfb_info *sinfo, int
>  	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
>  
>  	if (pdata->atmel_lcdfb_power_control)
> -		pdata->atmel_lcdfb_power_control(on);
> +		pdata->atmel_lcdfb_power_control(pdata, on);
>  }
>  
>  static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
> diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
> index 2eb601c..f624c51 100644
> --- a/include/video/atmel_lcdc.h
> +++ b/include/video/atmel_lcdc.h
> @@ -40,8 +40,10 @@ struct atmel_lcdfb_pdata {
>  	u8			lcd_wiring_mode;
>  	unsigned int		default_lcdcon2;
>  	unsigned int		default_dmacon;
> -	void (*atmel_lcdfb_power_control)(int on);
> +	void (*atmel_lcdfb_power_control)(struct atmel_lcdfb_pdata *pdata, int on);
>  	struct fb_monspecs	*default_monspecs;
> +
> +	struct list_head	pwr_gpios;
>  };
>  
>  #define ATMEL_LCDC_DMABADDR1	0x00
> 


-- 
Nicolas Ferre
