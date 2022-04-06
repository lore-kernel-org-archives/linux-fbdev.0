Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC23CC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239729AbiDFR5N (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239737AbiDFR5F (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Apr 2022 13:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B892C1A8FE8
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Apr 2022 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=OSyXJou27BURdMv28DN5iA0vittwcoh6uoSf5Bk8vh2qlX1EM130aDJTbMAZasgUI/nppW
        N0huWjp8FoV0X1pjGpd+gfJXjhMEOitKmxiaQ1ZGfn0+rHmejDbwqpTxcApwtClJT7V9lm
        hslKsea9zBmb7rEMRFx8dtVYIlaoH5U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-TCSoDpeDOV2fl30Lek7VWw-1; Wed, 06 Apr 2022 12:06:48 -0400
X-MC-Unique: TCSoDpeDOV2fl30Lek7VWw-1
Received: by mail-wr1-f71.google.com with SMTP id j18-20020adfa552000000b002060a011303so647609wrb.14
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Apr 2022 09:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KV4A7vxPY5Ri/A7ExTRv30H1oUVvMjyO4SRhZ4A4Rkc=;
        b=Ja3sE9U02g8KGcdbYUZOuC5HQ1fYClv0EQD8WlHLTZaUobRox/WcfhdbQYutnB0qf2
         nqkr96gir+AlbyEJaXzoBi/NGyI+atn3oFhOEWTsIdRbCSFjOz2t0NX/u6ZzdkfGmd+w
         cUacty5Stt76JGtCBMSKX5Uvc64dULrFB9PZbC7JlG1U9JWzF9lQtD+96jlLZ7NVxPUy
         pka9MtdIQcgSfoYOk9HxyiJ/dpMtlPkEVkvB90dr3W5wBglSONFRx4e6CGt8MxkwaOJA
         8XUXbD3z3PtQEc/+pFh1M5aXrphKs/CDPWkJx9N1e0TXqncAq232uYRWpw19n8k/Q/d+
         OWIg==
X-Gm-Message-State: AOAM530Bu8J8o4g7uh/SL8A3ejT72QNCX9nOhuOEBRF3dEEEAZzf/1aO
        JLqKzvEYBpA6XF1OVWixhUXD3BxpMQBT27GyETRib5ia02vSrGnuMaY8UaGvl1Td7Wd5yOJDWcR
        ZpOAn8rQ3C2Aebstwa0J2uHY=
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr7358628wrr.323.1649261207510;
        Wed, 06 Apr 2022 09:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4iqTGXWAmr0kVXiSaBoH7zqLfupO6IvuwBcok5RYqdCJJH/FQ8YSgWM4GphZdzl59KrH3Wg==
X-Received: by 2002:adf:f94d:0:b0:1e5:5ca1:2b80 with SMTP id q13-20020adff94d000000b001e55ca12b80mr7358600wrr.323.1649261207193;
        Wed, 06 Apr 2022 09:06:47 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 3/5] fbdev: Restart conflicting fb removal loop when unregistering devices
Date:   Wed,  6 Apr 2022 18:06:30 +0200
Message-Id: <20220406160632.496684-4-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406160632.496684-1-javierm@redhat.com>
References: <20220406160632.496684-1-javierm@redhat.com>
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

