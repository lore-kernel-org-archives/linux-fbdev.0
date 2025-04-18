Received: from sonic303-24.consmr.mail.gq1.yahoo.com (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCA21128A
	for <linux-fbdev@vger.kernel.org>; Fri, 18 Apr 2025 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989504; cv=none; b=bCwI1YczUmZiM59pCcsQZwwv2OnVrqKENCWqIsiwfdjiWnKBhIDk81BuRk21I5+Pq3SUxNAV70j1+VALhmKZWN+i1JWBheSC8+ZRIpth5A6d2bEiO2xNuVa+N0da/FGGRC9FJE4IEqbarRghA6uqRHIvoUAFxWBtEbnlctgtKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989504; c=relaxed/simple;
	bh=0egqAhQ+l5rRA7yaNYbjCrgURYXpcpUo1RvqDyp+R6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbn6qt+9VIsr7j10Ry3XldkGkvnFHWW93eP4k6KFiEGTeVgI4vksG1AHiRPFxgFiiGuy1ihTM0nR6vr0F3PwiWeOeHGRTM4Tf8Wz6hzAFmcvkIHosMGXmb3K0ykdoTJz5q+xVeM03c7v5n7Y1u26/R5mHZ1kg/F7RJjDc4B0SOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=RRV/5uU+; arc=none smtp.client-ip=98.137.64.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="RRV/5uU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744989502; bh=3+QIDz+8a7WhEyG6a1nGl5YyF8rJ364ekdxk7SsUvjg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=RRV/5uU+qkyg3fr0lX0p9ok+UdJy3DruN7vTOu9HW6nEf//7g3MFv5nf5dcXL5mzOhy9a5PdwvkEkueEG/tZY4wHTERuOiSG0ZU1aVXq5oXqIgqptKtbSB+t0KNxa6nHJcvUxtPW/sc+WheG7kBQDC+zEbcgYSq8UWkKlxLsywsDN/uJMFzDT0qvsnrk06z+MLIBOvmRaCP6mmsqxXDKyELoAjxc8pZo95KgCkinW87D4m7VDxwnP2tRaIVYZm21rkITHIfxadkyz8eY1mnKQFFekzJk3xF5xxGa81YwqfNIUp5wDdXESmCpfwhofiRzcEnW6foimEHuT3kTs7b7fA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744989502; bh=PYwPYcuRky0Fcfb87XVACXGqNNtWIgyTXDuHfjjFk8p=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aRmeFxBV8GN3jEiaMkbOYX0/4HrpdGIvOSBo9KVt4PDnU210vKisueQKV4SPfqELD1mrMoWrgUwMQAOomM68PnxhBmanxHKn5ajeEdG5VneOtH8cixH6sx4KAlJi4WmP0yLFuv8l5I//PPF8vcehsnNM9FCDsU2Y3ls2aOUIfYnYNDdemjbM8RChAU1WtNy90zkcbc8tQxpC2dYa0uGBCdnafeyMygypvghv0VxZrgwCjIgyIXKgpm553lixnA0+fQj5sq/HPyZnen+gmb3yzvMu3EyOg9fNejWK4Vt9efgMgIUZtIst8f7dIFUvSI7gEa+G/fPswe2rhoX7XjLX4A==
X-YMail-OSG: z5VYAMMVM1k89tlHf2BhUz_gQAURrg1v1yR_T.Dz.sRWKqW1olZArnKpDCmvIIw
 GGSlIz9qHIxZSPRS1ZMUT9ajAK8_TkrlzYCdr.MJpIxPt.vnJm4m4MHFEPR6WXR_QXmgdRMea2R6
 YIcRpeZUdNVnCUkdx_equXA75yBShFV3MOfiPRSs4sVf6g9.CmMtKkOdOW8BAWa1mBpaW7i.ST8f
 0MF.HjQu_LJc1Qn4jMW6iAr1BlUFlfkwsK3P4DiPyRoRCK3bobbwV86qC2ZNMIUpcyK0.apXGzOF
 weIrIQcPLEVonucSeYVd8jqzLRjpjkZtZa.3UPTr4lseh2t6hTXSZTPfrQ.Txlsgcm9P5fUako4L
 nz3.3j.p2VLjslLIEcFIkh_yP_CmjXwuTR_6ELQmcejzwFUayNDILfXRll1b2xJ5fa58nLn0XWIw
 UKSb.aFNXm02Ujr7_lRUsqkgwHibx9XaKJ8_fMkfDrpTtoMTq92iV9OaBZe98qoLILUuwfRgi6zc
 hFAv0ADoPgnHqjtkS1epCnIF_r03tdITFCMluWtClLkI.BjRDrm4l0VMBA6rWBGxk6efSD445oTf
 FPfStIZxHEe29wFHTYfB0zeltRgSZyVUlmrnuEsbaRVPAI.uAqitAtYNFEgSFKxfebt10K.vjK0M
 xVC3IF232PZY0I0jk99Jnk5IvAFHU7dvix3oHLSAVYUWtAaUy3odoXZG4ZUR72IKUoXzigr.jPzI
 KlVOsyCiVHdCkDjYROYr92liA1AUOKmjTr05sWjQ4lX1Fbrq6GWxZH_lFcLSz7XB7AH5Kwtw7ZHT
 dzgYo6F.DBhVvsci59_Abx4GLIUGwqcVkeDgK1m.2Gj7njt3maP1SKArHboxadulsqBz7zd43lwC
 oFft19HhaUNSCSXWQ4_EPPQMvZ1Mur.2xPzC8lYrOfepy4NFbxOLbGSx.UKxGcWssMeRkEHPNkuF
 MafMAcBvXKKVxv_YzYOmPuLHnhH53MW_Nb4R5ileb6ytBZvn0liaK7yADrt5YkiCv66Dwo7VWj89
 0HJZlQJ0O6j8D11jGXfioW7vT8I8AihEZB.6daoq2GMM6BqKM_Cwujf23kfWBxhSkxky4d81x74S
 ur1IPtynQ9dp4Dr0OYSjKd83zebzAOl9f_JhdE3cA1FsvqDAnma9XEovP5WM1_S_AAh3rpKCRcUX
 EhQ9n9NRcSa5me.hMMHiPoN1R1PLqtxBrbHd57MPHhhv7NrN90m62swq7mZpBWEuVYU52Axt_fXc
 zSY4R0YnvLxA4.0z01soOKqoqc4fwF0PzGVFQmcw1n_QHeYpL9EVYz3ajRPbQb2BYLWXqDcGfzjD
 eBZToUbcdt4HRJ031L.K9K_Xbjk9mLGV1U7Yxc4hv_1ivhUqDtk2l74qgpkUz4_L0ztN_gg5If_l
 8kBViatGgB8p_7wLgTRSE8eUCC9Z1_gysqkOGfdQOj4rw65wU1ef00fUWZzOIf6a7XiGwl6IS322
 JPYp6VF0Yp.pQvhpCITSXcMJYSIlAnECfG6NdSDivonGMVa.crwjQuENM4htNffGMm2aieGL1ZEf
 3_20hrnSu6uiFCgW.rRr5E2UROVHqC9LDDAf7Stsrl2Lh1saPF7.YWbHwc9zxcGA0vBEArmTnYkC
 plgCILskRmC2dSiBmVa6MdUKOqmIKE6fCQ08Mtgs_sUyO89YyjcKkdaDuIDVHQWYGVGAfsRDHZa1
 dAnlWCf9Oyp4JogTzyCwRQSoSdiBAd49Wwi21_6Q2DcKJZvw1gs9NJPdWE8n1cuHcZh7qXlKwdip
 _3In_wPRhLr6lHmNC.3TxHO7adpDmpZGcvmpZGYjXSV3Rasayr89XxOeknpBkolGjrGZwsI.w1Ql
 .6BbIThPEId0fH_im0eRyVmpZqKnWpRYiPOOEsbbA5_vKqm3nGslXHmVLW5zGvaeHWwXT5Mv8V0z
 WhD3GbAAl.98zHkibUF8kMbVxrWosPT8JjHhl0M93fqskOBqP6tU8lpy0ZFLWGaF6ucGbPbxdy7K
 TEljkt5vKq3xt0lTV4gcDqMDeA6ioy6J5zmsUcu5uyT96nZcPmyq_IKaXo.66XaQbe37D14ImWcX
 RHKQquugwKTeEcqA3UnvwTUvQu7AJRuB7hSc8dfVnSNj9VGBu4LF1NCfzJxhCbHVfkJBjX2oJeP6
 2r4oBAuBnQkxaU4J1qdZwlvbBUOa7qhiDWNvFdtKw5KEWnbF9aqvAYmPvfKx5uFaqb_MCjYeL2PR
 JbmF2oXKyuEJ9B4ZxeLg2WTt2SUPUZbZN1Y4V2xvjw_A9KASCc2XII7UHvCsR32P78hDqC0GOZbk
 vJsnw7rY-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 55914de9-c7f4-4caa-a157-6e1755fef135
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 15:18:22 +0000
Received: by hermes--production-ir2-858bd4ff7b-rjtcv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d9c4354726140fe64c22851ae4eda49;
          Fri, 18 Apr 2025 15:18:17 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] staging: sm750fb: remove ddk750_hwi2c
