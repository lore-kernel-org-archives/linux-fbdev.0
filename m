From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 18:57:55 +0000
Subject: Re: [PATCH 2/2] video: fbdev: w100fb: add COMPILE_TEST support
Message-Id: <20200117185755.GC24508@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145359eucas1p1350bf2b827aa7ffa3e6767739e9ba7ad@eucas1p1.samsung.com>
 <a929db5e-d373-7b09-ae2b-efec227f7e85@samsung.com>
In-Reply-To: <a929db5e-d373-7b09-ae2b-efec227f7e85@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Jan 16, 2020 at 03:53:58PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to w100fb driver for better compile
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
> @@ -1827,7 +1827,7 @@ config FB_FSL_DIU
>  
>  config FB_W100
>  	tristate "W100 frame buffer support"
> -	depends on FB && ARCH_PXA
> +	depends on FB && HAS_IOMEM && (ARCH_PXA || COMPILE_TEST)
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
