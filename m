Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A58C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 30 Apr 2022 02:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbiD3DCT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 29 Apr 2022 23:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiD3DCT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 29 Apr 2022 23:02:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425FB25
        for <linux-fbdev@vger.kernel.org>; Fri, 29 Apr 2022 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651287538; x=1682823538;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tIlOkmldkdpbOQRhdoU8+GxwKCLAG9CBfNwO4dyhs1Q=;
  b=YBljpio3bq63thVCCD6dbaiZ8w4jKGunXp9aWVICwaV/rjemI97B3G8P
   WRE1zb2KpHY/bzaT6zmJ/a9juc3S46VSaxUDEaZweXFdTBDG2Cw7VfAMM
   bEd1K1zCDcbK3JisZ7tj0weRfW1zcI0+HlyINFDlMhF/MWhh6hnPxYMm2
   dvaKtgkWsPds50WTvs8q8XpTvhn2Lyu4GNeF4BdlGL/RSbTBJ5OsZPu+z
   b37LpWGBfX59RYA4X4yoOzXoVNCNg1N07Avv6pypCxqfUyDPwWUVgjHj7
   mUfYwPy6v7z7zPZuPu6a6tSCbEiPUQ+ij4SMo6QPJ77qTSo5kDmIoitHf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="353253202"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="353253202"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 19:58:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; 
   d="scan'208";a="534805399"
Received: from junxiaochang.bj.intel.com ([10.238.135.52])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 19:58:56 -0700
From:   Junxiao Chang <junxiao.chang@intel.com>
To:     linux-fbdev@vger.kernel.org
Cc:     lethal@linux-sh.org, patchwork-bot@kernel.org, deller@gmx.de,
        lili.li@intel.com, junxiao.chang@intel.com
Subject: [PATCH] video: fbdev: don't remove firmware fb device if it is busy
Date:   Sat, 30 Apr 2022 10:57:49 +0800
Message-Id: <20220430025749.2320824-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When firmware framebuffer is in use, don't remove its platform
device. Or else its fb_info buffer is released by platform remove
hook while device is still opened. This introduces use after free
issue.

A kernel panic example:
CPU: 2 PID: 3425 Comm: psplash Tainted: G     U  W     5.18.0-rc3
Hardware name: Intel Client Platform/ADP-S DDR5 UDIMM CRB
RIP: 0010:native_queued_spin_lock_slowpath+0x1c7/0x210
RSP: 0018:ffffb3a0c0c2fdb0 EFLAGS: 00010206
RAX: 002dc074ff5c0988 RBX: ffff92e987a5d818 RCX: ffff92e989ba9f40
RDX: 0000000000002067 RSI: ffffffff864344f1 RDI: ffffffff8644183c
RBP: ffff92f10f4abd40 R08: 0000000000000001 R09: ffff92e986dc2188
...
Call Trace:
 <TASK>
 _raw_spin_lock+0x2c/0x30
 __mutex_lock.constprop.0+0x175/0x4f0
 ? _raw_spin_unlock+0x15/0x30
 ? list_lru_add+0x124/0x160
 fb_release+0x1b/0x60
 __fput+0x89/0x240
 task_work_run+0x59/0x90
 do_exit+0x343/0xaf0
 do_group_exit+0x2d/0x90
 __x64_sys_exit_group+0x14/0x20
 do_syscall_64+0x40/0x90
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 27599aacbaef ("fbdev: Hot-unplug firmware fb devices on forced removal")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
Signed-off-by: Lili Li <lili.li@intel.com>
---
 drivers/video/fbdev/core/fbmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index a6bb0e438216..ff9b9830b398 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1586,7 +1586,9 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
 				 * framebuffer as before without warning.
 				 */
 				do_unregister_framebuffer(registered_fb[i]);
-			} else if (dev_is_platform(device)) {
+			} else if (dev_is_platform(device) &&
+					refcount_read(&registered_fb[i]->count) == 1) {
+				/* Remove platform device if it is not in use. */
 				registered_fb[i]->forced_out = true;
 				platform_device_unregister(to_platform_device(device));
 			} else {
-- 
2.25.1

