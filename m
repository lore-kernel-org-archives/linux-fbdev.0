Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB720C4332E
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48BB23602
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhAMOxH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbhAMOwN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2396C061358
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:51 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e25so1865359wme.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiTAiO1+djM4LYXjGKueW16bvgv2sBtNiLbtIOEARdk=;
        b=IDza5YLilamkwPDT+g2/a0lofmuncKNpAv/y/6ZQX7PTgZHHrzIscPArIaLwzgGk21
         +PTQkWm+NELC+KC9BFDcWCwiEBGUoc7D99iVhf/b8Zau/fF4+imDj62ocQwZfhj48s7p
         G301bdVxqdgcGdeZ0mOu5lmhiQU2WC/WPRGqNZpFfUOiJAjYflnQOI3iCRme45LwRAT5
         UA87z3v5OeC740plgM+jScryysn9swGK41grynXPhZPBHzL1uyI195awHeRx0r0D+KV6
         M3YDyk1IDQxUtVgKliH+QZdMV6naG94aZh3W2EpFGPxDHMNQ6+AhIUIbY31cyP7lq5uP
         Fxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiTAiO1+djM4LYXjGKueW16bvgv2sBtNiLbtIOEARdk=;
        b=uodIqTmS7Vk3X7hvx6+Ec6XFN11Y7N0XEEcb9WLJ9Me489jK6b5R6KlnAFVAlzM/3U
         IKba0XM+fjEQEh/8Uy/uUj0ll2w3wa4UbwmMGtOshqZr32ZzCogxKesMuGHCmMukCwNv
         6h68/3voGEsWQwnpLu56Jdq3YdMgpmbZNi48e3B3hdpJvwPnTXlrrReCj99ZOoxszPPw
         ZdEfB18JoFpgIWEbFly2uB0K31JK2I/yG2zMI68ooiiGKss9Mu39j6TXBiBldy3A8GLX
         FVzLfm3L0QtBKGWqCgcsNBwPHTE9l9xaXIoeJaMjIY5EmMYnaYtNQ7TbOYnAuEZ13rJB
         1xXw==
X-Gm-Message-State: AOAM531MmRcg7qociE34S579NO1w7sDXTnn7LcnGVFODsK1nVQC5KUVa
        uvPanPyMDYGEiIiZdQDYYifW2g==
X-Google-Smtp-Source: ABdhPJzn0hsHSArPV+PdoU3MwAI+uaM7MfxzC+Q9pFqpa5/9nfQ0iIqmvEqP+hOl9RxA7AZoMzJjNw==
X-Received: by 2002:a1c:988f:: with SMTP id a137mr2554157wme.130.1610549450459;
        Wed, 13 Jan 2021 06:50:50 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Jeff Garzik <jgarzik@pobox.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/31] video: fbdev: riva: riva_hw: Remove set but unused variables 'vus_p' and 'vus_n'
Date:   Wed, 13 Jan 2021 14:50:04 +0000
Message-Id: <20210113145009.1272040-27-lee.jones@linaro.org>
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

 drivers/video/fbdev/riva/riva_hw.c: In function ‘nv10CalcArbitration’:
 drivers/video/fbdev/riva/riva_hw.c:845:23: warning: variable ‘vus_p’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:845:16: warning: variable ‘vus_n’ set but not used [-Wunused-but-set-variable]

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/riva/riva_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 4ee63f7d84d3e..2bc510c24aa9e 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -842,7 +842,7 @@ static void nv10CalcArbitration
     int found, mclk_extra, mclk_loop, cbs, m1;
     int mclk_freq, pclk_freq, nvclk_freq, mp_enable;
     int us_m, us_m_min, us_n, us_p, crtc_drain_rate;
-    int vus_m, vus_n, vus_p;
+    int vus_m;
     int vpm_us, us_video, cpm_us, us_crt,clwm;
     int clwm_rnd_down;
     int m2us, us_pipe_min, p1clk, p2;
@@ -924,8 +924,6 @@ static void nv10CalcArbitration
       us_pipe_min = us_m_min + us_n + us_p;
 
       vus_m = mclk_loop *1000*1000 / mclk_freq; /* Mclk latency in us */
-      vus_n = (4)*1000*1000 / nvclk_freq;/* nvclk latency in us */
-      vus_p = 0*1000*1000 / pclk_freq;/* pclk latency in us */
 
       if(video_enable) {
         crtc_drain_rate = pclk_freq * bpp/8; /* MB/s */
-- 
2.25.1

