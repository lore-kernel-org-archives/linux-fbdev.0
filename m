From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 29 Jul 2012 21:05:04 +0000
Subject: Re: [PATCH v2] da8xx-fb: add missing FB_BLANK operations
Message-Id: <5015A580.5030203@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
In-Reply-To: <1341583288-30281-1-git-send-email-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 07/06/2012 02:01 PM, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
> modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
> Otherwise X-server will complain about invalid parameter.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> v2: add linux-fbdev as recipient 
> 
>  drivers/video/da8xx-fb.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 47118c7..8d745bf 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -1026,6 +1026,9 @@ static int cfb_blank(int blank, struct fb_info *info)
>  
>  		lcd_enable_raster();
>  		break;
> +	case FB_BLANK_NORMAL:
> +	case FB_BLANK_VSYNC_SUSPEND:
> +	case FB_BLANK_HSYNC_SUSPEND:
>  	case FB_BLANK_POWERDOWN:
>  		if (par->panel_power_ctrl)
>  			par->panel_power_ctrl(0);

