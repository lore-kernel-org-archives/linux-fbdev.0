From: Zhou Zhu <zzhu3@marvell.com>
Date: Wed, 25 Sep 2013 07:59:48 +0000
Subject: Re: [PATCH] video: mmp: remove unneeded devm_ deallocations
Message-Id: <524297F4.9060400@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAPgLHd-HYd_iF7Rf9DXGB2dHwx8n4u_vyC05QH37ee_xt7iFdQ@mail.gmail.com>
In-Reply-To: <CAPgLHd-HYd_iF7Rf9DXGB2dHwx8n4u_vyC05QH37ee_xt7iFdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Yongjun,

There's already a same patch here.
http://marc.info/?l=linux-fbdev&m7995281725157&w=2

On 09/25/2013 03:43 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> The whole point of devm is that it'll do these automatically.
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>   drivers/video/mmp/hw/mmp_ctrl.c | 44 ++++++++++-------------------------------
>   1 file changed, 10 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctrl.c
> index 75dca19..ffa8664 100644
> --- a/drivers/video/mmp/hw/mmp_ctrl.c
> +++ b/drivers/video/mmp/hw/mmp_ctrl.c
> @@ -446,33 +446,28 @@ static int mmphw_probe(struct platform_device *pdev)
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (res = NULL) {
>   		dev_err(&pdev->dev, "%s: no IO memory defined\n", __func__);
> -		ret = -ENOENT;
> -		goto failed;
> +		return -ENOENT;
>   	}
>
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0) {
>   		dev_err(&pdev->dev, "%s: no IRQ defined\n", __func__);
> -		ret = -ENOENT;
> -		goto failed;
> +		return -ENOENT;
>   	}
>
>   	/* get configs from platform data */
>   	mi = pdev->dev.platform_data;
>   	if (mi = NULL || !mi->path_num || !mi->paths) {
>   		dev_err(&pdev->dev, "%s: no platform data defined\n", __func__);
> -		ret = -EINVAL;
> -		goto failed;
> +		return -EINVAL;
>   	}
>
>   	/* allocate */
>   	size = sizeof(struct mmphw_ctrl) + sizeof(struct mmphw_path_plat) *
>   	       mi->path_num;
>   	ctrl = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> -	if (!ctrl) {
> -		ret = -ENOMEM;
> -		goto failed;
> -	}
> +	if (!ctrl)
> +		return -ENOMEM;
>
>   	ctrl->name = mi->name;
>   	ctrl->path_num = mi->path_num;
> @@ -486,8 +481,7 @@ static int mmphw_probe(struct platform_device *pdev)
>   			resource_size(res), ctrl->name)) {
>   		dev_err(ctrl->dev,
>   			"can't request region for resource %pR\n", res);
> -		ret = -EINVAL;
> -		goto failed;
> +		return -EINVAL;
>   	}
>
>   	ctrl->reg_base = devm_ioremap_nocache(ctrl->dev,
> @@ -495,8 +489,7 @@ static int mmphw_probe(struct platform_device *pdev)
>   	if (ctrl->reg_base = NULL) {
>   		dev_err(ctrl->dev, "%s: res %x - %x map failed\n", __func__,
>   			res->start, res->end);
> -		ret = -ENOMEM;
> -		goto failed;
> +		return -ENOMEM;
>   	}
>
>   	/* request irq */
> @@ -505,16 +498,14 @@ static int mmphw_probe(struct platform_device *pdev)
>   	if (ret < 0) {
>   		dev_err(ctrl->dev, "%s unable to request IRQ %d\n",
>   				__func__, ctrl->irq);
> -		ret = -ENXIO;
> -		goto failed;
> +		return -ENXIO;
>   	}
>
>   	/* get clock */
>   	ctrl->clk = devm_clk_get(ctrl->dev, mi->clk_name);
>   	if (IS_ERR(ctrl->clk)) {
>   		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
> -		ret = -ENOENT;
> -		goto failed_get_clk;
> +		return -ENOENT;
>   	}
>   	clk_prepare_enable(ctrl->clk);
>
> @@ -551,22 +542,7 @@ failed_path_init:
>   		path_deinit(path_plat);
>   	}
>
> -	if (ctrl->clk) {
> -		devm_clk_put(ctrl->dev, ctrl->clk);
> -		clk_disable_unprepare(ctrl->clk);
> -	}
> -failed_get_clk:
> -	devm_free_irq(ctrl->dev, ctrl->irq, ctrl);
> -failed:
> -	if (ctrl) {
> -		if (ctrl->reg_base)
> -			devm_iounmap(ctrl->dev, ctrl->reg_base);
> -		devm_release_mem_region(ctrl->dev, res->start,
> -				resource_size(res));
> -		devm_kfree(ctrl->dev, ctrl);
> -	}
> -
> -	dev_err(&pdev->dev, "device init failed\n");
> +	clk_disable_unprepare(ctrl->clk);
>
>   	return ret;
>   }
>


-- 
Thanks, -Zhou
