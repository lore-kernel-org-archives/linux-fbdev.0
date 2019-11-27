From: Michael Kelley <mikelley@microsoft.com>
Date: Wed, 27 Nov 2019 18:14:22 +0000
Subject: RE: [PATCH v2] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <CY4PR21MB0629A6D880A94949B98A3725D7440@CY4PR21MB0629.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191122082408.3210-1-weh@microsoft.com>
In-Reply-To: <20191122082408.3210-1-weh@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh@microsoft.com>, "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>, "sam@ravnborg.org" <sam@ravnborg.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "info@metux.net" <info@metux.net>, "arnd@arndb.de" <arnd@arndb.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-k>

From: Wei Hu <weh@microsoft.com> Sent: Friday, November 22, 2019 12:24 AM
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
> Signed-off-by: Wei Hu <weh@microsoft.com>
> ---
>     v2: Incorporated review comments form hch@lst.de, Michael Kelley and
>     Dexuan Cui
>     - Use dma_alloc_coherent to allocate large contiguous memory
>     - Use phys_addr_t for physical addresses
>     - Corrected a few spelling errors and minor cleanups
>     - Also tested on 32 bit Ubuntu guest
> 
>  drivers/video/fbdev/Kconfig     |   1 +
>  drivers/video/fbdev/hyperv_fb.c | 196 +++++++++++++++++++++++++-------
>  2 files changed, 158 insertions(+), 39 deletions(-)
> 

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
> +	/* Try to call alloc_pages if the size is less than 2^MAX_ORDER */
> +	if (order < MAX_ORDER) {
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		paddr = (page_to_pfn(page) << PAGE_SHIFT);
> +		request_pages = (1 << order);
> +		goto get_phymem1;
> +	}

Could you use an 'else' clause here and eliminate the above
'goto' statement?  I know that makes the below code be indented
one level deeper, but that doesn't seem particularly problematic
here.  The reason we have 'else' clauses is to avoid 'goto's and
labels.  :-)

> +
> +	/* Allocate from CMA */
> +	if (hdev == NULL)
> +		return -1;

The above test seems unnecessary.  A lot of things would have
broken before getting to this function if hdev was NULL.

> +
> +	hdev->device.coherent_dma_mask = DMA_BIT_MASK(64);
> +
> +	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +
> +	vmem = dma_alloc_coherent(&hdev->device,
> +				 request_pages * PAGE_SIZE,
> +				 &dma_handle,
> +				 GFP_KERNEL | __GFP_NOWARN);
> +
> +	if (!vmem)
> +		return -1;
> +
> +	paddr = virt_to_phys(vmem);
> +
> +get_phymem1:
> +	pr_info("Allocated %d pages starts at physical addr 0x%llx\n",
> +		request_pages, paddr);

I wonder if we want to show the physical address here.  The Linux kernel
definitely does not show kernel virtual addresses due to security
concerns, and I'm wondering if the same applies to physical addresses.
What's the benefit to showing the physical address?

