From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 08:46:34 +0000
Subject: Re: [PATCH] video, udlfb: Fix two build warning about 'ignoring return value'
Message-Id: <20110418084634.GC32457@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1302769070-21670-1-git-send-email-namei.unix@gmail.com>
In-Reply-To: <1302769070-21670-1-git-send-email-namei.unix@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liu Yuan <namei.unix@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 14, 2011 at 04:17:50PM +0800, Liu Yuan wrote:
> Build warning:
> ...
> drivers/video/udlfb.c:1590: warning: ignoring return value of ???device_create_file???, declared with attribute warn_unused_result
> drivers/video/udlfb.c:1592: warning: ignoring return value of ???device_create_bin_file???, declared with attribute warn_unused_result
> 
> So add two checks to get rid of 'em.
> 
> Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
> ---
>  drivers/video/udlfb.c |   15 ++++++++++++---
>  1 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
> index 68041d9..55d6de6 100644
> --- a/drivers/video/udlfb.c
> +++ b/drivers/video/udlfb.c
> @@ -1586,10 +1586,19 @@ static int dlfb_usb_probe(struct usb_interface *interface,
>  		goto error;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++)
> -		device_create_file(info->dev, &fb_device_attrs[i]);
> +	for (i = 0; i < ARRAY_SIZE(fb_device_attrs); i++) {
> +		retval = device_create_file(info->dev, &fb_device_attrs[i]);
> +		if (retval) {
> +			pr_err("device_create_file failed %d\n", retval);
> +			goto error;
> +		}
> +	}
>  
> -	device_create_bin_file(info->dev, &edid_attr);
> +	retval = device_create_bin_file(info->dev, &edid_attr);
> +	if (retval) {
> +		pr_err("device_create_bin_file failed %d\n", retval);
> +		goto error;
> +	}
>  

While this will get rid of the warnings, it doesn't take care of cleaning
up the created files in the error case..
