From: Juston Li <juston.h.li@gmail.com>
Date: Mon, 29 Jun 2015 17:55:18 +0000
Subject: [PATCH v4 01/19] staging: sm750fb: use tabs for indentation
Message-Id: <1435600536-13135-1-git-send-email-juston.h.li@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
In-Reply-To: <CAFow2F-+fT0iRmFd+H_X-1gBmvCsgehxXeyr7A8Zk9TtfD0aBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Cc: Juston Li <juston.h.li@gmail.com>

Replace spaces with tabs for indentation to fix the checkpatch.pl error
ERROR: code indent should use tabs where possible
WARNING: please, no spaces at the start of a line

Signed-off-by: Juston Li <juston.h.li@gmail.com>
---
 drivers/staging/sm750fb/ddk750_display.c | 100 ++++----
 drivers/staging/sm750fb/ddk750_display.h |   2 +-
 drivers/staging/sm750fb/ddk750_dvi.c     |  66 +++---
 drivers/staging/sm750fb/ddk750_help.h    |   4 +-
 drivers/staging/sm750fb/ddk750_hwi2c.c   | 246 +++++++++----------
 drivers/staging/sm750fb/ddk750_mode.c    | 142 +++++------
 drivers/staging/sm750fb/ddk750_mode.h    |  46 ++--
 drivers/staging/sm750fb/ddk750_power.c   | 254 ++++++++++----------
 drivers/staging/sm750fb/ddk750_power.h   |   8 +-
 drivers/staging/sm750fb/ddk750_reg.h     |  18 +-
 drivers/staging/sm750fb/ddk750_sii164.c  | 394 +++++++++++++++----------------
 drivers/staging/sm750fb/ddk750_sii164.h  |  28 +--
 drivers/staging/sm750fb/sm750.h          |  26 +-
 drivers/staging/sm750fb/sm750_accel.c    | 370 ++++++++++++++---------------
 drivers/staging/sm750fb/sm750_accel.h    |   4 +-
 drivers/staging/sm750fb/sm750_help.h     |  26 +-
 drivers/staging/sm750fb/sm750_hw.c       |  70 +++---
 drivers/staging/sm750fb/sm750_hw.h       |  28 +--
 18 files changed, 916 insertions(+), 916 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index a3e6720..1c4049f 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -24,7 +24,7 @@ static void setDisplayControl(int ctrl, int dispState)
 			/* Timing should be enabled first before enabling the plane
 			 * because changing at the same time does not guarantee that
 			 * the plane will also enabled or disabled.
-     	     */
+			 */
 			ulDisplayCtrlReg = FIELD_SET(ulDisplayCtrlReg,
 								PANEL_DISPLAY_CTRL, TIMING, ENABLE);
 			POKE32(PANEL_DISPLAY_CTRL, ulDisplayCtrlReg);
@@ -135,8 +135,8 @@ static void waitNextVerticalSync(int ctrl, int delay)
 	if(!ctrl){
 		/* primary controller */
 
-        /* Do not wait when the Primary PLL is off or display control is already off.
-	           This will prevent the software to wait forever. */
+		/* Do not wait when the Primary PLL is off or display control is already off.
+		   This will prevent the software to wait forever. */
 		if ((FIELD_GET(PEEK32(PANEL_PLL_CTRL), PANEL_PLL_CTRL, POWER) =
 			 PANEL_PLL_CTRL_POWER_OFF) ||
 			(FIELD_GET(PEEK32(PANEL_DISPLAY_CTRL), PANEL_DISPLAY_CTRL, TIMING) =
@@ -145,26 +145,26 @@ static void waitNextVerticalSync(int ctrl, int delay)
 			return;
 		}
 
-        while (delay-- > 0)
-        {
-            /* Wait for end of vsync. */
-            do
-            {
-                status = FIELD_GET(PEEK32(SYSTEM_CTRL),
-                                   SYSTEM_CTRL,
-                                   PANEL_VSYNC);
-            }
-            while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
-
-            /* Wait for start of vsync. */
-            do
-            {
-                status = FIELD_GET(PEEK32(SYSTEM_CTRL),
-                                   SYSTEM_CTRL,
-                                   PANEL_VSYNC);
-            }
-            while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
-        }
+		while (delay-- > 0)
+		{
+			/* Wait for end of vsync. */
+			do
+			{
+				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
+						   SYSTEM_CTRL,
+						   PANEL_VSYNC);
+			}
+			while (status = SYSTEM_CTRL_PANEL_VSYNC_ACTIVE);
+
+			/* Wait for start of vsync. */
+			do
+			{
+				status = FIELD_GET(PEEK32(SYSTEM_CTRL),
+						   SYSTEM_CTRL,
+						   PANEL_VSYNC);
+			}
+			while (status = SYSTEM_CTRL_PANEL_VSYNC_INACTIVE);
+		}
 
 	}else{
 
@@ -275,33 +275,33 @@ void ddk750_setLogicalDispOut(disp_output_t output)
 
 int ddk750_initDVIDisp(void)
 {
-    /* Initialize DVI. If the dviInit fail and the VendorID or the DeviceID are
-       not zeroed, then set the failure flag. If it is zeroe, it might mean
-       that the system is in Dual CRT Monitor configuration. */
-
-    /* De-skew enabled with default 111b value.
-       This will fix some artifacts problem in some mode on board 2.2.
-       Somehow this fix does not affect board 2.1.
-     */
-    if ((dviInit(1,  /* Select Rising Edge */
-                1,  /* Select 24-bit bus */
-                0,  /* Select Single Edge clock */
-                1,  /* Enable HSync as is */
-                1,  /* Enable VSync as is */
-                1,  /* Enable De-skew */
-                7,  /* Set the de-skew setting to maximum setup */
-                1,  /* Enable continuous Sync */
-                1,  /* Enable PLL Filter */
-                4   /* Use the recommended value for PLL Filter value */
-        ) != 0) && (dviGetVendorID() != 0x0000) && (dviGetDeviceID() != 0x0000))
-    {
-        return (-1);
-    }
-
-    /* TODO: Initialize other display component */
-
-    /* Success */
-    return 0;
+	/* Initialize DVI. If the dviInit fail and the VendorID or the DeviceID are
+	   not zeroed, then set the failure flag. If it is zeroe, it might mean
+	   that the system is in Dual CRT Monitor configuration. */
+
+	/* De-skew enabled with default 111b value.
+	   This will fix some artifacts problem in some mode on board 2.2.
+	   Somehow this fix does not affect board 2.1.
+	 */
+	if ((dviInit(1,  /* Select Rising Edge */
+		     1,  /* Select 24-bit bus */
+		     0,  /* Select Single Edge clock */
+		     1,  /* Enable HSync as is */
+		     1,  /* Enable VSync as is */
+		     1,  /* Enable De-skew */
+		     7,  /* Set the de-skew setting to maximum setup */
+		     1,  /* Enable continuous Sync */
+		     1,  /* Enable PLL Filter */
+		     4   /* Use the recommended value for PLL Filter value */
+		     ) != 0) && (dviGetVendorID() != 0x0000) && (dviGetDeviceID() != 0x0000))
+	{
+		return (-1);
+	}
+
+	/* TODO: Initialize other display component */
+
+	/* Success */
+	return 0;
 
 }
 
diff --git a/drivers/staging/sm750fb/ddk750_display.h b/drivers/staging/sm750fb/ddk750_display.h
index ae0f84c..018a661 100644
--- a/drivers/staging/sm750fb/ddk750_display.h
+++ b/drivers/staging/sm750fb/ddk750_display.h
@@ -8,7 +8,7 @@
 #define PNL_2_OFFSET 0
 #define PNL_2_MASK (3 << PNL_2_OFFSET)
 #define PNL_2_USAGE	(PNL_2_MASK << 16)
-#define PNL_2_PRI 	((0 << PNL_2_OFFSET)|PNL_2_USAGE)
+#define PNL_2_PRI	((0 << PNL_2_OFFSET)|PNL_2_USAGE)
 #define PNL_2_SEC	((2 << PNL_2_OFFSET)|PNL_2_USAGE)
 
 
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index b2bf7e6..35866fa 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -12,35 +12,35 @@
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
 			)
 {
 	dvi_ctrl_device_t *pCurrentDviCtrl;
@@ -48,8 +48,8 @@ int dviInit(
 	if(pCurrentDviCtrl->pfnInit != NULL)
 	{
 		return pCurrentDviCtrl->pfnInit(edgeSelect, busSelect, dualEdgeClkSelect, hsyncEnable,
-                              vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
-                              pllFilterEnable, pllFilterValue);
+						vsyncEnable, deskewEnable, deskewSetting, continuousSyncEnable,
+						pllFilterEnable, pllFilterValue);
 	}
 	return -1; /* error */
 }
