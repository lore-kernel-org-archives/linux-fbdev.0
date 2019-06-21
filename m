From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 21 Jun 2019 11:23:33 +0000
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit
Message-Id: <cabdf0c8-8c8a-aa40-37ed-d3d11c9d3bb8@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44@epcas1p3.samsung.com>
        <20190617131624.2382303-1-arnd@arndb.de>
        <1628618a-7cf6-506e-9d87-c0966a99fbea@samsung.com>
        <CAK8P3a3qTCnJn7X1msg03Av71aZmmN8YB=WNs0JfzYoMH+uL-w@mail.gmail.com>
In-Reply-To: <CAK8P3a3qTCnJn7X1msg03Av71aZmmN8YB=WNs0JfzYoMH+uL-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: YueHaibing <yuehaibing@huawei.com>, Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


On 6/21/19 1:05 PM, Arnd Bergmann wrote:
> On Fri, Jun 21, 2019 at 12:58 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>>
>> On 6/17/19 3:16 PM, Arnd Bergmann wrote:
>>> When the driver is built-in for PCI, we reference the exit function
>>> after discarding it:
>>>
>>> `pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o
>>>
>>> Just remove the __exit annotation as the easiest workaround.
>>
>> Don't we also need to fix pvr2fb_dc_exit() for CONFIG_SH_DREAMCAST=y case?
> 
> I think that's correct, yes. Can you fix that up when applying the patch?

Sure.

I've queued the patch for v5.3, thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
