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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB6DC43462
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B73F613CF
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbhDGGqV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345694AbhDGGqP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0AC06175F;
        Tue,  6 Apr 2021 23:46:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id j7so4152880plx.2;
        Tue, 06 Apr 2021 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RBA5zwvxY/1ia+fk/xzK8YHrNKoUOfjiRKh/7CEC92U=;
        b=mrhaeb+T/SIIYoEllcrxGKc1jjqGpydgzecq43Imy5Oy7UD1xJ5ZjVKZeucTjR1y9R
         Ch4axRbbD7Vw6VxFryHw1vLmpG5gx1N5yBeJGUV98gU5IGUDPbwFdPu1iE+8h9R3vAef
         BT1kHDDwzSzRYah8JADtv2j29ecgHdIciHmBH0n1eiAmnNuPuhPsDkHNTa7dHVYPllW2
         uAmNlzbfP+Svr0nJNes8kHeIHn2oIDiiX1atR9JX44iDjZbycsleENnVTAOdWp0t0Lwp
         LVNgNHk9w4DOZAHO7yp2/vNwk/CZjd2XKtszXWCJM2yQIs0orE4yCEE3Nvrc80H6orEE
         s9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RBA5zwvxY/1ia+fk/xzK8YHrNKoUOfjiRKh/7CEC92U=;
        b=mqlFS9PgNdKn+DQr1w6vklUsfY6B115kyY1tlWB48uhOAzDWvo5fs3+97zISoLKCeb
         ay2e2Y1DiMO+r8RxeH0VG+uuHT6etmhYAhu0GixpPBa+PzbEM1fR3VwB611XvL6Vdlvl
         ezFJVbrsJVIrqGfXAvSWrMImbN1kgIXLz0vhKD6M5gMO+kxdsjveEPCntZUz1Mn9W9T+
         6Cp7ST2Bs7WFG5cDcpsmhWbwm/eRsZVeuprciHFNf+xJZnEFrlvRUPcsiQZJUGuDGpMQ
         mgznWKhbW+Bw9LptC/+xgD6A5Kf2L1r1f3JNbasNyeOoChs2D83Q90MB9ttt9VVrccdD
         xA8g==
X-Gm-Message-State: AOAM533tzh/Jk5ywHq4WiC5C7A/T8GILO27chGEO0afalnJ6M4LVtcNW
        JDfjvqXvEmXwcelG2uSRTBc=
X-Google-Smtp-Source: ABdhPJyv4gfR0TnKChyY15jeg2ZsvS91QJc36GgO+qjGtG7OfaTaQ0WlLPQ5uAOEYQEjtLrODErihw==
X-Received: by 2002:a17:90a:bf91:: with SMTP id d17mr1854424pjs.138.1617777960944;
        Tue, 06 Apr 2021 23:46:00 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id k4sm2732908pgm.73.2021.04.06.23.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:45:58 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 38/49] staging: sm750fb: Rename function
 hw_sm750_setColReg to snake case
Message-ID: <4ecf65873d119290ba1173e2a1665b91fdaae9d6.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
hw_sm750_setColReg.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c    | 2 +-
 drivers/staging/sm750fb/sm750.h    | 2 +-
 drivers/staging/sm750fb/sm750_hw.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8e803b580a71..62c9a8c5de8f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -545,7 +545,7 @@ static int lynxfb_ops_setcolreg(unsigned int regno,
 		red >>= 8;
 		green >>= 8;
 		blue >>= 8;
-		ret = hw_sm750_setColReg(crtc, regno, red, green, blue);
+		ret = hw_sm750_set_col_reg(crtc, regno, red, green, blue);
 		goto exit;
 	}
 
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index b46d13134f76..71b4ce05f4fe 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -208,7 +208,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 			  struct fb_var_screeninfo *var,
 			  struct fb_fix_screeninfo *fix);
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index,
 		       ushort red, ushort green, ushort blue);
 
 int hw_sm750_setBLANK(struct lynxfb_output *output, int blank);
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 410f726b03e9..7eae56b74a2b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -372,7 +372,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	return ret;
 }
 
-int hw_sm750_setColReg(struct lynxfb_crtc *crtc, ushort index,
+int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index,
 		       ushort red, ushort green, ushort blue)
 {
 	static unsigned int add[] = {PANEL_PALETTE_RAM, CRT_PALETTE_RAM};
-- 
2.30.2

