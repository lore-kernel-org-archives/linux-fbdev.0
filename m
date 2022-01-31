Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CA5C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 20:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378097AbiAaUMt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 15:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24532 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378229AbiAaUMq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 15:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643659965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vM3bdlw6HomnmKXTkmUtit4bHCKLqTmZACNhurI9HbE=;
        b=J1zjzZjmXbOeesI86OFEXW97UgR7iYiY32bCJy43g8WV0rsORx/SSzvpFi/gzn8UU+JXDh
        hwF0Bgdy4hhxH1SXQwCosQJTyleNmFxrBgmSYvURZbQUquOegrM0agsf8YKt13mfTjyMc/
        ied+irhL7jQ/Suu0T37reYVyAhyo48I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-yVXwJVlfPiuNNEe-Xr-Ydw-1; Mon, 31 Jan 2022 15:12:42 -0500
X-MC-Unique: yVXwJVlfPiuNNEe-Xr-Ydw-1
Received: by mail-wm1-f71.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso81176wmb.6
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 12:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM3bdlw6HomnmKXTkmUtit4bHCKLqTmZACNhurI9HbE=;
        b=vcYFFhKYPZa/yd/1yPUPvzTSyzr0laSu2qzP3JE6duHGZbSJMzo9ZlkJsCAVTYKZHm
         9/50RZ9djgtGppHdQiDn3Lu+DPxdzG/fsN+VkzFRJ1186yiJL/Z1GXWDLHtaC1JsTb8U
         r2apYvEmhfVKTeSq2rscjTLRCHW3illw+rR+oysJWjJtuYaNdKyprOid6cV2SCupCctS
         gb1Ls9qv85X4Yu5Ho8oVahtczcYN4US9dJqmhryu7UNWycp7OnPQA8YimfF2LZtIq79i
         gLtw4FlHBpyrcqC9HyH9raPXon8PDwxgs7HUduDBsc8G/bB61mC5tgna8Wo/k+lVsW02
         fe5Q==
X-Gm-Message-State: AOAM5320Q8hJB/3Dxf4FlHknUktB9QOoBms7Tl28Ij7GEnEh+OHNDFeq
        Ho5T1HRqGMV1xcEzUr0fwhUKCsHWHieB/HwYK+z69XCPodr23IcPxKFOwrOOLvsqLACsgMiCbem
        mglzByyTRnMj0B2HY59M0lU0=
X-Received: by 2002:adf:f784:: with SMTP id q4mr19229420wrp.59.1643659960634;
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3Q9aJyDDEzKcgl6ZRCOab6CbkULBPR+XNfldCqUZBAmgsUN/1rCzA6CjueKUxmVTW7C4q8w==
X-Received: by 2002:adf:f784:: with SMTP id q4mr19229412wrp.59.1643659960459;
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i9sm15124660wry.32.2022.01.31.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:12:40 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] drm/format-helper: Add drm_fb_gray8_to_mono_reversed()
Date:   Mon, 31 Jan 2022 21:12:22 +0100
Message-Id: <20220131201225.2324984-3-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131201225.2324984-1-javierm@redhat.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add support to convert 8-bit grayscale to reversed monochrome for drivers
that control monochromatic displays, that only have 1 bit per pixel depth.

This helper function was based on repaper_gray8_to_mono_reversed() from
the drivers/gpu/drm/tiny/repaper.c driver.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_format_helper.c | 35 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 0f28dd2bdd72..bf477c136082 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -584,3 +584,38 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_fb_blit_toio);
+
+/**
+ * drm_fb_gray8_to_mono_reversed - Convert grayscale to reversed monochrome
+ * @dst: reversed monochrome destination buffer
+ * @src: 8-bit grayscale source buffer
+ * @clip: Clip rectangle area to copy
+ *
+ * DRM doesn't have native monochrome or grayscale support.
+ * Such drivers can announce the commonly supported XR24 format to userspace
+ * and use drm_fb_xrgb8888_to_gray8() to convert to grayscale and then this
+ * helper function to convert to the native format.
+ */
+void drm_fb_gray8_to_mono_reversed(void *dst, void *src, const struct drm_rect *clip)
+{
+	size_t width = drm_rect_width(clip);
+	size_t height = drm_rect_width(clip);
+
+	u8 *mono = dst, *gray8 = src;
+	unsigned int y, xb, i;
+
+	for (y = 0; y < height; y++)
+		for (xb = 0; xb < width / 8; xb++) {
+			u8 byte = 0x00;
+
+			for (i = 0; i < 8; i++) {
+				int x = xb * 8 + i;
+
+				byte >>= 1;
+				if (gray8[y * width + x] >> 7)
+					byte |= BIT(7);
+			}
+			*mono++ = byte;
+		}
+}
+EXPORT_SYMBOL(drm_fb_gray8_to_mono_reversed);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index b30ed5de0a33..cd4c8b7c78de 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -43,4 +43,6 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		     const void *vmap, const struct drm_framebuffer *fb,
 		     const struct drm_rect *rect);
 
+void drm_fb_gray8_to_mono_reversed(void *dst, void *vaddr, const struct drm_rect *clip);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.34.1

