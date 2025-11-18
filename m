Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0212517AF
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Nov 2025 08:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452832; cv=none; b=Cqx6Y0Jjneo40TF9Az6goHA9dYe8zyJ3z/suKwTJVOWjCkUjX2UCCgu8sGTUbybewZ6WhHeNixFbzeyHN8AJMpvTbBow5Qdu5UxBMiWSXGVdxGbpXNmEtWFAApxr2xNRDueOQfBiRGwfxpHuTf5J6jyFWwwGwQB7qkodzO4/D1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452832; c=relaxed/simple;
	bh=vGMiemJRHg5EX1vh0pb+J4+nqLZl5HwCelERxdNYGtU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aPs0eakH4yMvI5mHHRQ2Day7xBjcmxRVsaH70Cpl5az44/MTWDZFIbVAwMdtPHzS1XalRpepJjJaTVzXBmaiQ43Ava/FLyVrN4FySTTXMzKIJ8JwdzYNmeMpkYLpCuHwyi0PSpSw+hYeoMqW3xKes/RvMlLu5X888sx7VCvw3tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9434f5350bcso478992639f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Nov 2025 00:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763452830; x=1764057630;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C8/pNX9SbOjjNIN26OVWmhsh/hu9+rN3ZW/7Vppn+XU=;
        b=D8Ax90XY0mXCUF9FKKUr64/aXJnFnX2JQfhDEkeYnUZk2CcOjhGGroefCsITwpiT3e
         ojZwErDPCBLTtl08WxL/5jfsx3DeDVvK0uaDEeCySGAoObhXF48CDrU0P9MLIvhY3MH/
         3iRsfRT0t9yzaXX0rdKX9o/GvXYmIF6fa9QBqJiw4WoB0rVvTTTuTpjB2afAlTGtWS+D
         MD+3ORwZsTJpte28NFiSY9m+I+fC8zWYUXDS9qf6LUMcxCrj+jiSUDeHNmvMXnkhWnT1
         WtARHQ+DN3M/tZkp82gatnq0oLDeo9bUhKB92OFcfhOSTUEXS+bXWLy2gYl0L5Fb8Lek
         TWhA==
X-Forwarded-Encrypted: i=1; AJvYcCX95mqTG5md03WWE/kQghWOOMdizRfOvBAiXBWk0Q/trhP+l//7o1OfUZB4HTvagRMnTHA6jdjqxOeGjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnjY4dXEiJdPbwlrcQNbMg7v/X188KU0KoTmsr8lk7KlHEz2+
	H+kRq16cGSXUjqrfo4ZiKS8Log0cxixROYXSoV+UCVcU62vu42rF+MRwnNAmzys3S7E9k7btenY
	aR/nt0t+nVmp+uzsPb2aQEXGdyKMV0NK1qXiZNm9LV7+sgN/6ZLDFBKtsbQk=
X-Google-Smtp-Source: AGHT+IFUSYc9EyrU2PmUGojVWx8wzC4EoFtzpZnqsofEv6VT0N5YvuvB7b8t6F5+Hyp52FZwysMK6tWyhPLmwhf5eNBJ83zLs10Q
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f1a:b0:572:c2ff:b9bd with SMTP id
 8926c6da1cb9f-5b7fa51bd46mr2755534173.0.1763452830020; Tue, 18 Nov 2025
 00:00:30 -0800 (PST)
Date: Tue, 18 Nov 2025 00:00:30 -0800
In-Reply-To: <6907c8c8.a70a0220.37351b.0012.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691c279e.a70a0220.3124cb.00b5.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (6)
From: syzbot <syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	soci@c64.rulez.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    e7c375b18160 Merge tag 'vfs-6.18-rc7.fixes' of gitolite.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15476692580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=5a40432dfe8f86ee657a
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a70332580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173228b4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1fcb660703f1/disk-e7c375b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4bf314965321/vmlinux-e7c375b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/456b373fea36/bzImage-e7c375b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a40432dfe8f86ee657a@syzkaller.appspotmail.com

RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fff34de03f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fd0417e5fa0 R14: 00007fd0417e5fa0 R15: 0000000000000003
 </TASK>
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
Write of size 8 at addr ffffc90003749fc0 by task syz.0.17/6037

CPU: 0 UID: 0 PID: 6037 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xcd/0x630 mm/kasan/report.c:482
 kasan_report+0xe0/0x110 mm/kasan/report.c:595
 fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
 fb_bitmap_2ppw drivers/video/fbdev/core/fb_imageblit.h:364 [inline]
 fb_bitmap_imageblit drivers/video/fbdev/core/fb_imageblit.h:462 [inline]
 fb_imageblit drivers/video/fbdev/core/fb_imageblit.h:492 [inline]
 sys_imageblit+0x1a6f/0x1e60 drivers/video/fbdev/core/sysimgblt.c:24
 drm_fbdev_shmem_defio_imageblit+0x20/0x130 drivers/gpu/drm/drm_fbdev_shmem.c:38
 cw_putcs_aligned drivers/video/fbdev/core/fbcon_cw.c:110 [inline]
 cw_putcs+0x917/0xbb0 drivers/video/fbdev/core/fbcon_cw.c:158
 fbcon_putcs+0x387/0x450 drivers/video/fbdev/core/fbcon.c:1320
 do_update_region+0x2e9/0x3f0 drivers/tty/vt/vt.c:628
 redraw_screen+0x63f/0x760 drivers/tty/vt/vt.c:980
 fbcon_modechanged+0x456/0x6b0 drivers/video/fbdev/core/fbcon.c:2710
 fbcon_rotate drivers/video/fbdev/core/fbcon.c:228 [inline]
 rotate_store+0x258/0x2f0 drivers/video/fbdev/core/fbcon.c:3215
 dev_attr_store+0x58/0x80 drivers/base/core.c:2437
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd04158f6c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff34de0398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd0417e5fa0 RCX: 00007fd04158f6c9
RDX: 0000000000000007 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fff34de03f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fd0417e5fa0 R14: 00007fd0417e5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc90003749e80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003749f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003749f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                           ^
 ffffc9000374a000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000374a080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
