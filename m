From: Kronos <kronos@people.it>
Subject: Re: [PATCH][RFC][2/3] mode attribute in sysfs tree
Date: Wed, 16 Jun 2004 11:30:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616093032.GC3556@dreamland.darkstar.lan>
References: <20040615172138.GA8823@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWkY-0005W8-71
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:30:30 -0700
Received: from mail-relay-1.tiscali.it ([212.123.84.91])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWkX-000740-Hz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:30:29 -0700
Received: from dreamland.darkstar.lan (82.84.177.170) by mail-relay-1.tiscali.it (7.0.028)
        id 40CF307E0005DDC1 for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:30:21 +0200
Content-Disposition: inline
In-Reply-To: <20040615172138.GA8823@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

fb_show_mode function and FB_MODE_ATTR macro.

diff -Nru -X dontdiff linux-2.6-vanilla/drivers/video/fbsysfs.c linux-2.6/drivers/video/fbsysfs.c
--- linux-2.6-vanilla/drivers/video/fbsysfs.c	2004-02-28 13:32:58.000000000 +0100
+++ linux-2.6/drivers/video/fbsysfs.c	2004-06-14 17:34:15.000000000 +0200
@@ -70,5 +70,32 @@
 	kfree(info);
 }
 
+ssize_t fb_show_mode(struct class_device *class_dev, char * buf) {
+	struct fb_info *info = class_get_devdata(class_dev);
+	struct fb_var_screeninfo *var = &info->var;
+	
+	u32 htotal = var->xres + var->upper_margin + var->lower_margin + var->hsync_len;
+	u32 vtotal = var->yres + var->left_margin + var->right_margin + var->vsync_len;
+
+	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
+		vtotal = vtotal << 2;
+	else if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_NONINTERLACED)
+		vtotal = vtotal << 1;
+
+	/* 
+	 * This should be:
+	 *                     1000000000000
+	 *            ------------------------------- * 2
+	 *            var->pixclock * htotal * vtotal
+	 *            
+	 * we divide numerator and pixclock by 1000 so the expression does not overflow.
+	 */
+	u32 refresh = 1000000000UL / ((var->pixclock / 1000) * htotal * vtotal) * 2;
+	
+	return snprintf(buf, PAGE_SIZE, "%ux%u-%u@%u\n", var->xres, var->yres,
+			var->bits_per_pixel, refresh);
+}
+
+EXPORT_SYMBOL(fb_show_mode);
 EXPORT_SYMBOL(framebuffer_release);
 EXPORT_SYMBOL(framebuffer_alloc);
diff -Nru -X dontdiff linux-2.6-vanilla/include/linux/fb.h linux-2.6/include/linux/fb.h
--- linux-2.6-vanilla/include/linux/fb.h	2004-06-15 15:38:40.000000000 +0200
+++ linux-2.6/include/linux/fb.h	2004-06-14 17:34:28.000000000 +0200
@@ -611,6 +611,15 @@
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
+extern ssize_t fb_show_mode(struct class_device *class_dev, char * buf);
+
+#define FB_MODE_ATTR(_name)			\
+struct class_device_attribute _name = {		\
+	.attr = {.name = "mode", .mode = 0444, .owner = THIS_MODULE },	\
+	.show = fb_show_mode,			\
+	.store = NULL,				\
+};
+
 
 /* drivers/video/fbmon.c */
 #define FB_MAXTIMINGS		0


Luca
-- 
Home: http://kronoz.cjb.net
Not an editor command: Wq


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
