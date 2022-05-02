Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48736C433FE
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 May 2022 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbiEBI4h (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 May 2022 04:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383904AbiEBI4g (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 May 2022 04:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4598926132
        for <linux-fbdev@vger.kernel.org>; Mon,  2 May 2022 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651481587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RFdAbAFC6hVBQLu+NPQWCbO+3EFmV4d5chrstqJm+WU=;
        b=PekSMZ3zNgaAGaDR1kR8bSece3TILM9d+pnh1BCj6lHRl79GNCwjmueHClPAG3sed2+C+D
        x+bB4gOJXYH+QHUT9IBbMoCr8W7OMlcNokABEUxK3EtaKcLYt9LsLm2+NzQJ8Vhd7IvTJR
        hqQdntPUs+Qq6Nf/ybbhGvRyyJ8lgCc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Ag_4P-rcOPmkqTdEB3-zSw-1; Mon, 02 May 2022 04:53:06 -0400
X-MC-Unique: Ag_4P-rcOPmkqTdEB3-zSw-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020adfa387000000b0020acc61dbaeso5150338wrb.7
        for <linux-fbdev@vger.kernel.org>; Mon, 02 May 2022 01:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFdAbAFC6hVBQLu+NPQWCbO+3EFmV4d5chrstqJm+WU=;
        b=aIj3RlXNvDk88VGE3b3tmankhGnNmvFGwYimfmo+0UJCywHgZjUvxU2UVJozEkQyST
         wgERfBQsDoxz5fv6kbW8TdfexIRI7vkSm0Bys946ZcuctJcO8xXoaYHcWtfgLYOFBkqj
         gWjvmV56DbUr+s5bN5ymZxOjNzT05fAHWodlib4i7/GnVucHVmG2P6OC9KKBsKAEj6F4
         SsW+XcXvmcXwXfG0VTqLhLQtX+K54BOh7OL5wFI/uajL5LgUuldPmIEaGXzELq0PlkQu
         LOtMoXSirRBMhutEIRuAln2NRoEweBSIcPIw0udN0c50ndT+oHFP2itEsuC3Jr7/KjiX
         nSyw==
X-Gm-Message-State: AOAM532ZGw9civgcTIR07kxuDpY4g47dEwZsq+UGx3PNQUZbhYRWnkGC
        I70yGbCWCg3Ih2NXI51jAiSc3FJrohrG+2SRqozIRQPDe5zz1Z/kYc0xA5dovWA+Vzd/V59yzKt
        KIEz1sCypjLpyT7aohFS1Kss=
X-Received: by 2002:a05:600c:6022:b0:394:3943:dd61 with SMTP id az34-20020a05600c602200b003943943dd61mr4082568wmb.196.1651481585095;
        Mon, 02 May 2022 01:53:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwAdCi1b+GagstF4L/akza3x40XLpRMN8KNh6WPEAQN0F84cne1/xuXbVNcY/l5tbIzjtp6A==
X-Received: by 2002:a05:600c:6022:b0:394:3943:dd61 with SMTP id az34-20020a05600c602200b003943943dd61mr4082552wmb.196.1651481584883;
        Mon, 02 May 2022 01:53:04 -0700 (PDT)
Received: from minerva.. ([90.167.94.74])
        by smtp.gmail.com with ESMTPSA id c1-20020adfc041000000b0020c5253d8desm6823400wrf.42.2022.05.02.01.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 01:53:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH 3/3] drm: Allow simpledrm to setup its emulated FB as firmware provided
Date:   Mon,  2 May 2022 10:52:59 +0200
Message-Id: <20220502085259.286590-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502084830.285639-1-javierm@redhat.com>
References: <20220502084830.285639-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Indicate to fbdev subsystem that the registered framebuffer is provided by
the system firmware, so that it can handle accordingly. For example, would
unregister the FB devices if asked to remove the conflicting framebuffers.

Add a new DRM_FB_FW field to drm_fbdev_generic_setup() options parameter.
Drivers can use this to indicate the FB helper initialization that the FB
registered is provided by the firmware, so it can be configured as such.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_fb_helper.c  |  9 +++++++++
 drivers/gpu/drm/tiny/simpledrm.c |  2 +-
 include/drm/drm_fb_helper.h      | 10 ++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index f626947bb9b9..c2ff986f064d 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -1891,6 +1891,10 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper,
 		/* don't leak any physical addresses to userspace */
 		info->flags |= FBINFO_HIDE_SMEM_START;
 
+	/* Indicate that the framebuffer is provided by the firmware */
+	if (fb_helper->firmware)
+		info->flags |= FBINFO_MISC_FIRMWARE;
+
 	/* Need to drop locks to avoid recursive deadlock in
 	 * register_framebuffer. This is ok because the only thing left to do is
 	 * register the fbdev emulation instance in kernel_fb_helper_list. */
@@ -2511,6 +2515,8 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  *
  * * DRM_FB_BPP: bits per pixel for the device. If the field is not set,
  *               @dev->mode_config.preferred_depth is used instead.
+ * * DRM_FB_FW:  if the framebuffer for the device is provided by the
+ *               system firmware.
  *
  * This function sets up generic fbdev emulation for drivers that supports
  * dumb buffers with a virtual address and that can be mmap'ed.
@@ -2537,6 +2543,7 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
 {
 	struct drm_fb_helper *fb_helper;
 	unsigned int preferred_bpp = DRM_FB_GET_OPTION(DRM_FB_BPP, options);
+	bool firmware = DRM_FB_GET_OPTION(DRM_FB_FW, options);
 	int ret;
 
 	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
@@ -2569,6 +2576,8 @@ void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int options)
 		preferred_bpp = 32;
 	fb_helper->preferred_bpp = preferred_bpp;
 
+	fb_helper->firmware = firmware;
+
 	ret = drm_fbdev_client_hotplug(&fb_helper->client);
 	if (ret)
 		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index f5b8e864a5cd..5dcc21ea6180 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -901,7 +901,7 @@ static int simpledrm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_generic_setup(dev, DRM_FB_SET_OPTION(DRM_FB_FW, 1));
 
 	return 0;
 }
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 1da3ef76f499..0eec500e0784 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -44,6 +44,7 @@ enum mode_set_atomic {
 };
 
 #define DRM_FB_BPP_MASK GENMASK(7, 0)
+#define DRM_FB_FW_MASK GENMASK(8, 8)
 
 /* Using the GNU statement expression extension */
 #define DRM_FB_SET_OPTION(option, value)			\
@@ -197,6 +198,15 @@ struct drm_fb_helper {
 	 * See also: @deferred_setup
 	 */
 	int preferred_bpp;
+
+	/**
+	 * @firmware:
+	 *
+	 * Set if the driver indicates to the FB helper initialization that the
+	 * framebuffer for the device being registered is provided by firmware,
+	 * so that it can pass this on when registering the framebuffer device.
+	 */
+	bool firmware;
 };
 
 static inline struct drm_fb_helper *
-- 
2.35.1

