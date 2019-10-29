From: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Date: Tue, 29 Oct 2019 23:22:07 +0000
Subject: [PATCH 2/2] staging: sm750fb: Replace multiple spaces with tabs when it suits
Message-Id: <20191029232207.4113-3-gabrielabittencourt00@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
In-Reply-To: <20191029232207.4113-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: outreachy-kernel@googlegroups.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Cc: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>

Replace multiple spaces before some comments with one tab. Aligning the
comment with the function below it.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 5925d7c7d464..8faa601c700b 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -243,21 +243,21 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 	 */
 	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
-    /*
-     * Program pitch (distance between the 1st points of two adjacent lines).
-     * Note that input pitch is BYTE value, but the 2D Pitch register uses
-     * pixel values. Need Byte to pixel conversion.
-     */
+	/*
+	 * Program pitch (distance between the 1st points of two adjacent lines).
+	 * Note that input pitch is BYTE value, but the 2D Pitch register uses
+	 * pixel values. Need Byte to pixel conversion.
+	 */
 	write_dpr(accel, DE_PITCH,
 		  ((dPitch / Bpp << DE_PITCH_DESTINATION_SHIFT) &
 		   DE_PITCH_DESTINATION_MASK) |
 		  (sPitch / Bpp & DE_PITCH_SOURCE_MASK)); /* dpr10 */
 
-    /*
-     * Screen Window width in Pixels.
-     * 2D engine uses this value to calculate the linear address in frame buffer
-     * for a given point.
-     */
+	/*
+	 * Screen Window width in Pixels.
+	 * 2D engine uses this value to calculate the linear address in frame buffer
+	 * for a given point.
+	 */
 	write_dpr(accel, DE_WINDOW_WIDTH,
 		  ((dPitch / Bpp << DE_WINDOW_WIDTH_DST_SHIFT) &
 		   DE_WINDOW_WIDTH_DST_MASK) |
-- 
2.20.1
