Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C77C001B0
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 Jul 2023 17:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjGNRSK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 Jul 2023 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236025AbjGNRRv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 Jul 2023 13:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108835A9
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689355020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxx5TTk5lZu9HJvHT+E7YQeM4QywQCqf8gUUxBZGqhw=;
        b=Lmh1otN0hWeyPiKtTf8EJ4urNfp2D4CM9Zu3UcpNpzH006qRpghfwh9SH8hVPSn1poroSB
        REHQBZT6KpvBUixkF0aLAP/iMeE/Rpx3hZsrHM+WVa+efrIhyYRJscZuVOD5jsUirIYZZi
        49jQdoODr04m04X3cKsd50SNwBoB700=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-2CcdUf-3M_W_zm2ZyPibug-1; Fri, 14 Jul 2023 13:16:58 -0400
X-MC-Unique: 2CcdUf-3M_W_zm2ZyPibug-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso11942145e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 10:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355017; x=1691947017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxx5TTk5lZu9HJvHT+E7YQeM4QywQCqf8gUUxBZGqhw=;
        b=D5AiHfBN5o0SXPta2vJAB1FkKGwi2c1f+i913v6ON+gSIt3Gkia7clIrazAftHQMGz
         lxvIWHIZ5ZsLa/WAeRlFpP/wydGP1Z++nD460PJFvDSqJxcLdnFCakJnDfmgSpjGu6N1
         oghJ+PbzNr/OW2SE/DIIrv81LEwBDuq2qZO6iZjs4vp4lr1YARkHcfGK8W6dIQsvu3tK
         0JuR+psNNjIal9/XXnglV5rwHXXFijv8kaCiN3I4VCUrL2e2FZdSwALikMon8EdeiBTu
         NGE0hC3LcEPM6oAfrpIT2BmHFa0FshMmGohg4Jbz0/gEc2WEvPflM91WPl3UGbMupSQH
         WhNA==
X-Gm-Message-State: ABy/qLYKmCye/c2I2F4Ddc9qZuXTjB22wQzLmfbX4I1pdTpRPs631+nb
        vIR7YHOXZvMgvmyptBZ/p1VmVsoI+td5/38J/otcNt4JayZeDfS4a4FEemCeJse6z/Mn56QTOJC
        ASv21+FBEiI2/g8yeq0EPCUU=
X-Received: by 2002:adf:e48e:0:b0:313:f463:9d40 with SMTP id i14-20020adfe48e000000b00313f4639d40mr4564544wrm.65.1689355017307;
        Fri, 14 Jul 2023 10:16:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGwyCdBjTkBOP6jxIu0o9kySHnKcHg8Cb95vIb/S98vkTaKyn9xLArsSZI8Nxr4LvszQCTOiA==
X-Received: by 2002:adf:e48e:0:b0:313:f463:9d40 with SMTP id i14-20020adfe48e000000b00313f4639d40mr4564526wrm.65.1689355017078;
        Fri, 14 Jul 2023 10:16:57 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adfe891000000b003143cdc5949sm11620842wrm.9.2023.07.14.10.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 10:16:56 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v5 3/4] fbdev: Split frame buffer support in FB and FB_CORE symbols
Date:   Fri, 14 Jul 2023 19:16:31 +0200
Message-ID: <20230714171642.91185-4-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714171642.91185-1-javierm@redhat.com>
References: <20230714171642.91185-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
drivers are needed (e.g: only to have support for framebuffer consoles).

The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
and so it can only be enabled if that dependency is enabled as well.

That means fbdev drivers have to be explicitly disabled if users want to
enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.

This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
allowing CONFIG_FB to be disabled (and automatically disabling all the
fbdev drivers).

Nothing from fb_backlight.o and fbmon.o is used by the DRM fbdev emulation
layer so these two objects can be compiled out when CONFIG_FB is disabled.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

Changes in v5:
- Fix ifdef guard check in drivers/video/backlight/backlight.c (Arnd Bergmann).

Changes in v4:
- Fix menuconfig hierarchy that was broken in v3 (Arnd Bergmann).

Changes in v3:
- Really make a hidden symbol by removing the prompt (Arnd Bergmann).
- Change FB_CORE to config instead of menuconfig (Arnd Bergmann).
- Keep "depends on FB" for FIRMWARE_EDID (Arnd Bergmann).
- Compile out fb_backlight.o and fbmon.o that are only needed for FB
  (Arnd Bergmann).
- Make FB_DEVICE to depend on FB_CORE instead of selecting it.

Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).

 arch/x86/Makefile                   |  2 +-
 arch/x86/video/Makefile             |  2 +-
 drivers/video/backlight/backlight.c |  6 +++---
 drivers/video/console/Kconfig       |  2 +-
 drivers/video/fbdev/Kconfig         | 10 ++++++++--
 drivers/video/fbdev/core/Kconfig    | 30 ++++++++++++++++-------------
 drivers/video/fbdev/core/Makefile   |  8 ++++----
 7 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c03..89a02e69be5f 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -259,7 +259,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
 # suspend and hibernation support
 drivers-$(CONFIG_PM) += arch/x86/power/
 
-drivers-$(CONFIG_FB) += arch/x86/video/
+drivers-$(CONFIG_FB_CORE) += arch/x86/video/
 
 ####
 # boot loader support. Several targets are kept for legacy purposes
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 11640c116115..5ebe48752ffc 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FB)               += fbdev.o
+obj-$(CONFIG_FB_CORE)		+= fbdev.o
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 9a885d398c22..86e1cdc8e369 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -79,8 +79,8 @@ static const char *const backlight_scale_types[] = {
 	[BACKLIGHT_SCALE_NON_LINEAR]	= "non-linear",
 };
 
