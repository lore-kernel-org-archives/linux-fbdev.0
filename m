From: Inki Dae <inki.dae@samsung.com>
Date: Mon, 05 Mar 2012 01:20:02 +0000
Subject: RE: [patch] backlight: s6e63m0: corruption storing gamma mode
Message-Id: <001c01ccfa6e$170a0160$451e0420$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120302065620.GC24508@elgon.mountain>
In-Reply-To: <20120302065620.GC24508@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Acked-by: Inki Dae <inki.dae@samsung.com>

Thanks.

> -----Original Message-----
> From: linux-fbdev-owner@vger.kernel.org [mailto:linux-fbdev-
> owner@vger.kernel.org] On Behalf Of Dan Carpenter
> Sent: Friday, March 02, 2012 3:56 PM
> To: Richard Purdie; InKi Dae
> Cc: Florian Tobias Schandinat; linux-fbdev@vger.kernel.org; kernel-
> janitors@vger.kernel.org
> Subject: [patch] backlight: s6e63m0: corruption storing gamma mode
> 
> strict_strtoul() writes a long but ->gamma_mode only has space to store
> an int, so on 64 bit systems we end up scribbling over
> ->gamma_table_count as well.  I've changed it to use kstrtouint()
> instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/video/backlight/s6e63m0.c
> b/drivers/video/backlight/s6e63m0.c
> index 9b0092e..e264f55 100644
> --- a/drivers/video/backlight/s6e63m0.c
> +++ b/drivers/video/backlight/s6e63m0.c
> @@ -690,7 +690,7 @@ static ssize_t s6e63m0_sysfs_store_gamma_mode(struct
> device *dev,
>  	struct backlight_device *bd = NULL;
>  	int brightness, rc;
> 
> -	rc = strict_strtoul(buf, 0, (unsigned long *)&lcd->gamma_mode);
> +	rc = kstrtouint(buf, 0, &lcd->gamma_mode);
>  	if (rc < 0)
>  		return rc;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

