From: Marek Szyprowski <m.szyprowski@samsung.com>
Date: Tue, 19 Oct 2010 06:50:56 +0000
Subject: RE: [PATCH 4/4] ARM: S5PV310: Add platform data for S5PV310 FIMD and
Message-Id: <002f01cb6f59$ff98d650$feca82f0$%szyprowski@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287406528-15324-1-git-send-email-sbkim73@samsung.com>
	<1287406528-15324-5-git-send-email-sbkim73@samsung.com>
In-Reply-To: <1287406528-15324-5-git-send-email-sbkim73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On Monday, October 18, 2010 2:55 PM Sangbeom Kim wrote:

> From: Jonghun Han <jonghun.han@samsung.com>
> 
> Some platform data for S5PV310 FIMD0 are added.
> LTE480WV lcd pannel used by SMDKV310 are added via platform-lcd interface.
> extern helper functions used by machine file are added.
> 
> Signed-off-by: Jonghun Han <jonghun.han@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  arch/arm/mach-s5pv310/mach-smdkv310.c   |   72 +++++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/fb.h |   14 ++++++
>  2 files changed, 86 insertions(+), 0 deletions(-)
> 
> ...

> diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
> index cb3ca3a..67733b5 100644
> --- a/arch/arm/plat-samsung/include/plat/fb.h
> +++ b/arch/arm/plat-samsung/include/plat/fb.h
> @@ -74,6 +74,14 @@ struct s3c_fb_platdata {
>  extern void s3c_fb_set_platdata(struct s3c_fb_platdata *pd);
> 
>  /**
> + * s5p_fimd0_set_platdata() - Setup the FB device with platform data.
> + * @pd: The platform data to set. The data is copied from the passed structure
> + *      so the machine data can mark the data __initdata so that any unused
> + *      machines will end up dumping their data at runtime.
> + */
> +extern void s5p_fimd0_set_platdata(struct s3c_fb_platdata *pd);
> +
> +/**
>   * s3c64xx_fb_gpio_setup_24bpp() - S3C64XX setup function for 24bpp LCD
>   *
>   * Initialise the GPIO for an 24bpp LCD display on the RGB interface.
> @@ -94,4 +102,10 @@ extern void s5pc100_fb_gpio_setup_24bpp(void);
>   */
>  extern void s5pv210_fb_gpio_setup_24bpp(void);
> 
> +/**
> + * s5pv310_fimd0_gpio_setup_24bpp() - S5PV310/S5PC210 setup function for 24bpp LCD0
> + *
> + * Initialise the GPIO for an 24bpp LCD display on the RGB interface 0.
> + */
> +extern void s5pv310_fimd0_gpio_setup_24bpp(void);
>  #endif /* __PLAT_S3C_FB_H */

Changes to arch/arm/plat-samsung/include/plat/fb.h file should go together with patch
2/4 from your series - they are not related to SMDK board at all.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center


