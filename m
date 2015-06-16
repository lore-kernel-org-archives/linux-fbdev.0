From: "Dighe, Niranjan (N.)" <ndighe@visteon.com>
Date: Tue, 16 Jun 2015 05:05:47 +0000
Subject: [PATCH 2/2] Staging: sm750fb: correct spacing between lines of code
Message-Id: <20150616050524.GA2677@siberianhusky>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "teddy.wang@siliconmotion.com" <teddy.wang@siliconmotion.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Niranjan Dighe <ndighe@visteon.com>

This patch corrects line spacing by removing and adding newline
characters wherever necessary

Signed-off-by: Niranjan Dighe <ndighe@visteon.com>
---
 drivers/staging/sm750fb/ddk750_dvi.h |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index c8d31f3..83bbd6d 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -14,6 +14,7 @@ typedef long (*PFN_DVICTRL_INIT)(
 	unsigned char continuousSyncEnable,
 	unsigned char pllFilterEnable,
 	unsigned char pllFilterValue);
+
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
 typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
@@ -24,8 +25,6 @@ typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
 typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
-
-
 /* Structure to hold all the function pointer to the DVI Controller. */
 typedef struct _dvi_ctrl_device_t
 {
@@ -40,9 +39,8 @@ typedef struct _dvi_ctrl_device_t
 	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
 	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
 } dvi_ctrl_device_t;
-#define DVI_CTRL_SII164
-
 
+#define DVI_CTRL_SII164
 
 /* dvi functions prototype */
 int dviInit(
@@ -61,7 +59,5 @@ int dviInit(
 unsigned short dviGetVendorID(void);
 unsigned short dviGetDeviceID(void);
 
-
-
 #endif
 
-- 
1.7.9.5
