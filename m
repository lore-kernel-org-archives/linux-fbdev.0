From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 26 Feb 2013 09:06:32 +0000
Subject: Re: [PATCH] fbmon: use VESA_DMT_VSYNC_HIGH to fix typo
Message-Id: <20130226090632.GA27173@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <009501ce13ce$2e912d20$8bb38760$%han@samsung.com>
In-Reply-To: <009501ce13ce$2e912d20$8bb38760$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>

On Tue, Feb 26, 2013 at 12:05:50PM +0900, Jingoo Han wrote:
> VESA_DMT_VSYNC_HIGH should be used instead of VESA_DMT_HSYNC_HIGH,
> because FB_SYNC_VERT_HIGH_ACT is related to vsync, not to hsync.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
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

Hi,

looks good to me.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
