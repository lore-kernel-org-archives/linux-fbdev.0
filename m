From: Kronos <kronos@kronoz.cjb.net>
Subject: [PATCH] fm2fb: New framebuffer_alloc API and class_dev changes
Date: Mon, 15 Sep 2003 21:53:28 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915195328.GL16370@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yzQS-0004p9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 12:54:20 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yzQS-0005Cg-0g
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 12:54:20 -0700
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
To: geert@linux-m68k.org
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>


Hi,
this patch converts driver/video/fm2fb.c to framebuffer_alloc:

======== drivers/video/fm2fb.c 1.25 ========
D 1.25 03/09/13 23:32:08+02:00 kronos@kronoz.cjb.net 27 26 21/12/285
P drivers/video/fm2fb.c
C switch to framebuffer_alloc
------------------------------------------------

===== drivers/video/fm2fb.c 1.24 vs 1.25 =====
--- 1.24/drivers/video/fm2fb.c	Thu Apr 24 12:30:41 2003
+++ 1.25/drivers/video/fm2fb.c	Sat Sep 13 23:32:08 2003
@@ -129,7 +129,7 @@
 
 #define arraysize(x)	(sizeof(x)/sizeof(*(x)))
 
-static struct fb_info fb_info;
+static struct fb_info *fb_info;
 static u32 pseudo_palette[17];
 
 static struct fb_fix_screeninfo fb_fix __initdata = {
@@ -234,11 +234,17 @@
 		if (!request_mem_region(z->resource.start, FRAMEMASTER_SIZE, "fm2fb"))
 			continue;
 
+		fb_info = framebuffer_alloc(0, NULL);
+		if (!fb_info) {
+			release_mem_region(z->resource.start, FRAMEMASTER_SIZE);
+			return -ENOMEM;
+		}
+
 		/* assigning memory to kernel space */
 		fb_fix.smem_start = z->resource.start;
-		fb_info.screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
+		fb_info->screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
 		fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
-		fm2fb_reg  = (unsigned char *)(fb_info.screen_base+FRAMEMASTER_REG);
+		fm2fb_reg  = (unsigned char *)(fb_info->screen_base+FRAMEMASTER_REG);
 	
 		strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
 
@@ -259,20 +265,23 @@
 		if (fm2fb_mode == -1)
 			fm2fb_mode = FM2FB_MODE_PAL;
 
-		fb_info.fbops = &fm2fb_ops;
-		fb_info.var = fb_var_modes[fm2fb_mode];
-		fb_info.screen_base = (char *)fb_fix.smem_start;
-		fb_info.pseudo_palette = pseudo_palette;
-		fb_info.fix = fb_fix;
-		fb_info.flags = FBINFO_FLAG_DEFAULT;
+		fb_info->fbops = &fm2fb_ops;
+		fb_info->var = fb_var_modes[fm2fb_mode];
+		fb_info->screen_base = (char *)fb_fix.smem_start;
+		fb_info->pseudo_palette = pseudo_palette;
+		fb_info->fix = fb_fix;
+		fb_info->flags = FBINFO_FLAG_DEFAULT;
 
 		/* The below fields will go away !!!! */
-		fb_alloc_cmap(&fb_info.cmap, 16, 0);
+		fb_alloc_cmap(&fb_info->cmap, 16, 0);
 
-		if (register_framebuffer(&fb_info) < 0)
+		if (register_framebuffer(fb_info) < 0) {
+			release_mem_region(z->resource.start, FRAMEMASTER_SIZE);
+			kfree(fb_info);
 			return -EINVAL;
+		}
 
-		printk("fb%d: %s frame buffer device\n", fb_info.node, fb_fix.id);
+		printk("fb%d: %s frame buffer device\n", fb_info->node, fb_fix.id);
 		return 0;
 	}
 	return -ENXIO;

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
