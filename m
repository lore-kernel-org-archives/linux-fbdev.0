Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77407C04A68
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jul 2022 07:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiG0HgX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jul 2022 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiG0HgX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jul 2022 03:36:23 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D921275
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 00:36:22 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id g1so12711086qki.7
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jul 2022 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO4phdManN60SPf1W9WiyPdt9raYFpN1OI/PcK1NnQ0=;
        b=uf7lDkpVYO56NWMPL08t3bV7ykOUYmDaRNEf57tqkkhLMFpNUwzcla0Lokoe8tkjv6
         GY7TYiWRZHqk7bMBMb76LrdFBYz0PHG29omXVyfilS5Kj7k2Y34QjUeFMx9v5Rx6hD86
         OatRJqn2LPFVr9JyH10I7+SY5t911D/Yjk6Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO4phdManN60SPf1W9WiyPdt9raYFpN1OI/PcK1NnQ0=;
        b=qPcd7t41gOCR6yw7WgCw6FgwqHccQnf9ZypvvYYcsMJpP2AA+q/nJ56t6oMfdtw2a3
         7BXiy87ol939C0/lL1xZw4NK5Xj7p9HzPaDpHAZvYUy2RKc9DxjkYOTAJmJgCTp4f7ss
         jsw/l+j9TlpNG1I+FzWQIO5MrqXiTRxN+vjrqKnYpVot7GLG6O8eqEVcBaK7oiXPqGnS
         Se4H80euEyyVd7HtX2IGK89/LqzODm//yddCD+wQGzmR1jAFbChbLW8rEwqhX380zOHM
         ln8ryv6iTslykShHHWo9SQb7JNtx3rH++nA2/KKgOLF+Q9tz9qbXs5mzSabD1TBGaRvX
         iClA==
X-Gm-Message-State: AJIora9VDP6kQjXXnMI8XWJZl16NyphsqLFMKbw/99egVFlSDo90gY6J
        3cg8lQ7VhBLvDCCoBidc9LpsWw==
X-Google-Smtp-Source: AGRyM1tTVXmc9JrwYNXN2698PGpq5P5gj2i9zaPSZqNDeI8sJMebG7pGAmT8yx65QQjJq/P/t8m5dQ==
X-Received: by 2002:a05:620a:2552:b0:6b4:8dbf:8992 with SMTP id s18-20020a05620a255200b006b48dbf8992mr15785127qko.109.1658907381478;
        Wed, 27 Jul 2022 00:36:21 -0700 (PDT)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id x22-20020ac86b56000000b0031f4007dd92sm2709526qts.89.2022.07.27.00.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 00:36:21 -0700 (PDT)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     chuansheng.liu@intel.com, dan.carpenter@oracle.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: fbtft: core: set smem_len before fb_deferred_io_init call
Date:   Wed, 27 Jul 2022 09:35:50 +0200
Message-Id: <20220727073550.1491126-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YuDlfLeossnntH/C@kroah.com>
References: <YuDlfLeossnntH/C@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The fbtft_framebuffer_alloc() calls fb_deferred_io_init() before
initializing info->fix.smem_len.  It is set to zero by the
framebuffer_alloc() function.  It will trigger a WARN_ON() at the
start of fb_deferred_io_init() and the function will not do anything.

Fixes: 856082f021a2 ("fbdev: defio: fix the pagelist corruption")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 V2 -> V3: Add patch changelog 
 V1 -> V2: Change commit message and base on top of linux-next

 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9b3eaed80cdd..afaba94d1d1c 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -654,7 +654,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbdefio->delay =            HZ / fps;
 	fbdefio->sort_pagereflist = true;
 	fbdefio->deferred_io =      fbtft_deferred_io;
-	fb_deferred_io_init(info);
 
 	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
@@ -665,6 +664,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
+	fb_deferred_io_init(info);
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
-- 
2.25.1

