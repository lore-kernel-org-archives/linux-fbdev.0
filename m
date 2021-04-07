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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DF6C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B21E36052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbhDGGgL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345797AbhDGGgJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D547C061756;
        Tue,  6 Apr 2021 23:35:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y2so8830346plg.5;
        Tue, 06 Apr 2021 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6C1VG94DXJmRElgd9BUdwwz/TIojJvKsjgpldW3yH08=;
        b=dbybRTa/Ml6XWFTXvUPiV1wTcKtPk0A6X8l9l8EA8SrHjiWYSqY7BU8G2N0D3CbRg+
         gg0ugqFFeUUYnbI+dXUjQn4fEEwcsb5wRU57EMVUazh+ROIbxcNOcnMnRHbm3mWD2KSs
         mnPScFC/fFdc7duNYLFrV1nVjeFVFTzX7HSaigdLC4O5Gg8ARKxlXF8cVtjaARDI8wWB
         g3jgLq9f87yEGaicajMjSJuFgmJH9aFyDBvVyzYPdxuVPMjzWHOhZTCXuPT0gVTll1QR
         Gk7ngBjKKPAJ7zoehiy4tUg2TLVj0o0r++E3nvLEUfTG+/X9yuKweoRtUrh1A2Xyz4LC
         eOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6C1VG94DXJmRElgd9BUdwwz/TIojJvKsjgpldW3yH08=;
        b=Ed625wllxVdXqIf9tDdP150ip6fcmE5EAM+q+j750qlwJCKgwDAPNLTYY0rQwsjKpm
         PccUX/AMZ+xyIqBGQDdifHuylAHPRimZPh1FjLbHqe/RZ6t800vJOeUwxV9V96qCykzx
         PCPkIQCIsgHHwcOOFzvDpQNVC3HuE7tAAqxnnP+ZoCZC/6VZdhspIjEHAlhyI1EgLmc2
         vwWrdUnM2dVYrn0MRICTXI98rf7s5JuTgYzVPDb3hBxyR4rS3kGPyRRAHk8yCkISikNN
         YcNXF8JAodhb9Gdahe40ff0RsnRS8KDuFFrXfEU79O5AsCg1jZc3aJCq53lb0msut2Y2
         b1tQ==
X-Gm-Message-State: AOAM533fXqrfrnMH0nG7ND8IWw8hqOPSUJoc5Esvwd9PbRlu+mPlYAeM
        Phem9hAMb3M/G1ovUTClZFI=
X-Google-Smtp-Source: ABdhPJwm6c7FEAbAd5EvvprcxCDFCYTJLgDE0AVQ43UGbHpu8AaOLI/APORmFUkmZhJEEhV/eg1i1g==
X-Received: by 2002:a17:902:6ac3:b029:e6:c6a3:a697 with SMTP id i3-20020a1709026ac3b02900e6c6a3a697mr1846232plt.2.1617777358776;
        Tue, 06 Apr 2021 23:35:58 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id p5sm4232548pfg.85.2021.04.06.23.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:35:58 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:35:56 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/49] staging: sm750fb: Update dvi_ctrl_device to snake
 case
Message-ID: <a3618331115064265bc3bbf8963a84ee8bb57fed.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for dvi_ctrl_device structure and
its usages.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 30 ++++++++--------
 drivers/staging/sm750fb/ddk750_dvi.h    | 20 +++++------
 drivers/staging/sm750fb/ddk750_sii164.c | 48 ++++++++++++-------------
 drivers/staging/sm750fb/ddk750_sii164.h | 20 +++++------
 4 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index cd564ea40779..db19bf732482 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -11,20 +11,20 @@
  * function API. Please set the function pointer to NULL whenever the function
  * is not supported.
  */
