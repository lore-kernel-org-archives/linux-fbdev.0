From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 31 Mar 2016 08:33:47 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi: remove driver
Message-Id: <CAMuHMdWpEwHQYvd3rgOxquXG4HEdNfaDTfjBwL1X4RF9CRTsvA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459386550-4660-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1459386550-4660-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Mar 31, 2016 at 3:09 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Remove the sh_mipi_dsi driver as it appears to be unused since
> 9a9863987bf7 ("ARM: shmobile: Remove legacy SoC code for SH-Mobile AG5").

I believe that should be much older commit c0bb9b3027690e10cf8f ("ARCH: ARM:
shmobile: Remove ag5evm board support").
SH-Mobile AG5 only defined its MSTP clock, not the platform device.

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
