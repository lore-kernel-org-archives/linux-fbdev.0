From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Fri, 03 Dec 2010 13:15:07 +0000
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Message-Id: <AANLkTimfj_J-P29Eqx29PGVqmUZs65SbwKewwrqib6ZC@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
	<20101202223208.GA17222@atomide.com>
	<20101203030954.GD3367@linux-sh.org>
	<20101203084102.GA30957@n2100.arm.linux.org.uk>
	<AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
	<20101203130724.GB30957@n2100.arm.linux.org.uk>
In-Reply-To: <20101203130724.GB30957@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 3, 2010 at 3:07 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 03, 2010 at 02:10:23PM +0200, Felipe Contreras wrote:
>> On Fri, Dec 3, 2010 at 10:41 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
>> >> This has been fixed since -rc2.
>> >
>> > So it is.  However, the ioremap fix is wrong.
>> >
>> >        } else {
>> >                paddr = memblock_alloc(size, PAGE_SIZE);
>> >        }
>> >
>> >        memblock_free(paddr, size);
>> >        memblock_remove(paddr, size);
>> >
>> > Didn't I say that such blocks were supposed to be aligned to a 2MB
>> > boundary - and the size also so aligned?
>>
>> I asked you if there was something special and I didn't receive any response:
>> http://article.gmane.org/gmane.linux.kernel/1048434
>
> So you thought you could ride rough-shod over my statement and ignore it?
> Thank you for treating me like shit, I'll remember that for future and
> treat you in a similar manner.

No, you didn't make any statement, just provided code. I thought SZ_2M
might have just been an example for something that required that
alignment, thus my request for clarification.

>> So, why SZ_2M?
>
> Firstly, that's the granularity which we allocate page tables - one
> Linux page table covers 2MB of memory.  We want to avoid creating page
> tables for the main memory mapping as that increases TLB pressure through
> the use of additional TLB entries, and more page table walks.
>
> Plus, we never used to allow the kernel's direct memory mapping to be
> mapped at anything less than section size - this restriction has since
> been lifted due to OMAP SRAM problems, but I'd rather we stuck with it
> to ensure that we have proper behaviour from all parts of the system.
>
> Secondly, we don't want to end up with lots of fragmentation at the end
> of the memory mapping as that'll reduce performance, not only by making
> the pfn_valid() search more expensive.
>
> Emsuring a minimum allocation size and alignment makes sure that the
> regions can be coalesced together into one block, and minimises run-time
> expenses.
>
> So please, 2MB, or if you object, at the _very_ _least_ 1MB.  But
> definitely not PAGE_SIZE.

Fair enough. If nobody beats me to it I would send patches to fix
that, although perhaps it would make sense to write a helper function
that does exactly this.

Cheers.

-- 
Felipe Contreras
