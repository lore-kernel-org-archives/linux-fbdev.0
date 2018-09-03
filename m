From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 03 Sep 2018 16:16:23 +0000
Subject: Re: [PATCH v3 04/13] fbdev: add remove_conflicting_pci_framebuffers()
Message-Id: <20180903161623.GH21634@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1535810304.git.mirq-linux@rere.qmqm.pl>
	<7db1c278276de420eb45a1b71d06b5eb6bbd49ef.1535810304.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <7db1c278276de420eb45a1b71d06b5eb6bbd49ef.1535810304.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, Jonathan Hunter <jonathanh@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>, Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, Dave Airlie <airlied@redhat.com>, Maxime Ripard <maxime.ripard@bootlin.com>, virtualization@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Sat, Sep 01, 2018 at 04:08:45PM +0200, Michał Mirosław wrote:
> Almost all PCI drivers using remove_conflicting_framebuffers() wrap it
> with the same code.
> 
> ---

This cuts away the sob. Just fyi.
-Daniel

> v2: add kerneldoc for DRM helper
> v3: propagate remove_conflicting_framebuffers() return value
>   + move kerneldoc to where function is implemented
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/video/fbdev/core/fbmem.c | 35 ++++++++++++++++++++++++++++++++
>  include/drm/drm_fb_helper.h      | 12 +++++++++++
>  include/linux/fb.h               |  2 ++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 2de93b5014e3..cd96b1c62bbe 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -34,6 +34,7 @@
>  #include <linux/fb.h>
>  #include <linux/fbcon.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/pci.h>
>  
>  #include <asm/fb.h>
>  
> @@ -1812,6 +1813,40 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
>  }
>  EXPORT_SYMBOL(remove_conflicting_framebuffers);
>  
> +/**
> + * remove_conflicting_pci_framebuffers - remove firmware-configured framebuffers for PCI devices
> + * @pdev: PCI device
> + * @resource_id: index of PCI BAR configuring framebuffer memory
> + * @name: requesting driver name
> + *
> + * This function removes framebuffer devices (eg. initialized by firmware)
> + * using memory range configured for @pdev's BAR @resource_id.
> + *
> + * The function assumes that PCI device with shadowed ROM drives a primary
> + * display and so kicks out vga16fb.
> + */
> +int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id, const char *name)
> +{
> +	struct apertures_struct *ap;
> +	bool primary = false;
> +	int err;
> +
> +	ap = alloc_apertures(1);
> +	if (!ap)
> +		return -ENOMEM;
> +
> +	ap->ranges[0].base = pci_resource_start(pdev, res_id);
> +	ap->ranges[0].size = pci_resource_len(pdev, res_id);
> +#ifdef CONFIG_X86
> +	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
> +					IORESOURCE_ROM_SHADOW;
> +#endif
> +	err = remove_conflicting_framebuffers(ap, name, primary);
> +	kfree(ap);
> +	return err;
> +}
> +EXPORT_SYMBOL(remove_conflicting_pci_framebuffers);
> +
>  /**
>   *	register_framebuffer - registers a frame buffer device
>   *	@fb_info: frame buffer info structure
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index b069433e7fc1..20ea856db900 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -577,4 +577,16 @@ drm_fb_helper_remove_conflicting_framebuffers(struct apertures_struct *a,
>  #endif
>  }
>  
> +static inline int
> +drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
> +						  int resource_id,
> +						  const char *name)
> +{
> +#if IS_REACHABLE(CONFIG_FB)
> +	return remove_conflicting_pci_framebuffers(pdev, resource_id, name);
> +#else
> +	return 0;
> +#endif
> +}
> +
>  #endif
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index aa74a228bb92..abeffd55b66a 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -632,6 +632,8 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
>  extern int register_framebuffer(struct fb_info *fb_info);
>  extern int unregister_framebuffer(struct fb_info *fb_info);
>  extern int unlink_framebuffer(struct fb_info *fb_info);
> +extern int remove_conflicting_pci_framebuffers(struct pci_dev *pdev, int res_id,
> +					       const char *name);
>  extern int remove_conflicting_framebuffers(struct apertures_struct *a,
>  					   const char *name, bool primary);
>  extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
