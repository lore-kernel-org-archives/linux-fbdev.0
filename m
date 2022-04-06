Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E277AC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 17:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239569AbiDFR5V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbiDFR5K (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Apr 2022 13:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C59D1AEC86
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Apr 2022 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z2VH15DInn1AZtnEsLb+elNYhtkABvKZLJ4uYvk26l8=;
        b=jQAZaN085TXgf5PJi0AoPGwSO6b4APgOJ9vwAKwy3YUwbb7YR92FDmxx1Qkpg3rkusNI4E
        Gc2odAtiJxorN63FRPlziJGFfJHljoiJQe/CiQ4DEE41fFTUMwFiKRsqDOxOV91b7/7g5X
        0fksW98NjQpznvHJdOY7u1XcDFaGeYU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-FqtKPzdXNLivR6zNVXc53w-1; Wed, 06 Apr 2022 12:06:44 -0400
X-MC-Unique: FqtKPzdXNLivR6zNVXc53w-1
Received: by mail-wm1-f72.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so1513737wmk.6
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Apr 2022 09:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2VH15DInn1AZtnEsLb+elNYhtkABvKZLJ4uYvk26l8=;
        b=O1m8jjnA7z0Olm217qKse8w2fxOsSussvKtk+t3Z4a057BMl0920F6TTqdo08MT2J4
         Bzf6D3j1Gu55T8m8S1UTMoihuwr2URb64FRCCDiVGJdpDuNlUoEP3ZIcjeb1VhAHuPJL
         RmQSoTbEBymRmFBFB5An0x1kWPMAUEWfcSNdT8j8QcMQTXTpDAggBC029hAr4YnrP2Zn
         Funp5LCiIewIjNPOW77YcaPRXUai/5uqbuqMJ8RYAhk11XAxV/cB6JQWu1rN9xlY7dnk
         eDeBhrWHGFfWKhGFngL0aupUHeo9ki2djfLibGNL7Io0RRjuxvWaaYKjrlLjYEC/cly4
         rnIw==
X-Gm-Message-State: AOAM530MzNkAEkXFKWV/S96GcDUARspuslrvvC4BZ0FhnungfEbUYz7i
        ZrZA2KxQxd1dArSpE5IfbwbxWz4hJbfhS13jS9iXq6xmaHca6LY94Wub3z/wJMiKPEffaMpSGc8
        H9M9oTg3VR2KCPmESzPmP8fQ=
X-Received: by 2002:a05:600c:b55:b0:38e:70e7:511f with SMTP id k21-20020a05600c0b5500b0038e70e7511fmr8332651wmr.178.1649261203159;
        Wed, 06 Apr 2022 09:06:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7yE8td6/fkffNhvrsqmHf15H0cuBaZltuOzDP9IJ5K6fOajl4WM2WGSsI9m1B/7+4GryIGA==
X-Received: by 2002:a05:600c:b55:b0:38e:70e7:511f with SMTP id k21-20020a05600c0b5500b0038e70e7511fmr8332625wmr.178.1649261202834;
        Wed, 06 Apr 2022 09:06:42 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 0/5] Fix some race conditions that exists between fbmem and sysfb
Date:   Wed,  6 Apr 2022 18:06:27 +0200
Message-Id: <20220406160632.496684-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

The patches in this series are mostly changes suggested by Daniel Vetter
to fix some race conditions that exists between the fbdev core (fbmem)
and sysfb with regard to device registration and removal.

For example, it is currently possible for sysfb to register a platform
device after a real DRM driver was registered and requested to remove the
conflicting framebuffers.

A symptom of this issue, was worked around with by commit fb561bf9abde
("fbdev: Prevent probing generic drivers if a FB is already registered")
but that's really a hack and should be reverted.

This series attempt to fix it more properly and reverted the mentioned
hack. This will also unblock a pending patch to not make num_registered_fb
visible to drivers anymore, since that's really internal to fbdev core.

Patch #1 is just a trivial preparatory change.

Patch #2 add sysfb_disable() and sysfb_try_unregister() helpers for fbmem
to use them.

Patch #3 changes how is dealt with conflicting framebuffers unregistering,
rather than having a variable to determine if a lock should be take, it
just drops the lock before unregistering the platform device.

Patch #4 fixes the mentioned race conditions and finally patch #5 is the
revert patch that was posted by Daniel before but he dropped from his set.

The patches were tested on a rpi4 using different video configurations:
(simpledrm -> vc4 both builtin, only vc4 builtin, only simpledrm builtin
and simpledrm builtin with vc4 built as a module).

I'm sending as an RFC since there are many changes to the locking scheme
and that is always tricky to get right. Please let me know what you think.

Best regards,
Javier


Daniel Vetter (1):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"

Javier Martinez Canillas (4):
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add helpers to unregister a pdev and disable
    registration
  fbdev: Restart conflicting fb removal loop when unregistering devices
  fbdev: Fix some race conditions between fbmem and sysfb

 drivers/firmware/sysfb.c          | 51 ++++++++++++++++++++++++++-----
 drivers/firmware/sysfb_simplefb.c | 24 +++++++++------
 drivers/video/fbdev/core/fbmem.c  | 38 ++++++++++++++++++-----
 drivers/video/fbdev/efifb.c       | 11 -------
 drivers/video/fbdev/simplefb.c    | 11 -------
 include/linux/fb.h                |  1 -
 include/linux/sysfb.h             | 27 +++++++++++++---
 7 files changed, 111 insertions(+), 52 deletions(-)

-- 
2.35.1

