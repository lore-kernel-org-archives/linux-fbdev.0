Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A39C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 11:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A73060FE8
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 11:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhESLEi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 07:04:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242803AbhESLEh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 07:04:37 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljJyu-0001DU-1u
        for linux-fbdev@vger.kernel.org; Wed, 19 May 2021 11:03:16 +0000
Received: by mail-wr1-f71.google.com with SMTP id 22-20020adf82960000b02901115ae2f734so7011353wrc.5
        for <linux-fbdev@vger.kernel.org>; Wed, 19 May 2021 04:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwXLnF7rWDVcwlt7Q5T7XhtjUkElmGn6H/9Zlr+sBJo=;
        b=dvZK3GpPZd6mKnPHEut0Nh24AyZtfvlRZyVRoma5XSMe7rr6sfpvM+g78jegM0Hd9T
         ih9tyIpy4ZzuzIGSJvUoHjo5lDNw/feb8rYXhoPypVIrepuBW/74WcUYsEtCs9EEKT9s
         jYjJG1MklxSOQBwaLl2YlxAC316SeGuUhWQHwvhq+VL4OJ3VuW4vcC6NnKUgC9ib75ws
         doAL0R0i7bVmxfGRT7D4ccOvKLlsCkTZy34ClSk8pA8Sg6uNq9HmqADkVJIsIcMDDfid
         TeLrVRUvQt7X9Dzq52ZqbRcpp8l3vodxtXFLK2bSMmkmyuxKKxqQ6+U5fh7ZoymZvKCa
         nbCw==
X-Gm-Message-State: AOAM532HESLGSPK/Oi5DmGMwy7P6apX4l3xrNUqyWxSwh+BTkS85y8ix
        SvvdCq2f12U4Yb1pxC50vv/HsB7lmRiL4QQEOVToG8egYrKP2d0vE0UfJFmjbCJA7mLkZqa5VUX
        pKmLWO7KNGkqZmmNpHQUolOeLUnVPA/gg+FX9V/JO
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr13878363wrx.82.1621422195805;
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6tC845fEuilnb4EmT7sQDtVzUIm15hK+X9ZytOkjmm3/ZcdO7CqysCBMbe2jUpyaFX/npoQ==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr13878336wrx.82.1621422195616;
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id r5sm23682357wmh.23.2021.05.19.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:03:15 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2] backlight: Kconfig whitespace and indentation cleanups
Date:   Wed, 19 May 2021 13:03:00 +0200
Message-Id: <20210519110300.17918-1-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517095839.81833-1-juergh@canonical.com>
References: <20210517095839.81833-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove leading whitespaces, replace multi spaces with tabs, and fix help
text indentation.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 drivers/video/backlight/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index d83c87b902c1..c887338de386 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -128,12 +128,12 @@ config LCD_HX8357
 	  If you have a HX-8357 LCD panel, say Y to enable its LCD control
 	  driver.
 
-  config LCD_OTM3225A
-  	tristate "ORISE Technology OTM3225A support"
-  	depends on SPI
-  	help
-  	  If you have a panel based on the OTM3225A controller
-  	  chip then say y to include a driver for it.
+config LCD_OTM3225A
+	tristate "ORISE Technology OTM3225A support"
+	depends on SPI
+	help
+	  If you have a panel based on the OTM3225A controller
+	  chip then say y to include a driver for it.
 
 endif # LCD_CLASS_DEVICE
 
@@ -269,11 +269,11 @@ config BACKLIGHT_MAX8925
 	  WLED output, say Y here to enable this driver.
 
 config BACKLIGHT_APPLE
-       tristate "Apple Backlight Driver"
-       depends on X86 && ACPI
-       help
-	 If you have an Intel-based Apple say Y to enable a driver for its
-	 backlight.
+	tristate "Apple Backlight Driver"
+	depends on X86 && ACPI
+	help
+	  If you have an Intel-based Apple say Y to enable a driver for its
+	  backlight.
 
 config BACKLIGHT_TOSA
 	tristate "Sharp SL-6000 Backlight Driver"
-- 
2.27.0

