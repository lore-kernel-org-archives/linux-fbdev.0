From: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Date: Sun, 14 Jun 2015 17:43:44 +0000
Subject: [PATCH] Staging: sm750fb: fix checkpatch.pl indentation warnings
Message-Id: <20150614174339.GA6105@codebox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150614171728.GA5800@codebox>
In-Reply-To: <20150614171728.GA5800@codebox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Niranjan Dighe <ndighe@visteon.com>

This patch fixes indentation issues by replacing spaces by tabs at
the start of line

Signed-off-by: Niranjan Dighe <ndighe@visteon.com>

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index b2bf7e6..c73b74a 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -1,4 +1,4 @@
-#define USE_DVICHIP 
+#define USE_DVICHIP
 #ifdef USE_DVICHIP
 #include "ddk750_help.h"
 #include "ddk750_reg.h"
@@ -12,44 +12,43 @@
 static dvi_ctrl_device_t g_dcftSupportedDviController[]  {
 #ifdef DVI_CTRL_SII164
-    {
-        .pfnInit = sii164InitChip,
-        .pfnGetVendorId = sii164GetVendorID,
-        .pfnGetDeviceId = sii164GetDeviceID,
+	{
+		.pfnInit = sii164InitChip,
+		.pfnGetVendorId = sii164GetVendorID,
+		.pfnGetDeviceId = sii164GetDeviceID,
 #ifdef SII164_FULL_FUNCTIONS
-        .pfnResetChip = sii164ResetChip,
-        .pfnGetChipString = sii164GetChipString,
-        .pfnSetPower = sii164SetPower,
-        .pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
-        .pfnIsConnected = sii164IsConnected,
-        .pfnCheckInterrupt = sii164CheckInterrupt,
-        .pfnClearInterrupt = sii164ClearInterrupt,
+		.pfnResetChip = sii164ResetChip,
+		.pfnGetChipString = sii164GetChipString,
+		.pfnSetPower = sii164SetPower,
+		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
+		.pfnIsConnected = sii164IsConnected,
+		.pfnCheckInterrupt = sii164CheckInterrupt,
+		.pfnClearInterrupt = sii164ClearInterrupt,
 #endif
-    },
+	},
 #endif
 };
 
-
 int dviInit(
-    unsigned char edgeSelect,
-    unsigned char busSelect,
-    unsigned char dualEdgeClkSelect,
-    unsigned char hsyncEnable,
-    unsigned char vsyncEnable,
-    unsigned char deskewEnable,
-    unsigned char deskewSetting,
-    unsigned char continuousSyncEnable,
-    unsigned char pllFilterEnable,
-    unsigned char pllFilterValue
-			)
+	unsigned char edgeSelect,
+	unsigned char busSelect,
+	unsigned char dualEdgeClkSelect,
+	unsigned char hsyncEnable,
+	unsigned char vsyncEnable,
+	unsigned char deskewEnable,
+	unsigned char deskewSetting,
+	unsigned char continuousSyncEnable,
+	unsigned char pllFilterEnable,
+	unsigned char pllFilterValue
+)
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if(pCurrentDviCtrl->pfnInit != NULL)
+	if (pCurrentDviCtrl->pfnInit != NULL)
 	{
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
-                              vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
-                              pllFilterEnable, pllFilterValue);
+			vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
+			pllFilterEnable, pllFilterValue);
 	}
 	return -1; /* error */
 }
@@ -64,13 +63,13 @@ int dviInit(
  */
 unsigned short dviGetVendorID(void)
 {
-    dvi_ctrl_device_t *pCurrentDviCtrl;
+	dvi_ctrl_device_t *pCurrentDviCtrl;
 
-    pCurrentDviCtrl = g_dcftSupportedDviController;
-    if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
-        return pCurrentDviCtrl->pfnGetVendorId();
+	pCurrentDviCtrl = g_dcftSupportedDviController;
+	if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
+		return pCurrentDviCtrl->pfnGetVendorId();
 
-    return 0x0000;
+	return 0x0000;
 }
 
 
@@ -83,15 +82,14 @@ unsigned short dviGetVendorID(void)
  */
 unsigned short dviGetDeviceID(void)
 {
-    dvi_ctrl_device_t *pCurrentDviCtrl;
+	dvi_ctrl_device_t *pCurrentDviCtrl;
 
 	pCurrentDviCtrl = g_dcftSupportedDviController;
-    if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
-        return pCurrentDviCtrl->pfnGetDeviceId();
+	if (pCurrentDviCtrl != (dvi_ctrl_device_t *)0)
+		return pCurrentDviCtrl->pfnGetDeviceId();
 
-    return 0x0000;
+	return 0x0000;
 }
 
 #endif
 
-
-- 
1.9.1
