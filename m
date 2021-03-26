Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E28C433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 08:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E2F61A05
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 08:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhCZIFa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCZIFK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Mar 2021 04:05:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B8FC0613AA;
        Fri, 26 Mar 2021 01:05:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id m7so4064903pgj.8;
        Fri, 26 Mar 2021 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NwKF2Id58T0+Q4X2V9aN9037qk0PD32MTro/1e/Ds88=;
        b=ZLXpn/oZ49bMlmklfTI2k7sZhQ+0C9OeZ7VXB+Hywup9pWjxk5oRbgO8TE1cpoXC8C
         +PRsUv6OLr73zUTDgV/s/2KA51K0qJ97XZmtkNtZWSyR/HLsii8rLG+YF8Rs1vvwdwSC
         UgUjQHeCCAwU35QikQCNYIVc05SPPIrrvKCW9CHBVAk1i74czU7Agj8+73b5aRqmP/Kb
         M9ndBgKXOklbs5T5PYSqansXI8FoIy4FnVb78PHHKz/zUk5FpQQRT/OAktsr8Jxq9at8
         iWCFAf36ESjbFMIDmHO88JJuySpmwkFHIGCCLpjLjq6CfebDTL9yrBTy8fUmMWpDa/TV
         WQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NwKF2Id58T0+Q4X2V9aN9037qk0PD32MTro/1e/Ds88=;
        b=hx3zFK91I6mPSicW0B3uUZdvWJxFqAxFYhfpCYiYBOqmKEAQW+/gcEdVobLOjtqFgx
         epa662Lfluwg7/KVUyNsFq7s9nc8FS8hJIrJd+I5MDQoLjPYMm/9xXLwNr0RdaL9fsmR
         IYptzYvwWR8dvoc//kkqmGvvrvwxVoPDD+e0nEWG8snRMRwkbyCs4gNN8mOuX7stzcXN
         a/NB0blm9vuez1yo4c62IM3oi7uWXCT1q1sKnn0ZCEmZSTWBNv+fSGGe5NzIC2Z/oOBF
         qG37DP93jiotfKzOLp0odioMywkPlQto6izV6msipcZGUN+ZsTHPaNOPyZxoH6+SVzOV
         /kAw==
X-Gm-Message-State: AOAM5306gGqNWprHO9n/BBQWja6e+ByWKrCUpVOUjkS1eMLRmmX9P/oS
        PDovrnNE91hsD4MAtv6dFE8=
X-Google-Smtp-Source: ABdhPJzwYrWPBCp71W6OTSt/+NtkvOrHJVunRMdCWyg0J4RMLKpEsesX58sJxFEsq5BjNvX4Ogxlrw==
X-Received: by 2002:a63:4842:: with SMTP id x2mr708260pgk.229.1616745909929;
        Fri, 26 Mar 2021 01:05:09 -0700 (PDT)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id d8sm8661064pfq.27.2021.03.26.01.05.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 01:05:09 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@yulong.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: fix a typo
Date:   Fri, 26 Mar 2021 16:05:15 +0800
Message-Id: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: "Carlis" <zhangxuezhi1@yulong.com>

Change 'tft' to 'TFT'

Signed-off-by: Carlis <zhangxuezhi1@yulong.com>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 4f362da..44e7acb 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -775,7 +775,7 @@ void fbtft_framebuffer_release(struct fb_info *info)
 EXPORT_SYMBOL(fbtft_framebuffer_release);
 
 /**
- *	fbtft_register_framebuffer - registers a tft frame buffer device
+ *	fbtft_register_framebuffer - registers a TFT frame buffer device
  *	@fb_info: frame buffer info structure
  *
  *  Sets SPI driverdata if needed
@@ -873,7 +873,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 EXPORT_SYMBOL(fbtft_register_framebuffer);
 
 /**
- *	fbtft_unregister_framebuffer - releases a tft frame buffer device
+ *	fbtft_unregister_framebuffer - releases a TFT frame buffer device
  *	@fb_info: frame buffer info structure
  *
  *  Frees SPI driverdata if needed
-- 
1.9.1

