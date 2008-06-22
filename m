From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 2/5] SM501: Restructure init to allow
	only 1 fb on an SM501
Date: Sun, 22 Jun 2008 22:04:41 +0100
Message-ID: <20080622210614.414283871@fluff.org.uk>
References: <20080622210439.018928412@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAWld-0002yH-KH for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KAWlb-00018I-0s
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-onefb.patch
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
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>

Add the ability to register only one of the two possible
main framebuffer devices on the SM501 by passing platform
data for only the framebuffer that you are interested in
having.

As a side note, we update the init sequence to commonise
the code that is executed twice, and fix a pair of missing
frees that we didn't do on framebuffer exit, such as freeing
the fb's cmap.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc6-quilt1/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.26-rc6-quilt1.orig/drivers/video/sm501fb.c	2008-06-18 19:02:14.000000000 +0100
+++ linux-2.6.26-rc6-quilt1/drivers/video/sm501fb.c	2008-06-18 19:48:01.000000000 +0100
@@ -143,6 +143,8 @@ static int sm501_alloc_mem(struct sm501f
 			   unsigned int why, size_t size)
 {
 	unsigned int ptr = 0;
+	unsigned int end;
+	struct fb_info *fbi;
 
 	switch (why) {
 	case SM501_MEMF_CURSOR:
@@ -152,7 +154,9 @@ static int sm501_alloc_mem(struct sm501f
 
 	case SM501_MEMF_PANEL:
 		ptr = inf->fbmem_len - size;
-		if (ptr < inf->fb[0]->fix.smem_len)
+		fbi = inf->fb[0];
+
+		if (fbi && ptr < fbi->fix.smem_len)
 			return -ENOMEM;
 
 		break;
@@ -162,11 +166,18 @@ static int sm501_alloc_mem(struct sm501f
 		break;
 
 	case SM501_MEMF_ACCEL:
-		ptr = inf->fb[0]->fix.smem_len;
+		fbi = inf->fb[0];
+		ptr = fbi ? fbi->fix.smem_len : 0;
+
+		fbi = inf->fb[1];
+		if (fbi)
+			end = (fbi->fix.smem_start - inf->fbmem_res->start);
+		else
+			end = inf->fbmem_len;
 
-		if ((ptr + size) >
-		    (inf->fb[1]->fix.smem_start - inf->fbmem_res->start))
+		if ((ptr + size) > end)
 			return -ENOMEM;
+
 		break;
 
 	default:
@@ -1228,39 +1239,6 @@ static struct fb_ops sm501fb_ops_pnl = {
 	.fb_imageblit	= cfb_imageblit,
 };
 
-/* sm501fb_info_alloc
- *
- * creates and initialises an sm501fb_info structure
-*/
-
-static struct sm501fb_info *sm501fb_info_alloc(struct fb_info *fbinfo_crt,
-					       struct fb_info *fbinfo_pnl)
-{
-	struct sm501fb_info *info;
-	struct sm501fb_par  *par;
-
-	info = kzalloc(sizeof(struct sm501fb_info), GFP_KERNEL);
-	if (info) {
-		/* set the references back */
-
-		par = fbinfo_crt->par;
-		par->info = info;
-		par->head = HEAD_CRT;
-		fbinfo_crt->pseudo_palette = &par->pseudo_palette;
-
-		par = fbinfo_pnl->par;
-		par->info = info;
-		par->head = HEAD_PANEL;
-		fbinfo_pnl->pseudo_palette = &par->pseudo_palette;
-
-		/* store the two fbs into our info */
-		info->fb[HEAD_CRT] = fbinfo_crt;
-		info->fb[HEAD_PANEL] = fbinfo_pnl;
-	}
-
-	return info;
-}
-
 /* sm501_init_cursor
  *
  * initialise hw cursor parameters
@@ -1268,10 +1246,16 @@ static struct sm501fb_info *sm501fb_info
 
 static int sm501_init_cursor(struct fb_info *fbi, unsigned int reg_base)
 {
-	struct sm501fb_par *par = fbi->par;
-	struct sm501fb_info *info = par->info;
+	struct sm501fb_par *par;
+	struct sm501fb_info *info;
 	int ret;
 
+	if (fbi == NULL)
+		return 0;
+
+	par = fbi->par;
+	info = par->info;
+
 	par->cursor_regs = info->regs + reg_base;
 
 	ret = sm501_alloc_mem(info, &par->cursor, SM501_MEMF_CURSOR, 1024);
@@ -1299,13 +1283,10 @@ static int sm501fb_start(struct sm501fb_
 			 struct platform_device *pdev)
 {
 	struct resource	*res;
-	struct device *dev;
+	struct device *dev = &pdev->dev;
 	int k;
 	int ret;
 
-	info->dev = dev = &pdev->dev;
-	platform_set_drvdata(pdev, info);
-
 	info->irq = ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
 		/* we currently do not use the IRQ */
@@ -1408,11 +1389,6 @@ static void sm501fb_stop(struct sm501fb_
 	kfree(info->regs_res);
 }
 
-static void sm501fb_info_release(struct sm501fb_info *info)
-{
-	kfree(info);
-}
-
 static int sm501fb_init_fb(struct fb_info *fb,
 			   enum sm501_controller head,
 			   const char *fbname)
@@ -1557,36 +1533,93 @@ static struct sm501_platdata_fb sm501fb_
 static char driver_name_crt[] = "sm501fb-crt";
 static char driver_name_pnl[] = "sm501fb-panel";
 
-static int __init sm501fb_probe(struct platform_device *pdev)
+static int __devinit sm501fb_probe_one(struct sm501fb_info *info,
+				       enum sm501_controller head)
 {
-	struct sm501fb_info *info;
-	struct device	    *dev = &pdev->dev;
-	struct fb_info	    *fbinfo_crt;
-	struct fb_info	    *fbinfo_pnl;
-	int		     ret;
+	unsigned char *name = (head == HEAD_CRT) ? "crt" : "panel";
+	struct sm501_platdata_fbsub *pd;
+	struct sm501fb_par *par;
+	struct fb_info *fbi;
 
-	/* allocate our framebuffers */
+	pd = (head == HEAD_CRT) ? info->pdata->fb_crt : info->pdata->fb_pnl;
+
+	/* Do not initialise if we've not been given any platform data */
+	if (pd == NULL) {
+		dev_info(info->dev, "no data for fb %s (disabled)\n", name);
+		return 0;
+	}
 
-	fbinfo_crt = framebuffer_alloc(sizeof(struct sm501fb_par), dev);
-	if (fbinfo_crt == NULL) {
-		dev_err(dev, "cannot allocate crt framebuffer\n");
+	fbi = framebuffer_alloc(sizeof(struct sm501fb_par), info->dev);
+	if (fbi == NULL) {
+		dev_err(info->dev, "cannot allocate %s framebuffer\n", name);
 		return -ENOMEM;
 	}
 
-	fbinfo_pnl = framebuffer_alloc(sizeof(struct sm501fb_par), dev);
-	if (fbinfo_pnl == NULL) {
-		dev_err(dev, "cannot allocate panel framebuffer\n");
-		ret = -ENOMEM;
-		goto fbinfo_crt_alloc_fail;
+	par = fbi->par;
+	par->info = info;
+	par->head = head;
+	fbi->pseudo_palette = &par->pseudo_palette;
+
+	info->fb[head] = fbi;
+
+	return 0;
+}
+
+/* Free up anything allocated by sm501fb_init_fb */
+
+static void sm501_free_init_fb(struct sm501fb_info *info,
+				enum sm501_controller head)
+{
+	struct fb_info *fbi = info->fb[head];
+
+	fb_dealloc_cmap(&fbi->cmap);
+}
+
+static int __devinit sm501fb_start_one(struct sm501fb_info *info,
+				       enum sm501_controller head,
+				       const char *drvname)
+{
+	struct fb_info *fbi = info->fb[head];
+	int ret;
+
+	if (!fbi)
+		return 0;
+
+	ret = sm501fb_init_fb(info->fb[head], head, drvname);
+	if (ret) {
+		dev_err(info->dev, "cannot initialise fb %s\n", drvname);
+		return ret;
+	}
+
+	ret = register_framebuffer(info->fb[head]);
+	if (ret) {
+		dev_err(info->dev, "failed to register fb %s\n", drvname);
+		sm501_free_init_fb(info, head);
+		return ret;
 	}
 
-	info = sm501fb_info_alloc(fbinfo_crt, fbinfo_pnl);
-	if (info == NULL) {
-		dev_err(dev, "cannot allocate par\n");
-		ret = -ENOMEM;
-		goto sm501fb_alloc_fail;
+	dev_info(info->dev, "fb%d: %s frame buffer\n", fbi->node, fbi->fix.id);
+
+	return 0;
+}
+
+static int __devinit sm501fb_probe(struct platform_device *pdev)
+{
+	struct sm501fb_info *info;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/* allocate our framebuffers */
+
+	info = kzalloc(sizeof(struct sm501fb_info), GFP_KERNEL);
+	if (!info) {
+		dev_err(dev, "failed to allocate state\n");
+		return -ENOMEM;
 	}
 
+	info->dev = dev = &pdev->dev;
+	platform_set_drvdata(pdev, info);
+
 	if (dev->parent->platform_data) {
 		struct sm501_platdata *pd = dev->parent->platform_data;
 		info->pdata = pd->fb;
@@ -1597,90 +1630,88 @@ static int __init sm501fb_probe(struct p
 		info->pdata = &sm501fb_def_pdata;
 	}
 
-	/* start the framebuffers */
+	/* probe for the presence of each panel */
 
-	ret = sm501fb_start(info, pdev);
-	if (ret) {
-		dev_err(dev, "cannot initialise SM501\n");
-		goto sm501fb_start_fail;
+	ret = sm501fb_probe_one(info, HEAD_CRT);
+	if (ret < 0) {
+		dev_err(dev, "failed to probe CRT\n");
+		goto err_alloc;
 	}
 
-	/* CRT framebuffer setup */
+	ret = sm501fb_probe_one(info, HEAD_PANEL);
+	if (ret < 0) {
+		dev_err(dev, "failed to probe PANEL\n");
+		goto err_probed_crt;
+	}
 
-	ret = sm501fb_init_fb(fbinfo_crt, HEAD_CRT, driver_name_crt);
-	if (ret) {
-		dev_err(dev, "cannot initialise CRT fb\n");
-		goto sm501fb_start_fail;
+	if (info->fb[HEAD_PANEL] == NULL &&
+	    info->fb[HEAD_CRT] == NULL) {
+		dev_err(dev, "no framebuffers found\n");
+		goto err_alloc;
 	}
 
-	/* Panel framebuffer setup */
+	/* get the resources for both of the framebuffers */
 
-	ret = sm501fb_init_fb(fbinfo_pnl, HEAD_PANEL, driver_name_pnl);
+	ret = sm501fb_start(info, pdev);
 	if (ret) {
-		dev_err(dev, "cannot initialise Panel fb\n");
-		goto sm501fb_start_fail;
+		dev_err(dev, "cannot initialise SM501\n");
+		goto err_probed_panel;
 	}
 
-	/* register framebuffers */
-
-	ret = register_framebuffer(fbinfo_crt);
-	if (ret < 0) {
-		dev_err(dev, "failed to register CRT fb (%d)\n", ret);
-		goto register_crt_fail;
+	ret = sm501fb_start_one(info, HEAD_CRT, driver_name_crt);
+	if (ret) {
+		dev_err(dev, "failed to start CRT\n");
+		goto err_started;
 	}
 
-	ret = register_framebuffer(fbinfo_pnl);
-	if (ret < 0) {
-		dev_err(dev, "failed to register panel fb (%d)\n", ret);
-		goto register_pnl_fail;
+	ret = sm501fb_start_one(info, HEAD_PANEL, driver_name_pnl);
+	if (ret) {
+		dev_err(dev, "failed to start Panel\n");
+		goto err_started_crt;
 	}
 
-	dev_info(dev, "fb%d: %s frame buffer device\n",
-		 fbinfo_crt->node, fbinfo_crt->fix.id);
-
-	dev_info(dev, "fb%d: %s frame buffer device\n",
-	       fbinfo_pnl->node, fbinfo_pnl->fix.id);
-
 	/* create device files */
 
 	ret = device_create_file(dev, &dev_attr_crt_src);
 	if (ret)
-		goto crtsrc_fail;
+		goto err_started_panel;
 
 	ret = device_create_file(dev, &dev_attr_fbregs_pnl);
 	if (ret)
-		goto fbregs_pnl_fail;
+		goto err_attached_crtsrc_file;
 
 	ret = device_create_file(dev, &dev_attr_fbregs_crt);
 	if (ret)
-		goto fbregs_crt_fail;
+		goto err_attached_pnlregs_file;
 
 	/* we registered, return ok */
 	return 0;
 
- fbregs_crt_fail:
+err_attached_pnlregs_file:
 	device_remove_file(dev, &dev_attr_fbregs_pnl);
 
- fbregs_pnl_fail:
+err_attached_crtsrc_file:
 	device_remove_file(dev, &dev_attr_crt_src);
 
- crtsrc_fail:
-	unregister_framebuffer(fbinfo_pnl);
-
- register_pnl_fail:
-	unregister_framebuffer(fbinfo_crt);
+err_started_panel:
+	unregister_framebuffer(info->fb[HEAD_PANEL]);
+	sm501_free_init_fb(info, HEAD_PANEL);
+
+err_started_crt:
+	unregister_framebuffer(info->fb[HEAD_CRT]);
+	sm501_free_init_fb(info, HEAD_CRT);
 
- register_crt_fail:
+err_started:
 	sm501fb_stop(info);
 
- sm501fb_start_fail:
-	sm501fb_info_release(info);
+err_probed_panel:
+	framebuffer_release(info->fb[HEAD_PANEL]);
 
- sm501fb_alloc_fail:
-	framebuffer_release(fbinfo_pnl);
+err_probed_crt:
+	framebuffer_release(info->fb[HEAD_CRT]);
 
- fbinfo_crt_alloc_fail:
-	framebuffer_release(fbinfo_crt);
+err_alloc:
+	kfree(info);
 
 	return ret;
 }
@@ -1699,11 +1730,14 @@ static int sm501fb_remove(struct platfor
 	device_remove_file(&pdev->dev, &dev_attr_fbregs_pnl);
 	device_remove_file(&pdev->dev, &dev_attr_crt_src);
 
+	sm501_free_init_fb(info, HEAD_CRT);
+	sm501_free_init_fb(info, HEAD_PANEL);
+
 	unregister_framebuffer(fbinfo_crt);
 	unregister_framebuffer(fbinfo_pnl);
 
 	sm501fb_stop(info);
-	sm501fb_info_release(info);
+	kfree(info);
 
 	framebuffer_release(fbinfo_pnl);
 	framebuffer_release(fbinfo_crt);

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
