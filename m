Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E35CC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 18 Jul 2022 07:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiGRHX1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiGRHX1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 18 Jul 2022 03:23:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844BF18352
        for <linux-fbdev@vger.kernel.org>; Mon, 18 Jul 2022 00:23:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 154813392C;
        Mon, 18 Jul 2022 07:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658129004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GZxo82O0GSD21ZK5W2Hm0LcGlwweorBc4NPn450GI2g=;
        b=zYROj88s6MFXXnPX4fcs295nrX+rd+QK7uPWxWXr40NlJ15H0hD9NfCmAqwd+47nbQYp3M
        HuBRouZobCZM9AUBg8k5NgXS3ZcTzMnhA4ACYXE+sMH5zhhRYysc3aUgPOidZkREekN5jY
        JKYoUpSeJBrSssKlv14QYOfprVuicQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658129004;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GZxo82O0GSD21ZK5W2Hm0LcGlwweorBc4NPn450GI2g=;
        b=L2sdneqZw2OaJFF3hynxuKpTZs7BwlN84Kfck8BYgo+X3OzC4/YZMPOFzU6NwOyWC91NbB
        I/MbDmKAVWXJZRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB68713A37;
        Mon, 18 Jul 2022 07:23:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YD+pNGsK1WKjcAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 18 Jul 2022 07:23:23 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, deller@gmx.de, daniel@ffwll.ch,
        sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/11] fbdev: Maintain device ownership with aperture helpers
Date:   Mon, 18 Jul 2022 09:23:11 +0200
Message-Id: <20220718072322.8927-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fbdev firmware drivers acquire ownership of framebuffer I/O ranges and
hand them over to native drivers during the boot process. Re-implement
this mechanism with aperture helpers and remove the respective fbdev
code.

This change allows to perform hand-over from DRM firmware drivers. In a
later patchset, device ownership can be moved from DRM and fbdev entirely
into aperture helpers.

Patches 1 and 4 are cleanups.

Patches 2 and 3 integrate EGA/VGA support into sysfb, although it's not
clear if the x86 architecture code actually still supports VGA graphics
mode.

Patches 5 to 10 replace fbdev's ownership management with aperture
helpers. This includes removal of conflicting framebuffer drivers,
removal of conflicting VGA drivers and registration of fbdev firmware
devices. Notably, many PCI-based fbdev drivers failed to remove firmware
devices until now; and therefore probably haven't worked correctly for
some time.

Patch 11 removes the implementation of fbdev ownership management.

The patchset has been tested by handing over device ownership between
firmware and native drivers of DRM and fbdev in various combinations.

v2:
	* remove unused options handling from vga16fb (Javier)
	* more elaborate commit messages (Javier)
	* remove unused internal functions in fbmem.c

Thomas Zimmermann (11):
  fbdev: Remove trailing whitespaces
  fbdev/vga16fb: Create EGA/VGA devices in sysfb code
  fbdev/vga16fb: Auto-generate module init/exit code
  fbdev/core: Remove remove_conflicting_pci_framebuffers()
  fbdev: Convert drivers to aperture helpers
  fbdev: Remove conflicting devices on PCI bus
  video/aperture: Disable and unregister sysfb devices via aperture
    helpers
  video: Provide constants for VGA I/O range
  video/aperture: Remove conflicting VGA devices, if any
  fbdev: Acquire framebuffer apertures for firmware devices
  fbdev: Remove conflict-handling code

 drivers/firmware/sysfb.c                     |   4 +
 drivers/staging/sm750fb/sm750.c              |  15 +-
 drivers/video/aperture.c                     |  69 ++--
 drivers/video/fbdev/arkfb.c                  |   5 +
 drivers/video/fbdev/asiliantfb.c             |   5 +
 drivers/video/fbdev/aty/aty128fb.c           |  57 ++--
 drivers/video/fbdev/aty/atyfb_base.c         |   7 +-
 drivers/video/fbdev/aty/radeon_base.c        |  83 +++--
 drivers/video/fbdev/carminefb.c              |   5 +
 drivers/video/fbdev/chipsfb.c                |  13 +-
 drivers/video/fbdev/cirrusfb.c               |   5 +
 drivers/video/fbdev/core/fbmem.c             | 213 ++-----------
 drivers/video/fbdev/cyber2000fb.c            |   5 +
 drivers/video/fbdev/geode/gx1fb_core.c       |   5 +
 drivers/video/fbdev/geode/gxfb_core.c        |   5 +
 drivers/video/fbdev/geode/lxfb_core.c        |   5 +
 drivers/video/fbdev/gxt4500.c                |   5 +
 drivers/video/fbdev/hyperv_fb.c              |   6 +-
 drivers/video/fbdev/i740fb.c                 |   5 +
 drivers/video/fbdev/i810/i810_main.c         | 315 ++++++++++---------
 drivers/video/fbdev/imsttfb.c                |  36 ++-
 drivers/video/fbdev/intelfb/intelfbdrv.c     |   5 +
 drivers/video/fbdev/kyro/fbdev.c             |   5 +
 drivers/video/fbdev/matrox/matroxfb_base.c   |   5 +
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c   |   5 +
 drivers/video/fbdev/neofb.c                  |  41 +--
 drivers/video/fbdev/nvidia/nvidia.c          |   7 +-
 drivers/video/fbdev/pm2fb.c                  |   5 +
 drivers/video/fbdev/pm3fb.c                  |   5 +
 drivers/video/fbdev/pvr2fb.c                 |   5 +
 drivers/video/fbdev/riva/fbdev.c             |  67 ++--
 drivers/video/fbdev/s3fb.c                   |   5 +
 drivers/video/fbdev/savage/savagefb_driver.c |   5 +
 drivers/video/fbdev/sis/sis_main.c           |   5 +
 drivers/video/fbdev/skeletonfb.c             | 210 +++++++------
 drivers/video/fbdev/sm712fb.c                |   5 +
 drivers/video/fbdev/sstfb.c                  |  43 +--
 drivers/video/fbdev/sunxvr2500.c             |   5 +
 drivers/video/fbdev/sunxvr500.c              |   5 +
 drivers/video/fbdev/tdfxfb.c                 |   5 +
 drivers/video/fbdev/tgafb.c                  |  17 +-
 drivers/video/fbdev/tridentfb.c              |   5 +
 drivers/video/fbdev/vermilion/vermilion.c    |   7 +-
 drivers/video/fbdev/vga16fb.c                | 191 +++++------
 drivers/video/fbdev/via/via-core.c           |   5 +
 drivers/video/fbdev/vt8623fb.c               |   5 +
 include/linux/fb.h                           |   4 -
 include/video/vga.h                          |  20 +-
 48 files changed, 776 insertions(+), 784 deletions(-)


base-commit: ebea934e2651857c9b56cc80bf99460ee18a3592
-- 
2.36.1

