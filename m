From: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Date: Sun, 14 Jun 2015 17:17:43 +0000
Subject: [PATCH] Staging: sm750fb: Fix checkpatch.pl warnings
Message-Id: <20150614171728.GA5800@codebox>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Niranjan Dighe <ndighe@visteon.com>

This patch removes spaces at the start of the line and replaces it
by tabs

Signed-off-by: Niranjan Dighe <ndighe@visteon.com>

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 50bcec2..cbd87c1 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -4,16 +4,18 @@
 /* dvi chip stuffs structros */
 
 typedef long (*PFN_DVICTRL_INIT)(
-    unsigned char edgeSelect,
-    unsigned char busSelect,
-    unsigned char dualEdgeClkSelect,
-    unsigned char hsyncEnable,
-    unsigned char vsyncEnable,
-    unsigned char deskewEnable,
-    unsigned char deskewSetting,
-    unsigned char continuousSyncEnable,
-    unsigned char pllFilterEnable,
-    unsigned char pllFilterValue);
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
+);
+
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
 typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
@@ -24,44 +26,39 @@ typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
 typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
-
-
 /* Structure to hold all the function pointer to the DVI Controller. */
 typedef struct _dvi_ctrl_device_t
 {
-    PFN_DVICTRL_INIT                pfnInit;
-    PFN_DVICTRL_RESETCHIP           pfnResetChip;
-    PFN_DVICTRL_GETCHIPSTRING       pfnGetChipString;
-    PFN_DVICTRL_GETVENDORID         pfnGetVendorId;
-    PFN_DVICTRL_GETDEVICEID         pfnGetDeviceId;
-    PFN_DVICTRL_SETPOWER            pfnSetPower;
-    PFN_DVICTRL_HOTPLUGDETECTION    pfnEnableHotPlugDetection;
-    PFN_DVICTRL_ISCONNECTED         pfnIsConnected;
-    PFN_DVICTRL_CHECKINTERRUPT      pfnCheckInterrupt;
-    PFN_DVICTRL_CLEARINTERRUPT      pfnClearInterrupt;
+	PFN_DVICTRL_INIT		pfnInit;
+	PFN_DVICTRL_RESETCHIP		pfnResetChip;
+	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
+	PFN_DVICTRL_GETVENDORID		pfnGetVendorId;
+	PFN_DVICTRL_GETDEVICEID		pfnGetDeviceId;
+	PFN_DVICTRL_SETPOWER		pfnSetPower;
+	PFN_DVICTRL_HOTPLUGDETECTION	pfnEnableHotPlugDetection;
+	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
+	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
+	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
 } dvi_ctrl_device_t;
-#define DVI_CTRL_SII164
-
 
+#define DVI_CTRL_SII164
 
 /* dvi functions prototype */
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
 );
 
 unsigned short dviGetVendorID(void);
 unsigned short dviGetDeviceID(void);
 
-
-
 #endif
 
-- 
1.9.1
