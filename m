From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Thu, 24 Oct 2013 15:55:40 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Remove unused variable
Message-Id: <526942DA.2080209@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Monday 21 October 2013 11:02 AM, Sachin Kamat wrote:
> 'pdev' is not used anymore (Removed vide commit 7e0be9f9 "video:
> exynos_mipi_dsim: Use the generic PHY driver"). Remove it and
> silence the following compilation warning:
> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning:
> unused variable ‘pdev’ [-Wunused-variable]
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 00b3a52..cee9602 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -141,7 +141,6 @@ static int exynos_mipi_dsi_early_blank_mode(struct mipi_dsim_device *dsim,
>  
>  static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
>  {
> -	struct platform_device *pdev = to_platform_device(dsim->dev);
>  	struct mipi_dsim_lcd_driver *client_drv = dsim->dsim_lcd_drv;
>  	struct mipi_dsim_lcd_device *client_dev = dsim->dsim_lcd_dev;
>  
> 

