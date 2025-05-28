Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084BF276027
	for <linux-fbdev@vger.kernel.org>; Wed, 28 May 2025 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424155; cv=none; b=gOEc+0vGi91lW/Hur8nICcpOn9XZOosrI1nLAkKz4Zi7dwyHJRsThP0GZFp+muzr8qDtbSykPAX1Urj5sU/HUoD7Sr+Z8yviR21IJvP1qw7y0wi13pQyOICJBM0YORHBXxv18Q1P5Ka0gXOs8AOXc/E1cqRALt7rRh8EA+bIsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424155; c=relaxed/simple;
	bh=EH1mMXQI5wxXfEugUS09ywjvRboZIQjKHsBHP/oQu+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ekbnl6lcjfCziqqTSGlAsEw6gFwsFXf9oQ9w1n+Xrx5Mw/iNvy7Iw5tYVjGMIUSWRQ9RGT2D59u1td8efNKlNqMVV6dYo4+TsrFj9DkLsT7n21NgWXckNpdM2HDsdLGLG2JnXbQQSw3IXQZJI8ComUDaLXyVmxIFBgpHPL7oRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-869e9667f58so857330739f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 28 May 2025 02:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748424153; x=1749028953;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QaxN9yI31Cw8gE+zvX2r8p8Olm+56SyVzimumhvEfJc=;
        b=I844W5Vct/t9xRJVR5QQLhTU69DY7T+6Q1egV+b1ssYv4Md3tErrUWVFUWayHQIgpO
         n4JhQlG/pjUEK5mlLEJ74wju5u3/8nUN42hF1VjQTfEqfPHVWwfTZFV5sD9m0gHJiz24
         kHzF86ubJivyqtd3hqxaslFo/c3drALLkSQ4LuFVM4d7yuCoh4fhq86mpu483YSumghN
         uH9Nfj/Hk6ZpcH8gOxfby2om2vIUT8qs+PkrOkRux9gsWeJcXTRZbbj/KojGKz3eVUS9
         jzZVP2bLwKL890jQ5RVpmRY2IOqRzUK8C3kP4nx24k498x/5EG1hFpkVRYkDerWwTxt/
         EJxA==
X-Forwarded-Encrypted: i=1; AJvYcCU6jI6LD22f+xd1GeSz4he3GlD4eNAcwmmH6jiURKMSa43IxlzOwlKnScUdctDSx492kY5NucKSNxGW7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiGr/QTDWjBiVKvBOIy1FEV1hY3tNCwzdqjC0OTeW5pd7Oy1+
	U880fl4IAuU2XDMtOrZc72PPSiwJDnaAWEFSrR/Ivod2c4Ncikm1AQHMnyu9qsw8s2xx1kXtqSg
	eFlFTs6ob8MYBGGEh1De2IOLtnB01dqtc44S0TL88JsV3C7DrqB59Y57pcVY=
X-Google-Smtp-Source: AGHT+IEU8oC+KFnoYP3nDRWZ403fy3i4VUTZQ8/uDd7pju+VTyPCCQ2XA+O9zAdIm7tXNHqKPXfH4qvZVoL4nJW5cEwGqe+QDBym
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7509:b0:867:2374:49cd with SMTP id
 ca18e2360f4ac-86cbb7b73demr1657350139f.2.1748424152959; Wed, 28 May 2025
 02:22:32 -0700 (PDT)
Date: Wed, 28 May 2025 02:22:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6836d5d8.a70a0220.253bc2.00c5.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in fillrect
From: syzbot <syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	soci@c64.rulez.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a5806cd506af Linux 6.15-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12afde70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87b7b87abbf1a67f
dashboard link: https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0398ca67d9a/disk-a5806cd5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dccdb3c5ff14/vmlinux-a5806cd5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3d94cf3493b5/bzImage-a5806cd5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bitfill drivers/video/fbdev/core/fb_fillrect.h:134 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:220 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:279 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect+0x15d4/0x17b0 drivers/video/fbdev/core/sysfillrect.c:22
Write of size 8 at addr ffffc90003849000 by task syz.1.1552/13525

CPU: 1 UID: 0 PID: 13525 Comm: syz.1.1552 Tainted: G     U              6.15.0-rc7-syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
 bitfill drivers/video/fbdev/core/fb_fillrect.h:134 [inline]
 fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:220 [inline]
 fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:279 [inline]
 sys_fillrect+0x15d4/0x17b0 drivers/video/fbdev/core/sysfillrect.c:22
 drm_fbdev_shmem_defio_fillrect+0x22/0x140 drivers/gpu/drm/drm_fbdev_shmem.c:37
 bit_clear+0x17a/0x220 drivers/video/fbdev/core/bitblit.c:73
 __fbcon_clear+0x600/0x780 drivers/video/fbdev/core/fbcon.c:1292
 fbcon_scroll+0x48b/0x690 drivers/video/fbdev/core/fbcon.c:1851
 con_scroll+0x45c/0x690 drivers/tty/vt/vt.c:579
 csi_M drivers/tty/vt/vt.c:2072 [inline]
 csi_ECMA drivers/tty/vt/vt.c:2483 [inline]
 do_con_trol drivers/tty/vt/vt.c:2657 [inline]
 do_con_write+0x6869/0x7c90 drivers/tty/vt/vt.c:3092
 con_write+0x23/0xb0 drivers/tty/vt/vt.c:3432
 process_output_block drivers/tty/n_tty.c:561 [inline]
 n_tty_write+0x40f/0x1160 drivers/tty/n_tty.c:2377
 iterate_tty_write drivers/tty/tty_io.c:1015 [inline]
 file_tty_write.constprop.0+0x502/0x9b0 drivers/tty/tty_io.c:1090
 tty_write drivers/tty/tty_io.c:1111 [inline]
 redirected_tty_write drivers/tty/tty_io.c:1134 [inline]
 redirected_tty_write+0xd4/0x150 drivers/tty/tty_io.c:1114
 new_sync_write fs/read_write.c:591 [inline]
 vfs_write+0x5ba/0x1180 fs/read_write.c:684
 ksys_write+0x12a/0x240 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f457158e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f457244f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f45717b5fa0 RCX: 00007f457158e969
RDX: 0000000000000013 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007f4571610ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f45717b5fa0 R15: 00007ffddb9e8a38
 </TASK>

The buggy address ffffc90003849000 belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90003848f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003848f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003849000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90003849080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003849100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
