Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A1C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A1F235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhAMOvR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbhAMOvQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5E7C0617B0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m4so2388917wrx.9
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZA26LGPctNuqP7mpV6XCcQsQZ+HB0XmYF1B/7L0jYA=;
        b=YtqFI8RDxxpW9mdQOUk2m2f1SEWXkWNA5Pijok8cpdh3D28yUmkArEeHKDJHaMEw2D
         PdgSAP9Q4tLae/SkYSJ5eTZDO+n6pFatwv/TqUUoiuB320K732eTGq0iXq8oR/tNfkIH
         9Y7pMmU2dnvUJlE7Cdikh+7Q8gG1oq1Nl7lwW/RGcLXR8b/1SFcPKGDY/yVn+9vcaOw5
         ZsO4KDnuoqv4twTiAyGApWz9SY9RChb3/M/q2nVmM21sVoOCVxHdSCQemO93T1g3lrAj
         3Lx+99Zkwfs70d4L1iYYRAQVeIVTso9ON+bmqWt1gSMmPn5bt/vIUtmLPizMCW6GT2UM
         qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZA26LGPctNuqP7mpV6XCcQsQZ+HB0XmYF1B/7L0jYA=;
        b=sNy/rXDyoi+JNd/0eP4e7zJNDrclamzIw+b28gyQdWOpwzzz0BaeO0eGlsRGMSH4Ww
         X3l7TdD7/vIzyJ2L6ggj9zfnYBsm89UPEIbpvi3OBtygiGogfQxKr+/WjWCql/t8CJ5C
         6QxLAOB3B5OIwQRVz9okhLx3ITExsn0oMccdMz53I2B2obvd4FFH/YR8UcBBceZUsanY
         JGmkOqgWELMqDMMAtz1NIIiIv9RDtZbtzdNQvi17mxz7iQEkDqI5nmEFFjG4o9LY7yIQ
         dXx48VDK8YG5WUzkhEDwf/9xgjrxKSPOBN5kLJM0FacajfjLef3iG/7+WvP78QUJ/ynB
         HAHw==
X-Gm-Message-State: AOAM5320PQjDdl+d/eumW/sr4daELWW+xiNvRl6i2GdGaQV1KgVK3Hih
        HOXNX+xP/LRvqhiuT2fyTAsw+w==
X-Google-Smtp-Source: ABdhPJybD9xMfIqt11fPwnFfiI93H9p+YPj4ju8Xk0ywP3UrRKbDeRkdo75NDlfYMlTY1EKiKvzaMA==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr2935428wrw.379.1610549422311;
        Wed, 13 Jan 2021 06:50:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
        Brad Douglas <brad@neruo.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 06/31] video: fbdev: core: fb_notify: Demote non-conformant kernel-doc header
Date:   Wed, 13 Jan 2021 14:49:44 +0000
Message-Id: <20210113145009.1272040-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fb_notify.c:44: warning: Function parameter or member 'val' not described in 'fb_notifier_call_chain'
 drivers/video/fbdev/core/fb_notify.c:44: warning: Function parameter or member 'v' not described in 'fb_notifier_call_chain'

Cc: Antonino Daplas <adaplas@pol.net>
Cc: Brad Douglas <brad@neruo.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fb_notify.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da5288848..1f142182fb40e 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -36,9 +36,8 @@ int fb_unregister_client(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(fb_unregister_client);
 
-/**
+/*
  * fb_notifier_call_chain - notify clients of fb_events
- *
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
-- 
2.25.1

