Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40F3C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Mar 2022 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiCCU7a (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiCCU73 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 3 Mar 2022 15:59:29 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DA42A2D
        for <linux-fbdev@vger.kernel.org>; Thu,  3 Mar 2022 12:58:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A01A2113B;
        Thu,  3 Mar 2022 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646341121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tzloYSWb9woade52JqwYOqpvH73D+5PCkYIzoJtfRww=;
        b=AIrTsKO9vnJOw1oFTXXsfqeHUJMRimn68YjArpRaPC3pmCCVrz84EulVb0fSij/uRlL+KH
        znF5zxY/XTTJu3Qy/nsnoRk3bZVGjrm/wfGMS7Cvm//MXKUvXq23YVcRpoChS2bLiwgf7P
        xe2q0RUPOS0+7XZyagG+GdCaCXKHTgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646341121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tzloYSWb9woade52JqwYOqpvH73D+5PCkYIzoJtfRww=;
        b=ceEcdBlqmxmv3j9lGl0H0Np853JQLmaQiX7E851kbA6RXMLNq0sVRCgUDKfA8CzafManHh
        9jne/VvxuoaXa0CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E5C0139B5;
        Thu,  3 Mar 2022 20:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lq2bDQEsIWJoHAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 03 Mar 2022 20:58:41 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/9] drm: Support GEM SHMEM fbdev without shadow FB
Date:   Thu,  3 Mar 2022 21:58:30 +0100
Message-Id: <20220303205839.28484-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Rework the fbdev deferred-I/O to not interfere with fields of struct
page. Make the code more flexible and implement GEM SHMEM mmap on top
of it.

This patchset removes the need for a special shadow framebuffer for
fbdev mmap when using GEM SHMEM. SHMEM pages are now mmap'ed from
/dev/fb directly.

Patches 2 and 3 rework the fbdev deferred I/O code. It now allows
drivers to have better control of the mmap operations. All references
to fields in struct page are gone. The rsp state is help in a 
separate pageref structure.

Patches 4 to 7 provide callbacks an helpers to implement deferred I/O
with DRM drivers. Specifically, patch 6 introduces a callback to create
a dumb buffer for fbdev. This will be useful for many drivers that
currently cannot use generic fbdev emulation because of special placement
needs of the BO, such as amdgpu or radeon. The drivers can handle the
differences to regular dumb buffers in their new callback implementation.

Patch 8 extends the GEM SHMEM memory manager with a new helper for fbdev
dumb-buffer creation. The returned BO has it's mmap set up to implement
deferred I/O with SHMEM pages. No additional shadow buffer is requires
any longer. Many drivers can immediatelly benefit from this change.

Patch 9 extends virtgpu to support fbdev dumb buffers. It's build on
top of GEM SHMEM, but has some modifications that need to be implemented
for fbdev as well.

There's no immediate fbdev performance improvement from this patchset.
Most of all, it removes unnecessary shadow framebuffers and rsp memcpys.
A shadow fb for a FullHD display is ~8 MiB, which we now save. The patches
do reduce latency between drawing to the fbdev buffer to displaying
on the screen. Watching a video on the fbdev console felt smoother and
had less flickering.

Thomas Zimmermann (9):
  drm/simpledrm: Use fbdev defaults for shadow buffering
  fbdev: Put mmap for deferred I/O into drivers
  fbdev: Track deferred-I/O pages in pageref struct
  fbdev: Export helper for implementing page_mkwrite
  drm/fb-helper: Separate deferred I/O from shadow buffers
  drm/fb-helper: Provide callback to create fbdev dumb buffers
  drm/fb-helper: Provide fbdev deferred-I/O helpers
  drm/gem-shmem: Implement fbdev dumb buffer and mmap helpers
  drm/virtio: Implement dumb_create_fbdev with GEM SHMEM helpers

 drivers/gpu/drm/drm_client.c            |  14 +-
 drivers/gpu/drm/drm_crtc_internal.h     |   3 +
 drivers/gpu/drm/drm_dumb_buffers.c      |  36 +++-
 drivers/gpu/drm/drm_fb_helper.c         |  79 +++++++--
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 204 ++++++++++++++++++++---
 drivers/gpu/drm/gud/gud_drv.c           |   2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |   2 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c   |   2 +-
 drivers/gpu/drm/tiny/cirrus.c           |   2 +-
 drivers/gpu/drm/tiny/gm12u320.c         |   2 +-
 drivers/gpu/drm/tiny/simpledrm.c        |   3 +-
 drivers/gpu/drm/udl/udl_drv.c           |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c    |   2 +
 drivers/gpu/drm/virtio/virtgpu_drv.h    |   2 +
 drivers/gpu/drm/virtio/virtgpu_object.c |  54 +++++-
 drivers/gpu/drm/vkms/vkms_drv.c         |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c      |   6 +-
 drivers/hid/hid-picolcd_fb.c            |   1 +
 drivers/staging/fbtft/fbtft-core.c      |   6 +-
 drivers/video/fbdev/broadsheetfb.c      |   6 +-
 drivers/video/fbdev/core/fb_defio.c     | 211 +++++++++++++++++-------
 drivers/video/fbdev/core/fbmem.c        |  19 +--
 drivers/video/fbdev/hecubafb.c          |   1 +
 drivers/video/fbdev/hyperv_fb.c         |   6 +-
 drivers/video/fbdev/metronomefb.c       |   6 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c  |  12 +-
 drivers/video/fbdev/smscufx.c           |   8 +-
 drivers/video/fbdev/ssd1307fb.c         |   1 +
 drivers/video/fbdev/udlfb.c             |   8 +-
 drivers/video/fbdev/xen-fbfront.c       |   6 +-
 include/drm/drm_client.h                |   3 +-
 include/drm/drm_drv.h                   |  27 +++
 include/drm/drm_fb_helper.h             |   9 +
 include/drm/drm_gem_shmem_helper.h      |  63 ++++++-
 include/linux/fb.h                      |  12 +-
 35 files changed, 668 insertions(+), 154 deletions(-)


base-commit: 710a019ad85e96e66f7d75ee7f4733cdd8a2b0d0
prerequisite-patch-id: c2b2f08f0eccc9f5df0c0da49fa1d36267deb11d
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: 6e1032c6302461624f33194c8b8f37103a3fa6ef
-- 
2.35.1

