From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Aug 2019 08:28:10 +0000
Subject: Re: [PATCH] m68k: atari: Rename shifter to shifter_st to avoid conflict
Message-Id: <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190812073020.19109-1-geert@linux-m68k.org>
In-Reply-To: <20190812073020.19109-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kbuild test robot <lkp@intel.com>, Stefan Wahren <wahrenst@gmx.net>, Michael Schmitz <schmitzmic@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Aug 12, 2019 at 9:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> When test-compiling the BCM2835 pin control driver on m68k:
>
>     In file included from arch/m68k/include/asm/io_mm.h:32:0,
>                      from arch/m68k/include/asm/io.h:8,
>                      from include/linux/io.h:13,
>                      from include/linux/irq.h:20,
>                      from include/linux/gpio/driver.h:7,
>                      from drivers/pinctrl/bcm/pinctrl-bcm2835.c:17:
>     drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function 'bcm2711_pull_config_set':
>     arch/m68k/include/asm/atarihw.h:190:22: error: expected identifier or '(' before 'volatile'
>      # define shifter ((*(volatile struct SHIFTER *)SHF_BAS))
>
> "shifter" is a too generic name for a global definition.
>
> As the corresponding definition for Atari TT is already called
> "shifter_tt", fix this by renaming the definition for Atari ST to
> "shifter_st".
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Finally we can use the sh pfc pin controller on our m68k Atari.

Now if I can only resolder the capacitors on my Atari TT ST
before the board self-destructs I will one day test this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
