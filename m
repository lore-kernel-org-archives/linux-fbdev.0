From: Michael Kelley <mikelley@microsoft.com>
Date: Sat, 02 Nov 2019 00:28:32 +0000
Subject: RE: [PATCH] video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.
Message-Id: <DM5PR21MB013765D349FF1F90E22E247DD77D0@DM5PR21MB0137.namprd21.prod.outlook.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191022110905.4032-1-weh@microsoft.com>
In-Reply-To: <20191022110905.4032-1-weh-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Hu <weh-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <mchehab+samsung-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org" <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org" <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, "info-EcKl7qYKIbxeoWH0uzbU5w@public.gmane.org" <info-EcKl7qYKIbxeoWH0uzbU5w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-hyperv-u79uwXL29TbrhsbdSgBK9A@public.gmane.org

From: Wei Hu <weh@microsoft.com> Sent: Tuesday, October 22, 2019 4:11 AM
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

[snip]

> +/*
> + * Allocate enough contiguous physical memory.
> + * Return physical address if succeeded or -1 if failed.
> + */
> +static unsigned long hvfb_get_phymem(unsigned int request_size)
> +{
> +	struct page *page = NULL;
> +	unsigned int request_pages;
> +	unsigned long paddr = 0;

Using 'unsigned long' for physical addresses is problematic on 32-bit
systems with Physical Address Extension (PAE) enabled. Linux has
phys_addr_t that handles 32-bit PAE correctly and that probably
should be used here.   This whole driver needs to be carefully
checked for the correct type for physical addresses.

> +	unsigned int order = get_order(request_size);
> +
> +	if (request_size == 0)
> +		return -1;
> +
> +	/* Try call alloc_pages if the size is less than 2^MAX_ORDER */
> +	if (order < MAX_ORDER) {
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, order);
> +		if (!page)
> +			return -1;
> +
> +		request_pages = (1 << order);
> +		goto get_phymem1;
> +	}
> +
> +	/* Allocate from CMA */
> +	// request_pages = (request_size >> PAGE_SHIFT) + 1;
> +	request_pages = (round_up(request_size, PAGE_SIZE) >> PAGE_SHIFT);
> +	page = dma_alloc_from_contiguous(NULL, request_pages, 0, false);
> +
> +	if (page == NULL)
> +		return -1;
> +
> +get_phymem1:
> +	paddr = (page_to_pfn(page) << PAGE_SHIFT);
> +
> +	pr_info("Allocated %d pages starts at physical addr 0x%lx\n",
> +		request_pages, paddr);
> +
> +	return paddr;
> +}
> +
> +/* Release contiguous physical memory */
> +static void hvfb_release_phymem(unsigned long paddr, unsigned int size)

Same issue here with 'unsigned long paddr'.

> +{
> +	unsigned int order = get_order(size);
> +
> +	if (order < MAX_ORDER)
> +		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
> +	else
> +		dma_release_from_contiguous(NULL,
> +					    pfn_to_page(paddr >> PAGE_SHIFT),
> +					    (round_up(size, PAGE_SIZE) >>
> +					     PAGE_SHIFT));
> +					    // (size >> PAGE_SHIFT) + 1);
> +}
> +
> 
>  /* Get framebuffer memory from Hyper-V video pci space */
>  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
> @@ -947,8 +1017,58 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
> *info)
>  	void __iomem *fb_virt;
>  	int gen2vm = efi_enabled(EFI_BOOT);
>  	resource_size_t pot_start, pot_end;
> +	unsigned long paddr;

Same issue with 'unsigned long'.

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
> +	 * from VM. If we success, deferred IO happens directly
> +	 * on this allocated framebuffer memory, avoiding extra
> +	 * memory copy.
> +	 */
> +	if (!gen2vm) {
> +		paddr = hvfb_get_phymem(screen_fb_size);
> +		if (paddr != (unsigned long) -1) {

phys_addr_t

> +			par->mmio_pp = paddr;

I'm not really sure what to do about the above, because mmio_pp is
declared as 'unsigned long' when it really should be phys_addr_t.
But maybe a MMIO address will always be less than 4 Gb and therefore
will fit in 32 bits?

> +			par->mmio_vp = par->dio_vp = __va(paddr);
> +
> +			info->fix.smem_start = paddr;

smem_start is also declared as 'unsigned long', which seems
problematic with 32-bit PAE.  There are a lot of drivers that cast values
as 'unsigned long' before storing into smem_start

> +			info->fix.smem_len = screen_fb_size;
> +			info->screen_base = par->mmio_vp;
> +			info->screen_size = screen_fb_size;
> +
> +			par->need_docopy = false;
> +			goto getmem1;
> +		} else {
> +			pr_info("Unable to allocate enough contiguous physical memory on
> Gen 1 VM. Use MMIO instead.\n");
> +		}
> +	}
> +
> +	/*
> +	 * Cannot use the contiguous physical memory.
> +	 * Allocate mmio space for framebuffer.
> +	 */
>  	dio_fb_size =
>  		screen_width * screen_height * screen_depth / 8;
> 
> @@ -956,13 +1076,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
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
> @@ -991,20 +1104,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info
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

32-bit PAE problem could also occur here, even though the above line isn't
part of your patch.

Ideally, we would build the kernel in 32-bit mode with PAE enabled, and
test in an environment where the frame buffer gets allocated above the
4 Gbyte line.  There may be some similar bugs in other parts of this
driver that aren't touched by the patch.

Michael
