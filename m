From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Date: Thu, 29 Nov 2012 11:55:53 +0000
Subject: Re: [BUGFIX PATCH] video: mxsfb: fix crash when unblanking the display
Message-Id: <20663.19785.221750.909491@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi,

adding Juergen Beisert as the driver's author to the recipient list.

Lothar Waßmann writes:
> The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
> The write in mxsfb_disable_controller() sets the data_cnt for the LCD
> DMA to 0 which obviously means the max. count for the LCD DMA and
> leads to overwriting arbitrary memory when the display is unblanked.
> 
> Note: I already sent this patch in December 2011 but noone picked it up obviously.
> 
> Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> ---
>  drivers/video/mxsfb.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 49619b4..f2a49ef 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -369,7 +369,8 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
>  		loop--;
>  	}
>  
> -	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
> +	reg = readl(host->base + LCDC_VDCTRL4);
> +	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
>  
>  	clk_disable_unprepare(host->clk);
>  
> -- 
> 1.7.2.5
> 
ping?


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
