Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693127;
	b=qHi56ct4K2SuihiyXXyCmqfHaTpSt/97ZZ3hYR8l+88wPr+CBRlyLn7k4wt1rIzr4ayV
	 Z+2Fan7Q6+/W+f8QuXWZqTaWr9oMpObXj49dUp6wY9QQ/5K+te2Xz3AWJ2vIfLY0ubv1A
	 zuBNoIJ9j0KI5ywt320Rjx8+x0Hm0wyyhfuuBGCoSJ+fI+MpgFjNg0LuSgVLJsx8Pmpal
	 1hpP47C8cn89AWsIeRnVoQUK7NDd32RrkclPSaBghpLGehJythnIoWnwUJgmgT29mEhWF
	 DAP/7JQECG+5STfjSHqn2GpBWjycxq4+lM5OoD+pLjF/gi7r9jQbEWlRWEElhgYi73g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693127;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=gTw7XRRIfHVYQyqbfXSyx0Prw2PsL3DVtgnGhtx9nTo=;
	b=2PEyk4pzNdvJvwChxdky3r1dsln9LTa0LBMDxQPWmLebisZv4TMeLlEMSNBAhb+RCGET
	 d3J6GALt+pIZsPSQ71tPfnGJBSSZB/tnMnkPLmXv/yVpJH5YPz6a6dECQzZ+95aYQEiOE
	 yHIwSoy2a/Ayxq/hszlYiSK6M5GwDhAhE27o48nazVIFs23XBYfcn3RGIBtK0XrFSTXDG
	 wxByz8CF0o41pL+hE5QYCvC9h41el98ctwFROlm57CVI5u5XYBQreqe0MUdZvvys3VheE
	 wUQCB3uXJrPyUU4ce32SJdpdQYzjxkBWafMfXn5OLMLol4o7hWYqCtHt9uBnScR62xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440D606A329
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 08:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7440D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-5641cd2cc13so4205769b6e.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Nov 2026 00:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693126; x=1794297926;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gTw7XRRIfHVYQyqbfXSyx0Prw2PsL3DVtgnGhtx9nTo=;
        b=kWwarmHTJoyrrA0dyU+eCHTY8KN9Cqmu8PQb1ZTuh0h4jDXdQ0k2+hZXGlJCny5pTu
         w0iGT2dwdhqd+5iHsP9fEEvE4m/EMHwEF+gNqDMac4Ye7gX4IbdXwfZrenYwpmkbeJgY
         reopI1ehRGS4ig426VHcJL/XqeFIQKE1qsrGMOLMQedKnDdSiQwqdOd2WNtDF/1VwwIq
         H58DGSU0/sK0mh3JHTbx1AoV/WzNb9FfYGbXvja+g0fj/Ib4RTUzAhYTwZ0GD9dAMueO
         Vs4dB0RHSYDf0qwdPTPhOg4kOOQeufTDeckRUhJDuwUHqu6xg9+9PFyKeS0iRdZJ9yUr
         KznA==
X-Forwarded-Encrypted: i=1; AKwUvBwjMlHyGfbylzTV9P6d56epY2o6ZW3HuSQMb+isTh6ZjkLT86bAvDi5IatbbsmYJcI4jQkwMBOiIGm2jg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/DR0ch2Q3bvFCTx5ehMxkKsLmqi7HlCLLenuLBWDqewJQuz2h6
	rLgBQU0WyU1SxmNJdLII5hTcr0jeFhChLSxWnXWY24PxYaiRcdWQ42N3I+H0u5BFDFuo7cI2iYB
	h86FJDv8ZN5O+KFhxnVhvXPIdjvMnJzsz6crF7MNO/wm9sbORe+sKdC/wjVQ=
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:124a:b0:4e7:8f9b:1185 with SMTP id
 5614622812f47-5640d92c7ffmr7321913b6e.3.1793693126459; Tue, 03 Nov 2026
 00:05:26 -0800 (PST)
Date: Tue, 03 Nov 2026 00:05:26 -0800
In-Reply-To: <6836d5d8.a70a0220.253bc2.00c5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae995c6.24f6a368.35686f.0de8.GAE@google.com>
Subject: Re: [syzbot] [fbdev?] KASAN: vmalloc-out-of-bounds Write in fillrect
From: syzbot <syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com>
To: deller@gmx.de, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	osama.abdelkader@gmail.com, simona@ffwll.ch, soci@c64.rulez.org, 
	syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6628e7d4c6b2 Linux 7.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14484581580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2c97eac7d33533
dashboard link: https://syzkaller.appspot.com/bug?extid=7a63ce155648954e749b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126c692d580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f1d59580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6628e7d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f9e962fc6ac/vmlinux-6628e7d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/192b99738db6/bzImage-6628e7d4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7a63ce155648954e749b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
BUG: KASAN: vmalloc-out-of-bounds in bitfill drivers/video/fbdev/core/fb_fillrect.h:133 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:219 [inline]
BUG: KASAN: vmalloc-out-of-bounds in fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:278 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_fillrect+0x174a/0x1910 drivers/video/fbdev/core/sysfillrect.c:24
Write of size 8 at addr ffffc900056fd000 by task syz.0.17/5992

CPU: 3 UID: 0 PID: 5992 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 fb_write_offset drivers/video/fbdev/core/sysmem.h:30 [inline]
 bitfill drivers/video/fbdev/core/fb_fillrect.h:133 [inline]
 fb_fillrect_static drivers/video/fbdev/core/fb_fillrect.h:219 [inline]
 fb_fillrect drivers/video/fbdev/core/fb_fillrect.h:278 [inline]
 sys_fillrect+0x174a/0x1910 drivers/video/fbdev/core/sysfillrect.c:24
 drm_fbdev_shmem_defio_fillrect+0x22/0x140 drivers/gpu/drm/drm_fbdev_shmem.c:39
 bit_clear+0x17d/0x220 drivers/video/fbdev/core/bitblit.c:73
 __fbcon_clear+0x633/0x760 drivers/video/fbdev/core/fbcon.c:1358
 fbcon_scroll+0x48b/0x650 drivers/video/fbdev/core/fbcon.c:1910
 con_scroll+0x464/0x690 drivers/tty/vt/vt.c:730
 csi_M drivers/tty/vt/vt.c:2307 [inline]
 csi_ECMA.constprop.0+0x1238/0x3b60 drivers/tty/vt/vt.c:2730
 do_con_trol drivers/tty/vt/vt.c:2945 [inline]
 do_con_write+0x366b/0x4ae0 drivers/tty/vt/vt.c:3442
 con_write+0x23/0xb0 drivers/tty/vt/vt.c:3778
 process_output_block drivers/tty/n_tty.c:557 [inline]
 n_tty_write+0x440/0x1200 drivers/tty/n_tty.c:2366
 iterate_tty_write drivers/tty/tty_io.c:1008 [inline]
 file_tty_write.isra.0+0x4ca/0x8f0 drivers/tty/tty_io.c:1056
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3a15b9fb19
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe1abca668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f3a15e25fa0 RCX: 00007f3a15b9fb19
RDX: 0000000000001006 RSI: 0000200000000680 RDI: 0000000000000006
RBP: 00007f3a15c37b70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3a15e25fac R14: 00007f3a15e25fa0 R15: 00007f3a15e25fa0
 </TASK>

The buggy address belongs to a vmalloc virtual mapping
Memory state around the buggy address:
 ffffc900056fcf00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900056fcf80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc900056fd000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                   ^
 ffffc900056fd080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc900056fd100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
