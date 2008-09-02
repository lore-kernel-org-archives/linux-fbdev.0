From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] i.MX Framebuffer: fix margins
Date: Tue,  2 Sep 2008 13:24:47 +0200
Message-ID: <1220354697-13648-5-git-send-email-s.hauer@pengutronix.de>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaU1z-0000lF-Sw for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:26:46 -0700
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaU1w-0000hk-Sg
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 04:26:43 -0700
In-Reply-To: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Andrew Dyer <amdyer@gmail.com>

The upper/lower and left/right margins are mixed up in the driver.
Fix it

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/video/imxfb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 1bccf5a..feaae73 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -410,13 +410,13 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
 #endif
 
 	writel(HCR_H_WIDTH(var->hsync_len) |
-		HCR_H_WAIT_1(var->left_margin) |
-		HCR_H_WAIT_2(var->right_margin),
+		HCR_H_WAIT_1(var->right_margin) |
+		HCR_H_WAIT_2(var->left_margin),
 		fbi->regs + LCDC_HCR);
 
 	writel(VCR_V_WIDTH(var->vsync_len) |
-		VCR_V_WAIT_1(var->upper_margin) |
-		VCR_V_WAIT_2(var->lower_margin),
+		VCR_V_WAIT_1(var->lower_margin) |
+		VCR_V_WAIT_2(var->upper_margin),
 		fbi->regs + LCDC_VCR);
 
 	writel(SIZE_XMAX(var->xres) | SIZE_YMAX(var->yres),
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
