From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Oct 2016 09:35:17 +0000
Subject: Re: [PATCH -resend 4/6] mdacon: enable COMPILE_TEST build
Message-Id: <CAMuHMdVv+z926OUd6v-P9CBEhKHWkFJFgLxdt=Cizw8JMh2VVg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161003090736.19926-1-jslaby@suse.cz> <20161003090736.19926-4-jslaby@suse.cz>
In-Reply-To: <20161003090736.19926-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jslaby@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, Oct 3, 2016 at 11:07 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> It can be built even on systems without ISA. So enable compile testing
> by specifying ISA || COMPILE_TEST.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: <linux-fbdev@vger.kernel.org>
> ---
>  drivers/video/console/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
> index 38da6e299149..7e9e8be24134 100644
> --- a/drivers/video/console/Kconfig
> +++ b/drivers/video/console/Kconfig
> @@ -48,7 +48,7 @@ config VGACON_SOFT_SCROLLBACK_SIZE
>          screenfuls of scrollback buffer
>
>  config MDA_CONSOLE
> -       depends on !M68K && !PARISC && ISA
> +       depends on !M68K && !PARISC && (ISA || COMPILE_TEST)

My first thought was

    depends on (!M68K && !PARISC && ISA) || COMPILE_TEST

but arch/m68k/include/asm/vga.h doesn't define VGA_MAP_MEM().
Adding #include <asm-generic/vga.h> at the end of arch/m68k/include/asm/vga.h
fixes that.

Do we want that?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
