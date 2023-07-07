Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BD7C05051
	for <linux-fbdev@archiver.kernel.org>; Fri,  7 Jul 2023 08:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjGGIeb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 7 Jul 2023 04:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjGGIea (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 7 Jul 2023 04:34:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08551FC4;
        Fri,  7 Jul 2023 01:34:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71F95227BF;
        Fri,  7 Jul 2023 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688718867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMwLIko/n0DlYoocrVnbzMjwujsIFsQzXunnsYrfOew=;
        b=ZTgvS2Hnu5DfHwlerwmCmX/X/rN3wSxLrGOo50U3pVZbebV6lsaa4CGtxXDKyXrfkJzUfC
        A9pODJuUuIQoBXaorEz3cNAr9dhI/aXiFB8I3v5YTxvXTIi3igAi7Gp/FbZ2R37A67pkKV
        c+0fL8VEfXJUusF8IJh2Mz97w7R43k8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688718867;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMwLIko/n0DlYoocrVnbzMjwujsIFsQzXunnsYrfOew=;
        b=y9QgbtOFwty2wuxsMqAeTPaQHu/VGEM7f3J+JoFxhlrN9q8tySeyveOSdS+Ft/JQF6WOz/
        /06SkcDmyRH4A3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 376931346D;
        Fri,  7 Jul 2023 08:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +D6FDBPOp2RdQAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 07 Jul 2023 08:34:27 +0000
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
Subject: [PATCH v3 04/12] drm/tegra: Set fbdev FBINFO_VIRTFB flag
Date:   Fri,  7 Jul 2023 10:31:55 +0200
Message-ID: <20230707083422.18691-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707083422.18691-1-tzimmermann@suse.de>
References: <20230707083422.18691-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Mark the framebuffer with FBINFO_VIRTFB. The framebuffer range is
in DMA-able memory and should be accessed with the CPU's regular
memory ops.

v2:
	* drop FBINFO_DEFAULT

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/fbdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 82577b7c88da..d8460c5dc91e 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -132,6 +132,7 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 		}
 	}
 
+	info->flags |= FBINFO_VIRTFB;
 	info->screen_base = (void __iomem *)bo->vaddr + offset;
 	info->screen_size = size;
 	info->fix.smem_start = (unsigned long)(bo->iova + offset);
-- 
2.41.0

