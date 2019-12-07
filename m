From: Michael Kelley <mikelley@microsoft.com>
Date: Sat, 07 Dec 2019 16:28:28 +0000
Subject: RE: [PATCH v3] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <CY4PR21MB0629C3DA1201A3FB51A7F486D75E0@CY4PR21MB0629.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191206113220.1849-1-weh@microsoft.com>
In-Reply-To: <20191206113220.1849-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: kbuild test robot <lkp@intel.com>

From: Wei Hu <weh@microsoft.com> Sent: Friday, December 6, 2019 3:32 AM
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

[snip]

> +/*
> + * Allocate enough contiguous physical memory.
> + * Return physical address if succeeded or -1 if failed.
> + */
> +static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
> +				   unsigned int request_size)
> +{
> +	struct page *page = NULL;
> +	dma_addr_t dma_handle;
> +	void *vmem;
> +	unsigned int request_pages;
> +	phys_addr_t paddr = 0;
> +	unsigned int order = get_order(request_size);
> +
> +	if (request_size == 0)
> +		return -1;
> +
> +	if (order < MAX_ORDER) {
> +		/* Call alloc_pages if the size is less than 2^MAX_ORDER */
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		paddr = (page_to_pfn(page) << PAGE_SHIFT);
> +		request_pages = (1 << order);

The above line is no longer needed.  request_pages was previously an
argument to a pr_info() statement, but that statement has appropriately
been removed.

> +	} else {
> +		/* Allocate from CMA */
> +		hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
> +
> +		request_pages = (round_up(request_size, PAGE_SIZE) >>
> +				 PAGE_SHIFT);
> +
> +		vmem = dma_alloc_coherent(&hdev->device,
> +					  request_pages * PAGE_SIZE,
> +					  &dma_handle,
> +					  GFP_KERNEL | __GFP_NOWARN);

With the request_pages value no longer being needed, there's wasted motion
in doing a PAGE_SHIFT shift to calculate request_pages, and then multiplying by
PAGE_SIZE.  The second argument above could just be
round_up(request_size, PAGE_SIZE).   Then it would be exactly parallel to
the second argument to dma_free_coherent() below in hvfb_release_phymem().
The request_pages variable can be eliminated entirely.

> +
> +		if (!vmem)
> +			return -1;
> +
> +		paddr = virt_to_phys(vmem);
> +	}
> +
> +	return paddr;
> +}
> +
> +/* Release contiguous physical memory */
> +static void hvfb_release_phymem(struct hv_device *hdev,
> +				phys_addr_t paddr, unsigned int size)
> +{
> +	unsigned int order = get_order(size);
> +
> +	if (order < MAX_ORDER)
> +		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
> +	else
> +		dma_free_coherent(&hdev->device,
> +				  round_up(size, PAGE_SIZE),
> +				  phys_to_virt(paddr),
> +				  paddr);
> +}
> +
> 

Everything else looks good.  The most recent changes to hvfb_getmem() worked
out very nicely.

Michael
