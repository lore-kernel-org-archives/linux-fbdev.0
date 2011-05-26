From: Peter Jones <pjones@redhat.com>
Date: Thu, 26 May 2011 14:35:09 +0000
Subject: Re: [PATCH 4/4] efifb: Disallow manual bind and unbind
Message-Id: <4DDE651D.3040504@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c160d075ca68ffd4eef4d0a64ef5fa49fa2c40e.1306418703.git.luto@mit.edu>
In-Reply-To: <7c160d075ca68ffd4eef4d0a64ef5fa49fa2c40e.1306418703.git.luto@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 05/26/2011 10:13 AM, Andy Lutomirski wrote:
> Both were buggy: bind would happily scribble over a real graphics
> device and unbind wouldn't destroy the framebuffer.  Hotplugging
> efifb makes no sense anyway, so just disable it.
> 
> As an added benefit, we save some runtime memory.
> 
> Signed-off-by: Andy Lutomirski <luto@mit.edu>

Signed-off-by: Peter Jones <pjones@redhat.com>

> ---
>  drivers/video/efifb.c |   21 ++++++++++++++-------
>  1 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 39bbfa9..f67717e 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -331,7 +331,7 @@ static int __init efifb_setup(char *options)
>  	return 0;
>  }
>  
> -static int __devinit efifb_probe(struct platform_device *dev)
> +static int __init efifb_probe(struct platform_device *dev)
>  {
>  	struct fb_info *info;
>  	int err;
> @@ -501,7 +501,6 @@ err_release_mem:
>  }
>  
>  static struct platform_driver efifb_driver = {
> -	.probe	= efifb_probe,
>  	.driver	= {
>  		.name	= "efifb",
>  	},
> @@ -532,13 +531,21 @@ static int __init efifb_init(void)
>  	if (!screen_info.lfb_linelength)
>  		return -ENODEV;
>  
> -	ret = platform_driver_register(&efifb_driver);
> +	ret = platform_device_register(&efifb_device);
> +	if (ret)
> +		return ret;
>  
> -	if (!ret) {
> -		ret = platform_device_register(&efifb_device);
> -		if (ret)
> -			platform_driver_unregister(&efifb_driver);
> +	/*
> +	 * This is not just an optimization.  We will interfere
> +	 * with a real driver if we get reprobed, so don't allow
> +	 * it.
> +	 */
> +	ret = platform_driver_probe(&efifb_driver, efifb_probe);
> +	if (ret) {
> +		platform_device_unregister(&efifb_driver);
> +		return ret;
>  	}
> +
>  	return ret;
>  }
>  module_init(efifb_init);


-- 
        Peter

If you're not part of the solution, then you're part of the precipitate.

01234567890123456789012345678901234567890123456789012345678901234567890123456789
