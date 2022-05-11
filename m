Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D6DC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 May 2022 11:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241309AbiEKLZl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 May 2022 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbiEKLZD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 May 2022 07:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9035323674B
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=74g0bmnivF1+sjdv/ldmbPuCRqvKL9LcvXu85lOOZDc=;
        b=AwDFplJtljDncHhuo6rFu1NkXjL2rVrHFR1MSp1a+NOWrkzKM221k3A+hXZzcEsFlql5Fl
        UpBg3N3pQmamFdDnKluhuU0PpIor5C5wOoO30xTgIJquJrhFT6kkv/TBytR5isurwVthWB
        YQWtL7cC1WvoHf7tRCgCf/YNvRmRo9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-qXLCRCQbNjOr5XEa-IqPDA-1; Wed, 11 May 2022 07:24:55 -0400
X-MC-Unique: qXLCRCQbNjOr5XEa-IqPDA-1
Received: by mail-wm1-f72.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so2703517wmq.3
        for <linux-fbdev@vger.kernel.org>; Wed, 11 May 2022 04:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74g0bmnivF1+sjdv/ldmbPuCRqvKL9LcvXu85lOOZDc=;
        b=cMnKwhKUQXevaU3H79xEpHroYOQdtgBgzJZpyWlo1L5ZFVlbezDYykwQ54fcUHZ4WS
         6SXqedu0okkno/1oGUPSvcLFHvzABDLHABMfKlUq/BzaFczUvq0iyD8qG9ZQCgFtN83B
         IF59t0ziv9owToPeCmBazelYPEI0KgvppQ493jluDGzKur1BEvA71I4eqBV9JZTPVSZK
         jD8JS8GyPsH3/pTzQy6pI0QI22mxSEGk5dHkOioBHuk6MqSOYbhyx9OMhC/+ZqPi4lxH
         k1mmqcMHnNKlkc4Kdo2HtufBg/WTylCLgKtzTDFk/R73yaCbD/ocH0Brt5TmHzdQ2tuw
         8DpQ==
X-Gm-Message-State: AOAM530lclxDItIWezgKDlWbf1jl2nl2p0k1q7V4xeq1wza4oTWeh16n
        Y8lb/erS49A+PMPMUNiM0TmFlMSKzgJAmb1lIz36KoCOwPmkPtVbwgScCDYivO/kiWtivVUaTNw
        ihImlCVdDEwC3LRnhdvs3WmE=
X-Received: by 2002:a05:6000:1841:b0:20c:788b:9306 with SMTP id c1-20020a056000184100b0020c788b9306mr21500994wri.369.1652268294329;
        Wed, 11 May 2022 04:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqiIDFQEwbgjQPCLimkTEcDNRsKPVMAysuPiAMG2NOuNeRfcXzFKnVvUYrhq6SaYWWb2umNQ==
X-Received: by 2002:a05:6000:1841:b0:20c:788b:9306 with SMTP id c1-20020a056000184100b0020c788b9306mr21500957wri.369.1652268294033;
        Wed, 11 May 2022 04:24:54 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4481000000b0020c5253d8d3sm1429174wrq.31.2022.05.11.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:24:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v5 0/7] Fix some races between sysfb device registration and drivers probe
Date:   Wed, 11 May 2022 13:24:31 +0200
Message-Id: <20220511112438.1251024-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

The patches in this series contain mostly changes suggested by Daniel Vetter
Thomas Zimmermann. They aim to fix existing races between the Generic System
Framebuffer (sysfb) infrastructure and the fbdev and DRM device registration.

For example, it is currently possible for sysfb to register a platform
device after a real DRM driver was registered and requested to remove the
conflicting framebuffers. Or is possible for a simple{fb,drm} to match with
a device previously registered by sysfb, even after a real driver is present.

A symptom of this issue, was worked around with the commit fb561bf9abde
("fbdev: Prevent probing generic drivers if a FB is already registered")
but that's really a hack and should be reverted instead.

This series attempt to fix it more correctly and revert the mentioned hack.
That will also allow to make the num_registered_fb variable not visible to
drivers anymore, since that's internal to fbdev core.

Pach 1 is just a simple cleanup in preparation for later patches.

Patch 2 add a sysfb_disable() and sysfb_try_unregister() helpers to allow
disabling sysfb and attempt to unregister registered devices respectively.

Patch 3 changes how is dealt with conflicting framebuffers unregistering,
rather than having a variable to determine if a lock should be take, it
just drops the lock before unregistering the platform device.

Patch 4 changes the fbdev core to not attempt to unregister devices that
were registered by sysfb, let the same code doing the registration to also
handle the unregistration.

Patch 5 fixes the race that exists between sysfb devices registration and
fbdev framebuffer devices registration, by disabling the sysfb when a DRM
or fbdev driver requests to remove conflicting framebuffers.

Patch 6 is the revert patch that was posted by Daniel before but dropped
from his set and finally patch 7 is the one that makes num_registered_fb
private to fbmem.c, to not allow drivers to use it anymore.

The patches were tested on a rpi4 with the vc4, simpledrm and simplefb
drivers, using different combinations of built-in and as a module.

For example, having simpledrm as a module and loading it after the vc4
driver probed would not register a DRM device, which happens now without
the patches from this series.

Best regards,
Javier

Changes in v5:
- Move the sysfb_disable() call at conflicting framebuffers again to
  avoid the need of a DRIVER_FIRMWARE capability flag.
- Add Daniel Vetter's Reviewed-by tag again since reverted to the old
  patch that he already reviewed in v2.
- Drop patches that added a DRM_FIRMWARE capability and use them
  since the case those prevented could be ignored (Daniel Vetter).

Changes in v4:
- Make sysfb_disable() to also attempt to unregister a device.
- Drop call to sysfb_disable() in fbmem since is done in other places now.
- Add patch to make registered_fb[] private.
- Add patches that introduce the DRM_FIRMWARE capability and usage.

Changes in v3:
- Add Thomas Zimmermann's Reviewed-by tag to patch #1.
- Call sysfb_disable() when a DRM dev and a fbdev are registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.
- Rebase on top of latest drm-misc-next branch.

Changes in v2:
- Rebase on top of latest drm-misc-next and fix conflicts (Daniel Vetter).
- Add kernel-doc comments and include in other_interfaces.rst (Daniel Vetter).
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).
- Drop RFC prefix since patches were already reviewed by Daniel Vetter.
- Add Daniel Reviewed-by tags to the patches.

Daniel Vetter (2):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"
  fbdev: Make registered_fb[] private to fbmem.c

Javier Martinez Canillas (5):
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add helpers to unregister a pdev and disable
    registration
  fbdev: Restart conflicting fb removal loop when unregistering devices
  fbdev: Make sysfb to unregister its own registered devices
  fbdev: Disable sysfb device registration when removing conflicting FBs

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 91 +++++++++++++++++--
 drivers/firmware/sysfb_simplefb.c             | 16 ++--
 drivers/video/fbdev/core/fbmem.c              | 67 +++++++++++---
 drivers/video/fbdev/efifb.c                   | 11 ---
 drivers/video/fbdev/simplefb.c                | 11 ---
 include/linux/fb.h                            |  8 +-
 include/linux/sysfb.h                         | 29 +++++-
 8 files changed, 178 insertions(+), 61 deletions(-)

-- 
2.35.1

