Received: from sonic309-21.consmr.mail.gq1.yahoo.com (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51B185920
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916615; cv=none; b=qJLqbXIMdldu+nl+iUILRsn2f26HgPYPiqRTmIwMeYyjMWteHakdfbPfl+cFJofcnIre08ATv997a4NigPmCXDpcfpuUXCAE3v/xuuEjPCk1Bv6vXh31c2/RA7DIujwtzQPl9Utw7DqYmu2H1Qwh1SapiX8bomK5Gl6+kwMnrT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916615; c=relaxed/simple;
	bh=5KTeWSc6H47lSlOKdSbwaqeePKMqgOAJ1wGVQhmKp+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR5IeUAIe+yB//cJTnletLtPFU+VEnsCFjIwKAX2VIUEfOzvoMCtLpTqQJOgtjVsjwE/2wLxFj0l39sq8F3bMpxRndc51GBiJy3xONf//GXzvnNbXF0QhIlFjJve1+tD97hePGmcmlXplNZcOmbSf0c3aulyOlX9gCoZsMGgDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=X2d1usPS; arc=none smtp.client-ip=98.137.65.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="X2d1usPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744916613; bh=d01pl2D+rgtMMJC7n70eJk6IKYF3exP95OX+V1JFanY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=X2d1usPSOHgmQWuZxK+oH4KM6wMOPvC20CkzvOMpQA88TCleN9V0jthkelysBUDvNnvhTJQVtZSQ2w8p+HwjhTOr6dg5r+7OfRw9KPY+D2wPLZHFUXt/anh/vBfthzecFvSfjXtHUcvy6BLMDKbPvEBcHZSskEFUC4g4BGnV+LqoKPfmqW3G2wtjEf+hF+b36XrnlaiuhV2L1ayxQqSoc+kiYUCExIraXWtnuitlSnkgjDt6pIrCQL5qhKBSxHo7BUkQsGVw/Z8wo+EUQBUwTwQrnUztGAwXrZtzPvbeFiwv/Dvj4mD2aNAqekdnzdB0KOSrfv0QbbHh4h5GJo+9Xw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744916613; bh=JuPl6lCJIn+kFgAKYjUe7CPMFeSmeiVJ08PevGezymR=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hS98+gLzshMKLeETY5ZYohPalAp/PsrRKmrbyCqnwYj9UNw1aIfjGcObyxdYqrGLvPI2nQAZdNqHhHBOKKdjRH2YJcaBVa92IEgLE5t5SpeCKPuzQieOB81gTM83vaX9WYdqKiv5wNxyI3AN+AYbyvmgfxWYCEs1jP7uOHc6O3EjgZpjsyAhjDZFrNRJEEmdnIFIs0hzs0V8veGemfHvJeOUWNf0f+qAiqxeDl5Brq40/aqMdGelKKh4gCzkG+xbzFfQkrFnNVnoZ73qDcrctJjShPCSOjlfwH8N1L72uX6IsQ47rCRbaI0x09Upb0koGwG/X4MPxuDEL6BSnmwl1A==
X-YMail-OSG: QfDLMyUVM1m2NCozMAOX5XmCIhexE_bL6YtVkt.yUNlTz5FJhZMzxvCcbHjCAz5
 Ur19sCPTbvlV7iIW6H6OJj_Y8aoaC0B1sRt3DantvkzX6DwWrWf_cms9ozzV.li.3P4tCE5HOrDN
 yco.rAJY5jya2LY6ZPuVXJ3ApSzzW0yl4O1BHXqQRWHKiOT_g7FRVUiTAUddmKtQlLy6Qkxj1ewm
 _I8UcZZybvngwfFDOCzj.XaBac6XKFHgf8EbgNGz4QAoqaUi.R4RblHiH6EdhGY4WvoZbPEMSvR1
 U_zY0Ab_k1tmz_cA5I2Nzub.yP.x76iBQgR.lLMdWGb1qkhMLBuk6l0hUP.YtFOnzPp_vzYYcpOk
 sd3krv5Z0FNHECeH.hygvf.ssVR.gmjWoIOkpW4z_hPl9NtARhSaxIneXr_SIGzcT9188uHR0Rpq
 _e8hM7.P5jFO1UTdocipQPosKJw5lXxks.Gp_y2fzQ7NMk9Bq22SfNAcg3k7DbBVzfQ5VS7W9oiI
 BjtoRwNB_1RhZTp0lvQpfYsGM8hxMbbNHlMBUxwH2xmMDRcTLYk0fcD0rCzxFGsgqGwzkzRoIAPe
 PoOji.J7SAiAuPcgLMCmRwBAXtj4OX2CVdBA.4.02aG4tn0SXDLoS1OCVKPN3sHMzfFA4zYbpz4f
 gTl5bi7PdTJL4oh.xSpmq2Wzs0nn_rqr_321SOIT8xcEHO4j2fgk7PI.Sf5UsyrHsMyh.1wnH4tz
 Ngsbwv2ViKq755br3eHucJ3ZwblDttBmnEaCoEWLiMHU4EbTf5dIHkjuMFi80w.Dfd34CjnRVLNr
 S58tebqgsXjMppRZkSjCINJV2OMKxUKSUKZyjLkwXSdl6DgxITS3kSqccdPxI2uFcrJco0ObdHnt
 __y5m.fb_B.rZvFmyTF0so02DZUFNTu2CViWWJmJ7.huslw24dgsPbVIEyx.mqH_s.m_BxCWFq4X
 v.v95Ig04bmUGLi2b9pfpLxdDEz5ynrX1vowwmuSbBJV9xA5freUK1aWiwS3E5UIpbbjgYr.mqfs
 3ghHyXAVljaTIdHY_YPJ2G6Z6QK4o.0xn8mgUVjPltrDjvOFwf5jhJDXGIkwNksOsrS1Q6MZtZlO
 eZO8.ae3q.xno2Y_8HDwVHmj_24KGpZmcSc2VYJmE5wv5cck9u0oYXJEH07wkYYGpUdhYMdmCASz
 IB_L_oXzAvlfU_Spy.limXeYee1EyEgcWgmhDHdP2q5tNXvAb4Qq9Fpqdv5aR8yCM9E5MMJOsorD
 LmyVaHLW4uOdCDlUSwLIa1DrvA8ZNkqPkpfs1siUWeKDZUuTpAzh75zXZvSR1RPTCLUsB7Kh3iDE
 zu1N6MbMZpN2.ivCSAoFrcZ0OA9BUTUa9tuXopSCHr8W2F3DQC7w_AMz7DaIiTMU7GHg9jkXvycd
 WWQqg7mznS95L4DxNEUqa1QXoD2DumGdV0qFrbxqtAXPtpNthiSlE7pBQcIX91_UaPR6AQwqHZ69
 wzNckHqLI.f7HGN5c7.B7LCroiFwyjw3qM7rX5jin5t3SmF8ynzVds9cfDmTtv039S8Li5Wu7hLN
 ssFXMdExU1dYBNymhEs4gS3CcwSWw7BH0Z7BuGKNtwF3MmQcegWgC8NOf1GqM2MtzLoMJ04cS_Ly
 JenPQbNQ_Q92QHlL_dHT1QH1637S8g1wWE7ntfwLdOx9S.WtYjV7qzy8MBM3kbklbxjGVRWFDjgQ
 MhCyXjG0TcDXnKtltSzNA_FtsxTJZZDst_PBgqCSRGriWdup9rmMHXzYaF17coyXoK1wqNHOzPa.
 JdafDp7x71k9awuiAEyfJv8x8hFMecINjQ0XNz4oQAJNxQMRi5DQ2gz.9q4E7Qg3MItCVWRW3v1l
 X_v3IhqKjsRP6q6_2B0jG4BB6hhLIINDqmCGN2kkIUBRpAEMSsn4yC0p_Omr3hHUfYOsQgUVs2zb
 G4osYg_o2CnV8X79DJnety.pfLz1UWAMNu.qL_dI47BvYZi3jaJz9jia6CWUq_9ad8dalm2AUZhg
 05pZ04pi2JimNcTNpSTBrNaDhMLQ_hwld0yySJfEncUtMtXu4wdfPjhMlzWidIS0ZqV..jkJljgx
 vUhg_WJQ2ftEpK1AUtlZGcGUTTaLvpDnGPQESaKxTHE2cmCDTozmpj83gM5pj.p4uvpcDepmWCDy
 xaYKHEvM9H3qwYcjjD45Y4eTjC9kRWgvfEUL4u3MLuu42rAvJHEoax_2Ya_G.Xi2zgqv5hvG8uIW
 tPpJZPgut3Xec6VjvJSFSIL.3xIkx5z3bHAvfAapoStWYS.0fEIEm.KHWSk.nK3zPupkocEbBsBp
 1ttbH5PfJWqJR1OYs
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: d68f3c3e-763b-4d8b-bc78-41d73a72a9c4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:03:33 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:26 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] staging: sm250fb: remove USE_HW_I2C check
Date: Thu, 17 Apr 2025 20:02:49 +0100
Message-ID: <20250417190302.13811-2-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417190302.13811-1-rubenru09@aol.com>
References: <20250417190302.13811-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes the USE_HW_I2C check and function defines in
ddk750_sii164.c.

