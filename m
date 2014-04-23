From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2014 19:45:45 +0000
Subject: Re: [PATCH] fbdev: Fix tmiofb driver dependencies
Message-Id: <CAMuHMdXjxZhno9T1PCcSL39Up4X4_0yEO9Xm4uZ4dSvA9DtYyA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140423135104.2974008f@endymion.delvare>
In-Reply-To: <20140423135104.2974008f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Jean,

On Wed, Apr 23, 2014 at 1:51 PM, Jean Delvare <jdelvare@suse.de> wrote:
> The tmiofb driver should not depend on MFD_CORE but on MFD_TMIO.
> Without the tmio_core driver, tmiofb has no platform device to bind
> to and is thus useless.

What about COMPILE_TEST?

> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
> I suspect that MFD_TMIO was originally intended and MFD_CORE was a
> typo.

Does it compile with MFD_CORE=n?
If no: depends on FB && MDF_CORE && (MFD_TMIO || COMPILE_TEST)
If yes: depends on FB && (MFD_TMIO || COMPILE_TEST)

>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-3.15-rc2.orig/drivers/video/fbdev/Kconfig     2014-04-23 11:51:17.163933232 +0200
> +++ linux-3.15-rc2/drivers/video/fbdev/Kconfig  2014-04-23 13:40:01.170774059 +0200
> @@ -1993,7 +1993,7 @@ config FB_SH_MOBILE_HDMI
>
>  config FB_TMIO
>         tristate "Toshiba Mobile IO FrameBuffer support"
> -       depends on FB && MFD_CORE
> +       depends on FB && MFD_TMIO

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
