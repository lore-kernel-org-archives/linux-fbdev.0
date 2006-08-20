From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/console/: make 3 functions static
Date: Mon, 21 Aug 2006 00:59:15 +0200
Message-ID: <20060820225914.GU7813@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751790AbWHTW7T@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch makes three needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/console/fbcon_ccw.c |    2 +-
 drivers/video/console/fbcon_cw.c  |    2 +-
 drivers/video/console/fbcon_ud.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_cw.c.old	2006-08-20 23:07:14.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_cw.c	2006-08-20 23:07:31.000000000 +0200
@@ -375,7 +375,7 @@
 	ops->cursor_reset = 0;
 }
 
-int cw_update_start(struct fb_info *info)
+static int cw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 vxres = GETVXRES(ops->p->scrollmode, info);
--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ccw.c.old	2006-08-20 23:07:58.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ccw.c	2006-08-20 23:08:03.000000000 +0200
@@ -391,7 +391,7 @@
 	ops->cursor_reset = 0;
 }
 
-int ccw_update_start(struct fb_info *info)
+static int ccw_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	u32 yoffset;
--- linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ud.c.old	2006-08-20 23:08:31.000000000 +0200
+++ linux-2.6.18-rc4-mm2/drivers/video/console/fbcon_ud.c	2006-08-20 23:08:45.000000000 +0200
@@ -415,7 +415,7 @@
 	ops->cursor_reset = 0;
 }
 
-int ud_update_start(struct fb_info *info)
+static int ud_update_start(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 	int xoffset, yoffset;
