From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Aug 2014 08:51:28 +0000
Subject: Re: EARLY_PRINTK equivalent for framebuffers.
Message-Id: <CAMuHMdWMPTg1NNpY476dwp7i-pRW1C=wNfvdsdSiUC9m5tRapg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
In-Reply-To: <CAKON4Owx5wQS29qj9Ks2CzP-Q9Kos6=6MbPRxS+4n9WkdbWegQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Jon,

On Thu, Aug 28, 2014 at 9:19 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> Is there some existing way to do early printk type output to a
> framebuffer that has been set up by the bootloader?  early printk is
> before any device drivers are loaded.

arch/m68k/kernel/head.S does this on Mac.

ISTR offb also used to do that on PPC, or perhaps it was the
old PowerMac console driver we had before that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
