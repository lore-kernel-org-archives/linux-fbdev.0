From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 May 2015 07:08:28 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <CAMuHMdWHP6i15Z2qZJBEW9uz7kh1_ET5N1VbOKoMw1EC7F3O0g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>
	<5562B9CE.7050807@ti.com>
	<5563EEF9.3080901@denx.de>
	<556418A9.8010603@ti.com>
In-Reply-To: <556418A9.8010603@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: hs@denx.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Tue, May 26, 2015 at 8:54 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 26/05/15 06:56, Heiko Schocher wrote:
>>> Without locking, the initmem may be freed while fb_find_logo() is
>>> running.

Or afterwards. Drivers may keep the pointer around indefinitely.

>> Yes, you are right, that must be added ... but has such a change a
>> chance to go in mainline?
>
> I don't know. To be honest, this whole thing feels a bit like hackery. I
> think initdata should only be accessed from initcalls, never asynchronously.
>
>> BTW: Could this not be currently a problem on multicore systems?
>> If lets say core 2 just draws the logo, another core 1 calls
>> fb_logo_late_init() and later core 1 free_initmem(), while the core 2
>> still draws it?
>
> Yes, I think so...

I don't think that can happen. All initcalls should complete before initmem
is freed.

> So, maybe it would be better to not even try to go forward with the
> current approach. Two approaches come to my mind:
>
> 1) Keep the logos in the memory, and don't even try to free them. I
> don't know many bytes they are in total, though.

m68k/allmodconfig:

$ size drivers/video/logo/logo*o
   text   data    bss    dec    hex filename
     24   6961      0   6985   1b49 drivers/video/logo/logo_linux_clut224.o
     24    800      0    824    338 drivers/video/logo/logo_linux_mono.o
     24   3200      0   3224    c98 drivers/video/logo/logo_linux_vga16.o
     24   6955      0   6979   1b43 drivers/video/logo/logo_mac_clut224.o
    161      4      2    167     a7 drivers/video/logo/logo.o

Not that bad... Custom logos may be larger, though.

> 2) Make a copy of the logos to a kmalloced area at some early boot
> stage. Then manually free the logos at some point (after the first
> access to the logos? after a certain time (urgh...)?).

3) Draw the logos from an initcall on all frame buffers that exist at that
   point in time. Yes, this will destroy (part of) the content that's
   currently shown.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
