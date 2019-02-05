From: Jin Chen <nobijinc@gmail.com>
Date: Tue, 05 Feb 2019 11:01:13 +0000
Subject: [PATCH] staging: sm750fb: Rename setDisplayControl to set_display_control - style
Message-Id: <20190205110113.GA3642@jin>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

Fix checkpatch.pl warning:
    CHECK: Avoid CamelCase: <setDisplayControl>

Signed-off-by: Jin Chen <nobijinc@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1273e7d..f38051e 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -5,7 +5,7 @@
 #include "ddk750_power.h"
 #include "ddk750_dvi.h"
 
-static void setDisplayControl(int ctrl, int disp_state)
+static void set_display_control(int ctrl, int disp_state)
 {
 	/* state != 0 means turn on both timing & plane en_bit */
 	unsigned long reg, val, reserved;
@@ -137,12 +137,12 @@ void ddk750_setLogicalDispOut(enum disp_output output)
 
 	if (output & PRI_TP_USAGE) {
 		/* set primary timing and plane en_bit */
-		setDisplayControl(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
+		set_display_control(0, (output & PRI_TP_MASK) >> PRI_TP_OFFSET);
 	}
 
 	if (output & SEC_TP_USAGE) {
 		/* set secondary timing and plane en_bit*/
-		setDisplayControl(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
+		set_display_control(1, (output & SEC_TP_MASK) >> SEC_TP_OFFSET);
 	}
 
 	if (output & PNL_SEQ_USAGE) {
-- 
1.9.1
