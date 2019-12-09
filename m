From: Michael Kelley <mikelley@microsoft.com>
Date: Mon, 09 Dec 2019 16:32:56 +0000
Subject: RE: [PATCH v4] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <CY4PR21MB06293C21EC5338C98080F6AED7580@CY4PR21MB0629.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191209075749.3804-1-weh@microsoft.com>
In-Reply-To: <20191209075749.3804-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: kbuild test robot <lkp@intel.com>

From: Wei Hu <weh@microsoft.com> Sent: Sunday, December 8, 2019 11:58 PM
> 
> On Hyper-V, Generation 1 VMs can directly use VM's physical memory for
> their framebuffers. This can improve the efficiency of framebuffer and
> overall performence for VM. The physical memory assigned to framebuffer
> must be contiguous. We use CMA allocator to get contiguouse physicial
> memory when the framebuffer size is greater than 4MB. For size under
> 4MB, we use alloc_pages to achieve this.
> 
> To enable framebuffer memory allocation from CMA, supply a kernel
> parameter to give enough space to CMA allocator at boot time. For
> example:
>     cma=130m
> This gives 130MB memory to CAM allocator that can be allocated to
> framebuffer. If this fails, we fall back to the old way of using
> mmio for framebuffer.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporated review comments form hch@lst.de, Michael Kelley and
>     Dexuan Cui
>     - Use dma_alloc_coherent to allocate large contiguous memory
>     - Use phys_addr_t for physical addresses
>     - Corrected a few spelling errors and minor cleanups
>     - Also tested on 32 bit Ubuntu guest
>     v3: Fixed a build issue reported by kbuild test robot and incorported
>     some review comments from Michael Kelley
>     - Add CMA check to avoid link failure
>     - Fixed small memory leak introduced by alloc_apertures
>     - Cleaned up so code
>     v4: Removed request_pages variable as it is no longer needed
> 
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 182 +++++++++++++++++++++++++-------
>  2 files changed, 144 insertions(+), 39 deletions(-)
> 

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
