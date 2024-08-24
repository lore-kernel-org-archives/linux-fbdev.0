Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA994A05
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Aug 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724539099; cv=none; b=JbZVVyvyJxkeUenyyTr5YJq9b1SH5h5N+mLxGHbgigQNLcIJps1YZTS02HvM6EVuVFmbxyq+d7rSOdajS2lsaEWPg7j2c24DkNwc2ai7kI8ozVK7kvBCmfLCXhi+Qf/SZ5Sni31mekCtJ+zF402LHSCa7wX63+zieuaZWgCARow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724539099; c=relaxed/simple;
	bh=aku1BGyPnFkzwCBLHItvSnqqXATipQbCvNjkisu2eTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=N0OSw23SsMbzQWe7i7RhoTW8WHGJZR9wdeHi9vT9E7q+BB3rjnMWzgbJM6wL+X2P9lRoidEsCKXVs1kKoLhoTYZz0UlkZwgwwOqYXtLLsXgUEUhQdUWiZwi1d3sxqd5wVXhicZg/1GM2RvIo6AWHgrga4recTbHaHjctTtBpiEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=HLtJZ9V+; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Px+3M/0J; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="HLtJZ9V+";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Px+3M/0J"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724539099; x=1756075099;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=aku1BGyPnFkzwCBLHItvSnqqXATipQbCvNjkisu2eTA=;
  b=HLtJZ9V+Sgn/IuvLp3KYwrw9x1UOojxNewEP0t+rvJE5wgmDRvMfvln/
   m0apB/t42ErJi7kaatyZXA+pSV6I/zLbM/PRxhaAvMrc4dIFhqIlONxiB
   Z4o2lOhfVuiUI6I6fheNX/+jg/EA0mkNzfCMEttfW0N4ydIO1wrIKpLtg
   MNsdiohpwxmqJkBnN4rBbVZJr8gitJzviiVQgmcyBDyk18kF2otQHVqUC
   mxKl89LhSvvvFYfxNICfxCrO8K+m0jnmWWaxJi4q8aThxilCSRbMxzZM1
   5Ka5iEGR0gaCrGnW5+muNGgqbozNiVBNueToySOHK0SknyjJZrMnrtJIV
   A==;
X-CSE-ConnectionGUID: AwRwe4thTbWjdpz8y6l0fw==
X-CSE-MsgGUID: 1UeO17N0RoSsVeyqRQXFFw==
Received: from mail-io1-f71.google.com ([209.85.166.71])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 15:38:17 -0700
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8223c3509a9so340994039f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Aug 2024 15:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724539096; x=1725143896; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XsiAD2fFCNgCPGwb7KVHK4effqndVE8zSBZgK6lYH2s=;
        b=Px+3M/0J1UVYnkiTmiE6JRGohQf2x34/boElLyByzOzVAYS1cSOlzKnwmCn09PHjPR
         LwWmcl1r1uh9OpaBOP5icsmaQgoXMPYxKbRHzpJxXmeGJWgPOBBkYqpIrC9I8mI+uhaa
         bPNb/gAq8cxHmltmAUJ4pbYxTuMnwqWGZ84xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724539096; x=1725143896;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XsiAD2fFCNgCPGwb7KVHK4effqndVE8zSBZgK6lYH2s=;
        b=NxjFa3sb7f718Glk3viRuTC9d/PY2JVMqwQcUDFQuXK4T/mGniyOsudED52WfcbQem
         aSoZGmVzMIgZgB7Mt6NdMe+LyjXuf1mYZDY6VvOr6DbJ04/5saGlQgdNkQED71eNHY9J
         Sev0I8hdRizPzOF/HalBeh5arpoOk4MuqnGPCODCu/oiPX1LF4lsqsUuBSSc7L69vwpG
         Cdd/2CiEcIFtIxLIDSvck+1SITjyLllpCT0z0tqNEuvgi29SQv7/tfSqYAEnhb/fWCC7
         Js2GlS3wRiS9g5Sa0zsHnyDRN4WgUFxZhW7mxO9mmaT3+hiftXxurf3B7ES13j/pYY9f
         FBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHHyh/NXrGo9da0YZJptbv6LwJBhgNsWvkochLZDK5cxO6Zscnhg6tjeUFrB36ieXBoPwLhEh7g0oWPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzN0O/yddtEO8Gr6XLuhdj6gldKylFO8ocwpig3uEU8B4bUGX1
	lJg/A6cpvGqFtkixnkCZLB/tnGDv37ctLVTM9skoRqkw1jfCM458akJHBTe89cMIHahVrwCebeH
	VItnehfg3fXS49NBWP/E4rZnMj8a9FNESnvOFPBnoQ0+pgBtWgpp90vnvhNPQDqvKDupoUATxlU
	Hd6o7b4J9zXzGAUKBKjXHTTNpaJl0BO3M1gBRE
