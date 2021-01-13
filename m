Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B8C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5432360D
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbhAMOvB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbhAMOu4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:50:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26268C06179F
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so1852431wmg.4
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AGeTlHRvpAdPio9vRmuctbq8OFArXLtHb/g2TDArOrk=;
        b=s5iALxr3dobAkBUTpXGoBoDm/4QIM6hPqOgnFBeyOPMxE44pJLX408VkWwnjf9EKr7
         cV7kywVBFk+BvK0rYKNvHfyqBUdb5WnuXOYKKGcbdNXTqGP8wzzNaWscr3GVpl5L+3e9
         59GwpRAnSZw8YR3uzHvOELb7YNB+MK3VqThmnI/SPsJGojvBSlVXx9pEChrkKe/NOSnL
         ISS27W14Wk79/qU5wLB7QGSr1xGvvu+viv/ZtzaO16hfIiOOc82jkjWv9QBVdfjnSd7c
         DsTks38v32N1wxNwz0nDYPs9DmW7h7iY6aRdoTTFZx6zjR6CxixctRYRVpRPsYNSW6i4
         aExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AGeTlHRvpAdPio9vRmuctbq8OFArXLtHb/g2TDArOrk=;
        b=rl4phzZWGZbydlGpjXBpqJDa1VdVz59Tpe0+jLJxa/R82bpZo38mN4AdXRn1waVijU
         71cJME7yyCQjbqt9BmZLMsU4CuOjehCQl2eb1Je8INgD7x37BmSs1SAfDxn1ZU4ORwl4
         qCBHwAif+g6QbrbJfB4N6PFnj4Zs1k8YQoeNSb9kZV83B6TsbbsK7nbIWkMRuJsW35SG
         6qu8SdSGRx/unGvJ6NJl1mwT1wXIdigl5toi6dFyC63VK0HoOQHGEcDJKVHL4kFJeQn1
         KKHPlgGpF06EYWB/u4JYlQSpqXXf4wH4j7GE0gJu/R6ctbUew4ByzYLnS5ARTmgriJIL
         vHFA==
X-Gm-Message-State: AOAM531DHA/KhLqwGnv0SrUFjGb8IgmOHmxcl3s7LxZSMaQG7jbsa1ad
        lyCZOcPZrYxuDGC77obQTD1EXg==
X-Google-Smtp-Source: ABdhPJyCW0t+4fXJ5f+EqccH4bSmfQRogXuSLR0mXqIvzlFByErtr2znDphOj6bW9fU2Yx0Dp0rX9w==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr2579994wmb.124.1610549414900;
        Wed, 13 Jan 2021 06:50:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        James Simmons <jsimmons@users.sf.net>,
        Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>,
        John Fremlin <vii@users.sourceforge.net>,
        Ani Joshi <ajoshi@unixbox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/31] video: fbdev: core: fbmon: Add missing description for 'specs'
Date:   Wed, 13 Jan 2021 14:49:39 +0000
Message-Id: <20210113145009.1272040-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Also fix a formatting issue

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/core/fbmon.c:617: warning: Function parameter or member 'specs' not described in 'fb_create_modedb'
 drivers/video/fbdev/core/fbmon.c:1103: warning: bad line:

Cc: James Simmons <jsimmons@users.sf.net>
Cc: Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>
Cc: John Fremlin <vii@users.sourceforge.net>
Cc: Ani Joshi <ajoshi@unixbox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/core/fbmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3cf..82f856fe3919f 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: framebuffer montior specifications
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
-- 
2.25.1

