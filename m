From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH] pxafb: turn off unused return value
Date: Thu, 18 Dec 2008 16:05:37 +0100
Message-ID: <1229612737-12628-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <l.fu@pengutronix.de>) id 1LDKRc-0005XW-W4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 15:05:44 +0000
Received: from metis.ext.pengutronix.de ([92.198.50.35])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LDKRZ-0002tg-CU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Dec 2008 15:05:44 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net, Luotao Fu <l.fu@pengutronix.de>

Nobody cares for the return value of pxafb_activate_var(). Indeed it always
returns with 0. Hence change it to void type. 

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
 drivers/video/pxafb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index cc59c52..b079f10 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -72,7 +72,7 @@
 static void (*pxafb_backlight_power)(int);
 static void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 
-static int pxafb_activate_var(struct fb_var_screeninfo *var,
+static void pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
 
@@ -870,7 +870,7 @@ static void setup_parallel_timing(struct pxafb_info *fbi,
  *	Configures LCD Controller based on entries in var parameter.
  *	Settings are only written to the controller if changes were made.
  */
-static int pxafb_activate_var(struct fb_var_screeninfo *var,
+static void pxafb_activate_var(struct fb_var_screeninfo *var,
 			      struct pxafb_info *fbi)
 {
 	u_long flags;
@@ -962,8 +962,6 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 	    (lcd_readl(fbi, FDADR0) != fbi->fdadr[0]) ||
 	    (lcd_readl(fbi, FDADR1) != fbi->fdadr[1]))
 		pxafb_schedule_work(fbi, C_REENABLE);
-
-	return 0;
 }
 
 /*
-- 
1.5.6.5


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
