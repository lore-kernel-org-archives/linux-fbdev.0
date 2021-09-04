Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32266C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DB561056
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Sep 2021 14:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhIDOXk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhIDOXj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 4 Sep 2021 10:23:39 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1074EC061575;
        Sat,  4 Sep 2021 07:22:38 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c6so1467863pjv.1;
        Sat, 04 Sep 2021 07:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/ua5yKYj8pkGfG7UiRoEoOwUToJwyNwNf/Tj0HDH/8=;
        b=C4MogmaLoR1H0yFxuV3YjeKt2Gn8IhnzECUoCNze0ifHO5rWWfLQcwal4MlbBH2NeK
         CQoYwvGs9MzxbPdD2fqsieTa5MufMQkp8dspcURqbAYR3ts8CTCge0mYfWSpWgUjkpnT
         bcXtE8LxLF8mYQM54Ki7Vy8bpFlodSyvYp6H4kpdEFI/GnmeH2nggGEtDAa0oyiVn3Tr
         apIyNXbMHdp4jNx977PIew28dnAX2UzCEfTIwgVFJIRxz35VG/aBvp11UpqCz+HtXP8g
         MDLQnUGwgcM/S9bN5KKuSFqet9kI9MonwlQzoyGG77hRY86CvIApEBafGI6RnTQuZzJS
         QOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I/ua5yKYj8pkGfG7UiRoEoOwUToJwyNwNf/Tj0HDH/8=;
        b=kzh09KYvyEjtRGvQv20H2QKqtsF2XRsyhS139uS8fUvH7JCTH1g96QlxFx93Gwa5V5
         ao2AnJraLI/82j4wX4Hgrrm6byGb2b+L86voBlzJwXF+Fekfc/N9Uncj63ZK6gLwSghV
         LBbF1YlPErhvHRLqlXqEAJAOwKmne6LQcLhvaJ8bYot3FTx/dCa4ADkFn6qiJgVLRhHk
         /0xtIR1u2EOskFPwZy2aFwvzeTvlY+ZhHsnrfWat8UO7Xk2O9fjtxupJHm3ZBxkdYxe+
         3A7O9E/1aD2KOjD9Bf119AWCZOu/9sQozxAIQYsCTtOW+PB+qPTbVg9+xt7BdkAJYzlE
         w5Fw==
X-Gm-Message-State: AOAM530FXRe4BymeF8ife90itdc794BfMruqR6yGN5fXacr5qbmREV4z
        WBYqVG/LxBs9ieHnTqnKRVY=
X-Google-Smtp-Source: ABdhPJxHf0ESh8pM4uIdjpjTkv4UmTjQPB9lqc7ZtM9W5E04SiwO6QKFx09EGvsPGa91UHcnSDnSow==
X-Received: by 2002:a17:90a:6b4d:: with SMTP id x13mr4446016pjl.88.1630765355470;
        Sat, 04 Sep 2021 07:22:35 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c26:4b2d:32ce:9155:7c42:8667])
        by smtp.gmail.com with ESMTPSA id m11sm2480391pjn.2.2021.09.04.07.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 07:22:34 -0700 (PDT)
From:   Srivathsa Dara <srivathsa729.8@gmail.com>
To:     bernie@plugable.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Srivathsa Dara <srivathsa729.8@gmail.com>
Subject: [PATCH] video: fbdev: udlfb: Fix brace coding style error
Date:   Sat,  4 Sep 2021 19:52:26 +0530
Message-Id: <20210904142226.23646-1-srivathsa729.8@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix brace coding-style error for function defination

Signed-off-by: Srivathsa Dara <srivathsa729.8@gmail.com>
drivers/video/fbdev/udlfb.c:82
---
 drivers/video/fbdev/udlfb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index b9cdd02c1000..25643265947f 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1457,7 +1457,8 @@ static ssize_t metrics_cpu_kcycles_used_show(struct device *fbdev,
 static ssize_t edid_show(
 			struct file *filp,
 			struct kobject *kobj, struct bin_attribute *a,
-			 char *buf, loff_t off, size_t count) {
+			 char *buf, loff_t off, size_t count)
+{
 	struct device *fbdev = kobj_to_dev(kobj);
 	struct fb_info *fb_info = dev_get_drvdata(fbdev);
 	struct dlfb_data *dlfb = fb_info->par;
-- 
2.25.1

