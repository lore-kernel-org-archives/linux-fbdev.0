Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A5AC433B4
	for <linux-fbdev@archiver.kernel.org>; Sun,  2 May 2021 01:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AD561446
	for <linux-fbdev@archiver.kernel.org>; Sun,  2 May 2021 01:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhEBByB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 1 May 2021 21:54:01 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38829 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEBByB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 1 May 2021 21:54:01 -0400
Received: by mail-io1-f69.google.com with SMTP id v1-20020a5d94810000b02903e0f4d732b4so1109501ioj.5
        for <linux-fbdev@vger.kernel.org>; Sat, 01 May 2021 18:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OaqvyMlXg8wGXZRGMIboAMoucZyr0AtXUbwHcvsJTxQ=;
        b=l24FoaAIc8AqtIcsxockSdBfRe8beGOWq5rQeS61zPbXr47NLVI0iD7qHRC2JVCuUH
         DsDdfiZWaHlF5IMWOF8l2DXyGJzru3dRG+NToGkPgZuNtI612IV8i34TR9xZjkv1alUO
         1HtFpmkKwgRNOd8tHw0fIiuBlMwmdQblee4Z8QTgm4bcpuRjIiQNXmWHJS1dO9LSWyMr
         ppTal9/LbgtDa+n4J8hF/AiLW4Kay/FGGrHCZY/sgnzJfQ7NBwUxhp+WxvCX52ziSmv4
         tnKIBPi0laK7a1ORBb+OgqNWBDg6OiBr3lxla2wahmETVBBkbxVDKZoP/b3gNQPw5qdm
         yU7g==
X-Gm-Message-State: AOAM532w5GnyawoRxUJUkffnuFmkTiMxaU4mY0CXci0wvSq8QkLZ/7vZ
        xGh9v5uu0XZfoeCGPvj9KTF6l43qZONHkVuPPSkatY6eH6fB
X-Google-Smtp-Source: ABdhPJzrDS4BZ0APncrMikVvdmVtL8AzN4r8IHRznwTpDU6fklt7kjPqWFHr3kUlkvmZAB5ysDk/ZrgPlZh+HISi5V3Ywm/O/0co
MIME-Version: 1.0
X-Received: by 2002:a6b:7413:: with SMTP id s19mr9056934iog.151.1619920390173;
 Sat, 01 May 2021 18:53:10 -0700 (PDT)
Date:   Sat, 01 May 2021 18:53:10 -0700
In-Reply-To: <00000000000086452c05a51da504@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bbd0c05c14f1b09@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 vga16fb_imageblit (2)
From:   syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, colin.king@canonical.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, jani.nikula@intel.com,
        jirislaby@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has bisected this issue to:

commit 988d0763361bb65690d60e2bc53a6b72777040c3
Author: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Date:   Sun Sep 27 11:46:30 2020 +0000

    vt_ioctl: make VT_RESIZEX behave like VT_RESIZE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15633759d00000
start commit:   d2b6f8a1 Merge tag 'xfs-5.13-merge-3' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17633759d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13633759d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=53fdf14defd48c56
dashboard link: https://syzkaller.appspot.com/bug?extid=1f29e126cf461c4de3b3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d9ff43d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10981693d00000

Reported-by: syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com
Fixes: 988d0763361b ("vt_ioctl: make VT_RESIZEX behave like VT_RESIZE")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
