From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:25:12 +0000
Subject: Re: [PATCH] video/macfb: Remove redundant code
Message-Id: <CAMuHMdUN1SGHd-BbEWY9xwc5jkybLQ_xbLaE0-jzskorso6brw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
In-Reply-To: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Feb 15, 2019 at 3:19 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> The value of info->var.bits_per_pixel get checked in macfb_setcolreg().
> Remove additional checks as they are redundant.
>
> macfb_defined.activate gets initialized to FB_ACTIVATE_NOW by the struct
> initializer. Remove redundant assignments.
>
> macfb_defined.bits_per_pixel, .width and .height all get assigned
> unconditionally. Remove redundant initializers.
>
> Cc: linux-m68k@lists.linux-m68k.org
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
