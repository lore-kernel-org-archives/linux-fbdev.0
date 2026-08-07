Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B13222599
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Aug 2026 00:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786060895; cv=none; b=VHwiJ2UNFYhZ25ZqNIHIOI4t44Z2r0tHqbMElajxWOlY9S0CSdT9JTHrVKOgYfX+rMloD/PIj06PI4OPpUREa3dVvjpFrnaGihe5D1kDHZ4KmbBdwIY8wV1enDH8WSrQqB2Ckuj0lLr8xf8R5OFkGJs8oLjGzjG2bcVP+QTlCn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786060895; c=relaxed/simple;
	bh=73HqpWVFdYJ4Y4Tw7ATgyLoYlrGRqb5MMMfQ3g44pwA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NvHRaQQOKnSbpJC86BxBTEFFagj4c99wqBvlyULnY5R6aq6JtAaR7Oi8TQoQp9ZqImtxr56ZrbqpnJbi2HHI6iG+qJLyyMHHJHZg7ZyjuTnnbe1aGJiMP8AzT0Y6w8XDxS4E7o6B5bZ33X3wbP5VkbLCuO9ppPNAp4klRxUqjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-448bb8bcf38so2546886fac.1
        for <linux-fbdev@vger.kernel.org>; Thu, 06 Aug 2026 17:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786060892; x=1786665692;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GfN1QcOLKkE6f4SQ8/MOLAZKM4TDMu6M26J6J6oRM+U=;
        b=s+vVZZbu6bJ3iuaC5wdTIZoF4yF99IBMi9vF/o9U7FdhQWlbtxJohVPkLhnQR2Y0Ea
         1HjtoEiI9CxbfdQpzAOM87PoH4xkEFeLLjkwHgkx+f2MLBdWkSkQbMh38YZk+RTAcm1i
         vpwqP0dv34kgRGH5ZN03tfi8PxKNBYb33gwyWkSjhkNHU1gKdl+Uptj2gyEds78KQr6l
         QSjqOntY3ksG8Elr0WhXnBiCPjf7NzljMFnpr+R34udg0FDVYWqZkcCc+/H3ZoFw+CsB
         JK8u0cde9zMRwmkHbiw8sBufoMWGAqsE217HouA+reza9iaasFH5vOg8WBivCc5MNtKH
         JTyg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1dqhnM7pBfKjm5p7GIRcQ7H+K4YqdH2aH7mg5nAC+MNB84UYuUXJ8DXx/b4vWJMfg4O0vG4xp9Q01pA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdgOsn64Fu9bw+dv/E36hbcsNZ8AUBDt17Py3zV0E6oO4dxjbL
	RFYdc8fegyeOGL4PwzR1IYzAAXr9PolkIwmqH+VvTL0enr+flLCUbvX1PbRTZorhvTrOLP6mRrP
	sw+CLkKTZMsF1WhD/iDRv8rP+ugwYLsmFgfBhO6ppb+wQZe9rv7M48tkgvcA=
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f024:b0:6af:f3a3:7f5d with SMTP id
 006d021491bc7-6aff3a486f6mr4081860eaf.26.1786060892556; Thu, 06 Aug 2026
 17:01:32 -0700 (PDT)
Date: Thu, 06 Aug 2026 17:01:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a75205c.01d0871a.3a0d52.0032.GAE@google.com>
Subject: [syzbot] [fbdev?] KASAN: global-out-of-bounds Read in soft_cursor (3)
From: syzbot <syzbot+61b1db46218109869c14@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, simona@ffwll.ch, 
	syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2a9495bd873 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=123f2986580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4a42e870a0b0ae0
dashboard link: https://syzkaller.appspot.com/bug?extid=61b1db46218109869c14
compiler:       Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03cd82d06e64/disk-c2a9495b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bef502845f71/vmlinux-c2a9495b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e14ed9394125/Image-c2a9495b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61b1db46218109869c14@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
Read of size 16 at addr ffff800086c57970 by task syz.7.609/8216

CPU: 0 UID: 0 PID: 8216 Comm: syz.7.609 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_address_description+0xb0/0x238 mm/kasan/report.c:378
 print_report+0x68/0x84 mm/kasan/report.c:482
 kasan_report+0x8c/0xc4 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x17c/0x1ac mm/kasan/generic.c:200
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 soft_cursor+0x378/0x6bc drivers/video/fbdev/core/softcursor.c:70
 bit_cursor+0xa90/0x1108 drivers/video/fbdev/core/bitblit.c:365
 fbcon_cursor+0x344/0x498 drivers/video/fbdev/core/fbcon.c:1427
 hide_cursor+0xdc/0x2d0 drivers/tty/vt/vt.c:883
 update_region+0x100/0x18c drivers/tty/vt/vt.c:669
 vcs_write+0x8ec/0xaf0 drivers/tty/vt/vc_screen.c:685
 do_loop_readv_writev+0x24c/0x3dc fs/read_write.c:-1
 vfs_writev+0x2c8/0x630 fs/read_write.c:1061
 do_writev+0x134/0x2a8 fs/read_write.c:1105
 __do_sys_writev fs/read_write.c:1173 [inline]
 __se_sys_writev fs/read_write.c:1170 [inline]
 __arm64_sys_writev+0x80/0x94 fs/read_write.c:1170
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594

The buggy address belongs to the variable:
 fontdata_8x16+0x1010/0x1480

The buggy address belongs to a vmalloc virtual mapping
The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x219857
flags: 0x5ffc00000002000(reserved|node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000002000 fffffdffc76615c8 fffffdffc76615c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff800086c57800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff800086c57880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff800086c57900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
                                                             ^
 ffff800086c57980: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
 ffff800086c57a00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
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
