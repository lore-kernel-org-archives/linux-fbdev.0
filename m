From: Kronos <kronos@people.it>
Subject: Re: [PATCH][RFC][1/3] mode attribute in sysfs tree
Date: Wed, 16 Jun 2004 11:28:47 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616092847.GB3556@dreamland.darkstar.lan>
References: <20040615172138.GA8823@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWio-0005S6-N2
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:28:42 -0700
Received: from mail-relay-4.tiscali.it ([212.123.84.94] helo=sparkfist.tiscali.it)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWio-0006mQ-1G
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:28:42 -0700
Received: from dreamland.darkstar.lan (82.84.177.170) by sparkfist.tiscali.it (7.0.028)
        id 40CF254F00073007 for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:28:33 +0200
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

First patch, with basic infrastructure:

diff -Nru -X dontdiff linux-2.6-vanilla/drivers/video/fbmem.c linux-2.6/drivers/video/fbmem.c
--- linux-2.6-vanilla/drivers/video/fbmem.c	2004-06-10 15:51:31.000000000 +0200
+++ linux-2.6/drivers/video/fbmem.c	2004-06-12 21:19:06.000000000 +0200
@@ -1294,6 +1294,8 @@
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
 	}
+	fb_info->class_dev = c;
+	class_set_devdata(fb_info->class_dev, fb_info);
 	
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
diff -Nru -X dontdiff linux-2.6-vanilla/include/linux/fb.h linux-2.6/include/linux/fb.h
--- linux-2.6-vanilla/include/linux/fb.h	2004-06-10 15:51:46.000000000 +0200
+++ linux-2.6/include/linux/fb.h	2004-06-14 17:34:28.000000000 +0200
@@ -389,6 +389,7 @@
 #include <linux/workqueue.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/notifier.h>
+#include <linux/device.h>
 #include <asm/io.h>
 
 struct vm_area_struct;
@@ -521,6 +522,7 @@
 #define FBINFO_STATE_RUNNING	0
 #define FBINFO_STATE_SUSPENDED	1
 	u32 state;			/* Hardware state i.e suspend */
+	struct class_device *class_dev;
 
 	/* From here on everything is device dependent */
 	void *par;	

Luca
-- 
Home: http://kronoz.cjb.net
Se non puoi convincerli, confondili.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
