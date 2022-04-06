Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E239C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 17:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239558AbiDFR5U (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbiDFR5L (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Apr 2022 13:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C8251AEC87
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Apr 2022 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=OegNKgnsE0zPqi5kNHGeoPhRiAsOQM7ZiIE0ofTppM+yiC6s9eNn2WRlXPmcVXON6rGNH3
        2bKCmDr/f3UQVY2RkfWuirKrfBwYyyld3rhZZ7xsyTP0gsD9B/KRHgyLZ3+y4Dz/e02bw7
        z3HsBGkklSxyS2F99m1xjoxOy2FGGNk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-8oe4lN9dO0m4ak-6vUp7MQ-1; Wed, 06 Apr 2022 12:06:51 -0400
X-MC-Unique: 8oe4lN9dO0m4ak-6vUp7MQ-1
Received: by mail-wm1-f69.google.com with SMTP id r19-20020a7bc093000000b0038e706da7c0so1524935wmh.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Apr 2022 09:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4FhXBUnLq/AeYpcQ43hIiOOWtFlBWzfoVNvi0Bsh0Mg=;
        b=sRSHD6ivu40u6INiP7ojVCjclOuENsiS8uLcse+ozslJGz9QlsSpw4DQjiArCfu7aT
         caaAAYbRF7krRMsA/S6b0ChOTiQl4FSDj/RNWZZDLagp1bojIlaa5tFNkqegMuX+MNjm
         5VmMZGUhNnENjshP50is3Dt4iaqfvJfHzHHC1JZ5Dnj6mYWDUgSIIiiRrBF0WEB/QDjv
         Bf6vqy5QIBIkIguA0pqET77zzg0WRFyUzv3FHs1Tv8v2KTTR0EESW0OLCb8im8fd/zmd
         jPZswilgYO+S5+6JhtOuUXbWsn2F7/YOimBrllpMR+Tsi9IP0myECpxx3k8T49ApecsP
         i6vA==
X-Gm-Message-State: AOAM5336TXsmVRab4RRvvL9W1yO3DaBAsWlUOnZGbmDbM0PgtElHFyNw
        xx3qWETFKME+V0cwoRnAp/7YmW5WnrzdtaMfAN9Q+iaPIO9rEPfsATqf2KHLfo9VenhYPJMFJrM
        C3d3Hj21GUWtGemah2sDrXlA=
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr7137233wrm.93.1649261209858;
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjTyMg4XL89qFWV3gB2V/HQc1uQjBder3TeH9rKQDOsGox6TANK3aF+8wdzRe76EhPl9Zl5g==
X-Received: by 2002:adf:dd4d:0:b0:203:f178:b78b with SMTP id u13-20020adfdd4d000000b00203f178b78bmr7137221wrm.93.1649261209641;
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Zack Rusin <zackr@vmware.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Peter Jones <pjones@redhat.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 5/5] Revert "fbdev: Prevent probing generic drivers if a FB is already registered"
Date:   Wed,  6 Apr 2022 18:06:32 +0200
Message-Id: <20220406160632.496684-6-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406160632.496684-1-javierm@redhat.com>
References: <20220406160632.496684-1-javierm@redhat.com>
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
Cc: Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

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
2.35.1

