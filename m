From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 26 Sep 2019 10:45:06 +0000
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
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
> ---
> Fixes: 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
>
> As this is a patch in akpm's tree, the commit ID in the Fixes tag is not
> stable.

BTW, that Fixes tag is incorrect.

Irrespective of 025f072e5823947c, you could manually enable
CONFIG_OPTIMIZE_INLINING from menuconfig etc.

So, this build error would have been found much earlier
if somebody had been running randconfig tests on m68k.

It is impossible to detect this error on other architectures
because the driver config options are guarded by
'depends on ATARI' or 'depends on AMIGA'.


The correct tag is:

Fixes: 9012d011660e ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING")

The commit id is stable.



As an additional work,
depends on (AMIGA || COMPILE_TEST)
would be nice unless this driver contains m68k-specific code.


-- 
Best Regards
Masahiro Yamada
