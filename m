From: Tony Prisk <linux@prisktech.co.nz>
Date: Thu, 28 Mar 2013 04:59:45 +0000
Subject: Re: [Bulk] [PATCH] video: fix invalid free of devm_ allocated data
Message-Id: <1364446785.15039.1.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364428524-13821-1-git-send-email-epure.andrei@gmail.com>
In-Reply-To: <1364428524-13821-1-git-send-email-epure.andrei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 2013-03-28 at 01:55 +0200, Andrei Epure wrote:
> The objects allocated by devm_* APIs are managed by devres and are freed when
> the device is detached. Hence there is no need to use kfree() explicitly.
> Patch found using coccinelle.
> 
> Signed-off-by: Andrei Epure <epure.andrei@gmail.com>
> ---
>  drivers/video/vt8500lcdfb.c |    3 ---
>  drivers/video/wm8505fb.c    |    3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/video/vt8500lcdfb.c b/drivers/video/vt8500lcdfb.c
> index b4ccca2..ea3ee61 100644
> --- a/drivers/video/vt8500lcdfb.c
> +++ b/drivers/video/vt8500lcdfb.c
> @@ -465,7 +465,6 @@ failed_free_res:
>  	release_mem_region(res->start, resource_size(res));
>  failed_fbi:
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(fbi);
>  failed:
>  	return ret;
>  }
> @@ -494,8 +493,6 @@ static int vt8500lcd_remove(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(res->start, resource_size(res));
>  
> -	kfree(fbi);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/video/wm8505fb.c b/drivers/video/wm8505fb.c
> index 2e8298e..34a2de1 100644
> --- a/drivers/video/wm8505fb.c
> +++ b/drivers/video/wm8505fb.c
> @@ -427,7 +427,6 @@ failed_free_res:
>  	release_mem_region(res->start, resource_size(res));
>  failed_fbi:
>  	platform_set_drvdata(pdev, NULL);
> -	kfree(fbi);
>  failed:
>  	return ret;
>  }
> @@ -451,8 +450,6 @@ static int wm8505fb_remove(struct platform_device *pdev)
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	release_mem_region(res->start, resource_size(res));
>  
> -	kfree(fbi);
> -
>  	return 0;
>  }
>  

NACK
Already have a patch queued up for this from Julia Lawall

Regards
Tony P