-static struct dvi_ctrl_device g_dcftSupportedDviController[] = {
+static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #ifdef DVI_CTRL_SII164
 	{
-		.pfnInit = sii164InitChip,
-		.pfnGetVendorId = sii164GetVendorID,
-		.pfnGetDeviceId = sii164GetDeviceID,
+		.pfn_init = sii164_init_chip,
+		.pfn_get_vendor_id = sii164_get_vendor_id,
+		.pfn_get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.pfnResetChip = sii164ResetChip,
-		.pfnGetChipString = sii164GetChipString,
-		.pfnSetPower = sii164SetPower,
-		.pfnEnableHotPlugDetection = sii164EnableHotPlugDetection,
-		.pfnIsConnected = sii164IsConnected,
-		.pfnCheckInterrupt = sii164CheckInterrupt,
-		.pfnClearInterrupt = sii164ClearInterrupt,
+		.pfn_reset_chip = sii164_reset_chip,
+		.pfn_get_chip_string = sii164_get_chip_string,
+		.pfn_set_power = sii164_set_power,
+		.pfn_enable_hot_plug_detection = sii164_enable_hot_plug_detection,
+		.pfn_is_connected = sii164_is_connected,
+		.pfn_check_interrupt = sii164_check_interrupt,
+		.pfn_clear_interrupt = sii164_clear_interrupt,
 #endif
 	},
 #endif
@@ -41,11 +41,11 @@ int dviInit(unsigned char edge_select,
 	    unsigned char pll_filter_enable,
 	    unsigned char pll_filter_value)
 {
-	struct dvi_ctrl_device *pCurrentDviCtrl;
+	struct dvi_ctrl_device *current_dvi_ctrl;
 
-	pCurrentDviCtrl = g_dcftSupportedDviController;
-	if (pCurrentDviCtrl->pfnInit) {
-		return pCurrentDviCtrl->pfnInit(edge_select,
+	current_dvi_ctrl = dcft_supported_dvi_controller;
+	if (current_dvi_ctrl->pfn_init) {
+		return current_dvi_ctrl->pfn_init(edge_select,
 						bus_select,
 						dual_edge_clk_select,
 						hsync_enable,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 1c7a565b617a..4ca2591ea94b 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -27,16 +27,16 @@ typedef void (*PFN_DVICTRL_CLEARINTERRUPT)(void);
 
 /* Structure to hold all the function pointer to the DVI Controller. */
 struct dvi_ctrl_device {
-	PFN_DVICTRL_INIT		pfnInit;
-	PFN_DVICTRL_RESETCHIP		pfnResetChip;
-	PFN_DVICTRL_GETCHIPSTRING	pfnGetChipString;
-	PFN_DVICTRL_GETVENDORID		pfnGetVendorId;
-	PFN_DVICTRL_GETDEVICEID		pfnGetDeviceId;
-	PFN_DVICTRL_SETPOWER		pfnSetPower;
-	PFN_DVICTRL_HOTPLUGDETECTION	pfnEnableHotPlugDetection;
-	PFN_DVICTRL_ISCONNECTED		pfnIsConnected;
-	PFN_DVICTRL_CHECKINTERRUPT	pfnCheckInterrupt;
-	PFN_DVICTRL_CLEARINTERRUPT	pfnClearInterrupt;
+	PFN_DVICTRL_INIT		pfn_init;
+	PFN_DVICTRL_RESETCHIP		pfn_reset_chip;
+	PFN_DVICTRL_GETCHIPSTRING	pfn_get_chip_string;
+	PFN_DVICTRL_GETVENDORID		pfn_get_vendor_id;
+	PFN_DVICTRL_GETDEVICEID		pfn_get_device_id;
+	PFN_DVICTRL_SETPOWER		pfn_set_power;
+	PFN_DVICTRL_HOTPLUGDETECTION	pfn_enable_hot_plug_detection;
+	PFN_DVICTRL_ISCONNECTED		pfn_is_connected;
+	PFN_DVICTRL_CHECKINTERRUPT	pfn_check_interrupt;
+	PFN_DVICTRL_CLEARINTERRUPT	pfn_clear_interrupt;
 };
 
 #define DVI_CTRL_SII164
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 73e0e9f41ec5..6c343e2e0433 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -29,13 +29,13 @@ static char *gDviCtrlChipName = "Silicon Image SiI 164";
 #endif
 
 /*
- *  sii164GetVendorID
+ *  sii164_get_vendor_id
  *      This function gets the vendor ID of the DVI controller chip.
  *
  *  Output:
  *      Vendor ID
  */
-unsigned short sii164GetVendorID(void)
+unsigned short sii164_get_vendor_id(void)
 {
 	unsigned short vendorID;
 
@@ -48,13 +48,13 @@ unsigned short sii164GetVendorID(void)
 }
 
 /*
- *  sii164GetDeviceID
+ *  sii164_get_device_id
  *      This function gets the device ID of the DVI controller chip.
  *
  *  Output:
  *      Device ID
  */
-unsigned short sii164GetDeviceID(void)
+unsigned short sii164_get_device_id(void)
 {
 	unsigned short deviceID;
 
@@ -72,7 +72,7 @@ unsigned short sii164GetDeviceID(void)
  */
 
 /*
- *  sii164InitChip
+ *  sii164_init_chip
  *      This function initialize and detect the DVI controller chip.
  *
  *  Input:
@@ -118,7 +118,7 @@ unsigned short sii164GetDeviceID(void)
  *      0   - Success
  *     -1   - Fail.
  */
-long sii164InitChip(unsigned char edge_select,
+long sii164_init_chip(unsigned char edge_select,
 		    unsigned char bus_select,
 		    unsigned char dual_edge_clk_select,
 		    unsigned char hsync_enable,
@@ -140,8 +140,8 @@ long sii164InitChip(unsigned char edge_select,
 #endif
 
 	/* Check if SII164 Chip exists */
-	if ((sii164GetVendorID() == SII164_VENDOR_ID) &&
-	    (sii164GetDeviceID() == SII164_DEVICE_ID)) {
+	if ((sii164_get_vendor_id() == SII164_VENDOR_ID) &&
+	    (sii164_get_device_id() == SII164_DEVICE_ID)) {
 		/*
 		 *  Initialize SII164 controller chip.
 		 */
@@ -250,36 +250,36 @@ long sii164InitChip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
-	sii164SetPower(0);
-	sii164SetPower(1);
+	sii164_set_power(0);
+	sii164_set_power(1);
 }
 
 /*
- * sii164GetChipString
+ * sii164_get_chip_string
  *      This function returns a char string name of the current DVI Controller
  *      chip.
  *
  *      It's convenient for application need to display the chip name.
  */
-char *sii164GetChipString(void)
+char *sii164_get_chip_string(void)
 {
 	return gDviCtrlChipName;
 }
 
 /*
- *  sii164SetPower
+ *  sii164_set_power
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
  *      powerUp - Flag to set the power down or up
  */
-void sii164SetPower(unsigned char powerUp)
+void sii164_set_power(unsigned char powerUp)
 {
 	unsigned char config;
 
@@ -329,12 +329,12 @@ void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
 }
 
 /*
- *  sii164EnableHotPlugDetection
+ *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
  *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 {
 	unsigned char detectReg;
 
@@ -350,14 +350,14 @@ void sii164EnableHotPlugDetection(unsigned char enableHotPlug)
 }
 
 /*
- *  sii164IsConnected
+ *  sii164_is_connected
  *      Check if the DVI Monitor is connected.
  *
  *  Output:
  *      0   - Not Connected
  *      1   - Connected
  */
-unsigned char sii164IsConnected(void)
+unsigned char sii164_is_connected(void)
 {
 	unsigned char hotPlugValue;
 
@@ -370,14 +370,14 @@ unsigned char sii164IsConnected(void)
 }
 
 /*
- *  sii164CheckInterrupt
+ *  sii164_check_interrupt
  *      Checks if interrupt has occurred.
  *
  *  Output:
  *      0   - No interrupt
  *      1   - Interrupt occurs
  */
-unsigned char sii164CheckInterrupt(void)
+unsigned char sii164_check_interrupt(void)
 {
 	unsigned char detectReg;
 
@@ -390,10 +390,10 @@ unsigned char sii164CheckInterrupt(void)
 }
 
 /*
- *  sii164ClearInterrupt
+ *  sii164_clear_interrupt
  *      Clear the hot plug interrupt.
  */
-void sii164ClearInterrupt(void)
+void sii164_clear_interrupt(void)
 {
 	unsigned char detectReg;
 
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index d940cb729066..cf17b9029496 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,7 +16,7 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164InitChip(unsigned char edgeSelect,
+long sii164_init_chip(unsigned char edgeSelect,
 		    unsigned char busSelect,
 		    unsigned char dualEdgeClkSelect,
 		    unsigned char hsyncEnable,
@@ -27,17 +27,17 @@ long sii164InitChip(unsigned char edgeSelect,
 		    unsigned char pllFilterEnable,
 		    unsigned char pllFilterValue);
 
-unsigned short sii164GetVendorID(void);
-unsigned short sii164GetDeviceID(void);
+unsigned short sii164_get_vendor_id(void);
+unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
-char *sii164GetChipString(void);
-void sii164SetPower(unsigned char powerUp);
-void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-unsigned char sii164IsConnected(void);
-unsigned char sii164CheckInterrupt(void);
-void sii164ClearInterrupt(void);
+void sii164_reset_chip(void);
+char *sii164_get_chip_string(void);
+void sii164_set_power(unsigned char powerUp);
+void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
+unsigned char sii164_is_connected(void);
+unsigned char sii164_check_interrupt(void);
+void sii164_clear_interrupt(void);
 #endif
 /*
  * below register definition is used for
-- 
2.30.2

