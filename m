From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Date: Sun, 05 Jan 2014 14:16:54 +0000
Subject: Re: [PATCH 1/2] ARM: omapfb: add coherent dma memory support
Message-Id: <52C96956.7040803@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1388409550-10720-1-git-send-email-tomi.valkeinen@ti.com>
 <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1388409550-10720-2-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


On 30.12.2013 15:19, Tomi Valkeinen wrote:
> The omapfb driver uses dma_alloc to reserve memory for the framebuffers.
> However, on some use cases, even when CMA is in use, it's quite probable
> that omapfb fails to allocate the fb, either due to not enough free dma
> memory, fragmented dma memory, or CMA failing to make enough contiguous
> space.
>
> This patch adds a kernel cmdline parameter 'omapfb_vram' which can be
> used to give the size of a memory area reserved exclusively for omapfb,
> and optionally a physical address where the memory area is reserved.
>
> The memory area is reserved with memblock, and assigned to omapfb with
> dma_declare_coherent_memory. The dma_alloc function will first try to
> allocate the fb from the coherent memory area, and if that fails, it'll
> use the normal method of allocation.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Ivaylo Dimitrov <freemangordon@abv.bg>
> ---
>   arch/arm/mach-omap2/common.c |  1 +
>   arch/arm/mach-omap2/common.h |  2 ++
>   arch/arm/mach-omap2/fb.c     | 77 +++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 79 insertions(+), 1 deletion(-)
>

Tested on Nokia N900 with Maemo5 and linux 3.13-rc6
