From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Nov 2013 11:59:40 +0000
Subject: Re: [PATCH] RFC: framebuffer: provide generic get_fb_unmapped_area
Message-Id: <CAMuHMdWtrSnTHNN-7GtMWAG9gZ0HJ3ZgVZt6Cfc=q=e-5Sr-Qw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1384772231-20993-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 18, 2013 at 11:57 AM, Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> This patch makes mmapping the simple-framebuffer device work on a no-MMU
> ARM target. The code is mostly taken from
> arch/blackfin/kernel/sys_bfin.c.
>
> Note this is only tested on this no-MMU machine and I don't know enough
> about framebuffers and mm to decide if this patch is sane. Also I'm
> unsure about the size check because it triggers if userspace page aligns
> the len parameter. (I don't know how usual it is to do, I'd say it's
> wrong, but my test program (fbtest by Geert Uytterhoeven) does it.)

It's quite common: the granularity of mmap() is PAGE_SIZE, i.e. if you
try to map a partial page, you'll get access to the full page anyway
(with MMU; without MMU, you can access everything anyway).
Fbtest always mmap()s the full (page aligned) smem_len.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/fbmem.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index dacaf74..70b328c 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1483,6 +1483,24 @@ __releases(&info->lock)
>         return 0;
>  }
>
> +#ifdef HAVE_ARCH_FB_UNMAPPED_AREA
> +#define fb_get_unmapped_area get_fb_unmapped_area
> +#else
> +unsigned long fb_get_unmapped_area(struct file *filp, unsigned long orig_addr,
> +               unsigned long len, unsigned long pgoff, unsigned long flags)
> +{
> +       struct fb_info * const info = filp->private_data;
> +       unsigned long screen_size = info->screen_size ?: info->fix.smem_len;

Why restrict this to screen_size? Fbtest will map the whole frame buffer memory.

Typically screen_size is not a multiple of PAGE_SIZE, so this is another
reason why your size check fails.

> +       if (len > screen_size) {
> +               pr_info("%lu > %lu (%lu, %lu)\n", len, screen_size, info->screen_size, info->fix.smem_len);
> +               return -EINVAL;
> +       }
> +
> +       return (unsigned long)info->screen_base;

Shouldn't you take into account pgoff?

> +}
> +#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
