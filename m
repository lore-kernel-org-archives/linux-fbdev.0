From: Kronos <kronos@people.it>
Subject: Re: [PATCH][RFC][3/3] mode attribute in sysfs tree
Date: Wed, 16 Jun 2004 11:32:03 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040616093202.GD3556@dreamland.darkstar.lan>
References: <20040615172138.GA8823@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWm1-0005Zn-1a
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:32:01 -0700
Received: from mail-relay-4.tiscali.it ([212.123.84.94] helo=sparkfist.tiscali.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaWlz-0002s7-J4
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 02:31:59 -0700
Received: from dreamland.darkstar.lan (82.84.177.170) by sparkfist.tiscali.it (7.0.028)
        id 40CF254F0007357C for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 11:31:50 +0200
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

Simple patch to show usage of the attribute with sisfb.

diff -Nru -X dontdiff linux-2.6-vanilla/drivers/video/sis/sis_main.c linux-2.6/drivers/video/sis/sis_main.c
--- linux-2.6-vanilla/drivers/video/sis/sis_main.c	2004-02-28 13:32:58.000000000 +0100
+++ linux-2.6/drivers/video/sis/sis_main.c	2004-06-12 19:21:06.000000000 +0200
@@ -4102,7 +4102,9 @@
         return NULL;
 }
 
-
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,7)
+static FB_MODE_ATTR(sis_mode_attr);
+#endif
 
 int __init sisfb_init(void)
 {
@@ -4954,6 +4956,9 @@
 			kfree(sis_fb_info);
 			return -EINVAL;
 		}
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,7)
+		class_device_create_file(sis_fb_info->class_dev, &sis_mode_attr);
+#endif
 
 		sisfb_registered = 1;			
 
@@ -5266,6 +5271,9 @@
 	/* Unregister the framebuffer */
 	if(sisfb_registered) {
 		unregister_framebuffer(sis_fb_info);
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,7)
+		class_device_remove_file(sis_fb_info->class_dev, &sis_mode_attr);
+#endif
 #if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,0)) && (defined(NEWFBDEV))
 		framebuffer_release(sis_fb_info);
 #else


Luca
-- 
Home: http://kronoz.cjb.net
Collect some stars to shine for you
And start today 'cause there's only a few
A sign of times my friend


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
