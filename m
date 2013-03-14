From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 14 Mar 2013 17:14:54 +0000
Subject: Re: [PATCH v2 1/8] drivers: media: use module_platform_driver_probe()
Message-Id: <Pine.LNX.4.64.1303141814290.22728@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363280978-24051-1-git-send-email-fabio.porcedda@gmail.com>
 <1363280978-24051-2-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1363280978-24051-2-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 14 Mar 2013, Fabio Porcedda wrote:

> This patch converts the drivers to use the
> module_platform_driver_probe() macro which makes the code smaller and
> a bit simpler.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Thanks, will queue for 3.10.

Regards
Guennadi

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Cc: Josh Wu <josh.wu@atmel.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Hans Verkuil <hans.verkuil@cisco.com>
> Cc: linux-media@vger.kernel.org
> ---
>  drivers/media/platform/soc_camera/atmel-isi.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
> index 82dbf99..12ba31d 100644
> --- a/drivers/media/platform/soc_camera/atmel-isi.c
> +++ b/drivers/media/platform/soc_camera/atmel-isi.c
> @@ -1081,17 +1081,7 @@ static struct platform_driver atmel_isi_driver = {
>  	},
>  };
>  
> -static int __init atmel_isi_init_module(void)
> -{
> -	return  platform_driver_probe(&atmel_isi_driver, &atmel_isi_probe);
> -}
> -
> -static void __exit atmel_isi_exit(void)
> -{
> -	platform_driver_unregister(&atmel_isi_driver);
> -}
> -module_init(atmel_isi_init_module);
> -module_exit(atmel_isi_exit);
> +module_platform_driver_probe(atmel_isi_driver, atmel_isi_probe);
>  
>  MODULE_AUTHOR("Josh Wu <josh.wu@atmel.com>");
>  MODULE_DESCRIPTION("The V4L2 driver for Atmel Linux");
> -- 
> 1.8.1.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
