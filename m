From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Mar 2016 07:55:36 +0000
Subject: Re: [PATCH 1/2] fbdev: sh_mobile_meram: use ARCH_RENESAS
Message-Id: <CAMuHMdV81zT5+dXvUaGxLEyy45G_T_5k_JYj83KUVMN7KyuBcg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1457663298-31973-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Simon,

On Fri, Mar 11, 2016 at 3:28 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use ARCH_RENESAS in place of ARCH_SHMOBILE.
> Also remove spurious ().
>
> This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/video/fbdev/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 8ea45a5cd806..71294f595f61 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1985,7 +1985,7 @@ config FB_W100
>
>  config FB_SH_MOBILE_LCDC
>         tristate "SuperH Mobile LCDC framebuffer support"
> -       depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
> +       depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK

I would replace SUPERH by ARCH_RENESAS, and thus keep ARCH_SHMOBILE.

"sh_mobile_lcdc_fb" is used on SH_AP325RXA, SH_ECOVEC, SH_KFR2R09, SH_MIGOR,
and SH_7724_SOLUTION_ENGINE, which depend on either CPU_SUBTYPE_SH7722,
CPU_SUBTYPE_SH7723, or CPU_SUBTYPE_SH7724, and all three select ARCH_SHMOBILE.

In addition, it's used on r8a7740/armadillo800eva, which is covered by
ARCH_RENESAS.

>         depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
>         select FB_SYS_FILLRECT
>         select FB_SYS_COPYAREA
> @@ -2450,7 +2450,7 @@ source "drivers/video/fbdev/mmp/Kconfig"
>
>  config FB_SH_MOBILE_MERAM
>         tristate "SuperH Mobile MERAM read ahead support"
> -       depends on (SUPERH || ARCH_SHMOBILE)
> +       depends on SUPERH || ARCH_RENESAS
>         select GENERIC_ALLOCATOR
>         ---help---
>           Enable MERAM support for the SuperH controller.

As Laurent already pointed out, that one is currently unused.

It could be used on sh73a0, r8a7740, and some SuperH SH-Mobile SoCs, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
