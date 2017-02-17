From: Colin King <colin.king@canonical.com>
Date: Fri, 17 Feb 2017 20:23:21 +0000
Subject: [PATCH] video: fbdev: fsl-diu-fb: fix spelling mistake "palette"
Message-Id: <20170217202321.21529-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistakes of "palette"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/fsl-diu-fb.c | 4 ++--
 include/linux/fsl-diu-fb.h       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index c48a59e..ca3d6b3 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -439,12 +439,12 @@ static struct mfb_info mfb_template[] = {
 static void __attribute__ ((unused)) fsl_diu_dump(struct diu __iomem *hw)
 {
 	mb();
-	pr_debug("DIU: desc=%08x,%08x,%08x, gamma=%08x pallete=%08x "
+	pr_debug("DIU: desc=%08x,%08x,%08x, gamma=%08x palette=%08x "
 		 "cursor=%08x curs_pos=%08x diu_mode=%08x bgnd=%08x "
 		 "disp_size=%08x hsyn_para=%08x vsyn_para=%08x syn_pol=%08x "
 		 "thresholds=%08x int_mask=%08x plut=%08x\n",
 		 hw->desc[0], hw->desc[1], hw->desc[2], hw->gamma,
-		 hw->pallete, hw->cursor, hw->curs_pos, hw->diu_mode,
+		 hw->palette, hw->cursor, hw->curs_pos, hw->diu_mode,
 		 hw->bgnd, hw->disp_size, hw->hsyn_para, hw->vsyn_para,
 		 hw->syn_pol, hw->thresholds, hw->int_mask, hw->plut);
 	rmb();
diff --git a/include/linux/fsl-diu-fb.h b/include/linux/fsl-diu-fb.h
index a1e8277..c46eab5 100644
--- a/include/linux/fsl-diu-fb.h
+++ b/include/linux/fsl-diu-fb.h
@@ -73,7 +73,7 @@ struct diu_ad {
 	/* Word 0(32-bit) in DDR memory */
 /* 	__u16 comp; */
 /* 	__u16 pixel_s:2; */
-/* 	__u16 pallete:1; */
+/* 	__u16 palette:1; */
 /* 	__u16 red_c:2; */
 /* 	__u16 green_c:2; */
 /* 	__u16 blue_c:2; */
@@ -142,7 +142,7 @@ struct diu_ad {
 struct diu {
 	__be32 desc[3];
 	__be32 gamma;
-	__be32 pallete;
+	__be32 palette;
 	__be32 cursor;
 	__be32 curs_pos;
 	__be32 diu_mode;
-- 
2.10.2

