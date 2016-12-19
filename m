From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Dec 2016 16:13:02 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: use designated initializers
Message-Id: <CAMuHMdWE=cZSTCGcoi71xQU+fBpEU5J-ZruxmvQ9RAMEzrJMkw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161217010203.GA140420@beast>
In-Reply-To: <20161217010203.GA140420@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Sat, Dec 17, 2016 at 2:02 AM, Kees Cook <keescook@chromium.org> wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> index 82c0a8caa9b8..42499a1afa07 100644
> --- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
> +++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
> @@ -439,9 +439,9 @@ static unsigned long lcdc_sys_read_data(void *handle)
>  }
>
>  static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
> -       lcdc_sys_write_index,
> -       lcdc_sys_write_data,
> -       lcdc_sys_read_data,
> +       .write_index = lcdc_sys_write_index,
> +       .write_data = lcdc_sys_write_data,
> +       .read_data = lcdc_sys_read_data,
>  };
>
>  static int sh_mobile_lcdc_sginit(struct fb_info *info,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
