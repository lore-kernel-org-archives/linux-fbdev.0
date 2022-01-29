Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A93C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat, 29 Jan 2022 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiA2OHK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 29 Jan 2022 09:07:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:55944 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiA2OHK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 29 Jan 2022 09:07:10 -0500
Received: by mail-io1-f71.google.com with SMTP id y23-20020a5e8717000000b0060fd92726cbso6436773ioj.22
        for <linux-fbdev@vger.kernel.org>; Sat, 29 Jan 2022 06:07:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0yID9FBNEnlHIDDPVExH7+jnkGuixmiFgWV9iVk8uAw=;
        b=sVW9pKBXjFouf7t5de3qpgTYITO91nStNvAYfg3sPlVI1Fk2rd2vPNWpDkIkIyxj2B
         B0csDbFAMtb66G7UVU7tk7UwXA34lWrcTW5Q8eL5RvypMLlwQ7UwZmVhMkH1VInFgX/3
         e/4mR3TaLu1gUcrUa8bWGPplu1jAX9GOiwfeicr79/sKDNtOFl+pER+aVQKfzIrL5XMC
         ovqDYD5gig8sc45IA3Y4hnd7nhQr0/qxGBZmeMMJrUFPoldlhfKzCA/IqGtocmc7NBp4
         6QgktwBCOoOsNxY+Y7shpa7UEwFfvx9a6G4KZC/HxN2ikswGHjc/OKQuiG5kHIj33Nnz
         9IGw==
X-Gm-Message-State: AOAM533WGpkUHlA7fhV8PgzC3DzPoQ6WVG0P5DHbEsEbrHb93yU+fPlP
        LRj9AheIKBHA9SUefXuMAY1mpnukzTqHlL7Ca2gczEsLFz0F
X-Google-Smtp-Source: ABdhPJys2smNcd54wqnufpsY+9aFghoE3qs6+teGCIqgvZBHcvUKkSP+xokUF3PxNaUW5iPcGnSHcmzTLIMObGaNGwv6yrAlWEs8
MIME-Version: 1.0
X-Received: by 2002:a6b:3b8a:: with SMTP id i132mr7981765ioa.85.1643465229580;
 Sat, 29 Jan 2022 06:07:09 -0800 (PST)
Date:   Sat, 29 Jan 2022 06:07:09 -0800
In-Reply-To: <000000000000ab6df705b453993a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035befb05d6b91185@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 bitfill_aligned (2)
From:   syzbot <syzbot+a4edd73d589b0b7efbeb@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, bugs-a21@moonlit-rail.com,
        dri-devel@lists.freedesktop.org, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, ngraniel@cocobongo.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 0499f419b76f94ede08304aad5851144813ac55c
Author: Javier Martinez Canillas <javierm@redhat.com>
Date:   Mon Jan 10 09:56:25 2022 +0000

    video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1752f5c0700000
start commit:   2a987e65025e Merge tag 'perf-tools-fixes-for-v5.16-2021-12..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d5e878e3399b6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=a4edd73d589b0b7efbeb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16671badb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122beabdb00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: video: vga16fb: Only probe for EGA and VGA 16 color graphic cards

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
