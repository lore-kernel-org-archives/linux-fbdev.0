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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B87C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65546124C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbhDGGgh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348883AbhDGGgf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1FEC06174A;
        Tue,  6 Apr 2021 23:36:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t24so5174124pjw.4;
        Tue, 06 Apr 2021 23:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ruk0ECVgk5cWHRPO3cAAhvgkfpUeZxerRvgvguMhn0o=;
        b=cCxkJ6PcgHqucOCgBqwJzcXMho+kt6wxoC9luQC65j75k28zZis00M0SDW3j2Y4AVa
         5VsMoxxNOrJjg5dj/E7aa/dO1MxwWX2K5GDUm1NErwkCGTRleULp/7KSpky/XhXZeVJw
         Wcyj9etukxGB50xyMBmT2ccHj5lTgRhuZKk5NeoTPbXC0InqfWPEFQci63q6cZeEDdg+
         4vZUuTfdeBc48mAbTscdQIbfIOHuUlBw1tORYtZaM3iUXEuj+ZVxsb41PbzbGmxgR4Fr
         +pm/4yD7Ka8bwklFfKxAzHbO1TjDxsYMpikH1lRAHJHK8t+HWZEgUNYiXS84Xr8TLvlM
         EAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ruk0ECVgk5cWHRPO3cAAhvgkfpUeZxerRvgvguMhn0o=;
        b=okGw7LAHLRVNAA1xkLHiiomnjyoAvtqsISpUEfVoW9bs1cShv/O2FaNvP5o3bADkL8
         oWYFQ4WckwlV79BVEt5isPtM0z9kiRLv++mADBWol0EHFlzrSmvOxkIKp4VR7LeHl892
         7Uo+gkiaiTMWWOP5tipJLAVQyoT6QKHruJD1Sn8SzuZA/Ass0qR3OJQILh61CfvhNKxf
         wwgCCxLOrYCGWD2P0TwrxMhppZ7hHchIQBKSn7jWu8ZTFsStHSYqyBva5eaPmXL6WsNf
         kzk66RtXzh2stebswen48B/loSj+Jlf/erfyCluOlehHmj0tzQ+nLC9Y5MlQZmDHkb5T
         L1aA==
X-Gm-Message-State: AOAM531FFgP1I6a3V3NZwvromNGFxudedi0RAG1VhL/XUKngdMHGTLdn
        2kKPDrscYG+yQG38UIHwcGWtRu7oo3I3TQ==
X-Google-Smtp-Source: ABdhPJyN79crnDz/EANR+ilOos5UHzuBrR29ClVpgHmPReRVWTDoisYajjjTpvhOzOjwA4j+Xc4I3A==
X-Received: by 2002:a17:90a:3ee3:: with SMTP id k90mr417024pjc.147.1617777385644;
        Tue, 06 Apr 2021 23:36:25 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id w16sm784249pfn.200.2021.04.06.23.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:25 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:23 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/49] staging: sm750fb: Rename ddk750_setModeTiming to
 ddk750_set_mode_timing
Message-ID: <2b1d5ae43f2f5556dfc787d15b27d0db99354c85.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the function
ddk750_setModeTiming.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 drivers/staging/sm750fb/ddk750_mode.h | 2 +-
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 5c685b4e2fd6..2548695829ec 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -207,7 +207,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 	return ret;
 }
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock)
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock)
 {
 	struct pll_value pll;
 
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 2df78a0937b2..1b70885f85e5 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -33,5 +33,5 @@ struct mode_parameter {
 	enum spolarity clock_phase_polarity;
 };
 
-int ddk750_setModeTiming(struct mode_parameter *parm, enum clock_type clock);
+int ddk750_set_mode_timing(struct mode_parameter *parm, enum clock_type clock);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 7136d751cff5..e31f4c6bc69e 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -305,7 +305,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 		clock = SECONDARY_PLL;
 
 	pr_debug("Request pixel clock = %lu\n", modparm.pixel_clock);
-	ret = ddk750_setModeTiming(&modparm, clock);
+	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
 		pr_err("Set mode timing failed\n");
 		goto exit;
-- 
2.30.2

