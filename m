From: Tony Prisk <linux@prisktech.co.nz>
Date: Mon, 08 Apr 2013 18:31:49 +0000
Subject: Re: [PATCH 1/1] video: wm8505fb: Convert to devm_ioremap_resource()
Message-Id: <51630D15.3080209@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365415496-6825-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1365415496-6825-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/04/13 22:04, Sachin Kamat wrote:
> Use the newly introduced devm_ioremap_resource() instead of
> devm_request_and_ioremap() which provides more consistent error handling.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/video/wm8505fb.c |    7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index 19e2e7f..01f9ace 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
> @@ -18,6 +18,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/fb.h>
>   #include <linux/errno.h>
> +#include <linux/err.h>
>   #include <linux/init.h>
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
> @@ -303,9 +304,9 @@ static int wm8505fb_probe(struct platform_device *pdev)
>   	fbi->fb.pseudo_palette	= addr;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	fbi->regbase = devm_request_and_ioremap(&pdev->dev, res);
> -	if (fbi->regbase = NULL)
> -		return -EBUSY;
> +	fbi->regbase = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(fbi->regbase))
> +		return PTR_ERR(fbi->regbase);
>   
>   	disp_timing = of_get_display_timings(pdev->dev.of_node);
>   	if (!disp_timing)
Looks fine,

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P
