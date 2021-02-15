Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED80C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Feb 2021 17:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED62564DA3
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Feb 2021 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhBORuV (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 Feb 2021 12:50:21 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:39357 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhBORt5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 Feb 2021 12:49:57 -0500
Received: by mail-io1-f70.google.com with SMTP id r140so7232900iod.6
        for <linux-fbdev@vger.kernel.org>; Mon, 15 Feb 2021 09:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RoXjSk9Af3jPUQTqmZVPDGkwVHOwjW/9fUaQTC8HuJ0=;
        b=KhTumUR5IoBRLqYJRN0fkGOFtNjMOVIfRW7X1R6+cJrvCLmFXayVeG5gxHI4bBl85T
         C5RR3bQ9MQo5WDq+r8Hn3ObE/p71uFc8EvADqQ2sXDzYjKw+/tKiM+SZnDjmYoj7CXer
         PfciEmSYC7/saTa9tQW7fTJwZvcDetaBfcvfvrxHqoD++3VghPYenUCrkAbQyECTd2oI
         cwzTEMWH/hzt8VqzKEcV4eV3EO9J3P/jCQY7+MUc/TY8YXcV6kZ8/+Mp8+FhWpD7u33S
         7vh2ajWMtHwbuPR/oQOKXzkwRawieDSeYefLqpHhHI8wmHKMKKXgrPeeFSfwc92/4oHX
         wb7Q==
X-Gm-Message-State: AOAM531chRAGduLoSPeiupmhlBjWFClsA07zP6pBKtc90vYOyyRof4/T
        sUJlND51allk0hV14+dtrGj6PzHgAqSGC1UaAgnSk653yryg
X-Google-Smtp-Source: ABdhPJwzOOxIy2iOkkChjuZZcTCvuOWkIaVMSnGKcKuT8QfwtaCwGkxJUGQdmh+AZkOM0BV9i6dS3eum4K+RDo1BujXuo+CluTlz
MIME-Version: 1.0
X-Received: by 2002:a6b:3b53:: with SMTP id i80mr13407420ioa.203.1613411355704;
 Mon, 15 Feb 2021 09:49:15 -0800 (PST)
Date:   Mon, 15 Feb 2021 09:49:15 -0800
In-Reply-To: <00000000000096ae3b05b838799c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbc2e905bb639abf@google.com>
Subject: Re: KASAN: vmalloc-out-of-bounds Write in imageblit
From:   syzbot <syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f40ddce8 Linux 5.11
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14216df4d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=51ab7ccaffffc30c
dashboard link: https://syzkaller.appspot.com/bug?extid=858dc7a2f7ef07c2c219
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f53924d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=138b494cd00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x12f4/0x1430 drivers/video/fbdev/core/sysimgblt.c:275
Write of size 4 at addr ffffc9000bc91000 by task syz-executor566/8649

CPU: 3 PID: 8649 Comm: syz-executor566 Not tainted 5.11.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2c6 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
 sys_imageblit+0x12f4/0x1430 drivers/video/fbdev/core/sysimgblt.c:275
 drm_fb_helper_sys_imageblit drivers/gpu/drm/drm_fb_helper.c:794 [inline]
 drm_fbdev_fb_imageblit+0x15c/0x350 drivers/gpu/drm/drm_fb_helper.c:2266
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:139 [inline]
 bit_putcs+0x6e1/0xd20 drivers/video/fbdev/core/bitblit.c:188
 fbcon_putcs+0x35a/0x450 drivers/video/fbdev/core/fbcon.c:1304
 do_update_region+0x399/0x630 drivers/tty/vt/vt.c:676
 redraw_screen+0x658/0x790 drivers/tty/vt/vt.c:1035
 fbcon_modechanged+0x593/0x6d0 drivers/video/fbdev/core/fbcon.c:2656
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:2701
 do_fb_ioctl+0x62e/0x690 drivers/video/fbdev/core/fbmem.c:1110
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43fd49
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0eaf1448 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000019c10 RCX: 000000000043fd49
RDX: 0000000020000080 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff0eaf15e8 R09: 00007fff0eaf15e8
R10: 00007fff0eaf0ec0 R11: 0000000000000246 R12: 00007fff0eaf145c
R13: 431bde82d7b634db R14: 00000000004ae018 R15: 0000000000400488


Memory state around the buggy address:
 ffffc9000bc90f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000bc90f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000bc91000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc9000bc91080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000bc91100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================

