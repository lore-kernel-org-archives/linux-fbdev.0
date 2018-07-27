From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Fri, 27 Jul 2018 01:49:41 +0000
Subject: Re: [BUG] video: fbdev: broadsheetfb: Possible null function pointers
Message-Id: <c95d4381-1278-e561-29d8-ae84be2c680e@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc@epcas1p2.samsung.com>
 <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
 <2568790.PcaMMF1rzM@amdc3058>
In-Reply-To: <2568790.PcaMMF1rzM@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org



On 2018/7/26 22:34, Bartlomiej Zolnierkiewicz wrote:
> On Thursday, July 26, 2018 10:17:44 PM bai wrote:
>> In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,
>>
>> 158. static void broadsheet_mmio_send_cmdargs(...) {
>>               ......
>> 163.     par->board->mmio_write(...);
>>               ......
>> 166.     par->board->mmio_write(...);
>> 167. }
>>
>> For x86 kernel configuration, I find that there is no assignment of the
>> function pointer ".mmio_write" in the kernel code.
>> So calling the function pointer in lines 163 and 166 may cause a null
>> pointer dereference.
>>
>> In this file, there are many calls to this function pointer...
> This is a platform driver and it won't be used on x86 (actually it is
> used only by single ARM PXA board). The dependency for FB_BROADSHEET
> in Kconfig file could be improved to i.e.
>
> 	depends on FB && (ARCH_PXA || COMPILE_TEST)
>
> but there is no bug there.

Thanks for the reply :)
So I want to submit a patch of updating Kconfig in 
drivers/video/fbdev/Kconfig:

config FB_BROADSHEET
     tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
-    depends on FB
+   depends on FB && (ARCH_PXA || COMPILE_TEST)
     select FB_SYS_FILLRECT
     select FB_SYS_COPYAREA
     select FB_SYS_IMAGEBLIT
     select FB_SYS_FOPS
     select FB_DEFERRED_IO


Do you think it is okay?


Best wishes,
Jia-Ju Bai
