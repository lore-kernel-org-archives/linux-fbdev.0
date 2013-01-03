From: Donghwa Lee <dh09.lee@samsung.com>
Date: Thu, 03 Jan 2013 00:35:44 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Fix an error check condition
Message-Id: <50E4D260.7000605@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1357124433-24455-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1357124433-24455-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 01/02/2013 20:00, Sachin Kamat wrote:
> Checking an unsigned variable for negative value returns false.
> Hence use the macro to fix it.
>
> Fixes the following smatch warning:
> drivers/video/exynos/exynos_mipi_dsi.c:417 exynos_mipi_dsi_probe()
> warn: unsigned 'dsim->irq' is never less than zero.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>   drivers/video/exynos/exynos_mipi_dsi.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 4a17cdc..f623dfc 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -414,7 +414,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
>   	}
>   
>   	dsim->irq = platform_get_irq(pdev, 0);
> -	if (dsim->irq < 0) {
> +	if (IS_ERR_VALUE(dsim->irq)) {
>   		dev_err(&pdev->dev, "failed to request dsim irq resource\n");
>   		ret = -EINVAL;
>   		goto err_platform_get_irq;
Hi,
It looks good to me.
Acked-by: Donghwa Lee <dh09.lee@samsung.com>

Thank you,
Donghwa Lee
