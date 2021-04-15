Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C78CC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu, 15 Apr 2021 10:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED7961132
	for <linux-fbdev@archiver.kernel.org>; Thu, 15 Apr 2021 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDOKW4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:22:56 -0400
Received: from foss.arm.com ([217.140.110.172]:42520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhDOKWz (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 15 Apr 2021 06:22:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727AB12FC;
        Thu, 15 Apr 2021 03:22:32 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D2AC3F73B;
        Thu, 15 Apr 2021 03:22:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peter Jones <pjones@redhat.com>
Subject: [PATCH] efifb: Fix runtime pm calls for non PCI efifb device
Date:   Thu, 15 Apr 2021 11:22:24 +0100
Message-Id: <20210415102224.2764054-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Commit a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
added runtime pm calls to probe and remove routines to ensure the PCI
device for efifb stays in D0 state. However not ever efifb is based on
PCI device and efifb_pci_dev can be NULL if that is the case.

In such cases, we will get a boot splat like below due to NULL dereference:
-->8
 Console: switching to colour frame buffer device 240x67
 fb0: EFI VGA frame buffer device
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000270
 Mem abort info:
   ESR = 0x96000004
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
 Data abort info:
   ISV = 0, ISS = 0x00000004
   CM = 0, WnR = 0
 [0000000000000270] user address but active_mm is swapper
 Internal error: Oops: 96000004 [#1] PREEMPT SMP
 Modules linked in:
 CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc7-next-20210413 #1
 Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
 pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
 pc : pm_runtime_drop_link+0x12c/0x338
 lr : efifb_probe+0x7bc/0x7f0
 Call trace:
  pm_runtime_drop_link+0x12c/0x338
  efifb_probe+0x7bc/0x7f0
  platform_probe+0x68/0xd8
  really_probe+0xe4/0x3a8
  driver_probe_device+0x64/0xc8
  device_driver_attach+0x74/0x80
  __driver_attach+0x64/0xf0
  bus_for_each_dev+0x70/0xc0
  driver_attach+0x24/0x30
  bus_add_driver+0x150/0x1f8
  driver_register+0x64/0x120
  __platform_driver_register+0x28/0x38
  efifb_driver_init+0x1c/0x28
  do_one_initcall+0x48/0x2b0
  kernel_init_freeable+0x1e8/0x258
  kernel_init+0x14/0x118
  ret_from_fork+0x10/0x30
 Code: 88027c01 35ffffa2 17fff706 f9800051 (885f7c40)
 ---[ end trace 17d8da630bf8ff77 ]---
 Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
-->8

Fix the issue by checking for non-NULL efifb_pci_dev before dereferencing
for runtime pm calls in probe and remove routines.

Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Peter Jones <pjones@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/video/fbdev/efifb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index f58a545b3bf3..8ea8f079cde2 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -575,7 +575,8 @@ static int efifb_probe(struct platform_device *dev)
 		goto err_fb_dealoc;
 	}
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
-	pm_runtime_get_sync(&efifb_pci_dev->dev);
+	if (efifb_pci_dev)
+		pm_runtime_get_sync(&efifb_pci_dev->dev);
 	return 0;
 
 err_fb_dealoc:
@@ -602,7 +603,8 @@ static int efifb_remove(struct platform_device *pdev)
 	unregister_framebuffer(info);
 	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 	framebuffer_release(info);
-	pm_runtime_put(&efifb_pci_dev->dev);
+	if (efifb_pci_dev)
+		pm_runtime_put(&efifb_pci_dev->dev);
 
 	return 0;
 }
-- 
2.25.1

