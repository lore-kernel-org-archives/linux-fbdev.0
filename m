From: Ryan Mallon <rmallon@gmail.com>
Date: Sat, 16 Mar 2013 02:19:48 +0000
Subject: Re: [PATCH 1/3] backlight: ep93xx_bl: fix section mismatch
Message-Id: <5143D6C4.9060503@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201303151803.08774.hartleys@visionengravers.com>
In-Reply-To: <201303151803.08774.hartleys@visionengravers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, rpurdie@rpsys.net, FlorianSchandinat@gmx.de

On 16/03/13 12:03, H Hartley Sweeten wrote:

> Remove the __init tag from ep93xxbl_probe() to fix the section
> mismatch warning.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>


There is a patch for this already queued in Andrew Morton's tree.

~Ryan

> ---
>  drivers/video/backlight/ep93xx_bl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
> index ef3e21e..17b8abb 100644
> --- a/drivers/video/backlight/ep93xx_bl.c
> +++ b/drivers/video/backlight/ep93xx_bl.c
> @@ -60,7 +60,7 @@ static const struct backlight_ops ep93xxbl_ops = {
>  	.get_brightness	= ep93xxbl_get_brightness,
>  };
>  
> -static int __init ep93xxbl_probe(struct platform_device *dev)
> +static int ep93xxbl_probe(struct platform_device *dev)
>  {
>  	struct ep93xxbl *ep93xxbl;
>  	struct backlight_device *bl;
> @@ -145,7 +145,6 @@ static struct platform_driver ep93xxbl_driver = {
>  	.suspend	= ep93xxbl_suspend,
>  	.resume		= ep93xxbl_resume,
>  };
> -
>  module_platform_driver(ep93xxbl_driver);
>  
>  MODULE_DESCRIPTION("EP93xx Backlight Driver");


