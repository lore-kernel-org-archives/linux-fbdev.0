Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C19C004D4
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Jan 2023 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjAUT0V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 21 Jan 2023 14:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjAUT0R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 21 Jan 2023 14:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67029E02
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Jan 2023 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674329097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=t3hudovJHnxcneZUu+woal1qY/z5dLk/KSxEgxM2qkk=;
        b=dMxE/Tu/fI30WOXMN8MsUIiZuZTQnQ/J6/5PdzzYlrINErdUGoWHizewAZ0+VTTaO3vzA1
        t8Ir6DL8zm00FyzOMgHF6rJXmfuZq9mLWgApX3KIkW9lf30bxxdi5X5f0+6VI9srT2c0Wg
        rIdV4y5BYYKl1shog/nL/CcO7kI03v0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-0pEBg4oTMo-KKOhJwEJnKw-1; Sat, 21 Jan 2023 14:24:45 -0500
X-MC-Unique: 0pEBg4oTMo-KKOhJwEJnKw-1
Received: by mail-wr1-f70.google.com with SMTP id t26-20020adfa2da000000b002be9cd25e90so669874wra.11
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Jan 2023 11:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3hudovJHnxcneZUu+woal1qY/z5dLk/KSxEgxM2qkk=;
        b=fpWBK7tpob8d/TAwdrNEzDNy55wemR7RU/RADTeLK3E619jD0uWZxiQ4QxGBVTYkcN
         K8rt0UFz/M22ulz1NU9jK57cfLSxq5RsO4zowRuwdiQ8fOkvXG+WgyRMLjHsh2VO0c1d
         lPJW5zZeer6wh1BvkS3bntPDBA/jVBWtPfZy/hfSNmsBL2KQbMkH53apnkgLHoPFzE/L
         Pkdym4hiKawUNa4QgWBfGQru3+d1bf6QWm9RbUWWOVBbZw9vJpKC5BLMYyLzzIu0rvH3
         Hgz9jFjNBAE87bjuZu6mZ6IPLW/AQ+aNlk50CFLslN0MdV+RlrzWCEW+iZ+zI0ZACWDB
         mppQ==
X-Gm-Message-State: AFqh2kp2+QLTX7XVzlRHJsNCDogXvvguyBwdw2sU4+C71wI7RC26il/J
        ljo2zlhKz84MHIqwSOo84obETcQvedRmAO/ogHZ3BNjJw60zO6Alcdj1YTiK2vqjRVIZjrFXQFa
        7eWTdWYTzMnpHFua5OdIxw7U=
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr15020842wms.12.1674329084677;
        Sat, 21 Jan 2023 11:24:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsX9USPEoSwU8E0lwBmJ+d/5/Wr2ac8HU57kLtvH6Q9yQcFpRhHXcnJcvHcD2LCoyGFM1bn+A==
X-Received: by 2002:a05:600c:3b91:b0:3d3:5c9e:6b27 with SMTP id n17-20020a05600c3b9100b003d35c9e6b27mr15020826wms.12.1674329084475;
        Sat, 21 Jan 2023 11:24:44 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm8544321wmg.27.2023.01.21.11.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 11:24:43 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/3] Fixes and cleanup for DRM fbdev emulation and deferred I/O
Date:   Sat, 21 Jan 2023 20:24:15 +0100
Message-Id: <20230121192418.2814955-1-javierm@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

This patch series contains two fixes and a cleanup for things that I noticed
while debugging a regression in the fbdev emulation for a DRM driver.

The first two patches are trivial and shoulnd't be controversial, the third
patch is less trivial, but it has been already reviewed by Thomas and I did
test it to make sure that works as expected. With it, I got rid of the WARN
that happened due a mutex used after it has been destroyed.

Best regards,
Javier

Changes in v2:
- Re-introduce the CONFIG_FB_DEFERRED_IO ifdef guard for the @fbdefio field
  declaration since the kernel test robot reported that's needed at the end.

Javier Martinez Canillas (3):
  fbdev: Remove unused struct fb_deferred_io .first_io field
  drm/fb-helper: Check fb_deferred_io_init() return value
  drm/fb-helper: Use a per-driver FB deferred I/O handler

 drivers/gpu/drm/drm_fbdev_generic.c | 15 ++++++++-------
 drivers/video/fbdev/core/fb_defio.c |  4 ----
 include/drm/drm_fb_helper.h         | 12 ++++++++++++
 include/linux/fb.h                  |  1 -
 4 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.39.0