@@ -64,13 +64,13 @@ int dviInit(
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
 
 
@@ -83,13 +83,13 @@ unsigned short dviGetVendorID(void)
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
diff --git a/drivers/staging/sm750fb/ddk750_help.h b/drivers/staging/sm750fb/ddk750_help.h
index 4285b05..3b06aed 100644
--- a/drivers/staging/sm750fb/ddk750_help.h
+++ b/drivers/staging/sm750fb/ddk750_help.h
@@ -12,8 +12,8 @@
 #if 0
 /* if 718 big endian turned on,be aware that don't use this driver for general use,only for ppc big-endian */
 #warning "big endian on target cpu and enable nature big endian support of 718 capability !"
-#define PEEK32(addr)  			__raw_readl(mmio750 + addr)
-#define POKE32(addr, data) 		__raw_writel(data, mmio750 + addr)
+#define PEEK32(addr)			__raw_readl(mmio750 + addr)
+#define POKE32(addr, data)		__raw_writel(data, mmio750 + addr)
 #else /* software control endianness */
 #define PEEK32(addr) readl(addr + mmio750)
 #define POKE32(addr, data) writel(data, addr + mmio750)
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
index 7826376..7f3b1f9 100644
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ b/drivers/staging/sm750fb/ddk750_hwi2c.c
@@ -10,70 +10,70 @@
 
 
 int hwI2CInit(
-    unsigned char busSpeedMode
+unsigned char busSpeedMode
 )
 {
-    unsigned int value;
+	unsigned int value;
 
-    /* Enable GPIO 30 & 31 as IIC clock & data */
+	/* Enable GPIO 30 & 31 as IIC clock & data */
 	value = PEEK32(GPIO_MUX);
 
-    value = FIELD_SET(value, GPIO_MUX, 30, I2C) |
-			FIELD_SET(0, GPIO_MUX, 31, I2C);
+	value = FIELD_SET(value, GPIO_MUX, 30, I2C) |
+			  FIELD_SET(0, GPIO_MUX, 31, I2C);
 	POKE32(GPIO_MUX, value);
 
-    /* Enable Hardware I2C power.
-       TODO: Check if we need to enable GPIO power?
-     */
-    enableI2C(1);
-
-    /* Enable the I2C Controller and set the bus speed mode */
-    value = PEEK32(I2C_CTRL);
-    if (busSpeedMode = 0)
-        value = FIELD_SET(value, I2C_CTRL, MODE, STANDARD);
-    else
-        value = FIELD_SET(value, I2C_CTRL, MODE, FAST);
-    value = FIELD_SET(value, I2C_CTRL, EN, ENABLE);
-    POKE32(I2C_CTRL, value);
-
-    return 0;
+	/* Enable Hardware I2C power.
+	 TODO: Check if we need to enable GPIO power?
+	 */
+	enableI2C(1);
+
+	/* Enable the I2C Controller and set the bus speed mode */
+	value = PEEK32(I2C_CTRL);
+	if (busSpeedMode = 0)
+		value = FIELD_SET(value, I2C_CTRL, MODE, STANDARD);
+	else
+		value = FIELD_SET(value, I2C_CTRL, MODE, FAST);
+	value = FIELD_SET(value, I2C_CTRL, EN, ENABLE);
+	POKE32(I2C_CTRL, value);
+
+	return 0;
 }
 
 
 void hwI2CClose(void)
 {
-    unsigned int value;
+	unsigned int value;
 
-    /* Disable I2C controller */
-    value = PEEK32(I2C_CTRL);
-    value = FIELD_SET(value, I2C_CTRL, EN, DISABLE);
-    POKE32(I2C_CTRL, value);
+	/* Disable I2C controller */
+	value = PEEK32(I2C_CTRL);
+	value = FIELD_SET(value, I2C_CTRL, EN, DISABLE);
+	POKE32(I2C_CTRL, value);
 
-    /* Disable I2C Power */
-    enableI2C(0);
+	/* Disable I2C Power */
+	enableI2C(0);
 
-    /* Set GPIO 30 & 31 back as GPIO pins */
-    value = PEEK32(GPIO_MUX);
-    value = FIELD_SET(value, GPIO_MUX, 30, GPIO);
-    value = FIELD_SET(value, GPIO_MUX, 31, GPIO);
-    POKE32(GPIO_MUX, value);
+	/* Set GPIO 30 & 31 back as GPIO pins */
+	value = PEEK32(GPIO_MUX);
+	value = FIELD_SET(value, GPIO_MUX, 30, GPIO);
+	value = FIELD_SET(value, GPIO_MUX, 31, GPIO);
+	POKE32(GPIO_MUX, value);
 }
 
 
 static long hwI2CWaitTXDone(void)
 {
-    unsigned int timeout;
+	unsigned int timeout;
 
-    /* Wait until the transfer is completed. */
-    timeout = HWI2C_WAIT_TIMEOUT;
+	/* Wait until the transfer is completed. */
+	timeout = HWI2C_WAIT_TIMEOUT;
 	while ((FIELD_GET(PEEK32(I2C_STATUS), I2C_STATUS, TX) != I2C_STATUS_TX_COMPLETED) &&
-           (timeout != 0))
+	       (timeout != 0))
 		timeout--;
 
 	if (timeout = 0)
-	    return (-1);
+		return (-1);
 
-    return 0;
+	return 0;
 }
 
 
@@ -91,53 +91,53 @@ static long hwI2CWaitTXDone(void)
  *      Total number of bytes those are actually written.
  */
 static unsigned int hwI2CWriteData(
-    unsigned char deviceAddress,
-    unsigned int length,
-    unsigned char *pBuffer
+	unsigned char deviceAddress,
+	unsigned int length,
+	unsigned char *pBuffer
 )
 {
-    unsigned char count, i;
-    unsigned int totalBytes = 0;
+	unsigned char count, i;
+	unsigned int totalBytes = 0;
 
-    /* Set the Device Address */
-    POKE32(I2C_SLAVE_ADDRESS, deviceAddress & ~0x01);
+	/* Set the Device Address */
+	POKE32(I2C_SLAVE_ADDRESS, deviceAddress & ~0x01);
 
-    /* Write data.
-     * Note:
-     *      Only 16 byte can be accessed per i2c start instruction.
-     */
-    do
-    {
-        /* Reset I2C by writing 0 to I2C_RESET register to clear the previous status. */
-        POKE32(I2C_RESET, 0);
+	/* Write data.
+	 * Note:
+	 *      Only 16 byte can be accessed per i2c start instruction.
+	 */
+	do
+	{
+		/* Reset I2C by writing 0 to I2C_RESET register to clear the previous status. */
+		POKE32(I2C_RESET, 0);
 
-        /* Set the number of bytes to be written */
-        if (length < MAX_HWI2C_FIFO)
-            count = length - 1;
-        else
-            count = MAX_HWI2C_FIFO - 1;
-        POKE32(I2C_BYTE_COUNT, count);
+		/* Set the number of bytes to be written */
+		if (length < MAX_HWI2C_FIFO)
+			count = length - 1;
+		else
+			count = MAX_HWI2C_FIFO - 1;
+		POKE32(I2C_BYTE_COUNT, count);
 
-        /* Move the data to the I2C data register */
-	    for (i = 0; i <= count; i++)
-            POKE32(I2C_DATA0 + i, *pBuffer++);
+		/* Move the data to the I2C data register */
+		for (i = 0; i <= count; i++)
+			POKE32(I2C_DATA0 + i, *pBuffer++);
 
-        /* Start the I2C */
-        POKE32(I2C_CTRL, FIELD_SET(PEEK32(I2C_CTRL), I2C_CTRL, CTRL, START));
+		/* Start the I2C */
+		POKE32(I2C_CTRL, FIELD_SET(PEEK32(I2C_CTRL), I2C_CTRL, CTRL, START));
 
-        /* Wait until the transfer is completed. */
-        if (hwI2CWaitTXDone() != 0)
-            break;
+		/* Wait until the transfer is completed. */
+		if (hwI2CWaitTXDone() != 0)
+			break;
 
-        /* Substract length */
-        length -= (count + 1);
+		/* Substract length */
+		length -= (count + 1);
 
-        /* Total byte written */
-        totalBytes += (count + 1);
+		/* Total byte written */
+		totalBytes += (count + 1);
 
-    } while (length > 0);
+	} while (length > 0);
 
-    return totalBytes;
+	return totalBytes;
 }
 
 
@@ -158,53 +158,53 @@ static unsigned int hwI2CWriteData(
  *      Total number of actual bytes read from the slave device
  */
 static unsigned int hwI2CReadData(
-    unsigned char deviceAddress,
-    unsigned int length,
-    unsigned char *pBuffer
+	unsigned char deviceAddress,
+	unsigned int length,
+	unsigned char *pBuffer
 )
 {
-    unsigned char count, i;
-    unsigned int totalBytes = 0;
+	unsigned char count, i;
+	unsigned int totalBytes = 0;
 
-    /* Set the Device Address */
-    POKE32(I2C_SLAVE_ADDRESS, deviceAddress | 0x01);
+	/* Set the Device Address */
+	POKE32(I2C_SLAVE_ADDRESS, deviceAddress | 0x01);
 
-    /* Read data and save them to the buffer.
-     * Note:
-     *      Only 16 byte can be accessed per i2c start instruction.
-     */
-    do
-    {
-        /* Reset I2C by writing 0 to I2C_RESET register to clear all the status. */
-        POKE32(I2C_RESET, 0);
+	/* Read data and save them to the buffer.
+	 * Note:
+	 *      Only 16 byte can be accessed per i2c start instruction.
+	 */
+	do
+	{
+		/* Reset I2C by writing 0 to I2C_RESET register to clear all the status. */
+		POKE32(I2C_RESET, 0);
 
-        /* Set the number of bytes to be read */
-        if (length <= MAX_HWI2C_FIFO)
-            count = length - 1;
-        else
-            count = MAX_HWI2C_FIFO - 1;
-        POKE32(I2C_BYTE_COUNT, count);
+		/* Set the number of bytes to be read */
+		if (length <= MAX_HWI2C_FIFO)
+			count = length - 1;
+		else
+			count = MAX_HWI2C_FIFO - 1;
+		POKE32(I2C_BYTE_COUNT, count);
 
-        /* Start the I2C */
-        POKE32(I2C_CTRL, FIELD_SET(PEEK32(I2C_CTRL), I2C_CTRL, CTRL, START));
+		/* Start the I2C */
+		POKE32(I2C_CTRL, FIELD_SET(PEEK32(I2C_CTRL), I2C_CTRL, CTRL, START));
 
-        /* Wait until transaction done. */
-        if (hwI2CWaitTXDone() != 0)
-            break;
+		/* Wait until transaction done. */
+		if (hwI2CWaitTXDone() != 0)
+			break;
 
-        /* Save the data to the given buffer */
-        for (i = 0; i <= count; i++)
-		    *pBuffer++ = PEEK32(I2C_DATA0 + i);
+		/* Save the data to the given buffer */
+		for (i = 0; i <= count; i++)
+			*pBuffer++ = PEEK32(I2C_DATA0 + i);
 
-        /* Substract length by 16 */
-        length -= (count + 1);
+		/* Substract length by 16 */
+		length -= (count + 1);
 
-        /* Number of bytes read. */
-        totalBytes += (count + 1);
+		/* Number of bytes read. */
+		totalBytes += (count + 1);
 
-    } while (length > 0);
+	} while (length > 0);
 
-    return totalBytes;
+	return totalBytes;
 }
 
 
@@ -222,16 +222,16 @@ static unsigned int hwI2CReadData(
  *      Register value
  */
 unsigned char hwI2CReadReg(
-    unsigned char deviceAddress,
-    unsigned char registerIndex
+	unsigned char deviceAddress,
+	unsigned char registerIndex
 )
 {
-    unsigned char value = (0xFF);
+	unsigned char value = (0xFF);
 
-    if (hwI2CWriteData(deviceAddress, 1, &registerIndex) = 1)
-        hwI2CReadData(deviceAddress, 1, &value);
+	if (hwI2CWriteData(deviceAddress, 1, &registerIndex) = 1)
+		hwI2CReadData(deviceAddress, 1, &value);
 
-    return value;
+	return value;
 }
 
 
@@ -252,19 +252,19 @@ unsigned char hwI2CReadReg(
  *         -1   - Fail
  */
 int hwI2CWriteReg(
-    unsigned char deviceAddress,
-    unsigned char registerIndex,
-    unsigned char data
+	unsigned char deviceAddress,
+	unsigned char registerIndex,
+	unsigned char data
 )
 {
-    unsigned char value[2];
+	unsigned char value[2];
 
-    value[0] = registerIndex;
-    value[1] = data;
-    if (hwI2CWriteData(deviceAddress, 2, value) = 2)
-        return 0;
+	value[0] = registerIndex;
+	value[1] = data;
+	if (hwI2CWriteData(deviceAddress, 2, value) = 2)
+		return 0;
 
-    return (-1);
+	return (-1);
 }
 
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 74313ff..1f93d07 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -20,54 +20,54 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 	x = pModeParam->horizontal_display_end;
 	y = pModeParam->vertical_display_end;
 
-    /* SM750LE has to set up the top-left and bottom-right
-       registers as well.
-       Note that normal SM750/SM718 only use those two register for
-       auto-centering mode.
-    */
-    POKE32(CRT_AUTO_CENTERING_TL,
-      FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, TOP, 0)
-    | FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, LEFT, 0));
-
-    POKE32(CRT_AUTO_CENTERING_BR,
-      FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, BOTTOM, y-1)
-    | FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, RIGHT, x-1));
-
-    /* Assume common fields in dispControl have been properly set before
-       calling this function.
-       This function only sets the extra fields in dispControl.
-    */
+	/* SM750LE has to set up the top-left and bottom-right
+	   registers as well.
+	   Note that normal SM750/SM718 only use those two register for
+	   auto-centering mode.
+	 */
+	POKE32(CRT_AUTO_CENTERING_TL,
+	FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, TOP, 0)
+	| FIELD_VALUE(0, CRT_AUTO_CENTERING_TL, LEFT, 0));
+
+	POKE32(CRT_AUTO_CENTERING_BR,
+	FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, BOTTOM, y-1)
+	| FIELD_VALUE(0, CRT_AUTO_CENTERING_BR, RIGHT, x-1));
+
+	/* Assume common fields in dispControl have been properly set before
+	   calling this function.
+	   This function only sets the extra fields in dispControl.
+	 */
 
 	/* Clear bit 29:27 of display control register */
