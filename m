From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 17 Jan 2020 18:59:03 +0000
Subject: Re: [PATCH 2/2] video: fbdev: wm8505fb: add COMPILE_TEST support
Message-Id: <20200117185903.GB24722@ravnborg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145810eucas1p11937b8ef56638752cb2fe501833c63fa@eucas1p1.samsung.com>
 <900c16b3-9306-7d17-f467-0f98bc95416a@samsung.com>
In-Reply-To: <900c16b3-9306-7d17-f467-0f98bc95416a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Prisk <linux@prisktech.co.nz>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Jan 16, 2020 at 03:58:08PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to wm8505fb driver for better compile
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
> @@ -1639,7 +1639,7 @@ config FB_VT8500
>  
>  config FB_WM8505
>  	bool "Wondermedia WM8xxx-series frame buffer support"
> -	depends on (FB = y) && ARM && ARCH_VT8500
> +	depends on (FB = y) && HAS_IOMEM && (ARCH_VT8500 || COMPILE_TEST)
>  	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
>  	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
>  	select FB_SYS_IMAGEBLIT
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
