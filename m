Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C2C43461
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692176052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbhDGGgS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbhDGGgR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE56EC06174A;
        Tue,  6 Apr 2021 23:36:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f29so9802956pgm.8;
        Tue, 06 Apr 2021 23:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d8ovuxYfB9+zqQGeJgdR8CqV8t9xX0UspHjHO2iP+oI=;
        b=PxdfwCQBWektpoQgkVweDVbU9rIFcwh7WpqLH1rEqatdwu50J2VaJ2jlMu/EpOUpXu
         BeHfMx7icVFrUAhKQnV2ST7plccdNO8o7ZRYhXXI2S6n/APsm9aTlAbhSIlX/MZa9608
         FKr0zp3zuORjznT3hKNJyA9UaA2GgO3Z1jIzeSp/REnr1VzVPCnsX6Wb9GVJURisgTd5
         ULgg01iDi7NDUybUWI6/2gWrmaQJKCKIOdSOAyzybF4on1cAMP2CQ+c8UFs9TIoAjfR4
         f7KouwPWP9UMIMPbsO+yvM5iFXPy1dP3iM0qqU7Yxv7ASJ/g1YFzmUXHGf3g2Aq8V28a
         uL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d8ovuxYfB9+zqQGeJgdR8CqV8t9xX0UspHjHO2iP+oI=;
        b=fNTxx5Xo7n7LsfcOHLz3Ln1kHqMkg8ibHMJhJ771ujklLKrVDZ1qfi4L6ZjRzUu0VH
         LgmjKXyUlB20DN3FcyxRpwWnbRbO5h9BBA2cVfu03Kni7UnvMPnMyaTDobiM0FThubSg
         /Dpf67v4Y4uIERUhG/aZ2SvuNlXn5sdLP7dNO9KyK+JwJ982U1j4EdyuTRydx9hB52u7
         bQxeIPw7yvOXtC23nZJwtWVTjVaQjbbyurn5GkmSfYWsavkHqiqtDjANv+eGn1WaNvs0
         FYeLWisg0NNTLpStHN1OSdB55xERojcWRAiBOZ8bldcd+Yooo562FmR+l6eqzvJxz9hb
         YkrQ==
X-Gm-Message-State: AOAM532BNAxynymtv9nMMQpvXoLGEx4fKMgI9i+MLVGNpnvf72hlebny
        OM6DSS9N2ICF8ZtkrAf+3U4=
X-Google-Smtp-Source: ABdhPJzYdiOWR58SziSMST5L8m60UsYF/HgfFlh9MmXvieSHl52C4trBgIXQBhIa6Z5s8REh2AlfEg==
X-Received: by 2002:a63:5c48:: with SMTP id n8mr1836343pgm.411.1617777368335;
        Tue, 06 Apr 2021 23:36:08 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id h1sm20780672pfq.137.2021.04.06.23.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:07 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:06 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/49] staging: sm750fb: Remove type names in variables
 and type definitions
Message-ID: <9c9f21eab07b55b365cf0265ec81aaf4a8fc0c2f.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove type names used in variables and type definitions for
dvi_ctrl_device structure.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c | 24 ++++++++---------
 drivers/staging/sm750fb/ddk750_dvi.h | 40 ++++++++++++++--------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 943cbcafcffa..2743778abaab 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -14,17 +14,17 @@
 static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.pfn_init = sii164_init_chip,
