From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jun 2020 21:26:58 +0000
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
Message-Id: <CAMuHMdVpT1oCg0LuQXHdoZg-nQTFfk7ZUs=qm+S2oARaPb5DTw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
 <CACvgo50HieMRRb1kK3X0XWXtNmgidYi_OWW9DGCrxT+1q14RWQ@mail.gmail.com>
In-Reply-To: <CACvgo50HieMRRb1kK3X0XWXtNmgidYi_OWW9DGCrxT+1q14RWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>

Hi Emil,

On Mon, Jun 15, 2020 at 10:38 PM Emil Velikov <emil.l.velikov@gmail.com> wrote:
> On Tue, 2 Jun 2020 at 11:37, Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> > On 5/14/20 10:21 PM, Geert Uytterhoeven wrote:
> > > These #ifdefs are relics from APUS (Amiga Power-Up System), which
> > > added a PPC board.  APUS support was killed off a long time ago,
> > > when arch/ppc/ was still king, but these #ifdefs were missed, because
> > > they didn't test for CONFIG_APUS.
> >
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
> >  1 file changed, 63 deletions(-)
> >
> A quick look through my checkout (drm-misc/next aka 5.8 ish), shows
> multiple other places which check for the define.
> And a single place where it's being set - the Makefile below.
>
> Should those be addressed as well? Or perhaps they are and I've got an old tree.

Only the above apply to APUS support.
All other below are probably legitimate.

> $ git grep -c __mc68000__
> arch/m68k/Makefile:1
> drivers/block/floppy.c:2
> drivers/ide/ide-probe.c:2
> drivers/input/misc/hp_sdc_rtc.c:1
> drivers/input/serio/hp_sdc.c:3
> drivers/input/serio/hp_sdc_mlc.c:1
> drivers/net/ethernet/i825xx/82596.c:8
> drivers/tty/vt/keyboard.c:1
> drivers/video/fbdev/amifb.c:11
> include/linux/a.out.h:1
> include/linux/hp_sdc.h:1
> include/uapi/linux/a.out.h:1
> lib/fonts/fonts.c:2
> lib/mpi/longlong.h:1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
