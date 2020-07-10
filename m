From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 Jul 2020 14:23:52 +0000
Subject: Re: [PATCH] omapfb: fix multiple reference count leaks due to pm_runtime_get_sync
Message-Id: <474b3931-4638-0eab-de96-2038a8e3ac7d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200614030543eucas1p11e05674cb3b4f801baaf012f44bbf1ba@eucas1p1.samsung.com>
 <20200614030528.128064-1-pakki001@umn.edu>
In-Reply-To: <20200614030528.128064-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aditya Pakki <pakki001@umn.edu>
Cc: linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kjlu@umn.edu, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Andrew F. Davis" <afd@ti.com>, Alexios Zavras <alexios.zavras@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, wu000273@umn.edu, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Enrico Weigelt <info@metux.net>, Allison Randal <allison@lohutok.net>


On 6/14/20 5:05 AM, Aditya Pakki wrote:
> On calling pm_runtime_get_sync() the reference count of the device
> is incremented. In case of failure, decrement the
> reference count before returning the error.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 7 +++++--
>  drivers/video/fbdev/omap2/omapfb/dss/dsi.c   | 7 +++++--
>  drivers/video/fbdev/omap2/omapfb/dss/dss.c   | 7 +++++--
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 5 +++--
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c | 5 +++--
>  drivers/video/fbdev/omap2/omapfb/dss/venc.c  | 7 +++++--
>  6 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> index 4a16798b2ecd..e2b572761bf6 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> @@ -520,8 +520,11 @@ int dispc_runtime_get(void)
>  	DSSDBG("dispc_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&dispc.pdev->dev);
> -	WARN_ON(r < 0);
> -	return r < 0 ? r : 0;
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&dispc.pdev->dev);
> +		return r;
> +	}
> +	return 0;
>  }
>  EXPORT_SYMBOL(dispc_runtime_get);
>  
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> index d620376216e1..6f9c25fec994 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> @@ -1137,8 +1137,11 @@ static int dsi_runtime_get(struct platform_device *dsidev)
>  	DSSDBG("dsi_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&dsi->pdev->dev);
> -	WARN_ON(r < 0);
> -	return r < 0 ? r : 0;
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&dsi->pdev->dev);
> +		return r;
> +	}
> +	return 0;
>  }
>  
>  static void dsi_runtime_put(struct platform_device *dsidev)
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> index 7252d22dd117..3586579c838f 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> @@ -768,8 +768,11 @@ int dss_runtime_get(void)
>  	DSSDBG("dss_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&dss.pdev->dev);
> -	WARN_ON(r < 0);
> -	return r < 0 ? r : 0;
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&dss.pdev->dev);
> +		return r;
> +	}
> +	return 0;
>  }
>  
>  void dss_runtime_put(void)
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> index 7060ae56c062..4804aab34298 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> @@ -39,9 +39,10 @@ static int hdmi_runtime_get(void)
>  	DSSDBG("hdmi_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&hdmi.pdev->dev);
> -	WARN_ON(r < 0);
> -	if (r < 0)
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&hdmi.pdev->dev);
>  		return r;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
> index ac49531e4732..a06b6f1355bd 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
> @@ -43,9 +43,10 @@ static int hdmi_runtime_get(void)
>  	DSSDBG("hdmi_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&hdmi.pdev->dev);
> -	WARN_ON(r < 0);
> -	if (r < 0)
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&hdmi.pdev->dev);
>  		return r;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> index d5404d56c922..0b0ad20afd63 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> @@ -348,8 +348,11 @@ static int venc_runtime_get(void)
>  	DSSDBG("venc_runtime_get\n");
>  
>  	r = pm_runtime_get_sync(&venc.pdev->dev);
> -	WARN_ON(r < 0);
> -	return r < 0 ? r : 0;
> +	if (WARN_ON(r < 0)) {
> +		pm_runtime_put_sync(&venc.pdev->dev);
> +		return r;
> +	}
> +	return 0;
>  }
>  
>  static void venc_runtime_put(void)
> 
