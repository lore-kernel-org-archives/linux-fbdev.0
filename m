From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Feb 2020 11:16:56 +0000
Subject: Re: [PATCH] fbdev: c2p: Use BUILD_BUG() instead of custom solution
Message-Id: <CAMuHMdX9M25O9MOQ5tb-cLs36E8qCf1M4YCbYN9BU+h1N3n0MQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200112171521.22443-1-geert@linux-m68k.org>
In-Reply-To: <20200112171521.22443-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Sun, Jan 12, 2020 at 6:15 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Replace the call to the custom non-existing function by a standard
> BUILD_BUG() invocation.
>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied and queued for v5.7.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
