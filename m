From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Sat, 25 Nov 2017 18:26:35 +0000
Subject: [PATCH 1/2] staging: sm750fb: Fix coding style in ddk750_sii164.h
Message-Id: <20171125182636.15245-1-j.lacomis@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Jeremy Lacomis <j.lacomis@gmail.com>

This patch to ddk750_sii164.h fixes line length warnings found by the
checkpatch.pl script and reformats comments uniformly.

Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.h | 57 +++++++++++++--------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 2e9a88cd6af3..393a3c5be3ae 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -4,15 +4,20 @@
 
 #define USE_DVICHIP
 
-/* Hot Plug detection mode structure */
+/*
+ * Hot Plug detection mode structure:
+ *      Disable Hot Plug output bit (always high).
+ *      Use Monitor Detect Interrupt bit.
+ *      Use Receiver Sense detect bit.
+ *      Use Hot Plug detect bit.
+ */
 enum sii164_hot_plug_mode {
-	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
-	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
-	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
-	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
+	SII164_HOTPLUG_DISABLE = 0,
+	SII164_HOTPLUG_USE_MDI,
+	SII164_HOTPLUG_USE_RSEN,
+	SII164_HOTPLUG_USE_HTPLG
 };
 
-
 /* Silicon Image SiI164 chip prototype */
 long sii164InitChip(unsigned char edgeSelect,
 		    unsigned char busSelect,
@@ -28,7 +33,6 @@ long sii164InitChip(unsigned char edgeSelect,
 unsigned short sii164GetVendorID(void);
 unsigned short sii164GetDeviceID(void);
 
-
 #ifdef SII164_FULL_FUNCTIONS
 void sii164ResetChip(void);
 char *sii164GetChipString(void);
@@ -39,35 +43,26 @@ unsigned char sii164CheckInterrupt(void);
 void sii164ClearInterrupt(void);
 #endif
 /*
- * below register definition is used for
+ * The below register definition is used for the
  * Silicon Image SiI164 DVI controller chip
  */
-/*
- * Vendor ID registers
- */
+
+/* Vendor ID registers */
 #define SII164_VENDOR_ID_LOW                        0x00
 #define SII164_VENDOR_ID_HIGH                       0x01
 
-/*
- * Device ID registers
- */
+/* Device ID registers */
 #define SII164_DEVICE_ID_LOW                        0x02
 #define SII164_DEVICE_ID_HIGH                       0x03
 
-/*
- * Device Revision
- */
+/* Device Revision */
 #define SII164_DEVICE_REVISION                      0x04
 
-/*
- * Frequency Limitation registers
- */
+/* Frequency Limitation registers */
 #define SII164_FREQUENCY_LIMIT_LOW                  0x06
 #define SII164_FREQUENCY_LIMIT_HIGH                 0x07
 
-/*
- * Power Down and Input Signal Configuration registers
- */
+/* Power Down and Input Signal Configuration registers */
 #define SII164_CONFIGURATION                        0x08
 
 /* Power down (PD) */
@@ -95,9 +90,7 @@ void sii164ClearInterrupt(void);
 #define SII164_CONFIGURATION_VSYNC_FORCE_LOW        0x00
 #define SII164_CONFIGURATION_VSYNC_AS_IS            0x20
 
-/*
- * Detection registers
- */
+/* Detection registers */
 #define SII164_DETECT                               0x09
 
 /* Monitor Detect Interrupt (MDI) */
@@ -127,9 +120,7 @@ void sii164ClearInterrupt(void);
 #define SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG    0x30
 #define SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG     0x30
 
-/*
- * Skewing registers
- */
+/* Skewing registers */
 #define SII164_DESKEW                               0x0A
 
 /* General Purpose Input (CTL[3:1]) */
@@ -149,14 +140,10 @@ void sii164ClearInterrupt(void);
 #define SII164_DESKEW_7_STEP                        0xC0
 #define SII164_DESKEW_8_STEP                        0xE0
 
-/*
- * User Configuration Data registers (CFG 7:0)
- */
+/* User Configuration Data registers (CFG 7:0) */
 #define SII164_USER_CONFIGURATION                   0x0B
 
-/*
- * PLL registers
- */
+/* PLL registers */
 #define SII164_PLL                                  0x0C
 
 /* PLL Filter Value (PLLF) */
-- 
2.11.0

