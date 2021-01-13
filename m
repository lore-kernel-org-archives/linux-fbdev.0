Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B114C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EB235FF
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbhAMOu4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhAMOuz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:50:55 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3438BC061794
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:15 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c124so1836295wma.5
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQA0SZS1JjhX66Y3VfvSEDt+f937BTntRK0+0hGKg34=;
        b=MwG9/Qb6GaHppLStwh0d8g1sY54LVGRwX3gXPZ3kQgCT9ZIDpmtPk7cscnHIZBHdIT
         6uFVdU4FQdl4gZYI9xks/jTNsVnE6HnH0Js2wu1T1BLUnMnVGvl8dYPIRb0XB7rwP1PV
         PqCc86pEjQfUdgzibMJ9yPZcNC63MCHC+5JmnZS6Q5ru0WjX4d6UxjertOoZJXpWFqB4
         9Otj49ELyBLyKb8lFCpERdPWMl0XuIb/G1737c6sgQu5FeLzATgOgrfq09jZPss8N9MR
         eQH5FtIMvUPKiqCGu+dFedTgUDGRI03g9F5N76w/Ez4e/XK25iX0sBLYXYVw5aWdGjgI
         bFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZQA0SZS1JjhX66Y3VfvSEDt+f937BTntRK0+0hGKg34=;
        b=U245XqhdwI5By4kEb3Ne+9QUUatMdm4em6NLR/FYbK5vi/AyNFaGMhENNwrbg3SsMr
         0Vxe6M/Lh/y259PZGnZKRd/JOLPPZQ/+Y/TbttxXrZH2HQAo32eF/hM+GmJAk5042cF8
         AIEIwgMAx6YLS8upTuAxMzSdeSTOcIc5a6MoC/pNgzXOm71QIZkEC+g511XsirdNzOiC
         4ymW62yorLsrYQb7mywRmoHEvoOxnZLTiH7RLOXW3h+bcmElnXAyr0QHe8e5Svg0neEP
         XIi/cLNmniLmWhy4FpcDRgIyJtCK4jsZRNZhaMjmpOLJ1AwhiOjKUbl9F7s8E5YmixVv
         NLTg==
X-Gm-Message-State: AOAM530w30q/3wo8eYYjVmZ8K3IqnMDfabAiJc6tSJJGj8ftW+MV4mqB
        YuBpCbnJ5dx/AzGYAJfmzKGz4w==
X-Google-Smtp-Source: ABdhPJyo01wJxIFaqfZaXsoDcuI6YydBQRYmxjlBlLsIvZ45jzX5rh/ERwTAcG1tKBC+qAUFjEGQyw==
X-Received: by 2002:a1c:ba07:: with SMTP id k7mr2582205wmf.34.1610549413750;
        Wed, 13 Jan 2021 06:50:13 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:12 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Alex Kern <alex.kern@gmx.de>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Ani Joshi <ajoshi@unixbox.com>, Anthony Tong <atong@uiuc.edu>,
        Antonino Daplas <adaplas@gmail.com>,
        Antonino Daplas <adaplas@pol.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Ben Dooks <ben@simtec.co.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brad Douglas <brad@neruo.com>, carter@compsci.bristol.ac.uk,
        daniel.mantione@freepascal.org, dri-devel@lists.freedesktop.org,
        "Eddie C. Dost" <ecd@skynet.be>,
        Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>,
        Emmanuel Marty <core@ggi-project.org>,
        Evgeny Novikov <novikov@ispras.ru>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Frodo Looijaard <frodol@dds.nl>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hannu Mallat <hmallat@cc.hut.fi>, Helge Deller <deller@gmx.de>,
        Ilario Nardinocchi <nardinoc@CS.UniBO.IT>,
        Jakub Jelinek <jakub@redhat.com>,
        Jakub Jelinek <jj@ultra.linux.cz>,
        James Simmons <jsimmons@infradead.org>,
        James Simmons <jsimmons@users.sf.net>,
        Jeff Garzik <jgarzik@pobox.com>, Jes Sorensen <jds@kom.auc.dk>,
        Jim Hague <jim.hague@acm.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        John Fremlin <vii@users.sourceforge.net>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        linux-fbdev@vger.kernel.org,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        Martin Mares <mj@ucw.cz>, Mike Rapoport <rppt@kernel.org>,
        Oliver Kropp <dok@directfb.org>,
        Paul Mundt <lethal@chaoticdreams.org>,
        Philip Edelbrock <phil@netroedge.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Software Engineering <lg@denx.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Urs Ganse <ursg@uni.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        William Rucklidge <wjr@cs.cornell.edu>
Subject: [PATCH 00/31] Rid W=1 warnings from Video
Date:   Wed, 13 Jan 2021 14:49:38 +0000
Message-Id: <20210113145009.1272040-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This patch-set clears all of the W=1 warnings currently residing
in drivers/video.

