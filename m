Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41184C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Apr 2022 21:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbiDFVvg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiDFVvK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Apr 2022 17:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25F3B8B6E5
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Apr 2022 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HYliOFP5D5aEhYg/JNms+LtE3G2AOKbcjH7HxyHb8vw=;
        b=dYWr3V0/ImRW8fUQa2rxvy/atfliw5zGCuc8lxlRiCVXGIWhk1o7Itg+FiFqwpZx0iQ4PP
        W2JnoX0Uw2ggpiKTsMFFVTr54rH8XpPmIk3j+l5TVgJQir+OOGloUAfny/Bu2EJ4ifqk5K
        k+sbhl1Q4ylHPiO0jyJcfJpZ2w2nhzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-462-UkDvwAlAO_ay3paN5cWk_g-1; Wed, 06 Apr 2022 17:40:51 -0400
X-MC-Unique: UkDvwAlAO_ay3paN5cWk_g-1
Received: by mail-wm1-f71.google.com with SMTP id 189-20020a1c02c6000000b0038e6c4c6472so3546000wmc.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Apr 2022 14:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYliOFP5D5aEhYg/JNms+LtE3G2AOKbcjH7HxyHb8vw=;
        b=mdq6tIuZIyACcDCKeikJGJq0gY87x0aR8fwRytJlk7m8/kdzSqLzjUpTsbKBDmvXmV
         4r6xMlNgjlWSHzMyoG9/qDzddv9FENMB+7UpVBFFLRvXnjz6/p6f83Mh6XtzTc01gtxm
         /EpHFU/G5w65kI9C9q1lxwKZjRVd6vl2wOzrSIAe2uOMA5Q4OsMcKO49CNAswYuUNSnq
         FHLNiUMcSIzQsxFgbmPsizdA2CCcTwMoAZ1FzfYMWg+2iLxfEQWgDJ8EAv56ri0lpihO
         9Gt6mGbxYWk9cQnPMLNX6aLIcN5mPKN9ydaRmWsKFYvyQZoJxl+IIYbFGz+lhaxXzc/J
         Xgdw==
X-Gm-Message-State: AOAM5329FH9AjlDcFNopOTu0k7+p85a59sOiwYLusuWB1G63l9XwVE+A
        ZYDj2z4xywJIME65IwztSpWAmgl+DOpMfvTjduYWdD0sX2dreE1iu+a/+kDV8iirhYv/PvBkGYz
        mspj/JgjM79lk0PmrDVQb+bw=
X-Received: by 2002:a7b:c111:0:b0:38e:7077:e650 with SMTP id w17-20020a7bc111000000b0038e7077e650mr9147317wmi.114.1649281250343;
        Wed, 06 Apr 2022 14:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6hhwgShELHlodQTRxrKt29AWUJxRNlWgookBuUhICSyykfZrbEYfYfVmqPCNphwSJ5AP/dw==
X-Received: by 2002:a7b:c111:0:b0:38e:7077:e650 with SMTP id w17-20020a7bc111000000b0038e7077e650mr9147307wmi.114.1649281250073;
        Wed, 06 Apr 2022 14:40:50 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
Subject: [RESEND RFC PATCH 0/5] Fix some race conditions that exists between fbmem and sysfb
Date:   Wed,  6 Apr 2022 23:39:14 +0200
Message-Id: <20220406213919.600294-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

[ resend since dri-devel wasn't Cc'ed on all patches, sorry for the noise ]

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
 include/linux/sysfb.h             | 29 +++++++++++++++---
 7 files changed, 112 insertions(+), 53 deletions(-)

-- 
2.35.1

