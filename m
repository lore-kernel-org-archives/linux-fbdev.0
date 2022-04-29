Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E8C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Apr 2022 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356876AbiD2KL5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 06:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiD2KL4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 06:11:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8161C6648
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 03:08:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 522E91F37F;
        Fri, 29 Apr 2022 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651226917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LTgpgelFxlKH+EGvpPO5YVBEsmctmfJglLzDPioPa4c=;
        b=moSZO8XUk7edZbD6CUR9KFv5bvRj6ockYOniLg0ER2gDkmNdKSCGiu/CRzOxtCg5HfX2vK
        XTR2Qe9cVNRDklvO4g8cKz8QQ/avYHvDEqkJlKM5w56mQ9B/Fss/AiQpBgzWIwTEzaphg6
        ov2yrnlIdPr0C8w/5Y0xJIRVf67e8d4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651226917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LTgpgelFxlKH+EGvpPO5YVBEsmctmfJglLzDPioPa4c=;
        b=xHR4nyZuOC6yw3eIABDOgBE0HnGmLsB78JPefhbbmlVXR9cJOWaUb4P6ZMM+i5+64mSrEa
        bZJbIcGNlRmTVgDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22B4813AE0;
        Fri, 29 Apr 2022 10:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z4OCByW5a2JiFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 29 Apr 2022 10:08:37 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, sam@ravnborg.org, daniel@ffwll.ch,
        deller@gmx.de, airlied@linux.ie, maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/5] fbdev: Decouple deferred I/O from struct page
Date:   Fri, 29 Apr 2022 12:08:29 +0200
Message-Id: <20220429100834.18898-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Rework the fbdev deferred-I/O to not interfere with fields of struct
page. All references from deferred-I/O code to fields in struct page
are gone. The rsp state is held in a separate pageref structure.

v4:
	* fix locking in fb_mmap() (Dan)
	* fix commit-message style (Javier)
v3:
	* rename pagelist to pagereflist (Sam)
	* use pageref->offset over page->index (Javier)
v2:
	* split off from a larger patchset [1]

[1] https://lore.kernel.org/dri-devel/20220303205839.28484-1-tzimmermann@suse.de/
	
Thomas Zimmermann (5):
  fbdev: Put mmap for deferred I/O into drivers
  fbdev: Track deferred-I/O pages in pageref struct
  fbdev: Refactor implementation of page_mkwrite
  fbdev: Rename pagelist to pagereflist for deferred I/O
  fbdev: Use pageref offset for deferred-I/O writeback

 drivers/gpu/drm/drm_fb_helper.c        |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |  10 +-
 drivers/hid/hid-picolcd_fb.c           |   3 +-
 drivers/staging/fbtft/fbtft-core.c     |  21 ++-
 drivers/video/fbdev/broadsheetfb.c     |  27 ++--
 drivers/video/fbdev/core/fb_defio.c    | 212 +++++++++++++++++--------
 drivers/video/fbdev/core/fbmem.c       |  22 +--
 drivers/video/fbdev/hecubafb.c         |   4 +-
 drivers/video/fbdev/hyperv_fb.c        |  10 +-
 drivers/video/fbdev/metronomefb.c      |  23 ++-
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  27 ++--
 drivers/video/fbdev/smscufx.c          |  13 +-
 drivers/video/fbdev/ssd1307fb.c        |   4 +-
 drivers/video/fbdev/udlfb.c            |  18 +--
 drivers/video/fbdev/xen-fbfront.c      |  10 +-
 include/drm/drm_fb_helper.h            |   3 +-
 include/linux/fb.h                     |  17 +-
 17 files changed, 265 insertions(+), 174 deletions(-)


base-commit: 0e7deff6446a4ba2c75f499a0bfa80cd6a15c129
-- 
2.36.0

