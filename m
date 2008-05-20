From: Ben Dooks <ben-fbdev@fluff.org>
Subject: [patch 1/5] SM501: Reverse FPEN/VBIASEN flags
	behaviour.
Date: Tue, 20 May 2008 13:49:55 +0100
Message-ID: <20080520125029.967251370@fluff.org.uk>
References: <20080520124954.001898813@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JyRIo-0004TK-Q2 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8] helo=kira.home.fluff.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JyRIm-0006Ht-WA
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 May 2008 05:50:50 -0700
Content-Disposition: inline;
	filename=simtec/simtec-drivers-fb-sm501-revertbehaviour.patch
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, arnaud.patard@rtp-net.org

To keep backwards compatibility, reverse the meanings of these flags
so that when they are not set, the driver uses the original behvaiour.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

Index: linux-2.6.25-rc9-quilt2/drivers/video/sm501fb.c
===================================================================
--- linux-2.6.25-rc9-quilt2.orig/drivers/video/sm501fb.c	2008-04-14 16:41:21.000000000 +0100
+++ linux-2.6.25-rc9-quilt2/drivers/video/sm501fb.c	2008-04-15 00:23:19.000000000 +0100
@@ -663,14 +663,14 @@ static void sm501fb_panel_power(struct s
 		sm501fb_sync_regs(fbi);
 		mdelay(10);
 
-		if (pd->flags & SM501FB_FLAG_PANEL_USE_VBIASEN) {
+		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_VBIASEN)) {
 			control |= SM501_DC_PANEL_CONTROL_BIAS;	/* VBIASEN */
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
 		}
 
-		if (pd->flags & SM501FB_FLAG_PANEL_USE_FPEN) {
+		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_FPEN)) {
 			control |= SM501_DC_PANEL_CONTROL_FPEN;
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
@@ -678,14 +678,14 @@ static void sm501fb_panel_power(struct s
 		}
 	} else if (!to && (control & SM501_DC_PANEL_CONTROL_VDD) != 0) {
 		/* disable panel power */
-		if (pd->flags & SM501FB_FLAG_PANEL_USE_FPEN) {
+		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_FPEN)) {
 			control &= ~SM501_DC_PANEL_CONTROL_FPEN;
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
 			mdelay(10);
 		}
 
-		if (pd->flags & SM501FB_FLAG_PANEL_USE_VBIASEN) {
+		if (!(pd->flags & SM501FB_FLAG_PANEL_NO_VBIASEN)) {
 			control &= ~SM501_DC_PANEL_CONTROL_BIAS;
 			writel(control, ctrl_reg);
 			sm501fb_sync_regs(fbi);
Index: linux-2.6.25-rc9-quilt2/include/linux/sm501.h
===================================================================
--- linux-2.6.25-rc9-quilt2.orig/include/linux/sm501.h	2008-04-15 00:11:29.000000000 +0100
+++ linux-2.6.25-rc9-quilt2/include/linux/sm501.h	2008-04-15 00:23:19.000000000 +0100
@@ -71,8 +71,8 @@ extern unsigned long sm501_gpio_get(stru
 #define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
 #define SM501FB_FLAG_USE_HWCURSOR	(1<<2)
 #define SM501FB_FLAG_USE_HWACCEL	(1<<3)
-#define SM501FB_FLAG_PANEL_USE_FPEN	(1<<4)
-#define SM501FB_FLAG_PANEL_USE_VBIASEN	(1<<5)
+#define SM501FB_FLAG_PANEL_NO_FPEN	(1<<4)
+#define SM501FB_FLAG_PANEL_NO_VBIASEN	(1<<5)
 
 struct sm501_platdata_fbsub {
 	struct fb_videomode	*def_mode;

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
