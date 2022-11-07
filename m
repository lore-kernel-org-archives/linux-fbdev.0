Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC7C43217
	for <linux-fbdev@archiver.kernel.org>; Mon,  7 Nov 2022 10:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiKGKtn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiKGKtl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 7 Nov 2022 05:49:41 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF9E4D
        for <linux-fbdev@vger.kernel.org>; Mon,  7 Nov 2022 02:49:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD9DD1F8A3;
        Mon,  7 Nov 2022 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1667818179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wM3/AFEFcKcF+B/LY2TMh5Q6GEobQrFepjDAE7pSm1s=;
        b=BtDFtNj8DALi01doeUVqrLpe4HtbbOII+8H35Y0OWzJyMA7lnW+oWg7JW3nQEBJmSy/J5B
        8zevUrR5IxC9V9evtFZhu/FAaDQ0l9arFEdPrcQ1itcsYYr4EGp3IdiwGqZTGBiLv6NdNg
        E5YoNOozKTDAUPGMVqRAPNsv+06yACI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1667818179;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wM3/AFEFcKcF+B/LY2TMh5Q6GEobQrFepjDAE7pSm1s=;
        b=xKMVARbWxekrSNfxTtML1hj3A/DwnanpdrCksAYyKMJ0K13kTFNVzJd1ODhIWxlEKwomQQ
        6vw6nZX2aSbX7+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A44213ADB;
        Mon,  7 Nov 2022 10:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ILUOIcPiaGPkewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 07 Nov 2022 10:49:39 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm: Move nomodeset kernel parameter to drivers/video
Date:   Mon,  7 Nov 2022 11:49:15 +0100
Message-Id: <20221107104916.18733-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221107104916.18733-1-tzimmermann@suse.de>
References: <20221107104916.18733-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Move the nomodeset kernel parameter to drivers/video to make it
available to non-DRM drivers. Adapt the interface, but keep the DRM
interface drm_firmware_drivers_only() to avoid churn within DRM. The
function should later be inlined into callers.

The parameter disables any DRM graphics driver that would replace a
driver for firmware-provided scanout buffers. It is an option to easily
fallback to basic graphics output if the hardware's native driver is
broken. Moving it to a more prominent location wil make it available
to fbdev as well.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 Documentation/admin-guide/kernel-parameters.txt      |  2 +-
 MAINTAINERS                                          |  2 ++
 drivers/gpu/drm/Kconfig                              |  7 +------
 drivers/gpu/drm/Makefile                             |  1 -
 drivers/video/Kconfig                                |  4 ++++
 drivers/video/Makefile                               |  1 +
 .../{gpu/drm/drm_nomodeset.c => video/nomodeset.c}   | 12 +++++++-----
 include/drm/drm_drv.h                                |  8 +++++++-
 include/video/nomodeset.h                            |  8 ++++++++
 9 files changed, 31 insertions(+), 14 deletions(-)
 rename drivers/{gpu/drm/drm_nomodeset.c => video/nomodeset.c} (63%)
 create mode 100644 include/video/nomodeset.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a465d5242774a..70178c5f53956 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3777,7 +3777,7 @@
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
-	nomodeset	Disable kernel modesetting. DRM drivers will not perform
+	nomodeset	Disable kernel modesetting. Graphics drivers will not perform
 			display-mode changes or accelerated rendering. Only the
 			system framebuffer will be available for use if this was
 			set-up by the firmware or boot loader.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f624e3ef6235..84b008f5aacbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6698,8 +6698,10 @@ F:	drivers/gpu/drm/drm_aperture.c
 F:	drivers/gpu/drm/tiny/ofdrm.c
 F:	drivers/gpu/drm/tiny/simpledrm.c
 F:	drivers/video/aperture.c
+F:	drivers/video/nomodeset.c
 F:	include/drm/drm_aperture.h
 F:	include/linux/aperture.h
+F:	include/video/nomodeset.h
 
 DRM DRIVER FOR SIS VIDEO CARDS
 S:	Orphan / Obsolete
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index f30f99166531f..6b11614aecc5b 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -8,7 +8,6 @@
 menuconfig DRM
 	tristate "Direct Rendering Manager (XFree86 4.1.0 and higher DRI support)"
 	depends on (AGP || AGP=n) && !EMULATED_CMPXCHG && HAS_DMA
