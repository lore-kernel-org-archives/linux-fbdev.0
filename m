Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05462C63777
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF6020702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCKLS+sr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbgK1WmD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgK1WmC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:02 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590E4C0613D1
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u19so12750497lfr.7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=es1AAe0TaPdJSHZcrk9xRxI2zSN1z9e2u/YAIJUcPNw=;
        b=vCKLS+srhrN0XNUrKEXWi07drCxDzrzfD7pdaFGh0I9d3NOazGbiNW+/QOWUi1Uzpb
         fxb6q1bv6exZXioWVBW0ty6q2wtzJCtnls5dMdxGGt49C7yUkWrH5KtiTSN4UBeQWUYV
         Y+QXYeaYVD1MSsmfEMK6Cg98EjGJPS1h+S/wXGHPigLOQuzakkdYVjneojpC8uvpDAdP
         eEDdvKbOoiVObXe2T6PVcUy5k+EVC1TMTSx5/ogvfCaa7hWXcCKnyOTqhtdp/8q5i4WU
         fgZjqvCbGnfd9P7PoAvuqhFxFYojxAxd2sb+3Qm+VtfsN26VBVsITX6LcU8mkDzjiOlI
         i4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=es1AAe0TaPdJSHZcrk9xRxI2zSN1z9e2u/YAIJUcPNw=;
        b=IKtBsjaXhTzcnuW/JhGCVopT+gJPj6WOIfSYQooW3+wDhyOg4LCyUZntVlG24gxuBp
         U+g0wV/ow4a28MBTuM1jubz+EbC/dCWaQcZpJVvGNBBuQfdDIBnDgNJ6V1zJxFcXqqLa
         kgwRNTZ76G8WEB5bhndlGNtzH09YiTVdHt88ufr/k/mQp7kprsrSju+nt9JOHtU/ZGO0
         oYLh2V11Tghn8JOun+FiPJ+yOyDd1kPnjkuQ/bf6jVSvwdK0IxisxSqyd9i3CElMnv+Z
         8v5P1mfoTVFCRnRstNq0Ps4UOUdX0Y6+nUtujVnPsFWvlPjcaFbLYGOUOt9z7gL6zJew
         E2tw==
X-Gm-Message-State: AOAM531wdwcseQPmPpOtgAKerBAlDeg3MwX7Jr0t9K2U6AvSlR4x5T/N
        r9rfdGwk8Y8RzTbj2Zp1m6+xHZScOxJW4g==
X-Google-Smtp-Source: ABdhPJxKFOaPRHulRxMfEZD7C6TvGRPUrDJjwXxOxPEC/xfnR/UxMWDFAhxDQgTcKvdEkF46U2xY7A==
X-Received: by 2002:a19:d02:: with SMTP id 2mr6550674lfn.294.1606603280421;
        Sat, 28 Nov 2020 14:41:20 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:19 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v2 0/28] drivers/video: W=1 warning fixes
Date:   Sat, 28 Nov 2020 23:40:46 +0100
Message-Id: <20201128224114.1033617-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Following the great work of Lee Jones in other subsystems
here is a set of patches that address all remaining W=1
warnings in drivers/video/.
Lee Jones already fixed all warnings in video/backlight/ so
this is mostly fbdev related fixes.

The general approach used were:
- Fix kernel-doc, this is often very trivial
- Drop unused local variables
- Use no_printk for local logging support

Build tested on a set of architectures with various configs.

The patches do not depends on each other and in most cases all
fixes for one driver is kept in a single patch.

The individual changes are trivial so this is a great
starter task to try to review these patches.

A timely Reviewed-by: or Acked-by: would be very nice so we can
get the warnings fixes before we cut for the merge window.

v2:
  - Updated subject of the patches to tell what was fixed (Lee)
  - Fixed build error in one patch (kernel test robot)
  - A few editorials updates to the changelog messages

	Sam

