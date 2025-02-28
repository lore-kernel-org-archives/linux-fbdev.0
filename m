Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114A23F388
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Feb 2025 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775047; cv=none; b=NoOZfo4KYRBzfUrWd13auAMhYf6u6gN5qL8/7YOeVTF0xPmeAhH7fytvGgzPPGqwlISZP0wG/nRaKsp8i01wgTd4CIDUG51Wb+UC0FR6eDuL4izJ54eVRL2JZsTAW/E588nWNL/tZP+QF00CJwwK7jHreudgB/bkxEY07vLsEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775047; c=relaxed/simple;
	bh=Ljzb965b+3OQC91DRvdpu9r5brh3YKoyoV8uSEqBBo8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XcSTtGIUyn1JBDwAV1ynzRwPkgOdY4HqxKyrcIUXcblMK6AMdzJlfiZsLrSqUeKE9KSpOzQZnjdb1P+k9v6L87w7Yt/+3IxXFaqcUYn5sblvT623f3sV7jYzsKCwqOfKRAzxCOx/RN2yBY2gRa/pBs1KqlReXCNC6/pc0pq7IiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfb20d74b5so24513455ab.3
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Feb 2025 12:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775044; x=1741379844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=do92xcNC0WFQw/Ce4Jou7iOdOxAiPDFL0QRYd03MRmc=;
        b=e3BA0EMQDeV4NEYMjHdsugazaZWmEVrKX74vYFFzpg6IFHa1tlQw/spxLEck8Kg3xt
         QfZILl/Nns/ASXQuMaGiQFlT9cD4EKvH6pvwFWk7FEp6QAK22/Sk8HtYrzueiYybcXIE
         b98T+HS3OleOCYxZ0B50+01JwGWe37w7tgFQXkONVplIhvT0c1xPLPkkINgS0BZu0aEp
         DmYNAyX4d5tTLmR14KB4q4WMsPsEcbq9fv/UMvT1V451gmzVgAVLBBnlgFZm3/FJ6rH9
         xWnGvqAgRxa5rNYyhkKEIElTgBl4FyAJUSfmJdJ7BCrnTUoQymfSX5Nmgd0ddsoN0MEO
         DE4A==
X-Forwarded-Encrypted: i=1; AJvYcCV3owMYGkCwGKqYvWzv1dUNou+PaEZHyjhoMKhbrwv2ijSv6s3Wuq5/5EJ/mVfKywzVocRE2CVUTedLXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqF2eHI6JnjLAhh8j3L03Z6QR0hUDnTI2cxAQT30KyoyYgclEj
	R0rcDVjNaogj0RxhU9Z8u8WZAGvgm/Q4TLRm9Ga13Ej1LCReIaonCrfroxqtBdzBmUAeS6WPItv
	+AvIJisJre7Qy+L7OVI9/QPnZTW5NKuhFpRn8xcvtD15xVbm1iF/UZvU=
X-Google-Smtp-Source: AGHT+IHqBkfoR8i6w/+tls7TWCjrAcTvjAR2poqDZFJnZwHhvPVKnHVB5XKg+dX40lgp78juIZg0UgbAjVmei839Qm5EwcMJPMir
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216c:b0:3cf:bc71:94f5 with SMTP id
 e9e14a558f8ab-3d3e6f4aaecmr46976555ab.22.1740775044496; Fri, 28 Feb 2025
 12:37:24 -0800 (PST)
Date: Fri, 28 Feb 2025 12:37:24 -0800
In-Reply-To: <000000000000e39b37061e898704@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c21e84.050a0220.dc10f.0151.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in bit_putcs (3)
From: syzbot <syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com>
To: daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    017f704fbfb1 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12128864580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=793cf822d213be1a74f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1643dba0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16128864580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d34fb306468f/disk-017f704f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f1126558a26/vmlinux-017f704f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d9d912bee27/Image-017f704f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+793cf822d213be1a74f2@syzkaller.appspotmail.com

 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
==================================================================
BUG: KASAN: global-out-of-bounds in __fb_pad_aligned_buffer include/linux/fb.h:644 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
BUG: KASAN: global-out-of-bounds in bit_putcs+0x9b8/0xe30 drivers/video/fbdev/core/bitblit.c:185
Read of size 1 at addr ffff80008be20810 by task syz-executor101/6448

CPU: 1 UID: 0 PID: 6448 Comm: syz-executor101 Not tainted 6.14.0-rc4-syzkaller-g017f704fbfb1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x198/0x550 mm/kasan/report.c:521
 kasan_report+0xd8/0x138 mm/kasan/report.c:634
 __asan_report_load1_noabort+0x20/0x2c mm/kasan/report_generic.c:378
 __fb_pad_aligned_buffer include/linux/fb.h:644 [inline]
 bit_putcs_aligned drivers/video/fbdev/core/bitblit.c:96 [inline]
 bit_putcs+0x9b8/0xe30 drivers/video/fbdev/core/bitblit.c:185
 fbcon_putcs+0x390/0x5a0 drivers/video/fbdev/core/fbcon.c:1308
 do_update_region+0x1e8/0x3d0 drivers/tty/vt/vt.c:609
 update_region+0x1e0/0x478 drivers/tty/vt/vt.c:633
 vcs_write+0x9e8/0x1180 drivers/tty/vt/vc_screen.c:698
 do_loop_readv_writev fs/read_write.c:843 [inline]
 vfs_writev+0x494/0x92c fs/read_write.c:1052
 do_writev+0x178/0x304 fs/read_write.c:1096
 __do_sys_writev fs/read_write.c:1164 [inline]
 __se_sys_writev fs/read_write.c:1161 [inline]
 __arm64_sys_writev+0x80/0x94 fs/read_write.c:1161
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600

The buggy address belongs to the variable:
 fontdata_8x16+0x1010/0x1480

The buggy address belongs to the virtual mapping at
 [ffff80008b810000, ffff80008f6b0000) created by:
 declare_kernel_vmas+0x58/0xb8 arch/arm64/mm/mmu.c:771

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1a1820
flags: 0x5ffc00000002000(reserved|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000002000 fffffdffc5860808 fffffdffc5860808 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff80008be20700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff80008be20780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff80008be20800: 00 00 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
                         ^
 ffff80008be20880: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffff80008be20900: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
