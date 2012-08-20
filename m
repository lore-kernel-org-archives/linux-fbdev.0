From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Aug 2012 09:24:42 +0000
Subject: Re: [PATCH 09/10] video: exynos_dp: Fix bug when checking dp->irq
Message-Id: <004e01cd7eb5$a145d0e0$e3d172a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344398064-13563-10-git-send-email-seanpaul@chromium.org>
In-Reply-To: <1344398064-13563-10-git-send-email-seanpaul@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wednesday, August 08, 2012 12:54 PM Sean Paul wrote:

> -----Original Message-----
> From: Sean Paul [mailto:seanpaul@chromium.org]
> Sent: Wednesday, August 08, 2012 12:54 PM
> To: jg1.han@samsung.com; linux-fbdev@vger.kernel.org
> Cc: Sean Paul
> Subject: [PATCH 09/10] video: exynos_dp: Fix bug when checking dp->irq
> 
> Fix a bug where we check !dp->irq instead of the correct check for
> -ENXIO.
> 
> BUG=None
> TEST=None
> 
> Change-Id: Ibcdd16fb71eb41e4380ac8911ad6063634ff80e2

Remove unnecessary commit message such as 'Change-Id',
'BUG', and 'TEST'.


> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Reviewed-on: https://gerrit.chromium.org/gerrit/29144
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> ---
>  drivers/video/exynos/exynos_dp_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_dp_core.c b/drivers/video/exynos/exynos_dp_core.c
> index 68ad494..eb5816f 100644
> --- a/drivers/video/exynos/exynos_dp_core.c
> +++ b/drivers/video/exynos/exynos_dp_core.c
> @@ -919,7 +919,7 @@ static int __devinit exynos_dp_probe(struct platform_device *pdev)
>  	}
> 
>  	dp->irq = platform_get_irq(pdev, 0);
> -	if (!dp->irq) {
> +	if (dp->irq = -ENXIO) {
>  		dev_err(&pdev->dev, "failed to get irq\n");
>  		ret = -ENODEV;
>  		goto err_clock;
> --
> 1.7.7.3

