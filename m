From: James Simmons <jsimmons@infradead.org>
Subject: FrameMasterII fbdev updates.
Date: Wed, 18 Feb 2004 18:28:00 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402181823110.10389-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtWVN-0004GA-86
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:33:05 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AtWJJ-0002tj-7B
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 18 Feb 2004 10:20:37 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi!

  Can you test this patch. It is a port of the driver to use sysfs. 

--- linus-2.6/drivers/video/fm2fb.c	2004-02-16 23:36:11.000000000 -0800
+++ fbdev-2.6/drivers/video/fm2fb.c	2004-02-17 18:20:24.000000000 -0800
@@ -127,11 +127,6 @@
 
 static volatile unsigned char *fm2fb_reg;
 
-#define arraysize(x)	(sizeof(x)/sizeof(*(x)))
-
-static struct fb_info fb_info;
-static u32 pseudo_palette[17];
-
 static struct fb_fix_screeninfo fb_fix __initdata = {
 	.smem_len =	FRAMEMASTER_REG,
 	.type =		FB_TYPE_PACKED_PIXELS,
@@ -202,7 +197,7 @@
 static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                          u_int transp, struct fb_info *info)
 {
-	if (regno > 15)
+	if (regno > 255)
 		return 1;
 	red >>= 8;
 	green >>= 8;
@@ -216,66 +211,91 @@
      *  Initialisation
      */
 
-int __init fm2fb_init(void)
+static struct zorro_device_id fm2fb_devices[] = {
+	{ ZORRO_PROD_BSC_FRAMEMASTER_II, NULL },
+	{ ZORRO_PROD_HELFRICH_RAINBOW_II, NULL },
+	{ 0, 0 }
+};	
+
+static struct zorro_driver fm2fb_driver = {
+	.name		= "fm2fb",
+	.id_table	= fm2fb_devices,
+	.probe		= fm2fb_probe,
+};	
+
+static int __devint fm2fb_probe(struct zorro_dev *dev,
+				const struct zorro_device_id *id)
 {
-	struct zorro_dev *z = NULL;
+	struct fb_info *info;
 	unsigned long *ptr;
 	int is_fm;
 	int x, y;
 
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		if (z->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
-			is_fm = 1;
-		else if (z->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
-			is_fm = 0;
-		else
-			continue;
+	if (id->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
+		is_fm = 1;
+	else if (id->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
+		is_fm = 0;
 		
-		if (!request_mem_region(z->resource.start, FRAMEMASTER_SIZE, "fm2fb"))
-			continue;
+	if (!zorro_request_device(z,"fm2fb"))
+		return -ENXIO;
 
-		/* assigning memory to kernel space */
-		fb_fix.smem_start = z->resource.start;
-		fb_info.screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
-		fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
-		fm2fb_reg  = (unsigned char *)(fb_info.screen_base+FRAMEMASTER_REG);
+	info = framebuffer_alloc(256 * sizeof(u32), &dev->dev);	
+	if (!info) {
+		zorro_release_dev(z);
+		return -ENOMEM;
+	}
+		
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		framebuffer_release(info);
+		zorro_release_dev(z);
+		return -ENOMEM;
+	}	
 	
-		strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
-
-		/* make EBU color bars on display */
-		ptr = (unsigned long *)fb_fix.smem_start;
-		for (y = 0; y < 576; y++) {
-			for (x = 0; x < 96; x++) *ptr++ = 0xffffff;/* white */
-			for (x = 0; x < 96; x++) *ptr++ = 0xffff00;/* yellow */
-			for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;/* cyan */
-			for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;/* green */
-			for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;/* magenta */
-			for (x = 0; x < 96; x++) *ptr++ = 0xff0000;/* red */
-			for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;/* blue */
-			for (x = 0; x < 96; x++) *ptr++ = 0x000000;/* black */
-		}
-		fm2fb_blank(0, NULL);
-
-		if (fm2fb_mode == -1)
-			fm2fb_mode = FM2FB_MODE_PAL;
-
-		fb_info.fbops = &fm2fb_ops;
-		fb_info.var = fb_var_modes[fm2fb_mode];
-		fb_info.screen_base = (char *)fb_fix.smem_start;
-		fb_info.pseudo_palette = pseudo_palette;
-		fb_info.fix = fb_fix;
-		fb_info.flags = FBINFO_FLAG_DEFAULT;
+	/* assigning memory to kernel space */
+	fb_fix.smem_start = zorro_resource_start(z);
+	info->screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
+	fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
+	fm2fb_reg  = (unsigned char *)(info->screen_base+FRAMEMASTER_REG);
+	
+	strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
 
-		/* The below fields will go away !!!! */
-		fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	/* make EBU color bars on display */
+	ptr = (unsigned long *)fb_fix.smem_start;
+	for (y = 0; y < 576; y++) {
+		for (x = 0; x < 96; x++) *ptr++ = 0xffffff;/* white */
+		for (x = 0; x < 96; x++) *ptr++ = 0xffff00;/* yellow */
+		for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;/* cyan */
+		for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;/* green */
+		for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;/* magenta */
+		for (x = 0; x < 96; x++) *ptr++ = 0xff0000;/* red */
+		for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;/* blue */
+		for (x = 0; x < 96; x++) *ptr++ = 0x000000;/* black */
+	}
+	fm2fb_blank(0, info);
 
-		if (register_framebuffer(&fb_info) < 0)
-			return -EINVAL;
+	if (fm2fb_mode == -1)
+		fm2fb_mode = FM2FB_MODE_PAL;
 
-		printk("fb%d: %s frame buffer device\n", fb_info.node, fb_fix.id);
-		return 0;
+	info->fbops = &fm2fb_ops;
+	info->var = fb_var_modes[fm2fb_mode];
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+	info->fix = fb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (register_framebuffer(info) < 0) {
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
+		zorro_release_dev(z);
+		return -EINVAL;
 	}
-	return -ENXIO;
+	printk("fb%d: %s frame buffer device\n", info->node, fb_fix.id);
+	return 0;
+}
+
+static int __init fm2fb_init(void)
+{
+	return zorro_register_driver(&fm2fb_driver);
 }
 
 int __init fm2fb_setup(char *options)



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
