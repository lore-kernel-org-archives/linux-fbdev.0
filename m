From: Christophe LEROY <christophe.leroy@c-s.fr>
Date: Fri, 24 Aug 2018 11:10:37 +0000
Subject: Re: [PATCH] drivers/video/fbdev: use ioremap_wc() instead of __ioremap(_PAGE_NO_CACHE)
Message-Id: <78342b34-1a47-26a5-1636-0f7f64588c73@c-s.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <0fe514f6e105a2c7f773679a14fce80216594a9b.1535103285.git.christophe.leroy@c-s.fr>
 <20180824110548.GV24439@gate.crashing.org>
In-Reply-To: <20180824110548.GV24439@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org



Le 24/08/2018 à 13:05, Segher Boessenkool a écrit :
> On Fri, Aug 24, 2018 at 10:16:22AM +0000, Christophe Leroy wrote:
>> _PAGE_NO_CACHE is a target specific flag. Prefer generic functions.
> 
>>   #ifdef CONFIG_PPC
>> -	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
>> +	p->screen_base = ioremap_wc(addr, 0x200000);
>>   #else
> 
> But that is not the same.  I think you want ioremap_nocache?
> 
> 

No, ioremap_nocache() is _PAGE_NO_CACHE | _PAGE_GUARDED



/arch/powerpc/include/asm/io.h

#define ioremap_nocache(addr, size)	ioremap((addr), (size))


/arch/powerpc/mm/pgtable_32.c:

void __iomem *
ioremap_wc(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
				__builtin_return_address(0));
}

void __iomem *
ioremap(phys_addr_t addr, unsigned long size)
{
	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
				__builtin_return_address(0));
}

Christophe
