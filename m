From: Tony Lindgren <tony@atomide.com>
Date: Mon, 12 Nov 2012 22:50:37 +0000
Subject: Re: [PATCH 0/5] OMAPFB: use dma_alloc instead of omap's vram
Message-Id: <20121112225037.GU6801@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121112 02:27]:
> Hi,
> 
> This series changes omapfb to use standard dma_alloc funcs instead of omap
> specific vram allocator. This let's us remove the omap vram allocator, making
> omapfb platform independent.
> 
> However, note that using standard dma funcs causes the following downsides:
> 
> 1) dma_alloc_attrs doesn't let us allocate at certain physical address.
> However, this should not be a problem as this feature of vram allocator
> is only used when reserving the framebuffer that was initialized by the
> bootloader, and we don't currently support "passing" a framebuffer from
> the bootloader to the kernel anyway.
> 
> 2) dma_alloc_attrs, as of now, always ioremaps the allocated area, and
> we don't need the ioremap when using VRFB. This patch uses
> DMA_ATTR_NO_KERNEL_MAPPING for the allocation, but the flag is currently
> not operational.
> 
> 3) OMAPFB_GET_VRAM_INFO ioctl cannot return real values anymore. I
> changed the ioctl to return 64M for all the values, which, I hope, the
> applications will interpret as "there's enough vram".
> 
> 4) "vram" kernel parameter to define how much ram to reserve for video use no
> longer works. The user needs to enable CMA and use "cma" parameter.

Great, thanks for fixing these. Could you please queue these into
a separate branch against v3.7-rc5 that I can also merge into
omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3?

Feel free to add my Acked-by: Tony Lindgren <tony@atomide.com> to the
arch/arm/*omap*/* parts.

Regards,

Tony