Date: Fri, 18 Apr 2025 16:17:49 +0100
Message-ID: <20250418151755.42624-4-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250418151755.42624-1-rubenru09@aol.com>
References: <20250418151755.42624-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the removal of ddk750_sii164.c, the functions in
ddk750_hwi2c are now also unused. This patch removes them
and the files they are in.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/Makefile       |   2 +-
 drivers/staging/sm750fb/ddk750.h       |   3 -
 drivers/staging/sm750fb/ddk750_hwi2c.c | 247 -------------------------
 drivers/staging/sm750fb/ddk750_hwi2c.h |  12 --
 4 files changed, 1 insertion(+), 263 deletions(-)
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.h

diff --git a/drivers/staging/sm750fb/Makefile b/drivers/staging/sm750fb/Makefile
index b3cb973e2672..f7e227df0e54 100644
--- a/drivers/staging/sm750fb/Makefile
+++ b/drivers/staging/sm750fb/Makefile
@@ -3,4 +3,4 @@ obj-$(CONFIG_FB_SM750)	+= sm750fb.o
 
 sm750fb-objs		:= sm750.o sm750_hw.o sm750_accel.o sm750_cursor.o \
 			   ddk750_chip.o ddk750_power.o ddk750_mode.o \
-			   ddk750_display.o ddk750_swi2c.o ddk750_hwi2c.o 
+			   ddk750_display.o ddk750_swi2c.o
diff --git a/drivers/staging/sm750fb/ddk750.h b/drivers/staging/sm750fb/ddk750.h
index 64ef4d258a91..8a32f8cf3a98 100644
--- a/drivers/staging/sm750fb/ddk750.h
+++ b/drivers/staging/sm750fb/ddk750.h
@@ -14,8 +14,5 @@
 #include "ddk750_chip.h"
 #include "ddk750_display.h"
 #include "ddk750_power.h"