-    dispControl &= FIELD_CLEAR(CRT_DISPLAY_CTRL, CLK);
+	dispControl &= FIELD_CLEAR(CRT_DISPLAY_CTRL, CLK);
 
 	/* Set bit 29:27 of display control register for the right clock */
 	/* Note that SM750LE only need to supported 7 resoluitons. */
 	if ( x = 800 && y = 600 )
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL41);
 	else if (x = 1024 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL65);
 	else if (x = 1152 && y = 864)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 768)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL80);
 	else if (x = 1280 && y = 720)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL74);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL74);
 	else if (x = 1280 && y = 960)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
 	else if (x = 1280 && y = 1024)
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
+		dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL108);
 	else /* default to VGA clock */
-    	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL25);
+	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLK, PLL25);
 
 	/* Set bit 25:24 of display controller */
-    dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CRTSELECT, CRT);
-    dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, RGBBIT, 24BIT);
+	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CRTSELECT, CRT);
+	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, RGBBIT, 24BIT);
 
-    /* Set bit 14 of display controller */
-    dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLOCK_PHASE, ACTIVE_LOW);
+	/* Set bit 14 of display controller */
+	dispControl = FIELD_SET(dispControl, CRT_DISPLAY_CTRL, CLOCK_PHASE, ACTIVE_LOW);
 
-    POKE32(CRT_DISPLAY_CTRL, dispControl);
+	POKE32(CRT_DISPLAY_CTRL, dispControl);
 
 	return dispControl;
 }
@@ -84,21 +84,21 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 	{
 		/* programe secondary pixel clock */
 		POKE32(CRT_PLL_CTRL, formatPllReg(pll));
-        POKE32(CRT_HORIZONTAL_TOTAL,
-              FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL, TOTAL, pModeParam->horizontal_total - 1)
-            | FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL, DISPLAY_END, pModeParam->horizontal_display_end - 1));
+		POKE32(CRT_HORIZONTAL_TOTAL,
+		FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL, TOTAL, pModeParam->horizontal_total - 1)
+		| FIELD_VALUE(0, CRT_HORIZONTAL_TOTAL, DISPLAY_END, pModeParam->horizontal_display_end - 1));
 
-        POKE32(CRT_HORIZONTAL_SYNC,
-              FIELD_VALUE(0, CRT_HORIZONTAL_SYNC, WIDTH, pModeParam->horizontal_sync_width)
-            | FIELD_VALUE(0, CRT_HORIZONTAL_SYNC, START, pModeParam->horizontal_sync_start - 1));
+		POKE32(CRT_HORIZONTAL_SYNC,
+		FIELD_VALUE(0, CRT_HORIZONTAL_SYNC, WIDTH, pModeParam->horizontal_sync_width)
+		| FIELD_VALUE(0, CRT_HORIZONTAL_SYNC, START, pModeParam->horizontal_sync_start - 1));
 
-        POKE32(CRT_VERTICAL_TOTAL,
-              FIELD_VALUE(0, CRT_VERTICAL_TOTAL, TOTAL, pModeParam->vertical_total - 1)
-            | FIELD_VALUE(0, CRT_VERTICAL_TOTAL, DISPLAY_END, pModeParam->vertical_display_end - 1));
+		POKE32(CRT_VERTICAL_TOTAL,
+		FIELD_VALUE(0, CRT_VERTICAL_TOTAL, TOTAL, pModeParam->vertical_total - 1)
+		| FIELD_VALUE(0, CRT_VERTICAL_TOTAL, DISPLAY_END, pModeParam->vertical_display_end - 1));
 
-        POKE32(CRT_VERTICAL_SYNC,
-              FIELD_VALUE(0, CRT_VERTICAL_SYNC, HEIGHT, pModeParam->vertical_sync_height)
-            | FIELD_VALUE(0, CRT_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
+		POKE32(CRT_VERTICAL_SYNC,
+		FIELD_VALUE(0, CRT_VERTICAL_SYNC, HEIGHT, pModeParam->vertical_sync_height)
+		| FIELD_VALUE(0, CRT_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
 
 
 		ulTmpValue = FIELD_VALUE(0, CRT_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
@@ -125,39 +125,39 @@ static int programModeRegisters(mode_parameter_t *pModeParam, pll_value_t *pll)
 		unsigned int ulReservedBits;
 		POKE32(PANEL_PLL_CTRL, formatPllReg(pll));
 
-        POKE32(PANEL_HORIZONTAL_TOTAL,
-              FIELD_VALUE(0, PANEL_HORIZONTAL_TOTAL, TOTAL, pModeParam->horizontal_total - 1)
-            | FIELD_VALUE(0, PANEL_HORIZONTAL_TOTAL, DISPLAY_END, pModeParam->horizontal_display_end - 1));
+		POKE32(PANEL_HORIZONTAL_TOTAL,
+		FIELD_VALUE(0, PANEL_HORIZONTAL_TOTAL, TOTAL, pModeParam->horizontal_total - 1)
+		| FIELD_VALUE(0, PANEL_HORIZONTAL_TOTAL, DISPLAY_END, pModeParam->horizontal_display_end - 1));
 
-        POKE32(PANEL_HORIZONTAL_SYNC,
-              FIELD_VALUE(0, PANEL_HORIZONTAL_SYNC, WIDTH, pModeParam->horizontal_sync_width)
-            | FIELD_VALUE(0, PANEL_HORIZONTAL_SYNC, START, pModeParam->horizontal_sync_start - 1));
+		POKE32(PANEL_HORIZONTAL_SYNC,
+		FIELD_VALUE(0, PANEL_HORIZONTAL_SYNC, WIDTH, pModeParam->horizontal_sync_width)
+		| FIELD_VALUE(0, PANEL_HORIZONTAL_SYNC, START, pModeParam->horizontal_sync_start - 1));
 
-        POKE32(PANEL_VERTICAL_TOTAL,
-              FIELD_VALUE(0, PANEL_VERTICAL_TOTAL, TOTAL, pModeParam->vertical_total - 1)
-            | FIELD_VALUE(0, PANEL_VERTICAL_TOTAL, DISPLAY_END, pModeParam->vertical_display_end - 1));
+		POKE32(PANEL_VERTICAL_TOTAL,
+		FIELD_VALUE(0, PANEL_VERTICAL_TOTAL, TOTAL, pModeParam->vertical_total - 1)
+			| FIELD_VALUE(0, PANEL_VERTICAL_TOTAL, DISPLAY_END, pModeParam->vertical_display_end - 1));
 
-        POKE32(PANEL_VERTICAL_SYNC,
-              FIELD_VALUE(0, PANEL_VERTICAL_SYNC, HEIGHT, pModeParam->vertical_sync_height)
-            | FIELD_VALUE(0, PANEL_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
+		POKE32(PANEL_VERTICAL_SYNC,
+		FIELD_VALUE(0, PANEL_VERTICAL_SYNC, HEIGHT, pModeParam->vertical_sync_height)
+		| FIELD_VALUE(0, PANEL_VERTICAL_SYNC, START, pModeParam->vertical_sync_start - 1));
 
 		ulTmpValue = FIELD_VALUE(0, PANEL_DISPLAY_CTRL, VSYNC_PHASE, pModeParam->vertical_sync_polarity)|
-					FIELD_VALUE(0, PANEL_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
-					FIELD_VALUE(0, PANEL_DISPLAY_CTRL, CLOCK_PHASE, pModeParam->clock_phase_polarity)|
-					FIELD_SET(0, PANEL_DISPLAY_CTRL, TIMING, ENABLE)|
-					FIELD_SET(0, PANEL_DISPLAY_CTRL, PLANE, ENABLE);
-
-        ulReservedBits = FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_1_MASK, ENABLE) |
-                         FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_2_MASK, ENABLE) |
-                         FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_3_MASK, ENABLE)|
-                         FIELD_SET(0, PANEL_DISPLAY_CTRL, VSYNC, ACTIVE_LOW);
-
-        ulReg = (PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits)
-              & FIELD_CLEAR(PANEL_DISPLAY_CTRL, CLOCK_PHASE)
-              & FIELD_CLEAR(PANEL_DISPLAY_CTRL, VSYNC_PHASE)
-              & FIELD_CLEAR(PANEL_DISPLAY_CTRL, HSYNC_PHASE)
-              & FIELD_CLEAR(PANEL_DISPLAY_CTRL, TIMING)
-              & FIELD_CLEAR(PANEL_DISPLAY_CTRL, PLANE);
+			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, HSYNC_PHASE, pModeParam->horizontal_sync_polarity)|
+			     FIELD_VALUE(0, PANEL_DISPLAY_CTRL, CLOCK_PHASE, pModeParam->clock_phase_polarity)|
+			     FIELD_SET(0, PANEL_DISPLAY_CTRL, TIMING, ENABLE)|
+			     FIELD_SET(0, PANEL_DISPLAY_CTRL, PLANE, ENABLE);
+
+		ulReservedBits = FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_1_MASK, ENABLE) |
+				 FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_2_MASK, ENABLE) |
+				 FIELD_SET(0, PANEL_DISPLAY_CTRL, RESERVED_3_MASK, ENABLE)|
+				 FIELD_SET(0, PANEL_DISPLAY_CTRL, VSYNC, ACTIVE_LOW);
+
+		ulReg = (PEEK32(PANEL_DISPLAY_CTRL) & ~ulReservedBits)
+			& FIELD_CLEAR(PANEL_DISPLAY_CTRL, CLOCK_PHASE)
+			& FIELD_CLEAR(PANEL_DISPLAY_CTRL, VSYNC_PHASE)
+			& FIELD_CLEAR(PANEL_DISPLAY_CTRL, HSYNC_PHASE)
+			& FIELD_CLEAR(PANEL_DISPLAY_CTRL, TIMING)
+			& FIELD_CLEAR(PANEL_DISPLAY_CTRL, PLANE);
 
 
 		/* May a hardware bug or just my test chip (not confirmed).
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 4e8fab3..3548d67 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -5,35 +5,35 @@
 
 typedef enum _spolarity_t
 {
-    POS = 0, /* positive */
-    NEG, /* negative */
+	POS = 0, /* positive */
+	NEG, /* negative */
 }
 spolarity_t;
 
 
 typedef struct _mode_parameter_t
 {
-    /* Horizontal timing. */
-    unsigned long horizontal_total;
-    unsigned long horizontal_display_end;
-    unsigned long horizontal_sync_start;
-    unsigned long horizontal_sync_width;
-    spolarity_t horizontal_sync_polarity;
-
-    /* Vertical timing. */
-    unsigned long vertical_total;
-    unsigned long vertical_display_end;
-    unsigned long vertical_sync_start;
-    unsigned long vertical_sync_height;
-    spolarity_t vertical_sync_polarity;
-
-    /* Refresh timing. */
-    unsigned long pixel_clock;
-    unsigned long horizontal_frequency;
-    unsigned long vertical_frequency;
-
-    /* Clock Phase. This clock phase only applies to Panel. */
-    spolarity_t clock_phase_polarity;
+	/* Horizontal timing. */
+	unsigned long horizontal_total;
+	unsigned long horizontal_display_end;
+	unsigned long horizontal_sync_start;
+	unsigned long horizontal_sync_width;
+	spolarity_t horizontal_sync_polarity;
+
+	/* Vertical timing. */
+	unsigned long vertical_total;
+	unsigned long vertical_display_end;
+	unsigned long vertical_sync_start;
+	unsigned long vertical_sync_height;
+	spolarity_t vertical_sync_polarity;
+
+	/* Refresh timing. */
+	unsigned long pixel_clock;
+	unsigned long horizontal_frequency;
+	unsigned long vertical_frequency;
+
+	/* Clock Phase. This clock phase only applies to Panel. */
+	spolarity_t clock_phase_polarity;
 }
 mode_parameter_t;
 
diff --git a/drivers/staging/sm750fb/ddk750_power.c b/drivers/staging/sm750fb/ddk750_power.c
index 1e5f398..b7a108b 100644
--- a/drivers/staging/sm750fb/ddk750_power.c
+++ b/drivers/staging/sm750fb/ddk750_power.c
@@ -19,7 +19,7 @@ unsigned int getPowerMode(void)
 {
 	if(getChipType() = SM750LE)
 		return 0;
-    return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
+	return (FIELD_GET(PEEK32(POWER_MODE_CTRL), POWER_MODE_CTRL, MODE));
 }
 
 
@@ -29,76 +29,76 @@ unsigned int getPowerMode(void)
  */
 void setPowerMode(unsigned int powerMode)
 {
-    unsigned int control_value = 0;
+	unsigned int control_value = 0;
 
-    control_value = PEEK32(POWER_MODE_CTRL);
+	control_value = PEEK32(POWER_MODE_CTRL);
 
 	if(getChipType() = SM750LE)
 		return;
 
-    switch (powerMode)
-    {
-        case POWER_MODE_CTRL_MODE_MODE0:
-            control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE0);
-            break;
+	switch (powerMode)
+	{
+	case POWER_MODE_CTRL_MODE_MODE0:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE0);
+		break;
 
-        case POWER_MODE_CTRL_MODE_MODE1:
-            control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE1);
-            break;
+	case POWER_MODE_CTRL_MODE_MODE1:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, MODE1);
+		break;
 
