From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] chipsfb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:43:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915194313.GH16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzGT-00047Z-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:44:01 -0700
Received: from mail-4.tiscali.it ([195.130.225.150])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzGS-0005Ep-AM
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:44:00 -0700
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
this patch converts driver/video/chipsfb.c to framebuffer_alloc:

======== drivers/video/chipsfb.c 1.23 ========
D 1.23 03/09/13 23:14:02+02:00 kronos@kronoz.cjb.net 26 25 37/14/503
P drivers/video/chipsfb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/chipsfb.c 1.22 vs 1.23 =====
--- 1.22/drivers/video/chipsfb.c	Mon Aug 18 06:52:28 2003
+++ 1.23/drivers/video/chipsfb.c	Sat Sep 13 23:14:02 2003
@@ -42,7 +42,7 @@
  * Since we access the display with inb/outb to fixed port numbers,
  * we can only handle one 6555x chip.  -- paulus
  */
-static struct fb_info chipsfb_info;
+static struct fb_info *chipsfb_info;
 
 #define write_ind(num, val, ap, dp)	do { \
 	outb((num), (ap)); outb((val), (dp)); \
@@ -95,6 +95,8 @@
 			     u_int transp, struct fb_info *info);
 static int chipsfb_blank(int blank, struct fb_info *info);
 
+static void release_chipsfb(struct fb_info *p);
+
 static struct fb_ops chipsfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= chipsfb_check_var,
@@ -354,7 +356,7 @@
 	.vsync_len = 8,
 };
 
-static void __init init_chips(struct fb_info *p, unsigned long addr)
+static int __init init_chips(struct fb_info *p, unsigned long addr)
 {
 	p->fix = chipsfb_fix;
 	p->fix.smem_start = addr;
@@ -366,21 +368,24 @@
 
 	fb_alloc_cmap(&p->cmap, 256, 0);
 
+	chipsfb_info = p;
 	if (register_framebuffer(p) < 0) {
 		printk(KERN_ERR "C&T 65550 framebuffer failed to register\n");
-		return;
+		return -1;
 	}
 
 	printk(KERN_INFO "fb%d: Chips 65550 frame buffer (%dK RAM detected)\n",
 		p->node, p->fix.smem_len / 1024);
 
 	chips_hw_init();
+
+	return 0;
 }
 
 static int __devinit
 chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
-	struct fb_info *p = &chipsfb_info;
+	struct fb_info *p;
 	unsigned long addr, size;
 	unsigned short cmd;
 
@@ -390,11 +395,14 @@
 	size = pci_resource_len(dp, 0);
 	if (addr == 0)
 		return -ENODEV;
-	if (p->screen_base != 0)
-		return -EBUSY;
 	if (!request_mem_region(addr, size, "chipsfb"))
 		return -EBUSY;
 
+	p = framebuffer_alloc(0, &dp->dev);
+	if (!p)
+		return -ENOMEM;
+	p->release = &release_chipsfb;
+
 #ifdef __BIG_ENDIAN
 	addr += 0x800000;	// Use big-endian aperture
 #endif
@@ -413,11 +421,18 @@
 
 	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
 	if (p->screen_base == NULL) {
+		kfree(p);
 		release_mem_region(addr, size);
 		return -ENOMEM;
 	}
 
-	init_chips(p, addr);
+	if (init_chips(p, addr)) {
+		iounmap(p->screen_base);
+		release_mem_region(addr, size);
+		kfree(p);
+
+		return -ENODEV;
+	}
 
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&chips_sleep_notifier);
@@ -430,20 +445,28 @@
 	return 0;
 }
 
+static void release_chipsfb(struct fb_info *p)
+{
+	struct pci_dev *dp = to_pci_dev(p->class_dev.dev);
+	
+#ifdef CONFIG_PMAC_PBOOK
+	pmu_unregister_sleep_notifier(&chips_sleep_notifier);
+#endif /* CONFIG_PMAC_PBOOK */
+
+	chipsfb_info = NULL;
+	iounmap(p->screen_base);
+	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
+}
+
 static void __devexit chipsfb_remove(struct pci_dev *dp)
 {
 	struct fb_info *p = pci_get_drvdata(dp);
 
-	if (p != &chipsfb_info || p->screen_base == NULL)
+	if (p != chipsfb_info || p->screen_base == NULL)
 		return;
 	unregister_framebuffer(p);
-	iounmap(p->screen_base);
-	p->screen_base = NULL;
-	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
 
-#ifdef CONFIG_PMAC_PBOOK
-	pmu_unregister_sleep_notifier(&chips_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
+	pci_set_drvdata(dp, NULL);
 }
 
 static struct pci_device_id chipsfb_pci_tbl[] = {


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"L'abilita` politica e` l'abilita` di prevedere quello che
 accadra` domani, la prossima settimana, il prossimo mese e
 l'anno prossimo. E di essere cosi` abili, piu` tardi,
 da spiegare  perche' non e` accaduto."


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
