From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 15:18:38 +0000
Subject: [PATCH v2 2/2] staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"
Message-Id: <20170321150638.9175-3-arushisinghal19971997@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, speakup@linux-speakup.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com, linux-iio@vger.kernel.org, Arushi Singhal <arushisinghal19971997@gmail.com>

This patch removes typedefs from enum and renames it from "typedef enum
_spolarity_t" to "enum spolarity" as per kernel coding standards."

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
 -change the subject and commit message of PATCH.

 drivers/staging/sm750fb/ddk750_mode.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 9dc4d6c5a779..d5eae36d85cb 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -3,11 +3,10 @@
 
 #include "ddk750_chip.h"
 
-typedef enum _spolarity_t {
+enum spolarity {
 	POS = 0, /* positive */
 	NEG, /* negative */
-}
-spolarity_t;
+};
 
 struct mode_parameter {
 	/* Horizontal timing. */
@@ -15,14 +14,14 @@ struct mode_parameter {
 	unsigned long horizontal_display_end;
 	unsigned long horizontal_sync_start;
 	unsigned long horizontal_sync_width;
-	spolarity_t horizontal_sync_polarity;
+	enum spolarity horizontal_sync_polarity;
 
 	/* Vertical timing. */
 	unsigned long vertical_total;
 	unsigned long vertical_display_end;
 	unsigned long vertical_sync_start;
 	unsigned long vertical_sync_height;
-	spolarity_t vertical_sync_polarity;
+	enum spolarity vertical_sync_polarity;
 
 	/* Refresh timing. */
 	unsigned long pixel_clock;
@@ -30,7 +29,7 @@ struct mode_parameter {
 	unsigned long vertical_frequency;
 
 	/* Clock Phase. This clock phase only applies to Panel. */
-	spolarity_t clock_phase_polarity;
+	enum spolarity clock_phase_polarity;
 };
 
 int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
-- 
2.11.0

