From: Joe Perches <joe@perches.com>
Date: Sun, 15 Jun 2014 23:32:39 +0000
Subject: Re: [PATCH -next 25/26] fbdev: Use dma_zalloc_coherent
Message-Id: <1402875159.2750.4.camel@joe-AO725>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1402863904.git.joe@perches.com>
	 <881b8f8d85c96b6e9d8735aa10bbf18468688b9d.1402863905.git.joe@perches.com>
	 <CAMuHMdWHJ1LY0r1aMZViQW_ZZYrbGkHb4Hpkt+YZfRbERfyE3Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWHJ1LY0r1aMZViQW_ZZYrbGkHb4Hpkt+YZfRbERfyE3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Mon, 2014-06-16 at 00:16 +0200, Geert Uytterhoeven wrote:
> On Sun, Jun 15, 2014 at 10:37 PM, Joe Perches <joe@perches.com> wrote:
> > diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx-fb.c
[]
> > @@ -1447,18 +1447,15 @@ static int fb_probe(struct platform_device *device)
> >                 da8xx_fb_fix.line_length - 1;
> >
> >         /* allocate palette buffer */
> > -       par->v_palette_base = dma_alloc_coherent(NULL,
> > -                                              PALETTE_SIZE,
> > -                                              (resource_size_t *)
> > -                                              &par->p_palette_base,
> > -                                              GFP_KERNEL | GFP_DMA);
> > +       par->v_palette_base = dma_zalloc_coherent(NULL, PALETTE_SIZE,
> > +                                                 (resource_size_t *)&par->p_palette_base,
> 
> Suggestion for further cleanup: It seems this cast is no longer needed.

Sure, but after this is applied.

