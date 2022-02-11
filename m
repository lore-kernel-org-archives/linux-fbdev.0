Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FB8C433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348321AbiBKJTo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 04:19:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347151AbiBKJTo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 04:19:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7FED81032
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644571182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x1udgbXGjlzK5bJeoxJIvncbREHU61CgMBl3Cu8KdUg=;
        b=ISL0udd1xVsUzJN8VfYUgcd4Kxx3nsYKlWNPRZ4AcPg248KQDHvn7sGba9ZnQElEbm5wXP
        A52iAaOdVtSWP15cg29j6poaAkKnhOisM+jwMw6N0HD51929mgzhgj5hg1D+3ZqPoj++aB
        P+WCpfxQAJtDF1xTKSw3N2+uUD3J5BQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-PT2DYlisOQe-w3YMi-jV_g-1; Fri, 11 Feb 2022 04:19:41 -0500
X-MC-Unique: PT2DYlisOQe-w3YMi-jV_g-1
Received: by mail-wr1-f69.google.com with SMTP id c9-20020adfa709000000b001dde29c3202so3627589wrd.22
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 01:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1udgbXGjlzK5bJeoxJIvncbREHU61CgMBl3Cu8KdUg=;
        b=qjCYWtCP0L5hwuKID0xw5JRbO7dsFPnVzQGMIdCJ4xxQjkqRgdlwnt1sVB8lKkfAzt
         F+DoSQ+vwWwHRGYTnLfFJu17MGt3b2dOhjZ6DRIfGa39HcpdeoAUKvQSh9X4/DqR0wF+
         gi8H1c9Nzb8jNyEVmnCh9USvOZB1uTRWOcfHP95rnwH2JCMNKpEC19WbUMUlLnbrQKLI
         C+wxsMdvNIxIwdXG4swLFXqBkIjqhNLBAP3htawFTizyr/7lKQ0JaXOlk9+cPPz+1vN6
         HlQb06D62jPzh4LgcSvtO+OyIuTGNJVPDNZX1fC738WQ5B0A57Y2VDTmxAP7vK4BwXYb
         XzxQ==
X-Gm-Message-State: AOAM530kxOqeIhDx5BjWs67+CQid/rFX2qNdI4GOkBPG3Frg0poQ9oEh
        GjCE9lMjEDwB/LfgT0vv31Z0GMXuwI7zcAaWXjyRdrMHW0xIFgKSaw1mp4hm40RQQfkygIW96UC
        SsVfy/bDl4IWIqFMFGz0rEBE=
X-Received: by 2002:a05:6000:1c16:: with SMTP id ba22mr482651wrb.470.1644571180162;
        Fri, 11 Feb 2022 01:19:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9uib9P8LoPw1Bn/AO7SmVcttDX0uIDFWIelsN6+GhZGFYX4rt6mkX1967jjm3xIdkICD8Cw==
X-Received: by 2002:a05:6000:1c16:: with SMTP id ba22mr482637wrb.470.1644571179939;
        Fri, 11 Feb 2022 01:19:39 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r17sm3805578wmq.33.2022.02.11.01.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:19:39 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v4 2/6] drm/format-helper: Add drm_fb_xrgb8888_to_mono_reversed()
Date:   Fri, 11 Feb 2022 10:19:23 +0100
Message-Id: <20220211091927.2988283-3-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211091927.2988283-1-javierm@redhat.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add support to convert from XR24 to reversed monochrome for drivers that
control monochromatic display panels, that only have 1 bit per pixel.

The function does a line-by-line conversion doing an intermediate step
first from XR24 to 8-bit grayscale and then to reversed monochrome.

The drm_fb_gray8_to_mono_reversed_line() helper was based on code from
drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v4:
- Rename end_offset to end_len (Thomas Zimmermann)
- Warn once if dst_pitch is not a multiple of 8 (Thomas Zimmermann)
- Drop drm_fb_gray8_to_mono_reversed() that's not used (Thomas Zimmermann)
- Allocate single buffer for both copy cma memory and gray8 (Thomas Zimmermann)
- Add Thomas Zimmermann Reviewed-by tag to patch adding XR24 -> mono helper.

