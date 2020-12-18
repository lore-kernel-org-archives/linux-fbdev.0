Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF79C4361B
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Dec 2020 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6239F23B53
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Dec 2020 15:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgLRP0p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Dec 2020 10:26:45 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50986 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgLRP0o (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Dec 2020 10:26:44 -0500
Received: by mail-io1-f70.google.com with SMTP id l5so2007791ioj.17
        for <linux-fbdev@vger.kernel.org>; Fri, 18 Dec 2020 07:26:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sk5wsene1nN0m/ZwzAMFtPnzrH/E8P/WHO8ceDjivzI=;
        b=LaXwW7n224FzPSz2l9NhTmF3UUawwsn4y/6yJo/J+3BjFV/G5UOXVe8IMOM8sNp0yB
         1wQaxaEwihocmdQ9k3VcyMoP9n3GvpNJS22k6zVZSS3GZka5y6ZX9U1uK6m2mCV6RUFf
         rsRzj8C90IRHBqPvycA2fsjpHlgamEAWlbdNgTxXSwz78kEDPfA1Uh9kYzEQCQr41X76
         TvEeFyeJC7cKTMXobQV1/iPtiWA+gbIgX05ipE1pDzphpsR2dabNrhxN6Um4fk/9izHv
         d67fIhNs/siHKkZmGgpon0ygpc3dlQyE6YhqZ8WMSTzhoPguBSutWqL/Li+yaX2zaXu3
         EnYA==
X-Gm-Message-State: AOAM530thPY+1lPtyTi06LDv30K+NQwVMpyG0asNSDWYrB64eXxcqeRY
        lDVyFnTrThHTMyJKLzyXQxCeCdYlh5LfJq/kcVKtv2MWIdVq
X-Google-Smtp-Source: ABdhPJzuvrPtRbQYMrW7TokBn0kIwTaf/V843TfLKQjba/B7jwxt5ruzQvW2+psjnlXsskbIbwR8PyAsQ+KrYXz+osh7v24vwsOS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:: with SMTP id i15mr4326230ilu.104.1608305163890;
 Fri, 18 Dec 2020 07:26:03 -0800 (PST)
Date:   Fri, 18 Dec 2020 07:26:03 -0800
In-Reply-To: <000000000000b30cad05b0fc3d74@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbf57305b6beb939@google.com>
Subject: Re: BUG: unable to handle kernel paging request in cfb_imageblit
From:   syzbot <syzbot+dfd0b1c6705301cc4847@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dan.carpenter@oracle.com,
        dri-devel@lists.freedesktop.org, george.kennedy@oracle.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit a49145acfb975d921464b84fe00279f99827d816
Author: George Kennedy <george.kennedy@oracle.com>
Date:   Tue Jul 7 19:26:03 2020 +0000

    fbmem: add margin check to fb_check_caps()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1149f30f500000
start commit:   22fbc037 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e672827d2ffab1f
dashboard link: https://syzkaller.appspot.com/bug?extid=dfd0b1c6705301cc4847
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ba9a5d900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cfd4af900000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fbmem: add margin check to fb_check_caps()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
