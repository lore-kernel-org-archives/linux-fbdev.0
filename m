From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Fri, 03 Dec 2010 12:10:23 +0000
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Message-Id: <AANLkTim3573_MUZNpo2+tKa=ZJgQf26x5of_ZkMM6BR8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
	<20101202215837.GW17222@atomide.com>
	<20101202221612.GJ10461@n2100.arm.linux.org.uk>
	<20101202223208.GA17222@atomide.com>
	<20101203030954.GD3367@linux-sh.org>
	<20101203084102.GA30957@n2100.arm.linux.org.uk>
In-Reply-To: <20101203084102.GA30957@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 3, 2010 at 10:41 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 03, 2010 at 12:09:55PM +0900, Paul Mundt wrote:
>> This has been fixed since -rc2.
>
> So it is.  However, the ioremap fix is wrong.
>
>        } else {
>                paddr = memblock_alloc(size, PAGE_SIZE);
>        }
>
>        memblock_free(paddr, size);
>        memblock_remove(paddr, size);
>
> Didn't I say that such blocks were supposed to be aligned to a 2MB
> boundary - and the size also so aligned?

I asked you if there was something special and I didn't receive any response:
http://article.gmane.org/gmane.linux.kernel/1048434

So, why SZ_2M?

-- 
Felipe Contreras
