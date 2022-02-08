Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFAC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386723AbiBHWX1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386682AbiBHVIb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:31 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A52C0612BA
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso1986124wmh.4
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaQEqDf6woJi3JiGI0Bz61Ya75WtHMc/MVZQW5TAKz8=;
        b=Egg8oW7w6vMCpi1QxSmX4D765EsgDJVXy+e89vdOj8VcgxsKKhCN6MHYC5vkBV761s
         UZkEzvw/pVj18r5pq4K0q9wZy7ZoHXN1MAbHYkOa+oJLstJKNQv5k6+g7Gk+7eItm4GS
         7OnwkrdQ5S0dTeSDESYXlh317nK1+2lW6IHTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eaQEqDf6woJi3JiGI0Bz61Ya75WtHMc/MVZQW5TAKz8=;
        b=0IwE1ok/SPw/yYMUIyLs0q5pwwbmpC51f0XROEkYybyFZ9x0vDOoPB18wERMxZttmd
         XBPqun5Or9/EjxY6MLHyHp7JdFUhAAuEnitxQGA7Bgsa1HWrRdEAD3202QRpuN3zPPNx
         BhZVsYOvrBfmUl3Ot9bwPlT83lnFLJlLfvz0BxxLvayBuN5GZIjqkr+QKftG5M5Cgl5w
         /g5T5hNQrYaLB2YRuh2E8TqUlpuvvf0/u9uDhVmD7y3MWsFN/rEX/kAMUo9hFDgnNj+t
         8WkItPzeMKBG5TAtU+/fBAlG3Yv/FruTfYSEkXC3WdoqXyardsiA5vriCEsvVAqa1j01
         8YiQ==
X-Gm-Message-State: AOAM532YYyFY2wPL5DKVrEO1MxqaMGk1oCyntUi7ebJkEUuVOUasDR9m
        KAgCDJND+LBWnpn4MVZ1Z0lGbA==
X-Google-Smtp-Source: ABdhPJyXbSnYegLxjgnRWGI973+iKOjTBJ+gW9TXNIyD3WsZiijJNxjj56AALEMQ0pOnnNO/sxirJw==
X-Received: by 2002:a05:600c:4854:: with SMTP id j20mr1210243wmo.78.1644354509133;
        Tue, 08 Feb 2022 13:08:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:28 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 00/19] fbcon patches, take two
Date:   Tue,  8 Feb 2022 22:08:05 +0100
Message-Id: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi all,

Second round, mostly just compile fixed and some minor polish to commit
messages. Also MAINTAINERS patch and fbcon scrolling patches are out
because they landed already.

There's still a handful here that need review (and somehow intel-gfx-ci
just keeled over on this).

Cheers, Daniel

Daniel Vetter (19):
  fbcon: delete a few unneeded forward decl
  fbcon: Move fbcon_bmove(_rec) functions
  fbcon: Introduce wrapper for console->fb_info lookup
  fbcon: delete delayed loading code
  fbdev/sysfs: Fix locking
  fbcon: Use delayed work for cursor
  fbcon: Replace FBCON_FLAGS_INIT with a boolean
  fb: Delete fb_info->queue
  fbcon: Extract fbcon_open/release helpers
  fbcon: Ditch error handling for con2fb_release_oldinfo
  fbcon: move more common code into fb_open()
  fbcon: use lock_fb_info in fbcon_open/release
  fbcon: Consistently protect deferred_takeover with console_lock()
  fbcon: Move console_lock for register/unlink/unregister
  fbcon: Move more code into fbcon_release
  fbcon: untangle fbcon_exit
  fbcon: Maintain a private array of fb_info
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"
  fbdev: Make registered_fb[] private to fbmem.c

 drivers/video/fbdev/core/fbcon.c   | 692 ++++++++++++++---------------
 drivers/video/fbdev/core/fbcon.h   |   8 +-
 drivers/video/fbdev/core/fbmem.c   |  35 +-
 drivers/video/fbdev/core/fbsysfs.c |   2 +
 drivers/video/fbdev/efifb.c        |  11 -
 drivers/video/fbdev/simplefb.c     |  11 -
 include/linux/fb.h                 |   8 +-
 7 files changed, 342 insertions(+), 425 deletions(-)

-- 
2.34.1

