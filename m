From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon, 13 May 2013 01:22:08 +0000
Subject: Re: [PATCH 05/15] video: mxsfb: remove unnecessary platform_set_drvdata()
Message-Id: <20130513012207.GB24494@S2101-09.ap.freescale.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000501ce4e46$0acce340$2066a9c0$@samsung.com>
In-Reply-To: <000501ce4e46$0acce340$2066a9c0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, May 11, 2013 at 09:49:57PM +0900, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/video/mxsfb.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 21223d4..10210a0 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -986,8 +986,6 @@ static int mxsfb_remove(struct platform_device *pdev)
>  
>  	framebuffer_release(fb_info);
>  
> -	platform_set_drvdata(pdev, NULL);
> -
>  	return 0;
>  }
>  
> -- 
> 1.7.2.5
> 
> 

