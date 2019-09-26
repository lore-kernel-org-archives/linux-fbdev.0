From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Sep 2019 11:43:16 +0000
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190926101312.32218-1-geert@linux-m68k.org> <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
In-Reply-To: <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Yamada-san,

On Thu, Sep 26, 2019 at 12:45 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Sep 26, 2019 at 7:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> > Reported-by: noreply@ellerman.id.au
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
> >
> > As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
> > stable.
>
> BTW, that Fixes tag is incorrect.
>
> Irrespective of 025f072e5823947c, you could manually enable
> CONFIG_OPTIMIZE_INLINING from menuconfig etc.

Merely enabling that doesn't help.
You also need CONFIG_CC_OPTIMIZE_FOR_SIZE=y, while the
default is CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y.
Which is why my all{mod,yes}config builds never caught that :-(

> So, this build error would have been found much earlier
> if somebody had been running randconfig tests on m68k.

It's been a while I did that...

BTW, does randconfig randomize choices these days?
I remember it didn't use to do that.

> It is impossible to detect this error on other architectures
> because the driver config options are guarded by
> 'depends on ATARI' or 'depends on AMIGA'.
>
> The correct tag is:
>
> Fixes: 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING")
>
> The commit id is stable.

Thanks, will update.

> As an additional work,
> depends on (AMIGA || COMPILE_TEST)
> would be nice unless this driver contains m68k-specific code.

The Amiga and Atari frame buffer drivers need <asm/{amiga,atari}hw.h>,
and the Atari driver contains inline asm.

The C2P code could be put behind its own Kconfig symbol, I guess.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
