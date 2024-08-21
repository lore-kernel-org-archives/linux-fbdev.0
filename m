Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5D2111B7
	for <linux-fbdev@vger.kernel.org>; Wed, 21 Aug 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235208; cv=none; b=SNmgqcTVf6ytTC3/eJaM3hCjxkVTY6bH5ZX+5IdBOHrZdcGOybYIvVCfbrrfhKTSqtiH26znbTqwkJ+mMXLj8PJcCLS0k3ZZE+ro3E+h0RjtWVFdrkBRGiGTT8CzZH1NVDwjr5p7WiSdbFd0UAEixigaCL1FHvRtxTWFm7O/Lxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235208; c=relaxed/simple;
	bh=zY5TOXEgvtf2zi8J8kXF6gXJJNMn+u/6nf4N6ZTyMJ8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rgNpUuDFoZBN2LolvNu7gHpFqQ/K8LcuwDhSXr0QkEDPlp4G0RTjXMoxyXtECclEr3knS0ZLp0BZnGgnZOc7BUOCxLq+QapqA1n+u4D2MPO3jHo78Y/rFKVtgy3bC9iV+zpz9c+rSbkelve/FP95+FutWQGl2nXY6pG+aISTwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-822372161efso461303639f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Aug 2024 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724235206; x=1724840006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UiFh2H3TQ9L0VhczgP+bvB+S7XEAVjt7rCWOHhajjM=;
        b=GpnDfcOaOZK2VE9kWRLj7MHX9vJdoEC6uKNn4ueZZ6LCg624TVKtMTBrgixP24Yt6/
         oIQqCHa3Z76v6+FFu3VWigmKlxbk9to0kfthgGu6i58ySYj1W059YczQ0Ij6JUcYD4nN
         X6TRXHcoffzFPzjxrtLVvTdUmbX5fam3AHZo3qB5aoiBcz67QII6xC+OQkd7WzUN1gld
         +NOPmSk4cPePMgOjVijOE8wHWcASpG13HAHwoHSXdAzg3nvyIE2p5ibs2HaYTMZQVk2o
         6G5yn06WlcQjQiSgLIuJmpqUSdkBGIwcMxNeQnlEAWZs5Ow0+XOMMnyP/HqZi9mUzIrN
         KT5A==
X-Forwarded-Encrypted: i=1; AJvYcCV5gN/hOhuKrJUYikL6Q7V2BRKlwS9s+9ugJLpFa98s4ayq6i/6D99WdImLZDq8T7tYVqmjJsj7SdyGSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLetAWpUr3aM/fySVoHKREqyPw97QL5JyI9+v4IBd6Lgytfw2
	922MUrrPMDktcMldGk8wfuv7TXHz34T8VbHesqc/jsrz7wYq+j1Rcs/AkSb91YVcQxn1ky5nKmK
	fH63bNTWhFnRWmfCo5oMO6BWFwa0FmA/vAcSBhTTXhExxwbtv8APb4T8=
X-Google-Smtp-Source: AGHT+IFfslfwRpzim82Y34UtM9j2TMDsKhPHkFZ+7frZREw42nfeE/6PM+qpr41N+JKn19pdqjnMt1ReULvJH8lpY1qB4euKWSeI
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210b:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4ce62da86bemr66384173.2.1724235205847; Wed, 21 Aug 2024
 03:13:25 -0700 (PDT)
Date: Wed, 21 Aug 2024 03:13:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4447f06202eca5f@google.com>
Subject: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in imageblit (4)
From: syzbot <syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com>
To: daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    670c12ce09a8 Merge tag 'for-6.11/dm-fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d41cdd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b7aa0513823e2ea880
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-670c12ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fdc54e331300/vmlinux-670c12ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e69f58032670/bzImage-670c12ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4b7aa0513823e2ea880@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_page_alloc, interval 1, probability 0, space 0, times 1
CPU: 0 UID: 0 PID: 5106 Comm: syz.0.0 Not tainted 6.11.0-rc3-syzkaller-00221-g670c12ce09a8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 prepare_alloc_pages+0x1da/0x5d0 mm/page_alloc.c:4473
 __alloc_pages_noprof+0x166/0x6c0 mm/page_alloc.c:4689
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 ___kmalloc_large_node+0x8b/0x1d0 mm/slub.c:4103
 __kmalloc_large_node_noprof+0x1a/0x80 mm/slub.c:4130
 __do_kmalloc_node mm/slub.c:4146 [inline]
 __kmalloc_noprof+0x2ae/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 vc_do_resize+0x31b/0x17f0 drivers/tty/vt/vt.c:1174
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_set_disp+0xac9/0x11d0 drivers/video/fbdev/core/fbcon.c:1389
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:794 [inline]
 set_con2fb_map+0xa6c/0x10a0 drivers/video/fbdev/core/fbcon.c:865
 fbcon_set_con2fb_map_ioctl+0x207/0x320 drivers/video/fbdev/core/fbcon.c:3092
 do_fb_ioctl+0x38f/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:138
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76311799b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7631f9d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7631315f80 RCX: 00007f76311799b9
RDX: 00000000200000c0 RSI: 0000000000004610 RDI: 0000000000000003
RBP: 00007f7631f9d090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f7631315f80 R15: 00007ffcf9b0e3e8
 </TASK>
==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1ec6/0x2b00 drivers/video/fbdev/core/sysimgblt.c:326
Write of size 4 at addr ffffc90001c19000 by task syz.0.0/5106

CPU: 0 UID: 0 PID: 5106 Comm: syz.0.0 Not tainted 6.11.0-rc3-syzkaller-00221-g670c12ce09a8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
 sys_imageblit+0x1ec6/0x2b00 drivers/video/fbdev/core/sysimgblt.c:326
 drm_fbdev_shmem_defio_imageblit+0x2e/0x100 drivers/gpu/drm/drm_fbdev_shmem.c:39
 bit_putcs+0x18ba/0x1db0
 fbcon_putcs+0x255/0x390 drivers/video/fbdev/core/fbcon.c:1288
 do_update_region+0x396/0x450 drivers/tty/vt/vt.c:619
 redraw_screen+0x902/0xe90 drivers/tty/vt/vt.c:971
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:794 [inline]
 set_con2fb_map+0xa6c/0x10a0 drivers/video/fbdev/core/fbcon.c:865
 fbcon_set_con2fb_map_ioctl+0x207/0x320 drivers/video/fbdev/core/fbcon.c:3092
 do_fb_ioctl+0x38f/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:138
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f76311799b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7631f9d038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7631315f80 RCX: 00007f76311799b9
RDX: 00000000200000c0 RSI: 0000000000004610 RDI: 0000000000000003
RBP: 00007f7631f9d090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 0000000000000000 R14: 00007f7631315f80 R15: 00007ffcf9b0e3e8
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90001919000, ffffc90001c1a000) created by:
 drm_gem_shmem_vmap+0x3ac/0x630 drivers/gpu/drm/drm_gem_shmem_helper.c:343

Memory state around the buggy address:
 ffffc90001c18f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90001c18f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90001c19000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc90001c19080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90001c19100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
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
