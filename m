Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2DFC433FE
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Apr 2022 11:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiDYLbA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Apr 2022 07:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiDYLa7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Apr 2022 07:30:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C05E0F3
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Apr 2022 04:27:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD4C3210EC;
        Mon, 25 Apr 2022 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650886072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZKrkE8FPb5LF7zYeH+H7Zv+EKkXH77NzpuOcL8LQEFE=;
        b=oGCe2gFT1Usd3JpX2IAkyOzIoil4uyBVkKndykiI8blhdrePdud6Qj8klFVoOWwNybRWHs
        w9FV23cf03rmFH4jLqoubGdw3Y4pCFHjOvz3+IUzoA1MDeFRUz3CV1nFnClvT+IZVvAXf0
        ToJD0rUoeqTcki4CP7OuX3MYcFTumkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650886072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZKrkE8FPb5LF7zYeH+H7Zv+EKkXH77NzpuOcL8LQEFE=;
        b=4pZOcGmQ7GgsD0p0jL9Su26zzT7xzuM74vlmH+CQDzzHxvxFNTFRk18ZFhhogirmhOwI8X
        5FbfoPsAx6QXy3AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9F43313AE1;
        Mon, 25 Apr 2022 11:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bLcUJriFZmIPUAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 25 Apr 2022 11:27:52 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, daniel@ffwll.ch, deller@gmx.de,
        airlied@linux.ie, maarten.lankhorst@linux.intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/3] fbdev: Decouple deferred I/O from struct page
Date:   Mon, 25 Apr 2022 13:27:48 +0200
Message-Id: <20220425112751.25985-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Rework the fbdev deferred-I/O to not interfere with fields of struct
page. All references from deferred-I/O code to fields in struct page
are gone. The rsp state is help in a separate pageref structure.

Version 1 of this patchset was part of a larger attempt to improve
GEM SHMEM support. [1] The patches can already be merged to resolve
a long-standing issue in the fbdev code.

[1] https://lore.kernel.org/dri-devel/20220303205839.28484-1-tzimmermann@suse.de/

Thomas Zimmermann (3):
  fbdev: Put mmap for deferred I/O into drivers
  fbdev: Track deferred-I/O pages in pageref struct
  fbdev: Refactor implementation of page_mkwrite

 drivers/gpu/drm/drm_fb_helper.c        |  10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |   6 +-
 drivers/hid/hid-picolcd_fb.c           |   1 +
 drivers/staging/fbtft/fbtft-core.c     |   6 +-
 drivers/video/fbdev/broadsheetfb.c     |   6 +-
 drivers/video/fbdev/core/fb_defio.c    | 213 +++++++++++++++++--------
 drivers/video/fbdev/core/fbmem.c       |  19 ++-
 drivers/video/fbdev/hecubafb.c         |   1 +
 drivers/video/fbdev/hyperv_fb.c        |   6 +-
 drivers/video/fbdev/metronomefb.c      |   6 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  12 +-
 drivers/video/fbdev/smscufx.c          |   8 +-
 drivers/video/fbdev/ssd1307fb.c        |   1 +
 drivers/video/fbdev/udlfb.c            |   8 +-
 drivers/video/fbdev/xen-fbfront.c      |   6 +-
 include/linux/fb.h                     |  11 +-
 16 files changed, 221 insertions(+), 99 deletions(-)


base-commit: 0e7deff6446a4ba2c75f499a0bfa80cd6a15c129
-- 
2.36.0

