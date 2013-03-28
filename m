From: Donghwa Lee <dh09.lee@samsung.com>
Date: Thu, 28 Mar 2013 00:04:00 +0000
Subject: Re: [PATCH] video: exynos: remove useless safety check in list traversal
Message-Id: <515388F0.3060604@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364419145-30375-1-git-send-email-epure.andrei@gmail.com>
In-Reply-To: <1364419145-30375-1-git-send-email-epure.andrei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrei Epure <epure.andrei@gmail.com>
Cc: inki.dae@samsung.com, kyungmin.park@samsung.com, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

It looks good to me.

Acked-by: Donghwa Lee <dh09.lee@samsung.com>

Best regard,
Donghwa Lee

On Thu, Mar 28, 2013 at 06:19, Andrei Epure wrote:
> list_for_each_entry_safe() does not require safety check.
> Patch found using coccinelle.
>
> Signed-off-by: Andrei Epure<epure.andrei@gmail.com>
> ---
>   drivers/video/exynos/exynos_mipi_dsi.c |   16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index dd5e5e9..fe84f08 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -214,8 +214,6 @@ static struct mipi_dsim_ddi *exynos_mipi_dsi_find_lcd_device(
>   	mutex_lock(&mipi_dsim_lock);
>   
>   	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
> -		if (!dsim_ddi)
> -			goto out;
>   
>   		lcd_dev = dsim_ddi->dsim_lcd_dev;
>   		if (!lcd_dev)
> @@ -473,17 +471,15 @@ static int exynos_mipi_dsi_remove(struct platform_device *pdev)
>   	clk_disable(dsim->clock);
>   
>   	list_for_each_entry_safe(dsim_ddi, next, &dsim_ddi_list, list) {
> -		if (dsim_ddi) {
> -			if (dsim->id != dsim_ddi->bus_id)
> -				continue;
> +		if (dsim->id != dsim_ddi->bus_id)
> +			continue;
>   
> -			dsim_lcd_drv = dsim_ddi->dsim_lcd_drv;
> +		dsim_lcd_drv = dsim_ddi->dsim_lcd_drv;
>   
> -			if (dsim_lcd_drv->remove)
> -				dsim_lcd_drv->remove(dsim_ddi->dsim_lcd_dev);
> +		if (dsim_lcd_drv->remove)
> +			dsim_lcd_drv->remove(dsim_ddi->dsim_lcd_dev);
>   
> -			kfree(dsim_ddi);
> -		}
> +		kfree(dsim_ddi);
>   	}
>   
>   	return 0;

