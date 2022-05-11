Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C934C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiEKLbq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbiEKLbo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 07:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43A29689B4
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SX2bFHVDV/mv6k7vv6fW/ROIxkWSEMHBP8/xN2gTDGs=;
        b=S2oB44iSzFnrntHz0OOc1hUhexDPJKsKfIXS+3pM1idgR0jkIbO1RwKBM9+M36hw+xPm2m
        JQo5mtWqYw3MiMddXxHPIJVBV4NXyVyZ95I5vP55so/FRsEOe3iK6JZsss8Z0E4S1e49JE
        FucXcy1UDbeEXkisWOUMZ3k1Aq5lQcw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-FLJy8CbMMyGrDBZZx--zPg-1; Wed, 11 May 2022 07:31:36 -0400
X-MC-Unique: FLJy8CbMMyGrDBZZx--zPg-1
Received: by mail-wm1-f70.google.com with SMTP id g14-20020a1c4e0e000000b0039425ef54d6so606140wmh.9
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SX2bFHVDV/mv6k7vv6fW/ROIxkWSEMHBP8/xN2gTDGs=;
        b=W11OHJn6qMHbiptWUqt4E1RA6cyUVTczqYDNGVk8y7KS88aulfv9cae2NNJ42hULXX
         onFDdVmmTGSzgMeWTG4xtGJgMbg0HVXSY0CXH8F1LIcyBKQzjlTMuNKYSUzwgl85xGNb
         tEfa0q5WJZEs8iZHSHb66Yi544qJ5wMaJamWDazScp+w6gERVlQOAWD6mnZ5srJkdWVW
         adIIftzTZnVBgrRzycbi+Y/jjVaaouIa0pNuGmP8w/CClXPBGl2XCNV3YkiOJiVu1IMW
         KdPvNRrmdIjnrTaPspJr/MxW4D0pXLzcgKRhPNCdcXPre/krP5v8s2cE+ceB/ET696z8
         9aHw==
X-Gm-Message-State: AOAM5304h3DhMUWq6PzQgADC47+sPtOzKu5nHg9MYz5KQRD5KrxwG3gI
        P7Eg2zPQ//KirQnHChLLhgMZiaP4DLMifxJbeaTQTO6m3yIvl/CI6tM1GCqClgRbaWgxiOPvzoP
        TPPZleUA1EusEY6wwKVI/FRY=
X-Received: by 2002:adf:f152:0:b0:20a:cb56:c20d with SMTP id y18-20020adff152000000b0020acb56c20dmr22007081wro.699.1652268694873;
        Wed, 11 May 2022 04:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0z1zDlwGIzZgJwvaUaNGzfZllclBP5T5A4FWJ6skTVqjs02PfSApxo9GnfjeSuNrfEEz42w==
X-Received: by 2002:adf:f152:0:b0:20a:cb56:c20d with SMTP id y18-20020adff152000000b0020acb56c20dmr22007059wro.699.1652268694617;
        Wed, 11 May 2022 04:31:34 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id be5-20020a05600c1e8500b003942a244f54sm5611293wmb.45.2022.05.11.04.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:31:34 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 4/7] fbdev: Make sysfb to unregister its own registered devices
Date:   Wed, 11 May 2022 13:31:25 +0200
Message-Id: <20220511113125.1252660-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The platform devices registered in sysfb match with a firmware-based fbdev
or DRM driver, that are used to have early graphics using framebuffers set
up by the system firmware.

Real DRM drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has the problem that sysfb doesn't know when the
device that registered is unregistered. This means that is not able to do
any cleanup if needed since the device pointer may not be valid anymore.

Not all platforms use sysfb to register the simple framebuffer devices,
so an unregistration has to be forced by fbmem if sysfb_try_unregister()
does not succeed at unregister the device.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---

(no changes since v4)

Changes in v4:
- Drop call to sysfb_disable() in fbmem since is done in other places now.

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2fda5917c212..9b035ef4d552 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/slab.h>
+#include <linux/sysfb.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/vt.h>
@@ -1587,18 +1588,35 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 			if (!device) {
 				pr_warn("fb%d: no device set\n", i);
 				do_unregister_framebuffer(registered_fb[i]);
-			} else if (dev_is_platform(device)) {
+			} else {
 				/*
 				 * Drop the lock because if the device is unregistered, its
 				 * driver will call to unregister_framebuffer(), that takes
 				 * this lock.
 				 */
 				mutex_unlock(&registration_lock);
-				platform_device_unregister(to_platform_device(device));
+				/*
+				 * First attempt the device to be unregistered by sysfb.
+				 */
+				if (!sysfb_try_unregister(device)) {
+					if (dev_is_platform(device)) {
+						/*
+						 * FIXME: sysfb didn't register this device, the platform
+						 * device was registered in other platform code.
+						 */
+						platform_device_unregister(to_platform_device(device));
+					} else {
+						/*
+						 * If is not a platform device, at least print a warning. A
+						 * fix would add to make the code that registered the device
+						 * to also unregister it.
+						 */
+						pr_warn("fb%d: cannot remove device\n", i);
+						/* call unregister_framebuffer() since the lock was dropped */
+						unregister_framebuffer(registered_fb[i]);
+					}
+				}
 				mutex_lock(&registration_lock);
-			} else {
-				pr_warn("fb%d: cannot remove device\n", i);
-				do_unregister_framebuffer(registered_fb[i]);
 			}
 			/*
 			 * Restart the removal loop now that the device has been
-- 
2.35.1

