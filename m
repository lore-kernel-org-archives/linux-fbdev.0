Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3334EC433EF
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Jun 2022 19:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357003AbiFGT7Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 15:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357673AbiFGT6Z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 15:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472A71B783D
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654626232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s12dM/fUNAK8FcN2HDfoJsYb2JSXAKJ07j+xEpEzvhM=;
        b=OWsCBO1jS/m8i4Mwi/4aQOsaxNu2Qiy9cQfq9xm9y4nkFn8QhzmL4MiMf75P49Rqwqx6t9
        K8RH+nsYizEC/bsTt1nioahN2MPM7/dj+R3JgFoK70DXovoPHR5fZbApDvjZbjXVmmqjki
        L9X9QBpAy2ZnckPputE9M3D9fMQ/NWo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-tXeTOVyjMcq5mIypKmLeVg-1; Tue, 07 Jun 2022 14:23:51 -0400
X-MC-Unique: tXeTOVyjMcq5mIypKmLeVg-1
Received: by mail-wm1-f70.google.com with SMTP id j40-20020a05600c1c2800b003972dbb1066so13093935wms.4
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jun 2022 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s12dM/fUNAK8FcN2HDfoJsYb2JSXAKJ07j+xEpEzvhM=;
        b=1G/AXbcx+cvUKcObWCKpFsi4Y84qjT8F/eiJ5Q4/WwTgrSfgzpDNlegfJ/ufoDOhC7
         FbQhjuVpWwAHO5b1Hjyg5CkeFf/Wo9ijI89z6nkynljjkgQ8IUFHfKW/7O5aB4BUDvzy
         vy8/QhcICwUQXuCar3OWAc16qKTz8ar+dztHjYXgyUqtHUmxBnoZAX6KzUOuv60/8Hb9
         tCB1AhoYAKxnGW9KGInz2iANOI4SxpCwGvMBckdFpyYvawDjzbJjkxYtiApK15+iV7+j
         e3DGgVyG5CamVMgHi3yg3U18RSW60YUcdIUUHJ2zjyYV/OwIS3SGFDG/yIUA9yzSKM8R
         +QdQ==
X-Gm-Message-State: AOAM530ldQkpHexa/iJym0SZ5HvtfRg3FZrE7NoYqcbN5wJxCuUUqdM/
        xDdmjU6CymyvEegDQBur8BuuF7lMSUICcmwAlz5NWlTpqteaYXRHUGG5LrYFs3XY/AZgXs063gH
        CZS8h+56ESn5uF6LRBL+bRLQ=
X-Received: by 2002:a05:600c:3d1b:b0:39b:1743:4d84 with SMTP id bh27-20020a05600c3d1b00b0039b17434d84mr29741814wmb.118.1654626230272;
        Tue, 07 Jun 2022 11:23:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHm5Esw2Ac7SpEx33f/vi2LUTuERvwYyQv2tSJ4Nx4mYKDItiXTPZoaSeRZfdNCayFMtQlEg==
X-Received: by 2002:a05:600c:3d1b:b0:39b:1743:4d84 with SMTP id bh27-20020a05600c3d1b00b0039b17434d84mr29741791wmb.118.1654626230045;
        Tue, 07 Jun 2022 11:23:50 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003942a244f51sm28267502wmq.42.2022.06.07.11.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 11:23:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>
Subject: [PATCH v6 4/5] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Tue,  7 Jun 2022 20:23:37 +0200
Message-Id: <20220607182338.344270-5-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607182338.344270-1-javierm@redhat.com>
References: <20220607182338.344270-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

This reverts commit fb561bf9abde49f7e00fdbf9ed2ccf2d86cac8ee.

With

commit 27599aacbaefcbf2af7b06b0029459bbf682000d
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Tue Jan 25 10:12:18 2022 +0100

    fbdev: Hot-unplug firmware fb devices on forced removal

this should be fixed properly and we can remove this somewhat hackish
check here (e.g. this won't catch drm drivers if fbdev emulation isn't
enabled).

Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ilya Trukhanov <lahvuun@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/efifb.c    | 11 -----------
 drivers/video/fbdev/simplefb.c | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index ea42ba6445b2..edca3703b964 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -351,17 +351,6 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&dev->dev,
-			"efifb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
 		return -ENODEV;
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 94fc9c6d0411..0ef41173325a 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -413,17 +413,6 @@ static int simplefb_probe(struct platform_device *pdev)
 	struct simplefb_par *par;
 	struct resource *res, *mem;
 
-	/*
-	 * Generic drivers must not be registered if a framebuffer exists.
-	 * If a native driver was probed, the display hardware was already
-	 * taken and attempting to use the system framebuffer is dangerous.
-	 */
-	if (num_registered_fb > 0) {
-		dev_err(&pdev->dev,
-			"simplefb: a framebuffer is already registered\n");
-		return -EINVAL;
-	}
-
 	if (fb_get_options("simplefb", NULL))
 		return -ENODEV;
 
-- 
2.36.1

