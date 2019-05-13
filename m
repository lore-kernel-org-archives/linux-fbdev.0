From: "Alastair D'Silva" <alastair@d-silva.org>
Date: Mon, 13 May 2019 07:35:47 +0000
Subject: RE: [PATCH v2 3/7] lib/hexdump.c: Optionally suppress lines of repeated bytes
Message-Id: <04de01d5095e$7f6af730$7e40e590$@d-silva.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190508070148.23130-1-alastair@au1.ibm.com> <20190508070148.23130-4-alastair@au1.ibm.com> <CAMuHMdVefYTgHzGKBc0ebku1z8V3wsM0ydN+6-S2nFKaB8eH_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVefYTgHzGKBc0ebku1z8V3wsM0ydN+6-S2nFKaB8eH_Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Geert Uytterhoeven' <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, 'Alastair D'Silva' <alastair-8fk3Idey6ehBDgjK7y7TUQ@public.gmane.org>
Cc: 'Jani Nikula' <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, 'Joonas Lahtinen' <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, 'Rodrigo Vivi' <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, 'David Airlie' <airlied-cv59FeDIM0c@public.gmane.org>, 'Daniel Vetter' <daniel-/w4YWyX8dFk@public.gmane.org>, 'Dan Carpenter' <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, 'Karsten Keil' <isdn-iHCpqvpFUx0uJkBD2foKsQ@public.gmane.org>, 'Jassi Brar' <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Tom Lendacky' <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, "'David S. Miller'" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, 'Jose Abreu' <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, 'Kalle Valo' <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, 'Stanislaw Gruszka' <sgruszka-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, 'Benson Leung' <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, 'Enric Balletbo i Serra' <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, "'James E.J. Bottomley'" <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "'Martin K. Petersen'" <martin.petersen-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

> -----Original Message-----
> From: Geert Uytterhoeven <geert@linux-m68k.org>
> Sent: Monday, 13 May 2019 5:01 PM
> To: Alastair D'Silva <alastair@au1.ibm.com>
> Cc: alastair@d-silva.org; Jani Nikula <jani.nikula@linux.intel.com>; Joonas
> Lahtinen <joonas.lahtinen@linux.intel.com>; Rodrigo Vivi
> <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>; Daniel Vetter
> <daniel@ffwll.ch>; Dan Carpenter <dan.carpenter@oracle.com>; Karsten
> Keil <isdn@linux-pingi.de>; Jassi Brar <jassisinghbrar@gmail.com>; Tom
> Lendacky <thomas.lendacky@amd.com>; David S. Miller
> <davem@davemloft.net>; Jose Abreu <Jose.Abreu@synopsys.com>; Kalle
> Valo <kvalo@codeaurora.org>; Stanislaw Gruszka <sgruszka@redhat.com>;
> Benson Leung <bleung@chromium.org>; Enric Balletbo i Serra
> <enric.balletbo@collabora.com>; James E.J. Bottomley
> <jejb@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>;
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Alexander Viro
> <viro@zeniv.linux.org.uk>; Petr Mladek <pmladek@suse.com>; Sergey
> Senozhatsky <sergey.senozhatsky@gmail.com>; Steven Rostedt
> <rostedt@goodmis.org>; David Laight <David.Laight@aculab.com>; Andrew
> Morton <akpm@linux-foundation.org>; Intel Graphics Development <intel-
> gfx@lists.freedesktop.org>; DRI Development <dri-
> devel@lists.freedesktop.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; netdev <netdev@vger.kernel.org>;
> ath10k@lists.infradead.org; linux-wireless <linux-wireless@vger.kernel.org>;
> scsi <linux-scsi@vger.kernel.org>; Linux Fbdev development list <linux-
> fbdev@vger.kernel.org>; driverdevel <devel@driverdev.osuosl.org>; Linux
> FS Devel <linux-fsdevel@vger.kernel.org>
> Subject: Re: [PATCH v2 3/7] lib/hexdump.c: Optionally suppress lines of
> repeated bytes
> 
> Hi Alastair,
> 
> Thanks for your patch!

And thanks for your politeness :)

> 
> On Wed, May 8, 2019 at 9:04 AM Alastair D'Silva <alastair@au1.ibm.com>
> wrote:
> > From: Alastair D'Silva <alastair@d-silva.org>
> >
> > Some buffers may only be partially filled with useful data, while the
> > rest is padded (typically with 0x00 or 0xff).
> >
> > This patch introduces a flag to allow the supression of lines of
> > repeated bytes,
> 
> Given print_hex_dump() operates on entities of groupsize (1, 2, 4, or 8)
> bytes, wouldn't it make more sense to consider repeated groups instead of
> repeated bytes?

Maybe, it would mean that subsequent addresses may not be a multiple of rowsize though, which is useful.

> > which are replaced with '** Skipped %u bytes of value 0x%x **'
> 
> Using a custom message instead of just "*", like "hexdump" uses, will require
> preprocessing the output when recovering the original binary data by
> feeding it to e.g. "xxd".
> This may sound worse than it is, though, as I never got "xxd" to work without
> preprocessing anyway ;-)

I think showing the details of the skipped values is useful when reading the output directly. In situations where binary extracts are desired, the feature can always be disabled.

-- 
Alastair D'Silva           mob: 0423 762 819
skype: alastair_dsilva     msn: alastair@d-silva.org
blog: http://alastair.d-silva.org    Twitter: @EvilDeece
