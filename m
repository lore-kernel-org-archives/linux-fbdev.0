Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61A1C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 12:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8082461076
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Nov 2021 12:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhKCMbG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Nov 2021 08:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231775AbhKCMbG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Nov 2021 08:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635942509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lDu7V2UPes5WjN4f5IhHpRndmxXdgV1k4QHUorLyZaY=;
        b=OXVkZznW+6AyKI+FSgsLXKKgetLAVzLlM0n0mzkgD9rYhDkBy9C/361II7/Fo3ZOfrXA8N
        iVDcwk3oGH0+Xsdu2Oz9JuStlnVNH64LDGYzFUuwmAn7s0cZINzbHoRh1tsQQvbf3K7jxP
        5dEbFygHUODxSKjEP5tirfWGJYUAXJw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-ixLkE4yXMeu79w2sThyRpg-1; Wed, 03 Nov 2021 08:28:28 -0400
X-MC-Unique: ixLkE4yXMeu79w2sThyRpg-1
Received: by mail-wm1-f71.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so980026wmg.9
        for <linux-fbdev@vger.kernel.org>; Wed, 03 Nov 2021 05:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lDu7V2UPes5WjN4f5IhHpRndmxXdgV1k4QHUorLyZaY=;
        b=73XwvYrvMXCUoc3XKnWUpIrjjtOA//Qckyq2zcZe66DzZGXQRXJP6H9tEg7tGNEQYt
         FlVwd+23RH6i9jg0MOV3g/qlcbLolnLnooRi/GOOpibcqOFP0TToZKORYDS7yiLYs3L2
         PAL+/LhCcJwHeNlw/U09gQOJfYnSS74oQ/J0b2lu2KMQXKW9zUlJrMqwdgeOm475Gwdi
         Cl/7paXMUX/EYLuv6DZ81raUEfzJjsRHlvRewQQck9yKjSjLVooFANsliTSpMGrMRIW+
         2et0/6fFiJC3p1LzUPSJokFmBTNQatw78K4fEk3OWvGsscKO+73P6UlvLuI38Q7V4tUa
         VtGw==
X-Gm-Message-State: AOAM5315Lm0qJctgB2cEEi6ctmrWaBTpPFnxv+s/gE4oYqIZyYI9KkkE
        mmJ+/Vt25JU1jcCdNxYjxE5AxLCd5TizaEOp2Sxnqd2FA5iE0uPjQN3HKg5V7bf1vHLbIBu8MYe
        PvjhodJZjnGra/dMkYBEbwKg=
X-Received: by 2002:adf:a78a:: with SMTP id j10mr56180962wrc.231.1635942507376;
        Wed, 03 Nov 2021 05:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoKFRYs4+FwUh+L5HYY422zuSq9cxsugE+p23YKU/J7QO0nbcMQx6cOjsOctL5eIXzrrPWjA==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr56180921wrc.231.1635942507148;
        Wed, 03 Nov 2021 05:28:27 -0700 (PDT)
Received: from minerva.home ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id w7sm1868400wru.51.2021.11.03.05.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:28:26 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Neal Gompa <ngompa13@gmail.com>,
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
Subject: [RESEND PATCH 0/5] Cleanups for the nomodeset kernel command line parameter logic
Date:   Wed,  3 Nov 2021 13:28:04 +0100
Message-Id: <20211103122809.1040754-1-javierm@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[ resend with all relevant people as Cc now, sorry to others for the spam ]

There is a lot of historical baggage on this parameter. It's defined in
the vgacon driver as a "nomodeset" parameter, but it's handler function is
called text_mode() that sets a variable named vgacon_text_mode_force whose
value is queried with a function named vgacon_text_force().

All this implies that it's about forcing text mode for VGA, yet it is not
used in neither vgacon nor other console driver. The only users for these
are DRM drivers, that check for the vgacon_text_force() return value to
determine whether the driver could be loaded or not.

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

Patch #1 is just a trivial fix for a comment that isn't referring to the
correct kernel parameter.

Patch #2 moves the nomodeset logic to the DRM subsystem.

Patch #3 renames the vgacon_text_force() function and accompaning logic as
drm_modeset_disabled(), which is what this function is really about.

Patch #4 adds a drm_drv_enabled() function that could be used by drivers
to check if could be enabled.

Patch #5 uses the drm_drv_enabled() function to check this instead of just
checking if nomodeset has been set.


Javier Martinez Canillas (5):
  drm/i915: Fix comment about modeset parameters
  drm: Move nomodeset kernel parameter handler to the DRM subsystem
  drm: Rename vgacon_text_force() function to drm_modeset_disabled()
  drm: Add a drm_drv_enabled() helper function
  drm: Use drm_drv_enabled() instead of drm_modeset_disabled()

 drivers/gpu/drm/Makefile                |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 ++---
 drivers/gpu/drm/ast/ast_drv.c           |  3 +--
 drivers/gpu/drm/drm_drv.c               | 21 ++++++++++++++++++++
 drivers/gpu/drm/drm_nomodeset.c         | 26 +++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_module.c      | 10 +++++-----
 drivers/gpu/drm/mgag200/mgag200_drv.c   |  3 +--
 drivers/gpu/drm/nouveau/nouveau_drm.c   |  3 +--
 drivers/gpu/drm/qxl/qxl_drv.c           |  3 +--
 drivers/gpu/drm/radeon/radeon_drv.c     |  3 +--
 drivers/gpu/drm/tiny/bochs.c            |  3 +--
 drivers/gpu/drm/tiny/cirrus.c           |  3 +--
 drivers/gpu/drm/vboxvideo/vbox_drv.c    |  5 +----
 drivers/gpu/drm/virtio/virtgpu_drv.c    |  3 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  3 +--
 drivers/video/console/vgacon.c          | 21 --------------------
 include/drm/drm_drv.h                   |  1 +
 include/drm/drm_mode_config.h           |  6 ++++++
 include/linux/console.h                 |  6 ------
 19 files changed, 73 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_nomodeset.c

-- 
2.33.1

