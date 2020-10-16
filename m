From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 21:18:31 +0000
Subject: Re: [PATCH -next] omapfb: connector-analog-tv: simplify the return expression of tvc_connect()
Message-Id: <20201016211831.GF1496366@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921131049.92616-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131049.92616-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Sep 21, 2020 at 09:10:49PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thanks, applied to drm-misc-next.

	Sam
> ---
>  .../fbdev/omap2/omapfb/displays/connector-analog-tv.c      | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
> index 63bd13ba4..a9fd732f8 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
> @@ -47,18 +47,13 @@ static int tvc_connect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
>  	struct omap_dss_device *in = ddata->in;
> -	int r;
>  
>  	dev_dbg(ddata->dev, "connect\n");
>  
>  	if (omapdss_device_is_connected(dssdev))
>  		return 0;
>  
> -	r = in->ops.atv->connect(in, dssdev);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return in->ops.atv->connect(in, dssdev);
>  }
>  
>  static void tvc_disconnect(struct omap_dss_device *dssdev)
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