Lee Jones (31):
  video: fbdev: core: fbmon: Add missing description for 'specs'
  video: of_display_timing: Provide missing description for 'dt'
  video: fbdev: aty: atyfb_base: Remove superfluous code surrounding
    'dac_type'
  video: fbdev: aty: atyfb_base: Mark 'dac_type' as __maybe_unused
  video: of_videomode: Fix formatting in kernel-doc header
  video: fbdev: core: fb_notify: Demote non-conformant kernel-doc header
  video: fbdev: riva: fbdev: Fix some kernel-doc misdemeanours
  video: fbdev: sis: sis_main: Remove unused variable 'reg'
  video: fbdev: sis: Remove superfluous include of 'init.h'
  video: fbdev: riva: riva_hw: Remove a bunch of unused variables
  video: fbdev: sis: init: Remove four unused variables
  video: fbdev: sis: oem310: Remove some unused static const tables
  video: fbdev: nvidia: nv_setup: Remove a couple of unused 'tmp'
    variables
  video: fbdev: aty: mach64_ct: Remove some set but unused variables
  video: fbdev: via: lcd: Remove unused variable 'mode_crt_table'
  video: fbdev: pm2fb: Fix some kernel-doc formatting issues
  video: fbdev: aty: radeon_monitor: Remove unused variable 'mon_types'
  video: fbdev: neofb: Remove unused variable 'CursorMem'
  video: fbdev: tdfxfb: Remove unused variable 'tmp'
  video: fbdev: core: fbcon: Mark 'pending' as __maybe_unused
  video: fbdev: sstfb: Mark 3 debug variables as __maybe_unused
  video: fbdev: cirrusfb: Remove unused variable 'dummy' from 'WHDR()'
  video: fbdev: s1d13xxxfb: Mark debug variables as __maybe_unused
  video: fbdev: s3c-fb: Fix some kernel-doc misdemeanours
  video: fbdev: mx3fb: Remove unused variable 'enabled'
  video: fbdev: riva: riva_hw: Remove set but unused variables 'vus_p'
    and 'vus_n'
  video: fbdev: sis: init: Remove unused variables 'cr_data2', 'VT' and
    'HT'
  video: fbdev: cirrusfb: Add description for 'info' and correct
    spelling of 'regbase'
  video: fbdev: s1d13xxxfb: Function name must be on the 2nd line in
    kernel-doc
  video: fbdev: s3c-fb: Remove unused variable 'var' from
    's3c_fb_probe_win()'
  video: fbdev: mx3fb: Fix some kernel-doc issues

 drivers/video/fbdev/aty/atyfb_base.c     |  5 +---
 drivers/video/fbdev/aty/mach64_ct.c      | 19 ++-----------
 drivers/video/fbdev/aty/radeon_monitor.c |  4 +--
 drivers/video/fbdev/cirrusfb.c           | 20 +++++++-------
 drivers/video/fbdev/core/fb_notify.c     |  3 +--
 drivers/video/fbdev/core/fbcon.c         |  2 +-
 drivers/video/fbdev/core/fbmon.c         |  2 +-
 drivers/video/fbdev/mx3fb.c              | 11 ++++----
 drivers/video/fbdev/neofb.c              |  5 ----
 drivers/video/fbdev/nvidia/nv_setup.c    |  8 ++----
 drivers/video/fbdev/pm2fb.c              | 12 ++++-----
 drivers/video/fbdev/riva/fbdev.c         | 15 ++++-------
 drivers/video/fbdev/riva/riva_hw.c       | 30 +++++++--------------
 drivers/video/fbdev/s1d13xxxfb.c         |  5 ++--
 drivers/video/fbdev/s3c-fb.c             | 11 ++++----
 drivers/video/fbdev/sis/init.c           | 34 +++++-------------------
 drivers/video/fbdev/sis/oem310.h         | 20 --------------
 drivers/video/fbdev/sis/sis.h            |  1 -
 drivers/video/fbdev/sis/sis_main.c       |  9 +++----
 drivers/video/fbdev/sstfb.c              |  2 +-
 drivers/video/fbdev/tdfxfb.c             |  4 +--
 drivers/video/fbdev/via/lcd.c            |  4 +--
 drivers/video/of_display_timing.c        |  1 +
 drivers/video/of_videomode.c             | 10 +++----
 24 files changed, 72 insertions(+), 165 deletions(-)

Cc: Alan Cox <alan@redhat.com>
Cc: Alex Dewar <alex.dewar90@gmail.com>
Cc: Alex Kern <alex.kern@gmx.de>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Ani Joshi <ajoshi@unixbox.com>
Cc: Anthony Tong <atong@uiuc.edu>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Antonino Daplas <adaplas@pol.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Brad Douglas <brad@neruo.com>
Cc: carter@compsci.bristol.ac.uk
Cc: daniel.mantione@freepascal.org
Cc: dri-devel@lists.freedesktop.org
Cc: "Eddie C. Dost" <ecd@skynet.be>
Cc: Egbert Eich <Egbert.Eich@Physik.TU-Darmstadt.DE>
Cc: Emmanuel Marty <core@ggi-project.org>
Cc: Evgeny Novikov <novikov@ispras.ru>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Frodo Looijaard <frodol@dds.nl>
Cc: Gerd Knorr <kraxel@goldbach.in-berlin.de>
Cc: Ghozlane Toumi <gtoumi@laposte.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Hannu Mallat <hmallat@cc.hut.fi>
Cc: Helge Deller <deller@gmx.de>
Cc: Ilario Nardinocchi <nardinoc@CS.UniBO.IT>
Cc: Jakub Jelinek <jakub@redhat.com>
Cc: Jakub Jelinek <jj@ultra.linux.cz>
Cc: James Simmons <jsimmons@infradead.org>
Cc: James Simmons <jsimmons@users.sf.net>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: Jes Sorensen <jds@kom.auc.dk>
Cc: Jim Hague <jim.hague@acm.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: John Fremlin <vii@users.sourceforge.net>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: "Mark D. Studebaker" <mdsxyz123@yahoo.com>
Cc: Martin Mares <mj@ucw.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oliver Kropp <dok@directfb.org>
Cc: Paul Mundt <lethal@chaoticdreams.org>
Cc: Philip Edelbrock <phil@netroedge.com>
Cc: Ralph Metzler <rjkm@thp.uni-koeln.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Software Engineering <lg@denx.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Thibaut VARENE <varenet@parisc-linux.org>
Cc: "Thomas J. Moore" <dark@mama.indstate.edu>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Urs Ganse <ursg@uni.de>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: William Rucklidge <wjr@cs.cornell.edu>
-- 
2.25.1

