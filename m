From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] sm501fb: control panel pin usage with
	platform data flags
Date: Fri, 28 Dec 2007 14:51:13 +0900
Message-ID: <20071228055113.807.96733.sendpatchset@clockwork.opensource.se>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J889W-00060c-5I for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 21:53:02 -0800
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J889V-0002Bj-DR
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 21:53:02 -0800
Received: by wa-out-1112.google.com with SMTP id k22so5672703waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 27 Dec 2007 21:53:00 -0800 (PST)
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
Cc: akpm@linux-foundation.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, syrjala@sci.fi, ben-linux@fluff.org

sm501fb: control panel pin usage with platform data flags

This patch makes it possible to control panel pins usage with flags passed
from the platform data. Without this patch the sm501fb driver always controls
the VBIASEN and FPEN pins. The polarity and use of these pins are very platform
specific, so this patch introduces the flags SM501FB_FLAG_PANEL_USE_VBIASEN
and SM501FB_FLAG_PANEL_USE_FPEN which enable the use of these pins.

This patch is needed to support the a Sharp LQ104V1DG21 lcd panel on SuperH
platforms such as R2D-1 and R2D-PLUS boards. Letting the sm501fb driver control
the FPEN and VBIASEN pins like today just results in lcd panel flicker.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies to 2.6.24-rc6.

 drivers/video/sm501fb.c |   41 +++++++++++++++++++++++++----------------
 include/linux/sm501.h   |    2 ++
 2 files changed, 27 insertions(+), 16 deletions(-)

--- 0003/drivers/video/sm501fb.c
+++ work/drivers/video/sm501fb.c	2007-12-27 14:18:28.000000000 +0900
@@ -639,6 +639,7 @@ static void sm501fb_panel_power(struct s
 {
 	unsigned long control;
 	void __iomem *ctrl_reg = fbi->regs + SM501_DC_PANEL_CONTROL;
+	struct sm501_platdata_fbsub *pd = fbi->pdata->fb_pnl;
 
 	control = readl(ctrl_reg);
 
@@ -655,26 +656,34 @@ static void sm501fb_panel_power(struct s
 		sm501fb_sync_regs(fbi);
 		mdelay(10);
 
-		control |= SM501_DC_PANEL_CONTROL_BIAS;	/* VBIASEN */
-		writel(control, ctrl_reg);
-		sm501fb_sync_regs(fbi);
-		mdelay(10);
-
-		control |= SM501_DC_PANEL_CONTROL_FPEN;
-		writel(control, ctrl_reg);
+		if (pd->flags & SM501FB_FLAG_PANEL_USE_VBIASEN) {
+			control |= SM501_DC_PANEL_CONTROL_BIAS;	/* VBIASEN */
+			writel(control, ctrl_reg);
+			sm501fb_sync_regs(fbi);
+			mdelay(10);
+		}
 
+		if (pd->flags & SM501FB_FLAG_PANEL_USE_FPEN) {
+			control |= SM501_DC_PANEL_CONTROL_FPEN;
+			writel(control, ctrl_reg);
+			sm501fb_sync_regs(fbi);
+			mdelay(10);
+		}
 	} else if (!to && (control & SM501_DC_PANEL_CONTROL_VDD) != 0) {
 		/* disable panel power */
+		if (pd->flags & SM501FB_FLAG_PANEL_USE_FPEN) {
+			control &= ~SM501_DC_PANEL_CONTROL_FPEN;
+			writel(control, ctrl_reg);
+			sm501fb_sync_regs(fbi);
+			mdelay(10);
+		}
 
-		control &= ~SM501_DC_PANEL_CONTROL_FPEN;
-		writel(control, ctrl_reg);
-		sm501fb_sync_regs(fbi);
-		mdelay(10);
-
-		control &= ~SM501_DC_PANEL_CONTROL_BIAS;
-		writel(control, ctrl_reg);
-		sm501fb_sync_regs(fbi);
-		mdelay(10);
+		if (pd->flags & SM501FB_FLAG_PANEL_USE_VBIASEN) {
+			control &= ~SM501_DC_PANEL_CONTROL_BIAS;
+			writel(control, ctrl_reg);
+			sm501fb_sync_regs(fbi);
+			mdelay(10);
+		}
 
 		control &= ~SM501_DC_PANEL_CONTROL_DATA;
 		writel(control, ctrl_reg);
--- 0001/include/linux/sm501.h
+++ work/include/linux/sm501.h	2007-12-27 14:13:40.000000000 +0900
@@ -70,6 +70,8 @@ extern unsigned long sm501_gpio_get(stru
 #define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
 #define SM501FB_FLAG_USE_HWCURSOR	(1<<2)
 #define SM501FB_FLAG_USE_HWACCEL	(1<<3)
+#define SM501FB_FLAG_PANEL_USE_FPEN	(1<<4)
+#define SM501FB_FLAG_PANEL_USE_VBIASEN	(1<<5)
 
 struct sm501_platdata_fbsub {
 	struct fb_videomode	*def_mode;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
