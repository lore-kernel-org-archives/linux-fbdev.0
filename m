From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [PATCH] sisfb: New framebuffer_alloc API and class_dev changes
Date: Tue, 16 Sep 2003 01:12:45 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3F66476D.8010405@winischhofer.net>
References: <20030915204703.GB23294@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z2Zw-0004GM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 16:16:20 -0700
Received: from [213.229.38.18] (helo=home.winischhofer.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19z2Zu-0001vv-EC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 16:16:18 -0700
In-Reply-To: <20030915204703.GB23294@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: kronos@kronoz.cjb.net
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>


Unfortunately you didn't base you changes on the current version (which 
is on my website)

I will merge your patch, but when will we see this framebuffer_alloc 
stuff in any mainstream kernel? Until then, I can only surround this new 
  API with some unresolvable #if's...

Thomas

Kronos wrote:
> Hi,
> this patch converts driver/video/sis to framebuffer_alloc:
> 
> ======== drivers/video/sis/sis_main.c 1.29 ========
> D 1.29 03/09/14 00:55:04+02:00 kronos@kronoz.cjb.net 35 34 87/56/5315
> P drivers/video/sis/sis_main.c
> C bugfix: sis_fb_info.fontname was set in sisfb_setup, but sis_fb_info was reset (with a memset) in sisfb_init. Add a static sisfb_fontname.
> C sis_fb_info is now dynamically allocated using framebuffer_alloc for kernel >= 2.6.0 and with kmalloc for older kernels.
> C add release_sisfb: this is manually called after framebuffer_unregister for older (< 2.6.0) kernels and automagically called for newer kernels.
> ------------------------------------------------
> 
> ===== drivers/video/sis/sis_main.c 1.28 vs 1.29 =====
> --- 1.28/drivers/video/sis/sis_main.c	Fri Aug 22 08:27:09 2003
> +++ 1.29/drivers/video/sis/sis_main.c	Sun Sep 14 00:55:04 2003
> @@ -2382,7 +2382,7 @@
>  	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
>  
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)	
> -	strcpy(fix->id, sis_fb_info.modename);
> +	strcpy(fix->id, sis_fb_info->modename);
>  #else
>  	strcpy(fix->id, myid);
>  #endif	
> @@ -4077,7 +4077,7 @@
>  	char *this_opt;
>  	
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> -	sis_fb_info.fontname[0] = '\0';
> +	sisfb_fontname[0] = '\0';
>  #endif	
>  
>  	ivideo.refresh_rate = 0;
> @@ -4102,7 +4102,8 @@
>  			sisfb_inverse = 1;
>  			/* fb_invert_cmaps(); */
>  		} else if (!strnicmp(this_opt, "font:", 5)) {
> -			strcpy(sis_fb_info.fontname, this_opt + 5);
> +			strncpy(sisfb_fontname, this_opt + 5, sizeof(sisfb_fontname) - 1);
> +			sisfb_fontname[sizeof(sisfb_fontname) - 1] = '\0';
>  #endif
>  		} else if (!strnicmp(this_opt, "vrate:", 6)) {
>  			ivideo.refresh_rate = simple_strtoul(this_opt + 6, NULL, 0);
> @@ -4273,8 +4274,6 @@
>  	sisfb_registered = 0;
>  	sisfb_thismonitor.datavalid = FALSE;
>  
> -	memset(&sis_fb_info, 0, sizeof(sis_fb_info));
> -
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
>          memset(&sisfb_lastrates[0], 0, 128);
>  #endif
> @@ -4292,8 +4291,19 @@
>  			if ((b->vendor == pdev->vendor)
>  			    && (b->device == pdev->device)) {
>  				pdev_valid = 1;
> +
> +#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> +				sis_fb_info = framebuffer_alloc(0, &pdev->dev);
> +#else
> +				sis_fb_info = kmalloc(sizeof(*sis_fb_info));
> +				memset(sis_fb_info, 0, sizeof(*sis_fb_info));
> +#endif
> +				if (!sis_fb_info)
> +					return -ENOMEM;
> +				
>  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)				
> -				strcpy(sis_fb_info.modename, b->name);
> +				strcpy(sis_fb_info->modename, b->name);
> +				memcpy(sis_fb_info->fontname, sisfb_fontname, sizeof(sisfb_fontname));
>  #else				
>  				strcpy(myid, b->name);
>  #endif				
> @@ -4335,7 +4345,7 @@
>  			if(reg32 == 0x07301039) {
>  				ivideo.chip = SIS_730;
>  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
> -				strcpy(sis_fb_info.modename, "SIS 730");
> +				strcpy(sis_fb_info->modename, "SIS 730");
>  #else
>  				strcpy(myid, "SIS 730");
>  #endif
> @@ -4385,7 +4395,7 @@
>  			if(reg32 == 0x07401039) {
>  				ivideo.chip = SIS_740;
>  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
> -				strcpy(sis_fb_info.modename, "SIS 740");
> +				strcpy(sis_fb_info->modename, "SIS 740");
>  #else
>  				strcpy(myid, "SIS 740");
>  #endif
> @@ -4409,7 +4419,7 @@
>  			if(reg32 == 0x07601039) {
>  				ivideo.chip = SIS_760;
>  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,5,0)
> -				strcpy(sis_fb_info.modename, "SIS 760");
> +				strcpy(sis_fb_info->modename, "SIS 760");
>  #else
>  				strcpy(myid, "SIS 760");
>  #endif
> @@ -4421,6 +4431,7 @@
>  		}
>  #endif
>             default:
> +		kfree(sis_fb_info);
>  	        return -ENODEV;
>  	}
>  	sishw_ext.jChipType = ivideo.chip;
> @@ -4438,7 +4449,10 @@
>  	sisfb_mmio_size =  pci_resource_len(pdev, 1);
>  
>  	if(!sisvga_enabled) {
> -		if (pci_enable_device(pdev))   return -EIO;
> +		if (pci_enable_device(pdev)) {
> +			kfree(sis_fb_info);
> +			return -EIO;
> +		}
>  	}
>  
>  	SiS_Pr.SiS_Backup70xx = 0xff;
> @@ -4472,6 +4486,7 @@
>  	if((reg & 0x80) && (reg != 0xff)) {
>  	   if((sisbios_mode[sisfb_mode_idx].mode_no) != 0xFF) {
>  	      printk(KERN_INFO "sisfb: Cannot initialize display mode, X server is active\n");
> +	      kfree(sis_fb_info);
>  	      return -EBUSY;
>  	   }
>  	}
> @@ -4608,6 +4623,7 @@
>  	sishw_ext.pSR = vmalloc(sizeof(SIS_DSReg) * SR_BUFFER_SIZE);
>  	if (sishw_ext.pSR == NULL) {
>  		printk(KERN_ERR "sisfb: Fatal error: Allocating SRReg space failed.\n");
> +		kfree(sis_fb_info);
>  		return -ENODEV;
>  	}
>  	sishw_ext.pSR[0].jIdx = sishw_ext.pSR[0].jVal = 0xFF;
> @@ -4616,6 +4632,7 @@
>  	if (sishw_ext.pCR == NULL) {
>  	        vfree(sishw_ext.pSR);
>  		printk(KERN_ERR "sisfb: Fatal error: Allocating CRReg space failed.\n");
> +		kfree(sis_fb_info);
>  		return -ENODEV;
>  	}
>  	sishw_ext.pCR[0].jIdx = sishw_ext.pCR[0].jVal = 0xFF;
> @@ -4650,6 +4667,7 @@
>  		        vfree(sishw_ext.pSR);
>  			vfree(sishw_ext.pCR);
>  			printk(KERN_ERR "sisfb: Fatal error: Unable to determine RAM size\n");
> +			kfree(sis_fb_info);
>  			return -ENODEV;
>  		}
>  	}
> @@ -4702,6 +4720,7 @@
>  			vfree(sishw_ext.pSR);
>  			vfree(sishw_ext.pCR);
>  			printk(KERN_INFO "sisfb: Fatal error: Unable to determine RAM size.\n");
> +			kfree(sis_fb_info);
>  			return -ENODEV;
>  		}
>  	}
> @@ -4730,6 +4749,7 @@
>  		printk(KERN_ERR "sisfb: Is there another framebuffer driver active?\n");
>  		vfree(sishw_ext.pSR);
>  		vfree(sishw_ext.pCR);
> +		kfree(sis_fb_info);
>  		return -ENODEV;
>  	}
>  
> @@ -4738,6 +4758,7 @@
>  		release_mem_region(ivideo.video_base, ivideo.video_size);
>  		vfree(sishw_ext.pSR);
>  		vfree(sishw_ext.pCR);
> +		kfree(sis_fb_info);
>  		return -ENODEV;
>  	}
>  
> @@ -4943,6 +4964,7 @@
>  			vfree(sishw_ext.pCR);
>  			release_mem_region(ivideo.video_base, ivideo.video_size);
>  			release_mem_region(ivideo.mmio_base, sisfb_mmio_size);
> +			kfree(sis_fb_info);
>  			return -EINVAL;
>  		}
>  
> @@ -4959,16 +4981,16 @@
>  
>  		sisfb_crtc_to_var(&default_var);
>  		
> -		sis_fb_info.node = -1;
> -		sis_fb_info.flags = FBINFO_FLAG_DEFAULT;
> -		sis_fb_info.blank = &sisfb_blank;
> -		sis_fb_info.fbops = &sisfb_ops;
> -		sis_fb_info.switch_con = &sisfb_switch;
> -		sis_fb_info.updatevar = &sisfb_update_var;
> -		sis_fb_info.changevar = NULL;
> -		sis_fb_info.disp = &sis_disp;
> +		sis_fb_info->node = -1;
> +		sis_fb_info->flags = FBINFO_FLAG_DEFAULT;
> +		sis_fb_info->blank = &sisfb_blank;
> +		sis_fb_info->fbops = &sisfb_ops;
> +		sis_fb_info->switch_con = &sisfb_switch;
> +		sis_fb_info->updatevar = &sisfb_update_var;
> +		sis_fb_info->changevar = NULL;
> +		sis_fb_info->disp = &sis_disp;
>  			
> -		sisfb_set_disp(-1, &default_var, &sis_fb_info);
> +		sisfb_set_disp(-1, &default_var, sis_fb_info);
>  		
>  #else		/* --------- For 2.5: Setup a somewhat sane default var ------------ */
>  
> @@ -5012,17 +5034,17 @@
>  	    		}
>  		}
>  
> -		sis_fb_info.flags = FBINFO_FLAG_DEFAULT;
> -		sis_fb_info.var = default_var;
> -		sis_fb_info.fix = sisfb_fix;
> -		sis_fb_info.par = &ivideo;
> -		sis_fb_info.screen_base = ivideo.video_vbase;
> -		sis_fb_info.fbops = &sisfb_ops;
> -		sis_fb_info.dev = &pdev->dev;
> -		sisfb_get_fix(&sis_fb_info.fix, -1, &sis_fb_info);
> -		sis_fb_info.pseudo_palette = pseudo_palette;
> +		sis_fb_info->flags = FBINFO_FLAG_DEFAULT;
> +		sis_fb_info->var = default_var;
> +		sis_fb_info->fix = sisfb_fix;
> +		sis_fb_info->par = &ivideo;
> +		sis_fb_info->screen_base = ivideo.video_vbase;
> +		sis_fb_info->fbops = &sisfb_ops;
> +		sis_fb_info->release = &release_sisfb;
> +		sisfb_get_fix(&sis_fb_info->fix, -1, sis_fb_info);
> +		sis_fb_info->pseudo_palette = pseudo_palette;
>  		
> -		fb_alloc_cmap(&sis_fb_info.cmap, 256 , 0);
> +		fb_alloc_cmap(&sis_fb_info->cmap, 256 , 0);
>  #endif
>  
>  		printk(KERN_INFO "sisfb: Initial vbflags 0x%lx\n", ivideo.vbflags);
> @@ -5041,7 +5063,7 @@
>  		vc_resize_con(1, 1, 0);
>  #endif
>  
> -		if(register_framebuffer(&sis_fb_info) < 0) {
> +		if(register_framebuffer(sis_fb_info) < 0) {
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
>  			vfree(sishw_ext.pSR);
>  			vfree(sishw_ext.pCR);
> @@ -5049,6 +5071,7 @@
>  			release_mem_region(ivideo.mmio_base, sisfb_mmio_size);
>  #endif
>  			printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuffer\n");
> +			kfree(sis_fb_info);
>  			return -EINVAL;
>  		}
>  
> @@ -5063,13 +5086,13 @@
>  
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>  		printk(KERN_INFO "fb%d: %s frame buffer device, Version %d.%d.%02d\n",
> -	       		GET_FB_IDX(sis_fb_info.node), sis_fb_info.modename, VER_MAJOR, VER_MINOR,
> +	       		GET_FB_IDX(sis_fb_info->node), sis_fb_info->modename, VER_MAJOR, VER_MINOR,
>  	       		VER_LEVEL);		     
>  #endif
>  
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,0)
>  		printk(KERN_INFO "fb%d: %s frame buffer device, Version %d.%d.%02d\n",
> -	       		sis_fb_info.node, myid, VER_MAJOR, VER_MINOR, VER_LEVEL);
> +	       		sis_fb_info->node, myid, VER_MAJOR, VER_MINOR, VER_LEVEL);
>  #endif
>  
>  		printk(KERN_INFO "sisfb: (C) 2001-2003 Thomas Winischhofer. All rights reserved.\n");
> @@ -5078,6 +5101,33 @@
>  	return 0;
>  }
>  
> +#if defined(MODULE) || LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> +static void release_sisfb(struct fb_info *info) {
> +	/* TW: Release mem regions */
> +	release_mem_region(ivideo.video_base, ivideo.video_size);
> +	release_mem_region(ivideo.mmio_base, sisfb_mmio_size);
> +
> +#ifdef CONFIG_MTRR
> +	/* TW: Release MTRR region */
> +	if(ivideo.mtrr) {
> +		mtrr_del(ivideo.mtrr,
> +		      (unsigned int)ivideo.video_base,
> +	              (unsigned int)ivideo.video_size);
> +	}
> +#endif
> +
> +	if(sishw_ext.pSR) vfree(sishw_ext.pSR);
> +	if(sishw_ext.pCR) vfree(sishw_ext.pCR);
> +	
> +	/* TODO: Restore the initial mode 
> +	 * This sounds easy but is as good as impossible
> +	 * on many machines with SiS chip and video bridge
> +	 * since text modes are always set up differently
> +	 * from machine to machine. Depends on the type
> +	 * of integration between chipset and bridge.
> +	 */
> +}
> +#endif
>  
>  #ifdef MODULE
>  
> @@ -5329,34 +5379,15 @@
>  
>  void cleanup_module(void)
>  {
> -	/* TW: Release mem regions */
> -	release_mem_region(ivideo.video_base, ivideo.video_size);
> -	release_mem_region(ivideo.mmio_base, sisfb_mmio_size);
> -
> -#ifdef CONFIG_MTRR
> -	/* TW: Release MTRR region */
> -	if(ivideo.mtrr) {
> -		mtrr_del(ivideo.mtrr,
> -		      (unsigned int)ivideo.video_base,
> -	              (unsigned int)ivideo.video_size);
> -	}
> -#endif
> -
>  	/* Unregister the framebuffer */
>  	if(sisfb_registered) {
> -		unregister_framebuffer(&sis_fb_info);
> +		unregister_framebuffer(sis_fb_info);
>  	}
>  
> -	if(sishw_ext.pSR) vfree(sishw_ext.pSR);
> -	if(sishw_ext.pCR) vfree(sishw_ext.pCR);
> -	
> -	/* TODO: Restore the initial mode 
> -	 * This sounds easy but is as good as impossible
> -	 * on many machines with SiS chip and video bridge
> -	 * since text modes are always set up differently
> -	 * from machine to machine. Depends on the type
> -	 * of integration between chipset and bridge.
> -	 */
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,0)
> +	release_sisfb(sis_fb_info);
> +	kfree(sis_fb_info);
> +#endif
>  	
>  	printk(KERN_INFO "sisfb: Module unloaded\n");
>  }
> 
> 
> ======== drivers/video/sis/sis_main.h 1.14 ========
> D 1.14 03/09/14 00:54:38+02:00 kronos@kronoz.cjb.net 15 14 6/1/1166
> P drivers/video/sis/sis_main.h
> C make sis_fb_info a pointer
> C add sisfb_fontname (used by sisfb_setup)
> C add prototype of release_sisfb
> ------------------------------------------------
> 
> ===== drivers/video/sis/sis_main.h 1.13 vs 1.14 =====
> --- 1.13/drivers/video/sis/sis_main.h	Tue Jul  8 23:11:14 2003
> +++ 1.14/drivers/video/sis/sis_main.h	Sun Sep 14 00:54:38 2003
> @@ -287,7 +287,7 @@
>  /* ------------------- Global Variables ----------------------------- */
>  
>  /* Fbcon variables */
> -static struct fb_info sis_fb_info;
> +static struct fb_info *sis_fb_info;
>  
>  static struct fb_var_screeninfo default_var = {
>  	.xres            = 0,
> @@ -352,6 +352,7 @@
>  
>  static int sisfb_inverse = 0;
>  static int currcon = 0;
> +static char sisfb_fontname[40];
>  #endif
>  
>  /* global flags */
> @@ -995,6 +996,10 @@
>  /* Interface used by the world */
>  #ifndef MODULE
>  int             sisfb_setup(char *options);
> +#endif
> +
> +#if defined(MODULE) || LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)
> +static void release_sisfb(struct fb_info *info);
>  #endif
>  
>  /* Interface to the low level console driver */
> 
> 
> 
> Luca


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
