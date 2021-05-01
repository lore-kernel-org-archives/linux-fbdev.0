Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBB8C43461
	for <linux-fbdev@archiver.kernel.org>; Sat,  1 May 2021 20:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD496613F0
	for <linux-fbdev@archiver.kernel.org>; Sat,  1 May 2021 20:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhEAUcI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 1 May 2021 16:32:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46806 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhEAUcH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 1 May 2021 16:32:07 -0400
Received: by mail-io1-f69.google.com with SMTP id b16-20020a5ea7100000b02904037ac1756fso877678iod.13
        for <linux-fbdev@vger.kernel.org>; Sat, 01 May 2021 13:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QKKJFHy3y5PAsVWvUOn8W0GWRt3JUykQc3seKuU45/4=;
        b=jVKvpFSzx0KzaVyCNePCCBjlJv6VR52vBP2wFPsbfxkB29plS1lz6f8hPazmT+soBK
         Apsw/jxniYb1kISwVUHEPb+NP+N9zkb17kQoBJh9RUeAtoe9rZJqohgh/JDYXj5ZurYq
         dyiU1UY/jnUqBB0BoUPGVE2Tac5B3lY9xk5kUXFHdpVCq8RPleyHY5/i1+Ii6Q4diZOc
         VvTcX873zbtomL5cbNmCNwa7LMVH5LVnNaMe7prnF1zpRVqJ5hGWqNbG2IRPfxViPs1b
         MxwvoHgphELAN6Hen5+odT1hdWnct2zcsnLzGgItQdctefJvsXMc9CiCpG0xdmy6iQL5
         W6CA==
X-Gm-Message-State: AOAM533G4X6D0gVBNZSFhtp1BfQah1lcdTg1z0k5JEjcFen+d5g7qgqY
        ekg8gHsKoVBzSHxhoYCVeJ7Q6piO5z1dqfaA2khUvfvrESYq
X-Google-Smtp-Source: ABdhPJzM7AnkqLcqp1eLfSDgDDEGL+0l6r5QnAfDl0uhyw/39cl/21byqnounSuTGEnjewTSm8fPeOQpuFS/dJN8OCJTgGrJ4Rls
MIME-Version: 1.0
X-Received: by 2002:a92:da8a:: with SMTP id u10mr9659277iln.100.1619901076158;
 Sat, 01 May 2021 13:31:16 -0700 (PDT)
Date:   Sat, 01 May 2021 13:31:16 -0700
In-Reply-To: <00000000000086452c05a51da504@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000373dd005c14a9c72@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 vga16fb_imageblit (2)
From:   syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, colin.king@canonical.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, jani.nikula@intel.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d80be1d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
dashboard link: https://syzkaller.appspot.com/bug?extid=1f29e126cf461c4de3b3
compiler:       Debian clang version 11.0.1-2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d9ff43d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10981693d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff888001000040
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 11201067 P4D 11201067 PUD 11202067 PMD 80000000010001e1 
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8403 Comm: syz-executor112 Not tainted 5.12.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1176 [inline]
RIP: 0010:vga16fb_imageblit+0xcee/0x1cb0 drivers/video/fbdev/vga16fb.c:1260
Code: 66 66 2e 0f 1f 84 00 00 00 00 00 90 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 1b 41 0f b6 04 24 <41> 88 06 85 ed 74 2b 49 ff c4 49 ff c6 e8 80 ae 43 fd ff cd eb cc
RSP: 0018:ffffc9000163f0a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888001000040 RCX: dffffc0000000000
RDX: ffff888022ad54c0 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff843b289b R09: 0000000000000000
R10: 0000000000000002 R11: ffff888022ad54c0 R12: ffff8880181bcea8
R13: ffffc9000163f2cc R14: ffff888001000040 R15: 0000000000000004
FS:  0000000001207300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888001000040 CR3: 0000000028d32000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bit_putcs+0x18e8/0x1de0 drivers/video/fbdev/core/bitblit.c:105
 fbcon_putcs+0x2ae/0x430 drivers/video/fbdev/core/fbcon.c:1296
 do_update_region+0x4d6/0x6a0 drivers/tty/vt/vt.c:676
 redraw_screen+0x8f6/0x1270 drivers/tty/vt/vt.c:1035
 fbcon_blank+0x556/0xa50 drivers/video/fbdev/core/fbcon.c:2207
 do_unblank_screen+0x27e/0xb20 drivers/tty/vt/vt.c:4406
 vt_kdsetmode drivers/tty/vt/vt_ioctl.c:276 [inline]
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:381 [inline]
 vt_ioctl+0x2a82/0x3180 drivers/tty/vt/vt_ioctl.c:713
 tty_ioctl+0xf51/0x1720 drivers/tty/tty_io.c:2805
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:1069 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:1055
 do_syscall_64+0x3f/0xb0 arch/x86/entry/common.c:47
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43fef9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc931a4c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000013f84 RCX: 000000000043fef9
RDX: 0000000000000000 RSI: 0000000000004b3a RDI: 0000000000000003
RBP: 0000000000000000 R08: 000000000000000d R09: 00007ffc931a4de8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc931a4c5c
R13: 431bde82d7b634db R14: 00000000004ae018 R15: 0000000000400488
Modules linked in:
CR2: ffff888001000040
---[ end trace 96734cf7ef5cce91 ]---
RIP: 0010:writeb arch/x86/include/asm/io.h:65 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1176 [inline]
RIP: 0010:vga16fb_imageblit+0xcee/0x1cb0 drivers/video/fbdev/vga16fb.c:1260
Code: 66 66 2e 0f 1f 84 00 00 00 00 00 90 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 1b 41 0f b6 04 24 <41> 88 06 85 ed 74 2b 49 ff c4 49 ff c6 e8 80 ae 43 fd ff cd eb cc
RSP: 0018:ffffc9000163f0a0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888001000040 RCX: dffffc0000000000
RDX: ffff888022ad54c0 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff843b289b R09: 0000000000000000
R10: 0000000000000002 R11: ffff888022ad54c0 R12: ffff8880181bcea8
R13: ffffc9000163f2cc R14: ffff888001000040 R15: 0000000000000004
FS:  0000000001207300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888001000040 CR3: 0000000028d32000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

