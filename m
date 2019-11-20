From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 20 Nov 2019 16:41:55 +0000
Subject: Re: [PATCH] staging: fbtft: Fix Kconfig indentation
Message-Id: <20191120164155.GR30416@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191120133911.13539-1-krzk@kernel.org>
In-Reply-To: <20191120133911.13539-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wed, Nov 20, 2019 at 09:39:11PM +0800, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I expect Greg will pick this up.
-Daniel

> ---
>  drivers/staging/fbtft/Kconfig | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> index d994aea84b21..19d9d88e9150 100644
> --- a/drivers/staging/fbtft/Kconfig
> +++ b/drivers/staging/fbtft/Kconfig
> @@ -95,8 +95,8 @@ config FB_TFT_PCD8544
>  	  Generic Framebuffer support for PCD8544
>  
>  config FB_TFT_RA8875
> -        tristate "FB driver for the RA8875 LCD Controller"
> -        depends on FB_TFT
> +	tristate "FB driver for the RA8875 LCD Controller"
> +	depends on FB_TFT
>  	help
>  	  Generic Framebuffer support for RA8875
>  
> @@ -132,10 +132,10 @@ config FB_TFT_SSD1289
>  	  Framebuffer support for SSD1289
>  
>  config FB_TFT_SSD1305
> -        tristate "FB driver for the SSD1305 OLED Controller"
> -        depends on FB_TFT
> -        help
> -          Framebuffer support for SSD1305
> +	tristate "FB driver for the SSD1305 OLED Controller"
> +	depends on FB_TFT
> +	help
> +	  Framebuffer support for SSD1305
>  
>  config FB_TFT_SSD1306
>  	tristate "FB driver for the SSD1306 OLED Controller"
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
