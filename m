Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD3DC433DB
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Jan 2021 10:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BF62310D
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Jan 2021 10:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbhAFKHC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:07:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:43336 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbhAFKHC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Jan 2021 05:07:02 -0500
Received: by mail-io1-f71.google.com with SMTP id c7so1434513iob.10
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Jan 2021 02:06:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5pDa3vIbxqJdV1lVZT6U5h+gjd7CuxHz3mCEuppmKfw=;
        b=Eobfc0IeCkVFxCBoQffiUNoZJ8iAHybDRF9BgxiYZukrceEJnNz7Ckz1Pb69r5iC8T
         f62ikKEI3S824tsO4RUzYCMrCBzf8YxUInkcf8QAHCe6V8hvC+n2g/JCs8DacS1WxpKD
         Lk5xVS3cU4IJnhQAR8+4qrCsOrWVJwUicCnL+YgxWV5JmpTniTyn8dStqjZeredmIed3
         TKDAIpswtSRL3/o97IXMcDpMX3YeT9GxeytUg5K+h+ooRSPAT892uZTTVLZobyN6FAfy
         CyIM90xv++M24uGZNpAT71JWGd8eT9zRkPVI4pDxtJMCCClIw0kLNH148W14qwflzYNd
         NwlQ==
X-Gm-Message-State: AOAM532FEH15zr//SXH1h1iqGsMDI5H4ONIa+MQZIYi7fpUSc8ftC1TT
        ZaGT7wExUnAigeGy3c3M9rbCDw01iggORxZrDIj00MBTFGVa
X-Google-Smtp-Source: ABdhPJyz6jj8T7s4aF16nIkkLT5KgvVMzFdbAHECyRyJmG8ADNp4NjZXcTUBcaS5O7RAqYbBehOeBdkefR9g9FqXeTo5U1zu4XOM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3a3:: with SMTP id z3mr3024750jap.67.1609927581149;
 Wed, 06 Jan 2021 02:06:21 -0800 (PST)
Date:   Wed, 06 Jan 2021 02:06:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000096ae3b05b838799c@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in imageblit
From:   syzbot <syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6207214a Merge tag 'afs-fixes-04012021' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d0c7a8d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=104b0cac547b2149
dashboard link: https://syzkaller.appspot.com/bug?extid=858dc7a2f7ef07c2c219
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com

BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x117f/0x1290 drivers/video/fbdev/core/sysimgblt.c:275
Write of size 4 at addr ffffc9000bc11000 by task syz-executor.1/10779

CPU: 0 PID: 10779 Comm: syz-executor.1 Not tainted 5.11.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 print_address_description.constprop.0.cold+0x5/0x2f8 mm/kasan/report.c:230
 __kasan_report mm/kasan/report.c:396 [inline]
 kasan_report.cold+0x79/0xd5 mm/kasan/report.c:413
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:229 [inline]
 sys_imageblit+0x117f/0x1290 drivers/video/fbdev/core/sysimgblt.c:275
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
 fb_compat_ioctl+0x17e/0x610 drivers/video/fbdev/core/fbmem.c:1309
 __do_compat_sys_ioctl+0x1d3/0x230 fs/ioctl.c:842
 do_syscall_32_irqs_on arch/x86/entry/common.c:78 [inline]
 __do_fast_syscall_32+0x56/0x80 arch/x86/entry/common.c:137
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:160
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7f12549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f550c0bc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004601
RDX: 0000000020000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
 ffffc9000bc10f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000bc10f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000bc11000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc9000bc11080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000bc11100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
