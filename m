Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBD4C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 17 Jan 2021 11:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BCA20759
	for <linux-fbdev@archiver.kernel.org>; Sun, 17 Jan 2021 11:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbhAQLaH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 17 Jan 2021 06:30:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40965 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbhAQL3r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 17 Jan 2021 06:29:47 -0500
Received: by mail-io1-f70.google.com with SMTP id x189so5714616iof.8
        for <linux-fbdev@vger.kernel.org>; Sun, 17 Jan 2021 03:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=P/d1FEPC5iUSKICunGAq3DjPk63uAX3l81ePhtYb8N0=;
        b=OXhf9muSctigHFtOZhppIuG0k/YCp1rS65fY3IfqzdOvAY+fMmWlVrbCUYhSw4sykR
         ZEkdxRRJTQboR3+VhWdcEL401nVNzVZLrLgx/gtpiD9u4LTy7//1EaV4SL8q2OPEQtCa
         ekj9OlwsxI9z6SGH6lCN8ybo09qI0bgr7ztcykqDDnTyKBqElSmV1AKhD3RAeX3EGBXC
         NVkyda77Alzr0IXsYF3xe9OTaPp4BgZkcz6PgBzpmscDxvz41w/iX/acOSf+hQrlLnlZ
         CWla0N7CduejiJbR82N3FVB72HaV+gsfDiT+pwT4RbJAAxL5+zeSq5crStigKMFauJX+
         o3qw==
X-Gm-Message-State: AOAM532bFMpUmaKhzF8UvYUhN87I1TM8SfyNVIXMi+SZ13P4k7l5xPSU
        eQzqIlN3BLx9YUdsM2zjEqJXTS7w9ENl8bFFofEx9rwzFVVR
X-Google-Smtp-Source: ABdhPJx5wlmIgilxar3mPnrNpenLIHXRB8QsmmaXtwL5co5ZgqUuD4L6Odq9Is16TpVeRpNjHvh4NXgVuwKnnAtq+1m2JAFvsRlf
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:411:: with SMTP id p17mr8267172ilr.33.1610882945873;
 Sun, 17 Jan 2021 03:29:05 -0800 (PST)
Date:   Sun, 17 Jan 2021 03:29:05 -0800
In-Reply-To: <00000000000091111005b435456e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c37b3a05b916e95a@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in fbcon_cursor
From:   syzbot <syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        daniel.vetter@intel.com, dri-devel@lists.freedesktop.org,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, melissa.srw@gmail.com,
        natechancellor@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de,
        yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has bisected this issue to:

commit ea40d7857d5250e5400f38c69ef9e17321e9c4a2
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Fri Oct 9 23:21:56 2020 +0000

    drm/vkms: fbdev emulation support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e2748d00000
start commit:   b3a3cbde Add linux-next specific files for 20210115
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168e2748d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=128e2748d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6ea08dae6aab586f
dashboard link: https://syzkaller.appspot.com/bug?extid=b67aaae8d3a927f68d20
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15cd8fe0d00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17af5258d00000

Reported-by: syzbot+b67aaae8d3a927f68d20@syzkaller.appspotmail.com
Fixes: ea40d7857d52 ("drm/vkms: fbdev emulation support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
