From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2013 13:36:55 +0000
Subject: Re: [PATCH v2] video: xilinxfb: Fix compilation warning
Message-Id: <CAMuHMdX2mKANduZO9HaBHRZ13V0PztOc-uYxTymUsH8-NE5FEQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <204d93f8a9dffef6ff00d961f91be0b465f21841.1374751310.git.michal.simek@xilinx.com>
In-Reply-To: <204d93f8a9dffef6ff00d961f91be0b465f21841.1374751310.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Michal Simek <monstr@monstr.eu>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 25, 2013 at 1:21 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> regs_phys is phys_addr_t (u32 or u64).
> Lets retype it to u64.

This no longer matches the actual patch?

> Fixes compilation warning introduced by:
> video: xilinxfb: Use drvdata->regs_phys instead of physaddr
> (sha1: c88fafef0135e1e1c3e23c3e32ccbeeabc587f81)
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes in v2:
> - Use %pa instead of casting

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
