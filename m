Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A0AC07E9C
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 09:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3467D611C1
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jul 2021 09:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbhGLJHu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jul 2021 05:07:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11286 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbhGLI7V (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jul 2021 04:59:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GNcvW6Kt1z78YD;
        Mon, 12 Jul 2021 16:51:51 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 16:56:17 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 16:56:16 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev <linux-fbdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 1/1] fbmem: Do not delete the mode that is still in use
Date:   Mon, 12 Jul 2021 16:55:44 +0800
Message-ID: <20210712085544.2828-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The execution of fb_delete_videomode() is not based on the result of the
previous fbcon_mode_deleted(). As a result, the mode is directly deleted,
regardless of whether it is still in use, which may cause UAF.

==================================================================
BUG: KASAN: use-after-free in fb_mode_is_equal+0x36e/0x5e0 \
drivers/video/fbdev/core/modedb.c:924
Read of size 4 at addr ffff88807e0ddb1c by task syz-executor.0/18962

CPU: 2 PID: 18962 Comm: syz-executor.0 Not tainted 5.10.45-rc1+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ...
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x137/0x1be lib/dump_stack.c:118
 print_address_description+0x6c/0x640 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report+0x13d/0x1e0 mm/kasan/report.c:562
 fb_mode_is_equal+0x36e/0x5e0 drivers/video/fbdev/core/modedb.c:924
 fbcon_mode_deleted+0x16a/0x220 drivers/video/fbdev/core/fbcon.c:2746
 fb_set_var+0x1e1/0xdb0 drivers/video/fbdev/core/fbmem.c:975
 do_fb_ioctl+0x4d9/0x6e0 drivers/video/fbdev/core/fbmem.c:1108
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 18960:
 kasan_save_stack mm/kasan/common.c:48 [inline]
 kasan_set_track+0x3d/0x70 mm/kasan/common.c:56
 kasan_set_free_info+0x17/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0x108/0x140 mm/kasan/common.c:422
 slab_free_hook mm/slub.c:1541 [inline]
 slab_free_freelist_hook+0xd6/0x1a0 mm/slub.c:1574
 slab_free mm/slub.c:3139 [inline]
 kfree+0xca/0x3d0 mm/slub.c:4121
 fb_delete_videomode+0x56a/0x820 drivers/video/fbdev/core/modedb.c:1104
 fb_set_var+0x1f3/0xdb0 drivers/video/fbdev/core/fbmem.c:978
 do_fb_ioctl+0x4d9/0x6e0 drivers/video/fbdev/core/fbmem.c:1108
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 13ff178ccd6d ("fbcon: Call fbcon_mode_deleted/new_modelist directly")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/video/fbdev/core/fbmem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 98f193078c05..1c855145711b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -970,13 +970,11 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		fb_var_to_videomode(&mode2, &info->var);
 		/* make sure we don't delete the videomode of current var */
 		ret = fb_mode_is_equal(&mode1, &mode2);
-
-		if (!ret)
-			fbcon_mode_deleted(info, &mode1);
-
-		if (!ret)
-			fb_delete_videomode(&mode1, &info->modelist);
-
+		if (!ret) {
+			ret = fbcon_mode_deleted(info, &mode1);
+			if (!ret)
+				fb_delete_videomode(&mode1, &info->modelist);
+		}
 
 		return ret ? -EINVAL : 0;
 	}
-- 
2.25.1


