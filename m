From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jul 2013 10:09:39 +0000
Subject: Re: [PATCH] video: xilinxfb: Fix compilation warning
Message-Id: <CAMuHMdXnkN39A1z-Ejd247KHs-=kVBcBX0rbSp=gtye=E-Wzow@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <ed64cda456be840147ae1f04bec6a99733f41c24.1374643896.git.michal.simek@xilinx.com>
	<007401ce8833$22ce0600$686a1200$@samsung.com>
	<51EF7FBD.8070103@monstr.eu>
	<51EF8530.90809@monstr.eu>
	<003a01ce8845$06df46e0$149dd4a0$@samsung.com>
	<51EF8F27.3030003@monstr.eu>
In-Reply-To: <51EF8F27.3030003@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: Jingoo Han <jg1.han@samsung.com>, Michal Simek <michal.simek@xilinx.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stepan Moskovchenko <stepanm@codeaurora.org>

On Wed, Jul 24, 2013 at 10:24 AM, Michal Simek <monstr@monstr.eu> wrote:
>> Just now, I tested that the same problem happens on ARM config.
>> Also, I solved it by adding '&' operator.
>>
>> '&' operator is necessary as below:
>>
>>         dev_dbg(dev, "regs: phys=%pa, virt=%p\n",
>>                  &drvdata->regs_phys, drvdata->regs);
>>                 ^^^
>>
>>         dev_dbg(dev, "fb: phys=%pa, virt=%p, size=%x\n",
>>                 &drvdata->fb_phys, drvdata->fb_virt, fbsize);
>>                ^^^
>
> ok.
>
> The truth is as I said there are just 5 files in the whole kernel
> which are using %pa and if %pa is right way to go we should
> probably fix all off them.

"%pa" is a quite recent addition (v3.9).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
