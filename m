From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH 3/6] pxa: fix pxa168 lcd controller vsync/hsync timing error
Date: Tue, 3 Nov 2009 14:45:33 +0800
Message-ID: <7c34ac520911022245x7f002a7at846a835dfded550c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net

pxa: fix pxa168 lcd controller vsync/hsync timing error

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |    4 ++--
 include/video/pxa168fb.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index 2ba1444..bdd524c 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -459,8 +459,8 @@ static void set_dumb_panel_control(struct fb_info *info)
 	x |= mi->invert_composite_blank ? 0x00000040 : 0;
 	x |= (info->var.sync & FB_SYNC_COMP_HIGH_ACT) ? 0x00000020 : 0;
 	x |= mi->invert_pix_val_ena ? 0x00000010 : 0;
-	x |= (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0 : 0x00000008;
-	x |= (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0 : 0x00000004;
+	x |= (info->var.sync & FB_SYNC_VERT_HIGH_ACT) ? 0x00000008 : 0;
+	x |= (info->var.sync & FB_SYNC_HOR_HIGH_ACT) ? 0x00000004 : 0;
 	x |= mi->invert_pixclock ? 0x00000002 : 0;

 	writel(x, fbi->reg_base + LCD_SPU_DUMB_CTRL);
diff --git a/include/video/pxa168fb.h b/include/video/pxa168fb.h
index f0497ae..7206483 100644
--- a/include/video/pxa168fb.h
+++ b/include/video/pxa168fb.h
@@ -117,8 +117,6 @@ struct pxa168fb_mach_info {
 	unsigned	invert_composite_blank:1;
 	unsigned	invert_pix_val_ena:1;
 	unsigned	invert_pixclock:1;
-	unsigned	invert_vsync:1;
-	unsigned	invert_hsync:1;
 	unsigned	panel_rbswap:1;
 	unsigned	active:1;
 	unsigned	enable_lcd:1;
-- 
1.5.4.3
