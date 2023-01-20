Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D74C25B4E
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Jan 2023 12:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjATMJU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Jan 2023 07:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjATMJT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Jan 2023 07:09:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C299F077
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 04:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674216509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EorP74j3x4AQpp4pYb79LEKPx0NRfoi7hoT0sE5jwxk=;
        b=iFYk848u+spP0caBtqC0oPG8ox5qhH+e/OpNllQ9t4ostRdH+ND8iRP+G9FECiwMCtQVzP
        kaWxfxIKn2PHVUfR6fVcj9HmmSUQmCxNK4cm5cUPBSOvroA8qL7NjS8LKX5BXHpAH8W6NV
        8Jn/G2WigRZKWaI+rkil9oU2tA8UB0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-477-tUtITOrtO36tWMlZxPpqNg-1; Fri, 20 Jan 2023 07:08:28 -0500
X-MC-Unique: tUtITOrtO36tWMlZxPpqNg-1
Received: by mail-wm1-f71.google.com with SMTP id ay38-20020a05600c1e2600b003da7c41fafcso4687033wmb.7
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 04:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EorP74j3x4AQpp4pYb79LEKPx0NRfoi7hoT0sE5jwxk=;
        b=zVqIRf2AKVqjCNwWa3A00e6Q7GaSk2HtPFvnn6Cc/gCrr89wo6huNFBCVDZKa/JmN4
         JJyhONPPEjHRfnWTTDW3ir/JR3Cs7S79jiN+OOhnUhGyNBGj/j5mr06LcO51ddegAyfs
         UzoecJUxBmeMVlvwybbhvMKT+Dn4+AvxVX7dN+8E/7qGvZzqV9O/InkHmqdkX2dpQ/7A
         CTtY8gbA74LAG1SR1Pa1cF8oRfDxfeLKQA+wFSU8J2XYjOFT3UWB0OfdtUIv1B4GbZTN
         ytpT/OEzYY1bnt84adbf/V3zVe4lqAblwj/WQ2rvCOfTR2IdaGTyMp+sPtkJRo+mu92R
         8SZw==
X-Gm-Message-State: AFqh2koD29ZPXEBrvhsBls+iPvjCquxZpoVBTb877yvueI+r/uN5ReUW
        9zRutQVjCm6WLTauTgaSf/89fgQiY6zivhX248IRMiw2VPJCJyK0+Kb60cHNHoJx8xNmd0PE+et
        t0af26EkBdl0thpjH7hAfpi8=
X-Received: by 2002:adf:c645:0:b0:2bf:81e9:cdc5 with SMTP id u5-20020adfc645000000b002bf81e9cdc5mr954317wrg.42.1674216507051;
        Fri, 20 Jan 2023 04:08:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtxVGUJbmsvWQFDyiPS9CLawvVjvF3wsxeOlNhZMZ27WAF18x2qJNgpWWaTBA3nDIrWCUDtEA==
X-Received: by 2002:adf:c645:0:b0:2bf:81e9:cdc5 with SMTP id u5-20020adfc645000000b002bf81e9cdc5mr954296wrg.42.1674216506809;
        Fri, 20 Jan 2023 04:08:26 -0800 (PST)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b002bbb2d43f65sm32766336wrx.14.2023.01.20.04.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 04:08:25 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, Helge Deller <deller@gmx.de>,
        Jaya Kumar <jayalk@intworks.biz>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 0/3] Fixes and cleanup for DRM fbdev emulation and deferred I/O
Date:   Fri, 20 Jan 2023 13:08:19 +0100
Message-Id: <20230120120822.2536032-1-javierm@redhat.com>
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


Javier Martinez Canillas (3):
  fbdev: Remove unused struct fb_deferred_io .first_io field
  drm/fb-helper: Check fb_deferred_io_init() return value
  drm/fb-helper: Use a per-driver FB deferred I/O handler

 drivers/gpu/drm/drm_fbdev_generic.c | 15 ++++++++-------
 drivers/video/fbdev/core/fb_defio.c |  4 ----
 include/drm/drm_fb_helper.h         | 10 ++++++++++
 include/linux/fb.h                  |  1 -
 4 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.39.0

