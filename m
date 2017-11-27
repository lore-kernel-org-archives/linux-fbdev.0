From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Nov 2017 18:56:12 +0000
Subject: Re: omapfb/dss: Delete an error message for a failed memory allocation in three functions
Message-Id: <CAMuHMdWqrTw80_t8Jr_ejzcLevXdxr-gnYgOQhk1-Mhn+v=A=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
 <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
 <502de06b-ca86-d0ff-bd50-d260fbe46fe5@users.sourceforge.net>
 <20171127174454.GA18851@lenoch>
 <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
In-Reply-To: <5e90409f-fcb0-cdb6-9bc3-26ad30a1f7c9@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Ladislav Michl <ladis@linux-mips.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Markus,

On Mon, Nov 27, 2017 at 7:12 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
>>> Can a default allocation failure report provide the information
>>> which you might expect so far?
>>
>> You should be able to answer that question yourself.
>
> I can not answer this detail completely myself because my knowledge
> is incomplete about your concrete expectations for the exception handling
> which can lead to different views for the need of additional error messages.

It may be a good idea to try to trigger an out-of-memory condition yourself,
and see what happens?

>> And if you are unable to do so, just do not sent changes pointed
>> by any code analysis tools.
>
> They can point aspects out for further software development considerations,
> can't they?

Sure. But I think it is a good experience to witness what can happen if you
"violate" these "coding standards written by other people", and learn to
understand why they were written, increasing your own knowledge.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
