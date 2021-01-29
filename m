Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE65C433E6
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Jan 2021 17:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CD164E00
	for <linux-fbdev@archiver.kernel.org>; Fri, 29 Jan 2021 17:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhA2RRr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Jan 2021 12:17:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52646 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhA2RPt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Jan 2021 12:15:49 -0500
Received: from 1-171-224-33.dynamic-ip.hinet.net ([1.171.224.33] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l5Rqz-0006Nc-Dn; Fri, 29 Jan 2021 11:22:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pjones@redhat.com
Cc:     hdegoede@redhat.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-fbdev@vger.kernel.org (open list:EFIFB FRAMEBUFFER DRIVER),
        dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND] [PATCH] efifb: Ensure graphics device for efifb stays at PCI D0
Date:   Fri, 29 Jan 2021 19:22:12 +0800
Message-Id: <20210129112213.1007006-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

We are seeing root ports on some desktop boards support D3cold for
discrete graphics card. So when efifb is in use while graphics device
isn't bound to a driver, PCI and ACPI will put the graphics to D3cold
when runtime suspend kicks in, makes efifb stop working.

So ensure the graphics device won't be runtime suspended, to keep efifb
work all the time.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/video/fbdev/efifb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index e57c00824965..19edd7206409 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/screen_info.h>
+#include <linux/pm_runtime.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_utils.h> /* For drm_get_panel_orientation_quirk */
@@ -575,6 +576,7 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_fb_dealoc;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
+	pm_runtime_get_sync(&efifb_pci_dev->dev);
 	return 0;
 
 err_fb_dealoc:
@@ -601,6 +603,7 @@ static int efifb_remove(struct platform_device *pdev)
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 	framebuffer_release(info);
+	pm_runtime_put(&efifb_pci_dev->dev);
 
 	return 0;
 }
-- 
2.29.2

