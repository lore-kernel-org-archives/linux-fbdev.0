From: James Simmons <jsimmons@infradead.org>
Subject: Show the name of the fbdev device
Date: Wed, 27 Jul 2005 23:23:49 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0507272323030.4063@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DxuJf-0002OB-Gc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:23:55 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1DxuJe-0002Pi-Uq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 27 Jul 2005 15:23:55 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>


Show the name of the fbdev device in sysfs. Has been tested.

--- linus-2.6/drivers/video/fbsysfs.c	2005-07-11 10:07:21.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-07-21 08:47:17.000000000 -0700
@@ -352,6 +351,13 @@
 			fb_info->var.xoffset);
 }
 
+static ssize_t show_name(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", fb_info->fix.id);
+}
+
 static struct class_device_attribute class_device_attrs[] = {
 	__ATTR(bits_per_pixel, S_IRUGO|S_IWUSR, show_bpp, store_bpp),
 	__ATTR(blank, S_IRUGO|S_IWUSR, show_blank, store_blank),
@@ -362,6 +368,7 @@
 	__ATTR(modes, S_IRUGO|S_IWUSR, show_modes, store_modes),
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
+	__ATTR(name, S_IRUGO, show_name, NULL),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
