From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 26 Sep 2019 11:52:04 +0000
Subject: Re: [PATCH -next] fbdev: c2p: Fix link failure on non-inlining
Message-Id: <CAK7LNAShZJw4K4kDURPyJ1_NGQt50cBA-aB2HZCzK7LOdNSaKA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190926101312.32218-1-geert@linux-m68k.org> <CAK7LNATN5QyC+-_VRZm_ZysYd8Z8aWU0Ys0cTpU2GUdEdrXvPg@mail.gmail.com>
 <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
In-Reply-To: <CAMuHMdU3T83z1iZ7O2-5eRkawdGm50Auw5o0K9+J5Q7+oev62g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Geert,

On Thu, Sep 26, 2019 at 8:43 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>
> BTW, does randconfig randomize choices these days?
> I remember it didn't use to do that.

randconfig does randomize choices.


masahiro@pug:~/ref/linux$ make -s randconfig ; grep OPTIMIZE_FOR .config
KCONFIG_SEED=0x75F1F6C8
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
masahiro@pug:~/ref/linux$ make -s randconfig ; grep OPTIMIZE_FOR .config
KCONFIG_SEED=0x8FDFC7FC
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y


all{yes,mod}config always takes the default in the choice.
So, you cannot enable CONFIG_CC_OPTIMIZE_FOR_SIZE by all{yes,mod}config.





> The Amiga and Atari frame buffer drivers need <asm/{amiga,atari}hw.h>,
> and the Atari driver contains inline asm.
>
> The C2P code could be put behind its own Kconfig symbol, I guess.

OK, then.


Thanks.




-- 
Best Regards
Masahiro Yamada
