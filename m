From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Sat, 25 Nov 2017 17:59:37 +0000
Subject: [PATCH] Staging: sm750fb: Fix coding style issue in ddk750_sii164.c
Message-Id: <20171125175937.10428-1-j.lacomis@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Jeremy Lacomis <j.lacomis@gmail.com>

This is a patch to the ddk750_sii164.c file that fixes line length warnings
found by the checkpatch.pl script

Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 39 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index c787a74c4f9c..d081ecbb3e3d 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -39,8 +39,10 @@ unsigned short sii164GetVendorID(void)
 {
 	unsigned short vendorID;
 
-	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_HIGH) << 8) |
-		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_LOW);
+	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_VENDOR_ID_HIGH) << 8) |
+		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_VENDOR_ID_LOW);
 
 	return vendorID;
 }
@@ -56,15 +58,20 @@ unsigned short sii164GetDeviceID(void)
 {
 	unsigned short deviceID;
 
-	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_HIGH) << 8) |
-		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_LOW);
+	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_DEVICE_ID_HIGH) << 8) |
+		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS,
+						SII164_DEVICE_ID_LOW);
 
 	return deviceID;
 }
 
 
 
-/* DVI.C will handle all SiI164 chip stuffs and try it best to make code minimal and useful */
+/*
+ * DVI.C will handle all SiI164 chip stuffs and try it best to make code minimal
+ * and useful
+ */
 
 /*
  *  sii164InitChip
@@ -72,10 +79,10 @@ unsigned short sii164GetDeviceID(void)
  *
  *  Input:
  *      edgeSelect          - Edge Select:
- *                              0 = Input data is falling edge latched (falling edge
- *                                  latched first in dual edge mode)
- *                              1 = Input data is rising edge latched (rising edge
- *                                  latched first in dual edge mode)
+ *                              0 = Input data is falling edge latched (falling
+ *                                  edge latched first in dual edge mode)
+ *                              1 = Input data is rising edge latched (rising
+ *                                  edge latched first in dual edge mode)
  *      busSelect           - Input Bus Select:
  *                              0 = Input data bus is 12-bits wide
  *                              1 = Input data bus is 24-bits wide
@@ -135,7 +142,8 @@ long sii164InitChip(unsigned char edgeSelect,
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID)) {
+	if ((sii164GetVendorID() = SII164_VENDOR_ID) &&
+	    (sii164GetDeviceID() = SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -260,8 +268,8 @@ void sii164ResetChip(void)
 
 /*
  * sii164GetChipString
- *      This function returns a char string name of the current DVI Controller chip.
- *      It's convenient for application need to display the chip name.
+ *      This function returns a char string name of the current DVI Controller
+ *      chip.  It's convenient for application need to display the chip name.
  */
 char *sii164GetChipString(void)
 {
@@ -336,8 +344,9 @@ void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 
 	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
 
-	/* Depending on each DVI controller, need to enable the hot plug based on each
-	 * individual chip design.
+	/*
+	 * Depending on each DVI controller, need to enable the hot plug based
+	 * on each individual chip design.
 	 */
 	if (enableHotPlug != 0)
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
@@ -402,5 +411,3 @@ void sii164ClearInterrupt(void)
 #endif
 
 #endif
-
-
-- 
2.11.0

