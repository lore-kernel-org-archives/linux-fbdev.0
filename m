Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A429C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Apr 2022 07:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiDTHJ3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHJ3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Apr 2022 03:09:29 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29850255A6
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 00:06:44 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id bf11so820970ljb.7
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Apr 2022 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6Pm6EQrJOZ/4EtJZXl52Z94IGgkZJJYDyI9ZFEJiOI=;
        b=aAcEjQWF0TAoCEXgBar5MuPFQ/YhqGLMjfZBrdip0U5FzeAFDKsuy+YpWOXvCSo4Cu
         d2RevKENklHTnW/xtjpv8VYGsZbZOHYLY6ZpLCOUwoc4wYQ+aPPwnDFesjx2DANGBrU8
         iY/IM6S0fHecKah9bK/nufixsKpBoYZR3mAr9lU5JwgamGzxfwuTkUJXIe2A3f3jS/oK
         C1iHraDKyLz3SNfs1vxzp8GUJP32phUs7Fb6iKz1ANha432H7Ya2mnrk7KW0FLrni+D3
         MpNc2SikA0eJqgC6hSpGInBOTf1DbSwx1ZoiGkZ3I/XWbCCQD7op2WNKl4j9mTrk3rEe
         AvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S6Pm6EQrJOZ/4EtJZXl52Z94IGgkZJJYDyI9ZFEJiOI=;
        b=A6zwf97sw5An/4tLn4e5TvgPQiRRvFz6X2ve2Cmkre1NYg19feEUd8bXmzpz6jCPT9
         IFLnO5aCQq3nlAbJZJCUJ14fmxJX3xGlb2tpFigbWNrIXYxryTpa64HLmzYJGzFNCktC
         MdFFFJdU7ZU3JxuWy7SnVVIWW5d/CdxXIg8ddeYW33PFge89z1iGTEzDoChmKoxvxftg
         3m71Pn00qZk2oIp5YF3vHopJb7JFKFZtun1mA1EeVjoe9AwSPj+PXx0+J2FcBqIRUrmq
         9nuwqGQqJyOCi4xpc928n6pSMZk8xZ2qEeLGM2AYEBwNj/Exa6bLWM+UyjmreDVt1jMa
         18DA==
X-Gm-Message-State: AOAM533OJG9dDCcu4b+QrZFyPvfS3+ZjZOW8IPXj87T4ceYYHqAvTLnn
        tPFL1WRfyRfl3EyWKVU7UeyX8JzPwjO9IL4E
X-Google-Smtp-Source: ABdhPJxxrz61XJwjbTtEFvxXTZA6X+h3fWbjr+H8xjkcYpoXbV+qfS7teIWXYa4d7icAIz9JoQdZ3w==
X-Received: by 2002:a2e:3e17:0:b0:24e:9b47:f1c4 with SMTP id l23-20020a2e3e17000000b0024e9b47f1c4mr453071lja.445.1650438402154;
        Wed, 20 Apr 2022 00:06:42 -0700 (PDT)
Received: from shc.milas.spb.ru ([188.243.217.78])
        by smtp.gmail.com with ESMTPSA id l18-20020a2e7012000000b0024b50132eeasm1630224ljc.10.2022.04.20.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:06:41 -0700 (PDT)
From:   Alexander Shiyan <eagle.alexander923@gmail.com>
To:     linux-fbdev@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] video: clps711x-fb: Use syscon_regmap_lookup_by_phandle
Date:   Wed, 20 Apr 2022 10:06:39 +0300
Message-Id: <20220420070639.62440-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Since version 5.13, the standard syscon bindings have been added
to all clps711x DT nodes, so we can now use the more general
syscon_regmap_lookup_by_phandle function to get the syscon pointer.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/video/fbdev/clps711x-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index c5d15c6db287..771ce1f76951 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -268,8 +268,7 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 		goto out_fb_release;
 	}
 
-	cfb->syscon =
-		syscon_regmap_lookup_by_compatible("cirrus,ep7209-syscon1");
+	cfb->syscon = syscon_regmap_lookup_by_phandle(np, "syscon");
 	if (IS_ERR(cfb->syscon)) {
 		ret = PTR_ERR(cfb->syscon);
 		goto out_fb_release;
-- 
2.32.0

