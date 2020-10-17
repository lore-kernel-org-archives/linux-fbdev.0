From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 17 Oct 2020 06:20:45 +0000
Subject: Re: [PATCH -next] omapfb: connector-dvi: simplify the return expression of dvic_connect()
Message-Id: <20201017062045.GF2242298@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200915032627.1772517-1-liushixin2@huawei.com>
In-Reply-To: <20200915032627.1772517-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liu Shixin <liushixin2@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Liu.

On Tue, Sep 15, 2020 at 11:26:27AM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks, also applied.
If you have other drm/fbdev patches pending then I have missed them.
So please resend if this is the case.

	Sam

> ---
>  drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
> index b4a1aefff766..2fa436475b40 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
> @@ -51,16 +51,11 @@ static int dvic_connect(struct omap_dss_device *dssdev)
>  {
>  	struct panel_drv_data *ddata = to_panel_data(dssdev);
>  	struct omap_dss_device *in = ddata->in;
> -	int r;
>  
>  	if (omapdss_device_is_connected(dssdev))
>  		return 0;
>  
> -	r = in->ops.dvi->connect(in, dssdev);
> -	if (r)
> -		return r;
> -
> -	return 0;
> +	return in->ops.dvi->connect(in, dssdev);
>  }
>  
>  static void dvic_disconnect(struct omap_dss_device *dssdev)
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
