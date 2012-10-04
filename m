From: Donghwa Lee <dh09.lee@samsung.com>
Date: Thu, 04 Oct 2012 07:42:28 +0000
Subject: Re: [PATCH 2/2] drivers/video/exynos/exynos_mipi_dsi.c: fix error return code
Message-Id: <506D3DE4.8090207@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1349268044-32616-2-git-send-email-peter.senna@gmail.com>
In-Reply-To: <1349268044-32616-2-git-send-email-peter.senna@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Inki Dae <inki.dae@samsung.com>, kernel-janitors@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On Wed, Oct 03, 2012 at 21:40, Peter Senna Tschudin wrote

> From: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> Convert a nonnegative error return code to a negative one, as returned
> elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> |
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 


I agree with you. Other codes is already used negative error return codes.

> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> 
> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index c4f25de..07d70a3 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -375,6 +375,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
>  	dsim->clock = clk_get(&pdev->dev, "dsim0");
>  	if (IS_ERR(dsim->clock)) {
>  		dev_err(&pdev->dev, "failed to get dsim clock source\n");
> +		ret = -ENODEV;
>  		goto err_clock_get;
>  	}
>  
> @@ -383,6 +384,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "failed to get io memory region\n");
> +		ret = -ENODEV;
>  		goto err_platform_get;
>  	}
>  
> @@ -407,6 +409,7 @@ static int exynos_mipi_dsi_probe(struct platform_device *pdev)
>  	dsim_ddi = exynos_mipi_dsi_bind_lcd_ddi(dsim, dsim_pd->lcd_panel_name);
>  	if (!dsim_ddi) {
>  		dev_err(&pdev->dev, "mipi_dsim_ddi object not found.\n");
> +		ret = -EINVAL;
>  		goto err_bind;
>  	}
>  
> 
> 


