Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BCC432BE
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A1C60F58
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244708AbhH0KGL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:06:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233121AbhH0KGL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Aug 2021 06:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lZeoDfGlQri5XDPiQdcQrgFtTksnEzEKvvSetj4F1YU=;
        b=gBQecQhLgo0tW8xsfWWg+w87ZD1qFtOT2EIlDAo4+fqc2McS4KDAfaE5qAg2ocsQAq+IyL
        96ruJYYcaGoQE12ArrUu71nA/YvhO58QZkYG0trYnX45dshHgEa9ul6DSnDzEiERFp4ydi
        hpVp8lIX26ggUXJs2ZUhG8E89yJHFSU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-MYXVIDWeMv-na1JS-mO_FQ-1; Fri, 27 Aug 2021 06:05:21 -0400
X-MC-Unique: MYXVIDWeMv-na1JS-mO_FQ-1
Received: by mail-wr1-f72.google.com with SMTP id h14-20020a056000000e00b001575b00eb08so1680499wrx.13
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Aug 2021 03:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lZeoDfGlQri5XDPiQdcQrgFtTksnEzEKvvSetj4F1YU=;
        b=T2worpyezAdmhdEMTEJ6yVIgUfQxIotxLejZHRCMA58a1ZZbZIqQoQFCjOjLYLMBNU
         pqgP+aMjmj9caPZMW9d1TTXD+BefmktzcBLVa6hdc5hCo04S0TRfaKGBuOvnHkPIhwug
         mKP/+o7mq++CklwuEwfM6CBlX5gTvLGGnB5DOlM/G1L+EwlNahBph5yiS2YiRxWheljf
         mlfceS0af5K3lG/sdjnH10PcDJTFH3zgZV3KindI0RfIOkjB8hxNyVQpw0pNVz21I/Rr
         H/uJwwTqsKC9BtFoRikcw9nHcfEaXeo1h3+LuTf02VPPUUO9jdFnf6PNoRpARtj1uzia
         RyZg==
X-Gm-Message-State: AOAM5307qmsKz/hcJTPybtpvPc41jT6duAVVib80OPyuw2/JA8Gk/jnK
        KlY2a8taP2PxtlAU0GfbmgaL2SnGq2cNltn8Kc+ADz75xUaBJcCQitZR+fCSRFLzzykT8UK0MmN
        9qxiv9TPNjCzxlud591886Io=
X-Received: by 2002:adf:df08:: with SMTP id y8mr9392594wrl.124.1630058719698;
        Fri, 27 Aug 2021 03:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYBGwA75JVWOcmJT5hsoigsXYLcUTaODP/05DgoTOGDrSnXVpxO4l4S8a8RqPK/jBwF3ToxQ==
X-Received: by 2002:adf:df08:: with SMTP id y8mr9392561wrl.124.1630058719405;
        Fri, 27 Aug 2021 03:05:19 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id e26sm6215156wrc.6.2021.08.27.03.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:05:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 2/4] fbdev: Move framebuffer_{alloc,release}() functions to fbmem.c
Date:   Fri, 27 Aug 2021 12:05:10 +0200
Message-Id: <20210827100510.1578493-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The framebuffer_alloc() and framebuffer_release() functions are much more
related with the functions in drivers/fbdev/core/fbmem.c than the ones in
drivers/fbdev/core/fbsysfs.c, that are only to manage sysfs attributes.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/core/fbmem.c   | 65 +++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbsysfs.c | 71 ------------------------------
 2 files changed, 65 insertions(+), 71 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d886582c0a4..2b22e46b815 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -57,6 +57,71 @@ bool fb_center_logo __read_mostly;
 
 int fb_logo_count __read_mostly = -1;
 
