From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Tue, 14 May 2013 16:33:18 +0000
Subject: Re: Build regressions/improvements in v3.10-rc1 (cris)
Message-Id: <20130514163318.GQ8853@axis.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.00.1305122130270.3789@ayla.of.borg>
 <alpine.DEB.2.00.1305122239040.5463@ayla.of.borg>
 <alpine.DEB.2.00.1305122242430.5463@ayla.of.borg>
 <CAMuHMdW6p6tP=wwBNV9uAAbwwgpyzMiPxsBSJNOUazhznYC4iQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW6p6tP=wwBNV9uAAbwwgpyzMiPxsBSJNOUazhznYC4iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-cris-kernel <linux-cris-kernel@axis.com>

On Tue, May 14, 2013 at 02:06:51PM +0200, Geert Uytterhoeven wrote:
> On Sun, May 12, 2013 at 10:44 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > drivers/video/console/fonts.c:71:2: error: #error No fonts configured.: 2 errors in 2 logs
> >         v3.10-rc1/cris/cris-allmodconfig v3.10-rc1/cris/cris-allyesconfig
> >
> >         Fbdev issue?
> 
> This is caused by cris not using the generic drivers/Kconfig, and thus not
> traversing drivers/video/console/Kconfig.
> As the build system does traverse drivers/video/console/Makefile, fonts.c
> is compiled with an inconsistent configuration.
> 
> Two solutions:
>   1. Add drivers/video/console/Kconfig to arch/cris/Kconfig,
>   2. Switch cris to drivers/Kconfig,
> 
> I prefer two, as this is what's done by all (except h8300) other
> architectures. This will seriously broaden the scope of allmodconfig,
> though, and require more fixes (e.g. missing <asm/vga.h>).

I would have no objections a conversion of CRIS to use the
drivers/Kconfig, though it feels a bit strange to compile
video drivers for SoCs that don't have any video out hardware.

> Note: The decision logic for compiling drivers/video/console/fonts.c is
>       overly complicated, and seems to be buggy for some stuff living
>       outside drivers drivers/video (drivers/media/platform/vivi.c and
>       drivers/staging/media/solo6x10/solo6x10-enc.c). I think this should
>       be resolved in Kconfig logic, using a new FONT_SUPPORT
>       symbol (FONTS is already taken).
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
