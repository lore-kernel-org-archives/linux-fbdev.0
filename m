Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3212C7EE2D
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 May 2023 11:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjEYLR4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 May 2023 07:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240442AbjEYLRz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 May 2023 07:17:55 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B813A
        for <linux-fbdev@vger.kernel.org>; Thu, 25 May 2023 04:17:52 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76c48b53e16so220044539f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 May 2023 04:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685013471; x=1687605471;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X298Rc6iJqA17+C3fEuxgsgZ0gAoLhGbhdBxE9t9JP0=;
        b=VgtZISDI/Eiyh2Jsj49HljaJWTBH9G1Xl8fvv/1K9+S1R+ftG7ySbxGj8Z8lMQMcPw
         HwEBaEqiNBw+U0j0aMbkMey272Z6peZox9HP8sm+/WVfJHx8o950pz5knBedyoM0oUoE
         jT1h6TbcF8jmru9GcPnAZ41c17WWhxSvE9FANDbp9TDYLUl+1EcZp0HG0TUBSFqprpKN
         53fqHy9zJO8dE8mUi7Ot9sprZKGlPg4fdlbuNb3B0oXKQVHoJpxDqCmJNYKurLgPEFED
         sDzIbryD8Ez0pVONgCIxQ2IbVpEfoPCSCVir198h8r3NM3cSkzgMBeEtdA3NdQLRzY6N
         hV0w==
X-Gm-Message-State: AC+VfDwGsiUMyn3dDM8LKHco83znrWAlGEXO85ag/C3c+aPEAz4e6mD/
        Yy0fV/ieAyXLsmlXRZxLlYmLXZyiILHG52rIKQCaAs27On9A
X-Google-Smtp-Source: ACHHUZ4HIfP2C+p5FhyX7nJFUXa85Ukb1CVy/LCs92Nq5pA7XAcFawjYQVX1u9Q165xmWVNMyLgAaPGaWhRMgDNSg6H3a82OR7vO
MIME-Version: 1.0
X-Received: by 2002:a02:a10b:0:b0:416:5d0f:f494 with SMTP id
 f11-20020a02a10b000000b004165d0ff494mr11021293jag.5.1685013471329; Thu, 25
 May 2023 04:17:51 -0700 (PDT)
Date:   Thu, 25 May 2023 04:17:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066852605fc82c577@google.com>
Subject: [syzbot] [fbdev?] memory leak in fbcon_set_font (3)
From:   syzbot <syzbot+6fda7f092994bd03fad1@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0dd2a6fb1e34 Merge tag 'tty-6.4-rc3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f15641280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8944c5b480b57ee6
dashboard link: https://syzkaller.appspot.com/bug?extid=6fda7f092994bd03fad1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c2cf09280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16325819280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2961112b4460/disk-0dd2a6fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ef8e1887351/vmlinux-0dd2a6fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4a1c984d6f73/bzImage-0dd2a6fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fda7f092994bd03fad1@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810eb60000 (size 26640):
  comm "syz-executor100", pid 4988, jiffies 4294944215 (age 14.910s)
  hex dump (first 32 bytes):
    03 cc 4b ef 00 00 00 00 00 68 00 00 01 00 00 00  ..K......h......
    0d e4 73 70 56 3e d4 50 e7 4f ba 9e e1 5c c0 c3  ..spV>.P.O...\..
  backtrace:
    [<ffffffff815460d7>] __do_kmalloc_node mm/slab_common.c:954 [inline]
    [<ffffffff815460d7>] __kmalloc+0xb7/0x120 mm/slab_common.c:979
    [<ffffffff826405bd>] kmalloc include/linux/slab.h:563 [inline]
    [<ffffffff826405bd>] fbcon_set_font+0x1ed/0x4a0 drivers/video/fbdev/core/fbcon.c:2502
    [<ffffffff8278ad5e>] con_font_set drivers/tty/vt/vt.c:4626 [inline]
    [<ffffffff8278ad5e>] con_font_op+0x5ae/0x730 drivers/tty/vt/vt.c:4673
    [<ffffffff82774b78>] vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
    [<ffffffff82774b78>] vt_ioctl+0x468/0x1d90 drivers/tty/vt/vt_ioctl.c:752
    [<ffffffff82757161>] tty_ioctl+0x4c1/0xd00 drivers/tty/tty_io.c:2777
    [<ffffffff8167fa80>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff8167fa80>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff8167fa80>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff8167fa80>] __x64_sys_ioctl+0x100/0x140 fs/ioctl.c:856
    [<ffffffff84a14749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a14749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
