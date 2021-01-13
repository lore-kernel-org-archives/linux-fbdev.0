Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA24CC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E38323600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbhAMOwC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbhAMOwB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:01 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2752C061383
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so1855227wmh.2
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7fOAdOMSh9+aZXnWVlTBiJqXaPtT0tmJFJgVlyDPug=;
        b=wkKY3gUVpw4qP/WuQzc8XjrzRncVeSuZ6NzeUbALePTgU3Yrbw7YLTdHcXZj56nxVU
         5Jh4wNloszsqH/vVqJxDDwBSRrJ2OCTzKTPcd5JzNVT5XIiv2M5crt5y5UskqbNAQTBB
         KvR9s7UwwCew+cXB1M/8JHMnIwXdbQxIScTfFklRChWJUy40Q3CuOodobSh9Um18qIvs
         FEHYZzDJPaKk06OPv4/h1Mi2+ufc5Xt/BqkVcO0w1K9kWocAZk5NMITW/2XtGYuEHFGY
         KaZnlzcDkLV1OrVCrmMpjQPrdUpM4TmeGqpdDN4K+fWyND84c6a9egSMvCEW1eojZ/Tv
         wkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7fOAdOMSh9+aZXnWVlTBiJqXaPtT0tmJFJgVlyDPug=;
        b=opm9PeHfXMYbO+wKL0puXzWOtmtIsrt9ibWJ1Y84mvpxSb1vfcOrr6d8mffXyhS+tH
         Gqc6R3B4KRQQPBthnhNI1PA3p8rIZWoNXAePBmfH6rSIpCjvAlQI6kXFXTJsFWY5wO82
         OkitS5xAB8DCm98T/80KVzZDtP333HRxOVhKMeqeMb0JTlrdD+bKDin2XcTSlcd/8BMS
         sg0pp6x47M4zjJSMPvHFL/sNnG1Mqb6cgCb7JcNapGOJvqebfF4yExrSQqASUnC3Yrew
         D+78KKqIJWD7LKymmFywUvjULJy1X+35D2rAgUndlDiv/9u7W+PWcuA+AlqBmJOSpe/1
         wTAA==
X-Gm-Message-State: AOAM532W35P9HIibKBMjoL5j0bECT5tHklR5bu/C54Z40YOY6krkNeFC
        x2v7b/tHRISxOHyvs9AeMwQEENEEfHn/qYQM
X-Google-Smtp-Source: ABdhPJwgWbKyROyg3P7kZzj3BsF17xohBzHH0P8bPH1Fo1biBkBRZcCRyPVkV1Whe5OHdIZxjMwpOQ==
X-Received: by 2002:a1c:cc14:: with SMTP id h20mr2564071wmb.180.1610549433405;
        Wed, 13 Jan 2021 06:50:33 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 12/31] video: fbdev: sis: oem310: Remove some unused static const tables
Date:   Wed, 13 Jan 2021 14:49:50 +0000
Message-Id: <20210113145009.1272040-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sis/oem310.h:213:28: warning: ‘SiS_TVDelay661_301B’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/oem310.h:203:28: warning: ‘SiS_TVDelay661_301’ defined but not used [-Wunused-const-variable=]

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/oem310.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/video/fbdev/sis/oem310.h b/drivers/video/fbdev/sis/oem310.h
index 8fce56e4482c0..5f7b503ed2a06 100644
--- a/drivers/video/fbdev/sis/oem310.h
+++ b/drivers/video/fbdev/sis/oem310.h
@@ -200,26 +200,6 @@ static const unsigned char SiS310_TVDelayCompensation_651302LV[] =	/* M650, 651,
 	0x33,0x33
 };
 
-static const unsigned char SiS_TVDelay661_301[] =			/* 661, 301 */
-{
-	0x44,0x44,
-	0x44,0x44,
-	0x00,0x00,
-	0x44,0x44,
-	0x44,0x44,
-	0x44,0x44
-};
-
-static const unsigned char SiS_TVDelay661_301B[] =			/* 661, 301B et al */
-{
-	0x44,0x44,
-	0x44,0x44,
-	0x00,0x00,
-	0x44,0x44,
-	0x44,0x44,
-	0x44,0x44
-};
-
 static const unsigned char SiS310_TVDelayCompensation_LVDS[] =		/* LVDS */
 {
 	0x0a,0x0a,
-- 
2.25.1