Changes in v3:
- Also add a drm_fb_xrgb8888_to_mono_reversed() helper (Thomas Zimmermann)
- Split lines copy to drm_fb_gray8_to_mono_reversed_line() (Thomas Zimmermann)
- Handle case where the source buffer is not aligned to 8 (Thomas Zimmermann)

 drivers/gpu/drm/drm_format_helper.c | 107 ++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |   4 ++
 2 files changed, 111 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b981712623d3..ec4e3724ee79 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -591,3 +591,110 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_fb_blit_toio);
+
+static void drm_fb_gray8_to_mono_reversed_line(u8 *dst, const u8 *src, unsigned int pixels,
+					       unsigned int start_offset, unsigned int end_len)
+{
+	unsigned int xb, i;
+
+	for (xb = 0; xb < pixels; xb++) {
+		unsigned int start = 0, end = 8;
+		u8 byte = 0x00;
+
+		if (xb == 0 && start_offset)
+			start = start_offset;
+
+		if (xb == pixels - 1 && end_len)
+			end = end_len;
+
+		for (i = start; i < end; i++) {
+			unsigned int x = xb * 8 + i;
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
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *vaddr,
+				      const struct drm_framebuffer *fb, const struct drm_rect *clip)
+{
+	unsigned int linepixels = drm_rect_width(clip);
+	unsigned int lines = clip->y2 - clip->y1;
+	unsigned int cpp = fb->format->cpp[0];
+	unsigned int len_src32 = linepixels * cpp;
+	unsigned int start_offset, end_len;
+	unsigned int y;
+	u8 *mono = dst, *gray8;
+	u32 *src32;
+
+	if (WARN_ON(fb->format->format != DRM_FORMAT_XRGB8888))
+		return;
+
+	/*
+	 * The reversed mono destination buffer contains 1 bit per pixel
+	 * and destination scanlines have to be in multiple of 8 pixels.
+	 */
+	if (!dst_pitch)
+		dst_pitch = DIV_ROUND_UP(linepixels, 8);
+
+	WARN_ONCE(dst_pitch % 8 != 0, "dst_pitch is not a multiple of 8\n");
+
+	/*
+	 * The cma memory is write-combined so reads are uncached.
+	 * Speed up by fetching one line at a time.
+	 *
+	 * Also, format conversion from XR24 to reversed monochrome
+	 * are done line-by-line but are converted to 8-bit grayscale
+	 * as an intermediate step.
+	 *
+	 * Allocate a buffer to be used for both copying from the cma
+	 * memory and to store the intermediate grayscale line pixels.
+	 */
+	src32 = kmalloc(len_src32 + linepixels, GFP_KERNEL);
+	if (!src32)
+		return;
+
+	gray8 = (u8 *)src32 + len_src32;
+
+	/*
+	 * For damage handling, it is possible that only parts of the source
+	 * buffer is copied and this could lead to start and end pixels that
+	 * are not aligned to multiple of 8.
+	 *
+	 * Calculate if the start and end pixels are not aligned and set the
+	 * offsets for the reversed mono line conversion function to adjust.
+	 */
+	start_offset = clip->x1 % 8;
+	end_len = clip->x2 % 8;
+
+	vaddr += clip_offset(clip, fb->pitches[0], cpp);
+	for (y = 0; y < lines; y++) {
+		src32 = memcpy(src32, vaddr, len_src32);
+		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
+		drm_fb_gray8_to_mono_reversed_line(mono, gray8, dst_pitch,
+						   start_offset, end_len);
+		vaddr += fb->pitches[0];
+		mono += dst_pitch;
+	}
+
+	kfree(src32);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_mono_reversed);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index b30ed5de0a33..0b0937c0b2f6 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -43,4 +43,8 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		     const void *vmap, const struct drm_framebuffer *fb,
 		     const struct drm_rect *rect);
 
+void drm_fb_xrgb8888_to_mono_reversed(void *dst, unsigned int dst_pitch, const void *src,
+				      const struct drm_framebuffer *fb,
+				      const struct drm_rect *clip);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.34.1

