From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 26 Jul 2018 14:34:53 +0000
Subject: Re: [BUG] video: fbdev: broadsheetfb: Possible null function pointers
Message-Id: <2568790.PcaMMF1rzM@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc@epcas1p2.samsung.com>
        <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
In-Reply-To: <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bai <baijiaju1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 10:17:44 PM bai wrote:
> In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,
> 
> 158. static void broadsheet_mmio_send_cmdargs(...) {
>              ......
> 163.     par->board->mmio_write(...);
>              ......
> 166.     par->board->mmio_write(...);
> 167. }
> 
> For x86 kernel configuration, I find that there is no assignment of the 
> function pointer ".mmio_write" in the kernel code.
> So calling the function pointer in lines 163 and 166 may cause a null 
> pointer dereference.
> 
> In this file, there are many calls to this function pointer...

This is a platform driver and it won't be used on x86 (actually it is
used only by single ARM PXA board). The dependency for FB_BROADSHEET
in Kconfig file could be improved to i.e.

	depends on FB && (ARCH_PXA || COMPILE_TEST)

but there is no bug there.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

