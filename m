Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA32267F4E
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Feb 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483819; cv=none; b=rv4nsvSV+CEY0N7Ajw87PAsY9cQ6VA2D7KHHyxGNmvJs9RNRHND8MsA9KcnV4YUhQbE4kaC1wEn0c14XvZSeQfnU/Fe8HlT8KGKx3t/ZT8UjMi1mjhtI1c3ufvTJwvEOVrjidukMDpE/VRP3XhYPQzki6PEYjMRG8VFMjg3OPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483819; c=relaxed/simple;
	bh=A0H+uA5AcuxpI89I3toRLh3HSxHEqNAQR44KjeeZe9M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Obd3tdbOr5KFoNOccRWWgoxKrSNnID/FxY7bN0MT/4hF5whyTPRWErxyEPhajzzhh/BduOYbPvJOQKp2fGeyj1a+K57eq64NIpYStW4dClDnJqRsnixHtmj2qvDr28Dc9fNGD6V9/L40Is4nYBtIh9ch02AyvgTS2zJ60/j08Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2b70f5723so111201335ab.1
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Feb 2025 03:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483816; x=1741088616;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHUPwMMe6tL/hSjkxiVP3JeiNcJ8v+AqTWhilBCfmyU=;
        b=TKsKlVo/FePGHqdkzV6HkGfXk/VeifjzFaiZ1Wpkr3YQcDLFTWSh5e1AV81n4OWi+U
         sYkN29gixLyu7BGJ4ajH9D2SVYrVEw3z8So1fRqodYHx/IRGtGJYtyCBuYLHmO16eTw9
         YNaitrQVG/kkQGBjHgqfXLRynhvTc1vERbSdlo/VR1kpke8Q5iLqYunul+M11zZqHL+u
         ZdDQWh5uSPjsggJi1iheZM0dyHmJ2KegQ0MdglpmC+Zc7RUNiToEZ3o/H5T7kTZTTCq6
         xrSe32oBMbXKPrgtokU9ANxNaVG7CWy4k/OiAmGvZ7e5TTp2B4JI2tG75+L99tbIvENh
         7EKw==
X-Forwarded-Encrypted: i=1; AJvYcCX70jQOH1zI5pvKXNn2vjJ1wyLV+QuzSna1XULjbBC96hr9yBkoRUUlq360dROq69A3eHsFRIR3Bm8Lrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjSBdPZIYo3PT1FqsQ5ESEInf/9eLu7su1+tTboCH/gGUtrM1
	G8OL7XDMqOZM7aq72xSCWkRcZNWBpfCTqPqqd9fN9XcOPqannKUDLvVLbP0WaEfQXSSQd64iOLE
	e7ruObRrJaflFZZiuFJntdzoiBfE8cQ7H5Y1pMesSsxWjfJpfAzioxds=
X-Google-Smtp-Source: AGHT+IFj1NHM3myWluJ/MLqEZZdrQqAer5LCyfIFbALYWLAaIEavN+NNUifjDGoWsNuzZvQIzUnrcyBSXJF1jPv5ha2RRM5WyYyF
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4602:b0:3d3:ce1b:5e84 with SMTP id
 e9e14a558f8ab-3d3ce1b6053mr8414535ab.22.1740483816347; Tue, 25 Feb 2025
 03:43:36 -0800 (PST)
Date: Tue, 25 Feb 2025 03:43:36 -0800
In-Reply-To: <67bd6bef.050a0220.bbfd1.009d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bdace8.050a0220.bbfd1.00a6.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f56db0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172e77f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/323a5d590eec/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c4b6e33fd9/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c518bbd55334/bzImage-d082ecbc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:38 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_prepare_logo+0xa15/0xc80 drivers/video/fbdev/core/fbcon.c:614
Read of size 256 at addr ffff888032edef60 by task syz.2.2428/8600

CPU: 0 UID: 0 PID: 8600 Comm: syz.2.2428 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xd9/0x110 mm/kasan/report.c:634
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 scr_memcpyw include/linux/vt_buffer.h:38 [inline]
 fbcon_prepare_logo+0xa15/0xc80 drivers/video/fbdev/core/fbcon.c:614
 fbcon_init+0xd41/0x1890 drivers/video/fbdev/core/fbcon.c:1146
 visual_init+0x31d/0x620 drivers/tty/vt/vt.c:1011
 do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3831
 vt_bind drivers/tty/vt/vt.c:3987 [inline]
 store_bind+0x61d/0x760 drivers/tty/vt/vt.c:4059
 dev_attr_store+0x55/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb44418d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe52f027e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb4443a5fa0 RCX: 00007fb44418d169
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fb44420e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb4443a5fa0 R14: 00007fb4443a5fa0 R15: 0000000000000003
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x32edc
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff00000000002 ffffea0000cbb701 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 8600, tgid 8600 (syz.2.2428), ts 463971995066, free_ts 463963903452
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 __alloc_pages_noprof+0xb/0x1b0 mm/page_alloc.c:4773
 __alloc_pages_node_noprof include/linux/gfp.h:265 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:292 [inline]
 ___kmalloc_large_node+0x84/0x1b0 mm/slub.c:4239
 __kmalloc_large_node_noprof+0x1c/0x70 mm/slub.c:4266
 __do_kmalloc_node mm/slub.c:4282 [inline]
 __kmalloc_noprof.cold+0xc/0x61 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 vc_do_resize+0x1e3/0x10f0 drivers/tty/vt/vt.c:1174
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_init+0xd1d/0x1890 drivers/video/fbdev/core/fbcon.c:1143
 visual_init+0x31d/0x620 drivers/tty/vt/vt.c:1011
 do_bind_con_driver.isra.0+0x57a/0xbf0 drivers/tty/vt/vt.c:3831
 vt_bind drivers/tty/vt/vt.c:3987 [inline]
 store_bind+0x61d/0x760 drivers/tty/vt/vt.c:4059
 dev_attr_store+0x55/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
page last free pid 8600 tgid 8600 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 __folio_put+0x32a/0x450 mm/swap.c:112
 vc_do_resize+0xe31/0x10f0 drivers/tty/vt/vt.c:1194
 vc_resize include/linux/vt_kern.h:49 [inline]
 fbcon_startup+0x406/0xb70 drivers/video/fbdev/core/fbcon.c:997
 do_bind_con_driver.isra.0+0x207/0xbf0 drivers/tty/vt/vt.c:3794
 vt_bind drivers/tty/vt/vt.c:3987 [inline]
 store_bind+0x61d/0x760 drivers/tty/vt/vt.c:4059
 dev_attr_store+0x55/0x80 drivers/base/core.c:2439
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:139
 kernfs_fop_write_iter+0x33d/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0x5ae/0x1150 fs/read_write.c:679
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888032edef00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888032edef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888032edf000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff888032edf080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888032edf100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
