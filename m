From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 23 Apr 2012 06:15:19 +0000
Subject: Re: [PATCH] video: s3c-fb: add runtime_get/put to suspend/resume
Message-Id: <4F94F377.1050803@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <001201cd1230$3c424a80$b4c6df80$%han@samsung.com>
In-Reply-To: <001201cd1230$3c424a80$b4c6df80$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 04/04/2012 06:57 AM, Jingoo Han wrote:
> This patch adds runtime_get/put to suspend/resume, which should be
> necessary to prevent the problem to access the fimd register
> without block power on.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/s3c-fb.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index f310516..76f3cf2 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1564,6 +1564,8 @@ static int s3c_fb_suspend(struct device *dev)
>  	struct s3c_fb_win *win;
>  	int win_no;
>  
> +	pm_runtime_get_sync(sfb->dev);
> +
>  	for (win_no = S3C_FB_MAX_WIN - 1; win_no >= 0; win_no--) {
>  		win = sfb->windows[win_no];
>  		if (!win)
> @@ -1577,6 +1579,9 @@ static int s3c_fb_suspend(struct device *dev)
>  		clk_disable(sfb->lcd_clk);
>  
>  	clk_disable(sfb->bus_clk);
> +
> +	pm_runtime_put_sync(sfb->dev);
> +
>  	return 0;
>  }
>  
> @@ -1589,6 +1594,8 @@ static int s3c_fb_resume(struct device *dev)
>  	int win_no;
>  	u32 reg;
>  
> +	pm_runtime_get_sync(sfb->dev);
> +
>  	clk_enable(sfb->bus_clk);
>  
>  	if (!sfb->variant.has_clksel)
> @@ -1633,6 +1640,8 @@ static int s3c_fb_resume(struct device *dev)
>  		s3c_fb_set_par(win->fbinfo);
>  	}
>  
> +	pm_runtime_put_sync(sfb->dev);
> +
>  	return 0;
>  }
>  #endif

