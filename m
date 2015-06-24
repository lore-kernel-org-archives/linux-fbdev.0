From: Juston Li <juston.h.li@gmail.com>
Date: Wed, 24 Jun 2015 16:25:04 +0000
Subject: [PATCH v3 03/19] staging: sm750fb: remove space before close parenthesis
Message-Id: <1435163120-3253-3-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
In-Reply-To: <CAFow2F8Vgh93P5wmvDKcLCkiO2KkXQ14M1DXLhyeD6WTcH2RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

fixes checkpatch.pl error:
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 1069a2d..fb1c533 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -268,7 +268,7 @@ int ddk750_initHw(initchip_param_t *pInitParam)
 #endif
 
 
-	if (pInitParam->powerMode != 0 )
+	if (pInitParam->powerMode != 0)
 		pInitParam->powerMode = 0;
 	setPowerMode(pInitParam->powerMode);
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 31424b2..4ee9ceb 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -43,7 +43,7 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
-	if (x = 800 && y = 600 )
+	if (x = 800 && y = 600)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
 		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 668258c..ed82813 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -363,7 +363,7 @@ int hw_imageblit(struct lynx_accel *accel,
        Note that input pitch is BYTE value, but the 2D Pitch register uses
        pixel values. Need Byte to pixel conversion.
     */
-	if(bytePerPixel = 3 ){
+	if(bytePerPixel = 3){
 		dx *= 3;
 		width *= 3;
 		startBit *= 3;
-- 
2.4.4

