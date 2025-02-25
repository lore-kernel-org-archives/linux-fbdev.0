Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5600E254875
	for <linux-fbdev@vger.kernel.org>; Tue, 25 Feb 2025 07:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740467186; cv=none; b=ojouuiN6qCNtzgnCr0n3Wr/3tDpq4ceR7200ywigjlaMQ0KXzr3khQY5ViynhBanYqS3IOFIpEWqgcC5lEZHoKc6FUg8G4kPz3OlEoZgzakNm4c8bkWjPDmXlcduQPeQ+Spm2kKjka+CrIO+ewNa8vKNKWl2CgWyMWB+RsOpe10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740467186; c=relaxed/simple;
	bh=6eGMpO2mjsrt9XfhCGPf0/igcsroeqJ8dVWBYfM4KQs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aQsT+MwZa4E4F0oJVdHz/KgeKtdCakC74JRTjp1JGaki58ZiNRuFkRLc4yAjz+Mr065a0ltBuV1mJTQShQsOgRB4jNmUtb35JbtqdstoQprHvYLgu0CwEE7hGkDYangyEtdQD+HE4l6n8p4x6+i2hzZnmsWKr3HVCB6jBdCauV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso116747475ab.3
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Feb 2025 23:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740467183; x=1741071983;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=skZVpTrxwM/0Qw6jRSv6aUe9ONEP/CFM61Y6JqwCXX0=;
        b=qBzgVD3MXHopWw4UzPgFuJk0y+lLiIaxABz+z1+7vJ6FxGa3ycckRtxuAJxY0FbtJO
         l47D9KG2vfVqkDALshHzUXCXtgOl4CFIdnG7VSaZJW2DlO0mJmRROU1buLbBtDFN662c
         tLjM4Q+gw/sY/+4N85IWj4bNC2AsJYYvjziQ2M7iSU4hndRCzXIvhpW+ofIhJvJ2OHFU
         w6ryD5s5zZpoVwQQgucCm/f5fdJ6S8uiU1MOQ38dDUAhR1ao4TrY9pgDPaLh0T0vncBq
         hYOlRTNW+uwtmnydzVC2ATiMY12qEZZRINrfva94JyAZ13BQVmdmx3DMI0Xk5LzrMs4x
         pUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKobY0LaEjgycn7WEzKK2JXKYjJdfE7NELS+o79G1bYQHitazJyQVScAAYYpVLmouTml+xIpT9jwP6gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRf0qYW/3LVQwMG2MG74N+EqnSYWV1sKVhvwH9X+foRBQMFuR
	eBs4cz9XiTaxwZIxTC5U8by3mh5Q4xPn4nYIvJ8HTrqPVK1R2bUixyB4fmA4HtrpHuHuFJ+HIGM
	6jOoN5viE2JVtySARJNtT3HQQq1gJ4CXtgV8j1H0F6Eq0vZMqPqnuyZk=
X-Google-Smtp-Source: AGHT+IGcsyu85lDB9nq1TeiGaKLcrsEFnu45po82K1OzSR8il+MmCZ9DON5F58aP2eWogfMe8sBSxq1n4XLHsZTHqgGQrAMqGLMi
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218b:b0:3d2:b5ae:f662 with SMTP id
 e9e14a558f8ab-3d2caf1a2e5mr189866135ab.21.1740467183480; Mon, 24 Feb 2025
 23:06:23 -0800 (PST)
Date: Mon, 24 Feb 2025 23:06:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bd6bef.050a0220.bbfd1.009d.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: slab-out-of-bounds Read in fbcon_prepare_logo
From: syzbot <syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100c97a4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=0c815b25cdb3678e7083
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/323a5d590eec/disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c4b6e33fd9/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c518bbd55334/bzImage-d082ecbc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c815b25cdb3678e7083@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in scr_memcpyw include/linux/vt_buffer.h:38 [inline]
BUG: KASAN: slab-out-of-bounds in fbcon_prepare_logo+0xa15/0xc80 drivers/video/fbdev/core/fbcon.c:614
Read of size 256 at addr ffff888033e96f60 by task syz.0.317/7285

CPU: 1 UID: 0 PID: 7285 Comm: syz.0.317 Not tainted 6.14.0-rc4-syzkaller #0
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
RIP: 0033:0x7f44b6f8d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44b7dc3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f44b71a5fa0 RCX: 00007f44b6f8d169
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f44b700e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f44b71a5fa0 R15: 00007ffee813d3a8
 </TASK>

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888033e94340 pfn:0x33e94
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
raw: ffff888033e94340 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff00000000040 0000000000000000 dead000000000122 0000000000000000
head: ffff888033e94340 0000000000000000 00000001ffffffff 0000000000000000
head: 00fff00000000002 ffffea0000cfa501 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x140dc0(GFP_USER|__GFP_COMP|__GFP_ZERO), pid 7285, tgid 7284 (syz.0.317), ts 193263994848, free_ts 193235941647
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
page last free pid 7285 tgid 7284 stack trace:
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
 ffff888033e96f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888033e96f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888033e97000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                   ^
 ffff888033e97080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 ffff888033e97100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
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
