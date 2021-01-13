Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE0C4332B
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AE823602
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbhAMOv6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbhAMOv5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493FC0617BC
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r7so2408351wrc.5
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Pf7w6hja2pyQaiiphc9339t7wWdI+GqQadABJm8g7Y=;
        b=sst9frRzW/IJefwutBUvPoGyyHkMdmNCE2/2cJ1SvAob/HspH1X56uzjWNN7XPuilz
         wdKSM/9Hqj3XNtAA/hBuaE7G/g9i5BxwEMY6nf9eunFCXOpEAB+tkTQ53x6HPpg6jtJ5
         4/CwTTvIH5eIMy9CUXAYqkwetX52U5C8J5iXu+ftxRcgI6ioB4TaWFUZokVU0jMRv4go
         iVThPqkc16K5jm14VkBnPxRc0KOF1l7502J6ctNsR0SVyVrAujPyJcOPpNmjUaQa0T2D
         QXsr/aNolpDchgMH7vINY63kaYmkDnVOFM9EKwvSgcfdyGaw5+y6o1AKmnSdmQwT2uZv
         +w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Pf7w6hja2pyQaiiphc9339t7wWdI+GqQadABJm8g7Y=;
        b=SePMincq7t0s4yKgT4+GuGTvRsprFIqZ7cn7pmKSreCUa5OBh8gJc7e8DO2jpaXw9m
         gOh3qoL+607U2Wk152/1ziq0ugXAEb3ztPgZmHNTEffXLWHT++Z9c1NWdI1I/THdTdLQ
         z1g39U6mbiFddXKzVZ6hYpMGjamnl9SC1NkcDD3zWqOMN3zK5mAnjwm7J3nUK7lX+X0u
         H7sCJ1gFGMZsy9jyVsf7fMH9kJBssl94LLMu1tpid8gzZGr59Dzv7idYO32hc7m3Unwe
         Wfjsgxynf2loGdzKWtwVl3BasALUD4gWUnLQsGFDcvHMr34JAZV4D9UVwd1qSHJpBGrt
         BxoA==
X-Gm-Message-State: AOAM532hglk5UjE3If7/X+TMyuqdVpxUP+qwFLeuw8TDSyazpxaBVtqF
        5QGQ5xMcWjJTAicMV4THGVkp2Q==
X-Google-Smtp-Source: ABdhPJw7YBO0Y3mdZUBWXhnPmv13OWbKuieV4zDqiFanxqcxWiLlKLymFuWigA/Hr4jjfIkyPRZuxQ==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr3137113wro.338.1610549428139;
        Wed, 13 Jan 2021 06:50:28 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 09/31] video: fbdev: sis: Remove superfluous include of 'init.h'
Date:   Wed, 13 Jan 2021 14:49:47 +0000
Message-Id: <20210113145009.1272040-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Neither 'sis.h' nor any of its consumers uses these tables.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sis/init.h:144:28: warning: ‘SiS_VGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:132:28: warning: ‘SiS_EGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:120:28: warning: ‘SiS_CGA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:108:28: warning: ‘SiS_MDA_DAC’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:106:29: warning: ‘ModeIndex_310_2048x1536’ defined but not used [-Wunused-const-variable
 drivers/video/fbdev/sis/init.h:105:29: warning: ‘ModeIndex_300_2048x1536’ defined but not used [-Wunused-const-variable
 drivers/video/fbdev/sis/init.h:104:29: warning: ‘ModeIndex_1920x1440’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:103:29: warning: ‘ModeIndex_1920x1080’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:102:29: warning: ‘ModeIndex_1600x1200’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:101:29: warning: ‘ModeIndex_1680x1050’ defined but not used [-Wunused-const-variable=]
 drivers/video/fbdev/sis/init.h:100:29: warning: ‘ModeIndex_1400x1050’ defined but not used [-Wunused-const-variable=]

NB: Snipped - there are 277 of these!

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/sis.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/sis/sis.h b/drivers/video/fbdev/sis/sis.h
index 9f4c3093ccb36..d632f096083b3 100644
--- a/drivers/video/fbdev/sis/sis.h
+++ b/drivers/video/fbdev/sis/sis.h
@@ -15,7 +15,6 @@
 
 #include "vgatypes.h"
 #include "vstruct.h"
-#include "init.h"
 
 #define VER_MAJOR		1
 #define VER_MINOR		8
-- 
2.25.1

