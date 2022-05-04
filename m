Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B6C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 11:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbiEDMDM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbiEDMDL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 08:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80DDF18B0E
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651665574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hdaz9MpZoIlHo5W6Yr3E01ttRcC4gjvc5tNziIXBlcs=;
        b=hxTN1fiSHXuDMr1250OOXSGwLme4dlYHEYZU1qZ4qAPgaFf6QUbEt/yj3GcfNGjFczyeko
        bLGeZY50K21D9a1RJ4gtLdCpm9F6FftmI+K5k0X3lRhAIO81eVslR2bbTgpT1Agoy5ZLbw
        K74CQfcDqD0GETR7AtErdwdXqKX254A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-6dBYR42mO8mny8Y-c7ZLEg-1; Wed, 04 May 2022 07:59:33 -0400
X-MC-Unique: 6dBYR42mO8mny8Y-c7ZLEg-1
Received: by mail-wm1-f72.google.com with SMTP id p13-20020a05600c358d00b00394586f6959so1117955wmq.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hdaz9MpZoIlHo5W6Yr3E01ttRcC4gjvc5tNziIXBlcs=;
        b=039lNGhJtbdY1cf9RESqXKW+JLyhAYOPoNXD8oBpzzRrTTwT0+HIN7qAHlCcmZBphb
         mzNS+MfQ5IUyTPbC8y8ToLUfD0B7wBxBchlS+QKVNzqwoTcKDsdGNsFSotGZq3qFu1tG
         5ABP+sR8E3Wx7XY4taMuU2jZP//d4odrHDHw+aEKW6klUPYYHRFvriUNOZtEtsqJcenB
         fmRpEPu1dmEaCU/vz+3QSXvR0YZ0/gtfeEqZZLERs6v3Sev4uNfFa7BPYRyfwqYAtx8X
         N65HL6eKvzk0STWDwtcfHGPzRsY+3McKBpnPmQFuoicfs+qXO2sEnirZKfS8nwsz5DhI
         xBWQ==
X-Gm-Message-State: AOAM532ggnylt5Dy1u3VUx34Cd58da5xvvR/rxnLDYM+45jUFLdV/ZfU
        aEVtgrHprRujRPatNXsRacf49i/0dSltl9JSbtguh/kvoMz6nWjUOQwMV7FMWIuoGC9OqA/lisx
        23g6z3w00JBQoArAzR+pQvOs=
X-Received: by 2002:a05:6000:1844:b0:20c:5672:9573 with SMTP id c4-20020a056000184400b0020c56729573mr15065537wri.538.1651665572011;
        Wed, 04 May 2022 04:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgDtpAe/DLUybOoXaFzCCcl0wELARIERg8DV6OtPnYk2dBjPP7wFdtw5kHDTnYHSwd136yIw==
X-Received: by 2002:a05:6000:1844:b0:20c:5672:9573 with SMTP id c4-20020a056000184400b0020c56729573mr15065508wri.538.1651665571647;
        Wed, 04 May 2022 04:59:31 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n32-20020a05600c3ba000b003943a559b3fsm3765344wms.8.2022.05.04.04.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 04:59:31 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] Revert "fbdev: Make fb_release() return -ENODEV if fbdev was unregistered"
Date:   Wed,  4 May 2022 13:59:17 +0200
Message-Id: <20220504115917.758787-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This reverts commit aafa025c76dcc7d1a8c8f0bdefcbe4eb480b2f6a. That commit
attempted to fix a NULL pointer dereference, caused by the struct fb_info
associated with a framebuffer device to not longer be valid when the file
descriptor was closed.

The issue was exposed by commit 27599aacbaef ("fbdev: Hot-unplug firmware
fb devices on forced removal"), which added a new path that goes through
the struct device removal instead of directly unregistering the fb.

Most fbdev drivers have issues with the fb_info lifetime, because call to
framebuffer_release() from their driver's .remove callback, rather than
doing from fbops.fb_destroy callback. This meant that due to this switch,
the fb_info was now destroyed too early, while references still existed,
while before it was simply leaked.

The patch we're reverting here reinstated that leak, hence "fixed" the
regression. But the proper solution is to fix the drivers to not release
the fb_info too soon.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v2:
- Add more info in the commit message about why it's crashing and how
  the reverted commit was papering over the issue (Daniel Vetter).
- Add Daniel Vetter's Reviewed-by tag.

 drivers/video/fbdev/core/fbmem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97eb0dee411c..a6bb0e438216 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1434,10 +1434,7 @@ fb_release(struct inode *inode, struct file *file)
 __acquires(&info->lock)
 __releases(&info->lock)
 {
-	struct fb_info * const info = file_fb_info(file);
-
-	if (!info)
-		return -ENODEV;
+	struct fb_info * const info = file->private_data;
 
 	lock_fb_info(info);
 	if (info->fbops->fb_release)
-- 
2.35.1

