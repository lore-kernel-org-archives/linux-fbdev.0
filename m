Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2845C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 13:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358600AbiBDNoA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240545AbiBDNn5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 4 Feb 2022 08:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643982237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gsCZ0vamCvMedkmFYkO3ZNEjaPZGxukH+BWgq2BQ6do=;
        b=FPCkJfLoTXFM70QKlOy+CvlA6vFVt/7Os16mjJ2Ubn4YVRSYWkZZkOz6PbMglIUfBDZlhc
        vg5Wc8fDybLI5Mgvj0aAfov/3vPB8rD1wY2XqQQgAd+F5aYtdjrslylidwt8ZiRDEfXRtf
        8m0U+iceUUUJD5JHe5SUQZiC0z0nFj0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-bo_bvbRpMnSK8Yb8YV-j3g-1; Fri, 04 Feb 2022 08:43:55 -0500
X-MC-Unique: bo_bvbRpMnSK8Yb8YV-j3g-1
Received: by mail-wr1-f70.google.com with SMTP id c10-20020adfa30a000000b001d79c73b64bso2048995wrb.1
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 05:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsCZ0vamCvMedkmFYkO3ZNEjaPZGxukH+BWgq2BQ6do=;
        b=5Uoue2mkY4F29SzWBhh8xM1s3/uYw19BuzeyBBbE4cgPEJavjuK4F4WvgkRNpwn5NA
         cL0oCklmXB5NzI1csfnRElgbfBvdCQdseRZE5RXp7Ky3eIZXhmrlaNR2hvBzMBlzLUWH
         9fixEd6cCLb9HugrEuoUMxMpZXACiuGdx+iFOLsKmv7lF4rZwVa1grM2QkDyEAdIshlo
         WqK7qTWPiMxyXk+Bvg9cgk1BL4s0ies9KWEcY2rmOny+AMUMOSB3giUudwz+cKTRpcZY
         djqLm7nD2seewowaChFMiuRBaknjTPcbwDzkeOf0otzh1583G/EVAA81zucXhMAqnNg/
         wkRA==
X-Gm-Message-State: AOAM533jgDz0aRwp28nozhVpcjl0VmcaOQqkHkyFr3NVzFjTwSZiP+lq
        Tdt+OY4s9Y8Vn8HjoQele2SnOpf0PK/H715Z+xWhIn2JGSXqsK35dbIS1/xtRE+VwmzD7M7gNEv
        A04noAkuW9cBL59zZK0jB/Vw=
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr2454492wrp.661.1643982234674;
        Fri, 04 Feb 2022 05:43:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwlXexVQP8cfpmjMdMsb00GdG9twKe+Dfe6NJ6PFq21cUefB7/9Y6OdbGzVDbpRhtxvxM4R3Q==
X-Received: by 2002:a5d:64a9:: with SMTP id m9mr2454469wrp.661.1643982234457;
        Fri, 04 Feb 2022 05:43:54 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r3sm1871692wrt.102.2022.02.04.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:43:54 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 1/4] drm/format-helper: Add drm_fb_{xrgb8888,gray8}_to_mono_reversed()
Date:   Fri,  4 Feb 2022 14:43:44 +0100
Message-Id: <20220204134347.1187749-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204134347.1187749-1-javierm@redhat.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add support to convert XR24 and 8-bit grayscale to reversed monochrome for
drivers that control monochromatic panels, that only have 1 bit per pixel.

The drm_fb_gray8_to_mono_reversed() helper was based on the function that
does the same in the drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/gpu/drm/drm_format_helper.c | 80 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  7 +++
 2 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 0f28dd2bdd72..cdce4b7c25d9 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -584,3 +584,83 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_fb_blit_toio);
+
+static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, size_t pixels)
+{
+	unsigned int xb, i;
+
+	for (xb = 0; xb < pixels / 8; xb++) {
+		u8 byte = 0x00;
+
+		for (i = 0; i < 8; i++) {
+			int x = xb * 8 + i;
+
+			byte >>= 1;
+			if (src[x] >> 7)
+				byte |= BIT(7);
+		}
+		*dst++ = byte;
+	}
+}
+
+/**
+ * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
+ * @dst: reversed monochrome destination buffer
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
+ * @src: 8-bit grayscale source buffer
+ * @clip: Clip rectangle area to copy
+ *
+ * DRM doesn't have native monochrome or grayscale support.
+ * Such drivers can announce the commonly supported XR24 format to userspace
+ * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
+ * helper function to convert to the native format.
+ */
+void drm_fb_gray8_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				   const struct drm_rect *clip)
+{
+
+	size_t height = drm_rect_height(clip);
+	size_t width = drm_rect_width(clip);
+	unsigned int y;
+	const u8 *gray8 = src;
+	u8 *mono = dst;
+
+	if (!dst_pitch)
+		dst_pitch = width;
+
+	for (y = 0; y < height; y++) {
+		drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch);
+		mono += (dst_pitch / 8);
+		gray8 += dst_pitch;
+	}
+}
+
+/**
+ * drm_fb_xrgb8888_to_mono_reversed - Convert XRGB8888 to reversed monochrome
+ * @dst: reversed monochrome destination buffer
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
+ * @src: XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ *
+ * DRM doesn't have native monochrome support.
+ * Such drivers can announce the commonly supported XR24 format to userspace
+ * and use this function to convert to the native format.
+ *
+ * This function uses drm_fb_xrgb8888_to_gray8() to convert to grayscale and
+ * then the result is converted from grayscale to reversed monohrome.
+ */
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				      const struct drm_framebuffer *fb,
+				      const struct drm_rect *clip)
+{
+	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
+		return;
+
+	if (!dst_pitch)
+		dst_pitch = drm_rect_width(clip);
+
+	drm_fb_xrgb8888_to_gray8(dst, dst_pitch, src, fb, clip);
+	drm_fb_gray8_to_mono_reversed(dst, dst_pitch, dst, fb, clip);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index b30ed5de0a33..85e551a5cbe6 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -43,4 +43,11 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		     const void *vmap, const struct drm_framebuffer *fb,
 		     const struct drm_rect *rect);
 
+void drm_fb_gray8_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				   const struct drm_rect *clip);
+
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				      const struct drm_framebuffer *fb,
+				      const struct drm_rect *clip);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.34.1

