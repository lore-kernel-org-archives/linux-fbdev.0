From: David Herrmann <dh.herrmann@googlemail.com>
Date: Tue, 14 Aug 2012 09:42:13 +0000
Subject: Re: [PATCH 03/11] fblog: new framebuffer kernel log dummy driver
Message-Id: <CANq1E4Q1YHw7HJ7bu41PPnk6MhzZ7UTjM-sXBbVuNuA5GjeE7Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344783205-2384-1-git-send-email-dh.herrmann@googlemail.com>
	<1344783205-2384-4-git-send-email-dh.herrmann@googlemail.com>
	<50283D7A.4090309@gmail.com>
In-Reply-To: <50283D7A.4090309@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ryan Mallon <rmallon@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Ryan

On Mon, Aug 13, 2012 at 1:34 AM, Ryan Mallon <rmallon@gmail.com> wrote:
> >  config VGA_CONSOLE
> >       bool "VGA text console" if EXPERT || !X86
> > -     depends on !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV &&
> > !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && (!ARM || ARCH_FOOTBRIDGE ||
> > ARCH_INTEGRATOR || ARCH_NETWINDER)
> > +     depends on VT && !4xx && !8xx && !SPARC && !M68K && !PARISC &&
> > !FRV && !SUPERH && !BLACKFIN && !AVR32 && !MN10300 && (!ARM ||
> > ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER)
> >       default y
> >       help
> >         Saying Y here will allow you to use Linux in text mode through a
> > @@ -45,7 +45,7 @@ config VGACON_SOFT_SCROLLBACK_SIZE
> >        screenfuls of scrollback buffer
>
> You could just place all of the CONFIG_VT options inside an if VT and
> then the new fblog options in the else case rather than modifying all of
> the (already overly long) depends statements.

Indeed, that sounds better.

> > +config FBLOG
> > +     tristate "Framebuffer Kernel Log Driver"
> > +     depends on !VT && FB
> > +     default n
>
> Default n is not required, all options are default n unless otherwise
> specified. I don't think you need the dependency on FB either, since
> this file should only get included if CONFIG_FB is set?

I will remove the default-line, but the FB-dependency is required. The
"console/" directory includes also drivers like vgacon which do not
depend on FB so it gets always included.

> > +     help
> > +       This driver displays all kernel log messages on all connected
> > +       framebuffers. It is mutually exclusive with
> > CONFIG_FRAMEBUFFER_CONSOLE
> > +       and CONFIG_VT. It was mainly created for debugging purposes when
> > +       CONFIG_VT is not selected but you still want kernel boot
> > messages on
> > +       the screen.
>
> Do command line options exist to specify screens to write the debug log
> to? It might be a useful feature to have.

See patch-7. However, I am not entirely happy with it. I will probably
have to rethink the parameters.

Thanks for reviewing. I will fix all these in the next series.
Regards
David
