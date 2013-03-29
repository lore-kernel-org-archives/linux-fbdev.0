From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 29 Mar 2013 08:41:14 +0000
Subject: Re: [PATCH RESEND] fbmon: use VESA_DMT_VSYNC_HIGH to fix typo
Message-Id: <20130329084114.GB32161@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <8984685.165951364521249756.JavaMail.weblogic@epml18>
In-Reply-To: <8984685.165951364521249756.JavaMail.weblogic@epml18>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, FlorianSchandinat@gmx.de, plagnioj@jcrosoft.com

On Fri, Mar 29, 2013 at 01:40:52AM +0000, Jingoo Han wrote:
> VESA_DMT_VSYNC_HIGH should be used instead of VESA_DMT_HSYNC_HIGH,
> because FB_SYNC_VERT_HIGH_ACT is related to vsync, not to hsync.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/fbmon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> index 94ad0f7..7f67099 100644
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1400,7 +1400,7 @@ int fb_videomode_from_videomode(const struct videomode *vm,
>  	fbmode->vmode = 0;
>  	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
>  		fbmode->sync |= FB_SYNC_HOR_HIGH_ACT;
> -	if (vm->dmt_flags & VESA_DMT_HSYNC_HIGH)
> +	if (vm->dmt_flags & VESA_DMT_VSYNC_HIGH)
>  		fbmode->sync |= FB_SYNC_VERT_HIGH_ACT;
>  	if (vm->data_flags & DISPLAY_FLAGS_INTERLACED)
>  		fbmode->vmode |= FB_VMODE_INTERLACED;
> -- 
> 1.7.2.5

Hi,

I already implied this on the original mail, but to be clear:

Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
