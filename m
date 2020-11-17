Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9397AC63777
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B702417E
	for <linux-fbdev@archiver.kernel.org>; Tue, 17 Nov 2020 20:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgKQUrU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:47:20 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52547 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgKQUrS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 17 Nov 2020 15:47:18 -0500
Received: by mail-io1-f70.google.com with SMTP id i19so14116255ioa.19
        for <linux-fbdev@vger.kernel.org>; Tue, 17 Nov 2020 12:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=g5pesXitIdT83qeXpTb2UUjP/lm8xGuI+nNj4EZ6F6w=;
        b=Vv8IUpqch15meNdDmUGHTk1KjogwCPPfh+myPgRrVDpxTuMkA20wbEa3z40FpPXcZf
         NuVaEaLB1AbNtMVs8sDW45/Y36R/BAyI9qrgIsAtZYutzEhFw22J9OXnNz8+xMzRmJDf
         YuVS2yDTT8Num5Jw05hTW012Bz6vN0gereGNegPZOuCvqe7QGwGUt8TvkRgYRxMoXYGM
         0psyR2PlD8WIvo6mNKGVLQ0wMLDLNWymyDAIcGp/OX5oQcZbgclZpaH7FcBGmhKsUGZB
         BMIcTQ8t3sSAg/Fmj95zqyN5WjGA0ACzd/x9YLaqHkJZikr1OBdpZsS8MNdtfcpa+AI7
         EBHA==
X-Gm-Message-State: AOAM533ueS1sgRXAhaOwkTRkCnDYJK9UkNdoU9FQlkI8wjh5aWwoh/hV
        +5XAI6sc3VX20ryBE2mmG9OatdJzONfcE0KISMmk5MCWVIY7
X-Google-Smtp-Source: ABdhPJzfYkoNeM6JM5oM3SgfhAX3KwAOT7hLO4hl1PqcqYqrkzzGETJ9Ej/aImLJ9xUY7VEDHgX9/yUnKOhIMXG4KEPYM5ZmLJJQ
MIME-Version: 1.0
X-Received: by 2002:a6b:5d0f:: with SMTP id r15mr10717304iob.20.1605646036985;
 Tue, 17 Nov 2020 12:47:16 -0800 (PST)
Date:   Tue, 17 Nov 2020 12:47:16 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab6df705b453993a@google.com>
Subject: BUG: unable to handle kernel paging request in bitfill_aligned (2)
From:   syzbot <syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0062442e Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16584b81500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9aa2432c01bcb1f
dashboard link: https://syzkaller.appspot.com/bug?extid=a4edd73d589b0b7efbeb
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff888001000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD fc01067 P4D fc01067 PUD fc02067 PMD 80000000010001e1 
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12457 Comm: syz-executor.5 Not tainted 5.10.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__writeq arch/x86/include/asm/io.h:98 [inline]
RIP: 0010:bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:70 [inline]
RIP: 0010:bitfill_aligned+0x11d/0x200 drivers/video/fbdev/core/cfbfillrect.c:35
Code: 41 83 fc 07 76 5f 4c 89 ed e8 bf 28 8a fd 48 89 5d 00 48 89 5d 08 48 89 5d 10 48 89 5d 18 48 89 5d 20 48 89 5d 28 48 8d 45 38 <48> 89 5d 30 48 83 c5 40 48 89 18 41 83 ef 08 bf 07 00 00 00 44 89
RSP: 0018:ffffc900082176d0 EFLAGS: 00010246
RAX: ffff888001000008 RBX: 0000000000000000 RCX: ffffc90013da2000
RDX: 0000000000040000 RSI: ffffffff83e60721 RDI: 0000000000000005
RBP: ffff888000ffffd0 R08: 0000000000001380 R09: 0000000000000040
R10: 0000000000000007 R11: 0000000000000000 R12: 000000000000004e
R13: ffff888000ffff10 R14: 0000000000000000 R15: 0000000000000036
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0063) knlGS:00000000f5542b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff888001000000 CR3: 000000001c7d6000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cfb_fillrect+0x40b/0x7b0 drivers/video/fbdev/core/cfbfillrect.c:327
 vga16fb_fillrect+0x683/0x1940 drivers/video/fbdev/vga16fb.c:951
 bit_clear_margins+0x3f6/0x4b0 drivers/video/fbdev/core/bitblit.c:224
 fbcon_clear_margins+0x1f1/0x280 drivers/video/fbdev/core/fbcon.c:1325
 fbcon_switch+0xafe/0x16b0 drivers/video/fbdev/core/fbcon.c:2187
 redraw_screen+0x2b9/0x790 drivers/tty/vt/vt.c:1021
 vc_do_resize+0xed8/0x1150 drivers/tty/vt/vt.c:1326
 vt_resize+0xa3/0xe0 drivers/tty/vt/vt.c:1367
 tiocswinsz drivers/tty/tty_io.c:2278 [inline]
 tty_ioctl+0x11a2/0x1600 drivers/tty/tty_io.c:2576
 tty_compat_ioctl+0x295/0x410 drivers/tty/tty_io.c:2818
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f48549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f55420cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000005414
RDX: 0000000020000040 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: ffff888001000000
---[ end trace 7c559c247d0f5502 ]---
RIP: 0010:__writeq arch/x86/include/asm/io.h:98 [inline]
RIP: 0010:bitfill_aligned drivers/video/fbdev/core/cfbfillrect.c:70 [inline]
RIP: 0010:bitfill_aligned+0x11d/0x200 drivers/video/fbdev/core/cfbfillrect.c:35
Code: 41 83 fc 07 76 5f 4c 89 ed e8 bf 28 8a fd 48 89 5d 00 48 89 5d 08 48 89 5d 10 48 89 5d 18 48 89 5d 20 48 89 5d 28 48 8d 45 38 <48> 89 5d 30 48 83 c5 40 48 89 18 41 83 ef 08 bf 07 00 00 00 44 89
RSP: 0018:ffffc900082176d0 EFLAGS: 00010246
RAX: ffff888001000008 RBX: 0000000000000000 RCX: ffffc90013da2000
RDX: 0000000000040000 RSI: ffffffff83e60721 RDI: 0000000000000005
RBP: ffff888000ffffd0 R08: 0000000000001380 R09: 0000000000000040
R10: 0000000000000007 R11: 0000000000000000 R12: 000000000000004e
R13: ffff888000ffff10 R14: 0000000000000000 R15: 0000000000000036
FS:  0000000000000000(0000) GS:ffff8880b9e00000(0063) knlGS:00000000f5542b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff888001000000 CR3: 000000001c7d6000 CR4: 00000000001526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
