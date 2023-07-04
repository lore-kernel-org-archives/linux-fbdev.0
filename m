Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8CFEB64DA
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 16:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjGDQBl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGDQBj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 12:01:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485810DD;
        Tue,  4 Jul 2023 09:01:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 298B1228AF;
        Tue,  4 Jul 2023 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688486496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckVHReRisnJ+7Edbypsv59JntS0oPCQ/YOl8IC0RY5c=;
        b=Zvd75MJg3ZOlTYJfyXF5ZQGxEem9yjDFvwsCwJLlON8YJ8DJunXBRFKBBE2o25+1aze2Jk
        qTCXkTTvnLM1Al2EhjRs21lFJPyyOe6dd02sCx3NNheEUmxKCU3p1kh9FvVc46XwlsNRL1
        aLjzBYPHgatbx8pFZmApKmeamwUTXgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688486496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ckVHReRisnJ+7Edbypsv59JntS0oPCQ/YOl8IC0RY5c=;
        b=iYDpY+hkmVGlNQL7l7FBkO623kFGawvtm4TS3af1tg2wzU6LX9RhWnhdyCyneq65Hz2Im9
        9pwt/equs88KBbCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E318F133F7;
        Tue,  4 Jul 2023 16:01:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SH+ENl9CpGTzLwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 04 Jul 2023 16:01:35 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 04/10] drm/tegra: Set fbdev flags
Date:   Tue,  4 Jul 2023 17:50:01 +0200
Message-ID: <20230704160133.20261-5-tzimmermann@suse.de>
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
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 82577b7c88da..8074430c52f1 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -103,6 +103,8 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 		return PTR_ERR(info);
 	}
 
+	info->flags = FBINFO_DEFAULT;
+
 	fb = tegra_fb_alloc(drm, &cmd, &bo, 1);
 	if (IS_ERR(fb)) {
 		err = PTR_ERR(fb);
@@ -132,6 +134,7 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 		}
 	}
 
+	info->flags |= FBINFO_VIRTFB;
 	info->screen_base = (void __iomem *)bo->vaddr + offset;
 	info->screen_size = size;
 	info->fix.smem_start = (unsigned long)(bo->iova + offset);
-- 
2.41.0