Sam Ravnborg (28):
      video: Fix kernel-doc warnings in of_display_timing + of_videomode
      video: fbcon: Fix warnings by using pr_debug() in fbcon
      video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
      video: fbdev: aty: Delete unused variable in radeon_monitor
      video: fbdev: aty: Fix set but not used warnings
      video: fbdev: aty: Fix set but not used warnings in mach64_ct
      video: fbdev: sis: Fix defined but not used warnings
      video: fbdev: sis: Fix defined but not used warning of SiS_TVDelay
      video: fbdev: sis: Fix set but not used warnings in init.c
      video: fbdev: sis: Fix set but not used warnings in sis_main
      video: fbdev: via: Fix set but not used warning for mode_crt_table
      video: fbdev: tdfx: Fix set but not used warning in att_outb()
      video: fbdev: riva: Fix kernel-doc and set but not used warnings
      video: fbdev: pm2fb: Fix kernel-doc warnings
      video: fbdev: neofb: Fix set but not used warning for CursorMem
      video: fbdev: hgafb: Fix kernel-doc warnings
      video: fbdev: tgafb: Fix kernel-doc and set but not used warnings
      video: fbdev: mx3fb: Fix kernel-doc, set but not used and string warnings
      video: fbdev: sstfb: Updated logging to fix set but not used warnings
      video: fbdev: nvidia: Fix set but not used warnings
      video: fbdev: tmiofb: Fix set but not used warnings
      video: fbdev: omapfb: Fix set but not used warnings in dsi
      video: fbdev: omapfb: Fix set but not used warnings in hdmi*_core
      video: fbdev: s3c-fb: Fix kernel-doc and set but not used warnings
      video: fbdev: uvesafb: Fix set but not used warning
      video: fbdev: uvesafb: Fix string related warnings
      video: fbdev: cirrusfb: Fix kernel-doc and set but not used warnings
      video: fbdev: s1d13xxxfb: Fix kernel-doc and set but not used warnings

 drivers/video/fbdev/aty/atyfb_base.c              | 11 +++-----
 drivers/video/fbdev/aty/mach64_ct.c               | 15 ++++++----
 drivers/video/fbdev/aty/radeon_monitor.c          |  4 +--
 drivers/video/fbdev/cirrusfb.c                    | 20 ++++++-------
 drivers/video/fbdev/core/fb_notify.c              |  3 +-
 drivers/video/fbdev/core/fbcon.c                  | 25 ++++++-----------
 drivers/video/fbdev/core/fbmon.c                  |  2 +-
 drivers/video/fbdev/hgafb.c                       |  4 +--
 drivers/video/fbdev/mx3fb.c                       | 13 +++++----
 drivers/video/fbdev/neofb.c                       |  4 ---
 drivers/video/fbdev/nvidia/nv_setup.c             |  7 ++---
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c        | 12 ++------
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c |  4 +--
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c |  4 +--
 drivers/video/fbdev/pm2fb.c                       |  8 +++---
 drivers/video/fbdev/riva/fbdev.c                  |  9 +++---
 drivers/video/fbdev/riva/riva_hw.c                | 28 ++++++-------------
 drivers/video/fbdev/s1d13xxxfb.c                  |  3 +-
 drivers/video/fbdev/s3c-fb.c                      | 11 ++++----
 drivers/video/fbdev/sis/init.c                    | 34 ++++-------------------
 drivers/video/fbdev/sis/oem310.h                  |  2 ++
 drivers/video/fbdev/sis/sis.h                     |  1 -
 drivers/video/fbdev/sis/sis_main.c                |  9 +++---
 drivers/video/fbdev/sstfb.c                       |  2 +-
 drivers/video/fbdev/tdfxfb.c                      |  4 +--
 drivers/video/fbdev/tgafb.c                       |  7 ++---
 drivers/video/fbdev/tmiofb.c                      |  6 ++--
 drivers/video/fbdev/uvesafb.c                     |  8 +++---
 drivers/video/fbdev/via/lcd.c                     |  4 +--
 drivers/video/of_display_timing.c                 |  1 +
 drivers/video/of_videomode.c                      |  8 +++---
 include/video/sstfb.h                             |  4 +--
 32 files changed, 107 insertions(+), 170 deletions(-)


