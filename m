Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF70C07CA9
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGDQBn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGDQBj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 12:01:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAECC10DF;
        Tue,  4 Jul 2023 09:01:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A8B6228B2;
        Tue,  4 Jul 2023 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688486497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e76bu1daEheBjGdpEyMYZAPb0mKF+Y+BPHVIDSFcmNA=;
        b=R+VKWJ3PuIiRh9QL36PegocvI9fbr90gL9CHh3UxwY8ytQpMx+3vaNpCk4UXGw3ZpA7BCL
        70+vfsq69iSkQU3Av3HLWLsFKT+nfqCfEXSbpMgUUuRIPj4jZI7zkMEOzCk9blFzRwRJqL
        qqXReBhZetjmeb8fYoSUa6e9AGodeVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688486497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e76bu1daEheBjGdpEyMYZAPb0mKF+Y+BPHVIDSFcmNA=;
        b=EuU2w4T/d9ejIVQ5io5J/YZsPK1ttIyz7YJ9PSLF0n/GcNXASRYqFASvgDEIl/1Loc8pYR
        wZNKIKX953uhuUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43ED8133F7;
        Tue,  4 Jul 2023 16:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WD6vD2FCpGTzLwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 04 Jul 2023 16:01:37 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH 09/10] drm/omapdrm: Set fbdev flags
Date:   Tue,  4 Jul 2023 17:50:06 +0200
Message-ID: <20230704160133.20261-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704160133.20261-1-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Set fbdev default flags FBNFO_DEFAULT and mark the framebuffer with
FBINFO_VIRTFB. The framebuffer range is in DMA-able memory and should
be accessed with the CPU's regular memory ops.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index b1a2d00ef52d..2dd86e6f5268 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -203,10 +203,12 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 
 	helper->fb = fb;
 
+	fbi->flags = FBINFO_DEFAULT;
 	fbi->fbops = &omap_fb_ops;
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 
+	fbi->flags |= FBINFO_VIRTFB;
 	fbi->screen_buffer = omap_gem_vaddr(bo);
 	fbi->screen_size = bo->size;
 	fbi->fix.smem_start = dma_addr;
-- 
2.41.0

