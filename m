From: Phil Turnbull <phil.turnbull@oracle.com>
Date: Fri, 02 Sep 2016 19:35:31 +0000
Subject: [PATCH] staging: sm750fb: Correctly set CLOCK_PHASE bit of display controller.
Message-Id: <20160902193531.12057-1-phil.turnbull@oracle.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Commit 6fba39cf32a3 ("staging: sm750fb: use BIT macro for
PANEL_DISPLAY_CTRL single-bit fields") accidentally changed the
CLOCK_PHASE logic from '|=' to '=' which clears all the previously set
bits.

Fixes: 6fba39cf32a3 ("staging: sm750fb: use BIT macro for PANEL_DISPLAY_CTRL single-bit fields")
Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index ccb4e067661a..e29d4bd5dcec 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -63,7 +63,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	dispControl |= (CRT_DISPLAY_CTRL_CRTSELECT | CRT_DISPLAY_CTRL_RGBBIT);
 
 	/* Set bit 14 of display controller */
-	dispControl = DISPLAY_CTRL_CLOCK_PHASE;
+	dispControl |= DISPLAY_CTRL_CLOCK_PHASE;
 
 	POKE32(CRT_DISPLAY_CTRL, dispControl);
 
-- 
2.9.0.rc2

