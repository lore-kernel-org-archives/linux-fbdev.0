From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 3/8] tridentfb: move global pseudo
	palette into structure
Date: Mon, 5 May 2008 18:53:58 +0200
Message-ID: <20080505185358.11a09a54.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jt3x1-0007IY-AA for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:54:07 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jt3wz-0005Iv-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 May 2008 09:54:07 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: adaplas@pol.net, akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch moves pseudo palette int tridentfb_par
structure and removes global default_var.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-old/drivers/video/tridentfb.c linux-pc/drivers/video/tridentfb.c
--- linux-old/drivers/video/tridentfb.c	2008-05-02 13:23:42.000000000 +0200
+++ linux-pc/drivers/video/tridentfb.c	2008-05-02 13:27:02.000000000 +0200
@@ -28,16 +28,12 @@
 
 struct tridentfb_par {
 	void __iomem *io_virt;	/* iospace virtual memory address */
+	u32 pseudo_pal[16];
 };
 
 static unsigned char eng_oper;	/* engine operation... */
 static struct fb_ops tridentfb_ops;
 
-/* FIXME:kmalloc these 3 instead */
-static u32 pseudo_pal[16];
-
-static struct fb_var_screeninfo default_var;
-
 static struct fb_fix_screeninfo tridentfb_fix = {
 	.id = "Trident",
 	.type = FB_TYPE_PACKED_PIXELS,
@@ -1340,9 +1336,7 @@ static int __devinit trident_pci_probe(s
 #ifdef CONFIG_FB_TRIDENT_ACCEL
 	info->flags |= FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT;
 #endif
-	info->pseudo_palette = pseudo_pal;
-
-	if (!fb_find_mode(&default_var, info,
+	if (!fb_find_mode(&info->var, info,
 			  mode_option, NULL, 0, NULL, bpp)) {
 		err = -EINVAL;
 		goto out_unmap2;
@@ -1352,11 +1346,10 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap2;
 
 	if (defaultaccel && acc)
-		default_var.accel_flags |= FB_ACCELF_TEXT;
+		info->var.accel_flags |= FB_ACCELF_TEXT;
 	else
-		default_var.accel_flags &= ~FB_ACCELF_TEXT;
-	default_var.activate |= FB_ACTIVATE_NOW;
-	info->var = default_var;
+		info->var.accel_flags &= ~FB_ACCELF_TEXT;
+	info->var.activate |= FB_ACTIVATE_NOW;
 	info->device = &dev->dev;
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
@@ -1365,8 +1358,8 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap2;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
-	   info->node, info->fix.id, default_var.xres,
-	   default_var.yres, default_var.bits_per_pixel);
+	   info->node, info->fix.id, info->var.xres,
+	   info->var.yres, info->var.bits_per_pixel);
 
 	pci_set_drvdata(dev, info);
 	return 0;

----------------------------------------------------------------------
Andrzej Piaseczny w roli kucharza? Zobacz!
http://link.interia.pl/f1dcb


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
