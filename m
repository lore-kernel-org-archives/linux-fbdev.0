Received: from sonic304-24.consmr.mail.gq1.yahoo.com (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487220E706
	for <linux-fbdev@vger.kernel.org>; Fri, 18 Apr 2025 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989497; cv=none; b=OkFF3A7I5GC+18ACo/qnwsqm2U+sWtolRv4tqGyXP8HKZ9Mh+bEf0rZGJk22YNKRgRoDgNQcGhiehGveToLdIpv/FmolVLhIWW4HqqKgoQYk3mkc2KNVuyrQ8lquU6b0JmJ1SGRvtVb42yU1w0IQhM+w2zSXzoleflGfaQD+uc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989497; c=relaxed/simple;
	bh=B7pSRHhh2uDpYku9T3lIiR/W02nfLMtIJ4opF0ZFj24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSDYyofqiysqLLE7oLqSrgOKzC88h1v8NxzMLSvaEFfpi8FfRBajyyNbg3zBheSiqWnU8YXv79IjQ5M38jmgcMk9IThn9qOt2r8jd7OWYU5GpiDYlTEqI3smVXKp2O4SuheB1reXl97Jv4pawC2Ld67SVLWoQv+ArOji7sts14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Wa1+y9mS; arc=none smtp.client-ip=98.137.68.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Wa1+y9mS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744989495; bh=UfPFOQHwynYkDl1wh5fSDxF5Ho80N8RriaG4lDBUwbI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Wa1+y9mSSAR+0kq7zJEWXnCQA5k2yhRJ4tzekc/Fs0RNvSEtQ/kGbajIsBnTkkfNBf9foZPTdSxxMzgtBK7p7jLe7sqLqwZZIpWK67niwBf0KDGAu0Fw0GiwW/tuEUocr0JB33oMD1yK/7K7NEC1pD7ljgOhN2vW6ys43VKdr53xN42LDBe7kviFMZsewIrgaeSbMh6174ApPZjvDHMxMzv34/2+x6mGVLvW9Elhs7ZEYplIE7IoLi2fv0IuSIM1D/a1/nW/TT/BjiN7u3bfrs9qEkJ6JehNPFx6l+0xk3vMQm4FAEvPDnCsmhtB6x/bJcWZMPVFr1yTIaqTLUSUyw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744989495; bh=mT3TWVNCW6CNSIfwMVagUVa/Zpp5zfbeL8E4QsYJkLf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bbfdLN870MFJ4X/3gJOjQ2rVpGxxESR0eU6XOKbXQUmWuvo6bAAeB/KTLV1GkSSu8S2Clv0UgKQNfQ+Z7ofg6Ny8fH31a+Jb4SU30XPb6gxzpcyIVvzqIrKVFnznKoGFg3uF88IryKNtivXacvV3q/VGHpYdmcyZklcgZc7zOmvneF9KwNKxhPieERkXNWkx7f4k5P9VNRE3qmJEhHiDmONNh45il8p5I6XZ1HIB2v4/6DWdfc93ErMTA+BJxox0XO5oOvYySKxjdTfEGPgsnsPqMOBwuJziC+QHulCmAsj0w2iHMidsYVq3TioKQ3MiHY+Ui6ANqfDlKyBMQ2A8Gw==
X-YMail-OSG: hbC1nuAVM1mChj985z17uOCWr_ZTiB_Ih60R5UVN227yLC72dJT0v7giJSxt307
 xzNHKSEFx_XA1shO8gVnwn1nkSBEJIrHFWYL_PNcfrkcUO7frbz6w6laNfrVvAHHGqYznKoLXkFZ
 asvBFbU.EVLU4ZKsf9LiDYKmt1gTzM1ry1kMQdFBSebIZoPAz.psabldxHov9w4yZaerlWO7i71n
 n..ABYOdQTyXM7rKl06Xrqd7gbygUzmFc7K6krWHqtxtQ_gA3E.LskNVrRTUTZVrWfp6ul0d5o4u
 L7KxnsLXxYzwctLC95Pjw2cnMPWwq2xuYhp6940JpEv_hXFaOoPQbFlHOA049zDS9B2My4s61TmJ
 hWxhH5G1IhQihjm4zF5OnyDlqQoXoU51cNEhGx7qHfQRgGHAh_mCmuYpIMYlQU4_9uAljw9p6lS_
 AbQqYr1nCx_2iicm4b3sQk16UZYgkl_88SEaCO9hHRbfSF63CREpfARJBItKJZ67bhWH0N5zEqen
 g6AXqM2wPD6ykC5nF_0B_dBovFbWjxJryVqnmFLswc6.HgEM6RanLvYh1SYFhD73kUHRoD2IS25p
 qL.SA5urdCTr.r_d2jEdnkUeWF5CWwzyzvJ8LYfL4ctNe7pIIPFHb.8cZR3bq5s_4hd7DvnR8X_M
 DKYZ0vYgXZatg9JTmclLRQQtw2fmEulNMk3jIIehXpeawJNEbZfxrLxdXIz9__x74Ms1LpdHd.dO
 8WPVU6wLBqJLIHvO2DtzUiy0.lxx.DDvFBZ2eYTae5VBhOA5rBZl80QcQwbF_.i31HZrA_Jd848D
 3BiVXJ04GUwjRfO09K1OmL1IAVDpZiz7lSmsIEcivfwBk30qngtLrUAPJw6e_nj04laYtKUdMGur
 gx_3gdL1n1nDChLfOHsW33JlyOokrYRI7POxIRN.qGIqahtvSslO74QzVgCC5Z9p7.DDY6sjtH6G
 g3UUsuday696Hh8VEzY0u3gifu3cZ3SHax4rEpZ_mPsEnlqASkcYdW_DoLMC7lx3.99L_85QFl2H
 1Jvn7aK7WqjEO6DBOoR3uQx9ONr7YuMu_E1XkGUX1S56TvpTdFxJz9FRPRHe_UAXGv5dBjVo8E7C
 PGxu2_QYvr0aG9eIXkt7br2XBbaS_UEV9RiYPcMNzARPK.moVlF53S0pkt95KlpbumwuSFYdcO6N
 hunQuWOmKMRr.RQ0xGsqab8rgwSw4TMh5NHC9od4DyV1Qxe2Kyorv4r7fvUr7PSObuM_yuIAeMR9
 n4UVdchdNs98bW7bCKfdtCsH4TDItcPZmc9lZ1LS8AnDTbmT63aBG0ZCp8.sj4vSksL9uGZw2Xo4
 QUCUjYQNo83XOb1T.KhB6_OUYEWFLrZJcs90A7AT0b6pxLIi3xe9gfpUSP7crggh7unMvMcW84vh
 MXJeGAkYIlW19R77MMeO.N4yt6Zvx3mkv5JjDX_.VqW9i_wq6kDjIRyTme_3K45v2pQX3HPEhWSL
 5Z.U7TpMgHoosMI1GlPdIlXgslh8yS2qOmTxvPWREVlWYPQ8ln70y807EexPpr9lEarDsEOGvlgI
 f0UJc.PzjVm1TW_HaY2lf_NNlh_E8SKxaulwttHjTU51Gbrxe3IrXIaDJU7HzJHRw1UgL6GuSVrE
 VQ2_fs_4.iiCexV3Fm7eMUByJgjLne8JrjmR3.WuxJP.yAstnAeDiJ179CFElMBTbwWeLUkx2Uuq
 mjQvpNRBLeJpXICHfM2nvWpWTm2Uq1o9PNyXVLsr0oev0xh3xXeZ.idyGBkp14mEo5CDEGVRtWFQ
 ToTIDiCq5TzZFaY9H8RRP1r7gvax8P3xf4J5Eg3xPmFeJFqjLZLQALbEJQ2Sri8TXQ3H1xvF5Am3
 NDusq0obb.RVXmXoIcCX6zAREi2ZXjLaF_WhoBxaQc.2irM.F32phqc5D3I3ZW8MHWseHDYiSvk8
 ty0v828fT22lVlRVtLCaRGKptRJmKif7duuIokhFUlG2T0pa43Wr7570UsOxzkbFQr2jTyWWd2O6
 VOCR2tm4gi0aTlF9J28n9056IRSy6e9FSSbTjYziX2lKidiKHtBOf4EOcNKqkc_OU.ACR.JecB7E
 9K3xps4jY53TFnR0KCWYRR3QhECvY4KTmM6e1ZOl.RvG9HBZZwp2lp1HF.nbkfKF0g1QF2LAaEGL
 KJ2O6bOIPRSClEq5NZq11maPHVfdkTvSZC7BfK0QdH_9mVt8Xx5mGrvCA4MRd8Fw5v.oFftivrzu
 OT6Jov8LVGko2eZBjiO_aDhBf262WgDmzec9yZBuFhdmCiDHKvFewKhBtulN7X9B4wkS6tNJgQyG
 KDBLgFtBmwdhz6alrT821pFE-
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 7d64a124-60f9-45e9-bf64-04a9b25bc496
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 15:18:15 +0000
Received: by hermes--production-ir2-858bd4ff7b-rjtcv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d9c4354726140fe64c22851ae4eda49;
          Fri, 18 Apr 2025 15:18:12 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: sm750fb: Remove ddk750_sii164
Date: Fri, 18 Apr 2025 16:17:47 +0100
Message-ID: <20250418151755.42624-2-rubenru09@aol.com>
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

Removes unused functions and files ddk750_sii164.

Functions were used in ddk750_dvi.c, which is itself
unused. Removal will be in the second patch in the series.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>

---

I have checked the entire driver, and found that the code
present within these files is used nowhere (except for in
ddk750_dvi.c, which is also used nowhere).

As such I have decided to remove the code in this file, as
it is essentially deadcode.
---
 drivers/staging/sm750fb/Makefile        |   4 +-
 drivers/staging/sm750fb/ddk750_dvi.c    |  21 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 408 ------------------------
 drivers/staging/sm750fb/ddk750_sii164.h | 174 ----------
 4 files changed, 4 insertions(+), 603 deletions(-)
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.h

diff --git a/drivers/staging/sm750fb/Makefile b/drivers/staging/sm750fb/Makefile
index b89aa4c12e9d..1926376664ca 100644
--- a/drivers/staging/sm750fb/Makefile
+++ b/drivers/staging/sm750fb/Makefile
@@ -3,5 +3,5 @@ obj-$(CONFIG_FB_SM750)	+= sm750fb.o
 
 sm750fb-objs		:= sm750.o sm750_hw.o sm750_accel.o sm750_cursor.o \
 			   ddk750_chip.o ddk750_power.o ddk750_mode.o \
-			   ddk750_display.o ddk750_swi2c.o ddk750_sii164.o \
-			   ddk750_dvi.o ddk750_hwi2c.o
+			   ddk750_display.o ddk750_swi2c.o ddk750_dvi.o  \
+			   ddk750_hwi2c.o
diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 6fef1ab484c1..9842c4e4cdf8 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -4,31 +4,14 @@
 #include "ddk750_chip.h"
 #include "ddk750_reg.h"
 #include "ddk750_dvi.h"
-#include "ddk750_sii164.h"
 
 /*
  * This global variable contains all the supported driver and its corresponding
  * function API. Please set the function pointer to NULL whenever the function
  * is not supported.
  */
-static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
-#ifdef DVI_CTRL_SII164
-	{
-		.init = sii164_init_chip,
-		.get_vendor_id = sii164_get_vendor_id,
-		.get_device_id = sii164_get_device_id,
-#ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164_reset_chip,
-		.get_chip_string = sii164_get_chip_string,
-		.set_power = sii164_set_power,
-		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.is_connected = sii164_is_connected,
-		.check_interrupt = sii164_check_interrupt,
-		.clear_interrupt = sii164_clear_interrupt,
-#endif
-	},
-#endif
-};
+
+static struct dvi_ctrl_device dcft_supported_dvi_controller[] = { };
 
 int dvi_init(unsigned char edge_select,
 	     unsigned char bus_select,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
deleted file mode 100644
index 89700fc5dd2e..000000000000
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ /dev/null
@@ -1,408 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define USE_DVICHIP
-#ifdef USE_DVICHIP
-
-#include "ddk750_sii164.h"
-#include "ddk750_hwi2c.h"
-
-/* I2C Address of each SII164 chip */
-#define SII164_I2C_ADDRESS                  0x70
-
-/* Define this definition to use hardware i2c. */
-#define USE_HW_I2C
-
-#ifdef USE_HW_I2C
-    #define i2cWriteReg sm750_hw_i2c_write_reg
-    #define i2cReadReg  sm750_hw_i2c_read_reg
-#else
-    #define i2cWriteReg sm750_sw_i2c_write_reg
-    #define i2cReadReg  sm750_sw_i2c_read_reg
-#endif
-
-/* SII164 Vendor and Device ID */
-#define SII164_VENDOR_ID                    0x0001
-#define SII164_DEVICE_ID                    0x0006
-
-#ifdef SII164_FULL_FUNCTIONS
-/* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
-#endif
-
-/*
- *  sii164_get_vendor_id
- *      This function gets the vendor ID of the DVI controller chip.
- *
- *  Output:
- *      Vendor ID
- */
-unsigned short sii164_get_vendor_id(void)
-{
-	unsigned short vendorID;
-
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_VENDOR_ID_LOW);
-
-	return vendorID;
-}
-
-/*
- *  sii164_get_device_id
- *      This function gets the device ID of the DVI controller chip.
- *
- *  Output:
- *      Device ID
- */
-unsigned short sii164_get_device_id(void)
-{
-	unsigned short device_id;
-
-	device_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_DEVICE_ID_LOW);
-
-	return device_id;
-}
-
-/*
- *  DVI.C will handle all SiI164 chip stuffs and try its best to make code
- *  minimal and useful
- */
-
-/*
- *  sii164_init_chip
- *      This function initialize and detect the DVI controller chip.
- *
- *  Input:
- *      edge_select           - Edge Select:
- *                               0 = Input data is falling edge latched (falling
- *                                   edge latched first in dual edge mode)
- *                               1 = Input data is rising edge latched (rising
- *                                   edge latched first in dual edge mode)
- *      bus_select            - Input Bus Select:
- *                               0 = Input data bus is 12-bits wide
- *                               1 = Input data bus is 24-bits wide
- *      dual_edge_clk_select  - Dual Edge Clock Select
- *                               0 = Input data is single edge latched
- *                               1 = Input data is dual edge latched
- *      hsync_enable          - Horizontal Sync Enable:
- *                               0 = HSYNC input is transmitted as fixed LOW
- *                               1 = HSYNC input is transmitted as is
- *      vsync_enable          - Vertical Sync Enable:
- *                               0 = VSYNC input is transmitted as fixed LOW
- *                               1 = VSYNC input is transmitted as is
- *      deskew_enable         - De-skewing Enable:
- *                               0 = De-skew disabled
- *                               1 = De-skew enabled
- *      deskew_setting        - De-skewing Setting (increment of 260psec)
- *                               0 = 1 step --> minimum setup / maximum hold
- *                               1 = 2 step
- *                               2 = 3 step
- *                               3 = 4 step
- *                               4 = 5 step
- *                               5 = 6 step
- *                               6 = 7 step
- *                               7 = 8 step --> maximum setup / minimum hold
- *      continuous_sync_enable- SYNC Continuous:
- *                               0 = Disable
- *                               1 = Enable
- *      pll_filter_enable     - PLL Filter Enable
- *                               0 = Disable PLL Filter
- *                               1 = Enable PLL Filter
- *      pll_filter_value      - PLL Filter characteristics:
- *                               0~7 (recommended value is 4)
- *
- *  Output:
- *      0   - Success
- *     -1   - Fail.
- */
-long sii164_init_chip(unsigned char edge_select,
-		      unsigned char bus_select,
-		      unsigned char dual_edge_clk_select,
-		      unsigned char hsync_enable,
-		      unsigned char vsync_enable,
-		      unsigned char deskew_enable,
-		      unsigned char deskew_setting,
-		      unsigned char continuous_sync_enable,
-		      unsigned char pll_filter_enable,
-		      unsigned char pll_filter_value)
-{
-	unsigned char config;
-
-	/* Initialize the i2c bus */
-#ifdef USE_HW_I2C
-	/* Use fast mode. */
-	sm750_hw_i2c_init(1);
-#else
-	sm750_sw_i2c_init(DEFAULT_I2C_SCL, DEFAULT_I2C_SDA);
-#endif
-
-	/* Check if SII164 Chip exists */
-	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
-	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
-		/*
-		 *  Initialize SII164 controller chip.
-		 */
-
-		/* Select the edge */
-		if (edge_select == 0)
-			config = SII164_CONFIGURATION_LATCH_FALLING;
-		else
-			config = SII164_CONFIGURATION_LATCH_RISING;
-
-		/* Select bus wide */
-		if (bus_select == 0)
-			config |= SII164_CONFIGURATION_BUS_12BITS;
-		else
-			config |= SII164_CONFIGURATION_BUS_24BITS;
-
-		/* Select Dual/Single Edge Clock */
-		if (dual_edge_clk_select == 0)
-			config |= SII164_CONFIGURATION_CLOCK_SINGLE;
-		else
-			config |= SII164_CONFIGURATION_CLOCK_DUAL;
-
-		/* Select HSync Enable */
-		if (hsync_enable == 0)
-			config |= SII164_CONFIGURATION_HSYNC_FORCE_LOW;
-		else
-			config |= SII164_CONFIGURATION_HSYNC_AS_IS;
-
-		/* Select VSync Enable */
-		if (vsync_enable == 0)
-			config |= SII164_CONFIGURATION_VSYNC_FORCE_LOW;
-		else
-			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
-
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-
-		/*
-		 * De-skew enabled with default 111b value.
-		 * This fixes some artifacts problem in some mode on board 2.2.
-		 * Somehow this fix does not affect board 2.1.
-		 */
-		if (deskew_enable == 0)
-			config = SII164_DESKEW_DISABLE;
-		else
-			config = SII164_DESKEW_ENABLE;
-
-		switch (deskew_setting) {
-		case 0:
-			config |= SII164_DESKEW_1_STEP;
-			break;
-		case 1:
-			config |= SII164_DESKEW_2_STEP;
-			break;
-		case 2:
-			config |= SII164_DESKEW_3_STEP;
-			break;
-		case 3:
-			config |= SII164_DESKEW_4_STEP;
-			break;
-		case 4:
-			config |= SII164_DESKEW_5_STEP;
-			break;
-		case 5:
-			config |= SII164_DESKEW_6_STEP;
-			break;
-		case 6:
-			config |= SII164_DESKEW_7_STEP;
-			break;
-		case 7:
-			config |= SII164_DESKEW_8_STEP;
-			break;
-		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
-
-		/* Enable/Disable Continuous Sync. */
-		if (continuous_sync_enable == 0)
-			config = SII164_PLL_FILTER_SYNC_CONTINUOUS_DISABLE;
-		else
-			config = SII164_PLL_FILTER_SYNC_CONTINUOUS_ENABLE;
-
-		/* Enable/Disable PLL Filter */
-		if (pll_filter_enable == 0)
-			config |= SII164_PLL_FILTER_DISABLE;
-		else
-			config |= SII164_PLL_FILTER_ENABLE;
-
-		/* Set the PLL Filter value */
-		config |= ((pll_filter_value & 0x07) << 1);
-
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
-
-		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-
-		return 0;
-	}
-
-	/* Return -1 if initialization fails. */
-	return -1;
-}
-
-/* below sii164 function is not necessary */
-
-#ifdef SII164_FULL_FUNCTIONS
-
-/*
- *  sii164_reset_chip
- *      This function resets the DVI Controller Chip.
- */
-void sii164_reset_chip(void)
-{
-	/* Power down */
-	sii164_set_power(0);
-	sii164_set_power(1);
-}
-
-/*
- * sii164_get_chip_string
- *      This function returns a char string name of the current DVI Controller
- *      chip.
- *
- *      It's convenient for application need to display the chip name.
- */
-char *sii164_get_chip_string(void)
-{
-	return gDviCtrlChipName;
-}
-
-/*
- *  sii164_set_power
- *      This function sets the power configuration of the DVI Controller Chip.
- *
- *  Input:
- *      powerUp - Flag to set the power down or up
- */
-void sii164_set_power(unsigned char powerUp)
-{
-	unsigned char config;
-
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
-		/* Power up the chip */
-		config &= ~SII164_CONFIGURATION_POWER_MASK;
-		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-	} else {
-		/* Power down the chip */
-		config &= ~SII164_CONFIGURATION_POWER_MASK;
-		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
-	}
-}
-
-/*
- *  sii164SelectHotPlugDetectionMode
- *      This function selects the mode of the hot plug detection.
- */
-static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
-{
-	unsigned char detectReg;
-
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
-	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
-		break;
-	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
-		break;
-	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
-		break;
-	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
-		break;
-	}
-
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
-}
-
-/*
- *  sii164_enable_hot_plug_detection
- *      This function enables the Hot Plug detection.
- *
- *  enable_hot_plug   - Enable (=1) / disable (=0) Hot Plug detection
- */
-void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
-{
-	unsigned char detectReg;
-
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-
-	/* Depending on each DVI controller, need to enable the hot plug based
-	 * on each individual chip design.
-	 */
-	if (enable_hot_plug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
-	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
-}
-
-/*
- *  sii164_is_connected
- *      Check if the DVI Monitor is connected.
- *
- *  Output:
- *      0   - Not Connected
- *      1   - Connected
- */
-unsigned char sii164_is_connected(void)
-{
-	unsigned char hotPlugValue;
-
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
-		return 1;
-	else
-		return 0;
-}
-
-/*
- *  sii164_check_interrupt
- *      Checks if interrupt has occurred.
- *
- *  Output:
- *      0   - No interrupt
- *      1   - Interrupt occurs
- */
-unsigned char sii164_check_interrupt(void)
-{
-	unsigned char detectReg;
-
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
-		return 1;
-	else
-		return 0;
-}
-
-/*
- *  sii164_clear_interrupt
- *      Clear the hot plug interrupt.
- */
-void sii164_clear_interrupt(void)
-{
-	unsigned char detectReg;
-
-	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
-}
-
-#endif
-
-#endif
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
deleted file mode 100644
index ebc173658f0e..000000000000
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ /dev/null
@@ -1,174 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef DDK750_SII164_H__
-#define DDK750_SII164_H__
-
-#define USE_DVICHIP
-
-/* Hot Plug detection mode structure */
-enum sii164_hot_plug_mode {
-	SII164_HOTPLUG_DISABLE = 0,	/* Disable Hot Plug output bit
-					 * (always high).
-					 */
-
-	SII164_HOTPLUG_USE_MDI,         /* Use Monitor Detect Interrupt bit. */
-	SII164_HOTPLUG_USE_RSEN,        /* Use Receiver Sense detect bit. */
-	SII164_HOTPLUG_USE_HTPLG        /* Use Hot Plug detect bit. */
-};
-
-/* Silicon Image SiI164 chip prototype */
-long sii164_init_chip(unsigned char edgeSelect,
-		      unsigned char busSelect,
-		      unsigned char dualEdgeClkSelect,
-		      unsigned char hsyncEnable,
-		      unsigned char vsyncEnable,
-		      unsigned char deskewEnable,
-		      unsigned char deskewSetting,
-		      unsigned char continuousSyncEnable,
-		      unsigned char pllFilterEnable,
-		      unsigned char pllFilterValue);
-
-unsigned short sii164_get_vendor_id(void);
-unsigned short sii164_get_device_id(void);
-
-#ifdef SII164_FULL_FUNCTIONS
-void sii164_reset_chip(void);
-char *sii164_get_chip_string(void);
-void sii164_set_power(unsigned char powerUp);
-void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
-unsigned char sii164_is_connected(void);
-unsigned char sii164_check_interrupt(void);
-void sii164_clear_interrupt(void);
-#endif
-/*
- * below register definition is used for
- * Silicon Image SiI164 DVI controller chip
- */
-/*
- * Vendor ID registers
- */
-#define SII164_VENDOR_ID_LOW                        0x00
-#define SII164_VENDOR_ID_HIGH                       0x01
-
-/*
- * Device ID registers
- */
-#define SII164_DEVICE_ID_LOW                        0x02
-#define SII164_DEVICE_ID_HIGH                       0x03
-
-/*
- * Device Revision
- */
-#define SII164_DEVICE_REVISION                      0x04
-
-/*
- * Frequency Limitation registers
- */
-#define SII164_FREQUENCY_LIMIT_LOW                  0x06
-#define SII164_FREQUENCY_LIMIT_HIGH                 0x07
-
-/*
- * Power Down and Input Signal Configuration registers
- */
-#define SII164_CONFIGURATION                        0x08
-
-/* Power down (PD) */
-#define SII164_CONFIGURATION_POWER_DOWN             0x00
-#define SII164_CONFIGURATION_POWER_NORMAL           0x01
-#define SII164_CONFIGURATION_POWER_MASK             0x01
-
-/* Input Edge Latch Select (EDGE) */
-#define SII164_CONFIGURATION_LATCH_FALLING          0x00
-#define SII164_CONFIGURATION_LATCH_RISING           0x02
-
-/* Bus Select (BSEL) */
-#define SII164_CONFIGURATION_BUS_12BITS             0x00
-#define SII164_CONFIGURATION_BUS_24BITS             0x04
-
-/* Dual Edge Clock Select (DSEL) */
-#define SII164_CONFIGURATION_CLOCK_SINGLE           0x00
-#define SII164_CONFIGURATION_CLOCK_DUAL             0x08
-
-/* Horizontal Sync Enable (HEN) */
-#define SII164_CONFIGURATION_HSYNC_FORCE_LOW        0x00
-#define SII164_CONFIGURATION_HSYNC_AS_IS            0x10
-
-/* Vertical Sync Enable (VEN) */
-#define SII164_CONFIGURATION_VSYNC_FORCE_LOW        0x00
-#define SII164_CONFIGURATION_VSYNC_AS_IS            0x20
-
-/*
- * Detection registers
- */
-#define SII164_DETECT                               0x09
-
-/* Monitor Detect Interrupt (MDI) */
-#define SII164_DETECT_MONITOR_STATE_CHANGE          0x00
-#define SII164_DETECT_MONITOR_STATE_NO_CHANGE       0x01
-#define SII164_DETECT_MONITOR_STATE_CLEAR           0x01
-#define SII164_DETECT_MONITOR_STATE_MASK            0x01
-
-/* Hot Plug detect Input (HTPLG) */
-#define SII164_DETECT_HOT_PLUG_STATUS_OFF           0x00
-#define SII164_DETECT_HOT_PLUG_STATUS_ON            0x02
-#define SII164_DETECT_HOT_PLUG_STATUS_MASK          0x02
-
-/* Receiver Sense (RSEN) */
-#define SII164_DETECT_RECEIVER_SENSE_NOT_DETECTED   0x00
-#define SII164_DETECT_RECEIVER_SENSE_DETECTED       0x04
-
-/* Interrupt Generation Method (TSEL) */
-#define SII164_DETECT_INTERRUPT_BY_RSEN_PIN         0x00
-#define SII164_DETECT_INTERRUPT_BY_HTPLG_PIN        0x08
-#define SII164_DETECT_INTERRUPT_MASK                0x08
-
-/* Monitor Sense Output (MSEN) */
-#define SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH     0x00
-#define SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI      0x10
-#define SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN     0x20
-#define SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG    0x30
-#define SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG     0x30
-
-/*
- * Skewing registers
- */
-#define SII164_DESKEW                               0x0A
-
-/* General Purpose Input (CTL[3:1]) */
-#define SII164_DESKEW_GENERAL_PURPOSE_INPUT_MASK    0x0E
-
-/* De-skewing Enable bit (DKEN) */
-#define SII164_DESKEW_DISABLE                       0x00
-#define SII164_DESKEW_ENABLE                        0x10
-
-/* De-skewing Setting (DK[3:1])*/
-#define SII164_DESKEW_1_STEP                        0x00
-#define SII164_DESKEW_2_STEP                        0x20
-#define SII164_DESKEW_3_STEP                        0x40
-#define SII164_DESKEW_4_STEP                        0x60
-#define SII164_DESKEW_5_STEP                        0x80
-#define SII164_DESKEW_6_STEP                        0xA0
-#define SII164_DESKEW_7_STEP                        0xC0
-#define SII164_DESKEW_8_STEP                        0xE0
-
-/*
- * User Configuration Data registers (CFG 7:0)
- */
-#define SII164_USER_CONFIGURATION                   0x0B
-
-/*
- * PLL registers
- */
-#define SII164_PLL                                  0x0C
-
-/* PLL Filter Value (PLLF) */
-#define SII164_PLL_FILTER_VALUE_MASK                0x0E
-
-/* PLL Filter Enable (PFEN) */
-#define SII164_PLL_FILTER_DISABLE                   0x00
-#define SII164_PLL_FILTER_ENABLE                    0x01
-
-/* Sync Continuous (SCNT) */
-#define SII164_PLL_FILTER_SYNC_CONTINUOUS_DISABLE   0x00
-#define SII164_PLL_FILTER_SYNC_CONTINUOUS_ENABLE    0x80
-
-#endif
-- 
2.48.1