-#ifdef USE_HW_I2C
-#include "ddk750_hwi2c.h"
-#endif
 #include "ddk750_swi2c.h"
 #endif
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.c b/drivers/staging/sm750fb/ddk750_hwi2c.c
deleted file mode 100644
index 8482689b665b..000000000000
--- a/drivers/staging/sm750fb/ddk750_hwi2c.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define USE_HW_I2C
-#ifdef USE_HW_I2C
-#include "ddk750_chip.h"
-#include "ddk750_reg.h"
-#include "ddk750_hwi2c.h"
-#include "ddk750_power.h"
-
-#define MAX_HWI2C_FIFO                  16
-#define HWI2C_WAIT_TIMEOUT              0xF0000
-
-int sm750_hw_i2c_init(unsigned char bus_speed_mode)
-{
-	unsigned int value;
-
-	/* Enable GPIO 30 & 31 as IIC clock & data */
-	value = peek32(GPIO_MUX);
-
-	value |= (GPIO_MUX_30 | GPIO_MUX_31);
-	poke32(GPIO_MUX, value);
-
-	/*
-	 * Enable Hardware I2C power.
-	 * TODO: Check if we need to enable GPIO power?
-	 */
-	sm750_enable_i2c(1);
-
-	/* Enable the I2C Controller and set the bus speed mode */
-	value = peek32(I2C_CTRL) & ~(I2C_CTRL_MODE | I2C_CTRL_EN);
-	if (bus_speed_mode)
-		value |= I2C_CTRL_MODE;
-	value |= I2C_CTRL_EN;
-	poke32(I2C_CTRL, value);
-
-	return 0;
-}
-
-void sm750_hw_i2c_close(void)
-{
-	unsigned int value;
-
-	/* Disable I2C controller */
-	value = peek32(I2C_CTRL) & ~I2C_CTRL_EN;
-	poke32(I2C_CTRL, value);
-
-	/* Disable I2C Power */
-	sm750_enable_i2c(0);
-
-	/* Set GPIO 30 & 31 back as GPIO pins */
-	value = peek32(GPIO_MUX);
-	value &= ~GPIO_MUX_30;
-	value &= ~GPIO_MUX_31;
-	poke32(GPIO_MUX, value);
-}
-
-static long hw_i2c_wait_tx_done(void)
-{
-	unsigned int timeout;
-
-	/* Wait until the transfer is completed. */
-	timeout = HWI2C_WAIT_TIMEOUT;
-	while (!(peek32(I2C_STATUS) & I2C_STATUS_TX) && (timeout != 0))
-		timeout--;
-
-	if (timeout == 0)
-		return -1;
-
-	return 0;
-}
-
-/*
- *  This function writes data to the i2c slave device registers.
- *
- *  Parameters:
- *      addr            - i2c Slave device address
- *      length          - Total number of bytes to be written to the device
- *      buf             - The buffer that contains the data to be written to the
- *                     i2c device.
- *
- *  Return Value:
- *      Total number of bytes those are actually written.
- */
-static unsigned int hw_i2c_write_data(unsigned char addr,
-				      unsigned int length,
-				      unsigned char *buf)
-{
-	unsigned char count, i;
-	unsigned int total_bytes = 0;
-
-	/* Set the Device Address */
-	poke32(I2C_SLAVE_ADDRESS, addr & ~0x01);
-
-	/*
-	 * Write data.
-	 * Note:
-	 *      Only 16 byte can be accessed per i2c start instruction.
-	 */
-	do {
-		/*
-		 * Reset I2C by writing 0 to I2C_RESET register to
-		 * clear the previous status.
-		 */
-		poke32(I2C_RESET, 0);
-
-		/* Set the number of bytes to be written */
-		if (length < MAX_HWI2C_FIFO)
-			count = length - 1;
-		else
-			count = MAX_HWI2C_FIFO - 1;
-		poke32(I2C_BYTE_COUNT, count);
-
-		/* Move the data to the I2C data register */
-		for (i = 0; i <= count; i++)
-			poke32(I2C_DATA0 + i, *buf++);
-
-		/* Start the I2C */
-		poke32(I2C_CTRL, peek32(I2C_CTRL) | I2C_CTRL_CTRL);
-
-		/* Wait until the transfer is completed. */
-		if (hw_i2c_wait_tx_done() != 0)
-			break;
-
-		/* Subtract length */
-		length -= (count + 1);
-
-		/* Total byte written */
-		total_bytes += (count + 1);
-
-	} while (length > 0);
-
-	return total_bytes;
-}
-
-/*
- *  This function reads data from the slave device and stores them
- *  in the given buffer
- *
- *  Parameters:
- *      addr            - i2c Slave device address
- *      length          - Total number of bytes to be read
- *      buf             - Pointer to a buffer to be filled with the data read
- *                     from the slave device. It has to be the same size as the
- *                     length to make sure that it can keep all the data read.
- *
- *  Return Value:
- *      Total number of actual bytes read from the slave device
- */
-static unsigned int hw_i2c_read_data(unsigned char addr,
-				     unsigned int length,
-				     unsigned char *buf)
-{
-	unsigned char count, i;
-	unsigned int total_bytes = 0;
-
-	/* Set the Device Address */
-	poke32(I2C_SLAVE_ADDRESS, addr | 0x01);
-
-	/*
-	 * Read data and save them to the buffer.
-	 * Note:
-	 *      Only 16 byte can be accessed per i2c start instruction.
-	 */
-	do {
-		/*
-		 * Reset I2C by writing 0 to I2C_RESET register to
-		 * clear all the status.
-		 */
-		poke32(I2C_RESET, 0);
-
-		/* Set the number of bytes to be read */
-		if (length <= MAX_HWI2C_FIFO)
-			count = length - 1;
-		else
-			count = MAX_HWI2C_FIFO - 1;
-		poke32(I2C_BYTE_COUNT, count);
-
-		/* Start the I2C */
-		poke32(I2C_CTRL, peek32(I2C_CTRL) | I2C_CTRL_CTRL);
-
-		/* Wait until transaction done. */
-		if (hw_i2c_wait_tx_done() != 0)
-			break;
-
-		/* Save the data to the given buffer */
-		for (i = 0; i <= count; i++)
-			*buf++ = peek32(I2C_DATA0 + i);
-
-		/* Subtract length by 16 */
-		length -= (count + 1);
-
-		/* Number of bytes read. */
-		total_bytes += (count + 1);
-
-	} while (length > 0);
-
-	return total_bytes;
-}
-
-/*
- *  This function reads the slave device's register
- *
- *  Parameters:
- *      deviceAddress   - i2c Slave device address which register
- *                        to be read from
- *      registerIndex   - Slave device's register to be read
- *
- *  Return Value:
- *      Register value
- */
-unsigned char sm750_hw_i2c_read_reg(unsigned char addr, unsigned char reg)
-{
-	unsigned char value = 0xFF;
-
-	if (hw_i2c_write_data(addr, 1, &reg) == 1)
-		hw_i2c_read_data(addr, 1, &value);
-
-	return value;
-}
-
-/*
- *  This function writes a value to the slave device's register
- *
- *  Parameters:
- *      deviceAddress   - i2c Slave device address which register
- *                        to be written
- *      registerIndex   - Slave device's register to be written
- *      data            - Data to be written to the register
- *
- *  Result:
- *          0   - Success
- *         -1   - Fail
- */
-int sm750_hw_i2c_write_reg(unsigned char addr,
-			   unsigned char reg,
-			   unsigned char data)
-{
-	unsigned char value[2];
-
-	value[0] = reg;
-	value[1] = data;
-	if (hw_i2c_write_data(addr, 2, value) == 2)
-		return 0;
-
-	return -1;
-}
-
-#endif
diff --git a/drivers/staging/sm750fb/ddk750_hwi2c.h b/drivers/staging/sm750fb/ddk750_hwi2c.h
deleted file mode 100644
index 337c6493ca61..000000000000
--- a/drivers/staging/sm750fb/ddk750_hwi2c.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef DDK750_HWI2C_H__
-#define DDK750_HWI2C_H__
-
-/* hwi2c functions */
-int sm750_hw_i2c_init(unsigned char bus_speed_mode);
-void sm750_hw_i2c_close(void);
-
-unsigned char sm750_hw_i2c_read_reg(unsigned char addr, unsigned char reg);
-int sm750_hw_i2c_write_reg(unsigned char addr, unsigned char reg,
-			   unsigned char data);
-#endif
-- 
2.48.1

