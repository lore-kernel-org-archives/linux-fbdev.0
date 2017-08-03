From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu, 03 Aug 2017 19:27:39 +0000
Subject: [PATCH] video: fbdev: vt8623fb: constify vt8623_timing_regs
Message-Id: <1501788459-32425-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>

vt8623_timing_regs is only passed as the first argument to
svga_check_timings and as the second argument to svga_set_timings,
both of which are const.  So make vt8623_timing_regs const also.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/fbdev/vt8623fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 9f34879..5cac871 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -81,7 +81,7 @@ struct vt8623fb_info {
 static struct vga_regset vt8623_fetch_count_regs[]   = {{0x1C, 0, 7}, {0x1D, 0, 1}, VGA_REGSET_END};
 static struct vga_regset vt8623_start_address_regs[] = {{0x0d, 0, 7}, {0x0c, 0, 7}, {0x34, 0, 7}, {0x48, 0, 1}, VGA_REGSET_END};
 
-static struct svga_timing_regs vt8623_timing_regs     = {
+static const struct svga_timing_regs vt8623_timing_regs     = {
 	vt8623_h_total_regs, vt8623_h_display_regs, vt8623_h_blank_start_regs,
 	vt8623_h_blank_end_regs, vt8623_h_sync_start_regs, vt8623_h_sync_end_regs,
 	vt8623_v_total_regs, vt8623_v_display_regs, vt8623_v_blank_start_regs,

