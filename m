From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Apr 2015 13:46:56 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <CAMuHMdV+-VcZD5TMswUjwW0fk=-76oYimeKJ_P9QC5Md4De-JA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd>
	<CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
	<20150409110634.GA27407@amd>
	<552660C7.4020805@ti.com>
	<552663C2.70308@ti.com>
	<55277650.8070607@codeaurora.org>
	<20150424132923.GA11729@amd>
	<553A47D3.2070107@ti.com>
In-Reply-To: <553A47D3.2070107@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, Archit Taneja <architt@codeaurora.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@arm.linux.org.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>

On Fri, Apr 24, 2015 at 3:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 24/04/15 16:29, Pavel Machek wrote:
>> On Fri 2015-04-10 12:35:52, Archit Taneja wrote:
>>>> That said, if the fb is in RAM, and is only written by the CPU, I think
>>>> a normal memcpy() for fb_memcpy_fromfb() should be fine...
>>>
>>> I didn't test for performance regressions when I posted this patch.
>>>
>>> A look at _memcpy_fromio in arch/arm/kernel/io.c shows that readb() is used
>>> all the time, even when the source and destination addresses are aligned for
>>> larger reads to be possible. Other archs seem to use readl() or readq() when
>>> they can. Maybe that makes memcpy_fromio slower than the implementation of
>>> memcpy on arm?
>>
>> Ok, can you prepare a patch for me to try? Or should we just revert
>> the original commit?
>
> The old way worked fine, afaik, so maybe we can revert. But still, isn't
> it more correct to use memcpy_fromio? It's (possibly) io memory we have
> here.

Yes it is.

So please optimize ARM's _memcpy_fromio(), _memcpy_toio(), and _memset_io().
That will benefit other drivers on ARM, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
