Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF5C4361B
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768B22333D
	for <linux-fbdev@archiver.kernel.org>; Sun,  6 Dec 2020 19:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgLFTDn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 6 Dec 2020 14:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLFTDm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 6 Dec 2020 14:03:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E678C0613D0
        for <linux-fbdev@vger.kernel.org>; Sun,  6 Dec 2020 11:02:56 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id x23so5655468lji.7
        for <linux-fbdev@vger.kernel.org>; Sun, 06 Dec 2020 11:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gOK5EsUnBK6I0SB14+NAG+xJwYrELRFSAKPeWrBBqm0=;
        b=F5B/Dk2Vkp1/cK20z+ZEyqFMI4MhCOK1at24ue0UjfUbKVxXzUto9EPpBz17r9aNxb
         DQ+iCsfg16Ld/0BdlTVRJNUUBu/KoAZWu9eHkNiITsc3fUwfAXS3AE1WbkqIsVlhVZTz
         e228UaP+a+H4XJJ6fclx3ZCzVrkeqzV8iToa1GWcc3fxpT5EkwRuTlrenhEX2CfUisdz
         LFd7aVe8D3edJSf+5+ODMl8qKNBfWwChQzsHZrOPSq0cj+SQsAL3lLaIbzyzrQhxToV/
         2k5Zv+Gfrl9Dah/SGX98ZRI7J/Qvy5bdprVwcTTtwFyKIDcQUxeGexXpSTIe0k5AqJHw
         94Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=gOK5EsUnBK6I0SB14+NAG+xJwYrELRFSAKPeWrBBqm0=;
        b=q4bvXp3MUuc3nJ1cZUubIJjhKYQmak8EEuVKZJfiFy9LN/zOMabaer2b/ker+9rKoA
         TVpeeG92uh6mefenuW9/wnEUZCHgYMG7x+9KJ0rRUGSE1LOH6WukRSZtYHvjbWsg4RvT
         HKfJpAUVWkOLeCrWwfWu4d1mJiB/wXxTKv3iIbHXM4sxXpds1jGjCZOvSNvTrCvWEz50
         WMnFwADuYVPy7eO0z9ybsyTIiSrKX+h6ngp40fT7u/GOX0B6InenNeQiZ7L+/2PUQLg8
         AwX1kj6wBHLxBH+9Hvgd4qt8rS78ddbpowlm8T2ZnmMdN5FmdvDJUL6i/+ohn0vgLGwc
         CzFA==
X-Gm-Message-State: AOAM531cl90HBVp/VfiVkzcvyARalwlX+lh3aJmawDRCo245f9P6JQNk
        A4EryO+TliK6z6hcd6LKd+3mBUOJLA2qlg==
X-Google-Smtp-Source: ABdhPJyqzMYmJv7+YC6fIUFr0DLw7ne5V1xvD/3AheCOymxXwONczk9HXcZoCzmw03frYFQO64dxOA==
X-Received: by 2002:a2e:5750:: with SMTP id r16mr7150233ljd.61.1607281374626;
        Sun, 06 Dec 2020 11:02:54 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:c1c3:bbc6:3ac5:732d])
        by smtp.gmail.com with ESMTPSA id v28sm2483865ljv.29.2020.12.06.11.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 11:02:54 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Klimov <grandmaster@al2klimov.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Colin Ian King <colin.king@canonical.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Gustavo A R Silva <gustavoars@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>, Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH v3 0/13] drivers/video: W=1 warning fixes
Date:   Sun,  6 Dec 2020 20:02:34 +0100
Message-Id: <20201206190247.1861316-1-sam@ravnborg.org>
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

Build tested on a set of architectures with various configs.

The patches do not depend on each other and fixes for one driver
are kept in a single patch.

v2:
  - Updated subject of the patches to tell what was fixed (Lee)
  - Fixed build error in one patch (kernel test robot)
  - A few editorials updates to the changelog messages

v3:
  - Applied patches that was acked - thanks Thomas!
  - Updated patches after feedback from Randy and Thomas
  - Added several new patches to cover warnings that triggers
    with other architectures than the one I used for v1 + v2
  - Included one sh specific fix that handle a corner-case,
    let's see what the sh people say to that
  - One fix to previous set of patches to fix an issue
    reported by Coverity (By Colin)

	Sam

Sam Ravnborg (13):
      video: fbdev: hgafb: Fix kernel-doc warnings
      video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
      video: fbdev: omapfb: Fix set but not used warnings in hdmi*_core
      video: fbdev: uvesafb: Fix set but not used warning
      sh: Fix set but not used warnings with !CONFIG_MMU
      video: fbdev: sparc drivers: fix kernel-doc warnings for blank_mode
      video: fbdev: mmp: Fix kernel-doc warning for lcd_spi_write
      video: fbdev: wmt_ge_rops: Fix function not declared warnings
      video: fbdev: goldfishfb: Fix defined but not used warning
      video: fbdev: gbefb: Fix set but not used warning
      video: fbdev: efifb: Fix set but not used warning for screen_pitch
      video: fbdev: controlfb: Fix set but not used warnings
      video: fbdev: sis: Drop useless call to SiS_GetResInfo()


 arch/sh/include/asm/io.h                          |  2 +-
 drivers/video/fbdev/bw2.c                         |  2 +-
 drivers/video/fbdev/cg3.c                         |  2 +-
 drivers/video/fbdev/cg6.c                         |  2 +-
 drivers/video/fbdev/controlfb.c                   |  4 ++--
 drivers/video/fbdev/core/fb_notify.c              | 10 ++++++++++
 drivers/video/fbdev/core/fbmon.c                  |  2 +-
 drivers/video/fbdev/efifb.c                       |  3 +--
 drivers/video/fbdev/ffb.c                         |  2 +-
 drivers/video/fbdev/gbefb.c                       |  4 +---
 drivers/video/fbdev/goldfishfb.c                  |  2 ++
 drivers/video/fbdev/hgafb.c                       | 10 +++++-----
 drivers/video/fbdev/leo.c                         |  2 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c              |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c |  4 ++--
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c |  4 ++--
 drivers/video/fbdev/p9100.c                       |  2 +-
 drivers/video/fbdev/sis/init.c                    |  1 -
 drivers/video/fbdev/tcx.c                         |  2 +-
 drivers/video/fbdev/uvesafb.c                     |  2 ++
 drivers/video/fbdev/wmt_ge_rops.c                 |  1 +
 21 files changed, 38 insertions(+), 27 deletions(-)


