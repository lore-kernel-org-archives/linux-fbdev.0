Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC088C67871
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 15:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjAKPlw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjAKPlg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974202E0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso8174274wms.4
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dVHGsRGAtc8yC6r+7bI8QFfhEvYdoERWC1PQCrm1tw=;
        b=I4+Xr0vcrHPi2zx8cnusy5qj5UkH4ZEMi/VSE9jNNkYnEsukNwrnfB9Iurz3G5dgcf
         76QuwtxZbjRwvvCqspLSFHr8XB3P1q2RF2Y5eWrxoFMskwYTX1IWSdJ6WiZU1henB7u7
         962tRp+8jbVpmWIs5v3fymXrn6cX2yJfS+ahs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dVHGsRGAtc8yC6r+7bI8QFfhEvYdoERWC1PQCrm1tw=;
        b=T1/8V5/V78vlb7R+RGDDtQTPBDoMlgoM0RSHDUm9moqhZLKPoBhHSruQahFH0rskZw
         ssIbQeQq5D3bS9gx/unJZ8QeEPy3ZFbpeTEIqfU7nlJQtoZ3iKmCbMz3qGe5yT+v+DV1
         /jIGBiLgiZFffxBqxnNiBLXQhJCn8L0cfdDaP3EURovhiJGZs/o4modFLIkTXst4L7bW
         b2YjmLbR3+ViIzRYlZUCHrrH8inAvr8rEkBlct0TjlPDZv1iIgPsJLyQfFjKFnJldHbf
         2RGRK4XIkJEGPB7pZbP2rXsMbT39os8eDig4AQlqARBKdk9+vngQ4/RrlnJY0otb65mD
         gR1g==
X-Gm-Message-State: AFqh2krpHYCVZZkQgeIOAOUXFAO4q5nDnnGAPeqEnwZMRJk7xtSYTxh3
        fosepNWGtpPJEfflxFVgxUABbg==
X-Google-Smtp-Source: AMrXdXvdiLsi4d/83lNa5SYYvtdYD0duEsEs1acqx+5zQwLQxSDtPPplhJfZOW7rOwY+MD6kGrfBcw==
X-Received: by 2002:a05:600c:1c20:b0:3d2:2f48:9443 with SMTP id j32-20020a05600c1c2000b003d22f489443mr52172779wms.15.1673451694167;
        Wed, 11 Jan 2023 07:41:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:33 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 10/11] video/aperture: Drop primary argument
Date:   Wed, 11 Jan 2023 16:41:11 +0100
Message-Id: <20230111154112.90575-10-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

With the preceeding patches it's become defunct. Also I'm about to add
a different boolean argument, so it's better to keep the confusion
down to the absolute minimum.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/drm/drm_aperture.c | 2 +-
 drivers/video/aperture.c       | 7 +++----
 include/linux/aperture.h       | 9 ++++-----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_aperture.c b/drivers/gpu/drm/drm_aperture.c
index 697cffbfd603..5729f3bb4398 100644
--- a/drivers/gpu/drm/drm_aperture.c
+++ b/drivers/gpu/drm/drm_aperture.c
@@ -168,7 +168,7 @@ EXPORT_SYMBOL(devm_aperture_acquire_from_firmware);
 int drm_aperture_remove_conflicting_framebuffers(resource_size_t base, resource_size_t size,
 						 const struct drm_driver *req_driver)
 {
-	return aperture_remove_conflicting_devices(base, size, false, req_driver->name);
+	return aperture_remove_conflicting_devices(base, size, req_driver->name);
 }
 EXPORT_SYMBOL(drm_aperture_remove_conflicting_framebuffers);
 
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 03f8a5e95238..ba565515480d 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -43,7 +43,7 @@
  *		base = mem->start;
  *		size = resource_size(mem);
  *
- *		ret = aperture_remove_conflicting_devices(base, size, false, "example");
+ *		ret = aperture_remove_conflicting_devices(base, size, "example");
  *		if (ret)
  *			return ret;
  *
@@ -274,7 +274,6 @@ static void aperture_detach_devices(resource_size_t base, resource_size_t size)
  * aperture_remove_conflicting_devices - remove devices in the given range
  * @base: the aperture's base address in physical memory
  * @size: aperture size in bytes
- * @primary: also kick vga16fb if present; only relevant for VGA devices
  * @name: a descriptive name of the requesting driver
  *
  * This function removes devices that own apertures within @base and @size.
@@ -283,7 +282,7 @@ static void aperture_detach_devices(resource_size_t base, resource_size_t size)
  * 0 on success, or a negative errno code otherwise
  */
 int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-					bool primary, const char *name)
+					const char *name)
 {
 	/*
 	 * If a driver asked to unregister a platform device registered by
@@ -328,7 +327,7 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 
 		base = pci_resource_start(pdev, bar);
 		size = pci_resource_len(pdev, bar);
-		ret = aperture_remove_conflicting_devices(base, size, primary, name);
+		ret = aperture_remove_conflicting_devices(base, size, name);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/aperture.h b/include/linux/aperture.h
index 442f15a57cad..7248727753be 100644
--- a/include/linux/aperture.h
+++ b/include/linux/aperture.h
@@ -14,7 +14,7 @@ int devm_aperture_acquire_for_platform_device(struct platform_device *pdev,
 					      resource_size_t size);
 
 int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-					bool primary, const char *name);
+					const char *name);
 
 int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *name);
 #else
@@ -26,7 +26,7 @@ static inline int devm_aperture_acquire_for_platform_device(struct platform_devi
 }
 
 static inline int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
-						      bool primary, const char *name)
+						      const char *name)
 {
 	return 0;
 }
@@ -39,7 +39,6 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
 
 /**
  * aperture_remove_all_conflicting_devices - remove all existing framebuffers
- * @primary: also kick vga16fb if present; only relevant for VGA devices
  * @name: a descriptive name of the requesting driver
  *
  * This function removes all graphics device drivers. Use this function on systems
@@ -48,9 +47,9 @@ static inline int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev,
  * Returns:
  * 0 on success, or a negative errno code otherwise
  */
-static inline int aperture_remove_all_conflicting_devices(bool primary, const char *name)
+static inline int aperture_remove_all_conflicting_devices(const char *name)
 {
-	return aperture_remove_conflicting_devices(0, (resource_size_t)-1, primary, name);
+	return aperture_remove_conflicting_devices(0, (resource_size_t)-1, name);
 }
 
 #endif
-- 
2.39.0

