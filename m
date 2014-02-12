From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 12 Feb 2014 09:56:08 +0000
Subject: Re: [PATCH 1/1] video: exynos: Fix S6E8AX0 LCD driver build error
Message-Id: <CAK9yfHwiCKBCPSsdCVt8SLdu5b_cm9-s0bpf1kaTANfVjqbStw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1392198583-1828-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12 February 2014 15:19, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Enable S6E8AX0 LCD driver only if LCD_CLASS_DEVICE is a built-in driver.
> Else we get the following errors due to missing symbols:
> drivers/built-in.o: In function `s6e8ax0_probe':
> :(.text+0x51aec): undefined reference to `lcd_device_register'
> :(.text+0x51c44): undefined reference to `lcd_device_unregister'
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/exynos/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/exynos/Kconfig b/drivers/video/exynos/Kconfig
> index 976594d578a9..eb6f2b059821 100644
> --- a/drivers/video/exynos/Kconfig
> +++ b/drivers/video/exynos/Kconfig
> @@ -22,7 +22,8 @@ config EXYNOS_MIPI_DSI
>
>  config EXYNOS_LCD_S6E8AX0
>         bool "S6E8AX0 MIPI AMOLED LCD Driver"
> -       depends on (EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE && LCD_CLASS_DEVICE)
> +       depends on EXYNOS_MIPI_DSI && BACKLIGHT_CLASS_DEVICE
> +       depends on (LCD_CLASS_DEVICE = y)
>         default n
>         help
>           If you have an S6E8AX0 MIPI AMOLED LCD Panel, say Y to enable its
> --
> 1.7.9.5
>

Sorry, please ignore this.

-- 
With warm regards,
Sachin
