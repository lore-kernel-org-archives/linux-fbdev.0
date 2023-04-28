Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B47DC77B61
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 12:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbjD1MZG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbjD1MY6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 08:24:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A12709
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:24:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6A2A20085;
        Fri, 28 Apr 2023 12:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682684695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CPsrpmI15kdAMdZDSgdd2i0u00cenKxKta4utAInOB4=;
        b=1U5g2FHBPgdFc8BjkA72LpXUE+encLy3h7SferVC2YH8jMUC6OPqYawxicvvHnqh1crtWa
        UWDqcl/vQjSkUmxBO5CjERu/L7y1oSyxY2a/Dbvds+rXcJbVQJmmszrzn3705NS027JgOx
        X4hpGQWx9wPqSyjFrkP2mOqI+6dl75E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682684695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CPsrpmI15kdAMdZDSgdd2i0u00cenKxKta4utAInOB4=;
        b=qvqZ8yR4D3vFbJ7b3cMz2Wgf87osCNq0XI47D1zPxlk9WSUDhV7yX91KS4QoC8pnvRYCpt
        LFn4/0oyahTNfyCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 795661390E;
        Fri, 28 Apr 2023 12:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T6GrHBe7S2RgeAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 12:24:55 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/19] drm,fbdev: Use fbdev's I/O helpers
Date:   Fri, 28 Apr 2023 14:24:33 +0200
Message-Id: <20230428122452.4856-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Make fbdev's built-in helpers for reading and writing I/O and system
memory available to DRM. Replace DRM's internal helpers.

The first 13 patches and patch 15 fix the use of screen_base and
screen_buffer. A number of drivers mix them up.

Patch 14 resolves a bug that's been in the fbdev code for more than
15 years. Makes the read/write helpers work successfully with the IGT
tests.

Patches 16 and 17 streamline fbdev's file-I/O code and remove a few
duplicate checks.

Patch 18 moves the default-I/O code into the new helpers fb_io_read()
and fb_io_write(); patch 19 uses them in DRM. This allows us to remove
quite a bit of code from DRM's internal fbdev helpers.

Tested with i915 and simpledrm.

The next step here is to remove the drm_fb_helper_{cfb,sys}_*()
entirely. They where mostly introduced because fbdev doesn't protect
it's public interfaces with an CONFIG_FB preprocessor guards. But all
of DRM driver's fbdev emulation won't be build without CONFIG_FB, so
this is not an issue in practice. Removing the DRM wrappers will
further simplify the DRM code.

v2:
	* fix screen_base vs. screen_buffer usage
	* fix copy_{from,to}_user() return value (Geert)
	* use fb_io_() prefix (Geert)
	* improved commit messages

Thomas Zimmermann (19):
  auxdisplay/cfag12864bfb: Use struct fb_info.screen_buffer
  auxdisplay/ht16k33: Use struct fb_info.screen_buffer
  hid/hid-picolcd_fb: Use struct fb_info.screen_buffer
  fbdev/arcfb: Use struct fb_info.screen_buffer
  fbdev/au1200fb: Use struct fb_info.screen_buffer
  fbdev/broadsheetfb: Use struct fb_info.screen_buffer
  fbdev/hecubafb: Use struct fb_info.screen_buffer
  fbdev/metronomefb: Use struct fb_info.screen_buffer
  fbdev/ps3fb: Use struct fb_info.screen_buffer
  fbdev/smscufx: Use struct fb_info.screen_buffer
  fbdev/udlfb: Use struct fb_info.screen_buffer
  fbdev/vfb: Use struct fb_info.screen_buffer
  fbdev/xen-fbfront: Use struct fb_info.screen_buffer
  fbdev: Return number of bytes read or written
  fbdev: Use screen_buffer in fb_sys_{read,write}()
  fbdev: Don't re-validate info->state in fb_ops implementations
  fbdev: Validate info->screen_{base,buffer} in fb_ops implementations
  fbdev: Move I/O read and write code into helper functions
  drm/fb-helper: Use fb_{cfb,sys}_{read, write}()

 drivers/auxdisplay/cfag12864bfb.c      |   2 +-
 drivers/auxdisplay/ht16k33.c           |   2 +-
 drivers/gpu/drm/drm_fb_helper.c        | 174 +------------------------
 drivers/hid/hid-picolcd_fb.c           |   4 +-
 drivers/media/pci/ivtv/ivtvfb.c        |   4 +-
 drivers/video/fbdev/arcfb.c            |  11 +-
 drivers/video/fbdev/au1200fb.c         |   2 +-
 drivers/video/fbdev/broadsheetfb.c     |  16 +--
 drivers/video/fbdev/cobalt_lcdfb.c     |   6 +
 drivers/video/fbdev/core/Makefile      |   2 +-
 drivers/video/fbdev/core/fb_io_fops.c  | 133 +++++++++++++++++++
 drivers/video/fbdev/core/fb_sys_fops.c |  36 ++---
 drivers/video/fbdev/core/fbmem.c       | 111 +---------------
 drivers/video/fbdev/hecubafb.c         |  12 +-
 drivers/video/fbdev/metronomefb.c      |  16 +--
 drivers/video/fbdev/ps3fb.c            |   4 +-
 drivers/video/fbdev/pvr2fb.c           |   3 +
 drivers/video/fbdev/sm712fb.c          |  10 +-
 drivers/video/fbdev/smscufx.c          |  14 +-
 drivers/video/fbdev/ssd1307fb.c        |   3 +
 drivers/video/fbdev/udlfb.c            |  12 +-
 drivers/video/fbdev/vfb.c              |   2 +-
 drivers/video/fbdev/xen-fbfront.c      |   2 +-
 include/linux/fb.h                     |  10 ++
 24 files changed, 239 insertions(+), 352 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_io_fops.c

-- 
2.40.0

