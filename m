From: Jingoo Han <jingoohan1@gmail.com>
Date: Tue, 18 Jun 2019 06:13:29 +0000
Subject: Re: [PATCH 1/3] video: fbdev: s3c-fb: return -ENOMEM on framebuffer_alloc() failure
Message-Id: <PSXP216MB066270BD6566CA5CDCEB1C7AAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144735eucas1p2f71313b752ae4ea841ddd4ea502fd79f@eucas1p2.samsung.com>
 <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
In-Reply-To: <bbf32fbc-b4bc-39fc-e8dd-db9f0cd0d83f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Han Jingoo <jingoohan1@gmail.com>

On 6/14/19, 11:47 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Fix error code from -ENOENT to -ENOMEM.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/s3c-fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: b/drivers/video/fbdev/s3c-fb.c
> ===================================================================
> --- a/drivers/video/fbdev/s3c-fb.c
> +++ b/drivers/video/fbdev/s3c-fb.c
> @@ -1191,7 +1191,7 @@ static int s3c_fb_probe_win(struct s3c_f
>  				   palette_size * sizeof(u32), sfb->dev);
>  	if (!fbinfo) {
>  		dev_err(sfb->dev, "failed to allocate framebuffer\n");
> -		return -ENOENT;
> +		return -ENOMEM;
>  	}
>  
>  	windata = sfb->pdata->win[win_no];
