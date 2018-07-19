From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Jul 2018 14:34:28 +0000
Subject: Re: [PATCH 0/6] vt: no blinking on console, 256/24-bit color improvements
Message-Id: <CAMuHMdXGY9YMwXiEm=Jn=rv6WW0V9P0k7DFZ-5BE4Smu7YzMgg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl> <20180719114749.00a7f979@alans-desktop>
 <20180719142844.u3u4p7tywb54y4yd@angband.pl>
In-Reply-To: <20180719142844.u3u4p7tywb54y4yd@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adam Borowski <kilobyte@angband.pl>
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adam,

On Thu, Jul 19, 2018 at 4:29 PM Adam Borowski <kilobyte@angband.pl> wrote:
> And vgacon has code that looks like it can do CGA and MDA (redundant with
> mdacon?), either of which I haven't used in... quite a while.  Might be
> tricky getting access to such hardware to test...

Mdacon is meant to be used next to vgacon, for systems with both color and
monochrome graphics adapters.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
