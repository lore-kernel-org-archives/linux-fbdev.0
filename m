From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Tue, 28 Feb 2012 15:55:28 +0000
Subject: Re: [PATCH] video: s3c-fb: use devm_request_irq()
Message-Id: <4F4CF8F0.2090701@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <017101ccefbc$0ab90710$202b1530$%han@samsung.com>
In-Reply-To: <017101ccefbc$0ab90710$202b1530$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 02/20/2012 10:40 AM, Jingoo Han wrote:
> The devm_ functions allocate memory that is released when a driver
> detaches. This patch uses devm_request_irq of these functions.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c-fb.c |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index e22bf9d..1fb7ddf 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1433,7 +1433,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
>  		goto err_lcd_clk;
>  	}
>  	sfb->irq_no = res->start;
> -	ret = request_irq(sfb->irq_no, s3c_fb_irq,
> +	ret = devm_request_irq(dev, sfb->irq_no, s3c_fb_irq,
>  			  0, "s3c_fb", sfb);
>  	if (ret) {
>  		dev_err(dev, "irq request failed\n");
> @@ -1499,7 +1499,6 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
>  
>  err_pm_runtime:
>  	pm_runtime_put_sync(sfb->dev);
> -	free_irq(sfb->irq_no, sfb);
>  
>  err_lcd_clk:
>  	pm_runtime_disable(sfb->dev);
> @@ -1535,8 +1534,6 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
>  		if (sfb->windows[win])
>  			s3c_fb_release_win(sfb, sfb->windows[win]);
>  
> -	free_irq(sfb->irq_no, sfb);
> -
>  	if (!sfb->variant.has_clksel) {
>  		clk_disable(sfb->lcd_clk);
>  		clk_put(sfb->lcd_clk);

