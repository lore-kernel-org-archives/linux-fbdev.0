From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1 try#2] [VIDEO/FRAMEBUFFER]: add
 BF52x EZkit Display driver
Date: Wed, 5 Mar 2008 23:02:23 -0800
Message-ID: <20080305230223.920765e9.akpm@linux-foundation.org>
References: <1201686800-31739-1-git-send-email-bryan.wu@analog.com>
	<20080130083820.c1bcbc14.randy.dunlap@oracle.com>
	<1201711783.6463.11.camel@roc-laptop>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXA7d-0002l8-TA for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 23:02:33 -0800
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JXA7c-0004Zd-EH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Mar 2008 23:02:33 -0800
In-Reply-To: <1201711783.6463.11.camel@roc-laptop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: Bryan Wu <bryan.wu@analog.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org

On Thu, 31 Jan 2008 00:49:43 +0800 Bryan Wu <bryan.wu@analog.com> wrote:
>

bah, January.

I'm trolling the fbdev list only now - I guess I'll slip this one into
2.6.25.

> +static int bfin_t350mcqb_request_ports(int action)
> +{
> +	u16 ppi0_req_8[] = {P_PPI0_CLK, P_PPI0_FS1, P_PPI0_FS2,
> +			    P_PPI0_D0, P_PPI0_D1, P_PPI0_D2,
> +			    P_PPI0_D3, P_PPI0_D4, P_PPI0_D5,
> +			    P_PPI0_D6, P_PPI0_D7, 0};

This array will be assembled on the stack at runtime.  If
peripheral_request_list() doesn't alter it then it would be better to
create it at compile-time by adding `static'.

> +	if (action) {
> +		if (peripheral_request_list(ppi0_req_8, DRIVER_NAME)) {
> +			printk(KERN_ERR "Requesting Peripherals faild\n");
> +			return -EFAULT;
> +		}
> +	} else
> +		peripheral_free_list(ppi0_req_8);
> +
> +	return 0;
> +}
> +
> +static int bfin_t350mcqb_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
> +{
> +	struct bfin_t350mcqbfb_info *fbi = info->par;
> +
> +	if (fbi->lq043_mmap)
> +		return -1;
> +
> +	spin_lock(&fbi->lock);
> +	fbi->lq043_mmap = 1;
> +	spin_unlock(&fbi->lock);

the locking here probably doesn't do a lot.

> +	vma->vm_start = (unsigned long)(fbi->fb_buffer + ACTIVE_VIDEO_MEM_OFFSET);
> +
> +	vma->vm_end = vma->vm_start + info->fix.smem_len;
> +	/* For those who don't understand how mmap works, go read
> +	 *   Documentation/nommu-mmap.txt.
> +	 * For those that do, you will know that the VM_MAYSHARE flag
> +	 * must be set in the vma->vm_flags structure on noMMU
> +	 *   Other flags can be set, and are documented in
> +	 *   include/linux/mm.h
> +	 */
> +	vma->vm_flags |= VM_MAYSHARE;
> +
> +	return 0;
> +}
> +
> +
> +static int __init bfin_t350mcqb_probe(struct platform_device *pdev)
> +{
> +	struct bfin_t350mcqbfb_info *info;
> +	struct fb_info *fbinfo;
> +	int ret;
> +
> +	printk(KERN_INFO DRIVER_NAME ": %dx%d %d-bit RGB FrameBuffer initializing...\n",
> +					 LCD_X_RES, LCD_Y_RES, LCD_BPP);
> +
> +	if (request_dma(CH_PPI, "CH_PPI") < 0) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": couldn't request CH_PPI DMA\n");
> +		ret = -EFAULT;
> +		goto out1;
> +	}
> +
> +	fbinfo =
> +	    framebuffer_alloc(sizeof(struct bfin_t350mcqbfb_info), &pdev->dev);
> +	if (!fbinfo) {
> +		ret = -ENOMEM;
> +		goto out2;
> +	}
> +
> +	info = fbinfo->par;
> +	info->fb = fbinfo;
> +	info->dev = &pdev->dev;
> +
> +	platform_set_drvdata(pdev, fbinfo);
> +
> +	strcpy(fbinfo->fix.id, driver_name);
> +
> +	fbinfo->fix.type = FB_TYPE_PACKED_PIXELS;
> +	fbinfo->fix.type_aux = 0;
> +	fbinfo->fix.xpanstep = 0;
> +	fbinfo->fix.ypanstep = 0;
> +	fbinfo->fix.ywrapstep = 0;
> +	fbinfo->fix.accel = FB_ACCEL_NONE;
> +	fbinfo->fix.visual = FB_VISUAL_TRUECOLOR;
> +
> +	fbinfo->var.nonstd = 0;
> +	fbinfo->var.activate = FB_ACTIVATE_NOW;
> +	fbinfo->var.height = -1;
> +	fbinfo->var.width = -1;
> +	fbinfo->var.accel_flags = 0;
> +	fbinfo->var.vmode = FB_VMODE_NONINTERLACED;
> +
> +	fbinfo->var.xres = LCD_X_RES;
> +	fbinfo->var.xres_virtual = LCD_X_RES;
> +	fbinfo->var.yres = LCD_Y_RES;
> +	fbinfo->var.yres_virtual = LCD_Y_RES;
> +	fbinfo->var.bits_per_pixel = LCD_BPP;
> +
> +	fbinfo->var.red.offset = 0;
> +	fbinfo->var.green.offset = 8;
> +	fbinfo->var.blue.offset = 16;
> +	fbinfo->var.transp.offset = 0;
> +	fbinfo->var.red.length = 8;
> +	fbinfo->var.green.length = 8;
> +	fbinfo->var.blue.length = 8;
> +	fbinfo->var.transp.length = 0;
> +	fbinfo->fix.smem_len = LCD_X_RES * LCD_Y_RES * LCD_BPP / 8;
> +
> +	fbinfo->fix.line_length = fbinfo->var.xres_virtual *
> +	    fbinfo->var.bits_per_pixel / 8;
> +
> +
> +	fbinfo->fbops = &bfin_t350mcqb_fb_ops;
> +	fbinfo->flags = FBINFO_FLAG_DEFAULT;
> +
> +	info->fb_buffer =
> +	    dma_alloc_coherent(NULL, fbinfo->fix.smem_len, &info->dma_handle,
> +			       GFP_KERNEL);
> +
> +	if (NULL == info->fb_buffer) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": couldn't allocate dma buffer.\n");
> +		ret = -ENOMEM;
> +		goto out3;
> +	}
> +
> +	memset(info->fb_buffer, 0, fbinfo->fix.smem_len);
> +
> +	fbinfo->screen_base = (void *)info->fb_buffer + ACTIVE_VIDEO_MEM_OFFSET;
> +	fbinfo->fix.smem_start = (int)info->fb_buffer + ACTIVE_VIDEO_MEM_OFFSET;
> +
> +	fbinfo->fbops = &bfin_t350mcqb_fb_ops;
> +
> +	fbinfo->pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL);
> +	if (!fbinfo->pseudo_palette) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       "Fail to allocate pseudo_palette\n");
> +
> +		ret = -ENOMEM;
> +		goto out4;
> +	}
> +
> +	memset(fbinfo->pseudo_palette, 0, sizeof(u32) * 16);

You just invented kzalloc!

> +	if (fb_alloc_cmap(&fbinfo->cmap, BFIN_LCD_NBR_PALETTE_ENTRIES, 0)
> +	    < 0) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       "Fail to allocate colormap (%d entries)\n",
> +		       BFIN_LCD_NBR_PALETTE_ENTRIES);
> +		ret = -EFAULT;
> +		goto out5;
> +	}
> +
> +	if (bfin_t350mcqb_request_ports(1)) {
> +		printk(KERN_ERR DRIVER_NAME ": couldn't request gpio port.\n");
> +		ret = -EFAULT;
> +		goto out6;
> +	}
> +
> +	info->irq = platform_get_irq(pdev, 0);
> +	if (info->irq < 0) {
> +		ret = -EINVAL;
> +		goto out7;
> +	}
> +
> +	if (request_irq(info->irq, (void *)bfin_t350mcqb_irq_error, IRQF_DISABLED,
> +			"PPI ERROR", info) < 0) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": unable to request PPI ERROR IRQ\n");
> +		ret = -EFAULT;

EFAULT?

> +		goto out7;
> +	}
> +
> +	if (register_framebuffer(fbinfo) < 0) {
> +		printk(KERN_ERR DRIVER_NAME
> +		       ": unable to register framebuffer.\n");
> +		ret = -EINVAL;
> +		goto out8;
> +	}
> +#ifndef NO_BL_SUPPORT
> +	bl_dev =
> +	    backlight_device_register("bf52x-bl", NULL, NULL,
> +				      &bfin_lq043fb_bl_ops);
> +	bl_dev->props.max_brightness = 255;
> +
> +	lcd_dev = lcd_device_register(DRIVER_NAME, NULL, &bfin_lcd_ops);
> +	lcd_dev->props.max_contrast = 255, printk(KERN_INFO "Done.\n");
> +#endif
> +
> +	return 0;
> +
> +out8:
> +	free_irq(info->irq, info);
> +out7:
> +	bfin_t350mcqb_request_ports(0);
> +out6:
> +	fb_dealloc_cmap(&fbinfo->cmap);
> +out5:
> +	kfree(fbinfo->pseudo_palette);
> +out4:
> +	dma_free_coherent(NULL, fbinfo->fix.smem_len, info->fb_buffer,
> +			  info->dma_handle);
> +out3:
> +	framebuffer_release(fbinfo);
> +out2:
> +	free_dma(CH_PPI);
> +out1:
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return ret;
> +}
> +


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
