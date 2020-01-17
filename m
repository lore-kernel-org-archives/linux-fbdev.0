From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 18:57:22 +0000
Subject: Re: [PATCH] video: fbdev: arcfb: add COMPILE_TEST support
Message-Id: <20200117185722.GA24508@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116144909eucas1p1b247368aded82dad3ca8da852deaca1a@eucas1p1.samsung.com>
 <acf2cc2e-614d-f0fb-ce40-cee62bfcde4c@samsung.com>
In-Reply-To: <acf2cc2e-614d-f0fb-ce40-cee62bfcde4c@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Jan 16, 2020 at 03:49:07PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to arcfb driver for better compile
> testing coverage.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/Kconfig
> =================================> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -435,7 +435,7 @@ config FB_FM2
>  
>  config FB_ARC
>  	tristate "Arc Monochrome LCD board support"
> -	depends on FB && X86
> +	depends on FB && (X86 || COMPILE_TEST)
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
>  	select FB_SYS_IMAGEBLIT
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
