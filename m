Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC1C43460
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEAE61029
	for <linux-fbdev@archiver.kernel.org>; Mon, 17 May 2021 09:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhEQKAd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 May 2021 06:00:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236308AbhEQJ77 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 May 2021 05:59:59 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1lia1K-0002TK-6S
        for linux-fbdev@vger.kernel.org; Mon, 17 May 2021 09:58:42 +0000
Received: by mail-ed1-f72.google.com with SMTP id p8-20020aa7c8880000b029038ce714c8d6so3590932eds.10
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 02:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2mpH5FVMrjvjH8WEdGmN2JnMyMXBzqsrskS5jwEFjyI=;
        b=dQPTgLsLi9ZFzO6z7YIjcMDHH27DPwW1G9QZxGzsiXAccUEjohn065L3hsv+oWqq5W
         XV86pEjH5pcL2sFTpezY4qDL0Abn4UXG6vyb56sAIqG2rnQFXnQVwvD4zbdzODGzxBlb
         zUuWi+desc7/EIJARCHSj9fwUAr52VGbnd9rgARKeIpzxfkynycsmNQFHuE2guVC4u0b
         KkMY+HMLnEyshGDpqcILNA6OKsH+G6OIR/LFZSVxlWgQNcKjGmsYTgumAOPePESZN90G
         mW1zGYlnDzCqwZKQBhATGKyCilMDdqczwnz1tNMkzneYpLmhJucPLqbz93iaHBcQs2qM
         lezw==
X-Gm-Message-State: AOAM531MoKjy6YLzAERtc9EmlQBC/xmDrm+LluinlUUTy2886YNul+QX
        nIQKd/LPg5VImyqrSd/A3IXG6Bw2JR3zUBa01EQX6HrtaNahBafBNyzwAmeb6anhB9RvhINo95o
        eLjMcg4NwyRXsLI6N+ru09OcPIKfl28adWqLkrwg+
X-Received: by 2002:a17:906:8478:: with SMTP id hx24mr4112960ejc.490.1621245521964;
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFRG/l/G2rg1zX50CxuoToOo+lAsM6sV5pKwmdKQGRrZLr8YNgrn4AfOtYJKORD+xj1Qs8MA==
X-Received: by 2002:a17:906:8478:: with SMTP id hx24mr4112949ejc.490.1621245521826;
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id i20sm4883813edr.94.2021.05.17.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:58:41 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, juergh@canonical.com
Subject: [PATCH] backlight: Remove leading spaces in Kconfig
Date:   Mon, 17 May 2021 11:58:39 +0200
Message-Id: <20210517095839.81833-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove leading spaces before tabs in Kconfig file(s) by running the
following command:

  $ find drivers/video/backlight -name 'Kconfig*' | \
    xargs sed -r -i 's/^[ ]+\t/\t/'

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/video/backlight/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d83c87b902c1..a967974f6cd6 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -129,11 +129,11 @@ config LCD_HX8357
 	  driver.
 
   config LCD_OTM3225A
-  	tristate "ORISE Technology OTM3225A support"
-  	depends on SPI
-  	help
-  	  If you have a panel based on the OTM3225A controller
-  	  chip then say y to include a driver for it.
+	tristate "ORISE Technology OTM3225A support"
+	depends on SPI
+	help
+	  If you have a panel based on the OTM3225A controller
+	  chip then say y to include a driver for it.
 
 endif # LCD_CLASS_DEVICE
 
-- 
2.27.0

