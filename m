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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7CC43603
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC681613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348956AbhDGGhZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348944AbhDGGhX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694C5C06174A;
        Tue,  6 Apr 2021 23:37:14 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p10so3695905pld.0;
        Tue, 06 Apr 2021 23:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dQrlDf0eDikumeOMgJ6ztK4P1o0ZR5DUf/qDrdQaE4g=;
        b=tVYXTWuH1N0C4RnwthpEI3savbkYox+RhtgZ2mFjU8Q7w6GEMIFs94zjEVTulflvkC
         Ouzrln1JTlBxQ2EJs77a04jkH/i/DeOq4236o8hwIO+uznKVPK8M8AarByMRIIZvIzoC
         tQe13+tZyS5cgQYS1ZWGltd1tcXmkr8OReKNt7ZXdypm/pcPhssPfPCfALQaF5LPL7Dy
         WleV/RfwrM5YKlIceCYNGfGLlHIOpOpPhu4sE/HUutrCFG8kow9svNXrhfNig5eyOd6Q
         aIPLNzsmQGReAWKrAkOsxCMF1ScpsoLWZ/0FSpma5VZe0zvSaosLD9VFcLiVywTnlk9f
         Azaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dQrlDf0eDikumeOMgJ6ztK4P1o0ZR5DUf/qDrdQaE4g=;
        b=DZ/svSS1tPH7Kn9UheGQJfSa03SGo2KA1ZZAAk2nSJm0doklVNWhxb/9l4eqjJgCDq
         ax9psFibQTR9jS4tmCO07XuQV7lmOPCylb0oWxG1uSS1FTdpYpSLxa9k1z5DmVOwvrpM
         YIdrVINxMaePI2h0RgudM/r12c2U0/CPzpPCUokHBk97IwnBGt4fcOp1E95xYZ8BCs76
         5Tl0suR4GGo3PIbBMuUXev8+Ljp6D+zJ0YAY+c+QfQBCSzY/qnuhC9c2365wTlZemUQq
         iBOXkf47eTeGm66FCnFbhAwv0rZVmf7wMlG6Hz1je0qGKhJ4cpCZgni2iw13qrMeYfBd
         V5vQ==
X-Gm-Message-State: AOAM5326lgWxzHkRkqKVhz2PUS0XnhM5el/1vSeM0cud643X6szOEatB
        DhOzSiessd4oqEJ1c/lNafU=
X-Google-Smtp-Source: ABdhPJwC2wF7XTq33ajE5NYMbxgVzCijJmae94EWZ6VhqV/eqM/QG7L8Et10IrnpxCRWw5hT/mrC2Q==
X-Received: by 2002:a17:902:d4c7:b029:e9:543c:58bc with SMTP id o7-20020a170902d4c7b02900e9543c58bcmr1757708plg.20.1617777433926;
        Tue, 06 Apr 2021 23:37:13 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id j21sm18707903pfc.114.2021.04.06.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:13 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:11 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/49] staging: sm750fb: Update function parameter names
 in ddk750_sii164.c
Message-ID: <53df8b6501a7849644fba613e194bfc297abb7c7.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for function
parameters in ddk750_sii164.c.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index a7e0f001d96f..869d74f53a6a 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -277,14 +277,14 @@ char *sii164_get_chip_string(void)
  *      This function sets the power configuration of the DVI Controller Chip.
  *
  *  Input:
- *      powerUp - Flag to set the power down or up
+ *      power_up - Flag to set the power down or up
  */
-void sii164_set_power(unsigned char powerUp)
+void sii164_set_power(unsigned char power_up)
 {
 	unsigned char config;
 
 	config = i2c_read_reg(SII164_I2C_ADDRESS, SII164_CONFIGURATION);
-	if (powerUp == 1) {
+	if (power_up == 1) {
 		/* Power up the chip */
 		config &= ~SII164_CONFIGURATION_POWER_MASK;
 		config |= SII164_CONFIGURATION_POWER_NORMAL;
@@ -302,13 +302,13 @@ void sii164_set_power(unsigned char powerUp)
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hotPlugMode)
+void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
 	unsigned char detectReg;
 
 	detectReg = i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
 		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
@@ -332,9 +332,9 @@ void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hotPlugMode
  *  sii164_enable_hot_plug_detection
  *      This function enables the Hot Plug detection.
  *
- *  enableHotPlug   - Enable (=1) / disable (=0) Hot Plug detection
+ *  enable_hot_plug   - Enable (=1) / disable (=0) Hot Plug detection
  */
-void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
 	unsigned char detectReg;
 
@@ -343,7 +343,7 @@ void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
 	 */
-	if (enableHotPlug != 0)
+	if (enable_hot_plug != 0)
 		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
 		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_DISABLE);
-- 
2.30.2

