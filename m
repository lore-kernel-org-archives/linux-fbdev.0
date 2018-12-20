From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 20 Dec 2018 16:42:56 +0000
Subject: Re: [PATCH] video: clps711x-fb: release disp device node in probe()
Message-Id: <05f1c984-ddda-6a83-32dd-e96756eac916@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20181102222440epcas1p3ccba6957ba132ddbbc6e32d6ff912062@epcas1p3.samsung.com>
        <1541197423-31560-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1541197423-31560-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


[ added dri-devel ML to Cc: ]

On 11/02/2018 11:23 PM, Alexey Khoroshilov wrote:
> clps711x_fb_probe() increments refcnt of disp device node by
> of_parse_phandle() and leaves it undecremented on both
> successful and error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Patch queued for 4.21, thanks.

> ---
>  drivers/video/fbdev/clps711x-fb.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
> index ff561073ee4e..42f909618f04 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -287,14 +287,17 @@ static int clps711x_fb_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = of_get_fb_videomode(disp, &cfb->mode, OF_USE_NATIVE_MODE);
> -	if (ret)
> +	if (ret) {
> +		of_node_put(disp);
>  		goto out_fb_release;
> +	}
>  
>  	of_property_read_u32(disp, "ac-prescale", &cfb->ac_prescale);
>  	cfb->cmap_invert = of_property_read_bool(disp, "cmap-invert");
>  
>  	ret = of_property_read_u32(disp, "bits-per-pixel",
>  				   &info->var.bits_per_pixel);
> +	of_node_put(disp);
>  	if (ret)
>  		goto out_fb_release;
>  

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
