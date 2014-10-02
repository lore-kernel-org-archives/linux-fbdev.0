From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 02 Oct 2014 19:15:06 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAMuHMdXDp8oE0XR6VWKw+S3C=p+3c79SoQUweZWL6UF=UyooTg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo>
 <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk> <542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
In-Reply-To: <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 2, 2014 at 2:22 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> 1) temporary early boot console -- this is nothing but an address in
> RAM and the x/y layout. The character set from framebuffer is built
> into the kernel.  The parallel to this is early-printk and how it uses
> the UARTs without interrupts. This console vaporizes late in the boot
> process -- the same thing happens with the early printk UART driver.
> EARLYPRINTK on the command line enables this.

JFYI, the early serial console can also vanish, even very early in the boot
process, before the unused clocks are disabled.
Cfr. http://marc.info/?l=linux-sh&m1227657322649&w=2

So there's no safety in this world without calling clk_prepare_enable().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
