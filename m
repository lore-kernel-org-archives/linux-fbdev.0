Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A91C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Mar 2022 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245562AbiCGUzR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245435AbiCGUzE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Mar 2022 15:55:04 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082533EAF
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Mar 2022 12:53:35 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by laurent.telenet-ops.be with bizsmtp
        id 3YtW2700C1Yj8bA01YtW0X; Mon, 07 Mar 2022 21:53:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLZ-0036Qg-DF; Mon, 07 Mar 2022 21:52:49 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLX-0034ha-Uq; Mon, 07 Mar 2022 21:52:47 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 04/10] drm/framebuffer: Use actual bpp for DRM_IOCTL_MODE_GETFB
Date:   Mon,  7 Mar 2022 21:52:39 +0100
Message-Id: <d87068fd1e2cc6f772a64ba9306350a31baeae58.1646683502.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When userspace queries the properties of a frame buffer, the number of
bits per pixel is derived from the deprecated drm_format_info.cpp[]
field, which does not take into account block sizes.

Fix this by using the actual number of bits per pixel instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - No changes.
---
 drivers/gpu/drm/drm_framebuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index 07f5abc875e97b96..4b9d7b01cb99c03d 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -530,7 +530,7 @@ int drm_mode_getfb(struct drm_device *dev,
 	r->height = fb->height;
 	r->width = fb->width;
 	r->depth = fb->format->depth;
-	r->bpp = fb->format->cpp[0] * 8;
+	r->bpp = drm_format_info_bpp(fb->format, 0);
 	r->pitch = fb->pitches[0];
 
 	/* GET_FB() is an unprivileged ioctl so we must not return a
-- 
2.25.1

