Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F215EC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB13223600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbhAMOxI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbhAMOwN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:13 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80297C061350
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so2409673wrc.5
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cx+Lvpr+opVztxwCrpEEue+3ZpAhdFGYil/Lm2hEOBU=;
        b=ClTWBKea4vm3y9ZVGUdkzqdOECtwhR9PudkWuiyjwsis41BqC493w/zvDp2ojr1Xuc
         ZKnKrxsByJZR0AsZRzPwnncxKrIpJo8q/JxnXgt5uVjgHffxSyJ/m/GiYYZFr0k/fKPF
         mAUTMzojahcDs+ltW3aBgJgY0pUiUSDu1uCQsHcM5514XCdauiHH8Frr9ruELCw0BD/E
         FTVVet0fiPEihuRkcU9+1jE680PoB0pOR4Fx8MdQ56p1l1lAxW4F53kcOf3dMgFbW0wD
         nLFBJyF35Zz+nr0o3nFYMPOFbn8EmarY0vsbpWCUmYqEvxpBpYIoiNLTuo7DHxfJGp22
         4RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cx+Lvpr+opVztxwCrpEEue+3ZpAhdFGYil/Lm2hEOBU=;
        b=F7lhjmfDQ6BM5+eilNcKvFbQRGlxYJeFwDo5UzGSK/N2vozv5sOjyu3cVZdNEAKJZp
         HoyOPoIbeFZtHg/XlUJNQ/BShCoBulXE1rT08L6ZnuRNqlSN7aMxQWMf3N5p/L5+U7EB
         54MsEYEUm5NNOOJgEWq+RPkxkgcOjTSl09FYNvICTO/4LArasbgty2SzQRiyeP4TBAES
         IUs3d2vbYczFF4HJFRo0OfpYLNzvwTBTfBy0zx46vLr+DyUxDxLl4d2j5IbquVqYoRvV
         UjHjsp8W9GBmcf0syM/SpiveLe29qL4QHmNaFS6ETr5uWPLnrHBm9N2/f4MMarWxp34p
         JqHQ==
X-Gm-Message-State: AOAM5313mzOuLHZv9dVtHGQeIW0+KgujQ7Zw1cP5eMyzqP62FfRoyL04
        +HrjC2o4ddfmxHTepr6NaafHyQ==
X-Google-Smtp-Source: ABdhPJy85VePePA0CqsKm5siGrKpak6OmOYMGqGLRupA7S/S8zgvi5kBWxRpHIlYj831TLmAru4Taw==
X-Received: by 2002:a5d:674b:: with SMTP id l11mr3094653wrw.247.1610549449265;
        Wed, 13 Jan 2021 06:50:49 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Software Engineering <lg@denx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 25/31] video: fbdev: mx3fb: Remove unused variable 'enabled'
Date:   Wed, 13 Jan 2021 14:50:03 +0000
Message-Id: <20210113145009.1272040-26-lee.jones@linaro.org>
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

 drivers/video/fbdev/mx3fb.c: In function ‘sdc_disable_channel’:
 drivers/video/fbdev/mx3fb.c:448:11: warning: variable ‘enabled’ set but not used [-Wunused-but-set-variable]

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Software Engineering <lg@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/mx3fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index 894617ddabcb6..d1c8f7a969ac3 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -445,7 +445,6 @@ static void sdc_enable_channel(struct mx3fb_info *mx3_fbi)
 static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 {
 	struct mx3fb_data *mx3fb = mx3_fbi->mx3fb;
-	uint32_t enabled;
 	unsigned long flags;
 
 	if (mx3_fbi->txd == NULL)
@@ -453,7 +452,7 @@ static void sdc_disable_channel(struct mx3fb_info *mx3_fbi)
 
 	spin_lock_irqsave(&mx3fb->lock, flags);
 
-	enabled = sdc_fb_uninit(mx3_fbi);
+	sdc_fb_uninit(mx3_fbi);
 
 	spin_unlock_irqrestore(&mx3fb->lock, flags);
 
-- 
2.25.1

