From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 4/5] LCD: Add lcd_device to check_fb()
	entry in lcd_ops.
Date: Sun, 22 Jun 2008 22:04:43 +0100
Message-ID: <20080622210614.835338562@fluff.org.uk>
References: <20080622210439.018928412@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAWld-0002yF-Eu for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KAWlb-00018D-1j
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-backlight-match-entry.patch
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
To: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>

Add the lcd_device being checked to the check_fb entry
of lcd_ops. This ensures that any driver using this
to check against it's own state can do so, and also
makes all the calls in lcd_ops more orthogonal in their
arguments.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc5-quilt1/drivers/video/backlight/lcd.c
===================================================================
--- linux-2.6.26-rc5-quilt1.orig/drivers/video/backlight/lcd.c	2008-06-09 11:47:51.000000000 +0100
+++ linux-2.6.26-rc5-quilt1/drivers/video/backlight/lcd.c	2008-06-09 11:49:25.000000000 +0100
@@ -33,7 +33,7 @@ static int fb_notifier_callback(struct n
 	ld = container_of(self, struct lcd_device, fb_notif);
 	mutex_lock(&ld->ops_lock);
 	if (ld->ops)
-		if (!ld->ops->check_fb || ld->ops->check_fb(evdata->info))
+		if (!ld->ops->check_fb || ld->ops->check_fb(ld, evdata->info))
 			ld->ops->set_power(ld, *(int *)evdata->data);
 	mutex_unlock(&ld->ops_lock);
 	return 0;
Index: linux-2.6.26-rc5-quilt1/drivers/video/bf54x-lq043fb.c
===================================================================
--- linux-2.6.26-rc5-quilt1.orig/drivers/video/bf54x-lq043fb.c	2008-06-09 11:56:06.000000000 +0100
+++ linux-2.6.26-rc5-quilt1/drivers/video/bf54x-lq043fb.c	2008-06-09 11:56:24.000000000 +0100
@@ -478,7 +478,7 @@ static int bfin_lcd_set_contrast(struct 
 	return 0;
 }
 
-static int bfin_lcd_check_fb(struct fb_info *fi)
+static int bfin_lcd_check_fb(struct lcd_device *dev, struct fb_info *fi)
 {
 	if (!fi || (fi == &bfin_bf54x_fb))
 		return 1;
Index: linux-2.6.26-rc5-quilt1/drivers/video/bfin-t350mcqb-fb.c
===================================================================
--- linux-2.6.26-rc5-quilt1.orig/drivers/video/bfin-t350mcqb-fb.c	2008-06-09 11:56:40.000000000 +0100
+++ linux-2.6.26-rc5-quilt1/drivers/video/bfin-t350mcqb-fb.c	2008-06-09 11:56:51.000000000 +0100
@@ -396,7 +396,7 @@ static int bfin_lcd_set_contrast(struct 
 	return 0;
 }
 
-static int bfin_lcd_check_fb(struct fb_info *fi)
+static int bfin_lcd_check_fb(struct lcd_device *dev, struct fb_info *fi)
 {
 	if (!fi || (fi == &bfin_t350mcqb_fb))
 		return 1;
Index: linux-2.6.26-rc5-quilt1/include/linux/lcd.h
===================================================================
--- linux-2.6.26-rc5-quilt1.orig/include/linux/lcd.h	2008-06-09 11:23:48.000000000 +0100
+++ linux-2.6.26-rc5-quilt1/include/linux/lcd.h	2008-06-09 11:24:10.000000000 +0100
@@ -47,7 +47,7 @@ struct lcd_ops {
         int (*set_contrast)(struct lcd_device *, int contrast);
 	/* Check if given framebuffer device is the one LCD is bound to;
 	   return 0 if not, !=0 if it is. If NULL, lcd always matches the fb. */
-	int (*check_fb)(struct fb_info *);
+	int (*check_fb)(struct lcd_device *, struct fb_info *);
 };
 
 struct lcd_device {

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
