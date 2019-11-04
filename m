From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 04 Nov 2019 09:50:01 +0000
Subject: Re: [PATCH v2] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <20191104095001.GB10326@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190927094708.11563-1-geert@linux-m68k.org>
 <CAMuHMdW7fkPjqppQYESDf4ZLKcCrxhMUyCn0=tm6kxPSxf5mGA@mail.gmail.com>
In-Reply-To: <CAMuHMdW7fkPjqppQYESDf4ZLKcCrxhMUyCn0=tm6kxPSxf5mGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Linux/m68k <linux-m68k@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On Mon, Nov 04, 2019 at 08:43:07AM +0100, Geert Uytterhoeven wrote:
> Hi Bartlomiej, Andrew,
> 
> On Fri, Sep 27, 2019 at 11:47 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > When the compiler decides not to inline the Chunky-to-Planar core
> > functions, the build fails with:
> >
> >     c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> >     c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> >     c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> >     c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> >
> > Fix this by marking the functions __always_inline.
> >
> > While this could be triggered before by manually enabling both
> > CONFIG_OPTIMIZE_INLINING and CONFIG_CC_OPTIMIZE_FOR_SIZE, it was exposed
> > in the m68k defconfig by commit ac7c3e4ff401b304 ("compiler: enable
> > CONFIG_OPTIMIZE_INLINING forcibly").
> >
> > Fixes: 9012d011660ea5cf ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> > This is a fix for v5.4-rc1.
> 
> Can you please apply this for v5.4?
> This is one of the 4 remaining build regressions, compared to v5.3.

Applied to drm-misc-fixes, thanks for your patch.
-Daniel

> 
> Thanks!
> 
> > v2:
> >   - Add Reviewed-by,
> >   - Fix Fixes,
> >   - Add more explanation.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
