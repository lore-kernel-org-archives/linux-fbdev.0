From: Jeremy Lacomis <j.lacomis@gmail.com>
Date: Sun, 26 Nov 2017 01:04:52 +0000
Subject: [PATCH v2] Staging: sm750fb: Fix coding style issue in ddk750_sii164.c
Message-Id: <20171126010453.1598-1-j.lacomis@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1511649387.20482.5.camel@perches.com>
In-Reply-To: <1511649387.20482.5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeremy Lacomis <j.lacomis@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

This is a patch to the ddk750_sii164.c file that fixes line length warnings
found by the checkpatch.pl script

Signed-off-by: Jeremy Lacomis <j.lacomis@gmail.com>
---
Changes in v2:
- Change definition of i2cReadReg/i2cWriteReg
- Remove unnecessary casts

 drivers/staging/sm750fb/ddk750_sii164.c | 87 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index c787a74c4f9c..66092c4645fc 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -12,11 +12,13 @@
 #define USE_HW_I2C
 
 #ifdef USE_HW_I2C
-    #define i2cWriteReg sm750_hw_i2c_write_reg
-    #define i2cReadReg  sm750_hw_i2c_read_reg
+#define i2c_write_reg(reg, config) sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, \
+							  reg, config)
+#define i2c_read_reg(reg) sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, reg)
 #else
-    #define i2cWriteReg sm750_sw_i2c_write_reg
-    #define i2cReadReg  sm750_sw_i2c_read_reg
+#define i2c_write_reg(reg, config) sm750_sw_i2c_write_reg(SII164_I2C_ADDRESS, \
+							  reg, config)
+#define i2c_read_reg(reg) sm750_sw_i2c_read_reg(SII164_I2C_ADDRESS, reg)
 #endif
 
 /* SII164 Vendor and Device ID */
@@ -39,8 +41,8 @@ unsigned short sii164GetVendorID(void)
 {
 	unsigned short vendorID;
 
-	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_HIGH) << 8) |
-		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_LOW);
+	vendorID = (i2c_read_reg(SII164_VENDOR_ID_HIGH) << 8) |
+		i2c_read_reg(SII164_VENDOR_ID_LOW);
 
 	return vendorID;
 }
@@ -56,15 +58,16 @@ unsigned short sii164GetDeviceID(void)
 {
 	unsigned short deviceID;
 
-	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_HIGH) << 8) |
-		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_LOW);
+	deviceID = (i2c_read_reg(SII164_DEVICE_ID_HIGH) << 8) |
+		i2c_read_reg(SII164_DEVICE_ID_LOW);
 
 	return deviceID;
 }
 
-
-
-/* DVI.C will handle all SiI164 chip stuffs and try it best to make code minimal and useful */
+/*
+ * DVI.C will handle all SiI164 chip stuffs and try it best to make code minimal
+ * and useful
+ */
 
 /*
  *  sii164InitChip
@@ -72,10 +75,10 @@ unsigned short sii164GetDeviceID(void)
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
@@ -135,7 +138,8 @@ long sii164InitChip(unsigned char edgeSelect,
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID)) {
+	if ((sii164GetVendorID() = SII164_VENDOR_ID) &&
+	    (sii164GetDeviceID() = SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -170,7 +174,7 @@ long sii164InitChip(unsigned char edgeSelect,
 		else
 			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_CONFIGURATION, config);
 
 		/*
 		 * De-skew enabled with default 111b value.
@@ -208,7 +212,7 @@ long sii164InitChip(unsigned char edgeSelect,
 			config |= SII164_DESKEW_8_STEP;
 			break;
 		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+		i2c_write_reg(SII164_DESKEW, config);
 
 		/* Enable/Disable Continuous Sync. */
 		if (continuousSyncEnable = 0)
@@ -225,12 +229,12 @@ long sii164InitChip(unsigned char edgeSelect,
 		/* Set the PLL Filter value */
 		config |= ((pllFilterValue & 0x07) << 1);
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+		i2c_write_reg(SII164_PLL, config);
 
 		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config = i2c_read_reg(SII164_CONFIGURATION);
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_CONFIGURATION, config);
 
 		return 0;
 	}
@@ -239,10 +243,6 @@ long sii164InitChip(unsigned char edgeSelect,
 	return -1;
 }
 
-
-
-
-
 /* below sii164 function is not necessary */
 
 #ifdef SII164_FULL_FUNCTIONS
@@ -260,8 +260,8 @@ void sii164ResetChip(void)
 
 /*
  * sii164GetChipString
- *      This function returns a char string name of the current DVI Controller chip.
- *      It's convenient for application need to display the chip name.
+ *      This function returns a char string name of the current DVI Controller
+ *      chip.  It's convenient for application need to display the chip name.
  */
 char *sii164GetChipString(void)
 {
@@ -279,17 +279,17 @@ void sii164SetPower(unsigned char powerUp)
 {
 	unsigned char config;
 
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	config = i2c_read_reg(SII164_CONFIGURATION);
 	if (powerUp = 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_CONFIGURATION, config);
 	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_CONFIGURATION, config);
 	}
 }
 
@@ -302,7 +302,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = i2c_read_reg(SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hotPlugMode) {
 	case SII164_HOTPLUG_DISABLE:
@@ -321,7 +321,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2c_write_reg(SII164_DETECT, detectReg);
 }
 
 /*
@@ -334,10 +334,11 @@ void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detectReg = i2c_read_reg(SII164_DETECT);
 
-	/* Depending on each DVI controller, need to enable the hot plug based on each
-	 * individual chip design.
+	/*
+	 * Depending on each DVI controller, need to enable the hot plug based
+	 * on each individual chip design.
 	 */
 	if (enableHotPlug != 0)
 		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
@@ -357,7 +358,7 @@ unsigned char sii164IsConnected(void)
 {
 	unsigned char hotPlugValue;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	hotPlugValue = i2c_read_reg(SII164_DETECT) &
 		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
 	if (hotPlugValue = SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
@@ -377,7 +378,7 @@ unsigned char sii164CheckInterrupt(void)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = i2c_read_reg(SII164_DETECT) &
 		    SII164_DETECT_MONITOR_STATE_MASK;
 	if (detectReg = SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
@@ -394,13 +395,11 @@ void sii164ClearInterrupt(void)
 	unsigned char detectReg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	detectReg = i2c_read_reg(SII164_DETECT);
+	i2c_write_reg(SII164_DETECT,
+		      detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
-#endif
-
-#endif
-
+#endif	/* SII164_FULL_FUNCTIONS */
 
+#endif	/* USE_DVICHIP */
-- 
2.11.0

