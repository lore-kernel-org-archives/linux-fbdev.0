Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2256FC001DD
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 16:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDQBk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDQBi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 12:01:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C781410D8;
        Tue,  4 Jul 2023 09:01:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 308C21FDCD;
        Tue,  4 Jul 2023 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688486495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q3o6HH10epfUBbyVpQ2BjTaq6/Z7q4pOKDMZHDJhhrk=;
        b=W3dCjljN3niN6goKeJiHVZjW6m+M0xhxyiv3x7nxsgQvkvWZ2KJd0H2o7qU4eNv9Qt2yIK
        x+KkxD9UE4m01BU5HHI/AXflTlw40YSrrZXn/3AR0nhrODhm624un8ct/w134s8MFG3pFc
        W9TDrEwYKwYiBvfGun19kVFo9CHanuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688486495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=q3o6HH10epfUBbyVpQ2BjTaq6/Z7q4pOKDMZHDJhhrk=;
        b=rCPwnYlgRA+jYT0G3ht5V7WgaqmVR4hIt5yTlLtWfDk0ZMptYxxMUJ4V5yf00bI19BBpBD
        77x/kr/CkBPjwdAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE42B133F7;
        Tue,  4 Jul 2023 16:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LMYvOV5CpGTzLwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 04 Jul 2023 16:01:34 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/10] drm: Improve fbdev emulation for DMA-able framebuffers
Date:   Tue,  4 Jul 2023 17:49:57 +0200
Message-ID: <20230704160133.20261-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add fbdev helpers for framebuffers in DMA-able memory and update
fbdev emulation in the respective DRM drivers. DMA memory used to
handled as system memory. Improve this and prepare for possible
future changes.

Patch 1 adds initializer macros for struct fb_ops and a Kconfig
token for framebuffers in DMA memory.

Patches 2 to 4 update fbdev-dma and tegra. No functional changes
are expected as both used system memory before.

Patches 5 and 6 update exynos to use DMA helpers. Exynos incorrectly
used fbdev's I/O-memory helpers. Fix this.

Patches 7 to 9 update omapdrm to use DMA helpers. Patch 7 first
reworks the driver's mmap to current best practices. This also makes
it suitable for use with fbdev, which patches 8 and 9 implement.

Patch 10 removes some fbdev macros for system memory that are now
unused.

The patchset would ideally go through drm-misc-next. Future patches
can build upon it and update fbdev drivers in similar ways.

Thomas Zimmermann (10):
  fbdev: Add fb_ops init macros for framebuffers in DMA-able memory
  drm/fbdev-dma: Use fbdev DMA helpers
  drm/tegra: Use fbdev DMA helpers
  drm/tegra: Set fbdev flags
  drm/exynos: Use fbdev DMA helpers
  drm/exynos: Set fbdev flags
  drm/omapdrm: Set VM flags in GEM-object mmap function
  drm/omapdrm: Use GEM mmap for fbdev emulation
  drm/omapdrm: Set fbdev flags
  fbdev: Remove FB_DEFAULT_SYS_OPS

 drivers/gpu/drm/Kconfig                   |  2 +-
 drivers/gpu/drm/drm_fbdev_dma.c           |  4 ++--
 drivers/gpu/drm/exynos/Kconfig            |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c |  6 ++++--
 drivers/gpu/drm/omapdrm/Kconfig           |  2 +-
 drivers/gpu/drm/omapdrm/omap_drv.c        | 12 +-----------
 drivers/gpu/drm/omapdrm/omap_fbdev.c      | 17 ++++++++++++++--
 drivers/gpu/drm/omapdrm/omap_gem.c        | 24 ++++++-----------------
 drivers/gpu/drm/omapdrm/omap_gem.h        |  3 ---
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c |  7 +------
 drivers/gpu/drm/tegra/Kconfig             |  2 +-
 drivers/gpu/drm/tegra/fbdev.c             |  7 +++++--
 drivers/video/fbdev/Kconfig               |  8 ++++++++
 include/linux/fb.h                        | 17 ++++++++++------
 14 files changed, 57 insertions(+), 56 deletions(-)

-- 
2.41.0

