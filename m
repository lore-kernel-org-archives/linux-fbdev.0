From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Date: Mon, 02 Jul 2012 07:51:24 +0000
Subject: RE: [PATCH] da8xx-fb: add missing FB_BLANK operations
Message-Id: <79CD15C6BA57404B839C016229A409A83EA60AE9@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
In-Reply-To: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jul 02, 2012 at 12:41:13, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
> modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
> Otherwise X-server will complain about invalid parameter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  drivers/video/da8xx-fb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 29577bf..9879edc 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -987,6 +987,9 @@ static int cfb_blank(int blank, struct fb_info *info)
>  
>  		lcd_enable_raster();
>  		break;
> +	case FB_BLANK_NORMAL:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
>  	case FB_BLANK_POWERDOWN:
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);


+ linux-fbdev & Florian

You should always send Fbdev patches to linux-fbdev list.


Thanks,
Vaibhav
