From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Jul 2018 07:16:42 +0000
Subject: Re: [PATCH] fb: amifb: fix build warnings when not builtin
Message-Id: <CAMuHMdVL8v4Y5iEyYxSAfFnWFq5+trAr+cWHbF59Ge_5gRwpNA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cda83e71-7bfc-5997-a271-0362a7ac0354@infradead.org>
In-Reply-To: <cda83e71-7bfc-5997-a271-0362a7ac0354@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Randy,

On Fri, Jul 27, 2018 at 2:00 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build warning when built as a loadable module.
> amifb_setup() and amifb_setup_mcap() are only needed when the driver
> is builtin.
> This matches how the functions are called (using #ifndef MODULE).
>
> ../drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
>  static int __init amifb_setup(char *options)
>
> ../drivers/video/fbdev/amifb.c:2307:20: warning: 'amifb_setup_mcap' defined but not used [-Wunused-function]
>  static void __init amifb_setup_mcap(char *spec)

Thanks for your patch!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Ideally, amifb_setup() should be called in the modular case, too.
But probably nobody cares.

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/fbdev/amifb.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20180717.orig/drivers/video/fbdev/amifb.c
> +++ linux-next-20180717/drivers/video/fbdev/amifb.c
> @@ -2303,7 +2303,7 @@ static void ami_build_copper(struct fb_i
>         ami_rebuild_copper(info->par);
>  }
>
> -
> +#ifndef MODULE
>  static void __init amifb_setup_mcap(char *spec)
>  {
>         char *p;
> @@ -2368,7 +2368,7 @@ static int __init amifb_setup(char *opti
>
>         return 0;
>  }
> -
> +#endif
>
>  static int amifb_check_var(struct fb_var_screeninfo *var,
>                            struct fb_info *info)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
