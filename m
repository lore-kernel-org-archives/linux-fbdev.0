Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77058C678D8
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 15:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjAKPlf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjAKPlc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A9386
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id ay40so11400470wmb.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okH8AsNmtLn+Xev5OTCMqwCCcQgJeFP0KaGCnceKOFQ=;
        b=e3QgYRhA/FauY7S29GhmvTbp6mhIVjL3kUKyk/aiNJTXGHtP9m5oMyVm5h+bchf5VB
         5Ozpe8kode9PPOMtykJJWS4wCtMq4JeTqLZWhNsrNNrrwUmqJgCj6729094+1wKf7qV8
         SfwbZApVC/cUEh7SexrqejM4npd5PFpvVRP4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okH8AsNmtLn+Xev5OTCMqwCCcQgJeFP0KaGCnceKOFQ=;
        b=5MgwPHZ+0ePEav3H9sd2qWXu5zVvj1/55Nb298cXw4E/PKUrbG/f5Yja6xquNfii50
         E4ULm7l6KK26ujqmfDB6+ZwawkKF6QiWAzQXrBybia6kk1DRC98qw2DjF+JRdDK8Ap94
         o+czbAiYduxzjCRULXnEcszLB/+WHYtIs0VrIWHZJljFbEaHqrC5kzx0Wu3DIdrRe1RL
         5axwgugEMhm+z2AiSY70ECiLvMWVaWJksQY6XKn10+zpydTioELH+GprhVN5eL+KmSJ8
         4xMdb+4eI4Y7oS+ei/7/JECX2hGqz5NrnOTRL2P6nNT4mw8u88Rt9uv1OMOmWQY4v+qe
         HV7Q==
X-Gm-Message-State: AFqh2kro2qamX/SfFw2rafpB1LiuoXwKtN7JCx+6lBEhAwqBZgdVHjSC
        n0HNr0XUXSurTf34tdAO2RCcPw==
X-Google-Smtp-Source: AMrXdXv1xjpTqbp3o72Jk+q/9NKQX+TzVLexEvL4brcebjiwodaMtz9/eJQ29HVAzKVNvEUGaR8qtg==
X-Received: by 2002:a05:600c:3d05:b0:3d3:5c21:dd94 with SMTP id bh5-20020a05600c3d0500b003d35c21dd94mr54680019wmb.9.1673451689538;
        Wed, 11 Jan 2023 07:41:29 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:28 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 07/11] fbdev/radeon: use pci aperture helpers
Date:   Wed, 11 Jan 2023 16:41:08 +0100
Message-Id: <20230111154112.90575-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It's not exactly the same since the open coded version doesn't set
primary correctly. But that's a bugfix, so shouldn't hurt really.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/radeon_base.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 657064227de8..972c4bbedfa3 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2238,14 +2238,6 @@ static const struct bin_attribute edid2_attr = {
 	.read	= radeon_show_edid2,
 };
 
-static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	resource_size_t base = pci_resource_start(pdev, 0);
-	resource_size_t size = pci_resource_len(pdev, 0);
-
-	return aperture_remove_conflicting_devices(base, size, false, KBUILD_MODNAME);
-}
-
 static int radeonfb_pci_register(struct pci_dev *pdev,
 				 const struct pci_device_id *ent)
 {
@@ -2296,7 +2288,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
-	ret = radeon_kick_out_firmware_fb(pdev);
+	ret = aperture_remove_conflicting_pci_devices(pdev, KBUILD_MODNAME);
 	if (ret)
 		goto err_release_fb;
 
-- 
2.39.0

