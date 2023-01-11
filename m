Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A306AC54EBC
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 15:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjAKPl3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjAKPlZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA4386
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:22 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso2639153wmb.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGvydfcnswB5kCTr6pgmQFxcgFjCL3fOh+5DF0n/kHQ=;
        b=MlaP4iz9T5QOEdEs7QRCj0LRht0gbuOE12jC5lqdYaja6OmWEu3x44yTN6+eBPdseA
         ZRP3gRxjIwfx/RvbvL1abOvvxn4IUBTB76ngU0gOrbj6czdukqRxbFjuguKcKlCvBiAi
         OIRDopYxEw1xY1T5KE6yRdOqY5ob94mIqBzMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGvydfcnswB5kCTr6pgmQFxcgFjCL3fOh+5DF0n/kHQ=;
        b=S4IhIkWqQEpcW4c17rVDIJ+urGWO+j2iki9t/Kfl8zYYbyhOC/XK97DXrSdU55U4BV
         89jfM0RftiWUj8Y9iVXX0vYXj/OeryOx+e0kxKRh7FvBksMGrzrurjXr+zYtsFDHSd5P
         JtX0XUHetkQX7uaEMKtGpYac/nq97Iggdy8hBZ7E3iXW7rsrw/tPmQ27QBm6e8xoGfZJ
         3a8aGeuUEzdnXpGn7rihVO6BjuKe6f+z6J5bGFGaGHwRh9rNC9q1Z8tkNDh7J1DgOFon
         7sH/UmP/jYEUjN7cU73PAeT8k1qJ6u0b1VV35d9gjPoa/hFaEirZwO49430SGAMWEWuF
         QEiA==
X-Gm-Message-State: AFqh2koa3SalOTHn8M829kWDOyk7Je/a9VM4n/ElwTkLY5DhiLm+nMO0
        XXNof/SYwCmGj4t9jzijpGiH0Q==
X-Google-Smtp-Source: AMrXdXvZL6+Fq4x6+s6c1TzAuUbbiOvtCaS9MpQRLMdhQaJKNpbYwvT73xPCftXvxiNmLgwrl3Fc5Q==
X-Received: by 2002:a05:600c:3482:b0:3d3:4f56:62e1 with SMTP id a2-20020a05600c348200b003d34f5662e1mr51193693wmq.27.1673451681375;
        Wed, 11 Jan 2023 07:41:21 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:20 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
Subject: [PATCH 01/11] drm/ast: Use drm_aperture_remove_conflicting_pci_framebuffers
Date:   Wed, 11 Jan 2023 16:41:02 +0100
Message-Id: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It's just open coded and matches.

Note that Thomas said that his version apparently failed for some
reason, but hey maybe we should try again.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/gpu/drm/ast/ast_drv.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index 420fc75c240e..3ac24a780f50 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -90,27 +90,13 @@ static const struct pci_device_id ast_pciidlist[] = {
 
 MODULE_DEVICE_TABLE(pci, ast_pciidlist);
 
-static int ast_remove_conflicting_framebuffers(struct pci_dev *pdev)
-{
-	bool primary = false;
-	resource_size_t base, size;
-
-	base = pci_resource_start(pdev, 0);
-	size = pci_resource_len(pdev, 0);
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags & IORESOURCE_ROM_SHADOW;
-#endif
-
-	return drm_aperture_remove_conflicting_framebuffers(base, size, primary, &ast_driver);
-}
-
 static int ast_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct ast_private *ast;
 	struct drm_device *dev;
 	int ret;
 
-	ret = ast_remove_conflicting_framebuffers(pdev);
+	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &ast_driver);
 	if (ret)
 		return ret;
 
-- 
2.39.0

