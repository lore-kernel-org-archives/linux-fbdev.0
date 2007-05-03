From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] Xilinx framebuffer device driver
	-	3d version
Date: Fri, 04 May 2007 03:57:12 +0800
Message-ID: <1178222232.28617.28.camel@daplas>
References: <463A1B58.8000804@ru.mvista.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjhQW-0004ea-Vb for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:57:21 -0700
Received: from wx-out-0506.google.com ([66.249.82.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjhQW-0007e6-He
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:57:20 -0700
Received: by wx-out-0506.google.com with SMTP id i30so1027644wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 May 2007 12:57:19 -0700 (PDT)
In-Reply-To: <463A1B58.8000804@ru.mvista.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-embedded@ozlabs.org

On Thu, 2007-05-03 at 21:26 +0400, Andrei Konovalov wrote:
> Add support for the video controller IP block included into Xilinx ML300
> and ML403 reference designs.
> 
> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
> 
> -----
> The driver has been tested with Xilinx ML300 and ML403 reference designs.
> 
> The two first version has been posted to linuxppc-embedded, and this
> version tries to address all the comments and criticism received.
> 
> The platform device registration for Xilinx ML300 and ML403
> moved into separate patch (will be posted to linuxppc-embedded
> in couple minutes).
> 
> Would be nice to get this driver into mainline for the 2.6.22.
> Reviews and comments are welcome.

It's hard to make comments when you submit patches as attachment, but
here goes.

+static int
+xilinx_fb_blank(int blank_mode, struct fb_info *fbi)
+{
+	struct xilinxfb_drvdata *drvdata = to_xilinxfb_drvdata(fbi);
+
+	switch (blank_mode) {
+	case VESA_NO_BLANKING:
+		/* turn on panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+		break;
+
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+	case VESA_POWERDOWN:
+		/* turn off panel */
+		xilinx_fb_out_be32(drvdata, REG_CTRL, 0);
+	default:
+		break;
+
+	}
+	return 0; /* success */
+}
+

Use the FB_BLANK_* constants defined in include/linux/fb.h instead of
the VESA_* constants.

+static int
+xilinx_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info
*fbi)
+{
+	if (var->xoffset != 0 || var->yoffset != 0)
+		return -EINVAL;
+
+	return 0;
+}
+

This silently succeeds.  If you don't have a pan_display() hook, might
as well remove it.

+static int
+xilinxfb_drv_probe(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct xilinxfb_platform_data *pdata;
+	struct xilinxfb_drvdata *drvdata;
+	struct resource *regs_res;
+	int retval;
+
+	if (!dev)
+		return -EINVAL;
+
+	pdev = to_platform_device(dev);
+	pdata = (struct xilinxfb_platform_data *)pdev->dev.platform_data;

Is the cast really needed?

+
+	if (pdata == NULL) {
+		printk(KERN_ERR "Couldn't find platform data.\n");
+		return -EFAULT;
+	}
+
+	drvdata = kzalloc(sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		printk(KERN_ERR "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	dev_set_drvdata(dev, (void *)drvdata);

Here also.

+
+	/* Map the control registers in */
+	regs_res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!regs_res || (regs_res->end - regs_res->start + 1 < 8)) {
+		printk(KERN_ERR "Couldn't get registers resource\n");
+		retval = -EFAULT;
+		goto failed1;
+	}
+
+	if (!request_mem_region(regs_res->start, 8, DRIVER_NAME)) {
+		printk(KERN_ERR
+		       "Couldn't lock memory region at 0x%08X\n",
+		       regs_res->start);
+		retval = -EBUSY;
+		goto failed1;
+	}
+	drvdata->regs = (u32 __iomem*) ioremap(regs_res->start, 8);
+	drvdata->regs_phys = regs_res->start;
+
+	/* Allocate the framebuffer memory */
+	drvdata->fb_virt = dma_alloc_coherent(dev, PAGE_ALIGN(FB_SIZE),
+				&drvdata->fb_phys, GFP_KERNEL);
+	if (!drvdata->fb_virt) {
+		printk(KERN_ERR "Could not allocate frame buffer memory\n");
+		retval = -ENOMEM;
+		goto failed2;
+	}
+
+	/* Clear (turn to black) the framebuffer */
+	memset((void *) drvdata->fb_virt, 0, FB_SIZE);

memset() or memset_io()?

+
+	/* Tell the hardware where the frame buffer is */
+	xilinx_fb_out_be32(drvdata, REG_FB_ADDR, drvdata->fb_phys);
+
+	/* Turn on the display */
+	if (pdata->rotate_screen) {
+		drvdata->reg_ctrl_default = REG_CTRL_ENABLE | REG_CTRL_ROTATE;
+	} else {
+		drvdata->reg_ctrl_default = REG_CTRL_ENABLE;
+	}
+	xilinx_fb_out_be32(drvdata, REG_CTRL, drvdata->reg_ctrl_default);
+
+	/* Fill struct fb_info */
+	drvdata->info.screen_base = drvdata->fb_virt;
+	drvdata->info.fbops = &xilinxfb_ops;
+	drvdata->info.fix = xilinx_fb_fix;
+	drvdata->info.fix.smem_start = drvdata->fb_phys;
+	drvdata->info.pseudo_palette = drvdata->pseudo_palette;

If you cannot use framebuffer_alloc()/release(), set
drvdata->info.device so your driver shows up in /sys/class/graphics.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
