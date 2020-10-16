From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 Oct 2020 21:18:07 +0000
Subject: Re: [PATCH -next] omapfb: simplify the return expression of panel_dpi_connect
Message-Id: <20201016211807.GE1496366@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200921082443.2591721-1-liushixin2@huawei.com>
In-Reply-To: <20200921082443.2591721-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liu Shixin <liushixin2@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Liu Shixin

On Mon, Sep 21, 2020 at 04:24:43PM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks.
Applied this and the following two patches to drm-misc-next.
They will appear in -next in a few weeks.

	Sam

> ---
>  drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
> index 37c9f5bfaefe..ff3d1e8e1e7b 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
> @@ -37,16 +37,11 @@ static int panel_dpi_connect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
>  	struct omap_dss_device *in = ddata->in;
> -	int r;
>  
>  	if (omapdss_device_is_connected(dssdev))
>  		return 0;
>  
> -	r = in->ops.dpi->connect(in, dssdev);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return in->ops.dpi->connect(in, dssdev);
>  }
>  
>  static void panel_dpi_disconnect(struct omap_dss_device *dssdev)
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
