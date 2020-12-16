Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFFEC2BBCA
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Dec 2020 01:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FB422EBD
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Dec 2020 01:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLPBOx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:14:53 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:56379 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgLPBOx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Dec 2020 20:14:53 -0500
Received: by mail-io1-f71.google.com with SMTP id e14so15102244iow.23
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Dec 2020 17:14:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KqSiQgWhoD3U6R5hjEeNhCbfIfoF5Ak040X4OCRefZg=;
        b=US68ZQ6OSaL3ws7pC/W2fMOu+SOHrTktLzWNyi79akhLfPboCOV1eih352FubJqaUN
         RX0/lz8ZCbf8u1GqZumjoqNMX3XUmFL7UxtqKcYwbdEdawlLCTUHetYC4enn/zxBCauh
         1kubts7oFh5qzNvhvdeye3HbFrYi+w3x22Xi1EuC89RSEbN6WDjHaIJXX2yYVtsfLqCG
         s1BPtRZ+bcu9nv52uXqgsRnwKHUFcv12uqmO/9nSILNz5Tl7pBs5U3na9h8MZld35ATq
         KtP6qnTQZyNOGl9pNFKa2JGJEUoTzR2jq1kLG2ouqyFNN/HoGR6Q4YDe8tFb9b//lxvh
         /6mQ==
X-Gm-Message-State: AOAM533Cxs3ZtLx8w5CcMijGaAEclobeZoqGK4OnzBhcYgx7H7CNxIRs
        q4XSy4/fE4C23bC+h3GWOl6Nb67+9/R7Q0g/6sjFMxWuqS+9
X-Google-Smtp-Source: ABdhPJxRF4JnudYyVFdlpAzdNt/B5IVfef+TzU8B6YH08NhU0AOnllFroZDBsTTM1pVIHe4xLihNAz1VQMDxFLHqe3WV0FX66gtc
MIME-Version: 1.0
X-Received: by 2002:a5d:8483:: with SMTP id t3mr27239384iom.35.1608081251984;
 Tue, 15 Dec 2020 17:14:11 -0800 (PST)
Date:   Tue, 15 Dec 2020 17:14:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb6db205b68a971c@google.com>
Subject: WARNING: suspicious RCU usage in modeset_lock
From:   syzbot <syzbot+972b924c988834e868b2@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, geert@linux-m68k.org,
        gustavoars@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com,
        peda@axentia.se, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    94801e5c Merge tag 'pinctrl-v5.10-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130558c5500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ee8a1012a5314210
dashboard link: https://syzkaller.appspot.com/bug?extid=972b924c988834e868b2
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+972b924c988834e868b2@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.10.0-rc7-syzkaller #0 Not tainted
-----------------------------
kernel/sched/core.c:7270 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 0
7 locks held by syz-executor.1/9232:
 #0: ffffffff8b328c60 (console_lock){+.+.}-{0:0}, at: do_fb_ioctl+0x2e4/0x690 drivers/video/fbdev/core/fbmem.c:1106
 #1: ffff888041bd4078 (&fb_info->lock){+.+.}-{3:3}, at: lock_fb_info include/linux/fb.h:636 [inline]
 #1: ffff888041bd4078 (&fb_info->lock){+.+.}-{3:3}, at: do_fb_ioctl+0x2ee/0x690 drivers/video/fbdev/core/fbmem.c:1107
 #2: ffff888041adca78 (&helper->lock){+.+.}-{3:3}, at: drm_fb_helper_pan_display+0xce/0x970 drivers/gpu/drm/drm_fb_helper.c:1448
 #3: ffff8880159f01b8 (&dev->master_mutex){+.+.}-{3:3}, at: drm_master_internal_acquire+0x1d/0x70 drivers/gpu/drm/drm_auth.c:407
 #4: ffff888041adc898 (&client->modeset_mutex){+.+.}-{3:3}, at: drm_client_modeset_commit_locked+0x44/0x580 drivers/gpu/drm/drm_client_modeset.c:1143
 #5: ffffc90001c07730 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_client_modeset_commit_atomic+0xb7/0x7c0 drivers/gpu/drm/drm_client_modeset.c:981
 #6: ffff888015986108 (crtc_ww_class_mutex){+.+.}-{3:3}, at: ww_mutex_lock_slow include/linux/ww_mutex.h:287 [inline]
 #6: ffff888015986108 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock+0x31c/0x650 drivers/gpu/drm/drm_modeset_lock.c:260

stack backtrace:
CPU: 1 PID: 9232 Comm: syz-executor.1 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 ___might_sleep+0x25d/0x2b0 kernel/sched/core.c:7270
 __mutex_lock_common kernel/locking/mutex.c:935 [inline]
 __ww_mutex_lock.constprop.0+0xa9/0x2cc0 kernel/locking/mutex.c:1111
 ww_mutex_lock+0x3d/0x170 kernel/locking/mutex.c:1190
 modeset_lock+0x392/0x650 drivers/gpu/drm/drm_modeset_lock.c:263
 drm_modeset_lock drivers/gpu/drm/drm_modeset_lock.c:342 [inline]
 drm_modeset_lock+0x50/0x90 drivers/gpu/drm/drm_modeset_lock.c:338
 drm_atomic_get_plane_state+0x19d/0x510 drivers/gpu/drm/drm_atomic.c:481
 drm_client_modeset_commit_atomic+0x225/0x7c0 drivers/gpu/drm/drm_client_modeset.c:994
 drm_client_modeset_commit_locked+0x145/0x580 drivers/gpu/drm/drm_client_modeset.c:1145
 pan_display_atomic drivers/gpu/drm/drm_fb_helper.c:1395 [inline]
 drm_fb_helper_pan_display+0x28b/0x970 drivers/gpu/drm/drm_fb_helper.c:1455
 fb_pan_display+0x2f7/0x6c0 drivers/video/fbdev/core/fbmem.c:925
 fb_set_var+0x57f/0xda0 drivers/video/fbdev/core/fbmem.c:1043
 do_fb_ioctl+0x2f9/0x690 drivers/video/fbdev/core/fbmem.c:1108
 fb_compat_ioctl+0x17c/0xaf0 drivers/video/fbdev/core/fbmem.c:1315
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fd8549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55d20bc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004601
RDX: 0000000020000240 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
detected fb_set_par error, error code: -16


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
