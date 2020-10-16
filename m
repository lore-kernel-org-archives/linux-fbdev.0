From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 21:20:49 +0000
Subject: Re: [PATCH -next] omapfb: panel-sony-acx565akm: simplify the return expression of acx565akm_connect(
Message-Id: <20201016212049.GH1496366@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921131052.92707-1-miaoqinglang@huawei.com>
In-Reply-To: <20200921131052.92707-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Qinglang Miao <miaoqinglang@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Qinglang Miao

On Mon, Sep 21, 2020 at 09:10:52PM +0800, Qinglang Miao wrote:
> Simplify the return expression.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Applied this and the following patch to drm-misc-next.
Note: I did not touch the drm/* patches, I expect someone else to pick
them up. As they are quite old maybe try to resend them.

	Sam

> ---
>  .../fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c     | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> index 1293515e4..8d8b5ff7d 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
> @@ -506,16 +506,11 @@ static int acx565akm_connect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
>  	struct omap_dss_device *in = ddata->in;
> -	int r;
>  
>  	if (omapdss_device_is_connected(dssdev))
>  		return 0;
>  
> -	r = in->ops.sdi->connect(in, dssdev);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return in->ops.sdi->connect(in, dssdev);
>  }
>  
>  static void acx565akm_disconnect(struct omap_dss_device *dssdev)
> -- 
> 2.23.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
