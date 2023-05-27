Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E062C77B7C
	for <linux-fbdev@archiver.kernel.org>; Sat, 27 May 2023 07:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjE0HM3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 27 May 2023 03:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0HM2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 27 May 2023 03:12:28 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BFE125
        for <linux-fbdev@vger.kernel.org>; Sat, 27 May 2023 00:12:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-763da06540aso243713139f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 27 May 2023 00:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685171547; x=1687763547;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWchqKPMOFT8mRiLEkV3wc3x0GBD55yGdX9K71lIRkw=;
        b=VRoeqLNKM+F7BAQZfmyD3EmE28dQpsSN/JV8BCGSi6lksBsT7oo/rpglOwiyAWXp2d
         34s4aPwGySnliFx+SVBWOzSZDbKlktC/A0KnPInzEyfIEdxHWefKy8OKD2juU+Zuf5Lc
         R1qUEFATkIFp4ctI3JVuk5mWS/6JsuwG4kx4TQf1UA9bxW40SycR2bez1rrjUvmV+QQr
         Ftaljhw9lSl4x2n5SMHwp/3brld/OtXYjFZGospL3gdtZdZVwEww4TwwB55Wo4iSZGG6
         p9d+DCry9xLNwu1Ggor6Yqoy6urlqWN12OJSjwRr8+APUmzY2Jyez+2p6oow1qk9Ae6h
         JF3Q==
X-Gm-Message-State: AC+VfDyLIjc+AuLH3hh6UurskA0cUEjxa+CJyot6FjV8LKjvzj0kOXHU
        u2p4PnCWMyxe8k79J7bV2pcXWqcgCaD8Wb0MMWq4DFG2fDd4
X-Google-Smtp-Source: ACHHUZ7Wg0GoaGFLqVjam0CAEhpAfvM9z6pAC6uClMZwq8s913zIOamgSr4CALZtFSwpmusnQ0Q6BFHqJ14Smz2Mugk4ynCOsOG9
MIME-Version: 1.0
X-Received: by 2002:a92:de02:0:b0:328:fb47:ede4 with SMTP id
 x2-20020a92de02000000b00328fb47ede4mr756567ilm.3.1685171547077; Sat, 27 May
 2023 00:12:27 -0700 (PDT)
Date:   Sat, 27 May 2023 00:12:27 -0700
In-Reply-To: <77f5c7f1-83fc-514c-14b9-453311b01188@gmx.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073034505fca7936b@google.com>
Subject: Re: [syzbot] [fbdev?] general protection fault in soft_cursor
From:   syzbot <syzbot+d910bd780e6efac35869@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d910bd780e6efac35869@syzkaller.appspotmail.com

Tested on:

commit:         9ee79acc fbcon: Prevent softcursor if no font set
git tree:       https://github.com/hdeller/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=136dee6d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8860074b9a9d6c45
dashboard link: https://syzkaller.appspot.com/bug?extid=d910bd780e6efac35869
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
