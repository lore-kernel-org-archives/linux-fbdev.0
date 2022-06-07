Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD5CCA47C
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Jun 2022 19:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353541AbiFGT7P (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Jun 2022 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357588AbiFGT6Y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Jun 2022 15:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307C41B7836
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Jun 2022 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654626232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVERor1pDjv50JOPQD6dbA5hWF6IpXrW4mZT/xer28A=;
        b=h7Sz1larvRxJt1b36YC0eXE50ymixJ4vKcfr+iBxhb9bbPsjkV+lVdYasJSUdQKcieP0CF
        RXDeG49E5oABm1jIFUKXVaZXwVhx8m02E+l9oCNRAQ9oG4B1nXijFPpOru2FmcuXJdCXmv
        bxObNmb4IkoKdMnC6nbpJfOjrY+XscQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-M6O6CWbVP42s8k2WvhE2wQ-1; Tue, 07 Jun 2022 14:23:50 -0400
X-MC-Unique: M6O6CWbVP42s8k2WvhE2wQ-1
Received: by mail-wr1-f72.google.com with SMTP id c7-20020adfa707000000b002184d715e69so1165125wrd.10
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Jun 2022 11:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVERor1pDjv50JOPQD6dbA5hWF6IpXrW4mZT/xer28A=;
        b=x6woGw0d6aycQS5S5WzvANTMvOYmeCQzK9Y/9NgMQRx/x8jgImvnqEyQmchgc1AsUA
         AvkWHFCjCTbFfV8gkO3C4x4g54zBn1KcXB4ncgMJwIn+K38hP9RB0gQTl3YA/beKRkfA
         yWR6WtiMK95fm8KHlx/80LU9X+QNW3vG/OWfgyup11fbGFn9RNY9eOyfctiFCRJl9U1+
         jhTTKWUJ2tg8iYupFKlbd0p1R4Rtqlv84Avtca60sxL9TxmlJjLCSAXuydkhL9/Soc+6
         dyWFA7BCorLKxfeW9YUHeEwnnRye6U5fmudPeBnLWWzNplDLvrNBF2Vg+ZHp6T54oELX
         i+ZQ==
X-Gm-Message-State: AOAM531J7R39J3QIXiTxksP7iTNnaKLXPmkxXUDSF4wGi0bVI36wfLoB
        RYb59uVnagEDy4by/qxXdKH16glnHg+VUZxkMB4XmuqStGomuuTyACV78WuCo6NK6AMPIriCT1a
        P9ngBZqoDtEWnyF3zdKaPR4k=
X-Received: by 2002:a05:6000:1b03:b0:216:43b4:82f1 with SMTP id f3-20020a0560001b0300b0021643b482f1mr18992414wrz.232.1654626229027;
        Tue, 07 Jun 2022 11:23:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIJ2ZaSX69tcbwGyt9OTbAcEXndsJiDIZKc+WEe5sBYC0UmDo7XaAT1uT5eNOYdA7eP4tzzQ==
X-Received: by 2002:a05:6000:1b03:b0:216:43b4:82f1 with SMTP id f3-20020a0560001b0300b0021643b482f1mr18992391wrz.232.1654626228799;
        Tue, 07 Jun 2022 11:23:48 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003942a244f51sm28267502wmq.42.2022.06.07.11.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 11:23:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v6 3/5] fbdev: Disable sysfb device registration when removing conflicting FBs
Date:   Tue,  7 Jun 2022 20:23:36 +0200
Message-Id: <20220607182338.344270-4-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607182338.344270-1-javierm@redhat.com>
References: <20220607182338.344270-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The platform devices registered by sysfb match with firmware-based DRM or
fbdev drivers, that are used to have early graphics using a framebuffer
provided by the system firmware.

DRM or fbdev drivers later are probed and remove all conflicting framebuffers,
leading to these platform devices for generic drivers to be unregistered.

But the current solution has a race, since the sysfb_init() function could
be called after a DRM or fbdev driver is probed and request to unregister
the devices for drivers with conflicting framebuffes.

To prevent this, disable any future sysfb platform device registration by
calling sysfb_disable(), if a driver requests to remove the conflicting
framebuffers.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---

Changes in v6:
- Move the sysfb_disable() before the remove conflicting framebuffers
  loop (Daniel Vetter).

Changes in v5:
- Move the sysfb_disable() call at conflicting framebuffers again to
  avoid the need of a DRIVER_FIRMWARE capability flag.
- Add Daniel Vetter's Reviewed-by tag again since reverted to the old
  patch that he already reviewed in v2.

Changes in v3:
- Call sysfb_disable() when a DRM dev and a fbdev are registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.

Changes in v2:
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).

 drivers/video/fbdev/core/fbmem.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 2fda5917c212..e0720fef0ee6 100644
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
@@ -1764,6 +1765,17 @@ int remove_conflicting_framebuffers(struct apertures_struct *a,
 		do_free = true;
 	}
 
+	/*
+	 * If a driver asked to unregister a platform device registered by
+	 * sysfb, then can be assumed that this is a driver for a display
+	 * that is set up by the system firmware and has a generic driver.
+	 *
+	 * Drivers for devices that don't have a generic driver will never
+	 * ask for this, so let's assume that a real driver for the display
+	 * was already probed and prevent sysfb to register devices later.
+	 */
+	sysfb_disable();
+
 	mutex_lock(&registration_lock);
 	do_remove_conflicting_framebuffers(a, name, primary);
 	mutex_unlock(&registration_lock);
-- 
2.36.1

