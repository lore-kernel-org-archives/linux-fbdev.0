Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A242C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F940235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbhAMOwp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbhAMOwY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B795C061795
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m4so2391130wrx.9
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kBvB4NkQBZ34V2o1ex42K5vSl0rdRhcvGCTff/v+VQ=;
        b=CX3P+S9L4wGYuGSks00quxfFpZEPOVPivW0r/M9EjGfhtOTkdgaF5aDbimCQt5ON7+
         ArYJ0aOzuZ3UQN/A8k7aMly33N16m2n25UqGKwjTU66wrXGcVp4c5o146iISuqMXolOE
         WHoahwD7dLOGZnK8I/aajIntcVornbKvK8GVcqxWXPCDEJzONy6QEKkTDIVeQ8br91/B
         RLFAOAbBTU2oZTL9ZOn/+bu+v4ss+ptf8QatATZZ/Qx5NWvYLhjlLcrxcQuf9r+tNcWM
         SmKKOt26cZHRlMc5SPNWHLCaCXTz35T5oJO8GK2T9EC+lLSv5P25KG/huKlSGIoTohQG
         tmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kBvB4NkQBZ34V2o1ex42K5vSl0rdRhcvGCTff/v+VQ=;
        b=XEnzOmr2I+ZWMKezdPzP1u1yEa2igOHtWkjvalRBlTaeESDjkMPDjc/DK3CSwvdNc8
         2mR8pscnT9SFrK04V+R1yGG+nxAXm29rpcHK1qpIg42hsSieqUkAu8yJOXslqIefvUV/
         l+0FcoEKQt194Xx+EIbq0vw3HSbwLT9eSCsksxkXDh/JYbdB+6D+1rVWgRq0BGGO4g+a
         QuuW+BL3Ut5C05XByPJopZEKecnul7oykbWHJIi0RLjt+QITbRIcbHH3ptN+SnkeqVIT
         DjCuh27UPPL/5wtFV+3P5AtCAYodDEzzdDqUoT2NLZJ/4ybi+JCVXyBmPX5b9qxNJbbF
         PTxQ==
X-Gm-Message-State: AOAM532QI1jIXArSF8TmTeh1+2snVCV0GxE3JIKWjJLIFHzGSAdIjUy/
        WXOGhsXnA1+1JtpqqWOolDQIVA==
X-Google-Smtp-Source: ABdhPJw1ufVOnrS2JPmqkNrZy8h6u74DEt1BTq/yWKFBkHEkejsbQDOSJfyqheFLrclUErFWt5afkg==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr3189875wro.244.1610549455814;
        Wed, 13 Jan 2021 06:50:55 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:55 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Ben Dooks <ben@simtec.co.uk>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/31] video: fbdev: s3c-fb: Remove unused variable 'var' from 's3c_fb_probe_win()'
Date:   Wed, 13 Jan 2021 14:50:08 +0000
Message-Id: <20210113145009.1272040-31-lee.jones@linaro.org>
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

 drivers/video/fbdev/s3c-fb.c: In function ‘s3c_fb_probe_win’:
 drivers/video/fbdev/s3c-fb.c:1176:28: warning: variable ‘var’ set but not used [-Wunused-but-set-variable]

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s3c-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index d33d7df77a6a5..91daeca5ca392 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1173,7 +1173,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 			    struct s3c_fb_win_variant *variant,
 			    struct s3c_fb_win **res)
 {
-	struct fb_var_screeninfo *var;
 	struct fb_videomode initmode;
 	struct s3c_fb_pd_win *windata;
 	struct s3c_fb_win *win;
@@ -1201,7 +1200,6 @@ static int s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 
 	win = fbinfo->par;
 	*res = win;
-	var = &fbinfo->var;
 	win->variant = *variant;
 	win->fbinfo = fbinfo;
 	win->parent = sfb;
-- 
2.25.1

