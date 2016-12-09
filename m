From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Dec 2016 12:33:32 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CAMuHMdUE9npco8hKcA160+rSFcCXpf7cXh+CX4Q207aA5FrT2g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1481158879.26959.41.camel@kernel.crashing.org>
 <20161208101005.6ufl3d4qvwprosju@phenom.ffwll.local>
 <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <1481283856.27965.11.camel@kernel.crashing.org>
In-Reply-To: <1481283856.27965.11.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

Hi Ben,

On Fri, Dec 9, 2016 at 12:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> So it is possible, only reason vram dumb buffers look worse is that there's
>> only 3 and no one cares about them, vs about 20 and a very active community
>> of contributors (also for core drm improvements) for the other case.
>
> Well, we could move offb to drm while at it I suppose that would be another
> one (offb is the "dumb driver based on pre-programmed output by firmware).

That would indeed be a great example.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
