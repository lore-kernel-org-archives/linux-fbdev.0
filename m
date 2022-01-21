Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11F5C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jan 2022 01:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiAUBsH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 Jan 2022 20:48:07 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:41553 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348338AbiAUBsG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 Jan 2022 20:48:06 -0500
Received: by mail-il1-f198.google.com with SMTP id g2-20020a056e020d0200b002b979ebc1daso2524612ilj.8
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Jan 2022 17:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DanrII7rs7VHR9x2Ad6ztSAzc5bhObpiObDh8wKC9WU=;
        b=ULsNc16z/2qM62W5eJEiL0j94a4eUyjzj3ehTrZ+DC2uupO7LlVHYZPdX4NLCxGDvi
         c3L3XO0MRJFgrB2ts4s8eLeQzKCBHO48Kl75AqjExICGi9bQ6cxnJJJ8o4IVPilGkUXZ
         5X3l468ZVd27w3r3i1zlZmeTHPwqvthj39R8c4DvLb+z2dSky01JMzteQl6aRKl6j0OU
         Tba8bWjmd76jnJQR7sDX7w03lHAgpt4yKg1j0WgMh7LCi/nH0hI8qEgRsv4QA/ly4zqi
         I4lCgTrtpIFRnc020GIar3KIoFfOp0p/QJUnHIDLR/fGDern1Sddp/Cdu0YqzomVSKZ2
         3swA==
X-Gm-Message-State: AOAM531Gxblh1QdqOtuDwih0zXQRpsaYiPCrlzDuKyxRj1Nrx89cNcB+
        OzWWO0g9eA9PEqoNzBkgPklGIsY/IR1YTCHZ03NIsIckx2Z5
X-Google-Smtp-Source: ABdhPJwo+j/up45k23KzgrwwJOdQRYqe4wZFCj5sSOh1hefXEP0mn76QeYRFAhQgeYfh1ABeRjuYCNLoAcbb47n7Nx1OAC7WHPRo
MIME-Version: 1.0
X-Received: by 2002:a02:2207:: with SMTP id o7mr751312jao.99.1642729686278;
 Thu, 20 Jan 2022 17:48:06 -0800 (PST)
Date:   Thu, 20 Jan 2022 17:48:06 -0800
In-Reply-To: <000000000000bbdd0405d120c155@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069ab4805d60dcf4c@google.com>
Subject: Re: [syzbot] KASAN: vmalloc-out-of-bounds Write in imageblit (2)
From:   syzbot <syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com>
To:     bugs-a21@moonlit-rail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has bisected this issue to:

commit 0499f419b76f94ede08304aad5851144813ac55c
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Mon Jan 10 09:56:25 2022 +0000

    video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c71e37b00000
start commit:   7fc5253f5a13 Add linux-next specific files for 20220120
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16c71e37b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12c71e37b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94e8da4df9ab6319
dashboard link: https://syzkaller.appspot.com/bug?extid=14b0e8f3fd1612e35350
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155dde3db00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125298e0700000

Reported-by: syzbot+14b0e8f3fd1612e35350@syzkaller.appspotmail.com
Fixes: 0499f419b76f ("video: vga16fb: Only probe for EGA and VGA 16 color graphic cards")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
