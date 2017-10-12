From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 12 Oct 2017 16:25:48 +0000
Subject: Re: [PATCH] video: fbdev: Fix an errro handling path in 'au1200fb_drv_probe()'
Message-Id: <12781513.OMEBNrce0f@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170912054234epcas4p2afadfa32766d7a186c00f1fdc568c7bf@epcas4p2.samsung.com>
        <20170912053930.18931-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20170912053930.18931-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: tj@kernel.org, viro@zeniv.linux.org.uk, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org


[ added dri-devel ML to cc: ]

On Tuesday, September 12, 2017 07:39:30 AM Christophe JAILLET wrote:
> If 'dmam_alloc_attrs()' fails, we must go through the error handling code,
> as done elsewhere in this function. Otherwise, there is a resource leak.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I'm also puzzled by the 'framebuffer_alloc()' call a few lines above.
> 'ret' is known to be 0 at this point. I guess that -ENOMEM should also be
> returned.

Yes, moreover the "failed:" error path is incomplete (please take
a look at au1200fb_drv_remove() for comparison) and needs to be fixed.

Could you please take care of it?

> ---
>  drivers/video/fbdev/au1200fb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
> index 5f04b4096c42..99d6cfb168b5 100644
> --- a/drivers/video/fbdev/au1200fb.c
> +++ b/drivers/video/fbdev/au1200fb.c
> @@ -1701,7 +1701,8 @@ static int au1200fb_drv_probe(struct platform_device *dev)
>  		if (!fbdev->fb_mem) {
>  			print_err("fail to allocate frambuffer (size: %dK))",
>  				  fbdev->fb_len / 1024);
> -			return -ENOMEM;
> +			ret = -ENOMEM;
> +			goto failed;
>  		}
>  
>  		/*

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

