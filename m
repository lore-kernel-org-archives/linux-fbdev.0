Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D35EB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGCXGc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGCXGb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 19:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD11E47
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Jul 2023 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688425542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T2H4I33KaT/CjDOhVJYMDoMgR8IdFg0Tm8qqUiSuquk=;
        b=P4YeR1fZPbDkADAmXecfcP6leE350vxThNu15AUU8sDzOmPu74q+MjqnQLzcU6SrPKH3/c
        0Np6K6cxJ6/hXdE6Rbter0HCm0g7ZSR58nvs9c4WqnxC8TUtBYOK7Nvw3c+ouz3t+4eeRu
        mFt37oiqQ2Gz4gsPTKWQwS22pOCC01Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-32NaZYYlNDWgi2pjNox7uQ-1; Mon, 03 Jul 2023 19:05:41 -0400
X-MC-Unique: 32NaZYYlNDWgi2pjNox7uQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3143b277985so543618f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Jul 2023 16:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688425540; x=1691017540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2H4I33KaT/CjDOhVJYMDoMgR8IdFg0Tm8qqUiSuquk=;
        b=lqPVG77JAayRiHTcvKpAFtQ9ed83Ybif5AcNnErx4FmBFk++2czlkK+J0ODR89xXbL
         LX5E1Z96Y5psilpdF4Zn0c4PUyiEh/RWmo3KtyGyF/r7auMfAAKHv3m784VyIjegaoFw
         rHJURm79lTqx+j7/mOGYw6DPMhYF9Pw2b9axuKt9ex6FNeXCgnOi5hDN0yyLIW+SjxYQ
         0LrbCOPWK376a6ZcgLwL9OdaD21wGkHjiL0b8KYJRDxny2zb3tU2aYiufmNC8/NXlq9v
         UIuRLvKbaThyJl2ZOpbqRChBhqNj45+CaA0JFqXVwlO5jauE5lBDElScuOefajKn3Y42
         KGJg==
X-Gm-Message-State: ABy/qLb8D0kZYhJf8VKl6cwrlt+lJu+4MkV+yPRvA0pEtvJBrRjxZImZ
        i+HimERD5e9oGf6BJXQUX86WWkQwjeUEf+JCU5JfcdvWjDToI1MMo+hrBpvcoXxKlJsrBxT7HzE
        xMFRFAwli1Kaq+8iC6rZIZ8U=
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9514829wrr.45.1688425540253;
        Mon, 03 Jul 2023 16:05:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFDiQ9CTDvxM8RjD5e6R9srvFb7gfEdNT7h9sgQp7ev4whpG0Vkx82r/6mI1ZjP3FfbRfvHfA==
X-Received: by 2002:adf:fe02:0:b0:313:f124:aa53 with SMTP id n2-20020adffe02000000b00313f124aa53mr9514818wrr.45.1688425539897;
        Mon, 03 Jul 2023 16:05:39 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm26504465wrb.85.2023.07.03.16.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 16:05:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v4 0/5] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Tue,  4 Jul 2023 01:05:24 +0200
Message-ID: <20230703230534.997525-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still having the the core fbdev support needed for the
CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
disabling all fbdev drivers instead of having to be disabled individually.

The reason for doing this is that now with simpledrm, there's no need for
the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
now disable them. But it would simplify the config a lot fo have a single
Kconfig symbol to disable all fbdev drivers.

I've built tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.

Patch #1, #2 and #3 are cleanups to the "Graphics support" Kconfig menu,
patch #4 does the FB symbol split and introduces the FB_CORE symbol and
finally patch #5 makes the DRM symbol to select FB_CORE if the DRM fbdev
emualtion support was enabled.

Since this series touches three subsystems (auxdisplay, fbdev and DRM),
I would like to merge it through DRM with the acks of these maintainers.

This is a v4 of the patch-set that addresses issues pointed out by Arnd
Bergmann, Thomas Zimmermann and Geert Uytterhoeven in the previous v3:

https://lists.freedesktop.org/archives/dri-devel/2023-July/411689.html

Changes in v4:
- Fix menuconfig hierarchy that was broken in v3 (Arnd Bergmann).

Changes in v3:
- Really make a hidden symbol by removing the prompt (Arnd Bergmann).
- Change FB_CORE to config instead of menuconfig (Arnd Bergmann).
- Keep "depends on FB" for FIRMWARE_EDID (Arnd Bergmann).
- Compile out fb_backlight.o and fbmon.o that are only needed for FB
  (Arnd Bergmann).
- Make FB_DEVICE to depend on FB_CORE instead of selecting it.
- Make the DRM symbol to select FB_CORE if DRM_FBDEV_EMULATION is
  enabled (Arnd Bergmann).
- Also make DRM select FB_SYS_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
- Make DRM_FBDEV_EMULATION to depend on DRM instead of DRM_KMS_HELPER.

Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

Javier Martinez Canillas (5):
  video: Add auxiliary display drivers to Graphics support menu
  fbdev: Move core fbdev symbols to a separate Kconfig file
  drm/arm: Make ARM devices menu depend on DRM
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled

 arch/x86/Makefile                 |   2 +-
 arch/x86/video/Makefile           |   2 +-
 drivers/Kconfig                   |   2 -
 drivers/gpu/drm/Kconfig           |   7 +-
 drivers/gpu/drm/arm/Kconfig       |   1 +
 drivers/video/Kconfig             |   2 +
 drivers/video/console/Kconfig     |   2 +-
 drivers/video/fbdev/Kconfig       | 213 ++----------------------------
 drivers/video/fbdev/core/Kconfig  | 206 +++++++++++++++++++++++++++++
 drivers/video/fbdev/core/Makefile |   8 +-
 10 files changed, 230 insertions(+), 215 deletions(-)
 create mode 100644 drivers/video/fbdev/core/Kconfig

-- 
2.41.0

