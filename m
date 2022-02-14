Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D069C4321E
	for <linux-fbdev@archiver.kernel.org>; Mon, 14 Feb 2022 13:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354331AbiBNNhq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 14 Feb 2022 08:37:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354314AbiBNNhp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 14 Feb 2022 08:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB975575F4
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644845856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PMJPygyk+q6IKiko2o+GbGpYNTzAZFXYDjw6FkGxW+0=;
        b=XcUSKBRxIZc8J6dipz0W+R/Oe5/cU69hgAH3vBwrQYbaRnopUtY6iHfaHKKG0cF6UI6u4B
        75xz4rW7nDNytaZ6xzLIGwHNGk0+3zzRGCIbsJ9eRhp2zUb6QWpC5bm/KwqQABw08YYvoK
        mJ+Itc591TO7E+hoYFfRWCQT6K99BBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-bgcmzn7NMEym__IDUdKfGg-1; Mon, 14 Feb 2022 08:37:35 -0500
X-MC-Unique: bgcmzn7NMEym__IDUdKfGg-1
Received: by mail-wr1-f72.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so6916627wrg.19
        for <linux-fbdev@vger.kernel.org>; Mon, 14 Feb 2022 05:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMJPygyk+q6IKiko2o+GbGpYNTzAZFXYDjw6FkGxW+0=;
        b=561MSDUdPhucVbHXltFjaqQHbM0Wzht9Ttw7+oHuR8D/Y3MWB3tk9PFBygQluiXVSx
         sqzbJS+zFw/ywOTwOyuJXgk+nq6kQ5VHtoYNk2NQ77SZ1sFNqG+X5iFzTzG7TsWW4TBX
         8gYRCN+ir9PHLd8loN7MNUNw60oeL/9+ZdgXJ/ZGKuOiqCNpmRKU24nmRtRAecboLYwJ
         2wrGAJGTfJwQuPF03lLx5BvosAJnJ0gY4m0qL/tAM6PNk8dSPlpITZP4jmcOJXyc0s81
         BDaoamM/LeZZ5m2RJ2CrMANUdxmBUlZnB8vjNcfZdziujbas8ill81sbP7g6YFqRypk+
         XwFw==
X-Gm-Message-State: AOAM5320zvGEvSyF4dJYUnRxchs1fus9cOSg/xIQ2E8LttOeWvNrt7Xh
        5Q1/NybfqQ6dt9dzd4CqLm+cTKr99ky52UGaKwvPZMUh9aYGP+13/UGu6lmyahSV+6UNMGQgdHK
        mj2y0IWpjFvRgRtR6yXP8+hE=
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr11405616wmm.102.1644845854447;
        Mon, 14 Feb 2022 05:37:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWrzaW0LQ9WRQkaVll0CUJhsj6kJUqQPxu24pAAdfApfjJNXNN9XDBh1yuBXccEzAh4eXAIw==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr11405587wmm.102.1644845854167;
        Mon, 14 Feb 2022 05:37:34 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6sm3568918wrd.30.2022.02.14.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 05:37:33 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v6 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Mon, 14 Feb 2022 14:37:05 +0100
Message-Id: <20220214133710.3278506-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
References: <20220214133710.3278506-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Pull the per-line conversion logic into a separate helper function.

This will allow to do line-by-line conversion in other helpers that
convert to a gray8 format.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Changes in v6:
- Add Andy Shevchenko's Reviewed-by to patch #1.

Changes in v5:
- Add Thomas Zimmermann's Reviewed-by to patch #1.

Changes in v3:
- Add a drm_fb_xrgb8888_to_gray8_line() helper function (Thomas Zimmermann)

 drivers/gpu/drm/drm_format_helper.c | 31 ++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 0f28dd2bdd72..b981712623d3 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -464,6 +464,21 @@ void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 
+static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
+{
+	unsigned int x;
+
+	for (x = 0; x < pixels; x++) {
+		u8 r = (*src & 0x00ff0000) >> 16;
+		u8 g = (*src & 0x0000ff00) >> 8;
+		u8 b =  *src & 0x000000ff;
+
+		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
+		*dst++ = (3 * r + 6 * g + b) / 10;
+		src++;
+	}
+}
+
 /**
  * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
  * @dst: 8-bit grayscale destination buffer
@@ -484,8 +499,9 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
 			      const struct drm_framebuffer *fb, const struct drm_rect *clip)
 {
-	unsigned int len = (clip->x2 - clip->x1) * sizeof(u32);
-	unsigned int x, y;
+	unsigned int linepixels = clip->x2 - clip->x1;
+	unsigned int len = linepixels * sizeof(u32);
+	unsigned int y;
 	void *buf;
 	u8 *dst8;
 	u32 *src32;
@@ -508,16 +524,7 @@ void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vad
 	for (y = clip->y1; y < clip->y2; y++) {
 		dst8 = dst;
 		src32 = memcpy(buf, vaddr, len);
-		for (x = clip->x1; x < clip->x2; x++) {
-			u8 r = (*src32 & 0x00ff0000) >> 16;
-			u8 g = (*src32 & 0x0000ff00) >> 8;
-			u8 b =  *src32 & 0x000000ff;
-
-			/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
-			*dst8++ = (3 * r + 6 * g + b) / 10;
-			src32++;
-		}
-
+		drm_fb_xrgb8888_to_gray8_line(dst8, src32, linepixels);
 		vaddr += fb->pitches[0];
 		dst += dst_pitch;
 	}
-- 
2.34.1

