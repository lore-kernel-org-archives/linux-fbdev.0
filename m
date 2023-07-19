Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE0DC001DC
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jul 2023 08:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGSIQp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jul 2023 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjGSIQm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jul 2023 04:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BCB171D
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689754555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=40ASWVJugYUVdn1GncG1gYQu4TsA6479quLHdQQNoPg=;
        b=NDLgDeho1Ng0ShLW2vEUyAYWsviHBv4M1WYfw2SytgK17aIj4KZ1SkSygWztgWR/+k1Eef
        ApB/97IJlnmZi503yddO39Bp0VLQ5NH0mpkAKR/bgh6+7bl9KO9vIutnqJWOvME3J1fYqs
        X8tCloLbw9ZgaCqD/VpGlA0FMVYJnk8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-NCthRgTvPAGqckR7-X1uzQ-1; Wed, 19 Jul 2023 04:15:54 -0400
X-MC-Unique: NCthRgTvPAGqckR7-X1uzQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-315998d6e7fso3658964f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 01:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754553; x=1690359353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40ASWVJugYUVdn1GncG1gYQu4TsA6479quLHdQQNoPg=;
        b=Lwcm/N7SnnZ/uchKvDpBhfW8r4tp7w25/Vq2sU34QMPHQ2ME2xa7k3yjBXaIPv4cRd
         /Nll8O3F0046O1/PZdoRCcitF9bfaTRkZU69Ywfo7RwIA6Wc6iLJKiOX0If1APRT5iep
         dKF/6hQYMXu602sgH+7IlI/O6v4CSecSjoaI9d1qD5+F9Q1lRQbkB/05qUmhsmui+PhJ
         gpLqVlSoKejToTK/lGOSPKGuYwqHjrywjY1r+UVffV9Fzkigbe2SrhL5heNONjw0TVpw
         /prshF0qVocJ4CeBUP1yhabUL1JJOn86vyng8vvKWeStITE2lFk25ln9qjCR8pFPZ97d
         bUyA==
X-Gm-Message-State: ABy/qLZP8Su/nDU8yCJS09Gqf3xI5TbZOIzL9KwG+1CmxB+x/t24ZXEQ
        /zP00nqCuVWephYdOfesRBjkzExex0RDSdUKE3NDuh/bgX1GW2PJ6Ml4eA9ZFVkLG6yPGK4Jgxg
        3bxZXb2vl9GseYvt1znihIPM=
X-Received: by 2002:adf:f010:0:b0:30f:c5b1:23ef with SMTP id j16-20020adff010000000b0030fc5b123efmr1442035wro.41.1689754553217;
        Wed, 19 Jul 2023 01:15:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwdSs8ByNSqXngMlZ63oFzlT6IoL2Kc3yr4P/RuiEvXHHGVP6vSlDKFsJHCgGc5/EQ8pwhrA==
X-Received: by 2002:adf:f010:0:b0:30f:c5b1:23ef with SMTP id j16-20020adff010000000b0030fc5b123efmr1441993wro.41.1689754552888;
        Wed, 19 Jul 2023 01:15:52 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d5385000000b0031423a8f4f7sm4574354wrv.56.2023.07.19.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:15:52 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v6 0/4] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Wed, 19 Jul 2023 10:15:34 +0200
Message-ID: <20230719081544.741051-1-javierm@redhat.com>
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

Patch #1 moves the auxdisplay drivers to "Graphics support" Kconfig menu,
patch #2 moves the core fbdev Kconfig symbols to a separate Kconfig file,
patch #3 does the FB symbol split and introduces the FB_CORE symbol and
finally patch #4 makes the DRM symbol to select FB_CORE if the DRM fbdev
emualtion support was enabled.

Since this series touches three subsystems (auxdisplay, fbdev and DRM),
I would like to merge it through DRM with the acks of these maintainers.

This is a v6 of the patch-set that addresses issues pointed out by Arnd
Bergmann in the previous v5:

https://lists.freedesktop.org/archives/dri-devel/2023-July/413943.html

Changes in v6:
- Don't move FB_{HECUBA,SVGALIB,MACMODES} to config/Kcore (Arnd Bergmann).
- Fix link error when CONFIG_FB_CORE=y and CONFIG_FB=m (Arnd Bergmann).

Changes in v5:
- Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).
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

Javier Martinez Canillas (4):
  video: Add auxiliary display drivers to Graphics support menu
  fbdev: Move core fbdev symbols to a separate Kconfig file
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make FB_CORE to be selected if DRM fbdev emulation is enabled

 arch/x86/Makefile                   |   2 +-
 arch/x86/video/Makefile             |   2 +-
 drivers/Kconfig                     |   2 -
 drivers/gpu/drm/Kconfig             |   7 +-
 drivers/video/Kconfig               |   2 +
 drivers/video/backlight/backlight.c |   6 +-
 drivers/video/console/Kconfig       |   2 +-
 drivers/video/fbdev/Kconfig         | 197 ++--------------------------
 drivers/video/fbdev/core/Kconfig    | 190 +++++++++++++++++++++++++++
 drivers/video/fbdev/core/Makefile   |  10 +-
 10 files changed, 218 insertions(+), 202 deletions(-)
 create mode 100644 drivers/video/fbdev/core/Kconfig

-- 
2.41.0

