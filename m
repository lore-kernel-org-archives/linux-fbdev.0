Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB79C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776126052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348919AbhDGGhR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348892AbhDGGhP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67B2C06174A;
        Tue,  6 Apr 2021 23:37:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y32so9079984pga.11;
        Tue, 06 Apr 2021 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vULtDa5keVBuOsfipQdVKGYBxEy7Ud81/4o2D3FTHWs=;
        b=XoKonTp1E4C28zmw43dvziWmtoduTK7P/adrpQQDP9obdlimDZDDGVMWdM0xEo8m/g
         xMV7eII7LP5cIGjZYynGHEQtEPE0VDh8mdgDhnd6PiL8xsHhelI0IcKG+dQ7dHTwvMO4
         XFgxOFeRJg2+XPLMXZ9MvY0ZHBBvqfWIOkA2wXYQ4+r0A9QcOmgScKibFIxv8ptfdm2U
         VcNAEovNhRnBT5ll5YVt7PLge0gX+L79GcznHdqLeBWmWNk3lYKeCAdxRHZ4f+o8Bc/6
         MjMC4rz698wUHSclZyr8hqUcG6xzT2ReVUTGZaaQ2Mm16ABeCCc7ZQtSwNJMknppV4Mv
         r7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vULtDa5keVBuOsfipQdVKGYBxEy7Ud81/4o2D3FTHWs=;
        b=gENmue8+jUe1gqhsD9QPAHqsINjNEjj71wM7sKHy1w30x2Djc4clBHXxd+trPTXd+x
         f/lIx0WDQCrUP+mzP5MftMPhy2F+Gruc26fGxPB+j6+o+cWONPG6fTpsl+99G7pc6cot
         xOwERODb8WMZX7vvq6cqwLKDpsf6Q1Vj+jhKqRj8TbsPk+726WvaHaPehmsib/IHZEOn
         gEtuRjNeSrP0o7GLjbc2/8YdMRNoQd2AIvHcMfz0TuKhhYmfWY6vxelIOA8UOWPrJxEx
         mYp+gnFZNRZ+f493IiubpgKdHT5FJX6a9fObk+KPJ3+0uZdhPqCIj249y0sqErFM9B21
         f4lQ==
X-Gm-Message-State: AOAM531XswNqHgp0BVqaYCMOJ3sdzChRBMS75Xhr7a5TwpAFWNkz+94D
        WxyQTrYv//bYVXIUhZ774oA=
X-Google-Smtp-Source: ABdhPJwS8g6q8EWYDwh7VZlr2HoIpM+960xrKG0v9PqsNci9JamJ6RO4Wp9euXTYeUjfHuJK1eFkHw==
X-Received: by 2002:a63:342:: with SMTP id 63mr1831044pgd.151.1617777426141;
        Tue, 06 Apr 2021 23:37:06 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id w26sm20734055pfj.58.2021.04.06.23.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:05 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:03 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/49] staging: sm750fb: Rename i2cWriteReg and i2cReadReg
 to snake case
Message-ID: <8a68f0a377016bd8026359e7ca10c658087ffac6.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for i2cWriteReg
and i2cReadReg in ddk750_sii164.c.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 46 ++++++++++++-------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 6c343e2e0433..af14273b99eb 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -12,11 +12,11 @@
 #define USE_HW_I2C
 
 #ifdef USE_HW_I2C
-    #define i2cWriteReg sm750_hw_i2c_write_reg
-    #define i2cReadReg  sm750_hw_i2c_read_reg
+    #define i2c_write_reg sm750_hw_i2c_write_reg
+    #define i2c_read_reg  sm750_hw_i2c_read_reg
 #else
-    #define i2cWriteReg sm750_sw_i2c_write_reg
-    #define i2cReadReg  sm750_sw_i2c_read_reg
+    #define i2c_write_reg sm750_sw_i2c_write_reg
+    #define i2c_read_reg  sm750_sw_i2c_read_reg
 #endif
 
 /* SII164 Vendor and Device ID */
@@ -39,9 +39,9 @@ unsigned short sii164_get_vendor_id(void)
 {
 	unsigned short vendorID;
 
-	vendorID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	vendorID = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_VENDOR_ID_LOW);
 
 	return vendorID;
@@ -58,9 +58,9 @@ unsigned short sii164_get_device_id(void)
 {
 	unsigned short deviceID;
 
-	deviceID = ((unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+	deviceID = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_DEVICE_ID_HIGH) << 8) |
-		   (unsigned short)i2cReadReg(SII164_I2C_ADDRESS,
+		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_DEVICE_ID_LOW);
 
 	return deviceID;
@@ -176,7 +176,7 @@ long sii164_init_chip(unsigned char edge_select,
 		else
 			config |= SII164_CONFIGURATION_VSYNC_AS_IS;
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		/*
 		 * De-skew enabled with default 111b value.
@@ -214,7 +214,7 @@ long sii164_init_chip(unsigned char edge_select,
 			config |= SII164_DESKEW_8_STEP;
 			break;
 		}
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_DESKEW, config);
 
 		/* Enable/Disable Continuous Sync. */
 		if (continuous_sync_enable == 0)
@@ -231,12 +231,12 @@ long sii164_init_chip(unsigned char edge_select,
 		/* Set the PLL Filter value */
 		config |= ((pll_filter_value & 0x07) << 1);
 
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_PLL, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_PLL, config);
 
 		/* Recover from Power Down and enable output. */
-		config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+		config = i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 
 		return 0;
 	}
@@ -283,17 +283,17 @@ void sii164_set_power(unsigned char powerUp)
 {
 	unsigned char config;
 
-	config = i2cReadReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
+	config = i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
 	if (powerUp == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	} else {
 		/* Power down the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_DOWN;
-		i2cWriteReg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
+		i2c_write_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION, config);
 	}
 }
 
@@ -306,7 +306,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hotPlugMode) {
 	case SII164_HOTPLUG_DISABLE:
@@ -325,7 +325,7 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 		break;
 	}
 
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
 }
 
 /*
@@ -338,7 +338,7 @@ void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
@@ -361,7 +361,7 @@ unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
-	hotPlugValue = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	hotPlugValue = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
 	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
@@ -381,7 +381,7 @@ unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    SII164_DETECT_MONITOR_STATE_MASK;
 	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
@@ -398,8 +398,8 @@ void sii164_clear_interrupt(void)
 	unsigned char detectReg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2cReadReg(SII164_I2C_ADDRESS, SII164_DETECT);
-	i2cWriteReg(SII164_I2C_ADDRESS, SII164_DETECT,
+	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT,
 		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
-- 
2.30.2

