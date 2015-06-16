From: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Date: Tue, 16 Jun 2015 05:04:01 +0000
Subject: [PATCH 1/2] Staging: sm750fb: replace spaces by tabs
Message-Id: <20150616050343.GA2643@siberianhusky>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Niranjan Dighe <ndighe@visteon.com>

This patch replaces spaces by tabs at the start of the line and in
between variable declarations.

Signed-off-by: Niranjan Dighe <ndighe@visteon.com>
---
 drivers/staging/sm750fb/ddk750_dvi.h |   60 +++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 50bcec2..c8d31f3 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -4,16 +4,16 @@
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
+	unsigned char pllFilterValue);
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
 typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
@@ -29,16 +29,16 @@ typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
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
 #define DVI_CTRL_SII164
 
@@ -46,16 +46,16 @@ typedef struct _dvi_ctrl_device_t
 
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
-- 
1.7.9.5
