From: antoine <antoine.blin@lip6.fr>
Date: Thu, 16 Jul 2015 15:55:54 +0000
Subject: [PATCH] coding style: Fix 1 error and 5 warnings
Message-Id: <1437062154-29181-1-git-send-email-antoine.blin@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This is a patch to the ddk750_power.c file that fixes up five "line over 80
characters" warnings and one "return is not a function, parentheses are not
required" error found by the checkpatch.pl script.

Signed-off-by: Antoine BLIN <antoine.blin@lip6.fr>
---
 drivers/staging/sm750fb/ddk750_power.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index c8c51be..42961ea 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -8,7 +8,8 @@ void ddk750_setDPMS(DPMS_t state)
 
 	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
-		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
+		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL,
+		DPMS, state));
 	} else {
 		value = PEEK32(SYSTEM_CTRL);
 		value = FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
@@ -20,7 +21,7 @@ unsigned int getPowerMode(void)
 {
 	if (getChipType() = SM750LE)
 		return 0;
-	return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
+	return FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE);
 }
 
 
@@ -39,15 +40,18 @@ void setPowerMode(unsigned int powerMode)
 
 	switch (powerMode) {
 	case POWER_MODE_CTRL_MODE_MODE0:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE0);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+				MODE0);
 		break;
 
 	case POWER_MODE_CTRL_MODE_MODE1:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE1);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+				MODE1);
 		break;
 
 	case POWER_MODE_CTRL_MODE_SLEEP:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, SLEEP);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+				SLEEP);
 		break;
 
 	default:
@@ -138,8 +142,9 @@ void enableZVPort(unsigned int enable)
 		gate = FIELD_SET(gate, CURRENT_GATE, I2C,    ON);
 #endif
 	} else {
-		/* Disable ZV Port Gate. There is no way to know whether the GPIO pins are being used
-		 or not. Therefore, do not disable the GPIO gate. */
+		/* Disable ZV Port Gate. There is no way to know whether the
+		GPIO pins are being used or not. Therefore, do not disable the
+		GPIO gate. */
 		gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, OFF);
 	}
 
-- 
2.4.5

