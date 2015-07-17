From: Antoine BLIN <antoine.blin@lip6.fr>
Date: Fri, 17 Jul 2015 13:04:34 +0000
Subject: [PATCH 2/2] staging: sm750fb: ddk750_power.c: Split lines over 80 characters.
Message-Id: <1437138274-23146-2-git-send-email-antoine.blin@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437138274-23146-1-git-send-email-antoine.blin@lip6.fr>
In-Reply-To: <1437138274-23146-1-git-send-email-antoine.blin@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Antoine BLIN <antoine.blin@lip6.fr>

Fix up "line over 80 characters" warning found by the checkpatch.pl script.

Signed-off-by: Antoine BLIN <antoine.blin@lip6.fr>
---
 drivers/staging/sm750fb/ddk750_power.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 3c04447..e580dab 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -8,7 +8,8 @@ void ddk750_setDPMS(DPMS_t state)
 
 	if (getChipType() = SM750LE) {
 		value = PEEK32(CRT_DISPLAY_CTRL);
-		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL, DPMS, state));
+		POKE32(CRT_DISPLAY_CTRL, FIELD_VALUE(value, CRT_DISPLAY_CTRL,
+						     DPMS, state));
 	} else {
 		value = PEEK32(SYSTEM_CTRL);
 		value = FIELD_VALUE(value, SYSTEM_CTRL, DPMS, state);
@@ -39,15 +40,18 @@ void setPowerMode(unsigned int powerMode)
 
 	switch (powerMode) {
 	case POWER_MODE_CTRL_MODE_MODE0:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE0);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+					  MODE0);
 		break;
 
 	case POWER_MODE_CTRL_MODE_MODE1:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE1);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+					  MODE1);
 		break;
 
 	case POWER_MODE_CTRL_MODE_SLEEP:
-		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, SLEEP);
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE,
+					  SLEEP);
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

