From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Jun 2014 22:16:30 +0000
Subject: Re: [PATCH -next 25/26] fbdev: Use dma_zalloc_coherent
Message-Id: <CAMuHMdWHJ1LY0r1aMZViQW_ZZYrbGkHb4Hpkt+YZfRbERfyE3Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1402863904.git.joe@perches.com>
	<881b8f8d85c96b6e9d8735aa10bbf18468688b9d.1402863905.git.joe@perches.com>
In-Reply-To: <881b8f8d85c96b6e9d8735aa10bbf18468688b9d.1402863905.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Sun, Jun 15, 2014 at 10:37 PM, Joe Perches <joe@perches.com> wrote:
> diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
> index a8484f7..788f6b3 100644
> --- a/drivers/video/fbdev/da8xx-fb.c
> +++ b/drivers/video/fbdev/da8xx-fb.c
> @@ -1447,18 +1447,15 @@ static int fb_probe(struct platform_device *device)
>                 da8xx_fb_fix.line_length - 1;
>
>         /* allocate palette buffer */
> -       par->v_palette_base = dma_alloc_coherent(NULL,
> -                                              PALETTE_SIZE,
> -                                              (resource_size_t *)
> -                                              &par->p_palette_base,
> -                                              GFP_KERNEL | GFP_DMA);
> +       par->v_palette_base = dma_zalloc_coherent(NULL, PALETTE_SIZE,
> +                                                 (resource_size_t *)&par->p_palette_base,

Suggestion for further cleanup: It seems this cast is no longer needed.

> +                                                 GFP_KERNEL | GFP_DMA);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
