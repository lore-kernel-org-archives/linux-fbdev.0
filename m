From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 Feb 2019 07:39:37 +0000
Subject: Re: [RFC] video/macfb: Wire up inverse option
Message-Id: <CAMuHMdXg6HcHf2WXu3NnTh1OOR_gOtcKAghWOjbtZ_OJFL64Gg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdWVERvgpC0uTSg9A70b3k6p=zD5BQY=Est6Tb-18x3EGA@mail.gmail.com>
In-Reply-To: <CAMuHMdWVERvgpC0uTSg9A70b3k6p=zD5BQY=Est6Tb-18x3EGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Finn,

On Mon, Feb 18, 2019 at 12:18 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Wed, 13 Feb 2019, Geert Uytterhoeven wrote:
> > On Wed, Feb 13, 2019 at 1:14 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On Tue, 12 Feb 2019, Geert Uytterhoeven wrote:
> > > > On Tue, Feb 12, 2019 at 6:31 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > > > There's an 'inverse' option in amifb, atafb, imstt, macfb,
> > > > > matroxfb, pvr2fb and vesafb. However, it's dead code in atafb,
> > > > > macfb, matroxfb and vesafb. The others use fb_invert_cmaps() but
> > > > > this has no effect on the framebuffer console. Does anyone know
> > > > > what this option is/was used for?
> > > >
> > > > To invert the console? ;-)
> > > >
> > > > Calling fb_invert_cmaps() inverts the default colormaps, and is thus
> > > > intended to have an effect on the frame buffer console.
> > >
> > > Calling fb_invert_cmaps() would affect all (new?) frame buffer
> > > consoles, right? If so, passing the same option to N drivers would
> > > defeat that setting, for even values of N. The effect of those
> > > settings would seem to depend on the driver probe order.
> >
> > True. This option dates back to the days only a single frame buffer
> > device could exist on the system.
>
> Makes sense. Many Linux systems still only support a single frame buffer.
>
> > > Anything we might do to fix this in matroxfb or vesafb has the potential
> > > to mess up someone's multi-driver setup. Is that why "inverse" is a no-op
> > > there?
> >
> > No idea.
> >
> > > > If this no longer works (due to some refactoring during the past +20
> > > > years?), that's a bug.
> > > >
> > >
> > > Calling fb_invert_cmaps() doesn't seem to have any effect on aranym, qemu
> > > nor (I'm told) centris 650. Maybe the default cmap is never actually sent
> > > to the driver?
> >
> > Probably. Needs more investigation.
>
> I did some more investigation. When I tested macfb in qemu, I found that
> dafb_setpalette() is actually being called.
>
> And with this patch to add the missing call to fb_invert_cmaps(), the
> dafb_setpalette() parameters change accordingly. So I'll submit this patch
> again with signed-off-by.
>
> (The problem remains that dafb_setpalette() doesn't seem to have the
> desired effect on the hardware, but that's a separate issue.)

Could it be the hardware CLUT pointer is out of sync?
Given lastreg is initialized to -1, if the first write is to regno 0,
the code will
assume the CLUT pointer is pointing to the right register.

Initializing lastreg to e.g. -2 would fix that.

> > Or just remove the feature. Apparently no one used it during the last
> > +20 years, as no one complained.
>
> On some powerbooks with greyscale LCD panels, the the black background is
> actually white, due to the backlight, and the white text is opaque black.
> This may or may not be optimal, depending on conditions etc. so I prefer
> not to remove macfb's 'inverse' option.

You can always use a higher layer to configure that, e.g.
"setterm --inversescreen on".  Won't help for the initial kernel log, though.

Originally (before git history), the inverse parameter also affected
display.inverse.  While this field still exists (see fbcon.h), there is no code
left that uses it.

The last user was removed in full-history-linux commit 25e5e3c795bcf408
("[PATCH] fbdev: support for bold attribute for monochrome framebuffers").

Probably reviving that, and getting rid of the fb_invert_cmaps() calls, is the
best solution, as display.inverse does not affect other frame buffers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
