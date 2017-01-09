From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 09 Jan 2017 12:59:42 +0000
Subject: Re: [PATCH] video: imxfb: always allocate 256 entries for the color map
Message-Id: <20170109125942.tk6iutwdnzzxysix@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1483395604-6931-1-git-send-email-martin@kaiser.cx>
 <1483395842-9675-1-git-send-email-martin@kaiser.cx>
In-Reply-To: <1483395842-9675-1-git-send-email-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Kaiser <martin@kaiser.cx>
Cc: b.zolnierkie@samsung.com, kernel@pengutronix.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 02, 2017 at 11:24:02PM +0100, Martin Kaiser wrote:
> The current code calculates the number of color map entries as
> 1 << info->var.bits_per_pixel. For 32bpp modes, 1 << 32 is 0 when
> written to an int variable. As a consequence, the subsequent copying
> of the default (non-empty) color map into our newly allocated color map
> fails and imxfb's probe function returns an error.
> 
> On both imx1 and imx21 platforms, the color map is used only for modes
> with <= 8bpp. By allocating 256 entries for the color map, we're on the
> safe side.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
> Re-sending: corrected a typo in the LKML address, sorry for that.
> 
>  drivers/video/fbdev/imxfb.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> index fe0c4ee..1b0faad 100644
> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -985,7 +985,11 @@ static int imxfb_probe(struct platform_device *pdev)
>  	 */
>  	imxfb_check_var(&info->var, info);
>  
> -	ret = fb_alloc_cmap(&info->cmap, 1 << info->var.bits_per_pixel, 0);
> +	/*
> +	 * For modes > 8bpp, the color map is bypassed.
> +	 * Therefore, 256 entries are enough.
> +	 */
> +	ret = fb_alloc_cmap(&info->cmap, 256, 0);
>  	if (ret < 0)
>  		goto failed_cmap;
>  
> -- 
> 1.7.10.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
