From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Jul 2018 08:53:29 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <CAMuHMdWvZnU_p-c98sag8t1BCaBLSqZmiH88sgD2kACbvax0pA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180721074319.GA30454@kroah.com>
 <20180721213843.wkculy5cdrrbmuij@angband.pl>
In-Reply-To: <20180721213843.wkculy5cdrrbmuij@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adam,

On Sat, Jul 21, 2018 at 11:39 PM Adam Borowski <kilobyte@angband.pl> wrote:
> Technically, every console can be made to blink by drawing/clearing affected
> characters a few times per second, but that'd be quite a waste of coding
> time and kernel size.  There's a reason browsers dropped support for <blink>
> and text-decoration:blink.

It's very simple and fast to implement in fbcon for FB_TYPE_PLANES or
FB_TYPE_INTERLEAVED_PLANES and FB_VISUAL_PSEUDOCOLOR ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
