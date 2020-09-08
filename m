From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 08 Sep 2020 11:36:54 +0000
Subject: Re: [PATCH] omapfb: fix spelling mistake "propert" -> "property"
Message-Id: <ce1d7ff3-fd1e-e6d8-706b-665db8411675@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200805102810eucas1p27af2db275089d0e815f59da56cf204a6@eucas1p2.samsung.com>
 <20200805102805.15353-1-colin.king@canonical.com>
In-Reply-To: <20200805102805.15353-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin King <colin.king@canonical.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


On 8/5/20 12:28 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to drm-misc-next tree, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/venc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> index 0b0ad20afd63..f560fa4d7786 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
> @@ -787,7 +787,7 @@ static int venc_probe_of(struct platform_device *pdev)
>  		venc.type = OMAP_DSS_VENC_TYPE_SVIDEO;
>  		break;
>  	default:
> -		dev_err(&pdev->dev, "bad channel propert '%d'\n", channels);
> +		dev_err(&pdev->dev, "bad channel property '%d'\n", channels);
>  		r = -EINVAL;
>  		goto err;
>  	}
> 
