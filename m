Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A9C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Nov 2021 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6881F611C4
	for <linux-fbdev@archiver.kernel.org>; Thu,  4 Nov 2021 16:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhKDQKF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60069 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231587AbhKDQKE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 4 Nov 2021 12:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636042046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=n/ejIrVb3rZrH44A2zViksmvIEiiBszGsTbTQyQjoKs=;
        b=hsDF9tJ9qoT6srxTuTvAMe2Qwg0BtWKJgkuKLTKcjAJ2GC3bY1IU8SqPb9al6Ve4d8YJn0
        Gu4gUe7bO6TzxiQbu2e1j6EYZ1lSEy3OKeiXsETr5LR781bBlgrWuTgOubjwlZTuSMJugz
        81fy1iW51cIrz9vj548MMHHJDpX4HZM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-x2PrRXi_PTuD-jqfBMY1Qw-1; Thu, 04 Nov 2021 12:07:22 -0400
X-MC-Unique: x2PrRXi_PTuD-jqfBMY1Qw-1
Received: by mail-wr1-f71.google.com with SMTP id k8-20020a5d5248000000b001763e7c9ce5so1176974wrc.22
        for <linux-fbdev@vger.kernel.org>; Thu, 04 Nov 2021 09:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/ejIrVb3rZrH44A2zViksmvIEiiBszGsTbTQyQjoKs=;
        b=ksr6enKIHxE326TRiNnhJa1Ua2SHLAJdx6w2Z4Hjv1TK7nUTI/ynfC4IVH8mwgDLC/
         qi/YJdngyp6yN5QZzaOJeFCMEpL7Kn6cH0adXOp8RsW/XBiQvgNDOwQ4/a87YkQa+FTp
         g6eMwFhQdvQbd7JQ6c1JLeiliPejbw38OPYjm8yewrhjMx7N3BMFlv79rNAU7o8r93oj
         ALviTzPH8qAfYaan0xU9OvpLLSR3ItNcmTJb9b78+I9EPWGg+20QucNakUw5wtX3sd5Z
         OVftNlJbDTRtpYM3PELEuBux5CpQmXA7ce6xTUYTx5diZHnKrTcKgWlg8rTZn+scEMvW
         8UXQ==
X-Gm-Message-State: AOAM532Hqfy6hdF3JLTLhbaFcqcYnsePQG80a4Wp15fKgCPY2hf5p38z
        2VHbJyWNf9i5CYsFe45VMjRgcfYa8hxn/NcRHfIi0sm9IpimNJaVg0OTTScDm0/Nipyfx9H/J0p
        Eym4K6/2d16HZOknsoWLKtAY=
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr23689896wml.100.1636042041574;
        Thu, 04 Nov 2021 09:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxQs3q9Q2yGgJQmZ5zypW+OBIyfR4YAS74a/Zv3Ucv5aomcisjC91zz+w+lhZHPPKLJjXLiw==
X-Received: by 2002:a7b:ca44:: with SMTP id m4mr23689832wml.100.1636042041250;
        Thu, 04 Nov 2021 09:07:21 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id l18sm5877863wrt.81.2021.11.04.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:07:20 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Robinson <pbrobinson@gmail.com>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Zack Rusin <zackr@vmware.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, nouveau@lists.freedesktop.org,
        spice-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] Cleanups for the nomodeset kernel command line parameter logic
Date:   Thu,  4 Nov 2021 17:07:05 +0100
Message-Id: <20211104160707.1407052-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

There is a lot of historical baggage on this parameter. It is defined in
the vgacon driver as nomodeset, but its set function is called text_mode()
and the value queried with a function named vgacon_text_force().

All this implies that it's about forcing text mode for VGA, yet it is not
used in neither vgacon nor other console driver. The only users for these
are DRM drivers, that check for the vgacon_text_force() return value to
determine whether the driver should be loaded or not.

That makes it quite confusing to read the code, because the variables and
function names don't reflect what they actually do and also are not in the
same subsystem as the drivers that make use of them.

This patch-set attempts to cleanup the code by moving the nomodseset param
to the DRM subsystem and do some renaming to make their intention clearer.

There is also another aspect that could be improved, and is the fact that
drivers are checking for the nomodeset being set as an indication if have
to be loaded.

But there may be other reasons why this could be the case, so it is better
to encapsulate the logic in a separate function to make clear what's about.

This is a v2 of the patches, that address the issues pointed out by Thomas
Zimmermann and Jani Nikula in v1:

https://lore.kernel.org/lkml/5b4e4534-4786-d231-e331-78fdb5d8496a@redhat.com/T/

Patch #1 adds a drm_drv_enabled() function that could be used by drivers to
check if these could be enabled, instead of just using vgacon_text_force().

Patch #2 moves the nomodeset logic to the DRM subsystem and renames the
functions and variables to better explain what these actually do.

Changes in v2:
- Squash patch to add drm_drv_enabled() and make drivers use it.
- Make the drivers changes before moving nomodeset logic to DRM.
- Make drm_drv_enabled() return an errno and -ENODEV if nomodeset.
- Remove debug and error messages in drivers.
- Conditionally build drm_nomodeset.o if CONFIG_VGA_CONSOLE is set.
- Squash patches to move nomodeset logic to DRM and do the renaming.
- Name the function drm_check_modeset() and make it return -ENODEV.

Javier Martinez Canillas (2):
  drm: Add a drm_drv_enabled() to check if drivers should be enabled
  drm: Move nomodeset kernel parameter to the DRM subsystem

 drivers/gpu/drm/Makefile                |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  8 +++-----
 drivers/gpu/drm/ast/ast_drv.c           |  8 +++++---
 drivers/gpu/drm/drm_drv.c               | 21 ++++++++++++++++++++
 drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c      |  8 +++++---
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  8 +++++---
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  6 ++++--
 drivers/gpu/drm/qxl/qxl_drv.c           |  8 +++++---
 drivers/gpu/drm/radeon/radeon_drv.c     |  7 ++++---
 drivers/gpu/drm/tiny/bochs.c            |  8 +++++---
 drivers/gpu/drm/tiny/cirrus.c           |  9 ++++++---
 drivers/gpu/drm/vboxvideo/vbox_drv.c    | 10 +++++-----
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  6 +++---
 drivers/video/console/vgacon.c          | 21 --------------------
 include/drm/drm_drv.h                   |  1 +
 include/drm/drm_mode_config.h           |  6 ++++++
 include/linux/console.h                 |  6 ------
 19 files changed, 109 insertions(+), 66 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

