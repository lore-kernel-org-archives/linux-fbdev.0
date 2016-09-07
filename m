From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 Sep 2016 11:12:20 +0000
Subject: Re: [PATCH] simplefb: Disable and release clocks and regulators in destroy callback
Message-Id: <CAMuHMdU3dgPzvHkd8qti1pwzf1aeUhyv7gdpufYkqxHPS4=VTw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160907090919.27187-1-wens@csie.org>
In-Reply-To: <20160907090919.27187-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Sep 7, 2016 at 11:09 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> simplefb gets unregister when a proper framebuffer driver comes in and
> kicks it out. However the claimed clocks and regulators stay enabled
> as they are only released in the platform device remove function, which
> in theory would never get called.
>
> Move the clock/regulator cleanup into the framebuffer destroy callback,
> which gets called as part of the framebuffer unregister process.

Is this called before or after the new proper framebuffer driver kicks in?
If before, it may cause glitches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