-		.pfn_get_vendor_id = sii164_get_vendor_id,
-		.pfn_get_device_id = sii164_get_device_id,
+		.init = sii164_init_chip,
+		.get_vendor_id = sii164_get_vendor_id,
+		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.pfn_reset_chip = sii164_reset_chip,
-		.pfn_get_chip_string = sii164_get_chip_string,
-		.pfn_set_power = sii164_set_power,
-		.pfn_enable_hot_plug_detection = sii164_enable_hot_plug_detection,
-		.pfn_is_connected = sii164_is_connected,
-		.pfn_check_interrupt = sii164_check_interrupt,
-		.pfn_clear_interrupt = sii164_clear_interrupt,
+		.reset_chip = sii164_reset_chip,
+		.get_chip_string = sii164_get_chip_string,
+		.set_power = sii164_set_power,
+		.enable_hot_plug_detection = sii164_enable_hot_plug_detection,
+		.is_connected = sii164_is_connected,
+		.check_interrupt = sii164_check_interrupt,
+		.clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
@@ -44,8 +44,8 @@ int dvi_init(unsigned char edge_select,
 	struct dvi_ctrl_device *current_dvi_ctrl;
 
 	current_dvi_ctrl = dcft_supported_dvi_controller;
-	if (current_dvi_ctrl->pfn_init) {
-		return current_dvi_ctrl->pfn_init(edge_select,
+	if (current_dvi_ctrl->init) {
+		return current_dvi_ctrl->init(edge_select,
 						bus_select,
 						dual_edge_clk_select,
 						hsync_enable,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index b2fd56ef51fc..8aee0cdf63a4 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -4,7 +4,7 @@
 
 /* dvi chip stuffs structros */
 
-typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
+typedef long (*DVICTRL_INIT)(unsigned char edge_select,
 				 unsigned char bus_select,
 				 unsigned char dual_edge_clk_select,
 				 unsigned char hsync_enable,
@@ -15,28 +15,28 @@ typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
 				 unsigned char pll_filter_enable,
 				 unsigned char pll_filter_value);
 
-typedef void (*PFN_DVICTRL_RESETCHIP)(void);
-typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
-typedef unsigned short (*PFN_DVICTRL_GETVENDORID)(void);
-typedef unsigned short (*PFN_DVICTRL_GETDEVICEID)(void);
-typedef void (*PFN_DVICTRL_SETPOWER)(unsigned char powerUp);
-typedef void (*PFN_DVICTRL_HOTPLUGDETECTION)(unsigned char enableHotPlug);
-typedef unsigned char (*PFN_DVICTRL_ISCONNECTED)(void);
-typedef unsigned char (*PFN_DVICTRL_CHECKINTERRUPT)(void);
-typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
+typedef void (*DVICTRL_RESETCHIP)(void);
+typedef char* (*DVICTRL_GETCHIPSTRING)(void);
+typedef unsigned short (*DVICTRL_GETVENDORID)(void);
+typedef unsigned short (*DVICTRL_GETDEVICEID)(void);
+typedef void (*DVICTRL_SETPOWER)(unsigned char powerUp);
+typedef void (*DVICTRL_HOTPLUGDETECTION)(unsigned char enableHotPlug);
+typedef unsigned char (*DVICTRL_ISCONNECTED)(void);
+typedef unsigned char (*DVICTRL_CHECKINTERRUPT)(void);
+typedef void (*DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
 struct dvi_ctrl_device {
-	PFN_DVICTRL_INIT		pfn_init;
-	PFN_DVICTRL_RESETCHIP		pfn_reset_chip;
-	PFN_DVICTRL_GETCHIPSTRING	pfn_get_chip_string;
-	PFN_DVICTRL_GETVENDORID		pfn_get_vendor_id;
-	PFN_DVICTRL_GETDEVICEID		pfn_get_device_id;
-	PFN_DVICTRL_SETPOWER		pfn_set_power;
-	PFN_DVICTRL_HOTPLUGDETECTION	pfn_enable_hot_plug_detection;
-	PFN_DVICTRL_ISCONNECTED		pfn_is_connected;
-	PFN_DVICTRL_CHECKINTERRUPT	pfn_check_interrupt;
-	PFN_DVICTRL_CLEARINTERRUPT	pfn_clear_interrupt;
+	DVICTRL_INIT			init;
+	DVICTRL_RESETCHIP		reset_chip;
+	DVICTRL_GETCHIPSTRING		get_chip_string;
+	DVICTRL_GETVENDORID		get_vendor_id;
+	DVICTRL_GETDEVICEID		get_device_id;
+	DVICTRL_SETPOWER		set_power;
+	DVICTRL_HOTPLUGDETECTION	enable_hot_plug_detection;
+	DVICTRL_ISCONNECTED		is_connected;
+	DVICTRL_CHECKINTERRUPT	check_interrupt;
+	DVICTRL_CLEARINTERRUPT	clear_interrupt;
 };
 
 #define DVI_CTRL_SII164
-- 
2.30.2

