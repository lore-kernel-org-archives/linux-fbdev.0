Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD9C07E9A
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 05:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC441613AF
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 05:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbhGNFTN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Jul 2021 01:19:13 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47056 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNFTM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Jul 2021 01:19:12 -0400
Received: by mail-il1-f199.google.com with SMTP id i11-20020a056e02004bb029020269661e11so301991ilr.13
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jul 2021 22:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=USd2GMqDDR83g9HOIvITJBl6roJLZm/Z57kOOP6/pBs=;
        b=WGB2PeBT6B31SJVXcF53K5xaDpffOaI5LWV2lVhL0MmS+5V1stewAByz0MVcL5nqcQ
         aqRWr+2M7RpkEQMpWUqlb08pMAKfikwH05Vl+3MT7ws3T2Z8N0656aLfiPjznDno3adx
         9VeVUASn5fuXumY9g+BXJlPS15BdtS4+kp0wn8f4O4gTTKI2awNdUUFGMvsp0kcKouzZ
         Dlsm4JQtND1TqmUWKOz4AZ9hYOwrkfUTT+v7b9Cg4gVScxJs6Pb95xy+qa494i8nUUod
         i5V1uxzQs5uu98Igc5NyBs49NjlTKDF4T/nhMlxZuKYlGzHN1WithpZhDXE2eyCBxzpy
         SMEw==
X-Gm-Message-State: AOAM530M1u4W+hS3xUlrflQUHg4Nb4uS+GTaCFyMG1QC3+lDQJ8zaYjz
        ZuGHDUmBGhUcoGfREUy/r87RDLbSlQCbKuCkEUcJyMMirF7F
X-Google-Smtp-Source: ABdhPJyJw2fODUdEtUAQ4caDJR3Bu4OQUFl+xJx0e6pAoXbSOtURb7gC5i1oq7EyVUMBXD7JGflxeD0OHTH/FPc1o3nX9WxMmxb+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1316:: with SMTP id r22mr7314690jad.89.1626239781656;
 Tue, 13 Jul 2021 22:16:21 -0700 (PDT)
Date:   Tue, 13 Jul 2021 22:16:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000815b9605c70e74f8@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in vga16fb_fillrect
From:   syzbot <syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, b.zolnierkie@samsung.com,
        colin.king@canonical.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3dbdb38e Merge branch 'for-5.14' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1323c402300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1fcf15a09815757
dashboard link: https://syzkaller.appspot.com/bug?extid=04168c8063cfdde1db5e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f0e772300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1114b9b0300000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fa45d8300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fa45d8300000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fa45d8300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+04168c8063cfdde1db5e@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff888001000050
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 10e01067 P4D 10e01067 PUD 10e02067 PMD 80000000010001e1 
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8433 Comm: syz-executor067 Tainted: G        W         5.13.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga16fb_fillrect+0x993/0x18d0 drivers/video/fbdev/vga16fb.c:923
Code: 6c fd 48 63 44 24 10 45 31 f6 48 89 04 24 e8 44 a6 6c fd 31 ff 89 de 31 ed e8 79 ad 6c fd 85 db 4d 89 ec 74 22 e8 2d a6 6c fd <45> 88 34 24 83 c5 01 89 df 49 83 c4 01 89 ee e8 49 ae 6c fd 39 eb
RSP: 0018:ffffc90000eff848 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000001b RCX: 0000000000000000
RDX: ffff88802d949c40 RSI: ffffffff8408e403 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8408dd8d
R10: ffffffff8408e3f7 R11: 0000000000000000 R12: ffff888001000050
R13: ffff888001000050 R14: 0000000000000000 R15: 000000000ffeb7ff
FS:  0000000001aa2300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888001000050 CR3: 00000000346fb000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bit_clear_margins+0x3f6/0x4b0 drivers/video/fbdev/core/bitblit.c:224
 fbcon_clear_margins+0x1f1/0x280 drivers/video/fbdev/core/fbcon.c:1315
 fbcon_switch+0xa8c/0x1620 drivers/video/fbdev/core/fbcon.c:2146
 redraw_screen+0x2b9/0x740 drivers/tty/vt/vt.c:1021
 fbcon_modechanged+0x593/0x6d0 drivers/video/fbdev/core/fbcon.c:2651
 fbcon_update_vcs+0x3a/0x50 drivers/video/fbdev/core/fbcon.c:2696
 do_fb_ioctl+0x62e/0x690 drivers/video/fbdev/core/fbmem.c:1110
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl fs/ioctl.c:1055 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:1055
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43efd9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc362df848 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043efd9
RDX: 0000000020000200 RSI: 0000000000004601 RDI: 0000000000000003
RBP: 0000000000402fc0 R08: 0000000000000000 R09: 0000000000400488
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000403050
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
Modules linked in:
CR2: ffff888001000050
---[ end trace 39dce64bc5621bd3 ]---
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga16fb_fillrect+0x993/0x18d0 drivers/video/fbdev/vga16fb.c:923
Code: 6c fd 48 63 44 24 10 45 31 f6 48 89 04 24 e8 44 a6 6c fd 31 ff 89 de 31 ed e8 79 ad 6c fd 85 db 4d 89 ec 74 22 e8 2d a6 6c fd <45> 88 34 24 83 c5 01 89 df 49 83 c4 01 89 ee e8 49 ae 6c fd 39 eb
RSP: 0018:ffffc90000eff848 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 000000000000001b RCX: 0000000000000000
RDX: ffff88802d949c40 RSI: ffffffff8408e403 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff8408dd8d
R10: ffffffff8408e3f7 R11: 0000000000000000 R12: ffff888001000050
R13: ffff888001000050 R14: 0000000000000000 R15: 000000000ffeb7ff
FS:  0000000001aa2300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888001000050 CR3: 00000000346fb000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
