From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Feb 2019 07:50:05 +0000
Subject: Re: [RFC] video/macfb: Wire up inverse option
Message-Id: <CAMuHMdWVERvgpC0uTSg9A70b3k6p=zD5BQY=Est6Tb-18x3EGA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Finn,

CC linux-fbdev

On Wed, Feb 13, 2019 at 1:14 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 12 Feb 2019, Geert Uytterhoeven wrote:
> > On Tue, Feb 12, 2019 at 6:31 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > There's an 'inverse' option in amifb, atafb, imstt, macfb, matroxfb,
> > > pvr2fb and vesafb. However, it's dead code in atafb, macfb, matroxfb
> > > and vesafb. The others use fb_invert_cmaps() but this has no effect on
> > > the framebuffer console. Does anyone know what this option is/was used
> > > for?
> >
> > To invert the console? ;-)
> >
> > Calling fb_invert_cmaps() inverts the default colormaps, and is thus
> > intended to have an effect on the frame buffer console.
>
> Calling fb_invert_cmaps() would affect all (new?) frame buffer consoles,
> right? If so, passing the same option to N drivers would defeat that
> setting, for even values of N. The effect of those settings would seem to
> depend on the driver probe order.

True. This option dates back to the days only a single frame buffer device
could exist on the system.

> Anything we might do to fix this in matroxfb or vesafb has the potential
> to mess up someone's multi-driver setup. Is that why "inverse" is a no-op
> there?

No idea.

> > If this no longer works (due to some refactoring during the past +20
> > years?), that's a bug.
> >
>
> Calling fb_invert_cmaps() doesn't seem to have any effect on aranym, qemu
> nor (I'm told) centris 650. Maybe the default cmap is never actually sent
> to the driver?

Probably. Needs more investigation.
Or just remove the feature. Apparently no one used it during the last +20
years, as no one complained.

(Start of thread at https://www.spinics.net/lists/linux-m68k/msg13292.html)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
