Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA4C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Sep 2021 12:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8610E60231
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Sep 2021 12:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhIPMhm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:37:42 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:46839 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbhIPMhl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Sep 2021 08:37:41 -0400
Received: by mail-io1-f69.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so10554931ioo.13
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Sep 2021 05:36:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=QPHEIdxU7DQNimsTFhfi84oUywJMvtus7syU0lNoVtM=;
        b=wUnvCtbqy6GOM0n2YxAwzbEJnd5P0lN3Tzum+WeZiSxlyHFDPObXnA6f+zOZupbB0s
         Cx+Sw9/5hVViYz3suV2Zzck0fzN5nhPWO9ATqt/3XakZqM380CxGDmr/n/kzhYHfeWDJ
         ldGfDRt7fNB3d2IygN/4VLhSwNjW6eFm9Qu+HYgAP2gq7OBlRi70w2oQAw0i7U1pC1w9
         Wm2pGYShd4T6cOVPAgddqCzYsdSQnL4n3BFcDemJaMYpSNXpEgB7xME/RMI4T5WTZQ47
         eN0/NxvPkUtIm+FpWbapVdNf8kDVTAlKAs4obI049z9M6P0pmQOdvL1Cd3A8ymWcRu72
         VVMQ==
X-Gm-Message-State: AOAM531x9ViJkSj/TFfL/4FE3O/Ea6Lk/SHkS1lI7USAgjdD6owDJBW5
        WCYe3XlKVr4DY0zVyFAMqrW/rLyv/h4ushpK4XJhF53SzV/E
X-Google-Smtp-Source: ABdhPJyoi78sxYRFgsqNmZe4NnbBQthKjTf5W/BF8nJoc75jbfLhyUYulbLltLsOds7mscnDl5McGuqxPuK3OAZgkaremrCk5+8y
MIME-Version: 1.0
X-Received: by 2002:a6b:6918:: with SMTP id e24mr4136362ioc.71.1631795781178;
 Thu, 16 Sep 2021 05:36:21 -0700 (PDT)
Date:   Thu, 16 Sep 2021 05:36:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e217b005cc1c0fcb@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in cfb_imageblit (2)
From:   syzbot <syzbot+219cc51510158a7d8290@syzkaller.appspotmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    78e709522d2c Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16029aed300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2150ebd7e72fa695
dashboard link: https://syzkaller.appspot.com/bug?extid=219cc51510158a7d8290
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+219cc51510158a7d8290@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff88800010f038
#PF: supervisor write access in kernel mode
#PF: error_code(0x0003) - permissions violation
PGD 10801067 P4D 10801067 PUD 10802067 PMD 10803067 PTE 800000000010f161
Oops: 0003 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7973 Comm: kworker/0:4 Not tainted 5.14.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_power_efficient fb_flashcursor
RIP: 0010:__writel arch/x86/include/asm/io.h:71 [inline]
RIP: 0010:fast_imageblit drivers/video/fbdev/core/cfbimgblt.c:257 [inline]
RIP: 0010:cfb_imageblit+0x648/0x1240 drivers/video/fbdev/core/cfbimgblt.c:300
Code: 42 0f b6 0c 3a 48 89 c2 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 1f 0b 00 00 8b 7c 24 18 49 8d 5e 04 23 38 8b 44 24 10 31 f8 <41> 89 06 31 ff 44 89 e6 e8 ab 85 69 fd 45 85 e4 75 0f e8 61 7e 69
RSP: 0018:ffffc900171af970 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800010f03c RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff840c8e86 RDI: 0000000000000000
RBP: ffff8880180a5359 R08: 000000000000001f R09: ffffffff840c8d14
R10: ffffffff840c8e77 R11: 0000000000000008 R12: 0000000000000004
R13: 0000000000000001 R14: ffff88800010f038 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800010f038 CR3: 000000001e6a0000 CR4: 0000000000350ef0
Call Trace:
 vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1207 [inline]
 vga16fb_imageblit+0x681/0x2200 drivers/video/fbdev/vga16fb.c:1260
 soft_cursor+0x514/0xa30 drivers/video/fbdev/core/softcursor.c:74
 bit_cursor+0xd07/0x1740 drivers/video/fbdev/core/bitblit.c:377
 fb_flashcursor+0x38b/0x430 drivers/video/fbdev/core/fbcon.c:387
 process_one_work+0x9bf/0x16b0 kernel/workqueue.c:2297
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2444
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
CR2: ffff88800010f038
---[ end trace 3e2fb001e55b5406 ]---
RIP: 0010:__writel arch/x86/include/asm/io.h:71 [inline]
RIP: 0010:fast_imageblit drivers/video/fbdev/core/cfbimgblt.c:257 [inline]
RIP: 0010:cfb_imageblit+0x648/0x1240 drivers/video/fbdev/core/cfbimgblt.c:300
Code: 42 0f b6 0c 3a 48 89 c2 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 1f 0b 00 00 8b 7c 24 18 49 8d 5e 04 23 38 8b 44 24 10 31 f8 <41> 89 06 31 ff 44 89 e6 e8 ab 85 69 fd 45 85 e4 75 0f e8 61 7e 69
RSP: 0018:ffffc900171af970 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800010f03c RCX: 0000000000000000
RDX: 0000000000000003 RSI: ffffffff840c8e86 RDI: 0000000000000000
RBP: ffff8880180a5359 R08: 000000000000001f R09: ffffffff840c8d14
R10: ffffffff840c8e77 R11: 0000000000000008 R12: 0000000000000004
R13: 0000000000000001 R14: ffff88800010f038 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88800010f038 CR3: 000000001e6a0000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	42 0f b6 0c 3a       	movzbl (%rdx,%r15,1),%ecx
   5:	48 89 c2             	mov    %rax,%rdx
   8:	83 e2 07             	and    $0x7,%edx
   b:	83 c2 03             	add    $0x3,%edx
   e:	38 ca                	cmp    %cl,%dl
  10:	7c 08                	jl     0x1a
  12:	84 c9                	test   %cl,%cl
  14:	0f 85 1f 0b 00 00    	jne    0xb39
  1a:	8b 7c 24 18          	mov    0x18(%rsp),%edi
  1e:	49 8d 5e 04          	lea    0x4(%r14),%rbx
  22:	23 38                	and    (%rax),%edi
  24:	8b 44 24 10          	mov    0x10(%rsp),%eax
  28:	31 f8                	xor    %edi,%eax
* 2a:	41 89 06             	mov    %eax,(%r14) <-- trapping instruction
  2d:	31 ff                	xor    %edi,%edi
  2f:	44 89 e6             	mov    %r12d,%esi
  32:	e8 ab 85 69 fd       	callq  0xfd6985e2
  37:	45 85 e4             	test   %r12d,%r12d
  3a:	75 0f                	jne    0x4b
  3c:	e8                   	.byte 0xe8
  3d:	61                   	(bad)
  3e:	7e 69                	jle    0xa9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
