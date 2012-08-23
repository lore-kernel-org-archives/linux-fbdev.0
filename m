From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 23 Aug 2012 20:40:02 +0000
Subject: Re: [PATCH] video: s3c-fb: use devm_clk_get()
Message-Id: <50369522.9060909@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000101cd707c$4e574450$eb05ccf0$%han@samsung.com>
In-Reply-To: <000101cd707c$4e574450$eb05ccf0$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 08/02/2012 06:59 AM, Jingoo Han wrote:
> The devm_ functions allocate memory that is released when a driver
> detaches. This patch uses devm_clk_get() for these functions.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c-fb.c |   24 +++++-------------------
>  1 files changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index 69bf9d0..6c95126 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1398,17 +1398,16 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&sfb->slock);
>  
> -	sfb->bus_clk = clk_get(dev, "lcd");
> +	sfb->bus_clk = devm_clk_get(dev, "lcd");
>  	if (IS_ERR(sfb->bus_clk)) {
>  		dev_err(dev, "failed to get bus clock\n");
> -		ret = PTR_ERR(sfb->bus_clk);
> -		goto err_sfb;
> +		return PTR_ERR(sfb->bus_clk);
>  	}
>  
>  	clk_enable(sfb->bus_clk);
>  
>  	if (!sfb->variant.has_clksel) {
> -		sfb->lcd_clk = clk_get(dev, "sclk_fimd");
> +		sfb->lcd_clk = devm_clk_get(dev, "sclk_fimd");
>  		if (IS_ERR(sfb->lcd_clk)) {
>  			dev_err(dev, "failed to get lcd clock\n");
>  			ret = PTR_ERR(sfb->lcd_clk);
> @@ -1421,12 +1420,6 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
>  	pm_runtime_enable(sfb->dev);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		dev_err(dev, "failed to find registers\n");
> -		ret = -ENOENT;
> -		goto err_lcd_clk;
> -	}
> -
>  	sfb->regs = devm_request_and_ioremap(dev, res);
>  	if (!sfb->regs) {
>  		dev_err(dev, "failed to map registers\n");
> @@ -1510,16 +1503,12 @@ err_pm_runtime:
>  err_lcd_clk:
>  	pm_runtime_disable(sfb->dev);
>  
> -	if (!sfb->variant.has_clksel) {
> +	if (!sfb->variant.has_clksel)
>  		clk_disable(sfb->lcd_clk);
> -		clk_put(sfb->lcd_clk);
> -	}
>  
>  err_bus_clk:
>  	clk_disable(sfb->bus_clk);
> -	clk_put(sfb->bus_clk);
>  
> -err_sfb:
>  	return ret;
>  }
>  
> @@ -1541,13 +1530,10 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
>  		if (sfb->windows[win])
>  			s3c_fb_release_win(sfb, sfb->windows[win]);
>  
> -	if (!sfb->variant.has_clksel) {
> +	if (!sfb->variant.has_clksel)
>  		clk_disable(sfb->lcd_clk);
> -		clk_put(sfb->lcd_clk);
> -	}
>  
>  	clk_disable(sfb->bus_clk);
> -	clk_put(sfb->bus_clk);
>  
>  	pm_runtime_put_sync(sfb->dev);
>  	pm_runtime_disable(sfb->dev);

