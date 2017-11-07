From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Nov 2017 08:16:19 +0000
Subject: Re: [PATCH] documentation: update list of available compiled-in fonts
Message-Id: <CAMuHMdVZ1b1efNu-aB27MF+yNyaH1stC00CRnHcC+57ZfLO+kw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <bf177e2d-d5a6-5889-e6b1-1c7a53e177ee@infradead.org>
In-Reply-To: <bf177e2d-d5a6-5889-e6b1-1c7a53e177ee@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

Hi Randy,

On Tue, Nov 7, 2017 at 5:48 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Update list of available compiled-in fonts in lib/fonts/:
> add 6x10 and drop RomanLarge (which was reverted 12 years ago).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- lnx-414-rc8.orig/Documentation/fb/fbcon.txt
> +++ lnx-414-rc8/Documentation/fb/fbcon.txt
> @@ -77,8 +77,8 @@ C. Boot options
>  1. fbcon=font:<name>
>
>          Select the initial font to use. The value 'name' can be any of the
> -        compiled-in fonts: VGA8x16, 7x14, 10x18, VGA8x8, MINI4x6, RomanLarge,
> -        SUN8x16, SUN12x22, ProFont6x11, Acorn8x8, PEARL8x8.
> +        compiled-in fonts: VGA8x16, 7x14, 10x18, VGA8x8, MINI4x6,
> +        SUN8x16, SUN12x22, 6x10, ProFont6x11, Acorn8x8, PEARL8x8.

While at it, perhaps you want to sort the list alphabetically?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
