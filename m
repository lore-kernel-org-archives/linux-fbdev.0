Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8264C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6D223600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbhAMOwq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbhAMOwX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:23 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22BC06135E
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so2387847wrm.11
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzS3qZvHYgaPOU1XJ8pzaZK9gKJ87LqYUfVBvla6rAk=;
        b=r5T8a1xoDb37mL9jIaJql8CuqF65c13F0JN0BADlmBJtoOSiLcHLQQE0zXy42jaISG
         L+mOCdoDYshlaFwezWabUiL61Rpla5d4FFyMQCCDUECkUNO1e6hFSngniGnbMl3TwRw+
         0YBTdOFYXyzAsLFnu8j9xEbDQHDJuqj6YN1tK1TxHEmTQvc5vFrEV8J9bQUUCzhlQc/L
         uEKFperGkCjqCYYjupjJDiL5O1pf0WMWVTyoYuZMKqCrDTJBlNsucq2nS6FxjcouMcm8
         ZJnYRxOZO/pAbljJIw7+ZWc1fEo6pqh7BSCCdYtMIEOpTqkl93Az01qWCSLh9dnj+3/e
         0yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzS3qZvHYgaPOU1XJ8pzaZK9gKJ87LqYUfVBvla6rAk=;
        b=QddTVf3lr9OOq38qIkphofpN+ycGTnbMk3qmEBoEFU0262tpCIEFsXBpFkfX7IaSYS
         yoLcVw8aTZmJqNZODH5zI5HmI1o1f/wpog1gmcSYhf4/Tp8ZAb1MaZeEO2/O7jT2jHvB
         pRd0W7FQYB9x1wrTfQGRiPvqFCIay/OoM1U9qZgfiSrNZQQ4wAD4Yy60sVMIcPEsQqiP
         6LrE2Y2US3hQRsf1BXiiNEor/zd1v7j7jAdWZGVoyK4tsy9PeAlYiI1mWi8YXpKmMRoM
         5tXNiFAv/pM5nO9XPHKSoueDwa87ILGj5+2DP4E+AUoWDS/JV/98tC5+ebRAEXkL03MI
         BPZg==
X-Gm-Message-State: AOAM530anki7RsUj8iK8jmeZN+kdL246m+L1hQGZmk9RmXyvF6mD7sbJ
        RYy8fgL19ujYiCs1pW+K6rhSdA==
X-Google-Smtp-Source: ABdhPJwWW8Mh0VQz40rTJwa/0e7kE/8p2NvxyZJuFij95jhV38CZu46wo+9mK5ByYWZwB9G7KRUEhQ==
X-Received: by 2002:a5d:5227:: with SMTP id i7mr3134555wra.68.1610549454505;
        Wed, 13 Jan 2021 06:50:54 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Ben Dooks <ben@simtec.co.uk>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 29/31] video: fbdev: s1d13xxxfb: Function name must be on the 2nd line in kernel-doc
Date:   Wed, 13 Jan 2021 14:50:07 +0000
Message-Id: <20210113145009.1272040-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/s1d13xxxfb.c:515: warning: Cannot understand  *

Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s1d13xxxfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index e6e8bc74412c6..b21627c07f8d0 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -512,7 +512,6 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 }
 
 /**
- *
  *	s1d13xxxfb_bitblt_solidfill - accelerated solidfill function
  *	@info : framebuffer structure
  *	@rect : fb_fillrect structure
-- 
2.25.1

