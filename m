From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Wed, 21 Dec 2011 07:27:10 +0000
Subject: Re: [BUGFIX] video/mxsfb: fix crash when unblanking the display
Message-Id: <20209.35406.958883.977664@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1323174425-24038-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1323174425-24038-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Lothar Waßmann writes:
> The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
> The write in mxsfb_disable_controller() sets the data_cnt for the LCD
> DMA to 0 which obviously means the max. count for the LCD DMA and
> leads to overwriting arbitrary memory when the display is unblanked.
> 
> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> ---
>  drivers/video/mxsfb.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index d837d63..03cb95a 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -366,7 +366,8 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
>  		loop--;
>  	}
>  
> -	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
> +	reg = readl(host->base + LCDC_VDCTRL4);
> +	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
>  
>  	clk_disable(host->clk);
>  
> -- 
> 1.5.6.5
> 
Ping. Any comments on this?


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
