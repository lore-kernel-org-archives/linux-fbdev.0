From: Heiko Schocher <hs@denx.de>
Date: Tue, 26 May 2015 07:29:54 +0000
Subject: Re: [RFC PATCH] video/logo: introduce new system state for checking if logos are freed
Message-Id: <556420F2.7020909@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430896145-8887-1-git-send-email-hs@denx.de>	<5562B9CE.7050807@ti.com>	<5563EEF9.3080901@denx.de>	<556418A9.8010603@ti.com> <CAMuHMdWHP6i15Z2qZJBEW9uz7kh1_ET5N1VbOKoMw1EC7F3O0g@mail.gmail.com> <55641D89.5020103@ti.com>
In-Reply-To: <55641D89.5020103@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

Hello Tomi, Geert,

Am 26.05.2015 09:15, schrieb Tomi Valkeinen:
>
>
> On 26/05/15 10:08, Geert Uytterhoeven wrote:
>> On Tue, May 26, 2015 at 8:54 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>> On 26/05/15 06:56, Heiko Schocher wrote:
>>>>> Without locking, the initmem may be freed while fb_find_logo() is
>>>>> running.
>>
>> Or afterwards. Drivers may keep the pointer around indefinitely.
>>
>>>> Yes, you are right, that must be added ... but has such a change a
>>>> chance to go in mainline?
>>>
>>> I don't know. To be honest, this whole thing feels a bit like hackery. I
>>> think initdata should only be accessed from initcalls, never asynchronously.
>>>
>>>> BTW: Could this not be currently a problem on multicore systems?
>>>> If lets say core 2 just draws the logo, another core 1 calls
>>>> fb_logo_late_init() and later core 1 free_initmem(), while the core 2
>>>> still draws it?
>>>
>>> Yes, I think so...
>>
>> I don't think that can happen. All initcalls should complete before initmem
>> is freed.
>
> Ah, true, the question was only about the initcalls. I was answering to
> what actually can happen with the logo code as a whole.
>
> The whole problem started when I fixed an issue where the logos were
> accessed from a workqueue. I don't remember the details, but I think drm
> always (?) sets up some console stuff via workthread. In that case we
> could have the workthread accessing the logos, while initmem is being freed.
>
>>> So, maybe it would be better to not even try to go forward with the
>>> current approach. Two approaches come to my mind:
>>>
>>> 1) Keep the logos in the memory, and don't even try to free them. I
>>> don't know many bytes they are in total, though.
>>
>> m68k/allmodconfig:
>>
>> $ size drivers/video/logo/logo*o
>>     text   data    bss    dec    hex filename
>>       24   6961      0   6985   1b49 drivers/video/logo/logo_linux_clut224.o
>>       24    800      0    824    338 drivers/video/logo/logo_linux_mono.o
>>       24   3200      0   3224    c98 drivers/video/logo/logo_linux_vga16.o
>>       24   6955      0   6979   1b43 drivers/video/logo/logo_mac_clut224.o
>>      161      4      2    167     a7 drivers/video/logo/logo.o
>>
>> Not that bad... Custom logos may be larger, though.
>
> I wonder how much a simple RLE would cut down the sizes...
>
>>> 2) Make a copy of the logos to a kmalloced area at some early boot
>>> stage. Then manually free the logos at some point (after the first
>>> access to the logos? after a certain time (urgh...)?).
>>
>> 3) Draw the logos from an initcall on all frame buffers that exist at that
>>     point in time. Yes, this will destroy (part of) the content that's
>>     currently shown.
>
> Isn't that almost the same as now? The problem is that the fb probes are
> deferred to a very late stage, so we would not have the fbs when the
> suggested initcall would be called.

Yes, exactly, this is my problem. DRM gets probed early and returns with
EPROBE_DEFER, as the display needs a spi init sequence, but spi is not
running yet ... later, when spi is up, DRM probes again, and all is
fine, but the logo is not drawn, as fb_logo_late_init() is called before,
which prevents drawing the logo.

We maybe could call fb_logo_late_init() directly from init/main.c
before calling free_initmem() ? But here again the question, could
it be possible that another core just draws the logo?
Or does async_synchronize_full() helps us here?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
