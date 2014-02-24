From: Haiyang Zhang <haiyangz@microsoft.com>
Date: Mon, 24 Feb 2014 22:05:45 +0000
Subject: RE: [PATCH v3 3/4] hyperv-fb: add support for generation 2 virtual machines.
Message-Id: <a0771ab44e4c4743817de8c8f41a3437@DFM-DB3MBX15-08.exchange.corp.microsoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393247831-5271-1-git-send-email-kraxel@redhat.com>
 <1393247831-5271-4-git-send-email-kraxel@redhat.com>
In-Reply-To: <1393247831-5271-4-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gerd Hoffmann <kraxel@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, "Abhishek Gupta (LIS)" <abgupta@microsoft.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Monday, February 24, 2014 8:17 AM
> To: linux-fbdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; gregkh@linuxfoundation.org; KY Srinivasan;
> Abhishek Gupta (LIS); Haiyang Zhang; jasowang@redhat.com;
> tomi.valkeinen@ti.com; devel@linuxdriverproject.org; Gerd Hoffmann; Jean-
> Christophe Plagniol-Villard
> Subject: [PATCH v3 3/4] hyperv-fb: add support for generation 2 virtual
> machines.
> 
> UEFI-based generation 2 virtual machines support vmbus devices only.
> There is no pci bus.  Thus they use a different mechanism for the graphics
> framebuffer:  Instead of using the vga pci bar a chunk of memory muct be
> allocated from the hyperv mmio region declared using APCI.  This patch
> implements support for it.
> 
> Based on a patch by Haiyang Zhang <haiyangz@microsoft.com>
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/video/hyperv_fb.c | 86 +++++++++++++++++++++++++++++++++---------
> -----
>  1 file changed, 60 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/video/hyperv_fb.c b/drivers/video/hyperv_fb.c index
> 130708f..135d8cd 100644
> --- a/drivers/video/hyperv_fb.c
> +++ b/drivers/video/hyperv_fb.c
> @@ -42,6 +42,7 @@
>  #include <linux/completion.h>
>  #include <linux/fb.h>
>  #include <linux/pci.h>
> +#include <linux/efi.h>
> 
>  #include <linux/hyperv.h>
> 
> @@ -212,6 +213,7 @@ struct synthvid_msg {
> 
>  struct hvfb_par {
>  	struct fb_info *info;
> +	struct resource mem;
>  	bool fb_ready; /* fb device is ready */
>  	struct completion wait;
>  	u32 synthvid_version;
> @@ -460,13 +462,13 @@ static int synthvid_connect_vsp(struct hv_device
> *hdev)
>  		goto error;
>  	}
> 
> -	if (par->synthvid_version = SYNTHVID_VERSION_WIN7) {
> +	if (par->synthvid_version = SYNTHVID_VERSION_WIN7)
>  		screen_depth = SYNTHVID_DEPTH_WIN7;
> -		screen_fb_size = SYNTHVID_FB_SIZE_WIN7;
> -	} else {
> +	else
>  		screen_depth = SYNTHVID_DEPTH_WIN8;
> -		screen_fb_size = SYNTHVID_FB_SIZE_WIN8;
> -	}
> +
> +	screen_fb_size = hdev->channel->offermsg.offer.
> +				mmio_megabytes * 1024 * 1024;
> 
>  	return 0;
> 
> @@ -627,26 +629,46 @@ static void hvfb_get_option(struct fb_info *info)
>  /* Get framebuffer memory from Hyper-V video pci space */  static int
> hvfb_getmem(struct fb_info *info)  {
> -	struct pci_dev *pdev;
> -	ulong fb_phys;
> +	struct hvfb_par *par = info->par;
> +	struct pci_dev *pdev  = NULL;
>  	void __iomem *fb_virt;
> +	int gen2vm = efi_enabled(EFI_BOOT);
> +	int ret;
> 
> -	pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +	par->mem.name = "hyperv_fb";

Please use KBUILD_MODNAME, so that the naming is consistent.

Thanks,
- Haiyang

> +	par->mem.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +	if (gen2vm) {
> +		ret = allocate_resource(&hyperv_mmio, &par->mem,
> +					screen_fb_size,
> +					0, -1,
> +					screen_fb_size,
> +					NULL, NULL);
> +		if (ret != 0) {
> +			pr_err("Unable to allocate framebuffer memory\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
>  			      PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -	if (!pdev) {
> -		pr_err("Unable to find PCI Hyper-V video\n");
> -		return -ENODEV;
> -	}
> +		if (!pdev) {
> +			pr_err("Unable to find PCI Hyper-V video\n");
> +			return -ENODEV;
> +		}
> 
> -	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> -	    pci_resource_len(pdev, 0) < screen_fb_size)
> -		goto err1;
> +		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> +		    pci_resource_len(pdev, 0) < screen_fb_size)
> +			goto err1;
> 
> -	fb_phys = pci_resource_end(pdev, 0) - screen_fb_size + 1;
> -	if (!request_mem_region(fb_phys, screen_fb_size,
> KBUILD_MODNAME))
> -		goto err1;
> +		par->mem.end = pci_resource_end(pdev, 0);
> +		par->mem.start = par->mem.end - screen_fb_size + 1;
> +		ret = request_resource(&pdev->resource[0], &par->mem);
> +		if (ret != 0) {
> +			pr_err("Unable to request framebuffer memory\n");
> +			goto err1;
> +		}
> +	}
> 
> -	fb_virt = ioremap(fb_phys, screen_fb_size);
> +	fb_virt = ioremap(par->mem.start, screen_fb_size);
>  	if (!fb_virt)
>  		goto err2;
> 
> @@ -654,30 +676,42 @@ static int hvfb_getmem(struct fb_info *info)
>  	if (!info->apertures)
>  		goto err3;
> 
> -	info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> -	info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> -	info->fix.smem_start = fb_phys;
> +	if (gen2vm) {
> +		info->apertures->ranges[0].base = screen_info.lfb_base;
> +		info->apertures->ranges[0].size = screen_info.lfb_size;
> +	} else {
> +		info->apertures->ranges[0].base = pci_resource_start(pdev, 0);
> +		info->apertures->ranges[0].size = pci_resource_len(pdev, 0);
> +	}
> +
> +	info->fix.smem_start = par->mem.start;
>  	info->fix.smem_len = screen_fb_size;
>  	info->screen_base = fb_virt;
>  	info->screen_size = screen_fb_size;
> 
> -	pci_dev_put(pdev);
> +	if (!gen2vm)
> +		pci_dev_put(pdev);
> +
>  	return 0;
> 
>  err3:
>  	iounmap(fb_virt);
>  err2:
> -	release_mem_region(fb_phys, screen_fb_size);
> +	release_resource(&par->mem);
>  err1:
> -	pci_dev_put(pdev);
> +	if (!gen2vm)
> +		pci_dev_put(pdev);
> +
>  	return -ENOMEM;
>  }
> 
>  /* Release the framebuffer */
>  static void hvfb_putmem(struct fb_info *info)  {
> +	struct hvfb_par *par = info->par;
> +
>  	iounmap(info->screen_base);
> -	release_mem_region(info->fix.smem_start, screen_fb_size);
> +	release_resource(&par->mem);
>  }
> 
> 
> --
> 1.8.3.1

