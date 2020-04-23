From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 23 Apr 2020 15:25:49 +0000
Subject: Re: [PATCH v2] console: console: Complete exception handling in newport_probe()
Message-Id: <051e7dee-d64c-c54c-6bdd-6e60444c0a26@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200423142637eucas1p2ea543e281d96c75aa4292b49756f2146@eucas1p2.samsung.com>
 <20200423142627.1820-1-zhengdejin5@gmail.com>
 <081f8192-1708-80ff-6eef-885d72bdf5c5@samsung.com>
 <CAHp75Vd8kC6ub-=pwe3QtdZ=FBqka3F1bbHea6__G5_Vm_ybcQ@mail.gmail.com>
In-Reply-To: <CAHp75Vd8kC6ub-=pwe3QtdZ=FBqka3F1bbHea6__G5_Vm_ybcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, FlorianSchandinat@gmx.de, Dejin Zheng <zhengdejin5@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, dri-devel <dri-devel@lists.freedesktop.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>


On 4/23/20 5:05 PM, Andy Shevchenko wrote:
> On Thu, Apr 23, 2020 at 5:55 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
> 
>>> +     if (err)
>>> +             iounmap((void *)npregs);
>>
>> Looks OK but while you are at it, could you please also add missing
>> release_mem_region() on error and on device removal:
>>
>>         newport_addr = dev->resource.start + 0xF0000;
>>         if (!request_mem_region(newport_addr, 0x10000, "Newport"))
>>                 return -ENODEV;
>>
>>         npregs = (struct newport_regs *)/* ioremap cannot fail */
>>                 ioremap(newport_addr, sizeof(struct newport_regs));
>>         console_lock();
>>         err = do_take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
>>         console_unlock();
>>         return err;
>> }
>>
>> static void newport_remove(struct gio_device *dev)
>> {
>>         give_up_console(&newport_con);
>>         iounmap((void *)npregs);
>> }
>>
>> ?
> 
> Don't you think that proper solution is rather switch to memremap()?

Doesn't seem to be a case here (used memory region in uncached).

On MIPS (this is MIPS-only driver):

...
#define ioremap(offset, size)						\
	__ioremap_mode((offset), (size), _CACHE_UNCACHED)
#define ioremap_uc		ioremap
...

While memremap() is only for cacheable memory:

...
 * memremap() - remap an iomem_resource as cacheable memory
 * @offset: iomem resource start address
 * @size: size of remap
 * @flags: any of MEMREMAP_WB, MEMREMAP_WT, MEMREMAP_WC,
 *		  MEMREMAP_ENC, MEMREMAP_DEC
...


>>>       return err;
>>>  }
> 
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
