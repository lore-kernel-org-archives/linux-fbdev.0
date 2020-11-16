Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3C3C55ABD
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7397221F9
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 08:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKPIgS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:36:18 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37588 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKPIgR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Nov 2020 03:36:17 -0500
Received: by mail-il1-f199.google.com with SMTP id u17so11437906ilb.4
        for <linux-fbdev@vger.kernel.org>; Mon, 16 Nov 2020 00:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=C4M/+xfiM9OnFE7qhVh67fuqh9hhXKStAw5Nvc3SLzk=;
        b=I8njaMhOx2/IVokfeSDsn6dNk8L/FOlUACLz33uXoUdCC8cjlHIpAPaEjbFK97i2Ti
         z5a3nlHm5JXfJKMJiwdeJPJFTPK3UeWyWKNg5vaZlJtaWtPvAU+QG0s9phqLzRzXQRVs
         qRWqiPiOh2SYU0lhbLyErULxeoYd7LYtizN1vZ9RB98s0M9UZ+RJdtLLn/r3qzM6CnWD
         9auUI1YdsuPmFbtPqxBsuguNjSN4XC48DDDP7xLPoVIdUFrCf9p0f2FoWGv0ey4DEFMr
         CuOS1t9WBB16sUZuIascdO6XBQNFR6IdUL25vfkBDFl7/Prf4XfkfHPyfPlVMLjLi6qi
         bM0g==
X-Gm-Message-State: AOAM5327EgSSGPOTuQ6qKX0DL8N1klMNkta6bmQpG8IztPT0IVah6a4y
        BLh9v0CLJ7/wr5fRhqr39IGOQ6HAG+0IOzocigyQMkPAVMue
X-Google-Smtp-Source: ABdhPJz5CkDlFNdysxHWwKhCe6/a6YA48Pk5yELKjSm9IP/lwTuiY0CWJpghC+UxqHQ2GkjsDX3IdlS6QkcJ8beHvY5L6MTbaxyd
MIME-Version: 1.0
X-Received: by 2002:a02:90ca:: with SMTP id c10mr5132009jag.115.1605515776953;
 Mon, 16 Nov 2020 00:36:16 -0800 (PST)
Date:   Mon, 16 Nov 2020 00:36:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091111005b435456e@google.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in fbcon_cursor
From:   syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, syzkaller-bugs@googlegroups.com,
        yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6dd65e60 Add linux-next specific files for 20201110
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1276af62500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fab43daf5c54712
dashboard link: https://syzkaller.appspot.com/bug?extid=b67aaae8d3a927f68d20
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 4e683067 P4D 4e683067 PUD 14850067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9433 Comm: syz-executor.5 Not tainted 5.10.0-rc3-next-20201110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000bca7858 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffff888144509000 RDI: ffff888010079000
RBP: ffff888010079000 R08: 0000000000000000 R09: ffffffff8cecc387
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888144509000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
FS:  00007f5822bee700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000004e973000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fbcon_cursor+0x50e/0x620 drivers/video/fbdev/core/fbcon.c:1346
 hide_cursor+0x85/0x280 drivers/tty/vt/vt.c:907
 redraw_screen+0x5ed/0x790 drivers/tty/vt/vt.c:1012
 vc_do_resize+0xed3/0x1150 drivers/tty/vt/vt.c:1326
 fbcon_set_disp+0x831/0xda0 drivers/video/fbdev/core/fbcon.c:1413
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:816 [inline]
 set_con2fb_map+0x7a6/0xf80 drivers/video/fbdev/core/fbcon.c:887
 fbcon_set_con2fb_map_ioctl+0x165/0x220 drivers/video/fbdev/core/fbcon.c:3072
 do_fb_ioctl+0x5b6/0x690 drivers/video/fbdev/core/fbmem.c:1156
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5822bedc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000e2c0 RCX: 000000000045deb9
RDX: 00000000200000c0 RSI: 0000000000004610 RDI: 0000000000000006
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007ffe024fb66f R14: 00007f5822bee9c0 R15: 000000000118bf2c
Modules linked in:
CR2: 0000000000000000
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 4e683067 P4D 4e683067 PUD 14850067 PMD 0 
Oops: 0010 [#2] PREEMPT SMP KASAN
CPU: 0 PID: 9433 Comm: syz-executor.5 Not tainted 5.10.0-rc3-next-20201110-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000bca7278 EFLAGS: 00010086
RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000000002 RSI: ffff888144509000 RDI: ffff888010079000
RBP: ffff888010079000 R08: 0000000000000000 R09: ffffffff8cecc387
R10: 0000000000000003 R11: 0000000000000001 R12: ffff888144509000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
FS:  00007f5822bee700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000004e973000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fbcon_cursor+0x50e/0x620 drivers/video/fbdev/core/fbcon.c:1346
 hide_cursor+0x85/0x280 drivers/tty/vt/vt.c:907
 redraw_screen+0x5ed/0x790 drivers/tty/vt/vt.c:1012
 fbcon_blank+0x8c5/0xc30 drivers/video/fbdev/core/fbcon.c:2248
 do_unblank_screen+0x25b/0x470 drivers/tty/vt/vt.c:4406
 bust_spinlocks+0x5b/0xe0 lib/bust_spinlocks.c:26
 oops_end+0x2b/0xe0 arch/x86/kernel/dumpstack.c:346
 no_context+0x5f2/0xa20 arch/x86/mm/fault.c:752
 __bad_area_nosemaphore+0xa9/0x400 arch/x86/mm/fault.c:840
 do_user_addr_fault+0x7d7/0xba0 arch/x86/mm/fault.c:1340
 handle_page_fault arch/x86/mm/fault.c:1434 [inline]
 exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1490
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:580
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000bca7858 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffff888144509000 RDI: ffff888010079000
RBP: ffff888010079000 R08: 0000000000000000 R09: ffffffff8cecc387
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888144509000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
Modules linked in:
CR2: 0000000000000000
---[ end trace 8931af4863156cb4 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000bca7858 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffff888144509000 RDI: ffff888010079000
RBP: ffff888010079000 R08: 0000000000000000 R09: ffffffff8cecc387
R10: 0000000000000003 R11: 0000000000000000 R12: ffff888144509000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
FS:  00007f5822bee700(0000) GS:ffff8880b9e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000004e973000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
