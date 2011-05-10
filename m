From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 May 2011 09:42:01 +0000
Subject: Re: [PATCH] omap2/omapfb: make DBG() more resistant in if-else constructions
Message-Id: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
In-Reply-To: <1305019249-9898-1-git-send-email-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Niels de Vos <ndevos@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, May 10, 2011 at 11:20, Niels de Vos <ndevos@redhat.com> wrote:
> When DBG() is used in a simple if-else, the resulting code path
> currently depends on the definition of DBG(). Inserting the statement in
> a "do { ... } while (0)" prevents this possible misuse.
>
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

> --- a/drivers/video/omap2/omapfb/omapfb.h
> +++ b/drivers/video/omap2/omapfb/omapfb.h
> @@ -34,8 +34,10 @@
>  #ifdef DEBUG
>  extern unsigned int omapfb_debug;
>  #define DBG(format, ...) \
> -       if (omapfb_debug) \
> -               printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__)
> +       do { \
> +               if (omapfb_debug) \
> +                       printk(KERN_DEBUG "OMAPFB: " format, ## __VA_ARGS__); \
> +       while (0)

Where's the closing '}'?

>  #else
>  #define DBG(format, ...)

BTW, no printf()-style format checking here.

>  #endif

What about using the standard pr_debug()/dev_dbg() instead?
With dynamic debug, it can be enabled at run time.
As a bonus, you get printf()-style format checking if debugging is disabled.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
