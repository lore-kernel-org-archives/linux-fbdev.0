Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2EC43381
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C56A23600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAMOwE (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbhAMOwD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F6C061346
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d13so2384811wrc.13
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdRuSJvii4mKY/Efrp+W2ecV3k/kYMixGrJ5X2aYPPE=;
        b=h7CCOaMRu/KwDp4FkMru0iAXzhcqDT8Zgx3TFkmqeQ+lFmQabkd31QQ+lufeDRUy3X
         LtVPTgu8/Zqp1FSR8BAvO7dZtJzfFJCxlVtW1Nocwnb68P37FSE+be5cVVaNK5Tt8JCU
         9w0Ph8RfNh92LMTOPQay3rdqNK2k+J9YHe1s4Pc7Cfwul+RTcoi4Ud5EHifbnQv/CgAl
         HXLZdEt7o50147fxcADWLOPX90H4PF4f7epdHBvT72f7b/PpYAha9w6yexNN/IIcz2uN
         fnQb+ZapvvgV5yFNpXtWjyjgqG+ixxGtM9qn4DjB5lbBlmDCcef1Kbvt5M9KefOQMbJJ
         FfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdRuSJvii4mKY/Efrp+W2ecV3k/kYMixGrJ5X2aYPPE=;
        b=iULB/bH9bezFpMhZJmQHjbAJn887M5GfW+iYDKzEzI5jkTjVJWg7KZL9s1G8Z5yZO8
         Zlyu6WjtHge3tD6r8bFMQwzz+/vqbw+PSlwCVdswhKltX1zgr2RoWzacsqzHOIuIundb
         VTtKoYi8WoXhB5Vm9zArZcwAv1bght96RvFYyE8iJW50zALR94CuUCeT48bEl56AavZF
         hZzsOa5FhNGUEIQwutZPFBPJDMOkWQDanO/sg27MibmgdmP8hupDgYBAgyYe+I7eWKvY
         p2qHSwIPqDkPqhjH4e8WZXL/cAAM4ihkAZ5pv2RBqTuzGj2lV69SGPqNvfex7uGHLDJz
         YRuw==
X-Gm-Message-State: AOAM5312tHNcJjHRK6Ppo/UdLFts0e8kWnhPKXj8wcFXLFNQY6mNOE7N
        W5726+/OhFrP/ruqO8J4tbnPeg==
X-Google-Smtp-Source: ABdhPJyuIlFTIENDUMPlw5lomJPJtWMdNwJG+DPzaqlFIAPWPUczY5LQd4LCs7FSNVgCvZWujNH+Hw==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr2937092wrw.379.1610549444578;
        Wed, 13 Jan 2021 06:50:44 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        James Simmons <jsimmons@infradead.org>,
        Paul Mundt <lethal@chaoticdreams.org>, Urs Ganse <ursg@uni.de>,
        Helge Deller <deller@gmx.de>, Alan Cox <alan@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 21/31] video: fbdev: sstfb: Mark 3 debug variables as __maybe_unused
Date:   Wed, 13 Jan 2021 14:49:59 +0000
Message-Id: <20210113145009.1272040-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

These are only used if SST_DEBUG_FUNC is set.

Declare them under the same clause as their use.

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sstfb.c: In function ‘sst_detect_ics’:
 drivers/video/fbdev/sstfb.c:934:26: warning: variable ‘n_clk1_b’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sstfb.c:934:16: warning: variable ‘n_clk0_7’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sstfb.c:934:6: warning: variable ‘n_clk0_1’ set but not used [-Wunused-but-set-variable]

Cc: Alex Dewar <alex.dewar90@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ghozlane Toumi <gtoumi@laposte.net>
Cc: James Simmons <jsimmons@infradead.org>
Cc: Paul Mundt <lethal@chaoticdreams.org>
Cc: Urs Ganse <ursg@uni.de>
Cc: Helge Deller <deller@gmx.de>
Cc: Alan Cox <alan@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index c05cdabeb11c2..b8813a0b63b1d 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -931,7 +931,7 @@ static int sst_detect_ics(struct fb_info *info)
 {
 	struct sstfb_par *par = info->par;
 	int m_clk0_1, m_clk0_7, m_clk1_b;
-	int n_clk0_1, n_clk0_7, n_clk1_b;
+	int __maybe_unused n_clk0_1, __maybe_unused n_clk0_7, __maybe_unused n_clk1_b;
 	int i;
 
 	for (i = 0; i<5; i++ ) {
-- 
2.25.1