-        case POWER_MODE_CTRL_MODE_SLEEP:
-            control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, SLEEP);
-            break;
+	case POWER_MODE_CTRL_MODE_SLEEP:
+		control_value = FIELD_SET(control_value, POWER_MODE_CTRL, MODE, SLEEP);
+		break;
 
-        default:
-            break;
-    }
+	default:
+		break;
+	}
 
-    /* Set up other fields in Power Control Register */
-    if (powerMode = POWER_MODE_CTRL_MODE_SLEEP)
-    {
-        control_value +	/* Set up other fields in Power Control Register */
+	if (powerMode = POWER_MODE_CTRL_MODE_SLEEP)
+	{
+		control_value  #ifdef VALIDATION_CHIP
-            FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, OFF) |
+		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, OFF) |
 #endif
-            FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
-    }
-    else
-    {
-        control_value +		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  OFF);
+	}
+	else
+	{
+		control_value  #ifdef VALIDATION_CHIP
-            FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, ON) |
+		FIELD_SET(  control_value, POWER_MODE_CTRL, 336CLK, ON) |
 #endif
-            FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
-    }
+		FIELD_SET(  control_value, POWER_MODE_CTRL, OSC_INPUT,  ON);
+	}
 
-    /* Program new power mode. */
-    POKE32(POWER_MODE_CTRL, control_value);
+	/* Program new power mode. */
+	POKE32(POWER_MODE_CTRL, control_value);
 }
 
 void setCurrentGate(unsigned int gate)
 {
-    unsigned int gate_reg;
-    unsigned int mode;
-
-    /* Get current power mode. */
-    mode = getPowerMode();
-
-    switch (mode)
-    {
-        case POWER_MODE_CTRL_MODE_MODE0:
-            gate_reg = MODE0_GATE;
-            break;
-
-        case POWER_MODE_CTRL_MODE_MODE1:
-            gate_reg = MODE1_GATE;
-            break;
-
-        default:
-            gate_reg = MODE0_GATE;
-            break;
-    }
-    POKE32(gate_reg, gate);
+	unsigned int gate_reg;
+	unsigned int mode;
+
+	/* Get current power mode. */
+	mode = getPowerMode();
+
+	switch (mode)
+	{
+	case POWER_MODE_CTRL_MODE_MODE0:
+		gate_reg = MODE0_GATE;
+		break;
+
+	case POWER_MODE_CTRL_MODE_MODE1:
+		gate_reg = MODE1_GATE;
+		break;
+
+	default:
+		gate_reg = MODE0_GATE;
+		break;
+	}
+	POKE32(gate_reg, gate);
 }
 
 
@@ -108,21 +108,21 @@ void setCurrentGate(unsigned int gate)
  */
 void enable2DEngine(unsigned int enable)
 {
-    uint32_t gate;
-
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-    {
-        gate = FIELD_SET(gate, CURRENT_GATE, DE,  ON);
-        gate = FIELD_SET(gate, CURRENT_GATE, CSC, ON);
-    }
-    else
-    {
-        gate = FIELD_SET(gate, CURRENT_GATE, DE,  OFF);
-        gate = FIELD_SET(gate, CURRENT_GATE, CSC, OFF);
-    }
-
-    setCurrentGate(gate);
+	uint32_t gate;
+
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+	{
+		gate = FIELD_SET(gate, CURRENT_GATE, DE,  ON);
+		gate = FIELD_SET(gate, CURRENT_GATE, CSC, ON);
+	}
+	else
+	{
+		gate = FIELD_SET(gate, CURRENT_GATE, DE,  OFF);
+		gate = FIELD_SET(gate, CURRENT_GATE, CSC, OFF);
+	}
+
+	setCurrentGate(gate);
 }
 
 
@@ -131,58 +131,58 @@ void enable2DEngine(unsigned int enable)
  */
 void enableZVPort(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable ZV Port Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-    {
-        gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, ON);
+	/* Enable ZV Port Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+	{
+		gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, ON);
 #if 1
-        /* Using Software I2C */
-        gate = FIELD_SET(gate, CURRENT_GATE, GPIO, ON);
+		/* Using Software I2C */
+		gate = FIELD_SET(gate, CURRENT_GATE, GPIO, ON);
 #else
-        /* Using Hardware I2C */
-        gate = FIELD_SET(gate, CURRENT_GATE, I2C,    ON);
+		/* Using Hardware I2C */
+		gate = FIELD_SET(gate, CURRENT_GATE, I2C,    ON);
 #endif
-    }
-    else
-    {
-        /* Disable ZV Port Gate. There is no way to know whether the GPIO pins are being used
-           or not. Therefore, do not disable the GPIO gate. */
-        gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, OFF);
-    }
-
-    setCurrentGate(gate);
+	}
+	else
+	{
+		/* Disable ZV Port Gate. There is no way to know whether the GPIO pins are being used
+		 or not. Therefore, do not disable the GPIO gate. */
+		gate = FIELD_SET(gate, CURRENT_GATE, ZVPORT, OFF);
+	}
+
+	setCurrentGate(gate);
 }
 
 
 void enableSSP(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable SSP Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-        gate = FIELD_SET(gate, CURRENT_GATE, SSP, ON);
-    else
-        gate = FIELD_SET(gate, CURRENT_GATE, SSP, OFF);
+	/* Enable SSP Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, SSP, ON);
+	else
+		gate = FIELD_SET(gate, CURRENT_GATE, SSP, OFF);
 
-    setCurrentGate(gate);
+	setCurrentGate(gate);
 }
 
 void enableDMA(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable DMA Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-        gate = FIELD_SET(gate, CURRENT_GATE, DMA, ON);
-    else
-        gate = FIELD_SET(gate, CURRENT_GATE, DMA, OFF);
+	/* Enable DMA Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, DMA, ON);
+	else
+		gate = FIELD_SET(gate, CURRENT_GATE, DMA, OFF);
 
-    setCurrentGate(gate);
+	setCurrentGate(gate);
 }
 
 /*
@@ -190,16 +190,16 @@ void enableDMA(unsigned int enable)
  */
 void enableGPIO(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable GPIO Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-        gate = FIELD_SET(gate, CURRENT_GATE, GPIO, ON);
-    else
-        gate = FIELD_SET(gate, CURRENT_GATE, GPIO, OFF);
+	/* Enable GPIO Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, GPIO, ON);
+	else
+		gate = FIELD_SET(gate, CURRENT_GATE, GPIO, OFF);
 
-    setCurrentGate(gate);
+	setCurrentGate(gate);
 }
 
 /*
@@ -207,16 +207,16 @@ void enableGPIO(unsigned int enable)
  */
 void enablePWM(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable PWM Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-        gate = FIELD_SET(gate, CURRENT_GATE, PWM, ON);
-    else
-        gate = FIELD_SET(gate, CURRENT_GATE, PWM, OFF);
+	/* Enable PWM Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, PWM, ON);
+	else
+		gate = FIELD_SET(gate, CURRENT_GATE, PWM, OFF);
 
-    setCurrentGate(gate);
+	setCurrentGate(gate);
 }
 
 /*
@@ -224,16 +224,16 @@ void enablePWM(unsigned int enable)
  */
 void enableI2C(unsigned int enable)
 {
-    uint32_t gate;
+	uint32_t gate;
 
-    /* Enable I2C Gate */
-    gate = PEEK32(CURRENT_GATE);
-    if (enable)
-        gate = FIELD_SET(gate, CURRENT_GATE, I2C, ON);
-    else
-        gate = FIELD_SET(gate, CURRENT_GATE, I2C, OFF);
+	/* Enable I2C Gate */
+	gate = PEEK32(CURRENT_GATE);
+	if (enable)
+		gate = FIELD_SET(gate, CURRENT_GATE, I2C, ON);
+	else
+	gate = FIELD_SET(gate, CURRENT_GATE, I2C, OFF);
 
-    setCurrentGate(gate);
+	setCurrentGate(gate);
 }
 
 
diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 4e00955..a20d438 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -3,10 +3,10 @@
 
 typedef enum _DPMS_t
 {
-    crtDPMS_ON = 0x0,
-    crtDPMS_STANDBY = 0x1,
-    crtDPMS_SUSPEND = 0x2,
-    crtDPMS_OFF = 0x3,
+	crtDPMS_ON = 0x0,
+	crtDPMS_STANDBY = 0x1,
+	crtDPMS_SUSPEND = 0x2,
+	crtDPMS_OFF = 0x3,
 }
 DPMS_t;
 
diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 1a40dc2..2995625 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -1640,9 +1640,9 @@
 /* CRT Graphics Control */
 
 #define CRT_DISPLAY_CTRL                              0x080200
-#define CRT_DISPLAY_CTRL_RESERVED_1_MASK  			  31:27
-#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_DISABLE  			  0
-#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_ENABLE 			  0x1F
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK	      31:27
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_DISABLE      0
+#define CRT_DISPLAY_CTRL_RESERVED_1_MASK_ENABLE       0x1F
 
 /* SM750LE definition */
 #define CRT_DISPLAY_CTRL_DPMS                         31:30
@@ -1664,9 +1664,9 @@
 #define CRT_DISPLAY_CTRL_SHIFT_VGA_DAC_ENABLE         0
 
 
-#define CRT_DISPLAY_CTRL_RESERVED_2_MASK 			  25:24
-#define CRT_DISPLAY_CTRL_RESERVED_2_MASK_ENABLE 			  3
-#define CRT_DISPLAY_CTRL_RESERVED_2_MASK_DISABLE 			  0
+#define CRT_DISPLAY_CTRL_RESERVED_2_MASK	      25:24
+#define CRT_DISPLAY_CTRL_RESERVED_2_MASK_ENABLE	      3
+#define CRT_DISPLAY_CTRL_RESERVED_2_MASK_DISABLE      0
 
 /* SM750LE definition */
 #define CRT_DISPLAY_CTRL_CRTSELECT                    25:25
@@ -1677,11 +1677,11 @@
 #define CRT_DISPLAY_CTRL_RGBBIT_12BIT                 1
 
 
-#define CRT_DISPLAY_CTRL_RESERVED_3_MASK 			  15:15
+#define CRT_DISPLAY_CTRL_RESERVED_3_MASK	      15:15
 #define CRT_DISPLAY_CTRL_RESERVED_3_MASK_DISABLE      0
 #define CRT_DISPLAY_CTRL_RESERVED_3_MASK_ENABLE       1
 
-#define CRT_DISPLAY_CTRL_RESERVED_4_MASK 			  9:9
+#define CRT_DISPLAY_CTRL_RESERVED_4_MASK	      9:9
 #define CRT_DISPLAY_CTRL_RESERVED_4_MASK_DISABLE      0
 #define CRT_DISPLAY_CTRL_RESERVED_4_MASK_ENABLE       1
 
@@ -1882,7 +1882,7 @@
 #endif
 
 /* sm750le new register to control panel output */
-#define DISPLAY_CONTROL_750LE 	0x80288
+#define DISPLAY_CONTROL_750LE			      0x80288
 /* Palette RAM */
 
 /* Panel Palette register starts at 0x080400 ~ 0x0807FC */
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index b6395b8..7f58fbe 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -36,12 +36,12 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
  */
 unsigned short sii164GetVendorID(void)
 {
-    unsigned short vendorID;
+	unsigned short vendorID;
 
-    vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_HIGH) << 8) |
-                (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_LOW);
+	vendorID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_HIGH) << 8) |
+		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_VENDOR_ID_LOW);
 
