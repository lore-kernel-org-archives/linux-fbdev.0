From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Nov 2019 07:43:07 +0000
Subject: Re: [PATCH v2] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <CAMuHMdW7fkPjqppQYESDf4ZLKcCrxhMUyCn0=tm6kxPSxf5mGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190927094708.11563-1-geert@linux-m68k.org>
In-Reply-To: <20190927094708.11563-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Bartlomiej, Andrew,

On Fri, Sep 27, 2019 at 11:47 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> When the compiler decides not to inline the Chunky-to-Planar core
> functions, the build fails with:
>
>     c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
>     c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
>     c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
>
> Fix this by marking the functions __always_inline.
>
> While this could be triggered before by manually enabling both
> CONFIG_OPTIMIZE_INLINING and CONFIG_CC_OPTIMIZE_FOR_SIZE, it was exposed
> in the m68k defconfig by commit ac7c3e4ff401b304 ("compiler: enable
> CONFIG_OPTIMIZE_INLINING forcibly").
>
> Fixes: 9012d011660ea5cf ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> This is a fix for v5.4-rc1.

Can you please apply this for v5.4?
This is one of the 4 remaining build regressions, compared to v5.3.

Thanks!

> v2:
>   - Add Reviewed-by,
>   - Fix Fixes,
>   - Add more explanation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
