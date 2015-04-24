From: Charles Rose <charles.rose.linux@gmail.com>
Date: Fri, 24 Apr 2015 15:10:56 +0000
Subject: [PATCH v2 2/2] staging: sm750fb: cleanup indentation
Message-Id: <1429888256-18890-1-git-send-email-charles.rose.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429887612-15285-1-git-send-email-charles.rose.linux@gmail.com>
In-Reply-To: <1429887612-15285-1-git-send-email-charles.rose.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: charles.rose.linux@gmail.com

This patch fixes indentation errors/warnings reported by checkpatch.pl.

Signed-off-by: Charles Rose <charles.rose.linux@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 8e7b9d4..eac5712 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -44,21 +44,29 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
 	if (x = 800 && y = 600)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL65);
 	else if (x = 1152 && y = 864)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 720)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL74);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL74);
 	else if (x = 1280 && y = 960)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL108);
 	else if (x = 1280 && y = 1024)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL108);
 	else /* default to VGA clock */
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL25);
+		dispControl = FIELD_SET(dispControl,
+					CRT_DISPLAY_CTRL, CLK, PLL25);
 
 	/* Set bit 25:24 of display controller */
     dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CRTSELECT, CRT);
-- 
2.1.0