+/**
+ * framebuffer_alloc - creates a new frame buffer info structure
+ *
+ * @size: size of driver private data, can be zero
+ * @dev: pointer to the device for this fb, this can be NULL
+ *
+ * Creates a new frame buffer info structure. Also reserves @size bytes
+ * for driver private data (info->par). info->par (if any) will be
+ * aligned to sizeof(long).
+ *
+ * Returns the new structure, or NULL if an error occurred.
+ *
+ */
+struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
+{
+#define BYTES_PER_LONG (BITS_PER_LONG/8)
+#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
+	int fb_info_size = sizeof(struct fb_info);
+	struct fb_info *info;
+	char *p;
+
+	if (size)
+		fb_info_size += PADDING;
+
+	p = kzalloc(fb_info_size + size, GFP_KERNEL);
+
+	if (!p)
+		return NULL;
+
+	info = (struct fb_info *) p;
+
+	if (size)
+		info->par = p + fb_info_size;
+
+	info->device = dev;
+	info->fbcon_rotate_hint = -1;
+
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
+	mutex_init(&info->bl_curve_mutex);
+#endif
+
+	return info;
+#undef PADDING
+#undef BYTES_PER_LONG
+}
+EXPORT_SYMBOL(framebuffer_alloc);
+
+/**
+ * framebuffer_release - marks the structure available for freeing
+ *
+ * @info: frame buffer info structure
+ *
+ * Drop the reference count of the device embedded in the
+ * framebuffer info structure.
+ *
+ */
+void framebuffer_release(struct fb_info *info)
+{
+	if (!info)
+		return;
+	kfree(info->apertures);
+	kfree(info);
+}
+EXPORT_SYMBOL(framebuffer_release);
+
 static struct fb_info *get_fb_info(unsigned int idx)
 {
 	struct fb_info *fb_info;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index a040d6bd6c3..2c1e3f0effe 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -5,12 +5,6 @@
  * Copyright (c) 2004 James Simmons <jsimmons@infradead.org>
  */
 
-/*
- * Note:  currently there's only stubs for framebuffer_alloc and
- * framebuffer_release here.  The reson for that is that until all drivers
- * are converted to use it a sysfsification will open OOPSable races.
- */
-
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
@@ -20,71 +14,6 @@
 
 #define FB_SYSFS_FLAG_ATTR 1
 
-/**
- * framebuffer_alloc - creates a new frame buffer info structure
- *
- * @size: size of driver private data, can be zero
- * @dev: pointer to the device for this fb, this can be NULL
- *
- * Creates a new frame buffer info structure. Also reserves @size bytes
- * for driver private data (info->par). info->par (if any) will be
- * aligned to sizeof(long).
- *
- * Returns the new structure, or NULL if an error occurred.
- *
- */
-struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
-{
-#define BYTES_PER_LONG (BITS_PER_LONG/8)
-#define PADDING (BYTES_PER_LONG - (sizeof(struct fb_info) % BYTES_PER_LONG))
-	int fb_info_size = sizeof(struct fb_info);
-	struct fb_info *info;
-	char *p;
-
-	if (size)
-		fb_info_size += PADDING;
-
-	p = kzalloc(fb_info_size + size, GFP_KERNEL);
-
-	if (!p)
-		return NULL;
-
-	info = (struct fb_info *) p;
-
-	if (size)
-		info->par = p + fb_info_size;
-
-	info->device = dev;
-	info->fbcon_rotate_hint = -1;
-
-#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
-	mutex_init(&info->bl_curve_mutex);
-#endif
-
-	return info;
-#undef PADDING
-#undef BYTES_PER_LONG
-}
-EXPORT_SYMBOL(framebuffer_alloc);
-
-/**
- * framebuffer_release - marks the structure available for freeing
- *
- * @info: frame buffer info structure
- *
- * Drop the reference count of the device embedded in the
- * framebuffer info structure.
- *
- */
-void framebuffer_release(struct fb_info *info)
-{
-	if (!info)
-		return;
-	kfree(info->apertures);
-	kfree(info);
-}
-EXPORT_SYMBOL(framebuffer_release);
-
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
-- 
2.31.1

