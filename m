Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E8C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 21:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbiDFVvf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiDFVvL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Apr 2022 17:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66ABE8C7D8
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Apr 2022 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=XMC3DO44F13IS1QdQwPv660gawUPeVr7VoCzC3L6fgK8nJcOt+V/TXyPx+Qxwez9zyi9+G
        27TGLvWnJWHKluKduDBoYLSkVgWoDknJx/RI0bFmjAKmStwH9/i2iV0cL89i4LXuPBgx7E
        mJdYz4Jq9dnjHlU89qU+TLMixvrjfwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-jC2uqHHgN0KwAHWUhI2KMA-1; Wed, 06 Apr 2022 17:40:55 -0400
X-MC-Unique: jC2uqHHgN0KwAHWUhI2KMA-1
Received: by mail-wm1-f71.google.com with SMTP id n21-20020a05600c4f9500b0038e3b0aa367so2430216wmq.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Apr 2022 14:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=RuxmEowZnEOCDpUtmV126gAEs82qx/v9XxvG1NAR27V+8rgeNt9gkKYwYpnuLD4ScJ
         mDFdKq9wH5LwcIYilagyq9fkY8YdSG00FT+wd7CQPZycWwyjsKLPsKaiPrRK5NDJi6Jc
         yZ92+YJH+K7yNrQHa/HlWqX7kCM6K/0GMNguR3qH2UL3mf1Wq5eb4GrzDYRA2CIR2FNT
         27RZhZAVwYrrpiURyL8FPxDC7KaxFydslfJWv23t0kF2JS+IccmofnN2v9NyXSO0Tg4H
         y07pG5e4jdP19kf0T8HFYTUISzPnCBPOVDHKiEHkDPuxpMygQNsHXTkm0+TwEpf5EzFc
         mntA==
X-Gm-Message-State: AOAM532ZblWZladOQs2qAUMMwjjj4RbIeFIrGWdFCUJjgCfXIz8mzf6d
        /3TIzaq/N5TUS0rHntk1/inb4Y/0AVlI3FAcOC3st09htDUCsS5kL79fDaYJZOeAfCLgKax/lmw
        uYn506ejxMlPDj/oUVk8vtL0=
X-Received: by 2002:adf:d1e8:0:b0:206:fdb:849 with SMTP id g8-20020adfd1e8000000b002060fdb0849mr8274608wrd.251.1649281253648;
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/mJZqMWnMsmiDK/QHEbj6zIloBdqX55fsoP+DxKAu2//ICDmt3KL7sczE6heg786RoMwiDQ==
X-Received: by 2002:adf:d1e8:0:b0:206:fdb:849 with SMTP id g8-20020adfd1e8000000b002060fdb0849mr8274601wrd.251.1649281253422;
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
Subject: [RESEND RFC PATCH 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed,  6 Apr 2022 23:39:17 +0200
Message-Id: <20220406213919.600294-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406213919.600294-1-javierm@redhat.com>
References: <20220406213919.600294-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Drivers that want to remove registered conflicting framebuffers prior to
register their own framebuffer, calls remove_conflicting_framebuffers().

This function takes the registration_lock mutex, to prevent a races when
drivers register framebuffer devices. But if a conflicting framebuffer
device is found, the underlaying platform device is unregistered and this
will lead to the platform driver .remove callback to be called, which in
turn will call to the unregister_framebuffer() that takes the same lock.

To prevent this, a struct fb_info.forced_out field was used as indication
to unregister_framebuffer() whether the mutex has to be grabbed or not.

A cleaner solution is to drop the lock before platform_device_unregister()
so unregister_framebuffer() can take it when called from the fbdev driver,
and just grab the lock again after the device has been registered and do
a removal loop restart.

Since the framebuffer devices will already be removed, the loop would just
finish when no more conflicting framebuffers are found.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c | 21 ++++++++++++++-------
 include/linux/fb.h               |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index b585339509b0..c1bfb8df9cba 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1555,6 +1555,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1582,8 +1583,18 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * fix would add code to remove the device from the system.
 			 */
 			if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
+				/*
+				 * Drop the lock since the driver will call to the
+				 * unregister_framebuffer() function that takes it.
+				 */
+				mutex_unlock(&registration_lock);
 				platform_device_unregister(to_platform_device(device));
+				mutex_lock(&registration_lock);
+				/*
+				 * Restart the removal now that the platform device
+				 * has been unregistered and its associated fb gone.
+				 */
+				goto restart_removal;
 			} else {
 				pr_warn("fb%d: cannot remove device\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
@@ -1917,13 +1928,9 @@ EXPORT_SYMBOL(register_framebuffer);
 void
 unregister_framebuffer(struct fb_info *fb_info)
 {
-	bool forced_out = fb_info->forced_out;
-
-	if (!forced_out)
-		mutex_lock(&registration_lock);
+	mutex_lock(&registration_lock);
 	do_unregister_framebuffer(fb_info);
-	if (!forced_out)
-		mutex_unlock(&registration_lock);
+	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(unregister_framebuffer);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 39baa9a70779..f1e0cd751b06 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -503,7 +503,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

