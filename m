Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B05BC433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 17 Jan 2021 08:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C01206D4
	for <linux-fbdev@archiver.kernel.org>; Sun, 17 Jan 2021 08:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbhAQI4L (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 17 Jan 2021 03:56:11 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43563 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbhAQIyE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 17 Jan 2021 03:54:04 -0500
Received: by mail-io1-f72.google.com with SMTP id n18so3776630ioo.10
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Jan 2021 00:53:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jB63CMEcmJtOeJXwbrg+QK8JaBfOQwDdZLHuAL7bLeE=;
        b=a5Hdc4N5UrzFhnOd7i/R9cx7rcfzzKM3rfViW+np2nJbk83QMclmZh1DvSt4hb3gZ3
         k3bWmEK6GpyRCrGa6KEfva0aX/RayLHTZI7GS9wAK45k+QzS4ebE3DxWCjFqcT/1DL95
         vh/v47Fhl0SbsPCZPM4jTudEehSoJAC8FZCZcZ1TI0gT/RQ4EVBV6uesi17H5Zzt7KkL
         /lc4Jgl9witCp7Fr3gSfEk5tq2HsiJBlociAtXzoS/Yn3/8uoswdq3KMX94Cs9N9b9Tn
         mD2CiRwd6h4UMpxeX8WtQ3N/C0385Y06iPg9ONKXo3BasIrZ4dimT+8WfMjjT7c1joR3
         dmTw==
X-Gm-Message-State: AOAM5325T9JEBoHG9AGJ+J1VLae++08/krbcas0GM2i0vMUnEiOGieID
        2JZBp5fCpf5PjFOA60bdrdX5CFtWUHqBtCMydGsfLBOcZrCN
X-Google-Smtp-Source: ABdhPJweouGIrw+slqM0687JcLjn/DUUC8TDxeOWr6ipObID1P0LywDif7Eo8t3OqmS7tfS+oZoePePlipgPh3nau4OvNFRajgIy
MIME-Version: 1.0
X-Received: by 2002:a92:8e0f:: with SMTP id c15mr16383751ild.224.1610873603038;
 Sun, 17 Jan 2021 00:53:23 -0800 (PST)
Date:   Sun, 17 Jan 2021 00:53:23 -0800
In-Reply-To: <00000000000091111005b435456e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e325f205b914bc4c@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in fbcon_cursor
From:   syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=164096d7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=b67aaae8d3a927f68d20
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cd8fe0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af5258d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 12267067 P4D 12267067 PUD 11841067 PMD 0 
Oops: 0010 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 8463 Comm: syz-executor088 Not tainted 5.11.0-rc3-next-20210115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000132f850 EFLAGS: 00010292
RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000000002 RSI: ffff88814394b000 RDI: ffff888010071000
RBP: ffff888010071000 R08: 0000000000000000 R09: ffffffff83ed87ea
R10: 0000000000000003 R11: 0000000000000018 R12: ffff88814394b000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
FS:  0000000000db8880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000020cd8000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 fbcon_cursor+0x50e/0x620 drivers/video/fbdev/core/fbcon.c:1336
 hide_cursor+0x85/0x280 drivers/tty/vt/vt.c:907
 redraw_screen+0x5b4/0x740 drivers/tty/vt/vt.c:1012
 vc_do_resize+0xed8/0x1150 drivers/tty/vt/vt.c:1325
 fbcon_set_disp+0x7a8/0xe10 drivers/video/fbdev/core/fbcon.c:1402
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:808 [inline]
 set_con2fb_map+0x7a6/0xf80 drivers/video/fbdev/core/fbcon.c:879
 fbcon_set_con2fb_map_ioctl+0x165/0x220 drivers/video/fbdev/core/fbcon.c:3010
 do_fb_ioctl+0x5b6/0x690 drivers/video/fbdev/core/fbmem.c:1156
 fb_ioctl+0xe7/0x150 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x4402b9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffffae24f88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402b9
RDX: 0000000020000080 RSI: 0000000000004610 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401ac0
R13: 0000000000401b50 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 0000000000000000
---[ end trace 5adb9f198fe5efa6 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
RSP: 0018:ffffc9000132f850 EFLAGS: 00010292
RAX: 0000000000000007 RBX: 0000000000000000 RCX: 0000000000000007
RDX: 0000000000000002 RSI: ffff88814394b000 RDI: ffff888010071000
RBP: ffff888010071000 R08: 0000000000000000 R09: ffffffff83ed87ea
R10: 0000000000000003 R11: 0000000000000018 R12: ffff88814394b000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000720
FS:  0000000000db8880(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 0000000020cd8000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

