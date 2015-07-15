From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 15 Jul 2015 04:14:31 +0000
Subject: [PATCH v5 02/19] staging: sm750fb: remove spacing after open parenthesis
Message-Id: <1436933688-5408-2-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
In-Reply-To: <CAFow2F9-0W4VRjLHmXZuv2vCwyGYRDatbCOrmg5o-AY0-nb-dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

Fixes checkpatch.pl warning:
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  | 6 +++---
 drivers/staging/sm750fb/ddk750_mode.c  | 2 +-
 drivers/staging/sm750fb/ddk750_power.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index f4975d2..1069a2d 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -599,9 +599,9 @@ unsigned int formatPllReg(pll_value_t *pPLL)
        On returning a 32 bit number, the value can be applied to any PLL in the calling function.
     */
 	ulPllReg -	FIELD_SET(  0, PANEL_PLL_CTRL, BYPASS, OFF)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, POWER,  ON)
-	| FIELD_SET(  0, PANEL_PLL_CTRL, INPUT,  OSC)
+	FIELD_SET(0, PANEL_PLL_CTRL, BYPASS, OFF)
+	| FIELD_SET(0, PANEL_PLL_CTRL, POWER,  ON)
+	| FIELD_SET(0, PANEL_PLL_CTRL, INPUT,  OSC)
 #ifndef VALIDATION_CHIP
 	| FIELD_VALUE(0, PANEL_PLL_CTRL, POD,    pPLL->POD)
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 1f93d07..31424b2 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -43,7 +43,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
-	if ( x = 800 && y = 600 )
+	if (x = 800 && y = 600 )
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index b7a108b..44b8eb1 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -59,17 +59,17 @@ void setPowerMode(unsigned int powerMode)
 	{
 		control_value  #ifdef VALIDATION_CHIP
-		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, OFF) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, OFF) |
 #endif
-		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
 	}
 	else
 	{
 		control_value  #ifdef VALIDATION_CHIP
-		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, ON) |
+		FIELD_SET(control_value, POWER_MODE_CTRL, 336CLK, ON) |
 #endif
-		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
+		FIELD_SET(control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
 	}
 
 	/* Program new power mode. */
-- 
2.4.5

