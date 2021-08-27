Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC117C432BE
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D71460F4F
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Aug 2021 10:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbhH0KBj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20214 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233102AbhH0KBf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630058446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+aJr1NTbvoxTLmIeJJqoJBHarMi/IcOrX6ArL1A6zIk=;
        b=PbVGfIjiz7rN88M6gc2yEsSrTnURPzWA5/Alg5Yj+FmCBGJKyGJQoReGvPfjUrq0glT429
        oAeAgxojq2JyltVujCn+YHcqyNApgR1B8Tf185Rgx80A7mtMmO05D7M0e7e0YDmK1noO/m
        RXq5xPlIIF3ZpqUkSVAzJCdMe865rQE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-Sn5_tb4LMROggzpCfbS9UQ-1; Fri, 27 Aug 2021 06:00:43 -0400
X-MC-Unique: Sn5_tb4LMROggzpCfbS9UQ-1
Received: by mail-wr1-f71.google.com with SMTP id p1-20020adfcc81000000b001576cccf12cso1703119wrj.6
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Aug 2021 03:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+aJr1NTbvoxTLmIeJJqoJBHarMi/IcOrX6ArL1A6zIk=;
        b=WnL3Oar/MY+8ul7EcMG9JY4nrIAMFY7cPZKQUrvZyPeMMHbjOA33WxwkgXzGsUYxop
         slBXdVFAFtUxlls98YbxB7WKD0lgyVconKwVTq25sWiFYBwnqJNWPbwr8U9y8Smaz9xk
         8SVLU9lE9U9S0hiw+T2fA/UWozCLHNW0jttOTZX4FUV5HWTr2PUT7FsgSpY+Ycmr6JWN
         MbtsU1nypdH8/CYCMOuzSmkbjOtoi6487shsuyujrBccp/ehjLNucFG7sC85XZxGmbtY
         mxQ4DpzQLvlFRrCdHOYEhizB0k5kmmlXYFS4scDDoCRx1LC0d+VtuPZrLLJA/E8Wjxar
         Mzxg==
X-Gm-Message-State: AOAM531qMfMUT2jDLscG/KRmXRBtBoX7i2O2vypkYTkoRTVcYCRKdYcN
        TW7eZ2i94xe/DgXmoxF9uoGGD23rw1AS7H146PSFtWyo3iHbOd6l1MBWc7a1jOcIvUfrThhPjaq
        F5NPKzsez2DaZpO/+uv2QS/E=
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr18455113wmc.25.1630058441647;
        Fri, 27 Aug 2021 03:00:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwD3l80v92gfAfOSZ8b1Ut69bemPoE/9nlRVQcrJ7xuf3wtFFgtxktW5NFZYCYctIfnyuFMVA==
X-Received: by 2002:a05:600c:428a:: with SMTP id v10mr18455078wmc.25.1630058441335;
        Fri, 27 Aug 2021 03:00:41 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id z17sm1121267wrh.66.2021.08.27.03.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:00:40 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ingo Molnar <mingo@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: [RFC PATCH 0/4] Allow to use DRM fbdev emulation layer with CONFIG_FB disabled
Date:   Fri, 27 Aug 2021 12:00:23 +0200
Message-Id: <20210827100027.1577561-1-javierm@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patch series splits the fbdev core support in two different Kconfig
symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
be disabled, while still using fbcon with the DRM fbdev emulation layer.

The reason for doing this is that now with simpledrm we could just boot
with simpledrm -> real DRM driver, without needing any legacy fbdev driver
(e.g: efifb or simplefb) even for the early console.

We want to do that in the Fedora kernel, but currently need to keep option
CONFIG_FB enabled and all fbdev drivers explicitly disabled, which makes
the configuration harder to maintain.

It is a RFC because I'm not that familiar with the fbdev core, but I have
tested and works with CONFIG_DRM_FBDEV_EMULATION=y and CONFIG_FB disabled.
This config automatically disables all the fbdev drivers that is our goal.

Patch 1/4 is just a clean up, patch 2/4 moves a couple of functions out of
fbsysfs.o, that are not related to sysfs attributes creation and finally
patch 3/4 makes the fbdev split that is mentioned above.

Patch 4/4 makes the DRM fbdev emulation depend on the new FB_CORE symbol
instead of FB. This could be done as a follow-up but for completeness is
also included in this series.

Best regards,
Javier


Javier Martinez Canillas (4):
  fbdev: Rename fb_*_device() functions names to match what they do
  fbdev: Move framebuffer_{alloc,release}() functions to fbmem.c
  fbdev: Split frame buffer support in FB and FB_CORE symbols
  drm: Make fbdev emulation depend on FB_CORE instead of FB

 arch/x86/Makefile                  |  2 +-
 arch/x86/video/Makefile            |  2 +-
 drivers/gpu/drm/Kconfig            |  2 +-
 drivers/video/console/Kconfig      |  2 +-
 drivers/video/fbdev/Kconfig        | 57 +++++++++++++---------
 drivers/video/fbdev/core/Makefile  | 13 +++--
 drivers/video/fbdev/core/fbmem.c   | 73 ++++++++++++++++++++++++++--
 drivers/video/fbdev/core/fbsysfs.c | 77 +-----------------------------
 include/linux/fb.h                 | 18 ++++++-
 9 files changed, 134 insertions(+), 112 deletions(-)

-- 
2.31.1

