Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ADC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Apr 2022 16:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiDHQPz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiDHQPv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Apr 2022 12:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75CE9ECB35
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Apr 2022 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649434425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcEitY10iZAiJ+J3+u8UtqIoWNDWTfj8MjNNemYgu3M=;
        b=TVAIMyQF/40HM6WGtubk/3SslJndD1IjwPGZd4ekZtj8FZG4pU/UaBkc2e6chNiPC6AlKS
        +9UAGNS0F+9rf0qgU259drvP7Nj4RpJNBni867rzhIiybO5ENs5rYnHP29y6XomYeqIjgB
        TKwQ2zpPfeGAK1rvYDwc6op0ay3+3rM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-azkfzhqJNHiLfFgKTufWfQ-1; Fri, 08 Apr 2022 12:13:44 -0400
X-MC-Unique: azkfzhqJNHiLfFgKTufWfQ-1
Received: by mail-wm1-f69.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so4568130wmk.6
        for <linux-fbdev@vger.kernel.org>; Fri, 08 Apr 2022 09:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zcEitY10iZAiJ+J3+u8UtqIoWNDWTfj8MjNNemYgu3M=;
        b=6zJc4+HxqE/I/tQQvsWS9vOvuemAcW0dmpji65YBBg9DiXyrXIGkSNDMFjEjsIG5Ir
         k6XxtFnxMKrIgAmtdk+pFsKgWI60zmaS66guYSHcg3UlnElM3vpfSyrP35+XAfrO5g8J
         LN8rwiAP3tFOwrm6oi5JNF3Eic0xuWGE4yT27Go83pzG/WrT08U82oWS64eUaO3R76Dm
         FkL27Zh2sDQW7GYb3YAtnusZIk1puClFQ/tGOS1tAHnhf8m0GIgUht/NXVsCMwi3ERiB
         LO7MBOP2uaN49ym4c6TknOqAe3cSlqByxt0/aDgTJhdK9x6VzwIBdXnfNQ9OXnrJGWai
         cZ6A==
X-Gm-Message-State: AOAM530futK86Kr0VOf5wMIMuU/Zn9ijp1htpkSLiDLyfHD/jOiJjrjT
        SIP+KDSupiKUwTm0TQLpv0fZtLskIuXWTWd2My3SrgHVBOznrX5sTkcaiUs1zXqL6MA/y7IIAPI
        Poxh8HcmhnMqmpZAmsv8vLpc=
X-Received: by 2002:a5d:6785:0:b0:204:f8f:8fab with SMTP id v5-20020a5d6785000000b002040f8f8fabmr15369341wru.353.1649434423620;
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt3Rj+zw8mIsN24LhLbQy+hWefHkvvpTKfeMVqAFvoZziJC7qiikDxng1MGBPfgLZBQiYEtg==
X-Received: by 2002:a5d:6785:0:b0:204:f8f:8fab with SMTP id v5-20020a5d6785000000b002040f8f8fabmr15369313wru.353.1649434423340;
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b002060d26c211sm14377455wrn.114.2022.04.08.09.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 09:13:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v2 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Fri,  8 Apr 2022 18:13:20 +0200
Message-Id: <20220408161322.270176-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408161322.270176-1-javierm@redhat.com>
References: <20220408161322.270176-1-javierm@redhat.com>
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
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

(no changes since v1)

 drivers/video/fbdev/core/fbmem.c | 29 +++++++++++++++++++----------
 include/linux/fb.h               |  1 -
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index bdd00d381bbc..bcdbbe543466 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1553,6 +1553,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 {
 	int i;
 
+restart_removal:
 	/* check all firmware fbs and kick off if the base addr overlaps */
 	for_each_registered_fb(i) {
 		struct apertures_struct *gen_aper;
@@ -1576,16 +1577,28 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			 * VESA, EFI, etc. A native driver will then be able to
 			 * allocate the memory range.
 			 *
-			 * If it's not a platform device, at least print a warning. A
-			 * fix would add code to remove the device from the system.
+			 * Drop the lock because if the device is unregistered, its
+			 * drivers will call to unregister_framebuffer() that takes
+			 * this lock.
 			 */
+			mutex_unlock(&registration_lock);
 			if (dev_is_platform(device)) {
-				registered_fb[i]->forced_out = true;
 				platform_device_unregister(to_platform_device(device));
 			} else {
+				/*
+				 * If it's not a platform device, at least print a warning. A
+				 * fix would add to code to remove the device from the system.
+				 */
 				pr_warn("fb%d: cannot remove device\n", i);
-				do_unregister_framebuffer(registered_fb[i]);
+				/* call unregister_framebuffer() so it can take the lock */
+				unregister_framebuffer(registered_fb[i]);
 			}
+			mutex_lock(&registration_lock);
+			/*
+			 * Restart the removal loop now that the device has been
+			 * unregistered and its associated framebuffer gone.
+			 */
+			goto restart_removal;
 		}
 	}
 }
@@ -1892,13 +1905,9 @@ EXPORT_SYMBOL(register_framebuffer);
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
index f95da1af9ff6..b781bc721113 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -502,7 +502,6 @@ struct fb_info {
 	} *apertures;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
-	bool forced_out; /* set when being removed by another driver */
 };
 
 static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
-- 
2.35.1

