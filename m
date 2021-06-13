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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C61C48BDF
	for <linux-fbdev@archiver.kernel.org>; Sun, 13 Jun 2021 23:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2F4161159
	for <linux-fbdev@archiver.kernel.org>; Sun, 13 Jun 2021 23:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhFMXeZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:34:25 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:54259 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbhFMXeZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 13 Jun 2021 19:34:25 -0400
Received: by mail-wm1-f51.google.com with SMTP id b205so6337186wmb.3;
        Sun, 13 Jun 2021 16:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwXW92AMV2Zj//j5lOIkr635SG8SKf3W/g8yx73Deyw=;
        b=DUroW1l97aA1bQpXB1gL/Mva4UMt3HN8cVre8KVO/G992+d6by8qKBsM83pW6Q107Y
         hs8iSCaoamecyCYycUEnWrL/eyxV4bNO+BE1ySyXaKbgLjqjS4jiVLbJ56Xcsv9GSNHP
         VOTygISZ/LJ4CnrgejEQx2gjuFyVzMBr7Zl0QhsQErcjbFmyLaLrv3DWnIqakCI5yNob
         IYB4F5XlvobD/KVRSwPxJjwd9JFeV3SzQODCwbysgNtWvC8qS3BO1lL9i8SrpY/Qnq8g
         XnLn+6bq1aNwZcfcY+uVBU9DcvepLFJZ729Tl/HB5LRLV5R1XBGgxJp5UXph2dwV6Wge
         L3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwXW92AMV2Zj//j5lOIkr635SG8SKf3W/g8yx73Deyw=;
        b=gvlDWQlOUFleoEKkmMkMUplon/FudvE9tbn0Yt7H7RK5UAl7DI+DpnrvIESei+hBZs
         fUCRHV/ppqY0q1CnGmB36OLNJFBvlBjq7JHy4BHuRlqydBFc7qslM7vce1k5EWGpFn9h
         kUxX0qYCZcGe4FT9ea4Wh5ph4WNWPTo7tnCnf20QCqYFieT/J+luGudXAGCXsyXRSxp+
         hqpLQeVI/XreRBjyUJdB52tHdYv2apeuqRk53mCE1l9FyI+DNMd+E6SsX5zOYIes5e9D
         u03YjC+Jmxn8MDnJT7gNHtHwPXhtG174jw2cJG2YBpKXgnLyQf+YS8peTejAl0XAN90l
         shTg==
X-Gm-Message-State: AOAM533Uw0imReAc9pWZSaNzxYzKhPf4osZhhQztBbSMBskRpnW+tqJ8
        ry6e49Z63FV8dsVcC5lom70=
X-Google-Smtp-Source: ABdhPJzLxMVGfF57HHlMph/YXajIfLnISEATl7O2cTyaAnm2qogppDHsEpF3EIVNuiYET/ha1sCf9Q==
X-Received: by 2002:a05:600c:3786:: with SMTP id o6mr13460279wmr.170.1623627083066;
        Sun, 13 Jun 2021 16:31:23 -0700 (PDT)
Received: from localhost.localdomain ([195.245.23.224])
        by smtp.gmail.com with ESMTPSA id i9sm17882511wrn.54.2021.06.13.16.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 16:31:22 -0700 (PDT)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        linux-fbdev@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] video: ep93xx: Prepare clock before using it
Date:   Mon, 14 Jun 2021 01:30:38 +0200
Message-Id: <20210613233041.128961-5-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
References: <20210613233041.128961-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
to Common Clock Framework.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/video/fbdev/ep93xx-fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index ba33b4dce0df..2398b3d48fed 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -548,7 +548,7 @@ static int ep93xxfb_probe(struct platform_device *pdev)
 	}
 
 	ep93xxfb_set_par(info);
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	err = register_framebuffer(info);
 	if (err)
@@ -577,7 +577,7 @@ static int ep93xxfb_remove(struct platform_device *pdev)
 	struct ep93xx_fbi *fbi = info->par;
 
 	unregister_framebuffer(info);
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 	ep93xxfb_dealloc_videomem(info);
 	fb_dealloc_cmap(&info->cmap);
 
-- 
2.32.0

