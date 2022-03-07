Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1355BC4332F
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Mar 2022 20:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245262AbiCGUxx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242590AbiCGUxw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Mar 2022 15:53:52 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48B1CFEA
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Mar 2022 12:52:56 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6100:2d37:4115:c358])
        by xavier.telenet-ops.be with bizsmtp
        id 3Ysq2700J1Yj8bA01Ysq8m; Mon, 07 Mar 2022 21:52:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLY-0036Qf-Bk; Mon, 07 Mar 2022 21:52:48 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nRKLX-0034hT-Tz; Mon, 07 Mar 2022 21:52:47 +0100
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
Subject: [PATCH v2 03/10] drm/client: Use actual bpp when allocating frame buffers
Date:   Mon,  7 Mar 2022 21:52:38 +0100
Message-Id: <8f29a983d42d9d68bd8cae2f9481d3c139f8750a.1646683502.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646683502.git.geert@linux-m68k.org>
References: <cover.1646683502.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When allocating a frame buffer, the number of bits per pixel needed is
derived from the deprecated drm_format_info.cpp[] field.  While this
works for formats using less than 8 bits per pixel, it does lead to a
large overallocation.

Reduce memory consumption by using the actual number of bits per pixel
instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
v2:
  - Add Acked-by.
---
 drivers/gpu/drm/drm_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_client.c
index ce45e380f4a2028f..c6a279e3de95591a 100644
--- a/drivers/gpu/drm/drm_client.c
+++ b/drivers/gpu/drm/drm_client.c
@@ -264,7 +264,7 @@ drm_client_buffer_create(struct drm_client_dev *client, u32 width, u32 height, u
 
 	dumb_args.width = width;
 	dumb_args.height = height;
-	dumb_args.bpp = info->cpp[0] * 8;
+	dumb_args.bpp = drm_format_info_bpp(info, 0);
 	ret = drm_mode_create_dumb(dev, &dumb_args, client->file);
 	if (ret)
 		goto err_delete;
@@ -372,7 +372,7 @@ static int drm_client_buffer_addfb(struct drm_client_buffer *buffer,
 	int ret;
 
 	info = drm_format_info(format);
-	fb_req.bpp = info->cpp[0] * 8;
+	fb_req.bpp = drm_format_info_bpp(info, 0);
 	fb_req.depth = info->depth;
 	fb_req.width = width;
 	fb_req.height = height;
-- 
2.25.1

