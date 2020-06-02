From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Jun 2020 11:04:33 +0000
Subject: Re: [PATCH 1/2] video: fbdev: amifb: remove dead APUS support
Message-Id: <CAMuHMdXUD4PNndjtxz84pYMdXaM68g7vWiRd+Gf18a35T-oA=Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <839133dd-8ed4-5fec-c311-ce9f8abf3d5f@samsung.com>
 <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
In-Reply-To: <72e0871c-d4bb-4887-4d6f-a60fd905bec1@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>

Hi Adrian,

On Tue, Jun 2, 2020 at 12:41 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 6/2/20 12:37 PM, Bartlomiej Zolnierkiewicz wrote:
> >> These #ifdefs are relics from APUS (Amiga Power-Up System), which
> >> added a PPC board.  APUS support was killed off a long time ago,
> >> when arch/ppc/ was still king, but these #ifdefs were missed, because
> >> they didn't test for CONFIG_APUS.
> >
> > Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/video/fbdev/amifb.c |   63 --------------------------------------------
> >  1 file changed, 63 deletions(-)
>
> What do you mean with the sentence "when arch/ppc/ was still king"?

Ah, Bartl copied that from my email ;-)

There used to be APUS support under arch/ppc/.
Later, 32-bit arch/ppc/ and 64-bit arch/ppc64/ were merged in a new\
architecture port under arch/powerpc/, and the old ones were dropped.
APUS was never converted, and thus dropped.

> Does that mean - in the case we would re-add APUS support in the future, that
> these particular changes would not be necessary?

They would still be necessary, as PowerPC doesn't grok m68k instructions.
Alternatively, we could just drop the m68k inline asm, and retain the C
version instead?  I have no idea how big of a difference that would make
on m68k, using a more modern compiler than when the code was written
originally.

Note that all of this is used only for cursor handling, which I doubt is
actually used by any user space application. The only exception is the
DIVUL() macro, which is used once during initialization, thus also not
performance critical.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
