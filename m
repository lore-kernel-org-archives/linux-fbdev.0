From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 06 Apr 2018 08:41:24 +0000
Subject: Re: [PATCH v2 15/19] omap2: omapfb: allow building it with COMPILE_TEST
Message-Id: <4561c3e1-dba6-d2c6-1649-5d79d5512f06@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1522959716.git.mchehab@s-opensource.com>
 <f0947227675df4a774949500b6ee4cac1485b494.1522959716.git.mchehab@s-opensource.com>
In-Reply-To: <f0947227675df4a774949500b6ee4cac1485b494.1522959716.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-omap@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On 05/04/18 23:29, Mauro Carvalho Chehab wrote:
> This driver builds cleanly with COMPILE_TEST, and it is
> needed in order to allow building drivers/media omap2
> driver.
> 
> So, change the logic there to allow building it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> ---
>  drivers/video/fbdev/omap2/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/omap2/Kconfig b/drivers/video/fbdev/omap2/Kconfig
> index 0921c4de8407..82008699d253 100644
> --- a/drivers/video/fbdev/omap2/Kconfig
> +++ b/drivers/video/fbdev/omap2/Kconfig
> @@ -1,4 +1,4 @@
> -if ARCH_OMAP2PLUS
> +if ARCH_OMAP2PLUS || COMPILE_TEST
>  
>  source "drivers/video/fbdev/omap2/omapfb/Kconfig"
>  
> 

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