X-Received: by 2002:a05:6602:2c87:b0:824:d7b5:45e with SMTP id ca18e2360f4ac-82787323b43mr745863439f.3.1724539095703;
        Sat, 24 Aug 2024 15:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGxRcU/vOsaC2nI2v7TINLpWQIGNtj/+p/YES/rNZzZJPEnEirmzlZsGv/ueCxgr72bCGOAQ0rFCWZfuydb2g=
X-Received: by 2002:a05:6602:2c87:b0:824:d7b5:45e with SMTP id
 ca18e2360f4ac-82787323b43mr745861939f.3.1724539095334; Sat, 24 Aug 2024
 15:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 15:38:03 -0700
Message-ID: <CANikGpcJF23qVPYMkjFG084kTP8oo4-9Jkp=JFO+SxB3BMJuKQ@mail.gmail.com>
Subject: BUG: KASAN: vmalloc-out-of-bounds Write in imageblit
To: daniel@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `fast_imageblit`, there is an out-of-bounds memory access when
executing `*dst++ = colortab[(*src >> 7) & bit_mask];`

Although Syzbot has found a similar bug
(https://syzkaller.appspot.com/bug?extid=3d3864c27a5e770e7654), the
bug we discovered can be triggered on Linux v6.10. Meanwhile, Syzbot
failed to trigger the crash for 396 days. Thus, it looks like this is
a new bug.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in fast_imageblit
drivers/video/fbdev/core/sysimgblt.c:257 [inline]
BUG: KASAN: vmalloc-out-of-bounds in sys_imageblit+0x1c22/0x2600
drivers/video/fbdev/core/sysimgblt.c:326
Write of size 4 at addr ffffc90002ad9190 by task syz.0.802/17876

CPU: 0 PID: 17876 Comm: syz.0.802 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 print_address_description+0x77/0x360 mm/kasan/report.c:377
 print_report+0xfd/0x210 mm/kasan/report.c:488
 kasan_report+0x13f/0x170 mm/kasan/report.c:601
 fast_imageblit drivers/video/fbdev/core/sysimgblt.c:257 [inline]
 sys_imageblit+0x1c22/0x2600 drivers/video/fbdev/core/sysimgblt.c:326
 drm_fbdev_generic_defio_imageblit+0x2a/0xf0
drivers/gpu/drm/drm_fbdev_generic.c:37
 bit_putcs+0x18a3/0x1d90
 fbcon_putcs+0x34f/0x520 drivers/video/fbdev/core/fbcon.c:1288
 con_putc drivers/tty/vt/vt.c:302 [inline]
 complement_pos+0x3f4/0xa70 drivers/tty/vt/vt.c:757
 highlight_pointer drivers/tty/vt/selection.c:63 [inline]
 clear_selection+0x17/0x70 drivers/tty/vt/selection.c:85
 hide_cursor+0x80/0x480 drivers/tty/vt/vt.c:844
 redraw_screen+0x1d7/0xe70 drivers/tty/vt/vt.c:948
 fbcon_blank+0x61f/0xae0 drivers/video/fbdev/core/fbcon.c:2231
 do_unblank_screen+0x294/0x760 drivers/tty/vt/vt.c:4563
 unblank_screen drivers/tty/vt/vt.c:4582 [inline]
 tioclinux+0x186/0x4c0 drivers/tty/vt/vt.c:3357
 vt_ioctl+0x9d4/0x2060 drivers/tty/vt/vt_ioctl.c:761
 tty_ioctl+0x906/0xdb0 drivers/tty/tty_io.c:2803
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f77eff809b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f77f0e57038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f77f0145f80 RCX: 00007f77eff809b9
RDX: 0000000020000580 RSI: 000000000000541c RDI: 0000000000000018
RBP: 00007f77efff4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f77f0145f80 R15: 00007ffd3ddd4628
 </TASK>

Memory state around the buggy address:
 ffffc90002ad9080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002ad9100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90002ad9180: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                         ^
 ffffc90002ad9200: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90002ad9280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================