-	select DRM_NOMODESET
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select HDMI
 	select FB_CMDLINE
@@ -19,6 +18,7 @@ menuconfig DRM
 # gallium uses SYS_kcmp for os_same_file_description() to de-duplicate
 # device and dmabuf fd. Let's make sure that is available for our userspace.
 	select KCMP
+	select VIDEO_NOMODESET
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
@@ -515,11 +515,6 @@ config DRM_EXPORT_FOR_TESTS
 config DRM_PANEL_ORIENTATION_QUIRKS
 	tristate
 
-# Separate option because nomodeset parameter is global and expected built-in
-config DRM_NOMODESET
-	bool
-	default n
-
 config DRM_LIB_RANDOM
 	bool
 	default n
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index c44a54cadb618..f92cd78927110 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -72,7 +72,6 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += \
 	drm_privacy_screen_x86.o
 obj-$(CONFIG_DRM)	+= drm.o
 
-obj-$(CONFIG_DRM_NOMODESET) += drm_nomodeset.o
 obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 
 #
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0587e21abad94..6d2fde6c5d11a 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -11,6 +11,10 @@ config APERTURE_HELPERS
 	  Support tracking and hand-over of aperture ownership. Required
 	  by graphics drivers for firmware-provided framebuffers.
 
+config VIDEO_NOMODESET
+	bool
+	default n
+
 if HAS_IOMEM
 
 config HAVE_FB_ATMEL
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5bb6b452cc83a..a50eb528ed3c3 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_APERTURE_HELPERS)    += aperture.o
 obj-$(CONFIG_VGASTATE)            += vgastate.o
+obj-$(CONFIG_VIDEO_NOMODESET)     += nomodeset.o
 obj-$(CONFIG_HDMI)                += hdmi.o
 
 obj-$(CONFIG_VT)		  += console/
diff --git a/drivers/gpu/drm/drm_nomodeset.c b/drivers/video/nomodeset.c
similarity index 63%
rename from drivers/gpu/drm/drm_nomodeset.c
rename to drivers/video/nomodeset.c
index f3978d5bd3a1d..13cc8b7196978 100644
--- a/drivers/gpu/drm/drm_nomodeset.c
+++ b/drivers/video/nomodeset.c
@@ -3,17 +3,19 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
-static bool drm_nomodeset;
+#include <video/nomodeset.h>
 
-bool drm_firmware_drivers_only(void)
+static bool video_nomodeset;
+
+bool video_firmware_drivers_only(void)
 {
-	return drm_nomodeset;
+	return video_nomodeset;
 }
-EXPORT_SYMBOL(drm_firmware_drivers_only);
+EXPORT_SYMBOL(video_firmware_drivers_only);
 
 static int __init disable_modeset(char *str)
 {
-	drm_nomodeset = true;
+	video_nomodeset = true;
 
 	pr_warn("Booted with the nomodeset parameter. Only the system framebuffer will be available\n");
 
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb88569..700d3857e0881 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -30,6 +30,8 @@
 #include <linux/list.h>
 #include <linux/irqreturn.h>
 
+#include <video/nomodeset.h>
+
 #include <drm/drm_device.h>
 
 struct drm_file;
@@ -602,6 +604,10 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
 
 int drm_dev_set_unique(struct drm_device *dev, const char *name);
 
-extern bool drm_firmware_drivers_only(void);
+/* TODO: Inline drm_firmware_drivers_only() in all its callers. */
+static inline bool drm_firmware_drivers_only(void)
+{
+	return video_firmware_drivers_only();
+}
 
 #endif
diff --git a/include/video/nomodeset.h b/include/video/nomodeset.h
new file mode 100644
index 0000000000000..8f8688b8beabe
--- /dev/null
+++ b/include/video/nomodeset.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef VIDEO_NOMODESET_H
+#define VIDEO_NOMODESET_H
+
+bool video_firmware_drivers_only(void);
+
+#endif
-- 
2.38.0

