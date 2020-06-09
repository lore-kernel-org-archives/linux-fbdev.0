From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 09 Jun 2020 10:17:47 +0000
Subject: Re: [PATCH v2] fbdev: geode: Add the missed pci_disable_device() in gx1fb_map_video_memory()
Message-Id: <a2bc1184-df7d-b921-c699-731591b2cd56@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200605161558eucas1p1388b824ffc9c65e05a30a71ffff8333a@eucas1p1.samsung.com>
 <20200605161458.2513177-1-hslester96@gmail.com>
In-Reply-To: <20200605161458.2513177-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chuhong Yuan <hslester96@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-geode@lists.infradead.org, dri-devel@lists.freedesktop.org, Adrian Bunk <bunk@stusta.de>, Markus Elfring <Markus.Elfring@web.de>, Andres Salomon <dilinger@queued.net>, David Vrabel <dvrabel@arcom.com>


Hi,

On 6/5/20 6:14 PM, Chuhong Yuan wrote:
> Although gx1fb_probe() has handled the failure of gx1fb_map_video_memory()
> partly, it does not call pci_disable_device() as gx1fb_map_video_memory()
> calls pci_enable_device().
> Add the missed function call to fix the bug.
> 
> Fixes: 53eed4ec8bcd ("[PATCH] fbdev: geode updates]")

This doesn't seem to be a matching commit.

The proper commit seems to be:

commit a06630f3e7fb29f2524e1d7b009eb8b5a278ba23
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Mon Jun 26 00:27:04 2006 -0700

    [PATCH] Detaching fbcon: remove calls to pci_disable_device()
    
    Detaching fbcon allows individual drivers to be unloaded.  However several
    drivers call pci_disable_device() upon exit.  This function will disable the
    BAR's which will kill VGA text mode and/or affect X/DRM.
    
    To prevent this, remove calls to pci_disable_device() from several drivers.
...    

which removed pci_disable_device() calls from:

 drivers/video/aty/radeon_base.c
 drivers/video/cirrusfb.c
 drivers/video/geode/gx1fb_core.c
 drivers/video/geode/gxfb_core.c
 drivers/video/i810/i810_main.c
 drivers/video/nvidia/nvidia.c
 drivers/video/riva/fbdev.c

In order to bring back pci_disable_device() calls to gx1fb
driver (and other affected ones) you should verify that
the issue described in the above commit is no longer present
(preferably with testing modified driver on a real hardware). 

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Fix the typo in the subject.
>   - Modify the label of error handler.
>   - Refactor the code.
>  
>  drivers/video/fbdev/geode/gx1fb_core.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/fbdev/geode/gx1fb_core.c b/drivers/video/fbdev/geode/gx1fb_core.c
> index 5d34d89fb665..15645244e4d0 100644
> --- a/drivers/video/fbdev/geode/gx1fb_core.c
> +++ b/drivers/video/fbdev/geode/gx1fb_core.c
> @@ -208,29 +208,39 @@ static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
>  
>  	ret = pci_request_region(dev, 0, "gx1fb (video)");
>  	if (ret < 0)
> -		return ret;
> +		goto err_disable_device;
>  	par->vid_regs = pci_ioremap_bar(dev, 0);
>  	if (!par->vid_regs)
> -		return -ENOMEM;
> +		goto err_nomem;
>  
> -	if (!request_mem_region(gx_base + 0x8300, 0x100, "gx1fb (display controller)"))
> -		return -EBUSY;
> +	if (!request_mem_region(gx_base + 0x8300, 0x100,
> +				"gx1fb (display controller)")) {
> +		ret = -EBUSY;
> +		goto err_disable_device;
> +	}
>  	par->dc_regs = ioremap(gx_base + 0x8300, 0x100);
>  	if (!par->dc_regs)
> -		return -ENOMEM;
> +		goto err_nomem;
>  
>  	if ((fb_len = gx1_frame_buffer_size()) < 0)
> -		return -ENOMEM;
> +		goto err_nomem;
> +
>  	info->fix.smem_start = gx_base + 0x800000;
>  	info->fix.smem_len = fb_len;
>  	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
>  	if (!info->screen_base)
> -		return -ENOMEM;
> +		goto err_nomem;
>  
>  	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
>  		 info->fix.smem_len / 1024, info->fix.smem_start);
>  
>  	return 0;
> +
> +err_nomem:
> +	ret = -ENOMEM;
> +err_disable_device:
> +	pci_disable_device(dev);
> +	return ret;
>  }
>  
>  static int parse_panel_option(struct fb_info *info)
> 
