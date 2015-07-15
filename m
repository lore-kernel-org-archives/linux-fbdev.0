From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:43 +0000
Subject: [PATCH v5 14/19] staging: sm750fb: remove trailing whitespace
Message-Id: <1436933688-5408-14-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl error:
ERROR: trailing whitespace

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c  | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 4c64436..c42db85 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -1,4 +1,4 @@
-#define USE_DVICHIP 
+#define USE_DVICHIP
 #ifdef USE_DVICHIP
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 0cfe96c..db950d4 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -37,7 +37,7 @@ void hw_de_init(struct lynx_accel *accel)
 {
 	/* setup 2d engine registers */
 	u32 reg, clr;
-	
+
 	write_dpr(accel, DE_MASKS, 0xFFFFFFFF);
 
 	/* dpr1c */
@@ -82,7 +82,7 @@ void hw_de_init(struct lynx_accel *accel)
 void hw_set2dformat(struct lynx_accel *accel, int fmt)
 {
 	u32 reg;
-	
+
 	/* fmt=0,1,2 for 8,16,32,bpp on sm718/750/502 */
 	reg = read_dpr(accel, DE_STRETCH_FORMAT);
 	reg = FIELD_VALUE(reg, DE_STRETCH_FORMAT, PIXEL_FORMAT, fmt);
-- 
2.4.5