And in the message "starts" should be "starting".

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
>  /* Get framebuffer memory from Hyper-V video pci space */
>  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
> @@ -947,8 +1028,57 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	void __iomem *fb_virt;
>  	int gen2vm = efi_enabled(EFI_BOOT);
>  	resource_size_t pot_start, pot_end;
> +	phys_addr_t paddr;
>  	int ret;
> 
> +	if (!gen2vm) {
> +		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	info->apertures = alloc_apertures(1);
> +	if (!info->apertures)
> +		goto err1;

There's a small memory leak here.  The apertures are never freed in any
of the error cases in this function, or in hvfb_putmem().  This is not a bug you
introduced -- the original code had the same leak.

> +
> +	if (gen2vm) {
> +		info->apertures->ranges[0].base = screen_info.lfb_base;
> +		info->apertures->ranges[0].size = screen_info.lfb_size;
> +	} else {
> +		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> +		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> +	}
> +
> +	/*
> +	 * For Gen 1 VM, we can directly use the contiguous memory
> +	 * from VM. If we succeed, deferred IO happens directly
> +	 * on this allocated framebuffer memory, avoiding extra
> +	 * memory copy.
> +	 */
> +	if (!gen2vm) {
> +		paddr = hvfb_get_phymem(hdev, screen_fb_size);
> +		if (paddr != (phys_addr_t) -1) {
> +			par->mmio_pp = paddr;
> +			par->mmio_vp = par->dio_vp = __va(paddr);
> +
> +			info->fix.smem_start = paddr;
> +			info->fix.smem_len = screen_fb_size;
> +			info->screen_base = par->mmio_vp;
> +			info->screen_size = screen_fb_size;
> +
> +			par->need_docopy = false;
> +			goto getmem1;

Maybe change the 'getmem1' label to 'done' or something similarly
indicative having successfully completed everything that needs to be
done?

> +		}
> +		pr_info("Unable to allocate enough contiguous physical memory on Gen 1
> VM. Use MMIO instead.\n");

I'd suggest changing the message to say "Using MMIO instead".  This is just an
informative message indicating what the driver is doing.  "Use MMIO instead"
sounds like a directive to the user to do something different, like change his
kernel configuration, and that's not the intent.

> +	}

In the above code, there are three, almost consecutive, tests of the "gen2vm"
variable.  It seems like the apertures could be allocated first, and then the three
tests combined into one test.  Then you have one range of code for Gen 1 and
another range for Gen 2 and fewer lines 'if' statements, 'else' statements, and
curly braces.

> +
> +	/*
> +	 * Cannot use the contiguous physical memory.
> +	 * Allocate mmio space for framebuffer.
> +	 */
>  	dio_fb_size =
>  		screen_width * screen_height * screen_depth / 8;
> 
> @@ -956,13 +1086,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  		pot_start = 0;
>  		pot_end = -1;
>  	} else {
> -		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> -			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -		if (!pdev) {
> -			pr_err("Unable to find PCI Hyper-V video\n");
> -			return -ENODEV;
> -		}
> -
>  		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
>  		    pci_resource_len(pdev, 0) < screen_fb_size) {
>  			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> @@ -991,20 +1114,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	if (par->dio_vp == NULL)
>  		goto err3;
> 
> -	info->apertures = alloc_apertures(1);
> -	if (!info->apertures)
> -		goto err4;
> -
> -	if (gen2vm) {
> -		info->apertures->ranges[0].base = screen_info.lfb_base;
> -		info->apertures->ranges[0].size = screen_info.lfb_size;
> -		remove_conflicting_framebuffers(info->apertures,
> -						KBUILD_MODNAME, false);
> -	} else {
> -		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> -		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> -	}
> -
>  	/* Physical address of FB device */
>  	par->mmio_pp = par->mem->start;
>  	/* Virtual address of FB device */
> @@ -1015,13 +1124,15 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	info->screen_base = par->dio_vp;
>  	info->screen_size = dio_fb_size;
> 
> +getmem1:
> +	remove_conflicting_framebuffers(info->apertures,
> +					KBUILD_MODNAME, false);

With your change, remove_conflicting_framebuffers() is called for both
Gen 1 and Gen 2 VMs.  In the old code, it was called only for Gen 2 VMs.
Is this change intentional?  If so, why?  I haven't delved into the details
of what remove_conflicting_framebuffers() does, so my question is 
more of a double-check rather than my definitely thinking something
is wrong.

> +
>  	if (!gen2vm)
>  		pci_dev_put(pdev);
> 
>  	return 0;
> 
> -err4:
> -	vfree(par->dio_vp);
>  err3:
>  	iounmap(fb_virt);
>  err2:
> @@ -1035,13 +1146,19 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  }
> 
>  /* Release the framebuffer */
> -static void hvfb_putmem(struct fb_info *info)
> +static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
>  {
>  	struct hvfb_par *par = info->par;
> 
> -	vfree(par->dio_vp);
> -	iounmap(info->screen_base);
> -	vmbus_free_mmio(par->mem->start, screen_fb_size);
> +	if (par->need_docopy) {
> +		vfree(par->dio_vp);
> +		iounmap(info->screen_base);
> +		vmbus_free_mmio(par->mem->start, screen_fb_size);
> +	} else {
> +		hvfb_release_phymem(hdev, info->fix.smem_start,
> +				    screen_fb_size);
> +	}
> +
>  	par->mem = NULL;

There's a small memory leak in the above statement.  The data
structure pointed to by "mem" is not freed.   The same problem
occurs in hvfb_getmem() in the "err2" path.   This bug existed in
the old code as well, so it was not introduced by your changes.

Michael
