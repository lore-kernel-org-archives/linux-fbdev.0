From: Ben Dooks <ben-linux@fluff.org>
Subject: [patch 1/5] SM501: Add inversion controls for
	VBIASEN and FPEN
Date: Sun, 22 Jun 2008 22:04:40 +0100
Message-ID: <20080622210614.259326969@fluff.org.uk>
References: <20080622210439.018928412@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAWld-0002yA-4D for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Received: from aeryn.fluff.org.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KAWlb-00018C-0w
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 14:06:33 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-ctrlinvert.patch
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

Add flags to allow the driver to invert the sense of
both VBIASEN and FPEN signals comming from the SM501.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.26-rc4-quilt3/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/drivers/video/sm501fb.c	2008-05-26 23:17:37.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/drivers/video/sm501fb.c	2008-05-29 10:53:18.000000000 +0100
@@ -663,15 +663,25 @@ static void sm501fb_panel_power(struct s
 		sm501fb_sync_regs(fbi);
 		mdelay(10);
 
+		/* VBIASEN */
+
 		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_VBIASEN)) {
-			control |= SM501_DC_PANEL_CONTROL_BIAS;	/* VBIASEN */
+			if (pd->flags & SM501FB_FLAG_PANEL_INV_VBIASEN)
+				control &= ~SM501_DC_PANEL_CONTROL_BIAS;
+			else
+				control |= SM501_DC_PANEL_CONTROL_BIAS;
+
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
 		}
 
 		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_FPEN)) {
-			control |= SM501_DC_PANEL_CONTROL_FPEN;
+			if (pd->flags & SM501FB_FLAG_PANEL_INV_FPEN)
+				control &= ~SM501_DC_PANEL_CONTROL_FPEN;
+			else
+				control |= SM501_DC_PANEL_CONTROL_FPEN;
+
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
@@ -679,14 +689,22 @@ static void sm501fb_panel_power(struct s
 	} else if (!to && (control & SM501_DC_PANEL_CONTROL_VDD) != 0) {
 		/* disable panel power */
 		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_FPEN)) {
-			control &= ~SM501_DC_PANEL_CONTROL_FPEN;
+			if (pd->flags & SM501FB_FLAG_PANEL_INV_FPEN)
+				control |= SM501_DC_PANEL_CONTROL_FPEN;
+			else
+				control &= ~SM501_DC_PANEL_CONTROL_FPEN;
+
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
 		}
 
 		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_VBIASEN)) {
-			control &= ~SM501_DC_PANEL_CONTROL_BIAS;
+			if (pd->flags & SM501FB_FLAG_PANEL_INV_VBIASEN)
+				control |= SM501_DC_PANEL_CONTROL_BIAS;
+			else
+				control &= ~SM501_DC_PANEL_CONTROL_BIAS;
+
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
Index: linux-2.6.26-rc4-quilt3/include/linux/sm501.h
===================================================================
--- linux-2.6.26-rc4-quilt3.orig/include/linux/sm501.h	2008-05-27 20:25:43.000000000 +0100
+++ linux-2.6.26-rc4-quilt3/include/linux/sm501.h	2008-05-29 10:54:40.000000000 +0100
@@ -73,6 +73,8 @@ extern unsigned long sm501_gpio_get(stru
 #define SM501FB_FLAG_USE_HWACCEL	(1<<3)
 #define SM501FB_FLAG_PANEL_NO_FPEN	(1<<4)
 #define SM501FB_FLAG_PANEL_NO_VBIASEN	(1<<5)
+#define SM501FB_FLAG_PANEL_INV_FPEN	(1<<6)
+#define SM501FB_FLAG_PANEL_INV_VBIASEN	(1<<7)
 
 struct sm501_platdata_fbsub {
 	struct fb_videomode	*def_mode;

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
