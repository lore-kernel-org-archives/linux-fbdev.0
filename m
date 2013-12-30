From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Dec 2013 08:51:38 +0000
Subject: Re: [PATCH] fonts:Kconfig: fix default enable FONT_8x8 and FONT_8x16 at the same time
Message-Id: <CAMuHMdVdg3-g9FGMjeKDw=a79eAzEMURgp8Vng8n-pWKHH9Usg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20131230065303.GA6640@udknight>
In-Reply-To: <20131230065303.GA6640@udknight>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Dec 30, 2013 at 7:53 AM, Wang YanQing <udknight@gmail.com> wrote:
> FONT_8x8 and FONT_8x16 have the same default value line:
> "default y if !SPARC && !FONTS"
>
> I test run "make defconfig" for x86 will enable FONT_8x8 and FONT_8x16 at
> the same time.
>
> This patch fix it, because FONT_AUTOSELECT choice FONT_8x16, so
> I decide to disable FONT_8x8, this patch will reduce size of kernel.

... at the expense of losing FONT_8x8...

In another email, you wrote:
| Sorry for confusion, the default behavior enable FONT_8x8 and FONT_8x16,
| FONT_8x8 eat ~50KB memory, but kernel never use it. I think this is not
| good default behavior.

Whether FONT_8x8 or FONT_8x16 is used depends on your screen resolution,
cfr. lib/fonts/font.c:get_default_font().

If you don't want to compile in FONT_8x8, then please enable CONFIG_FONTS,
and disable CONFIG_FONT_8x8.

> Signed-off-by: Wang YanQing <udknight@gmail.com>
> ---
>  lib/fonts/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
> index 34fd931..11d3758 100644
> --- a/lib/fonts/Kconfig
> +++ b/lib/fonts/Kconfig
> @@ -23,7 +23,6 @@ config FONTS
>  config FONT_8x8
>         bool "VGA 8x8 font" if FONTS
>         depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE
> -       default y if !SPARC && !FONTS
>         help
>           This is the "high resolution" font for the VGA frame buffer (the one
>           provided by the text console 80x50 (and higher) modes).
> --
> 1.8.3.4.8.g69490f3.dirty

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
