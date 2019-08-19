From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Aug 2019 11:27:41 +0000
Subject: Re: [PATCH] m68k: atari: Rename shifter to shifter_st to avoid conflict
Message-Id: <CAMuHMdVv=i5nffbN2vZjvHfeV_w74PvZD7ZLuf623H9pnyK14A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190812073020.19109-1-geert@linux-m68k.org> <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
In-Reply-To: <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kbuild test robot <lkp@intel.com>, Stefan Wahren <wahrenst@gmx.net>, Michael Schmitz <schmitzmic@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 14, 2019 at 10:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 12, 2019 at 9:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > When test-compiling the BCM2835 pin control driver on m68k:
> >
> >     In file included from arch/m68k/include/asm/io_mm.h:32:0,
> >                      from arch/m68k/include/asm/io.h:8,
> >                      from include/linux/io.h:13,
> >                      from include/linux/irq.h:20,
> >                      from include/linux/gpio/driver.h:7,
> >                      from drivers/pinctrl/bcm/pinctrl-bcm2835.c:17:
> >     drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function 'bcm2711_pull_config_set':
> >     arch/m68k/include/asm/atarihw.h:190:22: error: expected identifier or '(' before 'volatile'
> >      # define shifter ((*(volatile struct SHIFTER *)SHF_BAS))
> >
> > "shifter" is a too generic name for a global definition.
> >
> > As the corresponding definition for Atari TT is already called
> > "shifter_tt", fix this by renaming the definition for Atari ST to
> > "shifter_st".
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Finally we can use the sh pfc pin controller on our m68k Atari.
>
> Now if I can only resolder the capacitors on my Atari TT ST
> before the board self-destructs I will one day test this.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied and queued for v5.4.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
