From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Mon, 02 Dec 2013 18:25:57 +0000
Subject: Re: [PATCH] atmel_lcdfb: fix module autoload
Message-Id: <529CD0B5.600@atmel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382459817-26990-1-git-send-email-jhovold@gmail.com>
In-Reply-To: <1382459817-26990-1-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johan Hovold <jhovold@gmail.com>, linux-fbdev@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org

On 22/10/2013 18:36, Johan Hovold :
> Add missing module device table which is needed for module autoloading.
>
> Signed-off-by: Johan Hovold <jhovold@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Jean-Christophe, Tomi,

Can you please take this patch?

Best regards,


> ---
>   drivers/video/atmel_lcdfb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index 088511a..67b339c 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -94,6 +94,7 @@ static const struct platform_device_id atmel_lcdfb_devtypes[] = {
>   		/* terminator */
>   	}
>   };
> +MODULE_DEVICE_TABLE(platform, atmel_lcdfb_devtypes);
>
>   static struct atmel_lcdfb_config *
>   atmel_lcdfb_get_config(struct platform_device *pdev)
>


-- 
Nicolas Ferre
