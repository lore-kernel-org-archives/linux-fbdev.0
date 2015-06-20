From: Juston Li <juston.h.li@gmail.com>
Date: Sat, 20 Jun 2015 18:36:36 +0000
Subject: [PATCH 02/19] staging: sm750fb: remove spacing after open parenthesis
Message-Id: <1434825413-4994-2-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
In-Reply-To: <CAFow2F-rzu4Jywjo3JngEYDYMtuSRzS3pUFhwb5XLTWjRjmTJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl warning:
ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c  | 6 +++---
 drivers/staging/sm750fb/ddk750_mode.c  | 2 +-
 drivers/staging/sm750fb/ddk750_power.c | 8 ++++----
 drivers/staging/sm750fb/sm750_help.h   | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

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
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 8ba4f8d..ac0744e 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -43,7 +43,7 @@
 
 #define FIELD_CLEAR(reg, field) \
 ( \
-	~ _F_MASK(reg ## _ ## field) \
+	~_F_MASK(reg ## _ ## field) \
 )
 
 /* Field Macros */
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
