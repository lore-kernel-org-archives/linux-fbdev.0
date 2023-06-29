Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F7EB64D9
	for <linux-fbdev@archiver.kernel.org>; Thu, 29 Jun 2023 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjF2Wwa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 29 Jun 2023 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjF2WwI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 29 Jun 2023 18:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6E52728
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Jun 2023 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688079081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=97bfxa2ildUUs8zNadKQMWE3XSHS8OGi9guqfFdEnRY=;
        b=XLAyJSw5iADbfyXrrkbszg18IY3fqzfZn+QI3DqNicjCLH9HfhkSwRSnb/pmnomWTjA74t
        ZsIx9jzLybixztt4eyC8bZ3JfTS5+9cTMkyW75VnDBWoLOPIV9J2t5VfAesx7lcEJR8Dcv
        MNJ+OJvi4mYZS65USBMgilP3hCb62mc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-3-7Rh_9tMuygjkISBu72Cg-1; Thu, 29 Jun 2023 18:51:20 -0400
X-MC-Unique: 3-7Rh_9tMuygjkISBu72Cg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-313ec030acbso514622f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Jun 2023 15:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079079; x=1690671079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=97bfxa2ildUUs8zNadKQMWE3XSHS8OGi9guqfFdEnRY=;
        b=Zatz7vBE/7vkHICt8QhPQni2ppmFuziCIzhx8IeifKkc941XvIohkJ2zyNxFUM4qxG
         Yj9/497jdupUvlRmtfrvLr6YUV9vCOrNnJIL/BK7BW4xtT05beikD/hAneWx3ou7t2Mz
         utvtIxqha3W5IINkDVTDOMAS7g61Wc1dwn5vSCgdG4T40bN2QJ73iaCSTVp9SsZNnV+P
         fkjTV4egqSdA9Ks7JecEFnrjY3s6pv/48RVyH4MUiHueT87ROBrgefrbFBklrfPfkJ4e
         edZduy40/LbdIp1SLtL2eq6vtYGRNdI34NvoOzzHg5wZ7T8qIzmuaZgXqMMynMPQCwCx
         f0gw==
X-Gm-Message-State: AC+VfDxI9cY1HeQ5yCULEaEkC9kZE1MWk9Ab8py1TxnS+md5PbA9YSNy
        5Edr6qS5Vfhdr4hwP5RicR4B2SeDmw0fdMcEaAWB4MFqCHbOvJYy5g4NLx9hgAzrWw0MM6iHxMj
        hJGKPGbHpZRSJSagmLKAzm+A=
X-Received: by 2002:adf:cf0d:0:b0:313:ed10:7f52 with SMTP id o13-20020adfcf0d000000b00313ed107f52mr6115111wrj.18.1688079079541;
        Thu, 29 Jun 2023 15:51:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5yNLJ3SOH2DLnOJkryCoLwduMQdbLlL8LCtjNfgrXWsfzKraLofJ9rCFcQyRlq9jVxkKfBSg==
X-Received: by 2002:adf:cf0d:0:b0:313:ed10:7f52 with SMTP id o13-20020adfcf0d000000b00313ed107f52mr6115089wrj.18.1688079079281;
        Thu, 29 Jun 2023 15:51:19 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i6-20020adff306000000b00311339f5b06sm16795690wro.57.2023.06.29.15.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:51:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
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
Subject: [PATCH 0/2] Allow disabling all native fbdev drivers and only keeping DRM emulation
Date:   Fri, 30 Jun 2023 00:51:02 +0200
Message-ID: <20230629225113.297512-1-javierm@redhat.com>
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

I've build tested with possible combinations of CONFIG_FB, CONFIG_FB_CORE,
CONFIG_DRM_FBDEV_EMULATION and CONFIG_FB_DEVICE symbols set to 'y' or 'n'.

Patch 1/2 makes the CONFIG_FB split that is mentioned above and patch 2/2
makes DRM fbdev emulation depend on the new FB_CORE symbol instead of FB.


Javier Martinez Canillas (2):
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation depend on FB_CORE instead of FB

 arch/x86/Makefile                 |  2 +-
 arch/x86/video/Makefile           |  2 +-
 drivers/gpu/drm/Kconfig           |  2 +-
 drivers/video/console/Kconfig     |  2 +-
 drivers/video/fbdev/Kconfig       | 62 ++++++++++++++++++-------------
 drivers/video/fbdev/core/Makefile | 14 +++----
 6 files changed, 48 insertions(+), 36 deletions(-)

-- 
2.41.0

