Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F8C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Sep 2021 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CF660EE4
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Sep 2021 17:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345058AbhIPRI1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:08:27 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54094
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242598AbhIPRG0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Sep 2021 13:06:26 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D1F5F4025A
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Sep 2021 17:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811903;
        bh=OstzCEYmtVLZNRdG6WO7Mm1Vo0KZNtl5VBM7iApmnEE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=u29hRxq3U0kCUrcNILhXSPpsczBYrBSSoXIAp7t4WKOlzV2tZcpKHv1wVN4N/DsF7
         3+6WIL3nQ8BOf7tRuC6ImlStONuZj9ccFwry0r9Yn4WO9iUYvr4db08gsjPbtzu2Rn
         AgCstq7XnANXiK7raVW/pJKM68Rc6BY4VUUkaWordJJmCoUMGVZAMRJ22tyUP610ZA
         ZopgwO2TXqkMNXvhF5v9JGYdYygZKJfpkuAZH0sFFdTxAi2KDyfTJpQLF4kuOObUXK
         GyFzEagErHGM5OQYbgSIiv0Zy6wFtb/m7wOMS9e/UzdysujyTJl21gawghRglz895M
         L8iuksWN0azXw==
Received: by mail-wr1-f72.google.com with SMTP id v1-20020adfc401000000b0015e11f71e65so2699697wrf.2
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Sep 2021 10:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OstzCEYmtVLZNRdG6WO7Mm1Vo0KZNtl5VBM7iApmnEE=;
        b=GPbK3+bNwclQOCRBUZgTGoOYX0jT97rXiRXUQh8aAvVBAo276wpR3MeImNdMOzqOkE
         JFO6XStLWDEE2bF/GHEe+lJ3ZTnOiQDPeDa+8VSbt4FCx6JfdAyBkdpe97bacf7ZZ299
         YGQGdHp7S4GXYr88Sm+ZIAeD6ahryou2d2ukymZyjLp3IMyYrvBTBipKPyJ+I/47ZHNu
         3TVi8YSa8coDjmFkaJH5lQppQFvwK/D5YDhaSf6Ca2eHZNt7CipHCOyWaagRixverwZI
         FZbfCXRtgDJoeNRNfq1peo8wixTzBH084owKltD46njocg+jJfEoRY8j11oqHKNLow8q
         QVuw==
X-Gm-Message-State: AOAM531v3pvoZdnnezKMvnfm8iGYJNWxYxbI0WuVdITsC/dSA/X8eQAz
        HjEFxu/pqlAcNAvv0sYjsaI5hjuC7uLeWF2xlLk68EldlTiZpdLT2T+5mlUKdFKI7ZfEoISPpa3
        suPnmB7ZGeOlqQEKxKXN35/TOBHruIZFa8VE4zAfF
X-Received: by 2002:adf:e40b:: with SMTP id g11mr7347747wrm.313.1631811903561;
        Thu, 16 Sep 2021 10:05:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4kl/6AH0mpphfd4mDrnsfnhni4/TUU7nT32lFb3Prdb2KZaNGd9Q9JLbukKSrmVp+BXBQqQ==
X-Received: by 2002:adf:e40b:: with SMTP id g11mr7347728wrm.313.1631811903378;
        Thu, 16 Sep 2021 10:05:03 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id h16sm3971694wre.52.2021.09.16.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] video: fbdev: s3c-fb: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:04:59 +0200
Message-Id: <20210916170459.137696-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/video/fbdev/s3c-fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 3b134e1bbc38..1d88dcd3e26b 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1810,4 +1810,3 @@ module_platform_driver(s3c_fb_driver);
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung S3C SoC Framebuffer driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c-fb");
-- 
2.30.2

