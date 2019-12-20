From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 20 Dec 2019 18:07:22 +0000
Subject: Re: [PATCH] fbcon: Adjust indentation in set_con2fb_map
Message-Id: <CAKwvOd=DcXiA5d07bS_3qhr4F-mbsGzZic=OgomuhZchGaXeoQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191218025337.35044-1-natechancellor@gmail.com>
In-Reply-To: <20191218025337.35044-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Tue, Dec 17, 2019 at 6:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/video/fbdev/core/fbcon.c:915:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         return err;
>         ^
> ../drivers/video/fbdev/core/fbcon.c:912:2: note: previous statement is
> here
>         if (!search_fb_in_map(info_idx))
>         ^
> 1 warning generated.
>
> This warning occurs because there is a space before the tab on this
> line. This happens on several lines in this function; normalize them
> so that the indentation is consistent with the Linux kernel coding
> style and clang no longer warns.
>
> This warning was introduced before the beginning of git history so no
> fixes tab.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/824
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/video/fbdev/core/fbcon.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index c9235a2f42f8..9d2c43e345a4 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -866,7 +866,7 @@ static int set_con2fb_map(int unit, int newidx, int user)
>         int oldidx = con2fb_map[unit];
>         struct fb_info *info = registered_fb[newidx];
>         struct fb_info *oldinfo = NULL;
> -       int found, err = 0;
> +       int found, err = 0;
>
>         WARN_CONSOLE_UNLOCKED();
>
> @@ -888,31 +888,30 @@ static int set_con2fb_map(int unit, int newidx, int user)
>
>         con2fb_map[unit] = newidx;
>         if (!err && !found)
> -               err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
> -
> +               err = con2fb_acquire_newinfo(vc, info, unit, oldidx);
>
>         /*
>          * If old fb is not mapped to any of the consoles,
>          * fbcon should release it.
>          */
> -       if (!err && oldinfo && !search_fb_in_map(oldidx))
> -               err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
> -                                            found);
> +       if (!err && oldinfo && !search_fb_in_map(oldidx))
> +               err = con2fb_release_oldinfo(vc, oldinfo, info, unit, oldidx,
> +                                            found);
>
> -       if (!err) {
> -               int show_logo = (fg_console = 0 && !user &&
> -                                logo_shown != FBCON_LOGO_DONTSHOW);
> +       if (!err) {
> +               int show_logo = (fg_console = 0 && !user &&
> +                                logo_shown != FBCON_LOGO_DONTSHOW);
>
> -               if (!found)
> -                       fbcon_add_cursor_timer(info);
> -               con2fb_map_boot[unit] = newidx;
> -               con2fb_init_display(vc, info, unit, show_logo);
> +               if (!found)
> +                       fbcon_add_cursor_timer(info);
> +               con2fb_map_boot[unit] = newidx;
> +               con2fb_init_display(vc, info, unit, show_logo);
>         }
>
>         if (!search_fb_in_map(info_idx))
>                 info_idx = newidx;
>
> -       return err;
> +       return err;
>  }
>
>  /*
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191218025337.35044-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
