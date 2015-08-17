From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 16:21:01 +0000
Subject: Re: [PATCH] ARC: add negative dependency for VGA_CONSOLE
Message-Id: <CAMuHMdW0hzGN74pCRhCUwJ0Ua3YN94csFfu3Mb-STeCuLosoGw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1439826777-11489-1-git-send-email-yuriy.kolerov@synopsys.com>
In-Reply-To: <1439826777-11489-1-git-send-email-yuriy.kolerov@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yuriy Kolerov <yuriy.kolerov@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Anton.Kolesov@synopsys.com, Francois Bedard <Francois.Bedard@synopsys.com>

On Mon, Aug 17, 2015 at 5:52 PM, Yuriy Kolerov
<yuriy.kolerov@synopsys.com> wrote:
> Architectures which support VGA console must define screen_info
> structurture from "uapi/linux/screen_info.h". Otherwise undefined
> symbol error occurs. Usually it's defined in "setup.c" for each
> architecture.
>
> If an architecture does not support VGA console (ARC's case)
> there are 2 ways: define a dummy instance of screen_info or add
> a negative dependency for VGA_CONSOLE in to prevent selecting
> this option.
>
> I've implemented the second way. However the best solution is to
> add HAVE_VGA_CONSOLE option for targets which support VGA
> console. Then turn off VGA_CONSOLE by default and add dependency
> to HAVE_VGA_CONSOLE. But right now it's better to just add a
> negative dependency for ARC and then consider how to collaborate
> about this issue with maintainers of other architectures.

+1

> Signed-off-by: Yuriy Kolerov <yuriy.kolerov@synopsys.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