-    return vendorID;
+	return vendorID;
 }
 
 /*
@@ -53,12 +53,12 @@ unsigned short sii164GetVendorID(void)
  */
 unsigned short sii164GetDeviceID(void)
 {
-    unsigned short deviceID;
+	unsigned short deviceID;
 
-    deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_HIGH) << 8) |
-                (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_LOW);
+	deviceID = ((unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_HIGH) << 8) |
+		    (unsigned short) i2cReadReg(SII164_I2C_ADDRESS, SII164_DEVICE_ID_LOW);
 
-    return deviceID;
+	return deviceID;
 }
 
 
@@ -113,132 +113,132 @@ unsigned short sii164GetDeviceID(void)
  *     -1   - Fail.
  */
 long sii164InitChip(
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
 )
 {
 	unsigned char config;
 
-    /* Initialize the i2c bus */
+	/* Initialize the i2c bus */
 #ifdef USE_HW_I2C
-    /* Use fast mode. */
-    hwI2CInit(1);
+	/* Use fast mode. */
+	hwI2CInit(1);
 #else
-    swI2CInit(DEFAULT_I2C_SCL, DEFAULT_I2C_SDA);
+	swI2CInit(DEFAULT_I2C_SCL, DEFAULT_I2C_SDA);
 #endif
 
-    /* Check if SII164 Chip exists */
-    if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
-    {
-        /*
-         *  Initialize SII164 controller chip.
-         */
-
-        /* Select the edge */
-        if (edgeSelect = 0)
-            config = SII164_CONFIGURATION_LATCH_FALLING;
-        else
-            config = SII164_CONFIGURATION_LATCH_RISING;
-
-        /* Select bus wide */
-        if (busSelect = 0)
-            config |= SII164_CONFIGURATION_BUS_12BITS;
-        else
-            config |= SII164_CONFIGURATION_BUS_24BITS;
-
-        /* Select Dual/Single Edge Clock */
-        if (dualEdgeClkSelect = 0)
-            config |= SII164_CONFIGURATION_CLOCK_SINGLE;
-        else
-            config |= SII164_CONFIGURATION_CLOCK_DUAL;
-
-        /* Select HSync Enable */
-        if (hsyncEnable = 0)
-            config |= SII164_CONFIGURATION_HSYNC_FORCE_LOW;
-        else
-            config |= SII164_CONFIGURATION_HSYNC_AS_IS;
-
-        /* Select VSync Enable */
-        if (vsyncEnable = 0)
-            config |= SII164_CONFIGURATION_VSYNC_FORCE_LOW;
-        else
-            config |= SII164_CONFIGURATION_VSYNC_AS_IS;
-
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-
-        /* De-skew enabled with default 111b value.
-           This will fix some artifacts problem in some mode on board 2.2.
-           Somehow this fix does not affect board 2.1.
-         */
-        if (deskewEnable = 0)
-            config = SII164_DESKEW_DISABLE;
-        else
-            config = SII164_DESKEW_ENABLE;
-
-        switch (deskewSetting)
-        {
-            case 0:
-                config |= SII164_DESKEW_1_STEP;
-                break;
-            case 1:
-                config |= SII164_DESKEW_2_STEP;
-                break;
-            case 2:
-                config |= SII164_DESKEW_3_STEP;
-                break;
-            case 3:
-                config |= SII164_DESKEW_4_STEP;
-                break;
-            case 4:
-                config |= SII164_DESKEW_5_STEP;
-                break;
-            case 5:
-                config |= SII164_DESKEW_6_STEP;
-                break;
-            case 6:
-                config |= SII164_DESKEW_7_STEP;
-                break;
-            case 7:
-                config |= SII164_DESKEW_8_STEP;
-                break;
-        }
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
-
-        /* Enable/Disable Continuous Sync. */
-        if (continuousSyncEnable = 0)
-            config = SII164_PLL_FILTER_SYNC_CONTINUOUS_DISABLE;
-        else
-            config = SII164_PLL_FILTER_SYNC_CONTINUOUS_ENABLE;
-
-        /* Enable/Disable PLL Filter */
-        if (pllFilterEnable = 0)
-            config |= SII164_PLL_FILTER_DISABLE;
-        else
-            config |= SII164_PLL_FILTER_ENABLE;
-
-        /* Set the PLL Filter value */
-        config |= ((pllFilterValue & 0x07) << 1);
-
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
-
-        /* Recover from Power Down and enable output. */
-        config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-        config |= SII164_CONFIGURATION_POWER_NORMAL;
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-
-        return 0;
-    }
-
-    /* Return -1 if initialization fails. */
-    return (-1);
+	/* Check if SII164 Chip exists */
+	if ((sii164GetVendorID() = SII164_VENDOR_ID) && (sii164GetDeviceID() = SII164_DEVICE_ID))
+	{
+		/*
+		 *  Initialize SII164 controller chip.
+		 */
+
+		/* Select the edge */
+		if (edgeSelect = 0)
+			config = SII164_CONFIGURATION_LATCH_FALLING;
+		else
+			config = SII164_CONFIGURATION_LATCH_RISING;
+
+		/* Select bus wide */
+		if (busSelect = 0)
+			config |= SII164_CONFIGURATION_BUS_12BITS;
+		else
+			config |= SII164_CONFIGURATION_BUS_24BITS;
+
+		/* Select Dual/Single Edge Clock */
+		if (dualEdgeClkSelect = 0)
+			config |= SII164_CONFIGURATION_CLOCK_SINGLE;
+		else
+			config |= SII164_CONFIGURATION_CLOCK_DUAL;
+
+		/* Select HSync Enable */
+		if (hsyncEnable = 0)
+			config |= SII164_CONFIGURATION_HSYNC_FORCE_LOW;
+		else
+			config |= SII164_CONFIGURATION_HSYNC_AS_IS;
+
+		/* Select VSync Enable */
+		if (vsyncEnable = 0)
+			config |= SII164_CONFIGURATION_VSYNC_FORCE_LOW;
+		else
+			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
+
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+
+		/* De-skew enabled with default 111b value.
+		   This will fix some artifacts problem in some mode on board 2.2.
+		   Somehow this fix does not affect board 2.1.
+		 */
+		if (deskewEnable = 0)
+			config = SII164_DESKEW_DISABLE;
+		else
+			config = SII164_DESKEW_ENABLE;
+
+		switch (deskewSetting)
+		{
+		case 0:
+			config |= SII164_DESKEW_1_STEP;
+			break;
+		case 1:
+			config |= SII164_DESKEW_2_STEP;
+			break;
+		case 2:
+			config |= SII164_DESKEW_3_STEP;
+			break;
+		case 3:
+			config |= SII164_DESKEW_4_STEP;
+			break;
+		case 4:
+			config |= SII164_DESKEW_5_STEP;
+			break;
+		case 5:
+			config |= SII164_DESKEW_6_STEP;
+			break;
+		case 6:
+			config |= SII164_DESKEW_7_STEP;
+			break;
+		case 7:
+			config |= SII164_DESKEW_8_STEP;
+			break;
+		}
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+
+		/* Enable/Disable Continuous Sync. */
+		if (continuousSyncEnable = 0)
+			config = SII164_PLL_FILTER_SYNC_CONTINUOUS_DISABLE;
+		else
+			config = SII164_PLL_FILTER_SYNC_CONTINUOUS_ENABLE;
+
+		/* Enable/Disable PLL Filter */
+		if (pllFilterEnable = 0)
+			config |= SII164_PLL_FILTER_DISABLE;
+		else
+			config |= SII164_PLL_FILTER_ENABLE;
+
+		/* Set the PLL Filter value */
+		config |= ((pllFilterValue & 0x07) << 1);
+
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+
+		/* Recover from Power Down and enable output. */
+		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config |= SII164_CONFIGURATION_POWER_NORMAL;
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+
+		return 0;
+	}
+
+	/* Return -1 if initialization fails. */
+	return (-1);
 }
 
 