The software equivalents were never used due to
USE_HW_I2C being defined just before the ifdef, meaning
the hardware versions were always used.

The define names were also triggering checkpatch.pl's
camel case check.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>

---

I am somewhat unsure whether this is the way to go or
the correct way would be to add an option/opportunity for
the software version to be used. Currently the hardware
version is always used, but I am unsure if there ever even
would be a case where you would want to use the software
version over the hardware version.

I do not have the hardware in question so I cannot test
what the difference between the two versions exactly is.

I also note that the removal is mentioned in the TODO,
however once again this is currently hardcoded.
---
 drivers/staging/sm750fb/ddk750_sii164.c | 63 ++++++++++---------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 89700fc5dd2e..dd7811b18bf6 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -8,17 +8,6 @@
 /* I2C Address of each SII164 chip */
 #define SII164_I2C_ADDRESS                  0x70
 
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
 /* SII164 Vendor and Device ID */
 #define SII164_VENDOR_ID                    0x0001
 #define SII164_DEVICE_ID                    0x0006
@@ -39,10 +28,10 @@ unsigned short sii164_get_vendor_id(void)
 {
 	unsigned short vendorID;
 
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_VENDOR_ID_LOW);
+	vendorID = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+							  SII164_VENDOR_ID_HIGH) << 8) |
+		   (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+							 SII164_VENDOR_ID_LOW);
 
 	return vendorID;
 }
