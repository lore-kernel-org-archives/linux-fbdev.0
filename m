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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF18C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36966052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348967AbhDGGh2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348954AbhDGGhZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA77C06174A;
        Tue,  6 Apr 2021 23:37:16 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id n38so2504470pfv.2;
        Tue, 06 Apr 2021 23:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DYURKtLO6AtN4f6e54JwN9XZV55wF5BkCRQvFn99ABM=;
        b=ZxX/pDJ/ycCJIAr9JnYgENG2GHwcQVqthIG3lI/ZjHzcciTdYG0WM9Qn5EHVr4dSTR
         d07E5zpEoFac3yoE1GL+shm57oJYCLnrECJ/FrRKR4+0ncnfbb+uSyHKTX1zEo3dtSlE
         rwXz0xlHGvHAPTy1ter8A06UZKn16leAqQaNiZgb/4+KLyiv40okJ/7YVCLixloQrLsT
         SxPsyiQMq0bGeaCpX9XETtV7IANTvFcVBD1U5WY/+d6gnbCW3EsRXB4D1hoARcaZiSQH
         wuHXFV845voBWjKhQdcnKVtbYu+tekOE6gTMik2S5XCme1CUtyXqN93X2sG0w9TsQcnZ
         3m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYURKtLO6AtN4f6e54JwN9XZV55wF5BkCRQvFn99ABM=;
        b=OzSixYlAq2gy7yRKW2Gk1h6RyxNzrP81rYOFDY3zXyAmiDXgjm1oA2MLGUzLx+YS52
         goLeDJjYU63zIg1EDDqn7HakdR0vXGe3aRrxGPTHmdZueSXg3r+1C+AIYGjygPZNlv4d
         P27TUymTexrB4z64OO/mbaLfOGRuPnxlkOxAXP/4WIvWfuR/vcH8QK3NicvN5o/Rx1aY
         5trHwLsTxlqiNFrvW/puyR+iCXSFg3pDSdfyuftypGv6+B9gNYcV1lKfktDDUf3s8MZ7
         6raLoUdC3irbpDjX+uYf1We86Wlo8M4CuviXfISwfBn0YatspVuVVf78ZhZknbNle8Qz
         DFAw==
X-Gm-Message-State: AOAM531DNNqv0vGcN4TU/Zpfai/GGd/xbyk8RHSNBEAYSCVi+ojHhmbP
        vF+lVLyvGFyTBIFXicKmlmk=
X-Google-Smtp-Source: ABdhPJz2yOyJ5mHpagT/V01zGJIu58qjTR0EquQjsb+wWJOg/2MywFInIX9gMohojTtConxGWnLuZQ==
X-Received: by 2002:a63:cc05:: with SMTP id x5mr1867032pgf.254.1617777435642;
        Tue, 06 Apr 2021 23:37:15 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id kk6sm4290581pjb.51.2021.04.06.23.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:15 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:13 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/49] staging: sm750fb: Rename local variables to snake
 case
Message-ID: <031bfc81af290969ddfd06d211de6fc85db283ac.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for local
variables in SII164_FULL_FUNCTIONS block.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 869d74f53a6a..758a118e4421 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -304,28 +304,28 @@ void sii164_set_power(unsigned char power_up)
 static
 void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
 
-	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
 
 /*
@@ -336,9 +336,9 @@ void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mo
  */
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
@@ -359,11 +359,11 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
  */
 unsigned char sii164_is_connected(void)
 {
-	unsigned char hotPlugValue;
+	unsigned char hot_plug_value;
 
-	hotPlugValue = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	hot_plug_value = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
+	if (hot_plug_value == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
@@ -379,11 +379,11 @@ unsigned char sii164_is_connected(void)
  */
 unsigned char sii164_check_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
+	if (detect_reg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
@@ -395,12 +395,12 @@ unsigned char sii164_check_interrupt(void)
  */
 void sii164_clear_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
 	/* Clear the MDI interrupt */
-	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 	i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT,
-		    detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+		    detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
-- 
2.30.2

