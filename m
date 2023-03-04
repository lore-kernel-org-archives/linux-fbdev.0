Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B84C678D5
	for <linux-fbdev@archiver.kernel.org>; Sat,  4 Mar 2023 04:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCDEgS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 3 Mar 2023 23:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCDEgR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 3 Mar 2023 23:36:17 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB91ABDE
        for <linux-fbdev@vger.kernel.org>; Fri,  3 Mar 2023 20:36:16 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id t16-20020a92c0d0000000b00319bb6f4282so2342168ilf.20
        for <linux-fbdev@vger.kernel.org>; Fri, 03 Mar 2023 20:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBM8f3nfkQPiCUxCkC/1jIKN/CSWO63Mv0FZdwLHa7w=;
        b=BJ15FhQ5IdjTCSyZTtJzPrmDUi9QOvkbdlkkhy+DclGNFUAxl4PHdp+XsRGX+2iPuo
         ZDn/NAlwpBw0DvHi3AeALrTIToAZGnGpGUBG1vJxeaSXBUYW9bp/VvHdaHL9D0gzHd78
         yiVITcHXPeCyuIwO/M1kPYppWG77xxgmGVDEoCT/7sQkJyhSJYhentf5qcKUvrlaY34D
         gSPRksL1oAJOhPQ4GQA3kLYKjD1bRe9Xtj66UjY2W7Ds//6FPcpzsPMeDqOOTLwySSI2
         0b+/jejPKMlGcO8++XGoY3lvdEJVuU5guZewIUVJn4VDjpmMXtlLC8mBzq50Gb/7TRDP
         CSxw==
X-Gm-Message-State: AO0yUKWqyyWImTJZA8R8f34h3jkXA2KcnfFrl+InGDaqDEHaoErnDJhk
        ySwtDeYFf/KIqvcRfxRGXoHh/BHcn6dVzfnkC5TJVrPm9sK9
X-Google-Smtp-Source: AK7set9ivc7a0hTa59+MlzQADnVR9rVesqaUQ/nvWX6Tgg9CYI6nEEqLldZZLLoEwGD8VgHEij9xXEv9mpDaSxPxdEDomAm6DdMV
MIME-Version: 1.0
X-Received: by 2002:a02:94cd:0:b0:3e1:fb3d:4dce with SMTP id
 x71-20020a0294cd000000b003e1fb3d4dcemr1851215jah.0.1677904576128; Fri, 03 Mar
 2023 20:36:16 -0800 (PST)
Date:   Fri, 03 Mar 2023 20:36:16 -0800
In-Reply-To: <0000000000001d1fb505f605c295@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a2e5e05f60b9aff@google.com>
Subject: Re: [syzbot] [hardening?] [mm?] BUG: bad usercopy in con_font_op
From:   syzbot <syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, daniel@ffwll.ch, deller@gmx.de,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, keescook@chromium.org,
        linux-fbdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        samuel.thibault@ens-lyon.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

syzbot has bisected this issue to:

commit 24d69384bcd34b9dcaf5dab744bf7096e84d1abd
Author: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date:   Thu Jan 19 15:19:16 2023 +0000

    VT: Add KD_FONT_OP_SET/GET_TALL operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120b3232c80000
start commit:   2eb29d59ddf0 Merge tag 'drm-next-2023-03-03-1' of git://an..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110b3232c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=160b3232c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=3af17071816b61e807ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b71504c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f02d9cc80000

Reported-by: syzbot+3af17071816b61e807ed@syzkaller.appspotmail.com
Fixes: 24d69384bcd3 ("VT: Add KD_FONT_OP_SET/GET_TALL operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
