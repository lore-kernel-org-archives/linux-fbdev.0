From: Jon Ringle <jringle@gridpoint.com>
Date: Mon, 03 Mar 2014 08:43:03 +0000
Subject: [PATCH] video: da8xx-fb: Fix casting of info->pseudo_palette
Message-Id: <1393836183-26555-1-git-send-email-jringle@gridpoint.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The casting to (u16 *) on info->pseudo_palette is wrong and causes the
display to show a blue (garbage) vertical line on every other pixel column

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/video/da8xx-fb.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d042624..83c43b2 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -678,15 +678,7 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
                        (green << info->var.green.offset) |
                        (blue << info->var.blue.offset);

-               switch (info->var.bits_per_pixel) {
-               case 16:
-                       ((u16 *) (info->pseudo_palette))[regno] = v;
-                       break;
-               case 24:
-               case 32:
-                       ((u32 *) (info->pseudo_palette))[regno] = v;
-                       break;
-               }
+               ((u32 *) (info->pseudo_palette))[regno] = v;
                if (palette[0] != 0x4000) {
                        update_hw = 1;
                        palette[0] = 0x4000;
--
1.8.5.4


The information contained in this transmission may contain confidential information.  If the reader of this message is not the intended recipient, you are hereby notified that any review, dissemination, distribution or duplication of this communication is strictly prohibited.  If you are not the intended recipient, please contact the sender by reply email and destroy all copies of the original message.
