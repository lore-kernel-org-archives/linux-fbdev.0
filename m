From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 Sep 2020 20:12:46 +0000
Subject: Re: [PATCH] fbdev: mx3fb: remove unused variable 'irq'
Message-Id: <20200924201246.GH1223313@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
In-Reply-To: <1600334360-4214-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: linux-fbdev@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, jani.nikula@intel.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linuxarm@huawei.com, laurent.pinchart@ideasonboard.com

On Thu, Sep 17, 2020 at 05:19:20PM +0800, Xiaofei Tan wrote:
> Remove the variable 'irq' that is set but never used.
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>

Thanks, applied to drm-misc-next.

	Sam

> ---
>  drivers/video/fbdev/mx3fb.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
> index 603731a..894617d 100644
> --- a/drivers/video/fbdev/mx3fb.c
> +++ b/drivers/video/fbdev/mx3fb.c
> @@ -1428,7 +1428,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  	struct device *dev = mx3fb->dev;
>  	struct mx3fb_platform_data *mx3fb_pdata = dev_get_platdata(dev);
>  	const char *name = mx3fb_pdata->name;
> -	unsigned int irq;
>  	struct fb_info *fbi;
>  	struct mx3fb_info *mx3fbi;
>  	const struct fb_videomode *mode;
> @@ -1441,7 +1440,6 @@ static int init_fb_chan(struct mx3fb_data *mx3fb, struct idmac_channel *ichan)
>  	}
>  
>  	ichan->client = mx3fb;
> -	irq = ichan->eof_irq;
>  
>  	if (ichan->dma_chan.chan_id != IDMAC_SDC_0)
>  		return -EINVAL;
> -- 
> 2.8.1