@@ -255,9 +255,9 @@ long sii164InitChip(
  */
 void sii164ResetChip(void)
 {
-    /* Power down */
-    sii164SetPower(0);
-    sii164SetPower(1);
+	/* Power down */
+	sii164SetPower(0);
+	sii164SetPower(1);
 }
 
 
@@ -268,7 +268,7 @@ void sii164ResetChip(void)
  */
 char *sii164GetChipString(void)
 {
-    return gDviCtrlChipName;
+	return gDviCtrlChipName;
 }
 
 
@@ -280,26 +280,26 @@ char *sii164GetChipString(void)
  *      powerUp - Flag to set the power down or up
  */
 void sii164SetPower(
-    unsigned char powerUp
+	unsigned char powerUp
 )
 {
-    unsigned char config;
-
-    config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-    if (powerUp = 1)
-    {
-        /* Power up the chip */
-        config &= ~SII164_CONFIGURATION_POWER_MASK;
-        config |= SII164_CONFIGURATION_POWER_NORMAL;
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-    }
-    else
-    {
-        /* Power down the chip */
-        config &= ~SII164_CONFIGURATION_POWER_MASK;
-        config |= SII164_CONFIGURATION_POWER_DOWN;
-        i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-    }
+	unsigned char config;
+
+	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	if (powerUp = 1)
+	{
+		/* Power up the chip */
+		config &= ~SII164_CONFIGURATION_POWER_MASK;
+		config |= SII164_CONFIGURATION_POWER_NORMAL;
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+	}
+	else
+	{
+		/* Power down the chip */
+		config &= ~SII164_CONFIGURATION_POWER_MASK;
+		config |= SII164_CONFIGURATION_POWER_DOWN;
+		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+	}
 }
 
 
@@ -308,31 +308,31 @@ void sii164SetPower(
  *      This function selects the mode of the hot plug detection.
  */
 static void sii164SelectHotPlugDetectionMode(
-    sii164_hot_plug_mode_t hotPlugMode
+	sii164_hot_plug_mode_t hotPlugMode
 )
 {
-    unsigned char detectReg;
-
-    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-    switch (hotPlugMode)
-    {
-        case SII164_HOTPLUG_DISABLE:
-            detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
-            break;
-        case SII164_HOTPLUG_USE_MDI:
-            detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-            detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-            detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
-            break;
-        case SII164_HOTPLUG_USE_RSEN:
-            detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
-            break;
-        case SII164_HOTPLUG_USE_HTPLG:
-            detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
-            break;
-    }
-
-    i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	unsigned char detectReg;
+
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
+	switch (hotPlugMode)
+	{
+	case SII164_HOTPLUG_DISABLE:
+		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		break;
+	case SII164_HOTPLUG_USE_MDI:
+		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		break;
+	case SII164_HOTPLUG_USE_RSEN:
+		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		break;
+	case SII164_HOTPLUG_USE_HTPLG:
+		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		break;
+	}
+
+	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
 }
 
 /*
@@ -342,18 +342,18 @@ static void sii164SelectHotPlugDetectionMode(
  *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
  */
 void sii164EnableHotPlugDetection(
-    unsigned char enableHotPlug
+	unsigned char enableHotPlug
 )
 {
-    unsigned char detectReg;
-    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-
-    /* Depending on each DVI controller, need to enable the hot plug based on each
-       individual chip design. */
-    if (enableHotPlug != 0)
-        sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
-    else
-        sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+	unsigned char detectReg;
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+
+	/* Depending on each DVI controller, need to enable the hot plug based on each
+	   individual chip design. */
+	if (enableHotPlug != 0)
+		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+	else
+		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
@@ -366,13 +366,13 @@ void sii164EnableHotPlugDetection(
  */
 unsigned char sii164IsConnected(void)
 {
-    unsigned char hotPlugValue;
+	unsigned char hotPlugValue;
 
-    hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_HOT_PLUG_STATUS_MASK;
-    if (hotPlugValue = SII164_DETECT_HOT_PLUG_STATUS_ON)
-        return 1;
-    else
-        return 0;
+	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	if (hotPlugValue = SII164_DETECT_HOT_PLUG_STATUS_ON)
+		return 1;
+	else
+		return 0;
 }
 
 /*
@@ -385,13 +385,13 @@ unsigned char sii164IsConnected(void)
  */
 unsigned char sii164CheckInterrupt(void)
 {
-    unsigned char detectReg;
+	unsigned char detectReg;
 
-    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_MONITOR_STATE_MASK;
-    if (detectReg = SII164_DETECT_MONITOR_STATE_CHANGE)
-        return 1;
-    else
-        return 0;
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) & SII164_DETECT_MONITOR_STATE_MASK;
+	if (detectReg = SII164_DETECT_MONITOR_STATE_CHANGE)
+		return 1;
+	else
+		return 0;
 }
 
 /*
@@ -400,11 +400,11 @@ unsigned char sii164CheckInterrupt(void)
  */
 void sii164ClearInterrupt(void)
 {
-    unsigned char detectReg;
+	unsigned char detectReg;
 
-    /* Clear the MDI interrupt */
-    detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-    i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	/* Clear the MDI interrupt */
+	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index 2b4c7d3..0996a32 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -6,25 +6,25 @@
 /* Hot Plug detection mode structure */
 typedef enum _sii164_hot_plug_mode_t
 {
-    SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
-    SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
-    SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
-    SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
+	SII164_HOTPLUG_DISABLE = 0,         /* Disable Hot Plug output bit (always high). */
+	SII164_HOTPLUG_USE_MDI,             /* Use Monitor Detect Interrupt bit. */
+	SII164_HOTPLUG_USE_RSEN,            /* Use Receiver Sense detect bit. */
+	SII164_HOTPLUG_USE_HTPLG            /* Use Hot Plug detect bit. */
 } sii164_hot_plug_mode_t;
 
 
 /* Silicon Image SiI164 chip prototype */
 long sii164InitChip(
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
 
 unsigned short sii164GetVendorID(void);
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index cc80580..71e9a7a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -5,7 +5,7 @@
 
 #define FB_ACCEL_SMI 0xab
 /* please use revision id to distinguish sm750le and sm750*/
-#define SPC_SM750 	0
+#define SPC_SM750 0
 
 #define MB(x) ((x)<<20)
 #define MHZ(x) ((x) * 1000000)
@@ -38,8 +38,8 @@ struct lynx_accel{
 
 };
 
-/* 	lynx_share stands for a presentation of two frame buffer
-	that use one smi adaptor , it is similar to a basic class of C++
+/* lynx_share stands for a presentation of two frame buffer
+   that use one smi adaptor , it is similar to a basic class of C++
 */
 struct lynx_share{
 	/* common members */
@@ -115,7 +115,7 @@ struct lynxfb_crtc{
 	int(*proc_checkMode)(struct lynxfb_crtc*, struct fb_var_screeninfo*);
 	int(*proc_setColReg)(struct lynxfb_crtc*, ushort, ushort, ushort, ushort);
 	void (*clear)(struct lynxfb_crtc*);
-        /* pan display */
+	/* pan display */
 	int (*proc_panDisplay)(struct lynxfb_crtc *,
 			       const struct fb_var_screeninfo *,
 			       const struct fb_info *);
@@ -126,17 +126,17 @@ struct lynxfb_crtc{
 struct lynxfb_output{
 	int dpms;
 	int paths;
-	/* 	which paths(s) this output stands for,for sm750:
-		paths=1:means output for panel paths
-		paths=2:means output for crt paths
-		paths=3:means output for both panel and crt paths
+	/* which paths(s) this output stands for,for sm750:
+	   paths=1:means output for panel paths
+	   paths=2:means output for crt paths
+	   paths=3:means output for both panel and crt paths
 	*/
 
 	int *channel;
-	/* 	which channel these outputs linked with,for sm750:
-		*channel=0 means primary channel
-		*channel=1 means secondary channel
-		output->channel => &crtc->channel
+	/* which channel these outputs linked with,for sm750:
+	   *channel=0 means primary channel
+	   *channel=1 means secondary channel
+	   output->channel => &crtc->channel
 	*/
 	void *priv;
 
@@ -165,7 +165,7 @@ struct lynxfb_par{
 
 
 #define PS_TO_HZ(ps)	\
-			({ 	\
+			({ \
 			unsigned long long hz = 1000*1000*1000*1000ULL;	\
 			do_div(hz, ps);	\
 			(unsigned long)hz;})
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 6eee4cd..668258c 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -151,97 +151,97 @@ unsigned int width,
 unsigned int height, /* width and height of rectangle in pixel value */
 unsigned int rop2)   /* ROP value */
 {
-    unsigned int nDirection, de_ctrl;
-    int opSign;
-    nDirection = LEFT_TO_RIGHT;
+	unsigned int nDirection, de_ctrl;
+	int opSign;
+	nDirection = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
-    opSign = 1;
-    de_ctrl = 0;
-
-    /* If source and destination are the same surface, need to check for overlay cases */
-    if (sBase = dBase && sPitch = dPitch)
-    {
-        /* Determine direction of operation */
-        if (sy < dy)
-        {
-            /* +----------+
-               |S         |
-               |   +----------+
-               |   |      |   |
-               |   |      |   |
-               +---|------+   |
-                   |         D|
-                   +----------+ */
-
-            nDirection = BOTTOM_TO_TOP;
-        }
-        else if (sy > dy)
-        {
-            /* +----------+
-               |D         |
-               |   +----------+
-               |   |      |   |
-               |   |      |   |
-               +---|------+   |
-                   |         S|
-                   +----------+ */
-
-            nDirection = TOP_TO_BOTTOM;
-        }
-        else
-        {
-            /* sy = dy */
-
-            if (sx <= dx)
-            {
-                /* +------+---+------+
-                   |S     |   |     D|
-                   |      |   |      |
-                   |      |   |      |
-                   |      |   |      |
-                   +------+---+------+ */
-
-                nDirection = RIGHT_TO_LEFT;
-            }
-            else
-            {
-                /* sx > dx */
-
-                /* +------+---+------+
-                   |D     |   |     S|
-                   |      |   |      |
-                   |      |   |      |
-                   |      |   |      |
-                   +------+---+------+ */
-
-                nDirection = LEFT_TO_RIGHT;
-            }
-        }
-    }
-
-    if ((nDirection = BOTTOM_TO_TOP) || (nDirection = RIGHT_TO_LEFT))
-    {
-        sx += width - 1;
-        sy += height - 1;
-        dx += width - 1;
-        dy += height - 1;
-        opSign = (-1);
-    }
-
-    /* Note:
-       DE_FOREGROUND are DE_BACKGROUND are don't care.
-       DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS are set by set deSetTransparency().
-    */
+	opSign = 1;
+	de_ctrl = 0;
 
-    /* 2D Source Base.
-       It is an address offset (128 bit aligned) from the beginning of frame buffer.
-    */
-    write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
+	/* If source and destination are the same surface, need to check for overlay cases */
+	if (sBase = dBase && sPitch = dPitch)
+	{
+		/* Determine direction of operation */
+		if (sy < dy)
+		{
+			/* +----------+
+			   |S         |
+			   |   +----------+
+			   |   |      |   |
+			   |   |      |   |
+			   +---|------+   |
+			   |         D|
+			   +----------+ */
+
+			nDirection = BOTTOM_TO_TOP;
+		}
+		else if (sy > dy)
+		{
+			/* +----------+
+			   |D         |
+			   |   +----------+
+			   |   |      |   |
+			   |   |      |   |
+			   +---|------+   |
+			   |         S|
+			   +----------+ */
+
+			nDirection = TOP_TO_BOTTOM;
+		}
+		else
+		{
+			/* sy = dy */
+
+			if (sx <= dx)
+			{
+				/* +------+---+------+
+				   |S     |   |     D|
+				   |      |   |      |
+				   |      |   |      |
+				   |      |   |      |
+				   +------+---+------+ */
+
+				nDirection = RIGHT_TO_LEFT;
+			}
+			else
+			{
+			/* sx > dx */
+
+				/* +------+---+------+
+				   |D     |   |     S|
+				   |      |   |      |
+				   |      |   |      |
+				   |      |   |      |
+				   +------+---+------+ */
+
+				nDirection = LEFT_TO_RIGHT;
+			}
+		}
+	}
 
-    /* 2D Destination Base.
-       It is an address offset (128 bit aligned) from the beginning of frame buffer.
-    */
-    write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
+	if ((nDirection = BOTTOM_TO_TOP) || (nDirection = RIGHT_TO_LEFT))
+	{
+		sx += width - 1;
+		sy += height - 1;
+		dx += width - 1;
+		dy += height - 1;
+		opSign = (-1);
+	}
+
+	/* Note:
+	   DE_FOREGROUND are DE_BACKGROUND are don't care.
+	  DE_COLOR_COMPARE and DE_COLOR_COMPARE_MAKS are set by set deSetTransparency().
+	 */
+
+	/* 2D Source Base.
+	 It is an address offset (128 bit aligned) from the beginning of frame buffer.
+	 */
+	write_dpr(accel, DE_WINDOW_SOURCE_BASE, sBase); /* dpr40 */
+
+	/* 2D Destination Base.
+	 It is an address offset (128 bit aligned) from the beginning of frame buffer.
+	 */
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase); /* dpr44 */
 
 #if 0
     /* Program pitch (distance between the 1st points of two adjacent lines).
@@ -267,54 +267,54 @@ unsigned int rop2)   /* ROP value */
     /* Screen Window width in Pixels.
        2D engine uses this value to calculate the linear address in frame buffer for a given point.
     */
-    write_dpr(accel, DE_WINDOW_WIDTH,
-        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
-        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
+	write_dpr(accel, DE_WINDOW_WIDTH,
+	FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/Bpp)) |
+	FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (sPitch/Bpp))); /* dpr3c */
 
 	if (accel->de_wait() != 0){
 		return -1;
 	}
 
-    {
-
-        write_dpr(accel, DE_SOURCE,
-            FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
-            FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
-            FIELD_VALUE(0, DE_SOURCE, Y_K2, sy)); /* dpr0 */
-        write_dpr(accel, DE_DESTINATION,
-            FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
-            FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
-            FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
-        write_dpr(accel, DE_DIMENSION,
-            FIELD_VALUE(0, DE_DIMENSION, X,    width) |
-            FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
-
-        de_ctrl -            FIELD_VALUE(0, DE_CONTROL, ROP, rop2) |
-            FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
-            FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
-            ((nDirection = RIGHT_TO_LEFT) ?
-            FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
-            : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
-            FIELD_SET(0, DE_CONTROL, STATUS, START);
-		write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
-    }
-
-    return 0;
+	{
+
+	write_dpr(accel, DE_SOURCE,
+		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE) |
+		  FIELD_VALUE(0, DE_SOURCE, X_K1, sx)   |
+		  FIELD_VALUE(0, DE_SOURCE, Y_K2, sy)); /* dpr0 */
+	write_dpr(accel, DE_DESTINATION,
+		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)  |
+		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
+	write_dpr(accel, DE_DIMENSION,
+		  FIELD_VALUE(0, DE_DIMENSION, X,    width) |
+		  FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
+
+	de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, rop2) |
+		  FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2) |
+		  FIELD_SET(0, DE_CONTROL, COMMAND, BITBLT) |
+		  ((nDirection = RIGHT_TO_LEFT) ?
+		  FIELD_SET(0, DE_CONTROL, DIRECTION, RIGHT_TO_LEFT)
+		  : FIELD_SET(0, DE_CONTROL, DIRECTION, LEFT_TO_RIGHT)) |
+		  FIELD_SET(0, DE_CONTROL, STATUS, START);
+	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
+
+	}
+
+	return 0;
 }
 
 static unsigned int deGetTransparency(struct lynx_accel *accel)
 {
-    unsigned int de_ctrl;
+	unsigned int de_ctrl;
 
-    de_ctrl = read_dpr(accel, DE_CONTROL);
+	de_ctrl = read_dpr(accel, DE_CONTROL);
 
-    de_ctrl &-        FIELD_MASK(DE_CONTROL_TRANSPARENCY_MATCH) |
-        FIELD_MASK(DE_CONTROL_TRANSPARENCY_SELECT)|
-        FIELD_MASK(DE_CONTROL_TRANSPARENCY);
+	de_ctrl &+		   FIELD_MASK(DE_CONTROL_TRANSPARENCY_MATCH) |
+		   FIELD_MASK(DE_CONTROL_TRANSPARENCY_SELECT)|
+		   FIELD_MASK(DE_CONTROL_TRANSPARENCY);
 
-    return de_ctrl;
+	return de_ctrl;
 }
 
 int hw_imageblit(struct lynx_accel *accel,
@@ -332,32 +332,32 @@ int hw_imageblit(struct lynx_accel *accel,
 		 u32 bColor,   /* Background color (corresponding to a 0 in the monochrome data */
 		 u32 rop2)     /* ROP value */
 {
-    unsigned int ulBytesPerScan;
-    unsigned int ul4BytesPerScan;
-    unsigned int ulBytesRemain;
-    unsigned int de_ctrl = 0;
-    unsigned char ajRemain[4];
-    int i, j;
-
-    startBit &= 7; /* Just make sure the start bit is within legal range */
-    ulBytesPerScan = (width + startBit + 7) / 8;
-    ul4BytesPerScan = ulBytesPerScan & ~3;
-    ulBytesRemain = ulBytesPerScan & 3;
+	unsigned int ulBytesPerScan;
+	unsigned int ul4BytesPerScan;
+	unsigned int ulBytesRemain;
+	unsigned int de_ctrl = 0;
+	unsigned char ajRemain[4];
+	int i, j;
+
+	startBit &= 7; /* Just make sure the start bit is within legal range */
+	ulBytesPerScan = (width + startBit + 7) / 8;
+	ul4BytesPerScan = ulBytesPerScan & ~3;
+	ulBytesRemain = ulBytesPerScan & 3;
 
 	if(accel->de_wait() != 0)
-    {
-        return -1;
-    }
+	{
+		return -1;
+	}
 
-    /* 2D Source Base.
-       Use 0 for HOST Blt.
-    */
-    write_dpr(accel, DE_WINDOW_SOURCE_BASE, 0);
+	/* 2D Source Base.
+	 Use 0 for HOST Blt.
+	 */
+	write_dpr(accel, DE_WINDOW_SOURCE_BASE, 0);
 
-    /* 2D Destination Base.
-       It is an address offset (128 bit aligned) from the beginning of frame buffer.
-    */
-    write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
+	/* 2D Destination Base.
+	 It is an address offset (128 bit aligned) from the beginning of frame buffer.
+	 */
+	write_dpr(accel, DE_WINDOW_DESTINATION_BASE, dBase);
 #if 0
     /* Program pitch (distance between the 1st points of two adjacent lines).
        Note that input pitch is BYTE value, but the 2D Pitch register uses
@@ -380,30 +380,30 @@ int hw_imageblit(struct lynx_accel *accel,
 				FIELD_VALUE(0, DE_PITCH, SOURCE,      dPitch/bytePerPixel)); /* dpr10 */
 	}
 
-    /* Screen Window width in Pixels.
-       2D engine uses this value to calculate the linear address in frame buffer for a given point.
-    */
-    write_dpr(accel, DE_WINDOW_WIDTH,
-        FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
-        FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPitch/bytePerPixel)));
+	/* Screen Window width in Pixels.
+	 2D engine uses this value to calculate the linear address in frame buffer for a given point.
+	 */
+	write_dpr(accel, DE_WINDOW_WIDTH,
+		  FIELD_VALUE(0, DE_WINDOW_WIDTH, DESTINATION, (dPitch/bytePerPixel)) |
+		  FIELD_VALUE(0, DE_WINDOW_WIDTH, SOURCE,      (dPitch/bytePerPixel)));
 
-    /* Note: For 2D Source in Host Write, only X_K1_MONO field is needed, and Y_K2 field is not used.
-             For mono bitmap, use startBit for X_K1. */
-    write_dpr(accel, DE_SOURCE,
-        FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)       |
-        FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit)); /* dpr00 */
+	 /* Note: For 2D Source in Host Write, only X_K1_MONO field is needed, and Y_K2 field is not used.
+	    For mono bitmap, use startBit for X_K1. */
+	write_dpr(accel, DE_SOURCE,
+		  FIELD_SET  (0, DE_SOURCE, WRAP, DISABLE)       |
+		  FIELD_VALUE(0, DE_SOURCE, X_K1_MONO, startBit)); /* dpr00 */
 
-    write_dpr(accel, DE_DESTINATION,
-        FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
-        FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
-        FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
+	write_dpr(accel, DE_DESTINATION,
+		  FIELD_SET  (0, DE_DESTINATION, WRAP, DISABLE) |
+		  FIELD_VALUE(0, DE_DESTINATION, X,    dx)    |
+		  FIELD_VALUE(0, DE_DESTINATION, Y,    dy)); /* dpr04 */
 
-    write_dpr(accel, DE_DIMENSION,
-        FIELD_VALUE(0, DE_DIMENSION, X,    width) |
-        FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
+	write_dpr(accel, DE_DIMENSION,
+		  FIELD_VALUE(0, DE_DIMENSION, X,    width) |
+		  FIELD_VALUE(0, DE_DIMENSION, Y_ET, height)); /* dpr08 */
 
-    write_dpr(accel, DE_FOREGROUND, fColor);
-    write_dpr(accel, DE_BACKGROUND, bColor);
+	write_dpr(accel, DE_FOREGROUND, fColor);
+	write_dpr(accel, DE_BACKGROUND, bColor);
 
 	de_ctrl = FIELD_VALUE(0, DE_CONTROL, ROP, rop2)         |
 		FIELD_SET(0, DE_CONTROL, ROP_SELECT, ROP2)    |
@@ -413,24 +413,24 @@ int hw_imageblit(struct lynx_accel *accel,
 
 	write_dpr(accel, DE_CONTROL, de_ctrl | deGetTransparency(accel));
 
-    /* Write MONO data (line by line) to 2D Engine data port */
-    for (i=0; i<height; i++)
-    {
-        /* For each line, send the data in chunks of 4 bytes */
-        for (j=0; j<(ul4BytesPerScan/4); j++)
-        {
-            write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
-        }
-
-        if (ulBytesRemain)
-        {
-            memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
-            write_dpPort(accel, *(unsigned int *)ajRemain);
-        }
-
-        pSrcbuf += srcDelta;
-    }
-
-    return 0;
+	/* Write MONO data (line by line) to 2D Engine data port */
+	for (i=0; i<height; i++)
+	{
+		/* For each line, send the data in chunks of 4 bytes */
+		for (j=0; j<(ul4BytesPerScan/4); j++)
+		{
+			write_dpPort(accel, *(unsigned int *)(pSrcbuf + (j * 4)));
+		}
+
+		if (ulBytesRemain)
+		{
+			memcpy(ajRemain, pSrcbuf+ul4BytesPerScan, ulBytesRemain);
+			write_dpPort(accel, *(unsigned int *)ajRemain);
+		}
+
+		pSrcbuf += srcDelta;
+	}
+
+	    return 0;
 }
 
diff --git a/drivers/staging/sm750fb/sm750_accel.h b/drivers/staging/sm750fb/sm750_accel.h
index d3d256c..f252e47 100644
--- a/drivers/staging/sm750fb/sm750_accel.h
+++ b/drivers/staging/sm750fb/sm750_accel.h
@@ -7,7 +7,7 @@
 /* notes: below address are the offset value from de_base_address (0x100000)*/
 
 /* for sm718/750/502 de_base is at mmreg_1mb*/
-#define DE_BASE_ADDR_TYPE1 	0x100000
+#define DE_BASE_ADDR_TYPE1 0x100000
 /* for sm712,de_base is at mmreg_32kb */
 #define DE_BASE_ADDR_TYPE2  0x8000
 /* for sm722,de_base is at mmreg_0 */
@@ -26,7 +26,7 @@
 #define DE_SOURCE_WRAP_ENABLE                           1
 #define DE_SOURCE_X_K1                                  29:16
 #define DE_SOURCE_Y_K2                                  15:0
-#define DE_SOURCE_X_K1_MONO 							20:16
+#define DE_SOURCE_X_K1_MONO				20:16
 
 #define DE_DESTINATION                                  0x4
 #define DE_DESTINATION_WRAP                             31:31
diff --git a/drivers/staging/sm750fb/sm750_help.h b/drivers/staging/sm750fb/sm750_help.h
index 05777f7..8ba4f8d 100644
--- a/drivers/staging/sm750fb/sm750_help.h
+++ b/drivers/staging/sm750fb/sm750_help.h
@@ -11,9 +11,9 @@
 #define GET_FIELD(d, f)     (((d) >> _LSB(f)) & RAW_MASK(f))
 #define TEST_FIELD(d, f, v) (GET_FIELD(d, f) = f ## _ ## v)
 #define SET_FIELD(d, f, v)  (((d) & ~GET_MASK(f)) | \
-                            (((f ## _ ## v) & RAW_MASK(f)) << _LSB(f)))
+			    (((f ## _ ## v) & RAW_MASK(f)) << _LSB(f)))
 #define SET_FIELDV(d, f, v) (((d) & ~GET_MASK(f)) | \
-                            (((v) & RAW_MASK(f)) << _LSB(f)))
+			    (((v) & RAW_MASK(f)) << _LSB(f)))
 
 /* Internal macros */
 #define _F_START(f)             (0 ? f)
@@ -26,24 +26,24 @@
 /* Global macros */
 #define FIELD_GET(x, reg, field) \
 ( \
-    _F_NORMALIZE((x), reg ## _ ## field) \
+	_F_NORMALIZE((x), reg ## _ ## field) \
 )
 
 #define FIELD_SET(x, reg, field, value) \
 ( \
-    (x & ~_F_MASK(reg ## _ ## field)) \
-    | _F_DENORMALIZE(reg ## _ ## field ## _ ## value, reg ## _ ## field) \
+	(x & ~_F_MASK(reg ## _ ## field)) \
+	| _F_DENORMALIZE(reg ## _ ## field ## _ ## value, reg ## _ ## field) \
 )
 
 #define FIELD_VALUE(x, reg, field, value) \
 ( \
-    (x & ~_F_MASK(reg ## _ ## field)) \
-    | _F_DENORMALIZE(value, reg ## _ ## field) \
+	(x & ~_F_MASK(reg ## _ ## field)) \
+	| _F_DENORMALIZE(value, reg ## _ ## field) \
 )
 
 #define FIELD_CLEAR(reg, field) \
 ( \
-    ~ _F_MASK(reg ## _ ## field) \
+	~ _F_MASK(reg ## _ ## field) \
 )
 
 /* Field Macros */
@@ -55,20 +55,20 @@
 #define FIELD_DENORMALIZE(field, value) (((value) << FIELD_START(field)) & FIELD_MASK(field))
 
 #define FIELD_INIT(reg, field, value)   FIELD_DENORMALIZE(reg ## _ ## field, \
-                                                          reg ## _ ## field ## _ ## value)
+							  reg ## _ ## field ## _ ## value)
 #define FIELD_INIT_VAL(reg, field, value) \
-                                        (FIELD_DENORMALIZE(reg ## _ ## field, value))
+	(FIELD_DENORMALIZE(reg ## _ ## field, value))
 #define FIELD_VAL_SET(x, r, f, v)       x = x & ~FIELD_MASK(r ## _ ## f) \
-                                              | FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v)
+					| FIELD_DENORMALIZE(r ## _ ## f, r ## _ ## f ## _ ## v)
 
 #define RGB(r, g, b) \
 ( \
-    (unsigned long) (((r) << 16) | ((g) << 8) | (b)) \
+	(unsigned long) (((r) << 16) | ((g) << 8) | (b)) \
 )
 
 #define RGB16(r, g, b) \
 ( \
-    (unsigned short) ((((r) & 0xF8) << 8) | (((g) & 0xFC) << 3) | (((b) & 0xF8) >> 3)) \
+	(unsigned short) ((((r) & 0xF8) << 8) | (((g) & 0xFC) << 3) | (((b) & 0xF8) >> 3)) \
 )
 
 static inline unsigned int absDiff(unsigned int a, unsigned int b)
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 84381bc..28db9c7 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -171,23 +171,23 @@ int hw_sm750_inithw(struct lynx_share *share, struct pci_dev *pdev)
 		/* Set up GPIO for software I2C to program DVI chip in the
 		   Xilinx SP605 board, in order to have video signal.
 		 */
-        swI2CInit(0, 1);
+		swI2CInit(0, 1);
 
 
-        /* Customer may NOT use CH7301 DVI chip, which has to be
-           initialized differently.
-         */
-        if (swI2CReadReg(0xec, 0x4a) = 0x95)
-        {
-            /* The following register values for CH7301 are from
-               Chrontel app note and our experiment.
-             */
+		/* Customer may NOT use CH7301 DVI chip, which has to be
+		   initialized differently.
+		 */
+		if (swI2CReadReg(0xec, 0x4a) = 0x95)
+		{
+			/* The following register values for CH7301 are from
+			   Chrontel app note and our experiment.
+			 */
 			pr_info("yes,CH7301 DVI chip found\n");
-            swI2CWriteReg(0xec, 0x1d, 0x16);
-            swI2CWriteReg(0xec, 0x21, 0x9);
-            swI2CWriteReg(0xec, 0x49, 0xC0);
+			swI2CWriteReg(0xec, 0x1d, 0x16);
+			swI2CWriteReg(0xec, 0x21, 0x9);
+			swI2CWriteReg(0xec, 0x49, 0xC0);
 			pr_info("okay,CH7301 DVI chip setup done\n");
-        }
+		}
 	}
 
 	/* init 2d engine */
@@ -612,28 +612,28 @@ int hw_sm750_deWait(void)
 }
 
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-        const struct fb_var_screeninfo *var,
-        const struct fb_info *info)
+			 const struct fb_var_screeninfo *var,
+			 const struct fb_info *info)
 {
-    uint32_t total;
-    /* check params */
-    if ((var->xoffset + var->xres > var->xres_virtual) ||
-            (var->yoffset + var->yres > var->yres_virtual)) {
-        return -EINVAL;
-    }
-
-    total = var->yoffset * info->fix.line_length +
-        ((var->xoffset * var->bits_per_pixel) >> 3);
-    total += crtc->oScreen;
-    if (crtc->channel = sm750_primary) {
-        POKE32(PANEL_FB_ADDRESS,
-                FIELD_VALUE(PEEK32(PANEL_FB_ADDRESS),
-                    PANEL_FB_ADDRESS, ADDRESS, total));
-    } else {
-        POKE32(CRT_FB_ADDRESS,
-                FIELD_VALUE(PEEK32(CRT_FB_ADDRESS),
-                    CRT_FB_ADDRESS, ADDRESS, total));
-    }
-    return 0;
+	uint32_t total;
+	/* check params */
+	if ((var->xoffset + var->xres > var->xres_virtual) ||
+	    (var->yoffset + var->yres > var->yres_virtual)) {
+		return -EINVAL;
+	}
+
+	total = var->yoffset * info->fix.line_length +
+		((var->xoffset * var->bits_per_pixel) >> 3);
+	total += crtc->oScreen;
+	if (crtc->channel = sm750_primary) {
+		POKE32(PANEL_FB_ADDRESS,
+		FIELD_VALUE(PEEK32(PANEL_FB_ADDRESS),
+		PANEL_FB_ADDRESS, ADDRESS, total));
+	} else {
+		POKE32(CRT_FB_ADDRESS,
+		FIELD_VALUE(PEEK32(CRT_FB_ADDRESS),
+		CRT_FB_ADDRESS, ADDRESS, total));
+	}
+	return 0;
 }
 
diff --git a/drivers/staging/sm750fb/sm750_hw.h b/drivers/staging/sm750fb/sm750_hw.h
index 93288b3..adc61edf 100644
--- a/drivers/staging/sm750fb/sm750_hw.h
+++ b/drivers/staging/sm750fb/sm750_hw.h
@@ -2,8 +2,8 @@
 #define LYNX_HW750_H__
 
 
-#define DEFAULT_SM750_CHIP_CLOCK 		290
-#define DEFAULT_SM750LE_CHIP_CLOCK  	333
+#define DEFAULT_SM750_CHIP_CLOCK	290
+#define DEFAULT_SM750LE_CHIP_CLOCK	333
 #ifndef SM750LE_REVISION_ID
 #define SM750LE_REVISION_ID (unsigned char)0xfe
 #endif
@@ -24,9 +24,9 @@ enum sm750_dataflow{
 
 	sm750_simul_sec,/* secondary => all head */
 
-	sm750_dual_normal,/* 	primary => panel head and secondary => crt */
+	sm750_dual_normal,/* primary => panel head and secondary => crt */
 
-	sm750_dual_swap,/* 	primary => crt head and secondary => panel */
+	sm750_dual_swap,/* primary => crt head and secondary => panel */
 };
 
 
@@ -61,20 +61,20 @@ struct sm750_state{
 	int yLCD;
 };
 
-/* 	sm750_share stands for a presentation of two frame buffer
-	that use one sm750 adaptor, it is similar to the super class of lynx_share
-	in C++
-*/
+/* sm750_share stands for a presentation of two frame buffer
+   that use one sm750 adaptor, it is similar to the super class of lynx_share
+   in C++
+ */
 
 struct sm750_share{
 	/* it's better to put lynx_share struct to the first place of sm750_share */
 	struct lynx_share share;
 	struct sm750_state state;
 	int hwCursor;
-	/* 	0: no hardware cursor
-		1: primary crtc hw cursor enabled,
-		2: secondary crtc hw cursor enabled
-		3: both ctrc hw cursor enabled
+	/* 0: no hardware cursor
+	   1: primary crtc hw cursor enabled,
+	   2: secondary crtc hw cursor enabled
+	   3: both ctrc hw cursor enabled
 	*/
 };
 
@@ -95,7 +95,7 @@ int hw_sm750le_setBLANK(struct lynxfb_output*, int);
 void hw_sm750_crtc_clear(struct lynxfb_crtc*);
 void hw_sm750_output_clear(struct lynxfb_output*);
 int hw_sm750_pan_display(struct lynxfb_crtc *crtc,
-        const struct fb_var_screeninfo *var,
-        const struct fb_info *info);
+			 const struct fb_var_screeninfo *var,
+			 const struct fb_info *info);
 
 #endif
-- 
2.4.4

