Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECEC43216
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1A960F4F
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbhH0KBk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:01:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244762AbhH0KBh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=foW7usJ3woghuCkc/3vNgB/OwFOj3a3CXY41KP8I0wQ=;
        b=Hkinb06twqHN8H5bDDJXDyOmvgbEm0FZyg9Du+9+ee5GvkW3r3Y9Z5mzF9ZAk+Fqa7LYbu
        egF3IvjbmZuB7xuUKxE2h+8V4XxDiQdE2fqRLRIBuc+qqiudp/Dsy9VR1hn8gTLhLsXMU5
        VGwoD2a9CUSVQyMMVv1WAGyW+zsdgmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-hTBbNCnRN5yPkzTseOdYZg-1; Fri, 27 Aug 2021 06:00:47 -0400
X-MC-Unique: hTBbNCnRN5yPkzTseOdYZg-1
Received: by mail-wr1-f69.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso1682820wrm.9
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Aug 2021 03:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foW7usJ3woghuCkc/3vNgB/OwFOj3a3CXY41KP8I0wQ=;
        b=sKAthe3q9YlyLaW2IGa6X9YIrh8KznQkAFcmvox8XQOt7ipo5s+BFCq8sugsea4mAZ
         8+8Hfom6r0ETezckMHXuEkPMDpg/0IhzZOISaYOPaBYOpGNk3bCbtevzQR97tLsW3VC4
         XzGMnfOQo4WdFteRP8ICYniSOwObVLBSqKIDhiN7eAMCcZB5nk9a3+y90ykweHl+Sb5j
         5Hmhkv0Bsblt1CyG7eeCYxGKvareM5/ijvlKEKTGCbdbkUici7Iy7DYbsxe+M8BL+Zg7
         6fSJyJbAliOsAIrpfspOKHGE9ZUCdwxUcPj31P6x2jfoA/Iz9ErsWAnm8g4bqzMquZJc
         mD9Q==
X-Gm-Message-State: AOAM531M3GLA4Upim6G5nbL9nmv73XkzH0hc8UcvoXUcjsc3WpEylSpF
        h87amrtqKu2112jfgWDhQWmv4WhlZSUMrV50E1QHtkzZGqOAPcBAkGre4Aw2x42DYHfz0i8XuOT
        na+4VZQS6DFbCXylo18Lh5PI=
X-Received: by 2002:a1c:f314:: with SMTP id q20mr18904186wmq.154.1630058443405;
        Fri, 27 Aug 2021 03:00:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFlYp1BMQ77FCjlALBardwbtrf8PR3eyfLYaynSRZe3DMWKOKmTwk3yQe4c5MOPI7tPuHpLw==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr18904160wmq.154.1630058443199;
        Fri, 27 Aug 2021 03:00:43 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z17sm1121267wrh.66.2021.08.27.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:00:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 1/4] fbdev: Rename fb_*_device() functions names to match what they do
Date:   Fri, 27 Aug 2021 12:00:24 +0200
Message-Id: <20210827100027.1577561-2-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827100027.1577561-1-javierm@redhat.com>
References: <20210827100027.1577561-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The fb_init_device() and fb_cleanup_device() functions only register and
unregister sysfs attributes as their initialization and cleanup logic.
Let's rename these functions to better match what they actually do.

There's only a call to dev_set_drvdata() that's not related to the sysfs
registration, so move it to the do_register_framebuffer() function which
is where the device is created.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c   | 8 +++++---
 drivers/video/fbdev/core/fbsysfs.c | 6 ++----
 include/linux/fb.h                 | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 71fb710f1ce..d886582c0a4 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1602,8 +1602,10 @@ static int do_register_framebuffer(struct fb_info *fb_info)
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create device for framebuffer %d; errno = %ld\n", i, PTR_ERR(fb_info->dev));
 		fb_info->dev = NULL;
-	} else
-		fb_init_device(fb_info);
+	} else {
+		dev_set_drvdata(fb_info->dev, fb_info);
+		fb_register_sysfs(fb_info);
+	}
 
 	if (fb_info->pixmap.addr == NULL) {
 		fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1701,7 +1703,7 @@ static void do_unregister_framebuffer(struct fb_info *fb_info)
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[fb_info->node] = NULL;
 	num_registered_fb--;
-	fb_cleanup_device(fb_info);
+	fb_unregister_sysfs(fb_info);
 #ifdef CONFIG_GUMSTIX_AM200EPD
 	{
 		struct fb_event event;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 65dae05fff8..a040d6bd6c3 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -507,12 +507,10 @@ static struct device_attribute device_attrs[] = {
 #endif
 };
 
-int fb_init_device(struct fb_info *fb_info)
+int fb_register_sysfs(struct fb_info *fb_info)
 {
 	int i, error = 0;
 
-	dev_set_drvdata(fb_info->dev, fb_info);
-
 	fb_info->class_flag |= FB_SYSFS_FLAG_ATTR;
 
 	for (i = 0; i < ARRAY_SIZE(device_attrs); i++) {
@@ -531,7 +529,7 @@ int fb_init_device(struct fb_info *fb_info)
 	return 0;
 }
 
-void fb_cleanup_device(struct fb_info *fb_info)
+void fb_unregister_sysfs(struct fb_info *fb_info)
 {
 	unsigned int i;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5950f8f5dc7..96111248a25 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -689,8 +689,8 @@ static inline bool fb_be_math(struct fb_info *info)
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);
-extern int fb_init_device(struct fb_info *fb_info);
-extern void fb_cleanup_device(struct fb_info *head);
+extern int fb_register_sysfs(struct fb_info *fb_info);
+extern void fb_unregister_sysfs(struct fb_info *head);
 extern void fb_bl_default_curve(struct fb_info *fb_info, u8 off, u8 min, u8 max);
 
 /* drivers/video/fbmon.c */
-- 
2.31.1

