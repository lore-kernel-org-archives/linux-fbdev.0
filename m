Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D00C43217
	for <linux-fbdev@archiver.kernel.org>; Fri, 11 Nov 2022 13:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiKKNah (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 11 Nov 2022 08:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiKKNa3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 11 Nov 2022 08:30:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B14F60345
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Nov 2022 05:30:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E80BB225DD;
        Fri, 11 Nov 2022 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668173426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sqR8fK4Evh8rvaVoQyV+qDhALL0xOMiadGIgeuzCylg=;
        b=TFNG64YQqLLS6uAkdE8mQteSg+mhX4F5KEClyCVATRLwdefQJiBg7aaZpZEIMb0+/DX3ir
        ID+P8Gv9TP8VQRO5jyoLc/j3uUf3gGtug8JfjoaY63FlaTpmkWO8LcgnRqfDgvFUMj93TM
        /r8y9PtMUTgRlY5b2TpbG/LwqriPjGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668173426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sqR8fK4Evh8rvaVoQyV+qDhALL0xOMiadGIgeuzCylg=;
        b=opHQMXoWjtzft0NNaCcD75YQGXgd+qL/mEngtLh0mh3YJAvU3T3qjPIW0lVsr/ehCJxka4
        kLpmT9VqFTAJFyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C66A513273;
        Fri, 11 Nov 2022 13:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4F6YL3JObmPCbQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 11 Nov 2022 13:30:26 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/2] video/fbdev: Support 'nomodeset' in PCI drivers
Date:   Fri, 11 Nov 2022 14:30:22 +0100
Message-Id: <20221111133024.9897-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add support for the kernel's 'nomodeset' parameter to PCI-based
fbdev drivers. The option prevents DRM drivers from loading if they
could possibly displace a hardware-agnostic driver that runs on the
firmware framebuffer. It is a fallback for systems on which the
hardware's native driver does not work correctly.

After the work on the aperture helpers and their integration with
fbdev, it can happen that an fbdev driver replaces a hardware-
agnostic DRM driver. Supporting the nomodeset parameter unifies
the behavior among the graphics drivers and subsystems. An fbdev
driver will not replace any hardware-agnostic driver with nomodeset
given.

v2:
	* print warning for disabled drivers (Helge)
	* improve nomodeset docs (Javier)
	* use fbdev-internal helper

Thomas Zimmermann (2):
  drm: Move nomodeset kernel parameter to drivers/video
  fbdev: Add support for the nomodeset kernel parameter

 .../admin-guide/kernel-parameters.txt         | 15 +++++---
 MAINTAINERS                                   |  2 +
 drivers/gpu/drm/Kconfig                       |  7 +---
 drivers/gpu/drm/Makefile                      |  1 -
 drivers/staging/sm750fb/Kconfig               |  1 +
 drivers/staging/sm750fb/sm750.c               |  3 ++
 drivers/video/Kconfig                         |  4 ++
 drivers/video/Makefile                        |  1 +
 drivers/video/fbdev/Kconfig                   | 37 +++++++++++++++++++
 drivers/video/fbdev/arkfb.c                   |  5 +++
 drivers/video/fbdev/asiliantfb.c              |  3 ++
 drivers/video/fbdev/aty/aty128fb.c            |  5 +++
 drivers/video/fbdev/aty/atyfb_base.c          |  5 +++
 drivers/video/fbdev/aty/radeon_base.c         |  5 +++
 drivers/video/fbdev/carminefb.c               |  3 ++
 drivers/video/fbdev/chipsfb.c                 |  3 ++
 drivers/video/fbdev/cirrusfb.c                |  5 +++
 drivers/video/fbdev/core/fbmem.c              | 15 ++++++++
 drivers/video/fbdev/cyber2000fb.c             |  6 ++-
 drivers/video/fbdev/geode/Kconfig             |  3 ++
 drivers/video/fbdev/geode/gx1fb_core.c        |  5 +++
 drivers/video/fbdev/geode/gxfb_core.c         |  5 +++
 drivers/video/fbdev/geode/lxfb_core.c         |  5 +++
 drivers/video/fbdev/gxt4500.c                 |  3 ++
 drivers/video/fbdev/hyperv_fb.c               |  4 +-
 drivers/video/fbdev/i740fb.c                  |  5 +++
 drivers/video/fbdev/i810/i810_main.c          |  6 +++
 drivers/video/fbdev/imsttfb.c                 |  5 +++
 drivers/video/fbdev/intelfb/intelfbdrv.c      |  3 ++
 drivers/video/fbdev/kyro/fbdev.c              |  5 +++
 drivers/video/fbdev/matrox/matroxfb_base.c    |  3 ++
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c    |  3 ++
 drivers/video/fbdev/neofb.c                   |  5 +++
 drivers/video/fbdev/nvidia/nvidia.c           |  5 +++
 drivers/video/fbdev/pm2fb.c                   |  5 +++
 drivers/video/fbdev/pm3fb.c                   |  5 +++
 drivers/video/fbdev/pvr2fb.c                  |  5 +++
 drivers/video/fbdev/riva/fbdev.c              |  5 +++
 drivers/video/fbdev/s3fb.c                    |  5 +++
 drivers/video/fbdev/savage/savagefb_driver.c  |  3 ++
 drivers/video/fbdev/sis/sis_main.c            |  5 +++
 drivers/video/fbdev/skeletonfb.c              |  5 +++
 drivers/video/fbdev/sm712fb.c                 |  3 ++
 drivers/video/fbdev/sstfb.c                   |  3 ++
 drivers/video/fbdev/sunxvr2500.c              |  3 ++
 drivers/video/fbdev/sunxvr500.c               |  3 ++
 drivers/video/fbdev/tdfxfb.c                  |  5 +++
 drivers/video/fbdev/tgafb.c                   |  5 +++
 drivers/video/fbdev/tridentfb.c               |  5 +++
 drivers/video/fbdev/vermilion/vermilion.c     |  5 +++
 drivers/video/fbdev/via/via-core.c            |  3 ++
 drivers/video/fbdev/vt8623fb.c                |  5 +++
 .../drm/drm_nomodeset.c => video/nomodeset.c} | 12 +++---
 include/drm/drm_drv.h                         |  8 +++-
 include/linux/fb.h                            |  9 +++++
 include/video/nomodeset.h                     |  8 ++++
 56 files changed, 285 insertions(+), 21 deletions(-)
 rename drivers/{gpu/drm/drm_nomodeset.c => video/nomodeset.c} (63%)
 create mode 100644 include/video/nomodeset.h


base-commit: 3aa97a74d622aa26fe79cf4bd819b6a4fd176e90
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 3f204510fcbf9530d6540bd8e6128cce598988b6
prerequisite-patch-id: a0b503ec2c15fdf17e3c93ff0357fd3c27a791f6
prerequisite-patch-id: 2a2d490c863c0e2cb1b25052049b2f1c63f7c443
prerequisite-patch-id: bfad12b053cc616edbc07b5ea3e8f5793b647a5a
prerequisite-patch-id: a1abb89fd8c741f377444432278ea13f142b497d
prerequisite-patch-id: 63b3e0f79bfe4e3e19f389e21c8e0ee010801075
-- 
2.38.0

