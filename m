From: Jingoo Han <jingoohan1@gmail.com>
Date: Tue, 18 Jun 2019 06:12:27 +0000
Subject: Re: [PATCH] video: fbdev: s3c-fb: add COMPILE_TEST support
Message-Id: <PSXP216MB0662B10864E4DDEC1EC1823CAAEA0@PSXP216MB0662.KORP216.PROD.OUTLOOK.COM>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190614144634eucas1p1b04dcfcc040c3c886d2b33592c501d3b@eucas1p1.samsung.com>
 <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
In-Reply-To: <e771b89b-0e38-a712-b635-8d53cbf95a8e@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Han Jingoo <jingoohan1@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On 6/14/19, 11:46 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Add COMPILE_TEST support to s3c-fb driver for better compile
> testing coverage.
>
> Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/video/fbdev/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Index: b/drivers/video/fbdev/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1877,7 +1877,8 @@ config FB_TMIO_ACCELL
>  
>  config FB_S3C
>  	tristate "Samsung S3C framebuffer support"
> -	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
> +	depends on FB && HAVE_CLK && HAS_IOMEM
> +	depends on (CPU_S3C2416 || ARCH_S3C64XX) || COMPILE_TEST
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
