From: James Simmons <jsimmons@infradead.org>
Subject: Get the line length from sysfs.
Date: Wed, 21 Sep 2005 22:03:29 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0509212202030.10847@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIBkf-00069b-2k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 14:03:37 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EIBkd-0004wa-6v
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 14:03:37 -0700
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.52 #1 (Red Hat Linux))
	id 1EIBkX-0002t3-VR
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Sep 2005 22:03:30 +0100
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


Let me know if this is acceptable. Some people might not like the name.


--- linus-2.6/drivers/video/fbsysfs.c	2005-07-31 15:45:22.000000000 -0700
+++ fbdev-2.6/drivers/video/fbsysfs.c	2005-09-21 13:54:02.000000000 -0700
@@ -242,6 +242,13 @@
 			fb_info->var.yres_virtual);
 }
 
+static ssize_t show_stride(struct class_device *class_device, char *buf)
+{
+	struct fb_info *fb_info =
+		(struct fb_info *)class_get_devdata(class_device);
+	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->fix.line_length);
+}
+
 /* Format for cmap is "%02x%c%4x%4x%4x\n" */
 /* %02x entry %c transp %4x red %4x blue %4x green \n */
 /* 256 rows at 16 chars equals 4096, the normal page size */
@@ -432,6 +439,7 @@
 	__ATTR(pan, S_IRUGO|S_IWUSR, show_pan, store_pan),
 	__ATTR(virtual_size, S_IRUGO|S_IWUSR, show_virtual, store_virtual),
 	__ATTR(name, S_IRUGO, show_name, NULL),
+	__ATTR(stride, S_IRUGO, show_stride, NULL),
 };
 
 int fb_init_class_device(struct fb_info *fb_info)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
