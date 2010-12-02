From: Tony Lindgren <tony@atomide.com>
Date: Thu, 02 Dec 2010 21:58:38 +0000
Subject: Re: Mainline OMAP3 breakage (and other OMAP?)
Message-Id: <20101202215837.GW17222@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101202211421.GG10461@n2100.arm.linux.org.uk>
In-Reply-To: <20101202211421.GG10461@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [101202 13:04]:
> This has been around since October:
> 
> drivers/video/omap2/vram.c: In function ■omap_vram_reserve_sdram_memblock■:
> drivers/video/omap2/vram.c:573: error: ■MEMBLOCK_REAL_LIMIT■ undeclared (first use in this function)
> drivers/video/omap2/vram.c:573: error: (Each undeclared identifier is reported only once
> drivers/video/omap2/vram.c:573: error: for each function it appears in.)
> 
> This requires a trivial one-liner compile fix:
> 
> diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
> index fed2a72..a8973f0 100644
> --- a/drivers/video/omap2/vram.c
> +++ b/drivers/video/omap2/vram.c
> @@ -570,7 +570,7 @@ void __init omap_vram_reserve_sdram_memblock(void)
>  			return;
>  		}
>  	} else {
> -		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
> +		paddr = memblock_alloc(size, PAGE_SIZE);
>  	}
>  
>  	omap_vram_add_region(paddr, size);
> 
> which restores the old behaviour before the X86 memblock changes went
> in.  Yes, there may be other changes due to the ioremap stuff, but
> that's really no excuse for not fixing the compile error itself.

Great. Adding fbdev and Tomi to Cc.

Acked-by: Tony Lindgren <tony@atomide.com>
