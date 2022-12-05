Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C60C4321E
	for <linux-fbdev@archiver.kernel.org>; Mon,  5 Dec 2022 04:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiLEEet (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 4 Dec 2022 23:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLEEer (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 4 Dec 2022 23:34:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E23B64D1
        for <linux-fbdev@vger.kernel.org>; Sun,  4 Dec 2022 20:34:45 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so11283213ild.11
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Dec 2022 20:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcFrvjYpY9w3oBH5VMBrbCN5cG4DGtca+C+V9MNGNBY=;
        b=1/i1gtGCc3S9sO4Mdv5AyMlOAyBeXvzqLChY0Z6v9Ss8XfpthIboSuCfSXhAW9ygf2
         5QsTNcPVYI/wAfgTF0htvQ2Vpx0vjVK6OoHskD+45q3foaIYfzrHfXcfwDTXLlS15vBU
         1lwqEIM0f5bKZP1I5KOAkP63sRNcYOCJnF5gxcpLuuyb+0U4f5aAruZTelXBBpg6fR+I
         1mmh13zg+GQL4GsCh2rPXej2OVMVwSzqLV5BvOQAo4bXYRWSz2/Wu7dOm/HqCSBVqKIl
         8UxlctuF7J9Fz+Jbr2g8QpwpeCgxUzFlxoa+FFEksLZAD7Id9+OI9Q0KACLZSlclzc9n
         Le/A==
X-Gm-Message-State: ANoB5pl8Q5ZDfNfmh7I1VPiDN8d7ECVdCmvq+qQrvH5tODf/XFHhc5e/
        PqZ2eAVK86CuJqUfwiSI5e1sxHPlrEBYnyDM5Dp8IzttN0V1
X-Google-Smtp-Source: AA0mqf7iyVepFf9uvSqFu+Czqel85Bx9rIZHqrT9xKNbJkXJrxGVTRza++ig5vx166ELXQ5StTz/hrZ9soFSQWNPcWfAbfhn3byU
MIME-Version: 1.0
X-Received: by 2002:a5d:804e:0:b0:6dc:30bd:ed8f with SMTP id
 b14-20020a5d804e000000b006dc30bded8fmr30399822ior.130.1670214884451; Sun, 04
 Dec 2022 20:34:44 -0800 (PST)
Date:   Sun, 04 Dec 2022 20:34:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2efc305ef0d341f@google.com>
Subject: [syzbot] memory leak in fbcon_set_font (2)
From:   syzbot <syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        geert+renesas@glider.be, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c2bf05db6c78 Merge tag 'i2c-for-6.1-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171883d5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=979161df0e247659
dashboard link: https://syzkaller.appspot.com/bug?extid=25bdb7b1703639abd498
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fff84d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135806a7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63cd45bf1d68/disk-c2bf05db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bafbfb42c660/vmlinux-c2bf05db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f803a721cfc/bzImage-c2bf05db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111648000 (size 18448):
  comm "syz-executor148", pid 3653, jiffies 4294970435 (age 13.520s)
  hex dump (first 32 bytes):
    85 44 7e c7 00 00 00 00 00 48 00 00 00 00 00 00  .D~......H......
    92 30 86 d2 8c 38 30 9e e7 a3 05 00 9f 09 33 bb  .0...80.......3.
  backtrace:
    [<ffffffff814ee6d3>] __do_kmalloc_node mm/slab_common.c:943 [inline]
    [<ffffffff814ee6d3>] __kmalloc+0xb3/0x120 mm/slab_common.c:968
    [<ffffffff8250c359>] kmalloc include/linux/slab.h:558 [inline]
    [<ffffffff8250c359>] fbcon_set_font+0x1a9/0x470 drivers/video/fbdev/core/fbcon.c:2508
    [<ffffffff8262cd59>] con_font_set drivers/tty/vt/vt.c:4667 [inline]
    [<ffffffff8262cd59>] con_font_op+0x3a9/0x600 drivers/tty/vt/vt.c:4713
    [<ffffffff82618e3d>] vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
    [<ffffffff82618e3d>] vt_ioctl+0x14fd/0x1a80 drivers/tty/vt/vt_ioctl.c:752
    [<ffffffff825fdaf5>] tty_ioctl+0x6d5/0xbe0 drivers/tty/tty_io.c:2771
    [<ffffffff816200bc>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816200bc>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff816200bc>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff816200bc>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff8485c5e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485c5e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888110b18000 (size 18448):
  comm "syz-executor148", pid 3655, jiffies 4294971001 (age 7.860s)
  hex dump (first 32 bytes):
    85 44 7e c7 00 00 00 00 00 48 00 00 00 00 00 00  .D~......H......
    92 30 86 d2 8c 38 30 9e e7 a3 05 00 9f 09 33 bb  .0...80.......3.
  backtrace:
    [<ffffffff814ee6d3>] __do_kmalloc_node mm/slab_common.c:943 [inline]
    [<ffffffff814ee6d3>] __kmalloc+0xb3/0x120 mm/slab_common.c:968
    [<ffffffff8250c359>] kmalloc include/linux/slab.h:558 [inline]
    [<ffffffff8250c359>] fbcon_set_font+0x1a9/0x470 drivers/video/fbdev/core/fbcon.c:2508
    [<ffffffff8262cd59>] con_font_set drivers/tty/vt/vt.c:4667 [inline]
    [<ffffffff8262cd59>] con_font_op+0x3a9/0x600 drivers/tty/vt/vt.c:4713
    [<ffffffff82618e3d>] vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
    [<ffffffff82618e3d>] vt_ioctl+0x14fd/0x1a80 drivers/tty/vt/vt_ioctl.c:752
    [<ffffffff825fdaf5>] tty_ioctl+0x6d5/0xbe0 drivers/tty/tty_io.c:2771
    [<ffffffff816200bc>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816200bc>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff816200bc>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff816200bc>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff8485c5e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485c5e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
