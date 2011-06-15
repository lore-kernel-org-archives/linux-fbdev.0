From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jun 2011 11:32:56 +0000
Subject: Re: [PATCH] video: Add GRVGA framebuffer device driver
Message-Id: <BANLkTintJgEJUH-UV_+4f4prAbjjQcZnOA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 15, 2011 at 10:56, Kristoffer Glembo <kristoffer@gaisler.com> wrote:
> This patch adds support for the GRVGA framebuffer IP core from Aeroflex Gaisler.
> The device is used in LEON SPARCV8 based System on Chips. Documentation can
> be found here: www.gaisler.com/products/grlib/grip.pdf.
>
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>
> ---
>  drivers/video/Kconfig  |   10 +
>  drivers/video/Makefile |    1 +
>  drivers/video/grvga.c  |  559 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 570 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/video/grvga.c
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 549b960..18ee201 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -259,6 +259,16 @@ config FB_TILEBLITTING
>  comment "Frame buffer hardware drivers"
>        depends on FB
>
> +config FB_GRVGA
> +       tristate "Aeroflex Gaisler framebuffer support"
> +       depends on FB && SPARC

At first sight, nothing in this driver seems to be SPARC-specific, so
perhaps this can be relaxed
to e.g. depends on OF_DEVICE?

> +       select FB_CFB_FILLRECT
> +       select FB_CFB_COPYAREA
> +       select FB_CFB_IMAGEBLIT
> +       ---help---
> +       This enables support for the SVGACTRL framebuffer in the GRLIB IP library from Aeroflex Gaisler.
> +
> +
>  config FB_CIRRUS
>        tristate "Cirrus Logic support"
>        depends on FB && (ZORRO || PCI)

> --- /dev/null
> +++ b/drivers/video/grvga.c

> +       dev_info(&dev->dev,
> +                "Aeroflex Gaisler framebuffer device (fb%d), %dx%d-%d, using %luK of video memory @ 0x%x\n",
> +                info->node, info->var.xres, info->var.yres, info->var.bits_per_pixel,
> +                grvga_mem_size >> 10, (unsigned int) info->screen_base);
                                ^^^^^^^^^^^^^^
Please remove the cast and use %p to format the address.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
