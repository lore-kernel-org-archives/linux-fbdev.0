From: Peter Jones <pjones@redhat.com>
Subject: Re: [PATCH] fb: add support for handoff from
	firmware to hw framebuffers
Date: Thu, 04 Jun 2009 10:43:14 -0400
Message-ID: <4A27DD82.3010305@redhat.com>
References: <1244090788-31645-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pjones@redhat.com>) id 1MCEA7-0003Ww-Is
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 14:43:23 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCEA6-00089D-B2 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 14:43:23 +0000
In-Reply-To: <1244090788-31645-1-git-send-email-airlied@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev-devel@lists.sf.net

On 06/04/2009 12:46 AM, Dave Airlie wrote:
> From: Dave Airlie <airlied@redhat.com>
> 
> With KMS we have ran into an issue where we really want the KMS fb driver
> to be the one running the console, so panics etc can be shown by switching
> out of X etc.
> 
> However with vesafb/efifb built-in, we end up with those on fb0 and the
> KMS fb driver on fb1, driving the same piece of hw, so this adds an fb info
> flag to denote a firmware fbdev, and adds a new aperture base/size range
> which can be compared when the hw drivers are installed to see if there
> is a conflict with a firmware driver, and if there is the firmware driver is
> unregistered and the hw driver takes over.
> 
> It uses new aperture_base/size members instead of comparing on the fix
> smem_start/length, as smem_start/length might for example only cover the
> first 1MB of the PCI aperture, and we could allocate the kms fb from 8MB
> into the aperture, thus they would never overlap.
> 
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_fb.c |    8 ++++++++
>  drivers/video/efifb.c           |    5 ++++-
>  drivers/video/fbmem.c           |   24 ++++++++++++++++++++++++
>  drivers/video/vesafb.c          |    6 +++++-
>  include/linux/fb.h              |    9 ++++++++-
>  5 files changed, 49 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_fb.c b/drivers/gpu/drm/i915/intel_fb.c
> index e4652dc..f1849d3 100644
> --- a/drivers/gpu/drm/i915/intel_fb.c
> +++ b/drivers/gpu/drm/i915/intel_fb.c
> @@ -504,6 +504,14 @@ static int intelfb_create(struct drm_device *dev, uint32_t fb_width,
>  	info->fbops = &intelfb_ops;
>  
>  	info->fix.line_length = fb->pitch;
> +
> +	/* setup aperture base/size for vesafb takeover */
> +	info->aperture_base = dev->mode_config.fb_base;
> +	if (IS_I9XX(dev))
> +		info->aperture_size = pci_resource_len(dev->pdev, 2);
> +	else
> +		info->aperture_size = pci_resource_len(dev->pdev, 0);
> +
>  	info->fix.smem_start = dev->mode_config.fb_base + obj_priv->gtt_offset;
>  	info->fix.smem_len = size;
>  
> diff --git a/drivers/video/efifb.c b/drivers/video/efifb.c
> index 8dea2bc..eb12182 100644
> --- a/drivers/video/efifb.c
> +++ b/drivers/video/efifb.c
> @@ -280,6 +280,9 @@ static int __init efifb_probe(struct platform_device *dev)
>  	info->pseudo_palette = info->par;
>  	info->par = NULL;
>  
> +	info->aperture_base = efifb_fix.smem_start;
> +	info->aperture_size = size_total;
> +

It seems like we aught to be looking up the PCI BAR here, reserving it, and
using that as aperture_{base,size} -- though that's not strictly required by
fb_compare_aperture_sizes() .

>  	info->screen_base = ioremap(efifb_fix.smem_start, efifb_fix.smem_len);
>  	if (!info->screen_base) {
>  		printk(KERN_ERR "efifb: abort, cannot ioremap video memory "
> @@ -337,7 +340,7 @@ static int __init efifb_probe(struct platform_device *dev)
>  	info->fbops = &efifb_ops;
>  	info->var = efifb_defined;
>  	info->fix = efifb_fix;
> -	info->flags = FBINFO_FLAG_DEFAULT;
> +	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE;
>  
>  	if ((err = fb_alloc_cmap(&info->cmap, 256, 0)) < 0) {
>  		printk(KERN_ERR "efifb: cannot allocate colormap\n");
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index d412a1d..3dd033b 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -1462,6 +1462,16 @@ static int fb_check_foreignness(struct fb_info *fi)
>  	return 0;
>  }
>  
> +static bool fb_compare_aperture_sizes(struct fb_info *gen, struct fb_info *hw)

The name here seems weird -- something like fb_do_apertures_overlap() or even just fb_compare_apertures() would be more clear to me.

> +{
> +	/* is the generic aperture base the same as the HW one */
> +	if (gen->aperture_base == hw->aperture_base)
> +		return true;
> +	/* is the generic aperture base inside the hw base->hw base+size */
> +	if (gen->aperture_base > hw->aperture_base && gen->aperture_base <= hw->aperture_base + hw->aperture_size)
> +		return true;
> +	return false;
> +}
>  /**
>   *	register_framebuffer - registers a frame buffer device
>   *	@fb_info: frame buffer info structure
> @@ -1485,6 +1495,20 @@ register_framebuffer(struct fb_info *fb_info)
>  	if (fb_check_foreignness(fb_info))
>  		return -ENOSYS;
>  
> +	/* check all firmware fbs and kick off if the base addr overlaps */
> +	for (i = 0 ; i < FB_MAX; i++) {
> +		if (!registered_fb[i])
> +			continue;
> +
> +		if (registered_fb[i]->flags & FBINFO_MISC_FIRMWARE) {
> +			if (fb_compare_aperture_sizes(registered_fb[i], fb_info)) {
> +				printk("fb: conflicting fb hw usage - removing generic driver\n", registered_fb[i]->aperture_base, fb_info->aperture_base);
> +				unregister_framebuffer(registered_fb[i]);
> +				break;
> +			}
> +		}
> +	}

Seems like we should we also have a "nomodeset" check in this codepath.

> +
>  	num_registered_fb++;
>  	for (i = 0 ; i < FB_MAX; i++)
>  		if (!registered_fb[i])
> diff --git a/drivers/video/vesafb.c b/drivers/video/vesafb.c
> index d6856f4..52f03b2 100644
> --- a/drivers/video/vesafb.c
> +++ b/drivers/video/vesafb.c
> @@ -286,6 +286,10 @@ static int __init vesafb_probe(struct platform_device *dev)
>  	info->pseudo_palette = info->par;
>  	info->par = NULL;
>  
> +	/* set vesafb aperture size for generic probing */
> +	info->aperture_base = screen_info.lfb_base;
> +	info->aperture_size = size_total;
> +
>  	info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
>  	if (!info->screen_base) {
>  		printk(KERN_ERR
> @@ -437,7 +441,7 @@ static int __init vesafb_probe(struct platform_device *dev)
>  	info->fbops = &vesafb_ops;
>  	info->var = vesafb_defined;
>  	info->fix = vesafb_fix;
> -	info->flags = FBINFO_FLAG_DEFAULT |
> +	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE |
>  		(ypan ? FBINFO_HWACCEL_YPAN : 0);
>  
>  	if (!ypan)
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 330c4b1..88cbe56 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -786,6 +786,8 @@ struct fb_tile_ops {
>  #define FBINFO_MISC_USEREVENT          0x10000 /* event request
>  						  from userspace */
>  #define FBINFO_MISC_TILEBLITTING       0x20000 /* use tile blitting */
> +#define FBINFO_MISC_FIRMWARE           0x40000 /* a replaceable firmware 
> +						  inited framebuffer */
>  
>  /* A driver may set this flag to indicate that it does want a set_par to be
>   * called every time when fbcon_switch is executed. The advantage is that with
> @@ -854,7 +856,12 @@ struct fb_info {
>  	u32 state;			/* Hardware state i.e suspend */
>  	void *fbcon_par;                /* fbcon use-only private area */
>  	/* From here on everything is device dependent */
> -	void *par;	
> +	void *par;
> +	/* we need the PCI or similiar aperture base/size not
> +	   smem_start/size as smem_start may just be an object
> +	   allocated inside the aperture so may not actually overlap */
> +	resource_size_t aperture_base;
> +	resource_size_t aperture_size;
>  };
>  
>  #ifdef MODULE

-- 
        Peter

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
