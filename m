From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 26 Sep 2019 10:25:07 +0000
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <CAK7LNARTk5yE1=WsxdYpEw6EYXMmq8cW5QBEse2WWhTJ0y=iMA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190926101312.32218-1-geert@linux-m68k.org>
In-Reply-To: <20190926101312.32218-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Sep 26, 2019 at 7:13 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
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
> Reported-by: noreply@ellerman.id.au
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>


Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>




-- 
Best Regards
Masahiro Yamada
