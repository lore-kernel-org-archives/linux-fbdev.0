From: Petr Sedlak <hugosedlak@gmail.com>
Date: Mon, 22 Jan 2018 20:43:06 +0000
Subject: [PATCH] staging: sm750fb: fix CamelCase for dispSet var
Message-Id: <1516653786-6560-1-git-send-email-hugosedlak@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: Petr Sedlak <hugosedlak@gmail.com>

Fix warning reported by checkpatch:

  CHECK: Avoid CamelCase: <dispSet>

By renaming dispSet to disp_set

Signed-off-by: Petr Sedlak <hugosedlak@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index ffd114a..a8c7986 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -185,29 +185,29 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 			    struct fb_fix_screeninfo *fix)
 {
 	int ret;
-	disp_output_t dispSet;
+	disp_output_t disp_set;
 	int channel;
 
 	ret = 0;
-	dispSet = 0;
+	disp_set = 0;
 	channel = *output->channel;
 
 	if (sm750_get_chip_type() != SM750LE) {
 		if (channel = sm750_primary) {
 			pr_info("primary channel\n");
 			if (output->paths & sm750_panel)
-				dispSet |= do_LCD1_PRI;
+				disp_set |= do_LCD1_PRI;
 			if (output->paths & sm750_crt)
-				dispSet |= do_CRT_PRI;
+				disp_set |= do_CRT_PRI;
 
 		} else {
 			pr_info("secondary channel\n");
 			if (output->paths & sm750_panel)
-				dispSet |= do_LCD1_SEC;
+				disp_set |= do_LCD1_SEC;
 			if (output->paths & sm750_crt)
-				dispSet |= do_CRT_SEC;
+				disp_set |= do_CRT_SEC;
 		}
-		ddk750_setLogicalDispOut(dispSet);
+		ddk750_setLogicalDispOut(disp_set);
 	} else {
 		/* just open DISPLAY_CONTROL_750LE register bit 3:0 */
 		u32 reg;
-- 
2.7.4

