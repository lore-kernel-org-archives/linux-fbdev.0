From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Dec 2013 17:48:49 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <CAMuHMdWg83s3gW_szkVk8Ht6+fZ7dUkEaG0FYphe13GDbPD1Bw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Dec 12, 2013 at 6:13 PM, Mark Brown <broonie@kernel.org> wrote:
> The CLCD driver is used on ARM reference models for ARMv8 so add ARM64
> to the list of dependencies. The driver also has no build time dependencies
> on ARM (stubs are provided for ARM-specific DMA functions in the code) so
> make it available with COMPILE_TEST in order to maximise build coverage.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/video/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 4f2e1b35eb38..e6c7fb1a389b 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -312,7 +312,8 @@ config FB_PM2_FIFO_DISCONNECT
>
>  config FB_ARMCLCD
>         tristate "ARM PrimeCell PL110 support"
> -       depends on FB && ARM && ARM_AMBA
> +       depends on ARM || ARM64 || COMPILE_TEST
> +       depends on FB && ARM_AMBA
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT

Currently ARM_AMBA exists on arm/arm64 only.
Is there a patch in the pipeline to change that? Without such a change,
this patch doesn't make any difference.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
