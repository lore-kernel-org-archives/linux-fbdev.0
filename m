Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A416C677F1
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 15:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjAKPle (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 10:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjAKPla (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 10:41:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A3E29C
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so14682067wmb.2
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uA+tPLir+1X4c7NIGPD8fbGsyIZBKsPUjYPi9h9kAc8=;
        b=eNQu3m5MBYcJ4ir7wnU2uKSOdOlTVnwwoNbl7ndwmx7pL0oaymY4tJ+VPavmH4gWu3
         ctX/ciqpqll+Gi0G39VkzdIVV+zIy+55w4NRmQ48GvAAagPpdV92t11x9dtuCypNqs8x
         VKs1+2qNooBYEQ/WTCaaYQDd8eQZXRMv5YgkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uA+tPLir+1X4c7NIGPD8fbGsyIZBKsPUjYPi9h9kAc8=;
        b=16HgXjjzB5EJRKpxyAxM9MVLeU4yTYYoHu+5541oNpedMdAyQUTAolycdnlCMX4Skm
         uttQ0K6Po37VVatGl0mSIh8WvzqwS6LL5qvZ5MONPneRn2LLJSokyz3V11tpYS8otlzI
         OjdWammO8OdbV+suRCH+VrfhX2kcspgsIDRhJlm1bSy6xJPMSg+B1+WRWtw2Q1XWAxoi
         4C8A86pIR5nWUmVBtWGr2LFAIcuKIqxhqhTK18VsopSNIZ8dpnyBTd1Gkahw3ygsAnTQ
         XezUaIS5WRj/ewQL4d+IK9MRqHZ/S7Qh51iL6h1wUgJWnQykXAqwjoTscK6TGBj3v3GS
         MFPg==
X-Gm-Message-State: AFqh2kpEUymFYBbcLXWgqvVRnT3xt7jVMSLGYmIGvvP4tDhQyXC3sKlV
        utdYHDBTe2OnjslbxYAVBz1OoQ==
X-Google-Smtp-Source: AMrXdXvP0g7aBxRONWD/2hWDOWNy8uqW2LewLgFiVP8szo0yPD2T/n1jDfUyAtI8xKF52PjIaacOWg==
X-Received: by 2002:a05:600c:4f83:b0:3d2:3f55:f73f with SMTP id n3-20020a05600c4f8300b003d23f55f73fmr53421615wmq.8.1673451688237;
        Wed, 11 Jan 2023 07:41:28 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm15936149wmq.9.2023.01.11.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:41:27 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 06/11] staging/lynxfb: Use pci aperture helper
Date:   Wed, 11 Jan 2023 16:41:07 +0100
Message-Id: <20230111154112.90575-6-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
References: <20230111154112.90575-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It exists! Note that since this is an exact copy, there shouldn't be
any functional difference here.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/staging/sm750fb/sm750.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index effc7fcc3703..22ace3168723 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -989,20 +989,6 @@ static int sm750fb_framebuffer_alloc(struct sm750_dev *sm750_dev, int fbidx)
 	return err;
 }
 
-static int lynxfb_kick_out_firmware_fb(struct pci_dev *pdev)
-{
-	resource_size_t base = pci_resource_start(pdev, 0);
-	resource_size_t size = pci_resource_len(pdev, 0);
-	bool primary = false;
-
-#ifdef CONFIG_X86
-	primary = pdev->resource[PCI_ROM_RESOURCE].flags &
-					IORESOURCE_ROM_SHADOW;
-#endif
-
-	return aperture_remove_conflicting_devices(base, size, primary, "sm750_fb1");
-}
-
 static int lynxfb_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1011,7 +997,7 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	int fbidx;
 	int err;
 
-	err = lynxfb_kick_out_firmware_fb(pdev);
+	err = aperture_remove_conflicting_pci_devices(pdev, "sm750_fb1");
 	if (err)
 		return err;
 
-- 
2.39.0