@@ -58,10 +47,10 @@ unsigned short sii164_get_device_id(void)
 {
 	unsigned short device_id;
 
-	device_id = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
-					      SII164_DEVICE_ID_LOW);
+	device_id = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+							   SII164_DEVICE_ID_HIGH) << 8) |
+		   (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+							 SII164_DEVICE_ID_LOW);
 
 	return device_id;
 }
@@ -132,12 +121,8 @@ long sii164_init_chip(unsigned char edge_select,
 	unsigned char config;
 
 	/* Initialize the i2c bus */
-#ifdef USE_HW_I2C
 	/* Use fast mode. */
 	sm750_hw_i2c_init(1);
-#else
-	sm750_sw_i2c_init(DEFAULT_I2C_SCL, DEFAULT_I2C_SDA);
-#endif
 
 	/* Check if SII164 Chip exists */
 	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
@@ -176,7 +161,7 @@ long sii164_init_chip(unsigned char edge_select,
 		else
 			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		/*
 		 * De-skew enabled with default 111b value.
@@ -214,7 +199,7 @@ long sii164_init_chip(unsigned char edge_select,
 			config |= SII164_DESKEW_8_STEP;
 			break;
 		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
 
 		/* Enable/Disable Continuous Sync. */
 		if (continuous_sync_enable == 0)
@@ -231,12 +216,12 @@ long sii164_init_chip(unsigned char edge_select,
 		/* Set the PLL Filter value */
 		config |= ((pll_filter_value & 0x07) << 1);
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_PLL, config);
 
 		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		return 0;
 	}
@@ -283,17 +268,17 @@ void sii164_set_power(unsigned char powerUp)
 {
 	unsigned char config;
 
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	config = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 	if (powerUp == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	}
 }
 
@@ -306,7 +291,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hotPlugMode) {
 	case SII164_HOTPLUG_DISABLE:
@@ -325,7 +310,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
 }
 
 /*
@@ -338,7 +323,7 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
@@ -361,7 +346,7 @@ unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	hotPlugValue = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
 	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
@@ -381,7 +366,7 @@ unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    SII164_DETECT_MONITOR_STATE_MASK;
 	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
@@ -398,9 +383,9 @@ void sii164_clear_interrupt(void)
 	unsigned char detectReg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT,
+			       detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
-- 
2.45.2