-#if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
-			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
+#if defined(CONFIG_FB_CORE) || (defined(CONFIG_FB_CORE_MODULE) && \
+				defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
 /*
  * fb_notifier_callback
  *
@@ -155,7 +155,7 @@ static inline int backlight_register_fb(struct backlight_device *bd)
 static inline void backlight_unregister_fb(struct backlight_device *bd)
 {
 }
-#endif /* CONFIG_FB */
+#endif /* CONFIG_FB_CORE */
 
 static void backlight_generate_event(struct backlight_device *bd,
 				     enum backlight_update_reason reason)
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index a2a88d42edf0..1b5a319971ed 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -72,7 +72,7 @@ config DUMMY_CONSOLE_ROWS
 
 config FRAMEBUFFER_CONSOLE
 	bool "Framebuffer Console support"
-	depends on FB && !UML
+	depends on FB_CORE && !UML
 	select VT_HW_CONSOLE_BINDING
 	select CRC32
 	select FONT_SUPPORT
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ec4068abeb8e..7e65a648f71a 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -4,9 +4,9 @@
 #
 
 menuconfig FB
-	tristate "Support for frame buffer devices"
+	tristate "Support for frame buffer device drivers"
+	select FB_CORE
 	select FB_NOTIFY
-	select VIDEO_CMDLINE
 	help
 	  The frame buffer device provides an abstraction for the graphics
 	  hardware. It represents the frame buffer of some video hardware and
@@ -30,6 +30,12 @@ menuconfig FB
 	  <http://www.munted.org.uk/programming/Framebuffer-HOWTO-1.3.html> for more
 	  information.
 
+	  This enables support for native frame buffer device (fbdev) drivers.
+
+	  The DRM subsystem provides support for emulated frame buffer devices
+	  on top of KMS drivers, but this option allows legacy fbdev drivers to
+	  be enabled as well.
+
 	  Say Y here and to the driver for your graphics board below if you
 	  are compiling a kernel for a non-x86 architecture.
 
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index 8e308d12c57b..15ce529d579a 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -3,6 +3,10 @@
 # fbdev core configuration
 #
 
+config FB_CORE
+	select VIDEO_CMDLINE
+	tristate
+
 config FB_NOTIFY
 	bool
 
@@ -23,7 +27,7 @@ config FIRMWARE_EDID
 
 config FB_DEVICE
 	bool "Provide legacy /dev/fb* device"
-	depends on FB
+	depends on FB_CORE
 	default y
 	help
 	  Say Y here if you want the legacy /dev/fb* device file and
@@ -39,7 +43,7 @@ config FB_DDC
 
 config FB_CFB_FILLRECT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -47,7 +51,7 @@ config FB_CFB_FILLRECT
 
 config FB_CFB_COPYAREA
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -55,7 +59,7 @@ config FB_CFB_COPYAREA
 
 config FB_CFB_IMAGEBLIT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the cfb_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -63,7 +67,7 @@ config FB_CFB_IMAGEBLIT
 
 config FB_CFB_REV_PIXELS_IN_BYTE
 	bool
-	depends on FB
+	depends on FB_CORE
 	help
 	  Allow generic frame-buffer functions to work on displays with 1, 2
 	  and 4 bits per pixel depths which has opposite order of pixels in
@@ -71,7 +75,7 @@ config FB_CFB_REV_PIXELS_IN_BYTE
 
 config FB_SYS_FILLRECT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_fillrect function for generic software rectangle
 	  filling. This is used by drivers that don't provide their own
@@ -79,7 +83,7 @@ config FB_SYS_FILLRECT
 
 config FB_SYS_COPYAREA
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_copyarea function for generic software area copying.
 	  This is used by drivers that don't provide their own (accelerated)
@@ -87,7 +91,7 @@ config FB_SYS_COPYAREA
 
 config FB_SYS_IMAGEBLIT
 	tristate
-	depends on FB
+	depends on FB_CORE
 	help
 	  Include the sys_imageblit function for generic software image
 	  blitting. This is used by drivers that don't provide their own
@@ -126,22 +130,22 @@ endchoice
 
 config FB_SYS_FOPS
 	tristate
-	depends on FB
+	depends on FB_CORE
 
 config FB_DEFERRED_IO
 	bool
-	depends on FB
+	depends on FB_CORE
 
 config FB_IO_HELPERS
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_CFB_COPYAREA
 	select FB_CFB_FILLRECT
 	select FB_CFB_IMAGEBLIT
 
 config FB_SYS_HELPERS
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_SYS_COPYAREA
 	select FB_SYS_FILLRECT
 	select FB_SYS_FOPS
@@ -149,7 +153,7 @@ config FB_SYS_HELPERS
 
 config FB_SYS_HELPERS_DEFERRED
 	bool
-	depends on FB
+	depends on FB_CORE
 	select FB_DEFERRED_IO
 	select FB_SYS_HELPERS
 
diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
index 9150bafd9e89..2cd213716c12 100644
--- a/drivers/video/fbdev/core/Makefile
+++ b/drivers/video/fbdev/core/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
-obj-$(CONFIG_FB)                  += fb.o
-fb-y                              := fb_backlight.o \
-                                     fb_info.o \
-                                     fbmem.o fbmon.o fbcmap.o \
+obj-$(CONFIG_FB_CORE)             += fb.o
+fb-y                              := fb_info.o \
+                                     fbmem.o fbcmap.o \
                                      modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
+fb-$(CONFIG_FB)                   += fb_backlight.o fbmon.o
 fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
 fb-$(CONFIG_FB_DEVICE)            += fb_chrdev.o \
                                      fb_procfs.o \
-- 
2.41.0

