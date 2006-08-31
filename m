From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] fbdev: Fix crashes in various fbdev's
	blank routines
Date: Thu, 31 Aug 2006 14:04:34 +1000
Message-ID: <1156997075.12526.104.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GIdng-0003gK-4Z for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 21:05:08 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GIdne-0000dt-Fi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 Aug 2006 21:05:08 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Michael Hanselmann <linux-kernel@hansmi.ch>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Olaf Hering <olh@suse.de>

The backlight changes that went in 2.6.18 had a bug where they could
cause the kernel to access an unitialized pointer when blanking if there
is no backlight control on a machine. The bug affects atyfb, aty128fb,
nvidiafb and rivafb. radeonfb seems to be ok. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This is a 2.6.18 regression, please merge before release ! It breaks a
number of non-laptop powermacs (among others I suppose).

Index: linux-work/drivers/video/aty/aty128fb.c
===================================================================
--- linux-work.orig/drivers/video/aty/aty128fb.c	2006-08-17 09:26:21.000000000 +1000
+++ linux-work/drivers/video/aty/aty128fb.c	2006-08-31 13:56:11.000000000 +1000
@@ -1800,6 +1800,9 @@ static struct backlight_properties aty12
 
 static void aty128_bl_set_power(struct fb_info *info, int power)
 {
+	if (info->bl_dev == NULL)
+		return;
+
 	mutex_lock(&info->bl_mutex);
 	up(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
@@ -1828,7 +1831,7 @@ static void aty128_bl_init(struct aty128
 	bd = backlight_device_register(name, par, &aty128_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
-		printk("aty128: Backlight registration failed\n");
+		printk(KERN_WARNING "aty128: Backlight registration failed\n");
 		goto error;
 	}
 
Index: linux-work/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/atyfb_base.c	2006-08-17 09:26:21.000000000 +1000
+++ linux-work/drivers/video/aty/atyfb_base.c	2006-08-31 13:55:43.000000000 +1000
@@ -2199,6 +2199,9 @@ static struct backlight_properties aty_b
 
 static void aty_bl_set_power(struct fb_info *info, int power)
 {
+	if (info->bl_dev == NULL)
+		return;
+
 	mutex_lock(&info->bl_mutex);
 	up(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
@@ -2223,7 +2226,7 @@ static void aty_bl_init(struct atyfb_par
 	bd = backlight_device_register(name, par, &aty_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
-		printk("aty: Backlight registration failed\n");
+		printk(KERN_WARNING "aty: Backlight registration failed\n");
 		goto error;
 	}
 
Index: linux-work/drivers/video/nvidia/nv_backlight.c
===================================================================
--- linux-work.orig/drivers/video/nvidia/nv_backlight.c	2006-08-17 09:26:22.000000000 +1000
+++ linux-work/drivers/video/nvidia/nv_backlight.c	2006-08-31 13:58:47.000000000 +1000
@@ -112,6 +112,8 @@ static struct backlight_properties nvidi
 
 void nvidia_bl_set_power(struct fb_info *info, int power)
 {
+	if (info->bl_dev == NULL)
+		return;
 	mutex_lock(&info->bl_mutex);
 	up(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
@@ -140,7 +142,7 @@ void nvidia_bl_init(struct nvidia_par *p
 	bd = backlight_device_register(name, par, &nvidia_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
-		printk("nvidia: Backlight registration failed\n");
+		printk(KERN_WARNING "nvidia: Backlight registration failed\n");
 		goto error;
 	}
 
Index: linux-work/drivers/video/riva/fbdev.c
===================================================================
--- linux-work.orig/drivers/video/riva/fbdev.c	2006-08-17 09:26:22.000000000 +1000
+++ linux-work/drivers/video/riva/fbdev.c	2006-08-31 13:58:49.000000000 +1000
@@ -354,6 +354,9 @@ static struct backlight_properties riva_
 
 static void riva_bl_set_power(struct fb_info *info, int power)
 {
+	if (info->bl_dev == NULL)
+		return;
+
 	mutex_lock(&info->bl_mutex);
 	up(&info->bl_dev->sem);
 	info->bl_dev->props->power = power;
@@ -382,7 +385,7 @@ static void riva_bl_init(struct riva_par
 	bd = backlight_device_register(name, par, &riva_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
-		printk("riva: Backlight registration failed\n");
+		printk(KERN_WARNING "riva: Backlight registration failed\n");
 		goto error;
 	}
 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
