Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72369C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351AA22210
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3dmwBXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgK1CaI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgK0T6d (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:33 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02878C0613D4
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:32 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id q13so7863793lfr.10
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GBucTroFP+M0Yy64eG6RzrvScB9IstEoTS95L4tQgXY=;
        b=W3dmwBXjuIPRH7fZg2XcDakW3tYopwPAkXNSUf0wmgR22IRn5UsZcUY8CzR6jI/yjo
         Nik/vdEMXu3yiWCFCI0nbdaS1RwG4U1MjpKBtEbWkgZ4iwUZIt1nzEkpiaCsEVlZdM3m
         R3ZGihrm6/pvVZqRR33bh5c6oCuYI6Exodu5oaAjZ86FpsbabRbFk0HHvQzr7QSIt/5Q
         cmGf2VI1o5SENT6BoE9mC4MNH0+WgUc3HrNmu0abqNAFIgnvCSTC4LAajxjoqqNytV+n
         pWTs80SwGCMs5eI67g3h/ybkdSM9dD06XfXdjCxQi1KPFXdgqXlayGM3WhJ8WLgPnMDd
         XXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GBucTroFP+M0Yy64eG6RzrvScB9IstEoTS95L4tQgXY=;
        b=f609VNCzYBQza44X4lfcPffF6iigdXBwvr+A+x/D853oog4PfU0k3lD4VmkSx2pxbA
         kgX7v1WnYIgVE/KCUEoXqesM114uirTEYPgPdHsAUyR1GldQMV6GmGGfLu9Xwdm1CYgP
         KMjD+huAb5eVSeoh1sKmhY0pg9nAikXTz0Xwo/EY53ixIRAfMzDh5AinXCt0oc0CakTi
         1Ind3M95zzGKTYR94IQu9Z7Zrt4YmK6jgjnSmKLuz/rItuVzcbTUbrVqnRJ1tx0dXQyG
         PgKwR1v6Nvimxqa8a9yu7tHpxGxr3DcVKik+hEhvaylVl8ROq5PhVD2XZwNxaZJnp0qc
         //tg==
X-Gm-Message-State: AOAM533utRVmIeUyN1I3VE76lAjZ3dprJQLxsRSDUTlvrqvlF7FUFs3Y
        Zc3/kXJT1WRyTHHdu84ulUsYM1p8jHh9WIXa
X-Google-Smtp-Source: ABdhPJylIAu0KLBIroXyb9tC6gYTQuiUvN1EGzZkoJWcx5F+Qm8SIjI4a/0nnL+xr//qgqf4s4x9Hg==
X-Received: by 2002:ac2:428d:: with SMTP id m13mr4080520lfh.137.1606507111125;
        Fri, 27 Nov 2020 11:58:31 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:30 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
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
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
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
Subject: [PATCH v1 0/28] drivers/video: W=1 warning fixes
Date:   Fri, 27 Nov 2020 20:57:57 +0100
Message-Id: <20201127195825.858960-1-sam@ravnborg.org>
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

	Sam


Sam Ravnborg (28):
      video: Fix W=1 warnings in of_videomode + of_display_timing
      video: fbcon: Use pr_debug() in fbcon
      video: fbdev: core: Fix W=1 warnings in fbmon + fb_notify
      video: fbdev: aty: Delete unused variable in radeon_monitor
      video: fbdev: aty: Fix W=1 warnings in atyfb_base
      video: fbdev: aty: Fix W=1 warnings in mach64_ct
      video: fbdev: sis: Fix W=1 warnings about static symbols
      video: fbdev: sis: Fix W=1 warning about SiS_TVDelay
      video: fbdev: sis: Fix W=1 warnings in init.c
      video: fbdev: sis: Fix W=1 warnings in sis_main
      video: fbdev: via: Fix W=1 warnings
      video: fbdev: tdfx: Fix W=1 warnings
      video: fbdev: riva: Fix W=1 warnings
      video: fbdev: pm2fb: Fix W=1 warnings
      video: fbdev: neofb: Fix W=1 warnings
      video: fbdev: hgafb: Fix W=1 warnings
      video: fbdev: tgafb: Fix W=1 warnings
      video: fbdev: mx3fb: Fix W=1 warnings
      video: fbdev: sstfb: Fix W=1 warnings
      video: fbdev: nvidia: Fix W=1 warnings
      video: fbdev: tmiofb: Fix W=1 warnings
      video: fbdev: omapfb: Fix W=1 warnings in dsi
      video: fbdev: omapfb: Fix W=1 warnings in hdmi*_core
      video: fbdev: s3c-fb: Fix W=1 warnings
      video: fbdev: uvesafb: Fix W=1 warning
      video: fbdev: uvesafb: Fix W=1 string related warnings
      video: fbdev: cirrusfb: Fix W=1 warnings
      video: fbdev: s1d13xxxfb: Fix W=1 warnings

 drivers/video/fbdev/aty/atyfb_base.c              | 12 ++------
 drivers/video/fbdev/aty/mach64_ct.c               | 15 ++++++----
 drivers/video/fbdev/aty/radeon_monitor.c          |  4 +--
 drivers/video/fbdev/cirrusfb.c                    | 20 ++++++-------
 drivers/video/fbdev/core/fb_notify.c              |  3 +-
 drivers/video/fbdev/core/fbcon.c                  | 20 ++++---------
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
 32 files changed, 104 insertions(+), 169 deletions(-)


