From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] platinumfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 23:06:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915210641.GH23294@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0ZO-0002U4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 14:07:38 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0ZN-0001tJ-Sj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 14:07:38 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,
this patch converts driver/video/platinumfb.c to framebuffer_alloc:

======== drivers/video/platinumfb.c 1.24 ========
D 1.24 03/09/14 00:05:34+02:00 kronos@kronoz.cjb.net 27 26 26/20/673
P drivers/video/platinumfb.c
C switch framebuffer_alloc
------------------------------------------------

===== drivers/video/platinumfb.c 1.23 vs 1.24 =====
--- 1.23/drivers/video/platinumfb.c	Thu Sep  4 21:55:36 2003
+++ 1.24/drivers/video/platinumfb.c	Sun Sep 14 00:05:34 2003
@@ -51,7 +51,7 @@
 };
 
 struct fb_info_platinum {
-	struct fb_info			info;
+	struct fb_info			*info;
 	struct fb_par_platinum		par;
 
 	struct {
@@ -99,6 +99,7 @@
 static int platinum_var_to_par(const struct fb_var_screeninfo *var,
 			       struct fb_par_platinum *par,
 			       const struct fb_info_platinum *info);
+static void release_platinumfb(struct fb_info *info);
 
 /*
  * Interface used by the world
@@ -326,7 +327,7 @@
 static void __devinit platinum_init_info(struct fb_info *info, struct fb_info_platinum *p)
 {
 	/* Fill fb_info */
-	info->par = &p->par;
+	info->release = &release_platinumfb;
 	info->fbops = &platinumfb_ops;
 	info->pseudo_palette = p->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
@@ -394,22 +395,22 @@
 	}
 
 	/* Initialize info structure */
-	platinum_init_info(&p->info, p);
+	platinum_init_info(p->info, p);
 
 	/* Apply default var */
 	p->info.var = var;
 	var.activate = FB_ACTIVATE_NOW;
-	rc = fb_set_var(&p->info, &var);
+	rc = fb_set_var(p->info, &var);
 	if (rc && (default_vmode != VMODE_640_480_60 || default_cmode != CMODE_8))
 		goto try_again;
 
 	/* Register with fbdev layer */
-	rc = register_framebuffer(&p->info);
+	rc = register_framebuffer(p->info);
 	if (rc < 0)
 		return rc;
 
 	printk(KERN_INFO "fb%d: platinum frame buffer device\n",
-	       p->info.node);
+	       p->info->node);
 
 	return 0;
 }
@@ -537,6 +538,7 @@
 {
 	struct device_node	*dp = odev->node;
 	struct fb_info_platinum	*info;
+	struct fb_info		*fb_info;
 	unsigned long		addr, size;
 	volatile __u8		*fbuffer;
 	int			i, bank0, bank1, bank2, bank3, rc;
@@ -546,10 +548,11 @@
 		return -ENXIO;
 	}
 
-	info = kmalloc(sizeof(*info), GFP_ATOMIC);
-	if (info == 0)
+	fb_info = framebuffer_alloc(sizeof(*info), &odev->dev);
+	if (fb_info == 0)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
+	info = fb_info->par;
+	info->info = fb_info;
 
 	/* Map in frame buffer and registers */
 	for (i = 0; i < dp->n_addrs; ++i) {
@@ -557,7 +560,7 @@
 		size = dp->addrs[i].size;
 		/* Let's assume we can request either all or nothing */
 		if (!request_mem_region(addr, size, "platinumfb")) {
-			kfree(info);
+			kfree(fb_info);
 			return -ENXIO;
 		}
 		if (size >= 0x400000) {
@@ -620,24 +623,19 @@
 	rc = platinum_init_fb(info);
 	if (rc != 0) {
 		dev_set_drvdata(&odev->dev, NULL);
-		kfree(info);
+		kfree(fb_info);
 	}
 
 	return rc;
 }
 
-static int __devexit platinumfb_remove(struct of_device* odev)
-{
-	struct fb_info_platinum	*pinfo = dev_get_drvdata(&odev->dev);
+static void release_platinumfb(struct fb_info *info) {
+	struct fb_info_platinum *pinfo = info->par;
+	struct of_device *odev = to_of_device(info->class_dev.dev);
 	struct device_node *dp = odev->node;
 	unsigned long addr, size;
 	int i;
 	
-	if (!pinfo)
-		return 0;
-
-        unregister_framebuffer (&pinfo->info);
-	
 	/* Unmap frame buffer and registers */
 	for (i = 0; i < dp->n_addrs; ++i) {
 		addr = dp->addrs[i].address;
@@ -648,9 +646,17 @@
 	iounmap((void *)pinfo->platinum_regs);
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
 	iounmap((void *)pinfo->cmap_regs);
+}
 
-	kfree(pinfo);
+static int __devexit platinumfb_remove(struct of_device* odev)
+{
+	struct fb_info_platinum	*pinfo = dev_get_drvdata(&odev->dev);
+	
+	if (!pinfo)
+		return 0;
 
+        unregister_framebuffer (pinfo->info);
+	
 	return 0;
 }
 


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"I've seen things you people wouldn't believe...
 Attack Ships on fire off the shores of Orion.
 I've watched C-beams glitter in the dark off of Tanhauser Gate.
 All those moments will be lost in time...like tears, in rain.
 Time to die." -- Roy Batty (played by Rutger Hauer)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
