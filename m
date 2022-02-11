Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5CBC4332F
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Feb 2022 14:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbiBKOeL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Feb 2022 09:34:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350892AbiBKOeK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Feb 2022 09:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72892381
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644590048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wFaIKzYZq5mwoMCRxFCEVoEkMIRZsF+ixkyzhcwnXVQ=;
        b=jD103IZFSCCoX4Cm8PPE/jSLT1L4T7zyxIsJ+xYBEsxeai8vF4io/uM5MlYZGT73AIus31
        hZ6Uslt/QTR+AYM1HXTYmUoMV9v7pBfUby+t3E9rP3Ygipt8Bir+nEO1V1CPoFPCTmX7Va
        UJBwO3P8O3nmInjz2EgfproCImaSRTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-P3Pndn_rMMe93QOyyrh5HA-1; Fri, 11 Feb 2022 09:34:07 -0500
X-MC-Unique: P3Pndn_rMMe93QOyyrh5HA-1
Received: by mail-wm1-f69.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2583661wmb.6
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Feb 2022 06:34:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFaIKzYZq5mwoMCRxFCEVoEkMIRZsF+ixkyzhcwnXVQ=;
        b=bFNKMEFdw3hNb+FgSSpSxT7enuVU5YtMY05HCTxXlVSVYDgckuXD0GQVJom0QDZ5Af
         RQ37tMUo+3GaO5Tcxo8gEGb3FxVSaqafofNX2xWbQYx4RB+ZH1ptFan4QWtYMkL11fnd
         L1Tm1n8o2Lw2d967WlTtvK0btdrmkPFGaXdURvip8ROPVDB13nJLhWvAKvVpXzkmn70L
         8dz0lrsfuOmCSbRJprzpx4+Xx5vLHUvmMuIQ8gjww0Q2HTkX4Gz3FdrpkYN/fUbvPX8h
         RPc0DH4Awr/Y/syr9GoisjwdvPAZJaBHQD22PTJw+bAWq9lpO+vH2nRXPnDWmOSD934M
         DSeQ==
X-Gm-Message-State: AOAM531U98hk0BBS/U+aHFtXxD0lyTbXgGkwtPtRfdFc0E0YC5tU/D6y
        cVXS7C7NiWiWAD6HceEM9Fkeg0FZIZBa4UQ4a8AOamOBRy9oRBEmwNmlhJ5qnRraqabJXS7Ye0E
        EOCKZB/T61clGyumLTOUL1gg=
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr498430wmg.111.1644590046169;
        Fri, 11 Feb 2022 06:34:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhPexpHfSetxE0S3/Tn4IvNqI07iQUkmyj562tzbxdGmYsFTdsPjtNvRQ7u4RPguUGeK9nwg==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr498413wmg.111.1644590045932;
        Fri, 11 Feb 2022 06:34:05 -0800 (PST)
Received: from minerva.redhat.com ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o14sm24616012wry.104.2022.02.11.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:34:05 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 1/6] drm/format-helper: Add drm_fb_xrgb8888_to_gray8_line()
Date:   Fri, 11 Feb 2022 15:33:53 +0100
Message-Id: <20220211143358.3112958-2-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220211143358.3112958-1-javierm@redhat.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
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
---

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

