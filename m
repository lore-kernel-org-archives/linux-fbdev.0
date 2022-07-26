Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE77C43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 08:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiGZIXK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 04:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGZIXJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 04:23:09 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D36E26AC6
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 01:23:07 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id t7so10142138qvz.6
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6czwj1HzPSVht5LKBHhjYm6MovKhK084JbpR2sXNUxE=;
        b=PaanFb9C2onSyyBOzQuSewIeVp/JBcVJ6X2rfbbWQIfn89XDfLM+X2YNKzqdJolbxD
         sLAzF1ykNA08gre0tABu2WPkSCctDo3MQ1aGfZd7dLvtTyQ/+LaHV3mWP+DYrnK50ScQ
         ljQqIVT+LmzG3jQEX/dfAn0wHqLNAXV3noJmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6czwj1HzPSVht5LKBHhjYm6MovKhK084JbpR2sXNUxE=;
        b=MCnQkn0mJajlN77HOoMcEvyb4ti5lu/ioNEcDnU5G6lGymBiMwOZ30OUzHq2XoA7Cz
         l7WVLCTTg8HNHAwxHrOtqn8uFhVSDTOjgqS1Fp3CBCyeXdMsrQtYmrJd1PXofCUcki6F
         iPQa1WHFurUQC7rYGtR09nhlAN9eKpYoGeekQ1ocAE8g3aB7OXUKhxJBqEMXRw1VdsN8
         owOeMhLwq8hFzS+nOl7pTH7jNqkgJlJwXJVUKDZTNLZk7n9xaCv2KZoY+ailjYcvHnKc
         QWX+KP7K9XldA8D4lOb9eYiv3dSwW5xnG7P+eGcioAr1wBYFS1SIhksqlCmMQhdNSZ2P
         HvWg==
X-Gm-Message-State: AJIora+u233mGmeZlGrZoG59OJ4aqgG+U6bg/KFlScvgPtLnXl4aodrt
        z45NDkMhmlFM2zWTWcvNJ82PJ/vBNdW2WQnp
X-Google-Smtp-Source: AGRyM1voH2NwourXXNbOEJ/tLf9qotPbGThefm/NyTg7N/0KBHbFjT5XFPrO8DhdO3E3qZhWHOJvoA==
X-Received: by 2002:a05:6214:2342:b0:473:bcd6:a3b7 with SMTP id hu2-20020a056214234200b00473bcd6a3b7mr13676393qvb.88.1658823786755;
        Tue, 26 Jul 2022 01:23:06 -0700 (PDT)
Received: from localhost.localdomain (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id x14-20020a05620a12ae00b006b53fe19c41sm10004461qki.14.2022.07.26.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 01:23:06 -0700 (PDT)
From:   Peter Suti <peter.suti@streamunlimited.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Suti <peter.suti@streamunlimited.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: core: set smem_len before fb_deferred_io_init call
Date:   Tue, 26 Jul 2022 10:21:13 +0200
Message-Id: <20220726082114.891853-1-peter.suti@streamunlimited.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

fb_deferred_io_init depends on smem_len being filled
to be able to initialize the virtual page lists since
commit 856082f021a2 ("fbdev: defio: fix the pagelist corruption")

Signed-off-by: Peter Suti <peter.suti@streamunlimited.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 9c4d797e7ae4..4137c1a51e1b 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -656,7 +656,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	fbdefio->delay =           HZ / fps;
 	fbdefio->sort_pagelist =   true;
 	fbdefio->deferred_io =     fbtft_deferred_io;
-	fb_deferred_io_init(info);
 
 	snprintf(info->fix.id, sizeof(info->fix.id), "%s", dev->driver->name);
 	info->fix.type =           FB_TYPE_PACKED_PIXELS;
@@ -667,6 +666,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
+	fb_deferred_io_init(info);
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
-- 
2.25.1

