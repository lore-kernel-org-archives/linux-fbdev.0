Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08172EB64DC
	for <linux-fbdev@archiver.kernel.org>; Sat,  1 Jul 2023 21:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGAVqP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 1 Jul 2023 17:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGAVqH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 1 Jul 2023 17:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5261717
        for <linux-fbdev@vger.kernel.org>; Sat,  1 Jul 2023 14:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688247916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixfgD95cECm9IJRwnBAQBSBQpbSMzbZAJ/z6SVP266o=;
        b=DnHoLUHbHYE6h6eDw5tRySeASE/OSY3gTDS2yJGtEr845KelDnonfF8zY6WDc5gb6QU1rb
        W3HwDxC2Y21Cj3hNmF5no0yq9ABZusPbi4k0o1FIL1L+gLc9o2dCOf3W6sGPOwbew+xmtR
        jCmhQ8jdKYVSY5TrDlIiaMobxyU71bI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-W4qkQlRBPCW2Om6F42fKIQ-1; Sat, 01 Jul 2023 17:45:13 -0400
X-MC-Unique: W4qkQlRBPCW2Om6F42fKIQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa871e1eaaso38697785e9.3
        for <linux-fbdev@vger.kernel.org>; Sat, 01 Jul 2023 14:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688247912; x=1690839912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixfgD95cECm9IJRwnBAQBSBQpbSMzbZAJ/z6SVP266o=;
        b=irDAlg2Dsqx0gTZWl4x8MJwFXkb2fNXSlN8OmoRBB8wOhwkgaHaPWxBf04fdrQnjez
         J7VYFTGYBMJkxaWPqrXJ7nK3Ndq9PWHqWMiaPwKfSXMwaj9/zOfNX5nYVeIBh4RIVgCh
         FECDu0ThLffkfzPGkd/J6iay8iUxzOrhl4nbtCNH+Y6cqlOE6TP6Op73UdFbANr3zcwi
         ruhlfo3FFtvFx9dDQDoOoyG0zB5t1IlVAy8FcGLjQidmMIJbYZHP/kCb/HQQkhEgr/ef
         1jj+AZlP/sp5StKbkkoAfQiJU3z5B88j7oWHcx3qrMFOkRwreBx/d0loKkgcMC3kLBFr
         An0Q==
X-Gm-Message-State: AC+VfDzuPc0ZlAWGgV9LeU/Hl6h9v+Oc49QdoGOwd+7g6lUqbdL0jHKv
        eh4F7TSbmwGUGGp3C6P88JTF9rHzPqp26lNj2SeLnRuTVEu0H/Yo29qFhKm5fQwuCr3POI1W+Sl
        HEiNbgyKV7uI04XQLxMIlYzI=
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id y14-20020a7bcd8e000000b003fa8aedd57fmr6784944wmj.24.1688247912608;
        Sat, 01 Jul 2023 14:45:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4VVFAC+mKe4oPCU8/6h1nc/0/NeVojU7eqWExkSndccFGWikoSilyCREx/O03MkmAP6nkbXg==
X-Received: by 2002:a7b:cd8e:0:b0:3fa:8aed:d57f with SMTP id y14-20020a7bcd8e000000b003fa8aedd57fmr6784914wmj.24.1688247912252;
        Sat, 01 Jul 2023 14:45:12 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fbc0ea491dsm6913800wmc.40.2023.07.01.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jul 2023 14:45:11 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 0/2] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Sat,  1 Jul 2023 23:44:49 +0200
Message-ID: <20230701214503.550549-1-javierm@redhat.com>
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

Patch 1/2 makes the CONFIG_FB split that is mentioned above and patch 2/2
makes the DRM fbdev emulation to select the new FB_CORE symbol instead of
depending on FB.

This is a v2 of the patch-set that addresses issues pointed out by Arnd
Bergmann and Thomas Zimmermann in the previous version:

https://lists.freedesktop.org/archives/dri-devel/2023-June/411435.html


Changes in v2:
- Keep "depends on FB" for FB_DDC, FB_HECUBA, FB_SVGALIB, FB_MACMODES,
  FB_BACKLIGHT, FB_MODE_HELPERS and FB_TILEBLITTING (Arnd Bergmann).
- Don't change the fb.o object name (Arnd Bergmann).
- Make FB_CORE a non-visible Kconfig symbol instead (Thomas Zimmermann).
- Make CONFIG_DRM_FBDEV_EMULATION to select FB_CORE (Thomas Zimmermann).

Javier Martinez Canillas (2):
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation select FB_CORE instead of depends on FB

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/gpu/drm/Kconfig           |  2 +-
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 40 +++++++++++++++++++------------
 drivers/video/fbdev/core/Makefile |  2 +-
 6 files changed, 30 insertions(+), 20 deletions(-)


base-commit: 270689d257c88fd1ad7050041ed196a8188e6914
-- 
2.41.0

