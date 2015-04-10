From: Archit Taneja <architt@codeaurora.org>
Date: Fri, 10 Apr 2015 07:17:52 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <55277650.8070607@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd> <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com> <20150409110634.GA27407@amd> <552660C7.4020805@ti.com> <552663C2.70308@ti.com>
In-Reply-To: <552663C2.70308@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com



On 04/09/2015 05:04 PM, Tomi Valkeinen wrote:
> On 09/04/15 14:21, Tomi Valkeinen wrote:
>> On 09/04/15 14:06, Pavel Machek wrote:
>>> On Tue 2015-04-07 14:19:33, Geert Uytterhoeven wrote:
>>>> Hi Pavel,
>>>>
>>>> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>>>> I have an socfpga board, which uses has simple framebuffer implemented
>>>>> in the FPGA. On 3.15, framebuffer is fast:
>>>>>
>>>>> root@wagabuibui:~# time cat /dev/fb0 > /dev/null
>>>>> real               0m 0.00s
>>>>> user               0m 0.00s
>>>>> sys                0m 0.00s
>>>>>
>>>>> on 3.18, this takes 220msec. Similar slowdown exists for
>>>>> writes. Simple framebuffer did not change at all between 3.15 and
>>>>> 3.18; resource flags of the framebuffer are still same (0x200).
>>>>>
>>>>> If I enable caching on 3.18, it speeds up a bit, to 70msec or
>>>>> so... Which means problem is not only in caching.
>>>>>
>>>>> Any ideas?
>>>>
>>>> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buffer
>>>> copying optimisations"), but this was introduced only in v4.0-rc1.
>>>>
>>>> Just in case you encounter another performance regression after upgrading
>>>> to a more modern kernel ;-)
>>>
>>> :-). I did a git bisect, and it pointed to this. And reverting it
>>> indeed fixes the problem in 3.18. Problem is still there in 4.0.
>
> The difference is probably caused by memcpy() vs memcpy_fromio(). The
> comment above memcpy_fromio() says "This needs to be optimized". I think
> generally speaking memcpy_fromio() is correct for a framebuffer.
>
> That said, if the fb is in RAM, and is only written by the CPU, I think
> a normal memcpy() for fb_memcpy_fromfb() should be fine...

I didn't test for performance regressions when I posted this patch.

A look at _memcpy_fromio in arch/arm/kernel/io.c shows that readb() is 
used all the time, even when the source and destination addresses are 
aligned for larger reads to be possible. Other archs seem to use readl() 
or readq() when they can. Maybe that makes memcpy_fromio slower than the 
implementation of memcpy on arm?

Thanks,
Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
