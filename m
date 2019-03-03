From: Yifeng Li <tomli@tomli.me>
Date: Sun, 03 Mar 2019 16:55:32 +0000
Subject: [RESEND][PATCH 2/2] staging: sm750fb: trivial Camel Case removal for setDisplayControl().
Message-Id: <20190303165532.23727-3-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190303165532.23727-1-tomli@tomli.me>
In-Reply-To: <20190303165532.23727-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Jin Chen <nobijinc@gmail.com>

Rename the function setDisplayControl() to set_display_control().
This fixes the following checkpatch.pl warning:

    CHECK: Avoid CamelCase: <setDisplayControl>

Suggested-by: Jin Chen <nobijinc@gmail.com>
Signed-off-by: Jin Chen <nobijinc@gmail.com>
[tomli@tomli.me: resent as trivial patch, reworded the commit message]
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/staging/sm750fb/ddk750_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 1273e7d18925..f38051eedb6c 100644
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
2.20.1
